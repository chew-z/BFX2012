function res = movmax(x, k)
% movmax(x, k) - moving forward maximum of x 
	if nargin < 2, k = 5; end
	l = length(x);
	res = zeros(l,1);
	for i=1:l
		window = [i: min(i+k, l)];
		res(i) = max(x(window));
	end
end