% Project Euler prob 6


%{

The sum of the squares of the first ten natural numbers is,
1^2 + 2^2 + ... + 10^2 = 385

The square of the sum of the first ten natural numbers is,
(1 + 2 + ... + 10)2 = 552 = 3025

Hence the difference between the sum of the squares of the first ten
 natural numbers and the square of the sum is 3025 ? 385 = 2640.

Find the difference between the sum of the squares of the first one hundred
 natural numbers and the square of the sum.

%}

tic;

N = 100;

sumsq = 0;
sqsum = 0;
sum = 0;

for i = 1:N
    % calculate the sum of the squares
    tempsq = i*i;
    sumsq = sumsq + tempsq;
    
    % calculates the square of the sum
    sum = sum + i;
end

sqsum = sum*sum;

fprintf('Sum of the squares of the first %d terms = %d \n', N, sumsq)
fprintf('Square of the sum of the first %d terms = %d \n', N, sqsum)
fprintf('The difference is = %d \n', sqsum-sumsq)

toc;