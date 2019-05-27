function out = givePrime(in)
%Give prime function will yield closest prime for an array, or single
%variables
%
%   Alan Jakub Pawlak - u1561875 07/01/2019
%
    for k = 1:length(in)
        out(k) = singlePrime(in(k));
    end
end

function y = singlePrime(x)
    z = primes(x);
    y = max(z);
end