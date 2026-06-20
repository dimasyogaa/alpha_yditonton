import os
import sys

def parse_lcov(lcov_path):
    coverage = {}
    current_file = None
    if not os.path.exists(lcov_path):
        return coverage

    with open(lcov_path, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('SF:'):
                current_file = line[3:]
                coverage[current_file] = {'hit': 0, 'total': 0, 'missed': []}
            elif line.startswith('DA:'):
                parts = line[3:].split(',')
                line_num = int(parts[0])
                hit_count = int(parts[1])
                coverage[current_file]['total'] += 1
                if hit_count > 0:
                    coverage[current_file]['hit'] += 1
                else:
                    coverage[current_file]['missed'].append(line_num)
            elif line == 'end_of_record':
                current_file = None
    return coverage

def print_coverage(coverage):
    for file, data in coverage.items():
        total = data['total']
        hit = data['hit']
        if total == 0:
            continue
        pct = (hit / total) * 100
        if pct < 100:
            print(f"File: {file} - Coverage: {pct:.2f}% ({hit}/{total})")
            print(f"Missed lines: {data['missed'][:20]} {'...' if len(data['missed']) > 20 else ''}")
            print("-" * 40)

if __name__ == '__main__':
    modules = ['core', 'movie', 'tv']
    for module in modules:
        print(f"=== MODULE: {module} ===")
        lcov_path = os.path.join(module, 'coverage', 'lcov.info')
        cov = parse_lcov(lcov_path)
        if not cov:
            print(f"No coverage data found for {module}.")
        else:
            print_coverage(cov)
