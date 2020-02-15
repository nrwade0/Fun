%{
 In prime shape

 

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