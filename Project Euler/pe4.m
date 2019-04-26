
% Project Euler prob 4


%{
A palindromic number reads the same both ways. The largest palindrome made
from the product of two 2-digit numbers is 9009 = 91 × 99.

Find the largest palindrome made from the product of two 3-digit numbers.
%}

N = 991;

x = linspace(9, 999, N);

palindromes = zeros();
p = 1;

% get the product of two numbers
for i = 1:N
    
    for j = 1:N
        
        prod = x(i) * x(j);
        
        % is prod palindromic?
        str_prod = int2str(prod);
        
        len = strlength(str_prod);

        for k = 1:len
            if(str_prod(k) == str_prod(len+1-k))
                if(k == len/2)
                    %disp(str_prod)
                    palindromes(p) = prod;
                    p = p + 1;
                end
                
                continue;
                
            else
                break;
            end
        end

    end
    
end

ans = 0;
for i = 1:p-1
    
    if(palindromes(i) > ans)
        ans = palindromes(i);
    end
    
end

ans
