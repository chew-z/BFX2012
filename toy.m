% this script draws labels and intersecting plane (with different kernels)

clear all
clf
load('EURUSDM15.mat')

% x = randn(100,2);
x = MQL(1:100, [6,8]); 		% Stochastic Main, RSI
% x = [MQL(1:100,18), MQL(1:100,4) > MQL(1:100,11)]; % isTrendingL && Close(0) > HC

% y = double(sum(x,2) > 0);
y1 = sign(MQL(1:100,5));		% costf L
y = double(y1 == movmax(y1, 20));
for c = 0
	for g = -2:2
		param = ['-q -c ', num2str(10^c), ' -g ', num2str(10^g)];
		svmtoy(y, x, param)
	end
end

clear c g param y1 
