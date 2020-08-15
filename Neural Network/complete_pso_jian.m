tic
close all 
clear all 
rng default    
gbest = 0.0; 
input = xlsread('inputs_jian.xlsx'); 
target = xlsread('outputs_jian.xlsx');   
inputs=input'; 
targets=target';   
m=length(inputs(:,1)); 
o=length(targets(:,1));   
n=[15,15,15]; net=feedforwardnet(n); 
net=configure(net,inputs,targets); 
kk=15000;%replaced equation
for j=1:kk     
  LB(1,j)=-1.5;     
  UB(1,j)=1.5; 
end 
pop=10; 
for i=1:pop     
    for j=1:kk         
      xx(i,j)=LB(1,j)+rand*(UB(1,j)-LB(1,j));     
    end 
end   
maxrun=1; 
for run=1:maxrun     
    fun=@(x)myfunc(x,n,m,o,net,inputs,targets);
    x0=xx; 
 
% pso initialization----------------------------------------------start   
    x=x0;  % initial population     
    v=0.1*x0;   % initial velocity     
    for i=1:pop         
        f0(i,1)=fun(x0(i,:));
    end     
    [fmin0,index0]=min(f0);     
    pbest=x0;               % initial pbest     
    gbest=x0(index0,:);     % initial gbest     
    % pso initialization------------------------------------------------end 
    % pso algorithm---------------------------------------------------start     
    c1=1.5; 
    c2=2.5;
    ite=1;
    maxite=1000;
    tolerance=1;
    while ite<=maxite && tolerance>10^-8
          w=0.1+rand*0.4;         % pso velocity updates 
          for i=1:pop          
              for j=1:kk
                 v(i,j)=w*v(i,j)+c1*rand*(pbest(i,j)-x(i,j))...  
                          +c2*rand*(gbest(1,j)-x(i,j)); 
              end  
          end           % pso position update         
          for i=1:pop             
              for j=1:kk                 
                  x(i,j)=x(i,j)+v(i,j);   
              end  
          end
          % handling boundary violations
          for i=1:pop      
              for j=1:kk 
                if x(i,j)<LB(j)
                  x(i,j)=LB(j);      
                elseif x(i,j)>UB(j)
                  x(i,j)=UB(j); 
                end          
              end        
          end
          
          % evaluating fitness
          for i=1:pop 
             f(i,1)=fun(x(i,:));    
          end
          
          % updating pbest and fitness
          for i=1:pop      
            if f(i,1)<f0(i,1)    
               pbest(i,:)=x(i,:);
               f0(i,1)=f(i,1);        
            end      
          end     
           
          [fmin,index]=min(f0);   % finding out the best particle 
          ffmin(ite,run)=fmin;    % storing best fitness  
          ffite(run)=ite;         % storing iteration count  
          
          % updating gbest and best fitness  
          
          if fmin<fmin0    
             gbest=pbest(index,:);
             fmin0=fmin;      
          end       
           
          % calculating tolerance 
          if ite>100;       
              tolerance=abs(ffmin(ite-100,run)-fmin0);
          end    
          % displaying iterative results    
          if ite==1      
              disp(sprintf('Iteration    Best particle    Objective fun')); 
          end   
          disp(sprintf('%8g  %8g          %8.4f',ite,index,fmin0));   
          ite=ite+1;     
    end   
    % pso algorithm-----------------------------------------------------end    
    xo=gbest;
    fval=fun(xo);
    xbest(run,:)=xo;
    ybest(run,1)=fun(xo);
    disp(sprintf('****************************************'));
    disp(sprintf('    RUN   fval       ObFuVa'));
    disp(sprintf('%6g %6g %8.4f %8.4f',run,fval,ybest(run,1)));
end
toc   
% Final neural network model 
disp('Final nn model is net_f') 
net_f = feedforwardnet(n); 
net_f=configure(net_f,inputs,targets); 
[a b]=min(ybest); xo=xbest(b,:);
k=0; 
for i=1:n     
  for j=1:m         
    k=k+1;      
    xi(i,j)=xo(k);
  end 
end 
A=k;
for i=1:n 
    for j=1:n  
        for v=1:n
        k=k+1;   
        xl1(i,j)=xo(k);
        end
    end
     xb1(i,1)=xo(A+15);
end 
for i=1:n 
    for j=1:n  
        for v=1:n
        k=k+1;   
        xl2(i,j)=xo(k);
        end
    end
end 
for v=1:n
    k=k+1;
    xb2(i,1)=xo(k+15);
