

n = 40;
m = 16;

% create (n x m) game board 
grid = zeros(n,m);

% start with a few cells
grid(20,8) = 1;
grid(22,9) = 1;
grid(21,8) = 1;
grid(20,9) = 1;
grid(22,8) = 1

pause on

for i=2:n-1 % cycle through each column
    for j=2:m-1 % cylce through each row
        pause
        
        % count the number of cells around it
        neighbors = 0;
        %pop = grid(i-1,j-1)
        if(grid(i-1,j-1) == 1) % top left
            neighbors = neighbors + 1;
        end
        if(grid(i-1,j) == 1) % top mid
            neighbors = neighbors + 1;
        end
        if(grid(i-1,j+1) == 1) % top right
            neighbors = neighbors + 1;
        end
        if(grid(i,j-1) == 1) % middle left
            neighbors = neighbors + 1;
        end
        if(grid(i,j+1) == 1) % middle right
            neighbors = neighbors + 1;
        end
        if(grid(i+1,j-1) == 1) % bot left
            neighbors = neighbors + 1;
        end
        if(grid(i+1,j) == 1) % bot mid
            neighbors = neighbors + 1;
        end
        if(grid(i+1,j+1) == 1) % bot right
            neighbors = neighbors + 1;
        end
        
        if(grid(i,j) == 1) % cell is populated
                        
            if(neighbors <= 1) % Rule one: one or no neighbors - dies of solitude
                grid(i,j) = 0
            end
            if(neighbors >= 4) % Rule two: 4 or more neighbors - dies of overpopulation
               grid(i,j) = 0
            end
            % Rule three: 2 or 3 neighbors - survives 
                    
        else % cell is unpopulated
            if(neighbors == 3) % Rules four: 3 or more neighbors - grows by expansion
                grid(i,j) = 1
            end
        end
    end
end
