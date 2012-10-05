clf
% x = randn(100,2);
x = MQL(1:100, [6,8]); 		% Stochastic Main, RSI
% x = [MQL(1:100,18), MQL(1:100,4) > MQL(1:100,11)]; % isTrendingL && Close(0) > HC

% y = double(sum(x,2) > 0);
y1 = sign(MQL(1:100,5));		% costf L
y = double(y1 == movmax(y1, 10));
for c = -2:2
	svmtoy(y, double(x), ['-t 2 -c ' num2str(10^c)])
end
% svmtoy(y, double(x), '-t 1')
% svmtoy(y, double(x), '-t 0')