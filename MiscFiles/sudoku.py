"""
Sudoku puzzle solver
"""


"""
Finds the next cell to be evaluates (has a 0)
  returns the coordinates as (row, col)
"""
def FindNextCell(grid):
    for row in range(9):
        for col in range(9):
            if(grid[row][col] == 0):
                return row, col



"""
Check possibilities of a cell by
  - Row
  - Column
  - Box
"""
def isValid(grid, row, col):
        
    # Make a list of possible numbers
    possibilities = [1, 2, 3, 4, 5, 6, 7, 8, 9]
    
    # Check by row
    for i in range(9):
        if grid[row][i] in possibilities:
            possibilities.remove(grid[row][i])
    
    # Check by column
    for j in range(9):
        if grid[j][col] in possibilities:
            possibilities.remove(grid[j][col])
    
    # Check by box
    box_coords = determineBox(row, col)
    for i in range(3):
        for j in range(3):
            if(grid[box_coords[0]+i][box_coords[2]+j] != 0):
                if(grid[box_coords[0]+i][box_coords[2]+j] in possibilities):
                    possibilities.remove(grid[box_coords[0]+i][box_coords[2]+j])
    
    #print('possibilities = ', possibilities, ' for (', row, ',', col, ')')
    if(len(possibilities) == 1):
        grid[row][col] = possibilities[0]
    
    return grid



"""
Determine the box that the number is located
   - returns [min_row, max_row, min_col, max_col]
"""
def determineBox(row, col):
    
    # Top line of boxes
    if(0 <= row <= 2):
        # Top left box
        if(0 <= col <= 2):
            return [0, 2, 0, 2]
        # Top middle box
        if(3 <= col <= 5):
            return [0, 2, 3, 5]
        # Top right box
        if(6 <= col <= 8):
            return [0, 2, 6, 8]
    
    # Middle line of boxes
    if(3 <= row <= 5):
        # Middle left box
        if(0 <= col <= 2):
            return [3, 5, 0, 2]
        # Middle middle box
        if(3 <= col <= 5):
            return [3, 5, 3, 5]
        # Middle right box
        if(6 <= col <= 8):
            return [3, 5, 6, 8]
    
    # Bottom line of boxes
    if(6 <= row <= 8):
        # Bottom left box
        if(0 <= col <= 2):
            return [6, 8, 0, 2]
        # Bottom middle box
        if(3 <= col <= 5):
            return [6, 8, 3, 5]
        # Bottom right box
        if(6 <= col <= 8):
            return [6, 8, 6, 8]
    

"""
Print the puzzle in readable form
   - Replace zeros with 'X'
   - Print | after every third column
   - Print ----- after every third row
"""
def PrintPuzzle(grid):
    for i in range(9):
        for j in range(9):
            if(grid[i][j] == 0):
                print('X', ' ', end='')
            else:
                print(grid[i][j], ' ', end='')
            if(j == 2 or j == 5):
                print('|  ', end='')
        print('')
        if(i == 2 or i == 5):
            print('-------------------------------')




grid = [[0,0,7, 0,0,0, 0,1,5], \
        [0,0,0, 3,9,7, 0,0,0], \
        [0,6,2, 0,1,0, 4,0,9], \
        \
        [0,2,0, 0,0,1, 5,4,3], \
        [7,0,0, 4,0,9, 0,0,1], \
        [4,8,1, 2,0,0, 0,6,0], \
        \
        [9,0,6, 0,2,0, 7,3,0], \
        [0,0,0, 9,8,4, 0,0,0], \
        [1,5,0, 0,0,0, 2,0,0]]

print('Problem: ')
PrintPuzzle(grid)
print('')
print('')
print('')


for duh in range(100):    
    for row in range(9):
        for col in range(9):
            if(grid[row][col] == 0):
                grid = isValid(grid, row, col)
                


print('Solution: ')
PrintPuzzle(grid)










