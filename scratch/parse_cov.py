import re
import sys

def parse_lcov(file_path):
    coverage_data = {}
    current_file = None
    with open(file_path, 'r') as f:
        for line in f:
            line = line.strip()
            if line.startswith('SF:'):
                current_file = line[3:]
                coverage_data[current_file] = {'lines': {}, 'hit': 0, 'total': 0}
            elif line.startswith('DA:'):
                parts = line[3:].split(',')
                line_num = int(parts[0])
                hits = int(parts[1])
                coverage_data[current_file]['lines'][line_num] = hits
                coverage_data[current_file]['total'] += 1
                if hits > 0:
                    coverage_data[current_file]['hit'] += 1
                    
    for file, data in coverage_data.items():
        if data['total'] > 0:
            pct = data['hit'] / data['total'] * 100
            if pct < 100:
                uncovered = [str(line) for line, hits in data['lines'].items() if hits == 0]
                print(f"{file} ({pct:.1f}%): Missing lines: {', '.join(uncovered)}")

if __name__ == '__main__':
    parse_lcov('coverage/lcov.info')
