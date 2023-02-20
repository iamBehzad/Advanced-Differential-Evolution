function f=SIS_novel_func(x,func_num)
% SIS novel composition functions
% Including six composition functions
% f=SIS_novel_func(x,func_num)
% func_num: 1:6
% reference:
% J. J. Liang, P. N. Suganthan and K. Deb, "Novel Composition Test Functions for Numerical Global Optimization", submitted to IEEE International Swarm Intelligence Symposium, 2005.

global initial_flag
persistent fhd f_bias
[ps,D]=size(x);
if D==1
    x=x';
end
if initial_flag==0
    
    if func_num==1 fhd=str2func('com_func1'); %[-5,5]
    elseif func_num==2 fhd=str2func('com_func2'); %[-5,5]
    elseif func_num==3 fhd=str2func('com_func3'); %[-5,5]
    elseif func_num==4 fhd=str2func('hybrid_func1'); %[-5,5]
    elseif func_num==5 fhd=str2func('hybrid_func2'); %[-5,5]
    elseif func_num==6 fhd=str2func('hybrid_func3'); %[-5,5]
    end
end

f=feval(fhd,x);
%---------------------------------------------------
%   1.com Composition Function 1
function fit=com_func1(x)
global initial_flag
persistent  fun_num func o sigma lamda bias M
if initial_flag==0
    [ps,D]=size(x);
    initial_flag=1;
    fun_num=10;
    load SIS\com_func1_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=zeros(1,D);
    func.f1=str2func('fsphere');
    func.f2=str2func('fsphere');
    func.f3=str2func('fsphere');
    func.f4=str2func('fsphere');
    func.f5=str2func('fsphere');
    func.f6=str2func('fsphere');
    func.f7=str2func('fsphere');
    func.f8=str2func('fsphere');
    func.f9=str2func('fsphere');
    func.f10=str2func('fsphere');
    bias=((1:fun_num)-1).*100;
    sigma=ones(1,fun_num);
    lamda=5/100.*ones(fun_num,1);
    lamda=repmat(lamda,1,D);
    for i=1:fun_num
        eval(['M.M' int2str(i) '=diag(ones(1,D));']);
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);

%---------------------------------------------------
%   2.com Composition Function 2
function fit=com_func2(x)
global initial_flag
persistent  fun_num func o sigma lamda bias M
if initial_flag==0
    [ps,D]=size(x);
    initial_flag=1;
    fun_num=10;
    load SIS\com_func2_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=zeros(1,D);
    func.f1=str2func('fgriewank');
    func.f2=str2func('fgriewank');
    func.f3=str2func('fgriewank');
    func.f4=str2func('fgriewank');
    func.f5=str2func('fgriewank');
    func.f6=str2func('fgriewank');
    func.f7=str2func('fgriewank');
    func.f8=str2func('fgriewank');
    func.f9=str2func('fgriewank');
    func.f10=str2func('fgriewank');
    bias=((1:fun_num)-1).*100;
    sigma=ones(1,fun_num);
    lamda=5/100.*ones(fun_num,1);
    lamda=repmat(lamda,1,D);
    if D==10
        load SIS\com_func2_M_D10,
    else
        for i=1:fun_num
            eval(['M.M' int2str(i) '=orthm_generator(D);']);
        end
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);

%---------------------------------------------------
%   3.com Composition Function 3
function fit=com_func3(x)
global initial_flag
persistent  fun_num func o sigma lamda bias M
if initial_flag==0
    [ps,D]=size(x);
    initial_flag=1;
    fun_num=10;
    load SIS\com_func3_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=zeros(1,D);
    func.f1=str2func('frastrigin');
    func.f2=str2func('frastrigin');
    func.f3=str2func('frastrigin');
    func.f4=str2func('frastrigin');
    func.f5=str2func('frastrigin');
    func.f6=str2func('frastrigin');
    func.f7=str2func('frastrigin');
    func.f8=str2func('frastrigin');
    func.f9=str2func('frastrigin');
    func.f10=str2func('frastrigin');
    bias=((1:fun_num)-1).*100;
    sigma=ones(1,fun_num);
    lamda=ones(fun_num,1);
    lamda=repmat(lamda,1,D);
    if D==10
        load SIS\com_func3_M_D10,
    else
        for i=1:fun_num
            eval(['M.M' int2str(i) '=orthm_generator(D);']);
        end
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);


