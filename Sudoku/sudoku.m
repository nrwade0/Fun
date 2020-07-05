%{
    Sudoku puzzle solver
    07-03-2020

    SOLUTIONS:

   DEDUCTIVE
    Using deductive reasoning to eliminate possibilities in each position
    based on the row, column, and box data.
    
   BACKTRACKING
    Backtracking includes testing "branches" by checking if the random 
     numbers are allowed to be there is allowed to be there. If there are
     no violations (checking row, column, and box constraints) the branch 
     is moved forward When checking for violations, if it is discovered 
     that the "1" is not allowed, the value is advanced to "2". If a cell 
     is discovered where none of the 9 digits is allowed, then the 
     algorithm leaves that cell blank and moves back to the previous cell. 
     The value in that cell is then incremented by one. This is repeated 
     until the allowed value in the last (81st) cell is discovered.
%}

% ------------------------------------------------------- %
% ----------------------- PREAMBLE ---------------------- %
% ------------------------------------------------------- %

% initialize the puzzle
tic
clc

% select puzzle type
easy = 0;
hard = 1;

if(easy == 1)
    grid = [[5 3 0  0 7 0  0 0 0];
            [6 0 0  1 9 5  0 0 0];
            [0 9 8  0 0 0  0 6 0];
            [8 0 0  0 6 0  0 0 3];
            [4 0 0  8 0 3  0 0 1];
            [7 0 0  0 2 0  0 0 6];
            [0 6 0  0 0 0  2 8 0];
            [0 0 0  4 1 9  0 0 5];
            [0 0 0  0 8 0  0 7 9]];
elseif(hard == 1)
    grid = [[0 0 3  0 0 1  2 0 0];
            [6 8 0  0 0 0  3 0 7];
            [9 0 5  0 0 0  0 0 0];
            [0 0 0  8 2 0  0 0 6];
            [0 0 2  1 0 9  5 0 0];
            [3 0 0  0 6 5  0 0 0];
            [0 0 0  0 0 0  8 0 5];
            [5 0 7  0 0 0  0 4 1];
            [0 0 9  5 0 0  6 0 0]];
end

    
% draw beginning grid
draw(grid)

% set row/column iterators and while-loop condition
i = 1; j = 1; done = 0;

% declare testing type
deductive = 0;
backtracking = 1;




% ------------------------------------------------------- %
% ---------------------- SOLUTIONS ---------------------- %
% ------------------------------------------------------- %
% solve by deduction
if(deductive == 1)
    while(done == 0)
        % for each empty space, check possibility based on row, col, & box
        if(grid(i,j) == 0)
            p = zeros(1,9);
            p = check_box(grid,i,j,p);
            p = check_row(grid,i,j,p);
            p = check_col(grid,i,j,p);

            % set to only possibility, if applicable
            if(sum(p(:)==0) == 1)
                grid(i,j) = find(p==0);
            end
        end
        
        % go until no more zeros
        if(ismember(0, grid) == 0)
            done = 1;
        end
        
        % cycle thru all i's and j's
        i = i + 1;
        if(i == 10)    % if end of the row,
            i = 1;     % reset i, and
            j = j + 1; % increment to the next row
        end
        
        % reset completely at the end of the square
        if(i == 9 && j == 9)
            i = 1; j = 1;
        end
    end
    draw(grid)
end

% solve by backtracking, grid is displayed in 
if(backtracking == 1)
    branch_out(grid);
end

% show elapsed time
toc




% ------------------------------------------------------- %
% ---------------------- FUNCTIONS ---------------------- %
% ------------------------------------------------------- %

%{
  CHECK_BOX(GRID, I, J, P)
    checks the numbers in 1 of the 9 boxes in which (i,j) is located
  inputs: GRID = current sudoku puzzle grid
    I = current row to be checked
    J = current column to be checked
    P = number possibility array e.g. [0 0 1 ... 1 1 0] (0 = could be)
  output: P = possible values isolated based on box data
%}
function p = check_box(grid, i, j, p)
    % get the ranges of i and j of the box to search within
    switch i   % i_range = range for i
        case {1,2,3}
            i_range = 1:3;
        case {4,5,6}
            i_range = 4:6;
        case {7,8,9}
            i_range = 7:9;
    end
    switch j   % j_range = range for j
        case {1,2,3}
            j_range = 1:3;
        case {4,5,6}
            j_range = 4:6;
        case {7,8,9}
            j_range = 7:9;
    end
    
    % use the ranges to search the box and eliminate possibilities in p
    for x = 1:3
        for y = 1:3
            if(grid(i_range(x), j_range(y)) == 0)
                continue
            else
                p(1,grid(i_range(x),j_range(y))) = 1;
            end
        end
    end
    
