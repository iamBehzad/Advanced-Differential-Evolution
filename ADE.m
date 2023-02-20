function  [Convergence_curve , nfe , Fbest, Trajectories, fitness_history, position_history]=ADE(F_index,N,fobj,lb, ub , dim, MaxIt)%
%% Problem Definition

%CostFunction=@(x) Sphere(x);    % Cost Function
global NFE;
global maxFEs bestStar;
nfe=zeros(MaxIt,1);

nVar=dim;            % Number of Decision Variables

VarSize=[1 nVar];   % Decision Variables Matrix Size

VarMin= lb;          % Lower Bound of Decision Variables
VarMax= ub;          % Upper Bound of Decision Variables

%% ADE Parameters
nPop=N;        % Population Size
NPopmin = 4;
NPopinit = 28;
Pop1Size=NPopinit;
Pop2Size=nPop-Pop1Size;

beta_min=0.2;   % Lower Bound of Scaling Factor
beta_max=0.8;   % Upper Bound of Scaling Factor

pCR=0.2;        % Crossover Probability

NumIt=round(maxFEs/nPop);
fitness_history=zeros(nVar,NumIt);
position_history=zeros(nPop,NumIt,nVar);
Trajectories=zeros(nVar,NumIt);
Convergence_curve=zeros(1,NumIt);
%% Initialization

empty_individual.Position=[];
empty_individual.Cost=[];

pop=repmat(empty_individual,nPop,1);
NewSol=empty_individual;
NewSol2=empty_individual;

BestSol1Pop1.Cost=inf;
BestSol2Pop1.Cost=inf;

%% Initialization
mu=4;           %constant in (eq. 1)
pop(1).Position = unifrnd(0, 1, VarSize);
for i = 1:nPop
    % Initialize Solutions
    pop(i+1).Position = mu* pop(i).Position.*(1- pop(i).Position); %(Eq. 1)
end
pop(1)=[];
for i = 1:nPop
    pop(i).Position=mapping(pop(i).Position,dim,VarMax,VarMin);
    % Evaluation
    pop(i).Cost = fobj(pop(i).Position,F_index,dim);
    
    fitness_history(i,1)=pop(i).Cost;
    position_history(i,1,:)=pop(i).Position;
end
    Trajectories(:,1)=pop(1).Position;
% Store Best Solution Ever Found
BestCost=zeros(MaxIt,1);

[~ ,index]= min([pop.Cost]);
BestSol = pop(index);

pop1=pop(1 : Pop1Size);
pop2=pop(Pop1Size + 1 : end);


%% ADE Main Loop
for it=1:MaxIt
    if BestSol.Cost==bestStar
        break;
    end
    % Population Reduction
    Pop1Size=round((((NPopmin-NPopinit)/MaxIt)*it) + NPopinit);
    
    if Pop1Size<length(pop1)
        Pop2Size=nPop-Pop1Size;
        pop2(Pop2Size)=BestSol1Pop1;
        [~,WorstSolPop1_index]=max([pop1.Cost]);
        pop1(WorstSolPop1_index)=[];
    end
    % Phase #1 (Pop 1 & improved DE)
    for i=1:Pop1Size
        
        x1=pop1(i).Position;
        
        A=randperm(Pop1Size);
        
        A(A==i)=[];
        
        a=A(1);
        b=A(2);
        c=A(3);
        
        % Set Scale Factor (beta1) and Mutation
        if pdist2(pop1(b).Position,pop1(c).Position)>pdist2(VarMax,VarMin)/10
            beta1=unifrnd(beta_min,beta_max,VarSize);
        else
            beta1=unifrnd(beta_min,beta_max*(1+rand),VarSize);
        end
        
        y1=pop1(a).Position+beta1.*(pop1(b).Position - pop1(c).Position);
        
        % Bound
        y1 = max(y1, VarMin);
        y1 = min(y1, VarMax);
        
        % Crossover
        z1=Crossover(x1,y1,pCR);
        
        % Evaluation
        NewSol.Position=z1;
        NewSol.Cost=fobj(NewSol.Position,F_index,dim);
        
        fitness_history(i,it)=pop1(i).Cost;
        position_history(i,it,:)=pop1(i).Position;
        Trajectories(:,it)=pop1(1).Position;
        
        % Select best between parent and Mutant
        if NewSol.Cost<pop1(i).Cost
            pop1(i)=NewSol;
            % Update Global Best
            if pop1(i).Cost<BestSol.Cost
                BestSol=pop1(i);
            end
        end
        
        % Find Best Solution of pop1
        if pop1(i).Cost<BestSol1Pop1.Cost
            BestSol1Pop1=pop1(i);
        end
    end
    
    % Phase #2 (Pop 2 & New Algo)
    if Pop2Size>=(2*NPopmin)
        % Find the NPopmin best answers in pop1 and replace with best answers in pop2
        [~,BestKSolPop1_index] = mink([pop1.Cost],NPopmin);
        pop2(1:NPopmin)=pop1(BestKSolPop1_index);
    end
    for j=1:Pop2Size
        x2=pop2(j).Position;
        
        %resultant of top two vectors in pop 2
        resOfTop2 = (rand(VarSize).*(x2 - pop2(1).Position) + ...
            rand(VarSize).*(x2 - pop2(2).Position)) ;
        
        % Set Scale Factor
        beta2=unifrnd(beta_min,beta_max,VarSize);
        
        y2= beta2.*resOfTop2 ;
        % Bound
        y2 = max(y2, VarMin);
        y2 = min(y2, VarMax);
        
        % Crossover
        z2=Crossover(x2,y2,pCR);
        
        % Evaluation
        NewSol2.Position=z2;
        NewSol2.Cost=fobj(NewSol2.Position,F_index,dim);
        
        fitness_history(Pop1Size+j,it)=pop2(j).Cost;
        position_history(Pop1Size+j,it,:)=pop2(j).Position;    
        
        % Find Best Solution so far
        if NewSol2.Cost<BestSol.Cost
            BestSol=NewSol2;
        end
        
        % Add new offspring to pop2
        pop2=[pop2;NewSol2];
        
    end
    % Sort Pop2
    Costs = [pop2.Cost];
    [~, SortOrder] = sort(Costs);
    pop2 = pop2(SortOrder);
    % Truncation Pop2
    pop2 = pop2(1:Pop2Size);
    
    % Store Best Solution Ever Found
    [~,BestSolPop2_index] = min([pop2.Cost]);
    
    if pop2(BestSolPop2_index).Cost < BestSol.Cost
        BestSol = pop2(BestSolPop2_index);
    end

    
    nfe(it)=NFE;
    
    % Update Best Cost
    BestCost(it)=BestSol.Cost;
    
    % Show Iteration Information
     disp(['Iteration ' num2str(it) ': Best Cost = ' num2str(BestCost(it)) ]);
    
end

% Return Convergence_curve and BestSol
Convergence_curve = BestCost;
Fbest = BestSol;
%% Show Results

end

%%Crossover
function z=Crossover(x,y,pCR)
z=zeros(size(x));
j0=randi([1 numel(x)]);
for jj=1:numel(x)
    if jj==j0 || rand<=pCR
        z(jj)=y(jj);
    else
        z(jj)=x(jj);
    end
end
end

%%Mapping
function MX=mapping(X,dim,ub,lb)
if numel(ub)==1
    ub=ones(1,dim)*ub;
    lb=ones(1,dim)*lb;
end
for i=1:dim
    ub_i=ub(i);
    lb_i=lb(i);
    MX(:,i)=X(i).*(ub_i-lb_i)+lb_i; %(Eq. 2)
end
end