%----------------------------------------------------------------
%   4.	Rotated Hybrid Composition Function 1
function fit=hybrid_func1(x)
global initial_flag
persistent  fun_num func o sigma lamda bias M
if initial_flag==0
    [ps,D]=size(x);
    initial_flag=1;
    fun_num=10;
    load SIS\hybrid_func1_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=0;
    func.f1=str2func('fackley');
    func.f2=str2func('fackley');
    func.f3=str2func('frastrigin');
    func.f4=str2func('frastrigin');
    func.f5=str2func('fweierstrass');
    func.f6=str2func('fweierstrass');
    func.f7=str2func('fgriewank');
    func.f8=str2func('fgriewank');
    func.f9=str2func('fsphere');
    func.f10=str2func('fsphere');
    bias=((1:fun_num)-1).*100;
    sigma=ones(1,fun_num);
    lamda=[5/32; 5/32; 1; 1; 10; 10; 5/100; 5/100;  5/100; 5/100];
    lamda=repmat(lamda,1,D);
    if D==10
        load SIS\hybrid_func1_M_D10,
    else
        for i=1:fun_num
            eval(['M.M' int2str(i) '=orthm_generator(D);']);
        end
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%----------------------------------------------------------------
%   5.Rotated Hybrid Composition Function 2
function fit=hybrid_func2(x)
global initial_flag
persistent  fun_num func o sigma lamda bias M
if initial_flag==0
    [ps,D]=size(x);
    initial_flag=1;
    fun_num=10;
    load SIS\hybrid_func2_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=zeros(1,D);
    func.f1=str2func('frastrigin');
    func.f2=str2func('frastrigin');
    func.f3=str2func('fweierstrass');
    func.f4=str2func('fweierstrass');
    func.f5=str2func('fgriewank');
    func.f6=str2func('fgriewank');
    func.f7=str2func('fackley');
    func.f8=str2func('fackley');
    func.f9=str2func('fsphere');
    func.f10=str2func('fsphere');
    bias=((1:fun_num)-1).*100;
    sigma=ones(1,fun_num);
    lamda=[1/5;1/5;10;10;5/100;5/100;5/32;5/32;5/100;5/100];
    lamda=repmat(lamda,1,D);
    if D==10
        load SIS\hybrid_func2_M_D10,
    else
        for i=1:fun_num
            eval(['M.M' int2str(i) '=orthm_generator(D);']);
        end
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);
%---------------------------------------------------------------------
%   6.	Rotated Hybrid Composition Function 3
function fit=hybrid_func3(x)
global initial_flag
persistent  fun_num func o sigma lamda bias M
if initial_flag==0
    [ps,D]=size(x);
    initial_flag=1;
    fun_num=10;
    load SIS\hybrid_func2_data % saved the predefined optima
    if length(o(1,:))>=D
        o=o(:,1:D);
    else
        o=-5+10*rand(fun_num,D);
    end
    o(10,:)=0;
    func.f1=str2func('frastrigin');
    func.f2=str2func('frastrigin');
    func.f3=str2func('fweierstrass');
    func.f4=str2func('fweierstrass');
    func.f5=str2func('fgriewank');
    func.f6=str2func('fgriewank');
    func.f7=str2func('fackley');
    func.f8=str2func('fackley');
    func.f9=str2func('fsphere');
    func.f10=str2func('fsphere');
    bias=((1:fun_num)-1).*100;
    sigma=[0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1];
    lamda=[1/5;1/5;10;10;5/100;5/100;5/32;5/32;5/100;5/100];lamda=lamda.*sigma';
    %     a=[0.1 * 1 / 5 , 0.2 * 1 / 5 , 0.3 * 5 / 0.5 , 0.4 * 5 / 0.5 , 0.5 * 5 / 100 ,0.6 * 5 / 100 , 0.7 * 5 / 32 , 0.8 * 5 / 32 , 0.9 * 5 / 100 , 1 * 5 / 100];
    lamda=repmat(lamda,1,D);
    if D==10
        load SIS\hybrid_func2_M_D10,
    else
        for i=1:fun_num
            eval(['M.M' int2str(i) '=orthm_generator(D);']);
        end
    end
end
fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M);

