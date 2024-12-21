"""
--- Day 5: Print Queue ---
"""
import math
from operator import indexOf

from day2 import total_2

FILENAME= 'input/day5.txt'

with open(FILENAME, 'r', encoding="utf-8") as f:
    lines = f.readlines()

rules = {}
updates = []
updates_not_valid = []
is_rules = True
for line in lines:
    if line == '\n':
        is_rules = False

    line = line.replace('\n', '')
    if is_rules:
        first, second = line.split('|')
        rules.setdefault(second, []).append(first)

    else:
        updates.append(line)

total = 0
for line in updates[1:]:
    pages = line.split(',')

    last = ''
    is_valid = True
    for page in reversed(pages):
        if last != '' and  not (page in rules[last]):
            is_valid = False
        else:
            last = page

    if is_valid:
        total += int ( pages[math.ceil(len(pages)/2)  - 1])
    else:
        updates_not_valid.append(line)




print(rules)
print(total)

total2 = 0
# part 2
for line in updates_not_valid:
    pages = line.split(',')

    last = ''
    valid_index = 0

    # careful, the index must be recalculated
    print(f'unchanged pages {pages}')
    i = len(pages) - 1

    while i>0:
        if last != '' and not(pages[i-1] in rules[pages[i]] ):
            valid_index = i

            tmp = pages[i]
            pages[i] = pages[i-1]
            pages[i-1] = tmp

            # restart loop
            i = len(pages)
        else:
            last = pages[i]
        i -= 1

    # for index, val in enumerate(reversed(pages)):
    #     if last != '' and not (val in rules[last]) and index != len(pages) -1 :
    #         valid_index = len(pages) - index
    #
    #         tmp = pages[valid_index]
    #         pages[valid_index] = pages[valid_index - 1]
    #         pages[valid_index - 1] = tmp
    #         print(valid_index)
    #         # todo restart
    #         last = val
    #     else:
    #         last = val

    # print(f" pages {pages}, valid_index {valid_index}")
    # tmp = pages[valid_index]
    # pages[valid_index] = pages[valid_index -1 ]
    # pages[valid_index-1 ] = tmp
    print(f"changed pages {pages}")
    total2 += int(pages[math.ceil(len(pages) / 2) - 1])


# non va perchè c'è più di un problema per riga
print (total2)