#!/usr/bin/env bash

# https://medium.com/@nocnoc/combined-code-coverage-for-flutter-and-dart-237b9563ecf8

# remember some failed commands and report on exit
error=false

show_help() {
  printf "usage: $0 [--help]
Tool for running all unit and widget tests with code coverage and automatically generated if lcov is installed.

(run from root of repo)
where:
    --help
        print this message
"
  exit 1
}

# run unit and widget tests
runTests() {
  cd $1
  if [ -f "pubspec.yaml" ] && [ -d "test" ]; then
    echo -e "\n\033[1;34m=========================================================================\033[0m"
    echo -e "\033[1;32m🚀 RUNNING TESTS IN: \033[1;33m$1\033[0m"
    echo -e "\033[1;34m=========================================================================\033[0m"
    flutter pub get

    escapedPath="$(echo $1 | sed 's/\//\\\//g')"

    # run tests with coverage
    if grep flutter pubspec.yaml >/dev/null; then
      echo -e "\033[1;36m▶ Running flutter tests...\033[0m"
      if [ -f "test/all_tests.dart" ]; then
        flutter test --coverage --concurrency=1 test/all_tests.dart || error=true
      else
        flutter test --coverage --concurrency=1 || error=true
      fi

      if [ -d "coverage" ]; then
        # ensure root coverage dir exists
        mkdir -p "$2/coverage"
        # combine line coverage info from package tests to a common file
        sed "s/^SF:lib/SF:$escapedPath\/lib/g" coverage/lcov.info >>$2/coverage/test.info
        rm -f coverage/lcov.info
      fi
    else
      echo -e "\033[1;33m⚠ Not a flutter package, skipping.\033[0m"
    fi
  fi
  cd - >/dev/null
}

runReport() {
  echo -e "\n\033[1;34m=========================================================================\033[0m"
  echo -e "\033[1;32m📊 GENERATING COVERAGE REPORT\033[0m"
  echo -e "\033[1;34m=========================================================================\033[0m"
  
  if [ -f "coverage/test.info" ] && ! [ "$TRAVIS" ]; then
    # Fix paths for Windows compatibility
    sed -i 's/\\/\//g' coverage/test.info
    
    if command -v genhtml &> /dev/null; then
      genhtml coverage/test.info -o coverage --no-function-coverage --prefix $(pwd)

      if [ "$(uname)" == "Darwin" ]; then
        open coverage/index.html
      else
        start coverage/index.html
      fi
    else
      echo -e "\033[1;33m⚠ Warning: genhtml (lcov) is not installed. Skipping HTML report generation.\033[0m"
      echo -e "Coverage info is available at \033[1;36mcoverage/test.info\033[0m"
    fi
  fi
}

if ! [ -f "pubspec.yaml" ] && [ -d .git ]; then
  printf "\nError: not in root of repo\n"
  show_help
fi

case $1 in
--help)
  show_help
  ;;
*)
  currentDir=$(pwd)
  # if no parameter passed
  if [ -z $1 ]; then
    if [ -d "coverage" ]; then
      rm -r coverage
    fi
    dirs=($(find . -maxdepth 2 -type d))
    for dir in "${dirs[@]}"; do
      runTests $dir $currentDir
    done
  else
    if [[ -d "$1" ]]; then
      runTests $1 $currentDir
    else
      printf "\nError: not a directory: $1"
      show_help
    fi
  fi
  runReport
  ;;
esac

# Fail the build if there was an error
if [ "$error" = true ]; then
  echo -e "\n\033[1;31m❌ SOME TESTS FAILED!\033[0m"
  read -p "Press Enter to exit..."
  exit -1
fi

echo -e "\n\033[1;32m✅ ALL TESTS COMPLETED SUCCESSFULLY!\033[0m"
read -p "Press Enter to exit..."