%----------------------------------
function fit=hybrid_composition_func(x,fun_num,func,o,sigma,lamda,bias,M)
[ps,D]=size(x);
for i=1:fun_num
    oo=repmat(o(i,:),ps,1);
    
    weight(:,i)=exp(-sum((x-oo).^2,2)./2./(D*sigma(i)^2));
end

[tmp,tmpid]=sort(weight,2);
for i=1:ps
    weight(i,:)=(weight(i,:)==tmp(i,fun_num)).*weight(i,:)+(weight(i,:)~=tmp(i,fun_num)).*(weight(i,:).*(1-tmp(i,fun_num).^10));
end
weight=weight./repmat(sum(weight,2),1,fun_num);

fit=0;
for i=1:fun_num
    oo=repmat(o(i,:),ps,1);
    x1=5*ones(1,D);
    
    switch(i)
        case 1
            f=func.f1(((x-oo)./repmat(lamda(i,:),ps,1))*M.M1 , ps ,D);
              f1=func.f1((x1./lamda(i,:))*M.M1 , ps ,D);
        case 2
            f=func.f2(((x-oo)./repmat(lamda(i,:),ps,1))*M.M2 , ps ,D);
              f1=func.f2((x1./lamda(i,:))*M.M2 , ps ,D);
        case 3
            f=func.f3(((x-oo)./repmat(lamda(i,:),ps,1))*M.M3 , ps ,D);
              f1=func.f3((x1./lamda(i,:))*M.M3 , ps ,D);
        case 4
            f=func.f4(((x-oo)./repmat(lamda(i,:),ps,1))*M.M4 , ps ,D);
              f1=func.f4((x1./lamda(i,:))*M.M4 , ps ,D);
        case 5
            f=func.f5(((x-oo)./repmat(lamda(i,:),ps,1))*M.M5 , ps ,D);
              f1=func.f5((x1./lamda(i,:))*M.M5 , ps ,D);
        case 6
            f=func.f6(((x-oo)./repmat(lamda(i,:),ps,1))*M.M6 , ps ,D);
              f1=func.f6((x1./lamda(i,:))*M.M6 , ps ,D);
        case 7
            f=func.f7(((x-oo)./repmat(lamda(i,:),ps,1))*M.M7 , ps ,D);
              f1=func.f7((x1./lamda(i,:))*M.M7 , ps ,D);
        case 8
            f=func.f8(((x-oo)./repmat(lamda(i,:),ps,1))*M.M8 , ps ,D);
              f1=func.f8((x1./lamda(i,:))*M.M8 , ps ,D);
        case 9
            f=func.f9(((x-oo)./repmat(lamda(i,:),ps,1))*M.M9 , ps ,D);
            f1=func.f9((x1./lamda(i,:))*M.M9 , ps ,D);
        case 10
            f=func.f10(((x-oo)./repmat(lamda(i,:),ps,1))*M.M10 , ps ,D);
           f1=func.f10((x1./lamda(i,:))*M.M10 , ps ,D);
        otherwise
            psch=num2str(ps);
            Dch=num2str(D);
            gg=int2str(i);
            eval(['f=feval(func.f' gg  ',((x-oo)./repmat(lamda(i,:),ps,1))*M.M' gg ',' psch ',' Dch ');']);
            eval(['f1=feval(func.f' gg ',(x1./lamda(i,:))*M.M' gg ',' psch ',' Dch ');']);

    end
     
    
    fit1=2000.*f./f1;
    fit=fit+weight(:,i).*(fit1+bias(i));
end
%-------------------------------------------------
%basic functions

function f=fsphere(x,ps,D)
%Please notice there is no use to rotate a sphere function, with rotation
%here just for a similar structure as other functions and easy programming
%[ps,D]=size(x);
f=sum(x.^2,2);
%--------------------------------
function f=fsphere_noise(x,ps,D)
%[ps,D]=size(x);
f=sum(x.^2,2).*(1+0.1.*normrnd(0,1,ps,1));
%--------------------------------
function f=fgriewank(x,ps,D)
%[ps,D]=size(x);
f=1;
for i=1:D
    f=f.*cos(x(:,i)./sqrt(i));
