%_________________________________________________________________________%
%  Grasshopper Optimization Algorithm (GOA) source codes demo V1.0        %
%                                                                         %
%  Developed in MATLAB R2016a                                             %
%                                                                         %
%  Author and programmer: Seyedali Mirjalili                              %
%                                                                         %
%         e-Mail: ali.mirjalili@gmail.com                                 %
%                 seyedali.mirjalili@griffithuni.edu.au                   %
%                                                                         %
%       Homepage: http://www.alimirjalili.com                             %
%                                                                         %
%  Main paper: S. Saremi, S. Mirjalili, A. Lewis                          %
%              Grasshopper Optimisation Algorithm: Theory and Application %
%               Advances in Engineering Software , in press,              %
%               DOI: http://dx.doi.org/10.1016/j.advengsoft.2017.01.004   %
%                                                                         %
%_________________________________________________________________________%

% This function draw the benchmark functions

function [x,y,f]=func_plot(F_index)

if F_index<30
    
[lb,ub,dim,bestStar]=test_functions_range(F_index);
fobj=@test_functions;

elseif F_index>29 && F_index<=38
    
    Function_name=strcat('cec0',num2str(F_index-29));
    [dim,fobj,ub, lb]  = Select_Functions(Function_name);
    dim=2;
elseif F_index>38
    
    Function_name=strcat('cec',num2str(F_index-29));
    [dim,fobj,ub, lb]  = Select_Functions(Function_name);
    dim=2;
end


switch F_index
    case 1
        x=-100:2:100; y=x; %[-100,100]
        
    case 2
        x=-100:2:100; y=x; %[-10,10]
        
    case 3
        x=-100:2:100; y=x; %[-100,100]
        
    case 4
        x=-100:2:100; y=x; %[-100,100]
    case 5
        x=-200:2:200; y=x; %[-5,5]
    case 6
        x=-100:2:100; y=x; %[-100,100]
    case 7
        x=-1:0.03:1;  y=x  %[-1,1]
    case 8
        x=-500:10:500;y=x; %[-500,500]
    case 9
        x=-5:0.1:5;   y=x; %[-5,5]
    case 10
        x=-20:0.5:20; y=x;%[-500,500]
    case 11
        x=-500:10:500; y=x;%[-0.5,0.5]
    case 12
        x=-10:0.1:10; y=x;%[-pi,pi]
    case 13
        x=-5:0.08:5; y=x;%[-3,1]
    case 14
        x=-100:2:100; y=x;%[-100,100]
    case 15
        x=-5:0.1:5; y=x;%[-5,5]
    case 16
        x=-1:0.01:1; y=x;%[-5,5]
    case 17
        x=-5:0.1:5; y=x;%[-5,5]
    case 18
        x=-5:0.06:5; y=x;%[-5,5]
    case 19
        x=-5:0.1:5; y=x;%[-5,5]
    case 20
        x=-5:0.1:5; y=x;%[-5,5]
    case 21
        x=-5:0.1:5; y=x;%[-5,5]
    case 22
        x=-5:0.1:5; y=x;%[-5,5]
    case 23
        x=-5:0.1:5; y=x;%[-5,5]
    case 24
        x=-5:0.1:5; y=x;%[-5,5]
    case 25
        x=-5:0.1:5; y=x;%[-5,5]
    case 26
        x=-5:0.1:5; y=x;%[-5,5]
    case 27
        x=-5:0.1:5; y=x;%[-5,5]
    case 28
        x=-5:0.1:5; y=x;%[-5,5]
    case 29
        x=-5:0.1:5; y=x;%[-5,5]
    case 30
        x=-5:0.1:5; y=x;%[-5,5]
    case 31
        x=-5:0.1:5; y=x;%[-5,5]
    case 32
        x=-5:0.1:5; y=x;%[-5,5]
    case 33
        x=-5:0.1:5; y=x;%[-5,5]
    case 34
        x=-5:0.1:5; y=x;%[-5,5]
    case 35
        x=-5:0.1:5; y=x;%[-5,5]
    case 36
        x=-5:0.1:5; y=x;%[-5,5]
    case 37
        x=-5:0.1:5; y=x;%[-5,5]
    case 38
        x=-5:0.1:5; y=x;%[-5,5]
    case 39
        x=-5:0.1:5; y=x;%[-5,5] 
end

L=length(x);
f=[];

for i=1:L
    for j=1:L
        if F_index ~= 15 && F_index~=19 && F_index~=20 && F_index~=21 && F_index~=22 && F_index~=23 && F_index<30
            f(i,j)=fobj([x(i),y(j)],F_index,dim);
        end
        if F_index>=30
            f(i,j)=fobj([x(i),y(j)]);
        end
        if F_index==19
            f(i,j)=fobj([x(i),y(j),0],F_index,dim);
        end
        if F_index==20
            f(i,j)=fobj([x(i),y(j),0,0,0,0],F_index,dim);
        end
        if F_index==21 || F_index==22 ||F_index==23
            f(i,j)=fobj([x(i),y(j),0,0],F_index,dim);
        end
    end
end

surfc(x,y,f,'LineStyle','none');


end

