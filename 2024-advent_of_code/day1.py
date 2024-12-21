"""

"""

# populate list
left_arr = []
right_arr = []

# using with is automatically closed at the end
with open('input/day1.txt', 'r', encoding="utf-8") as f:
    lines = f.readlines()

    for line in lines:
        left, right = line.rstrip().split("   ")
        left_arr.append(int(left))
        right_arr.append(int(right))
    # todo insertion sort

    print("close input")


# order list, todo put it in the cycle
left_arr.sort()
right_arr.sort()


# calculate sum
total = 0
if len(left_arr) == len(right_arr):
    for i in range(len(left_arr)):
        total += abs(right_arr[i] - left_arr[i])

print(total)


# part 2, no sort needed this time, it could be done with a hashmap
total = 0
if len(left_arr) == len(right_arr):
    for i in range(len(left_arr)):
        total += left_arr[i] * right_arr.count(left_arr[i])

print(total)