end
f=sum(x.^2,2)./4000-f+1;
%--------------------------------
function f=fackley(x,ps,D)
%[ps,D]=size(x);
f=sum(x.^2,2);
f=20-20.*exp(-0.2.*sqrt(f./D))-exp(sum(cos(2.*pi.*x),2)./D)+exp(1);
%--------------------------------
function f=frastrigin(x,ps,D)
%[ps,D]=size(x);
f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);
%--------------------------------
function f=frastrigin_noncont(x,ps,D)
%[ps,D]=size(x);
x=(abs(x)<0.5).*x+(abs(x)>=0.5).*(round(x.*2)./2);
f=sum(x.^2-10.*cos(2.*pi.*x)+10,2);
%--------------------------------
function [f]=fweierstrass(x,ps,D)
%[ps,D]=size(x);
x=x+0.5;
a = 0.5;
b = 3;
kmax = 20;
c1(1:kmax+1) = a.^(0:kmax);
c2(1:kmax+1) = 2*pi*b.^(0:kmax);
f=0;
c=-w(0.5,c1,c2);
for i=1:D
    f=f+w(x(:,i)',c1,c2);
end
f=f+c*D;

function y = w(x,c1,c2)
y = zeros(length(x),1);
for k = 1:length(x)
    y(k) = sum(c1 .* cos(c2.*x(:,k)));
end
%--------------------------------
function f=fE_ScafferF6(x,ps,D)
fhd=str2func('ScafferF6');
%[ps,D]=size(x);

f=0;
for i=1:(D-1)
    f=f+feval(fhd,(x(:,i:i+1)));
end
f=f+feval(fhd,x(:,[D,1]));
%--------------------------------
function f=fE_ScafferF6_noncont(x,ps,D)
fhd=str2func('ScafferF6');
%[ps,D]=size(x);
x=(abs(x)<0.5).*x+(abs(x)>=0.5).*(round(x.*2)./2);
f=0;
for i=1:(D-1)
    f=f+feval(fhd,(x(:,i:i+1)));
end
f=f+feval(fhd,x(:,[D,1]));
%------------------------------
function f=fEF8F2(x,ps,D)
%[ps,D]=size(x);
f=0;
for i=1:(D-1)
    f=f+F8F2(x(:,[i,i+1]));
end
f=f+F8F2(x(:,[D,1]));

%--------------------------------
function f=fschwefel_102(x,ps,D)
%[ps,D]=size(x);
f=0;
for i=1:D
    f=f+sum(x(:,1:i),2).^2;
end
%--------------------------------
function f=felliptic(x,ps,D)
%[ps,D]=size(x);
a=1e+6;
f=0;
for i=1:D
    f=f+a.^((i-1)/(D-1)).*x(:,i).^2;
end
%--------------------------------
function f=F8F2(x,ps,D)
f2=100.*(x(:,1).^2-x(:,2)).^2+(1-x(:,1)).^2;
f=1+f2.^2./4000-cos(f2);

function f=ScafferF6(x)
f=0.5+(sin(sqrt(x(:,1).^2+x(:,2).^2)).^2-0.5)./(1+0.001*(x(:,1).^2+x(:,2).^2)).^2;


% classical Gram Schmid
function [q,r] = cGram_Schmidt (A)
% computes the QR factorization of $A$ via
% classical Gram Schmid
%
[n,m] = size(A);
q = A;
for j=1:m
    for i=1:j-1
        r(i,j) = q(:,j)'*q(:,i);
    end
    for i=1:j-1
        q(:,j) = q(:,j) -  r(i,j)*q(:,i);
    end
    t =  norm(q(:,j),2 ) ;
    q(:,j) = q(:,j) / t ;
    r(j,j) = t  ;
end

function M=rot_matrix(D,c)
A=normrnd(0,1,D,D);
P=cGram_Schmidt(A);
A=normrnd(0,1,D,D);
Q=cGram_Schmidt(A);
u=rand(1,D);
D=c.^((u-min(u))./(max(u)-min(u)));
D=diag(D);
M=P*D*Q;

function M=orthm_generator(D1)
pi=3.14159;
M=diag(ones(1,D1));
for j=1:D1%*D
    R1=diag(ones(1,D1));
    x=pi/2.*rand;angel=[cos(x) -sin(x);sin(x) cos(x)];
    rc=randperm(D1);row=rc(1:2);
    R1(row(1),row(1))=angel(1,1);
    R1(row(1),row(2))=angel(1,2);
    R1(row(2),row(1))=angel(2,1);
    R1(row(2),row(2))=angel(2,2);
    M=M*R1;
end
