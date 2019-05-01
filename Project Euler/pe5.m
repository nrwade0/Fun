% Project Euler problem 5

%{
2520 is the smallest number that can be divided by each of the numbers
 from 1 to 10 without any remainder.
What is the smallest positive number that is evenly divisible by all of 
 the numbers from 1 to 20?
%}

tic;

% Starts at 2520 and increment by 2520
N = 3e9;

% DIVISORS
% Must keep 20 but not 2 or 10 or 5.
% 19, 17, 13, 11 are primes.
% keep 18 and leave out 12 and 6 and 3 and 2.
% 14 can leave out 7 and 2.
range = [11 13 14 16 17 18 19 20];
val = 20;

while (val < 1e10)
    count = 0;
    
    for i = 1:length(range)
        if(mod(val, range(i)) == 0)
            count = count + 1;
        else
            break;
        end
    end
    
    if(count == length(range))
        disp(val)
        break;
    end
    
    val = val + 20;
    
end

toc;
