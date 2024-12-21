"""
--- Day 4: Ceres Search ---

"Looks like the Chief's not here. Next!" One of The Historians pulls out a device and pushes the only button on it. After a brief flash, you recognize the interior of the Ceres monitoring station!

As the search for the Chief continues, a small Elf who lives on the station tugs on your shirt; she'd like to know if you could help her with her word search (your puzzle input). She only has to find one word: XMAS.

This word search allows words to be horizontal, vertical, diagonal, written backwards, or even overlapping other words. It's a little unusual, though, as you don't merely need to find one instance of XMAS - you need to find all of them. Here are a few ways XMAS might appear, where irrelevant characters have been replaced with .:

..X...
.SAMX.
.A..A.
XMAS.S
.X....

The actual word search will be full of letters instead. For example:

MMMSXXMASM
MSAMXMSMSA
AMXSXMAAMM
MSAMASMSMX
XMASAMXAMM
XXAMMXXAMA
SMSMSASXSS
SAXAMASAAA
MAMMMXMMMM
MXMXAXMASX

In this word search, XMAS occurs a total of 18 times; here's the same word search again, but where letters not involved in any XMAS have been replaced with .:

....XXMAS.
.SAMXMS...
...S..A...
..A.A.MS.X
XMASAMX.MM
X.....XA.A
S.S.S.S.SS
.A.A.A.A.A
..M.M.M.MM
.X.X.XMASX

Take a look at the little Elf's word search. How many times does XMAS appear?
"""

limit = 140

def searching_x_mas(i, j, matrix):
    # todo improvement recursive


    if (
            matrix[i-1][j-1] == 'M' and matrix[i-1][j+1] == 'S' and
            matrix[i+1][j-1] == 'M' and matrix[i+1][j+1] == 'S') or (
            matrix[i-1][j-1] == 'S' and matrix[i-1][j+1] == 'M' and
            matrix[i+1][j-1] == 'S' and matrix[i+1][j+1] == 'M') or (
            matrix[i-1][j-1] == 'M' and matrix[i-1][j+1] == 'M' and
            matrix[i+1][j-1] == 'S' and matrix[i+1][j+1] == 'S') or (
            matrix[i-1][j-1] == 'S' and matrix[i-1][j+1] == 'S' and
            matrix[i+1][j-1] == 'M' and matrix[i+1][j+1] == 'M'):
        return 1
    return 0



def searching_xmas(i, j, matrix, last_step):
    # if i >= limit or i < 0 or j >=limit or j< 0:
    #     return 0
    # if (matrix[i][j] == "S" and  last_step ==  2):
    #     return  1
    # if (last_step == 0 and matrix[i][j] == 'M') or (last_step == 1 and matrix[i][j] == 'A'):
    #     return (
    #             searching_xmas(i-1, j, matrix, last_step+1)   + searching_xmas(i, j-1, matrix, last_step+1)   +
    #             searching_xmas(i+1, j, matrix, last_step+1)   + searching_xmas(i, j+1, matrix, last_step+1)   +
    #             searching_xmas(i-1, j-1, matrix, last_step+1) + searching_xmas(i-1, j+1, matrix, last_step+1) +
    #             searching_xmas(i+1, j-1, matrix, last_step+1) + searching_xmas(i+1, j+1, matrix, last_step+1)
    #             )
    # else :
    #     return 0


    total = 0

    #east
    if j+3<limit and matrix[i][j+1] == 'M' and matrix[i][j+2] == 'A' and matrix[i][j+3] == 'S':
        total+=1

    #west
    if j-3>-1 and matrix[i][j-1] == 'M' and matrix[i][j-2] == 'A' and matrix[i][j-3] == 'S':
        total+=1

    #nord
    if i-3>-1 and matrix[i-1][j] == 'M' and matrix[i-2][j] == 'A' and matrix[i-3][j] == 'S':
        total+=1

    #sud
    if i+3<limit and matrix[i+1][j] == 'M' and matrix[i+2][j] == 'A' and matrix[i+3][j] == 'S':
        total+=1

    #n-e
    if i-3>-1 and j+3<limit and matrix[i-1][j+1] == 'M' and matrix[i-2][j+2] == 'A' and matrix[i-3][j+3] == 'S':
        total+=1

    #n-w
    if i-3>-1  and j-3>-1 and matrix[i-1][j-1] == 'M' and matrix[i-2][j-2] == 'A' and matrix[i-3][j-3] == 'S':
        total+=1

    #s-e
    if i+3<limit and j+3<limit and matrix[i+1][j+1] == 'M' and matrix[i+2][j+2] == 'A' and matrix[i+3][j+3] == 'S':
        total+=1

    #s-w
    if i+3<limit and j-3>-1 and matrix[i+1][j-1] == 'M' and matrix[i+2][j-2] == 'A' and matrix[i+3][j-3] == 'S':
        total+=1

    return total

with open('input/day4.txt', 'r', encoding="utf-8") as f:
    lines = f.readlines()


total = 0
total_2 = 0

# find the X
for i in range(len(lines)):
    print(f'i {i}:{lines[i]}')
    for j in range(len(lines[i])):
        print(f'j:{j}')
        # print(f'char: {lines[i][j]}')
        if lines[i][j] == 'X':
            total += searching_xmas(i,j, lines, 0)

        if lines[i][j] == 'A' and i>0 and j>0 and i<limit-1 and j<limit-1:
            total_2 += searching_x_mas(i, j, lines)

print(total)
print(total_2)