%{
   IN-PRIME-SHAPE

    Given a set P of primes, your cryptography system relies on the fact
    that there are lots of P-divisible numbers. 

    To check this, write a program, which given a set P of primes and a
    positive integer M, computes the number of P-divisible numbers that are
    less than or equal to M.
 
%}

clc
format long g
tic;

% set run parameters
challenge = 1;
test_num = '2'; % 0 1 or 2


%%%% ---- INPUT TEXT.IN FILE ---- %%%%
%    The first line contains the two numbers n and M, separated by a space.
%    This is followed by n lines, each containing a prime number
%    p1, p2, . . . , pn of P . You may assume they are distinct.
if(challenge == 0)
    cd /Users/nick/Documents/GitHub/projects/Challenge/in-prime-shape
    file_name = strcat('data/prime-test', test_num, '.in');
    f = fopen(file_name,'r');    % input test
    
    % get variables
    n = fscanf(f, '%d', 1);
    M = fscanf(f, '%d', 1);
    P = fscanf(f, '%d', [1 n]);

    % close file
    fclose(f);
else
    % execute challenge
    cd /Users/nick/Documents/GitHub/projects/Challenge/in-prime-shape
    f = fopen('data/prime-challenge.in','r');    % input challenge

    % get variables
    n = fscanf(f, '%d', 1);
    M = fscanf(f, '%d', 1);
    P = fscanf(f, '%d', [1 n]);

    % close file
    fclose(f);
end
fprintf('.in file imported\n')
toc


%%%% ---- EXTRA INSTRUCTIONS ---- %%%%
% Given P = {2, 5, 7} and M = 20, there are 10 P-divisible numbers that 
%  do not exceed 20 (namely, 1, 2, 4, 5, 7, 8, 10, 14, 16, and 20).

% determine the number of integers q that are P-divisible
% said to be P-divisible if q is evenly divisible by no prime number other
%  than the numbers of P.

if(challenge == 0) % running a test
    % Sieve method might be unnecessary... use MATLAB built-in function
    %  primes() to get primes up to 'M'
    p = primes(M);
    
    % run sieve method if testing
    %{
    primes = 2:M;
    p = 2;
    % using sieve method
    while (p <= M)
        for i = 2*p:p:M
            primes(i - 1) = 0;
        end
        p = p + 1;
    end
    primes = primes(primes > 0);
    %}
else % running the challenge
    % sieve method takes too long for challenge, input primes from .txt
    f = fopen('data/primes.txt','r');    % input primes.txt
    p = fscanf(f, '%d');
    p(p > M) = [];
    fclose(f);
end
fprintf('primes determined up to M=%d\n', M)
toc


% remove 'P' from 'p' making a list of bad multiples
neg_P = setdiff(p,P);

% remove the multiples of 'neg_P' array from a 1:M array by...
%  cycle thru each possible value up to M and determine if it is a multiple
%  of any "bad" prime from 'neg_P'
answer = [];
n_answer = 0;
for i = 1:M
    
    not_a_multiple = 0; % assume it isn't a multiple
    
    for j = 1:length(neg_P) % check against each bad prime
        if(mod(i,neg_P(j)) == 0) % check if divisible by a neg_P item
            % if it is then mark it and leave the check
            not_a_multiple = 1;
            break
        end
    end
    
    % save it to answer array if it was not marked
    if(not_a_multiple == 0)
        n_answer = n_answer + 1;
        %answer = [answer i];
    end
    
end

% answer is the length of answer array, saved to text file
%length(answer)
fprintf('answer found! %d\n', n_answer)
toc

if(challenge == 0)
    % check answer to input.out file
    file_name = strcat('data/prime-test', test_num, '.out');
    f = fopen(file_name,'r');
    
    % open and compare to txt file
    if(fscanf(f, '%d', 1) == length(answer))
        disp('correct answer!')
    else
        disp('incorrect answer!')
    end
    
    % close output file
    fclose(f);
else
    % write answer to challenge.out file
    f = fopen('data/prime-challenge.out','w');
    
    % write answer
    %fprintf(f, '%d', length(answer));
    fprintf(f, '%d', n_answer);
    
    % close output file
    fclose(f);
end


