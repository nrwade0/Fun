%{
   IN-PRIME-SHAPE
    Given a set P of primes and a positive integer M, compute the number 
    of P-divisible numbers that are less than or equal to M.
%}

clc
format long g
tic;
cd /Users/nick/Documents/GitHub/projects/Challenge/in-prime-shape

% set run parameters
challenge = 1;
test_num = '2'; % 0 1 or 2


%% ---- INPUT TEXT.IN FILE ---- %%
%    The first line contains the two numbers n and M, separated by a space.
%    This is followed by n lines, each containing a prime number
%    p1, p2, . . . , pn of P . You may assume they are distinct.
if(challenge == 0)
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
    f = fopen('data/prime-challenge.in','r');    % input challenge

    % get variables
    n = fscanf(f, '%d', 1);
    M = fscanf(f, '%d', 1);
    P = fscanf(f, '%d', [1 n]);

    % close file
    fclose(f);
end
fprintf('The `.in` file was sucessfully imported. --- ')
toc
fprintf('\n')


%% ---- DETERMINE NUMBER OF P-DIVISIBLE INTEGERS ---- %%
% Given P = {2, 5, 7} and M = 20, there are 10 P-divisible numbers that 
%  do not exceed 20 (namely, 1, 2, 4, 5, 7, 8, 10, 14, 16, and 20).

% determine the number of integers (each called 'q') that are P-divisible
%  It is said to be P-divisible if q is evenly divisible by no prime number
%  other than the numbers of P.


%%% -- FIRST CALCULATE THE PRIMES UP TO M -- %%%
prime = primes(M);
fprintf('Primes have been calculated up to M = %d --- ', M)
toc
fprintf('\n')


%%% -- CHECK ALL INTEGERS UP TO M FOR P-DIVISIBILITY -- %%%
% remove 'P' from 'p' making a list of bad multiples
%P_diff = setdiff(prime, P); % primes up to M excluding the set P

% remove the multiples of 'neg_P' array from a 1:M array by...
%  cycle thru each possible value up to M and determine if it is a multiple
%  of any "bad" prime from 'neg_P'
n_answer = 1;


% first try - works well, not fast
%{
for q = 2:M
    
    if(mod(q,10000000) == 0)
        fprintf('%d percent completed.\n', q/10000000)
    end
    
    %fprintf('Q = %d\n ', q)
    fact = factor(q);
    f_sum = 0;
    
    %fprintf('checking factor...\n')
    for f_i = 1:length(fact)
        %fprintf('  length(fact) = %d\n', length(fact))
        %fprintf('  %d is in P?  =  %d\n', fact(f_i), ismember(fact(f_i), P)) 
        if(ismember(fact(f_i), P) == 1)
            f_sum = f_sum + 1;
            %fprintf('  f_sum increased\n')
        else
            %fprintf('  not divisible\n')
            break
        end
    end
    
    if(length(fact) == f_sum)
        n_answer = n_answer + 1;
        %fprintf('found one!!! %d\n', q)
    end
    %fprintf('\n')
    %{
    fprintf(repmat('%d \n', 1, length(factor(i))), factor(i));
    fprintf('--- \n');
    %}
end
%}

% second try - not quite correct
%{
for q_i = 1:length(prime)
    
    q = prime(q_i);
    
    %fprintf(' - checking %d... ', q)
    if(ismember(factor(q), P) == 1)
        n_answer = n_answer + 1;
        fprintf('   %d \n', q)
    end
        
end
%}

% third try, "Why are all non-prime numbers divisible by a prime number?"
%{
    Only test non-prime numbers. Break these into their factors and 
    determine if they are made up of P-set numbers exclusively.
%}
%wb = waitbar(0,'PROGRESS');
n_answer = n_answer + length(P); % counts 1 and all the P-set numbers
Qs = setdiff(1:M, primes(M)); % remove all primes to be checked
for q_i = 1:length(Qs)
    
    q = Qs(q_i); % get new integer to be checked, q
    
    %fprintf('Q = %d\n ', q)
    fact = factor(q);
    f_sum = 0;
    
    %fprintf('  checking factor...\n')
    if(ismember(fact, P) == 1)
        %fprintf('   found one = %d\n', q)
        %fact
        n_answer = n_answer + 1;
    end
    %fprintf('\n')
    %waitbar(q_i/M*100,wb)
end
%close(wb)


%%% -- PRINT ANSWER -- %%%
% answer is the length of answer array, saved to text file
%length(answer)
fprintf('An answer has been found! %d. --- ', n_answer)
toc
fprintf('\n')


%% ---- CHECK ANSWER BASED ON .OUT FILES ---- %%
if(challenge == 0)
    % check answer to input.out file
    file_name = strcat('data/prime-test', test_num, '.out');
    f = fopen(file_name,'r');
    
    % open and compare to txt file
    if(fscanf(f, '%d', 1) == n_answer)
        disp('Correct answer!')
    else
        disp('Incorrect answer!')
    end
    
    % close output file
    fclose(f);
else
    % write answer to challenge.out file
    f = fopen('data/prime-challenge.out','w');
    
    % write answer
    %fprintf(f, '%d', length(answer));
    fprintf(f, '%d', n_answer);
    disp('Answer successfully stored in data/prime-challenge.out')
    
    % close output file
    fclose(f);
end