end


%{
  CHECK_ROW(GRID, I, J, P)
    checks the numbers in the ith row
  inputs: GRID = current sudoku puzzle grid
    I = current row to be checked
    (UNUSED) J = current column to be checked
    P = number possibility array e.g. [0 0 1 ... 1 1 0] (0 = could be)
  output: P = possible values isolated based on row data
%}
function p = check_row(grid, i, ~, p)
    % use cols to iterate to each number (iterator = c) in a row
    cols = 1:9;
    for y = 1:9
        c = cols(y);
        if(grid(i, c) == 0)
            continue
        else
            p(1,grid(i, c)) = 1;
        end
    end
    
end


%{
  CHECK_COL(GRID, I, J, P)
    checks the numbers in the jth column
  inputs: GRID = current sudoku puzzle grid
    (UNUSED) I = current row to be checked
    J = current column to be checked
    P = number possibility array e.g. [0 0 1 ... 1 1 0] (0 = could be)
  output: P = possible values isolated based on column data
%}
function p = check_col(grid, ~, j, p)
    % use rows to iterate to each number (iterator = r) in a column
    rows = 1:9;
    for x = 1:9
        r = rows(x);
        if(grid(r, j) == 0)
            continue
        else
            p(1,grid(r, j)) = 1;
        end
    end
    
end


%{
  VALIDATE(GRID, I, J, VAL)
    validate the temp variable going into the empty cell when backtracking
  inputs: GRID = current sudoku puzzle grid
    I = current row to be checked
    J = current column to be checked
    VAL = temporary variable being tested for validity
  output: TF = binary integer whether val is valid in that cell
%}
function tf = validate(grid, i, j, val)
    % assume it will be validated
    tf = 0; % can be returned several times throughout
    
    % ---- CHECK IF TEMP IS IN THE BOX ---- %
    % get the ranges of i and j of the box to search within
    switch i   % i_range = range for i
        case {1,2,3}
            i_range = 1:3;
        case {4,5,6}
            i_range = 4:6;
        case {7,8,9}
            i_range = 7:9;
    end
    switch j   % j_range = range for j
        case {1,2,3}
            j_range = 1:3;
        case {4,5,6}
            j_range = 4:6;
        case {7,8,9}
            j_range = 7:9;
    end
    % use the ranges to search the box and eliminate possibilities in p
    for x = 1:3
        for y = 1:3
            if(grid(i_range(x), j_range(y)) == val)
                tf = 1;
                return
            end
        end
    end
    
    
    % ---- CHECK IF TEMP IS IN THE ROW ---- %
    % use y to iterate to each number in a row, i
    for y = 1:9
        if(grid(i, y) == val)
            tf = 1;
            return
        end
    end
    
    
    % ---- CHECK IF TEMP IS IN THE COL ---- %
    % use x to iterate to each number in a col, j
    for x = 1:9
        if(grid(x, j) == val)
            tf = 1;
            return
        end
    end
end


%{
  BRANCH_OUT(GRID)
    creates new branch of possibility in puzzle guess
  inputs: GRID = current sudoku puzzle grid (continously in-development)
  output: B = keeps track of successful branches
%}
function b = branch_out(grid)
    for i = 1:9 % check each row
        for j = 1:9 % check each col
            if(grid(i,j) == 0) % if empty box
                for temp = 1:9 % try values 1 thru 9
                    if(validate(grid, i, j, temp) == 0) % check if safe
                        % write temp into grid
                        grid(i,j) = temp;
                        
                        % draw commands
                        %clc
                        %draw(grid)
                        
                        % start next branch
                        if(branch_out(grid) == 1)
                            b = 1;
                            return
                        else % unsuccessful
                            grid(i,j) = 0;
                        end
                    end
                end
                b = 0; %backtrack
                return
            end
        end
    end
    b = 1; % draw finished grid (grid doesn't export)
    draw(grid)
end


%{
  DRAW(GRID)
    Displays a readable sudoku grid in the command window
  input: GRID = current sudoku puzzle grid
  output: prints to command window
%}
function draw(grid)
    % print a header
    fprintf('\n-------\ndraw(grid):  \n')
    % iterate to each value with (r,c)
    for r = 1:9
       for c = 1:9
           % end of a box
           if(c == 4 || c == 7)
               fprintf(' | ')
           end
           % print value
           fprintf(' %d ', grid(r, c))
       end
       % end of a row
       if(r == 3 || r == 6)
           fprintf('\n---------------------------------')
       end
       fprintf(' \n')
    end
end