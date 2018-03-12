function p = peak(f,t,N)
n = length(f);
x = 1:n;
fp = [ f(1); f; f(n) ];
p = (fp(x+1) > fp(x)) & (fp(x+1) > fp(x+2));
p = find((f .* p) > t);
pd = find(diff(p) < N);
while numel(pd)
pd = p([pd pd+1]);
[~, i] = min(f(pd), [], 2);
n = length(i);
x = 1:n;
p = setdiff(p,pd(n*(i-1)+x'));
pd = find(diff(p) < N);
%size(pd)
end
end
