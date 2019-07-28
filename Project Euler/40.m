% Project Euler prob 40

%{
Champernowne's constant

An irrational decimal fraction is created by concatenating the positive
 integers:

0.123456789101112131415161718192021...

It can be seen that the 12th digit of the fractional part is 1.

If dn represents the nth digit of the fractional part, find the value of
 the following expression.

d1 × d10 × d100 × d1000 × d10000 × d100000 × d1000000

%}

tic;

% define values: N is arbitrary max limit, breaks before that point.
%                run is the running total of indices
%                indices is the indices the user is asked to save from the
%                 Champernowne's constant.
%                n is an iterator for the indices array.
N = 1e6;
run = 0;
indices = [1 10 101 1001 10001 100001 1000001];
n = 1;

% a is running product answer.
ans = 1;


% the strange inidices (i.e. 1001 instead of 1000) gives the correct answer
% but was initially a typo. I think it relates to the indexing of MATLAB.
% Not a bad idea to redo using a different method.
for i = 1:N
    
    str = num2str(i);
    
    run = run + length(str);
    
    if(run > indices(n))
        tempi = run - indices(n);
        ans = ans*str2double(str(tempi));
        n = n + 1;
    elseif(run == indices(n))
        ans = ans*str2double(str(end));
        n = n + 1;
    end
    
    if(n == 8)
        break;
    end
    
end

ans


toc;