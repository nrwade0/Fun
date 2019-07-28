% Project Euler prob 7


%{

By listing the first six prime numbers: 2, 3, 5, 7, 11, and 13, we can see
 that the 6th prime is 13.

What is the 10,001st prime number?

%}

% top prime number
N = 1e6;

tic;

% array of prime numbers
primes = zeros();
p = 1;

% cycle through potential candidates (i)
for i = 2:N
    
    % counter for prime candidates
    count = 0;
    
    for j = 2:i-1
        
        % if the candidate is divisible by any value below itself, leave
        if(mod(i,j) == 0)
            break;
        else % otherwise add to the counter
            count = count + 1;
        end
    end
    
    % if the counter is full (no divisors), add to prime list
    if(count == i-2)
        primes(p) = i;
        p = p + 1;
    end
    
    % when the prime array is at 10001, leave
    if(length(primes) == 10001)
        disp('primes list full')
        break;
    end
    
end

disp(primes(10001))

toc;