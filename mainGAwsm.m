%%main body geberator:
clc
clear 
%close all
%%WSM weights
%w1=input('First weight on average of observed on each equation  ');
%w2=input('Second weight on the frequency of observed links in different equations   ');

tic
%% GA parameter
Maxiter=1000;     %maximum number of iteration
popsize=input('please insert the population size (10*n)   ');

pc=0.8  ;    %percentage crossover

nc= 2*round(pc*popsize/2);   %crossover population size (num of offspring)

pm=0.6 ;     %percentage mutation

nm= round(pm*popsize);     %mutation population size


%% initialization 
A=xlsread('Fishbone','sheet2');
[n,m]=size(A);

empty_individual.position=[];
empty_individual.costwsm=[];
empty_individual.costave1=[];
empty_individual.costave2=[];
empty_individual.costmax1=[];
empty_individual.costmax2=[];

Popinitial=repmat(empty_individual,popsize,1);
for i=1:popsize
 Popinitial(i).position=populationmaker(m,n,A); 
 
 %evaluation
Popinitial(i).costwsm=WSM(A,Popinitial(i).position);

Popinitial(i).costave1=ave1(A,Popinitial(i).position);
Popinitial(i).costave2=ave2(A,Popinitial(i).position);

Popinitial(i).costmax1=max1(A,Popinitial(i).position);
Popinitial(i).costmax2=max2(A,Popinitial(i).position);
end
% sort population
Costs=[Popinitial.costwsm];
[Costs,sortorder]=sort(Costs);
Popinitial=Popinitial(sortorder);

%best solution in each iteration


%defined an array to hold best cost values


%%  Main body:

for j=1:Maxiter
    
 %crossover
 popc=repmat(empty_individual,nc/2,2);
 for k=1:nc/2

    
  %apply crossover
  [popc(k,1).position popc(k,2).position]=singlepointcrossover(A,n,m,Popinitial,popsize);
  
  
  % evaluate crossover
  popc(k,1).costwsm=WSM(A,popc(k,1).position);
  popc(k,2).costwsm=WSM(A,popc(k,2).position);
  
  popc(k,1).costave1=ave1(A,popc(k,1).position);
  popc(k,2).costave1=ave1(A,popc(k,2).position);
  
  popc(k,1).costmax1=max1(A,popc(k,1).position);
  popc(k,2).costmax1=max1(A,popc(k,2).position);

  popc(k,1).costave2=ave2(A,popc(k,1).position);
  popc(k,2).costave2=ave2(A,popc(k,2).position);
  
  popc(k,1).costmax2=max2(A,popc(k,1).position);
  popc(k,2).costmax2=max2(A,popc(k,2).position); 
  
  popcc=popc(:); 
 end
  
 %mutation
 popm=repmat(empty_individual,nm,1);
 for u=1:nm
 ii=randi([1 popsize]);
 ps=Popinitial(ii);
 popm(u).position=mutation(ps.position,A,n);   
     %evaluation in mutants
 popm(u).costwsm=WSM(A,popm(u).position);
 popm(u).costave1=ave1(A,popm(u).position);
 popm(u).costave2=ave2(A,popm(u).position);
 popm(u).costmax1=max1(A,popm(u).position);
 popm(u).costmax2=max2(A,popm(u).position);
 end
 
 
 %^create merged population
 Popinitial=[Popinitial
              popcc
              popm];
 %sort merged population
 Costss=[Popinitial.costwsm];
[Costss,sortorder]=sort(Costss);
Popinitial=Popinitial(sortorder);
 
 %truncation
 Popinitial=Popinitial(1:popsize);
 
 %best solution in each iteration
Bestsolution=Popinitial(1);

%store best cost
Bestcostwsm(j)=Bestsolution.costwsm;
Bestcostmaxz1(j)=Bestsolution.costmax1;
Bestcostmaxz2(j)=Bestsolution.costmax2;
%show iteration information
disp(['Iteration' num2str(j) ': best cost=' num2str(Bestcostwsm(j))]);
end

%% results
figure;
hold all
plot(Bestcostwsm,'linewidth', 2);
xlabel('iteration');
ylabel('Expected number of unobserved links');
toc
