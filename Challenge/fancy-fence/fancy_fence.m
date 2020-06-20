%{
 Fancy fence

Letting 'a' denote the number of horizontal and vertical fence segments, and
 letting 'b' denote the number of diagonal segments, the total length of
 the fence is a + b*sqrt(2). Write a program that inputs the tree coordinates
 and outputs the values 'a' and 'b'.

%}

format long g

%{ 
   Input text file
    inputs coordinates of trees into 'points'  and number of trees into 'N'
%}
cd /Users/nick/Documents/GitHub/projects/UMDChallengeBox/fancy-fence
f = fopen('data/fence-challenge.in','r');    % challenge
%f = fopen('data/fence-test2.in','r');      % test

% get number of trees (N) and coordinates of those trees (points 2xN array)
N = fscanf(f, '%d', 1);
points = transpose(fscanf(f, '%d %d', [2 N]));

% close file
fclose(f);



%{ 
   Convex hull algorithm - Graham Scan
    Pseudocode and explanation found here:
    https://en.wikipedia.org/wiki/Graham_scan
%}

% find lowest y-coordinate and leftmost point, called p0
p0 = points(1,:); % initialize as first point

for i = 1:N
    if(points(i,2) < p0(1,2)) % lowest y-coordinate
        p0 = points(i,:);
    end
end

for i = 1:N
    % leftmost at same y-coord as current p0
    if(points(i,2) == p0(1,2) && points(i,1) < p0(1,1))
        p0 = points(i,:);
    end
end

% initialize polar angles and distance matrix, to be combined w/ points
polars = zeros(N,2);

% solve for polar angles (col 1 in 'polars') and dist (col 2 in 'polars')
for i = 1:N
    delta_x = points(i,1) - p0(1,1);
    delta_y = points(i,2) - p0(1,2);
    polars(i,1) = atan2(delta_y, delta_x)*180/pi; % degrees
    polars(i,2) = sqrt(delta_x^2 + delta_y^2);
end

% concatenate with points matrix now a Nx4 matrix
points = [points polars];

% sort based on col 3 (polar angle) with col 4 (dist) breaking ties
points = sortrows(points, [3 4]);

% remove first row (p0)
points = points(2:end,:);

% initalize our dynamic stack as only the coordinates from points
stack = points(:,1:2);

% reset N and declare hull (our convex hull coordinates)
N = N-1;

% start Graham scan...
for i = 1:N
    
    % current checked point declared
    point = points(i,1:2);
    
    % get rid of the point if we turn clockwise
    while(length(stack) > 1 && ccw(stack(2,:), stack(1,:), point) < 0)
        stack = stack(2:end,:); % pop stack (remove top)
    end
    
    % push point to stack for the next check
    stack = [point; stack];
    
end

% set the appropriate coords from the stack to the hull surrounded by p0's
%  for completness in plotting
hull = [p0; stack(1:end-N,:); p0];

% With the convex hull coordinates, determine length from point to point
%  'a' being left/right/up/down, 'b' being diagonal moves, saved in 'moves'
a = 0;
b = 0;
moves = [a b];

% for each two coordinate pairs, calculate_movement()
for i = 1:size(hull,1)-1
    p1 = hull(i,:);
    p2 = hull(i+1,:);
    moves = moves + calculate_movement(p1,p2);
end

% show 'a' and 'b' and 'total_length' from prompt
a = moves(1,1)
b = moves(1,2)
total_length = moves(1,1) + moves(1,2)*sqrt(2)

% write answer to txt file
f_out = fopen('data/fence-challenge.out','w');

% get number of trees (N) and coordinates of those trees (points 2xN array)
fprintf(f_out, 'a = %d, b = %d', a, b);

% close output file
fclose(f_out);


% quick plot of garden with black trees, fence in red, p0 in blue
hold on
offset = mean(hull(:,:))/10;
sz = 250;
scatter(points(:,1), points(:,2), sz, 'k.')
scatter(p0(1,1), p0(1,2), sz, 'b.')
plot(hull(:,1), hull(:,2), 'r-')
xlim([min(hull(:,1))-offset(1,1) max(hull(:,1))+offset(1,1)])
ylim([min(hull(:,2))-offset(1,2) max(hull(:,2))+offset(1,1)])
grid on
hold off



%{
    Input: three points: p1, p2, p3, each a 1x2 array of coordinates
    Outputs: positive: left turn, zero: colinear, positive: right turn 
    Computes the orientation of the three points (which way they turn)
%}
function o = ccw(p1, p2, p3)
    % For three points P1 = (x1,y1), P2 = (x2,y2) and P3 = (x3,y3), 
    %  compute the z-coordinate of the cross product of the two vectors 
    %  which is given by the expression:
    %          (x2 - x1)(y3 - y1) - (y2 - y1)(x3 - x1).
    % If the result is 0, the points are collinear;
    % if it is positive, the three points constitute a "left turn" or
    %   counter-clockwise orientation,
    % otherwise a "right turn" or clockwise orientation
    %   (for counter-clockwise numbered points).
    
    o = (p2(1,1) - p1(1,1))*(p3(1,2) - p1(1,2)) - ...
        (p2(1,2) - p1(1,2))*(p3(1,1) - p1(1,1));
    
end


%{
    Input: two points: p1, p2, each a 1x2 array of coordinates
    Outputs: 1x2 array moves of 'a' (left/right/up/down) and 'b' (diagonal)
    computes the movements between two points as 'a' and 'b'
%}
function moves = calculate_movement(p1, p2)
    % determine x and y movements between the two points
    x_delta = abs(p1(1,1) - p2(1,1));
    y_delta = abs(p1(1,2) - p2(1,2));
    
    % reset movements
    a = 0;
    b = 0;
    
    while(x_delta > 0 && y_delta > 0) % diagonal movement
        x_delta = x_delta - 1;
        y_delta = y_delta - 1;
        b = b + 1;
    end
    
    if(x_delta == 0) % up/down movement
        while(y_delta > 0)
            y_delta = y_delta - 1;
            a = a + 1;
        end
    elseif(y_delta == 0) % left/right movement
        while(x_delta > 0)
            x_delta = x_delta - 1;
            a = a + 1;
        end
    end
    
    moves = [a b];
end