end
for v=1:n
    k=k+1;
    xb3(i,1)=xo(k+15);
end
for i=1:o   
    k=k+1;
    xb4(i,1)=xo(k);
end 
net_f.iw{1,1}=xi; 
net_f.lw{2,1}=xl1;
net_f.lw{3,2}=xl2;
net_f.b{1,1}=xb1; 
net_f.b{2,1}=xb2;
net_f.b{3,1}=xb3;
net_f.b{4,1}=xb4;
%Calculation of MSE 
err=sum((net_f(inputs)-targets).^2)/length(net_f(inputs)) 
%Regression plot 
plotregression(targets,net_f(inputs)) 
 
disp('Trained ANN net_f is ready for the use'); 
%Trained ANN net_f is ready for the use

% % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 
% LB=[0 0 0]; %lower bounds of variables
% UB=[10 10 10]; %upper bounds of variables
% pso parameters values
 LB = [7 26 11 8 6 10 17 2 2 0.5]; %%10 values
UB  = [10 34 14 10 8 14 23 4 4 1.5]; %%%%10 values 
m=10; % number of variables
n=100; % population size
wmax=0.9; % inertia weight
wmin=0.4; % inertia weight
c1=2; % acceleration factor
c2=2; % acceleration factor
% pso main program----------------------------------------------------start
maxite=200; % set maximum number of iteration
maxrun=10; % set maximum number of runs need to be
for run=1:maxrun
run
% pso initialization----------------------------------------------start
x0 = xlsread('lhs_data_jian2019.xlsx');
% for i=1:n
% for j=1:m
% x0(i,j)=round(LB(j)+rand()*(UB(j)-LB(j)));
% end
% end
x=x0 % initial population
v=0.1*x0; % initial velocity
lds = x0';
for i=1:n
of = net_f(lds(:,i));
f = abs(4-of);
f0(i,1)=f;
end
% f0%change this%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[fmin0,index0]=min(f0);
pbest=x0; % initial pbest
gbest=x0(index0,:); % initial gbest
% fmin0%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% pso initialization------------------------------------------------end
% pso algorithm---------------------------------------------------start
ite=1;
tolerance=1;
while ite<=maxite && tolerance>10^-12
w=wmax-(wmax-wmin)*ite/maxite; % update inertial weight
% pso velocity updates
for i=1:n
for j=1:m
v(i,j)=w*v(i,j)+c1*rand()*(pbest(i,j)-x(i,j))...
+c2*rand()*(gbest(1,j)-x(i,j));
end
end
% pso position update
for i=1:n
for j=1:m
x(i,j)=x(i,j)+v(i,j);
end
end
% handling boundary violations
for i=1:n
for j=1:m
if x(i,j)<LB(j)
x(i,j)=LB(j);
elseif x(i,j)>UB(j)
x(i,j)=UB(j);
end
end
end
% evaluating fitness
Z = x';
for i=1:n
of = net_f(Z(:,i));
f = abs(4-of);
f(i,1)=f;
end
% updating pbest and fitness
for i=1:n
if f(i,1)<f0(i,1)
pbest(i,:)=x(i,:);
f0(i,1)=f(i,1);
end
end
[fmin,index]=min(f0); % finding out the best particle
ffmin(ite,run)=fmin; % storing best fitness
ffite(run)=ite; % storing iteration count
% updating gbest and best fitness
% fmin0%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%55
if fmin<fmin0
gbest=pbest(index,:);
fmin0=fmin;
end
% calculating tolerance
if ite>100;
tolerance=abs(ffmin(ite-100,run)-fmin0);
end
% displaying iterative results
if ite==1
disp(sprintf('Iteration Best particle Objective fun'));
end
disp(sprintf('%8g %8g %8.4f',ite,index,fmin0));
ite=ite+1;
end
% pso algorithm-----------------------------------------------------end
gbest;
fvalue=abs(4-net_f(gbest'));
fff(run)=fvalue;
rgbest(run,:)=gbest;
disp(sprintf('--------------------------------------'));
end
% pso main program------------------------------------------------------end
disp(sprintf('\n'));
disp(sprintf('*********************************************************'));
disp(sprintf('Final Results-----------------------------'));
[bestfun,bestrun]=min(fff)
best_variables=rgbest(bestrun,:)
disp(sprintf('*********************************************************'));
toc
% PSO convergence characteristic
plot(ffmin(1:ffite(bestrun),bestrun),'-k');
xlabel('Iteration');
ylabel('Fitness function value');
title('PSO convergence characteristic')
%##########################################################################