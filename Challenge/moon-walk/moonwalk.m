%{
   MOON-WALK
    You are given an undirected graph having n vertices, numbered 1 to n, 
     and m edges. Each edge is associated with an integer weight, which is 
     to be interpreted as a binary bit vector.

    A walk in this graph is any path that starts at vertex 1 and ends at 
     vertex n. A walk is allowed to visit the same vertex and same edge 
     multiple times. Our objective is to compute a minimum-weight path 
     from 1 to n, but as our graph resides on the lunar surface the notion
     of “weight” is very unusual up there.

    Rather than summing up weights along a path, we instead take the 
     exclusive-or (xor) of the edge weights. For example, if a walk 
     travels along three edges with decimal weights 26 (= 11010), 
     18 (= 10010), and 5 (= 00101) the total weight of the walk is 
     13 (= 11010 ⊕ 10010 ⊕ 00101). Your objective is to find the walk of 
     minimum xor-weight from vertex 1 to vertex n.
%}

clc
format long g
tic;
cd /Users/nick/Documents/GitHub/projects/Challenge/moon-walk

% set run parameters
challenge = 0;
test_num = '1'; % 0 1 or 2


%% ---- INPUT TEXT.IN FILE ---- %%
%    The first line contains the two numbers n and M, separated by a space.
%    This is followed by n lines, each containing a prime number
%    p1, p2, . . . , pn of P . You may assume they are distinct.
if(challenge == 0)
    file_name = strcat('data/moonwalk-test', test_num, '.in');
    f = fopen(file_name,'r');    % input test
    
    % get variables
    n = fscanf(f, '%d', 1);
    m = fscanf(f, '%d', 1);
    abw = fscanf(f, '%d', [3 m]);
    abw = transpose(abw);

    % close file
    fclose(f);
else
    % execute challenge
    f = fopen('data/moonwalk-challenge.in','r');    % input challenge

    % get variables
    n = fscanf(f, '%d', 1);
    m = fscanf(f, '%d', 1);
    abw = fscanf(f, '%d', [3 m]);
    abw = transpose(abw);

    % close file
    fclose(f);
end
fprintf('The `.in` file was sucessfully imported. --- ')
toc
fprintf('\n')


node_names = {'A','B','C'};
G = graph(abw(:,1), abw(:,2), abw(:,3))
plot(G, 'EdgeLabel', G.Edges.Weight)


