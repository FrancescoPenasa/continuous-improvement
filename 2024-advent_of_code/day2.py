"""

"""

def check_safety_tolerant(report):

    direction = 0
    safety_broken = False
    previous = int(report[0])
    for i in range(1, len(report)):
        level = int(report[i])

        # understand the direction
        if direction == 0:
            if level > previous:
                direction = 1
            else:
                direction = -1

        # too big step, too small step, no step, wrong direction
        # then interrupt and return 0
        if (level - previous > 3
                or  level - previous < -3
                or level == previous
                or (direction == 1 and previous > level)
                or (direction == -1 and level > previous)):
            if safety_broken:
                return 0
            else:
                print('warning')
                print(report)
                print(i)

                res = max(check_safety(report[1:] ), check_safety(report[0:i] + report[i+1:]), check_safety(report[0:i-1] +report[i:]))
                print(res)
                return res
                # reset and remove
        previous = level
    # end of loop
    return 1

def check_safety(report):
    print(report)

    direction = 0
    previous = int(report[0])
    for i in range(1, len(report)):
        level = int(report[i])

        # understand the direction
        if direction == 0:
            if level > previous:
                direction = 1
            else:
                direction = -1

        # too big step, too small step, no step, wrong direction
        # then interrupt and return 0
        if (level - previous > 3
                or  level - previous < -3
                or level == previous
                or (direction == 1 and previous > level)
                or (direction == -1 and level > previous)):
            return 0
        previous = level
    # end of loop
    return 1

total = 0
total_2 =  0

# using with is automatically closed at the end
with open('input/day2.txt', 'r', encoding="utf-8") as f:
    lines = f.readlines()

    for line in lines:
        #total += check_safety(line.replace("\n", "").split(" "))
        total_2 += check_safety_tolerant(line.replace("\n", "").split(" "))

    print("close input")


print(f"total {total}")
print(f"totale2 {total_2}")
