lb = [20 20 1 20];        % lower bound
ub = [40 40 2 25];        % upper bound
n = 100;                          % number of samples
p = 4;                          % number of parameters
xn = lhsdesign(n,p,'criterion','correlation','iterations',5000);            % generate normalized design
x = bsxfun(@plus,lb,bsxfun(@times,xn,(ub-lb)))
filename='lhs_data_samples1.xlsx';
writematrix(x,filename);
% clear all; 
% clc; 
% close all; 
% T=readmatrix('lhs_data.xlsx');
% opts = detectImportOptions('lhs_data.xlsx');
% M = readmatrix('lhs_data.xlsx',opts);
% l=M(:,1)
% w=M(:,2)
% fm=M(:,3)
% fl=M(:,4)