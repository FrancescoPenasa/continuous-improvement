"""
--- Day 3: Mull It Over ---
"Our computers are having issues, so I have no idea if we have any Chief Historians in stock!
You're welcome to check the warehouse, though," says the mildly flustered shopkeeper at the North Pole Toboggan Rental Shop.
The Historians head out to take a look.

The shopkeeper turns to you.
"Any chance you can see why our computers are having issues again?"

The computer appears to be trying to run a program, but its memory (your puzzle input) is corrupted.
All of the instructions have been jumbled up!

It seems like the goal of the program is just to multiply some numbers.
It does that with instructions like mul(X,Y), where X and Y are each 1-3 digit numbers.
For instance, mul(44,46) multiplies 44 by 46 to get a result of 2024. Similarly, mul(123,4) would multiply 123 by 4.

However, because the program's memory has been corrupted, there are also many invalid characters that should be ignored,
even if they look like part of a mul instruction. Sequences like mul(4*, mul(6,9!, ?(12,34), or mul ( 2 , 4 ) do nothing.

For example, consider the following section of corrupted memory:

xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))

Only the four highlighted sections are real mul instructions.
Adding up the result of each instruction produces 161 (2*4 + 5*5 + 11*8 + 8*5).

Scan the corrupted memory for uncorrupted mul instructions.
What do you get if you add up all of the results of the multiplications?
"""

import re

# with open('input/day3.txt', 'r', encoding="utf-8") as f:
#     text = f.read()
#     #pattern = r"(?<![a-zA-Z])mul\([0-9]+,[0-9]+\)"
#     pattern = r"mul\([0-9]+,[0-9]+\)"
#     matches = re.findall(pattern, text)
#
# total = 0
# for mul in matches:
#     num_pattern = r"[0-9]+"
#     nums = re.findall(num_pattern, mul)
#     total += int(nums[0]) * int(nums[1])
#
# print(f"total = {total}")


# exercise 2
# another way could be the have the indexes

pattern = r"mul\([0-9]+,[0-9]+\)"
start= "do()"
end = "don't()"
total = 0

with open('input/day3.txt', 'r', encoding="utf-8") as f:
    text = f.read()

total_len = len(text)
start_index = 0
end_index = text.index(end)

window = []
tmp = 0

go_on = True
while go_on:
    print(f'working on {tmp} /{total_len}')
    print(f'{start_index} - {end_index}')
    # shift window
    window = text[start_index:end_index]
    tmp += len(window)

    # take values
    matches = re.findall(pattern, window)
    for mul in matches:
        num_pattern = r"[0-9]+"
        nums = re.findall(num_pattern, mul)
        total += int(nums[0]) * int(nums[1])


    # remove the first step and find new indexes
    text = text[end_index:]
    try:
        start_index = text.index(start)
        end_index = start_index + text[start_index:].index(end)
    except:
        print("end of file")
        print(f"total = {total}")
        go_on=False

print(f"total = {total}")

# alternative get the indexes of do() and don't()