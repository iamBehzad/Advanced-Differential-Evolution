clear
close all
clc

format long
global NFE maxFEs bestStar;

N=30; % Number of solutions in each iteration
MaxIt=500;% Maximum Number of Iterations

NameFunctions=strings([1 29]);

F_index=1;% F1:F29--> 1:29
Function_name=strcat('F',num2str(F_index));
NameFunctions(F_index) =  Function_name;
DisplayResults=0;
    
if F_index>=24 &&F_index<=29 %composite functions
    global initial_flag
    initial_flag=0;
    clear fun_num func o sigma lamda bias M
end
    
[lb,ub,dim,bestStar]=test_functions_range(F_index);
fobj=@test_functions;
maxFEs=dim*1000; % Maximum number of fitness evaluations

NFE=0;
[Convergence_curve,FEs_counts,Fbest,Trajectories, fitness_history, position_history ]=ADE(F_index,N,fobj, lb, ub , dim, MaxIt);
ADE_NFE=NFE;

if F_index>=24 &&F_index<=29 %composite functions
    global initial_flag
    initial_flag=0;
    clear fun_num func o sigma lamda bias M
end

figure('Position',[454   445   894   297])
%Draw search space
subplot(1,5,1);
% [x,y,f]=func_plot(Function_name);
[x,y,f]=func_plot(F_index);

title('Parameter space')
xlabel('x_1');
ylabel('x_2');
zlabel([F_index,'( x_1 , x_2 )'])
box on
axis tight

subplot(1,5,2);
hold on
contour(x,y,f);
for k1 = 1: size(position_history,1)
    for k2 = 1: size(position_history,2)
        plot(position_history(k1,k2,1),position_history(k1,k2,2),'.','markersize',1,'MarkerEdgeColor','k','markerfacecolor','k');
    end
end
plot(Fbest.Position(1),Fbest.Position(2),'.','markersize',10,'MarkerEdgeColor','r','markerfacecolor','r');
title('Search history (x1 and x2 only)')
xlabel('x1')
ylabel('x2')
box on
axis tight

subplot(1,5,3);
hold on
plot(Trajectories(1,:));
title('Trajectory of 1st agent')
xlabel('Iteration#')
box on
axis tight

subplot(1,5,4);
hold on
plot(mean(fitness_history),'MarkerSize',30);
title('Average fitness of all agents')
xlabel('Iteration#')
box on
axis tight

%Draw objective space
subplot(1,5,5);
semilogy(Convergence_curve,'Color','r','MarkerSize',30)
title('Convergence curve')
xlabel('Iteration#');
ylabel('Best score obtained so far');
box on
axis tight
set(gcf, 'position' , [39         479        1727         267]);

display(['The best solution obtained by ADE is : ', num2str(Fbest.Position)]);
display(['The best optimal value of the objective funciton found by ADE is : ', num2str(Fbest.Cost)]);


