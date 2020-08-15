% did not configure wrt jian.. general code
% Spill1 = importdata('data_Ls=1Ws=1P=15.txt');
% Spill=Spill1.data
% T = Spill(:,1);
% C = Spill(:,2);
% plot(T,C)
% xlabel('Time / Days');
% ylabel('Concentration / ppb')
clear all; 
clc;
close all; 
T=readmatrix('lhs_data.xlsx');
opts = detectImportOptions('lhs_data.xlsx');
M = readmatrix('lhs_data.xlsx',opts);
l=M(:,1);
w=M(:,2);
fm=M(:,3);

fl=M(:,4);
cst = actxserver('CSTStudio.Application');
mws = cst.invoke('NewMWS');
mws.invoke('OpenFile','C:\WORK\Mini Project\CST_Files\final_microstrip.cst');
solv = mws.invoke('Solver');
export = mws.invoke('ASCIIExport');
plot1d = mws.invoke('Plot1D');
f_cell = cell(2,1);
j=15;
for i=175: 350
    mws.invoke('StoreDoubleParameter','l',l(i));
    mws.invoke('StoreDoubleParameter','w',w(i));
    mws.invoke('StoreDoubleParameter','fm',fm(i));
    mws.invoke('StoreDoubleParameter','fl',fl(i));
    mws.invoke('Rebuild');
    solv.invoke('Start');
    solv.invoke('Start');
    str_y = num2str(i);
    f_name = strcat('C:\WORK\Mini Project\CST_Files\data\',str_y,'.txt');
    f_cell(i,1) = {f_name};
    mws.invoke('SelectTreeItem','1D Results\S-Parameters\S1,1');
    plot1d.invoke('PlotView','magnitudedb');
    export.invoke('Reset');
    export.invoke('FileName',f_name);
    export.invoke('Mode','FixedNumber');
    export.invoke('Step','1001');
    export.invoke('Execute');
end