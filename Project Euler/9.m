% Project Euler problem 9


%{

A Pythagorean triplet is a set of three natural numbers, a < b < c, for
 which, a^2 + b^2 = c^2

For example, 3^2 + 4^2 = 9 + 16 = 25 = 5^2.

There exists exactly one Pythagorean triplet for which a + b + c = 1000.
Find the product abc.

%}

tic;


for c = 1:500
    
    for b = 1:c
        
        for a = 1:b
            
            if(a*a + b*b == c*c) % is pythag triple
                if(a+b+c == 1000)
                    fprintf("a = %d \n", a);
                    fprintf("b = %d \n", b);
                    fprintf("c = %d \n", c);
                    fprintf("abc = %d \n", a*b*c);
                end
            end
            
        end
        
    end
    
end


toc;
