% This code just simply run the SVM on the example data set "heart_scale",
% which is scaled properly. The code divides the data into 2 parts
% train: 1 to 200
% test: 201:270
% Then plot the results vs their true class. In order to visualize the high
% dimensional data, we apply MDS to the 13D data and reduce the dimension
% to 2D

clear
clc
close all
load('EURUSDM15.mat');
x1 = 8; x2 = 10;
['x1 ' tits{x1} ' -  x2 ' tits{x2}]

x = MQL(:, [x1,x2]);        % Stochastic Main, RSI
y1 = sign(MQL(:,5));        % costf L
y = double(y1 == movmax(y1, 20));
% N = floor(length(y) / 2);
% read the data set
heart_scale_label = y(1:1000);
heart_scale_inst = x(1:1000,:);
[N, D] = size(heart_scale_inst);
N=500;

% Determine the train and test index
trainIndex = zeros(N,1); trainIndex(1:N) = 1;
testIndex = zeros(N,1); testIndex(N+1:2*N) = 1;
trainData = heart_scale_inst(trainIndex==1,:);
trainLabel = heart_scale_label(trainIndex==1,:);
testData = heart_scale_inst(testIndex==1,:);
testLabel = heart_scale_label(testIndex==1,:);

% ###################################################################
% From here on, we do 3-fold cross validation on the train data set
% ###################################################################

% ###################################################################
% cross validation scale 1
% This is the big scale (rough)
% ###################################################################
stepSize = 1;
log2c_list = -20:stepSize:20;
log2g_list = -20:stepSize:20;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 0;
for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        % -v 3 --> 3-fold cross validation
        param = ['-q -v 3 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(trainLabel, trainData, param);
        cvMatrix(i,j) = cv;
        if (cv >= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end

disp(['CV scale1: best log2c:',num2str(bestLog2c),' best log2g:',num2str(bestLog2g),' accuracy:',num2str(bestcv),'%']);

% Plot the results
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick',1:numLog2g)
set(gca,'XTickLabel',sprintf('%3.1f|',log2g_list))
xlabel('Log_2\gamma');
set(gca,'YTick',1:numLog2c)
set(gca,'YTickLabel',sprintf('%3.1f|',log2c_list))
ylabel('Log_2c');


% ###################################################################
% cross validation scale 2
% This is the medium scale
% ###################################################################
prevStepSize = stepSize;
stepSize = prevStepSize/2;
log2c_list = bestLog2c-prevStepSize:stepSize:bestLog2c+prevStepSize;
log2g_list = bestLog2g-prevStepSize:stepSize:bestLog2g+prevStepSize;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 0;
for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        % -v 3 --> 3-fold cross validation
        param = ['-q -v 3 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(trainLabel, trainData, param);
        cvMatrix(i,j) = cv;
        if (cv >= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end

disp(['CV scale2: best log2c:',num2str(bestLog2c),' best log2g:',num2str(bestLog2g),' accuracy:',num2str(bestcv),'%']);

% Plot the results
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick',1:numLog2g)
set(gca,'XTickLabel',sprintf('%3.1f|',log2g_list))
xlabel('Log_2\gamma');
set(gca,'YTick',1:numLog2c)
set(gca,'YTickLabel',sprintf('%3.1f|',log2c_list))
ylabel('Log_2c');



% ###################################################################
% cross validation scale 3
% This is the small scale
% ###################################################################
prevStepSize = stepSize;
stepSize = prevStepSize/2;
log2c_list = bestLog2c-prevStepSize:stepSize:bestLog2c+prevStepSize;
log2g_list = bestLog2g-prevStepSize:stepSize:bestLog2g+prevStepSize;

numLog2c = length(log2c_list);
numLog2g = length(log2g_list);
cvMatrix = zeros(numLog2c,numLog2g);
bestcv = 0;
for i = 1:numLog2c
    log2c = log2c_list(i);
    for j = 1:numLog2g
        log2g = log2g_list(j);
        % -v 3 --> 3-fold cross validation
        param = ['-q -v 3 -c ', num2str(2^log2c), ' -g ', num2str(2^log2g)];
        cv = svmtrain(trainLabel, trainData, param);
        cvMatrix(i,j) = cv;
        if (cv >= bestcv),
            bestcv = cv; bestLog2c = log2c; bestLog2g = log2g;
        end
        % fprintf('%g %g %g (best c=%g, g=%g, rate=%g)\n', log2c, log2g, cv, bestc, bestg, bestcv);
    end
end

disp(['CV scale3: best log2c:',num2str(bestLog2c),' best log2g:',num2str(bestLog2g),' accuracy:',num2str(bestcv),'%']);

% Plot the results
figure;
imagesc(cvMatrix); colormap('jet'); colorbar;
set(gca,'XTick',1:numLog2g)
set(gca,'XTickLabel',sprintf('%3.1f|',log2g_list))
xlabel('Log_2\gamma');
set(gca,'YTick',1:numLog2c)
set(gca,'YTickLabel',sprintf('%3.1f|',log2c_list))
ylabel('Log_2c');

% ################################################################
% Test phase
% Use the parameters to classify the test set
% ################################################################
param = ['-q -c ', num2str(2^bestLog2c), ' -g ', num2str(2^bestLog2g), ' -b 1']
bestModel = svmtrain(testLabel, testData, param);
[predict_label, accuracy, prob_values] = svmpredict(testLabel, testData, bestModel, '-b 1'); % test the training data


