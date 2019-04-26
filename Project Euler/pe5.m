
% Project Euler prob 5


%{

2520 is the smallest number that can be divided by each of the numbers from 1 to 10 without any remainder.

What is the smallest positive number that is evenly divisible by all of the numbers from 1 to 20?

%}
tic;

N = 1e4;

% divisors
range = [3 4 5 6 7 8 9];%11 13 15 17 19];


for i = 10:2:N
    
    count = 0;
    if(mod(i,2) == 0) % evens only
        
        for j = 1:4
            if(mod(i,range(j)) == 0)
                count = count + 1;
                if(count == 4)
                    ans = i
                    break;
                end
                
            else
                break;
            end
            
        end
        
    end
    
end

toc;