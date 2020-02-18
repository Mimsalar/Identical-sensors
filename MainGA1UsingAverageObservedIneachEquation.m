%%main body geberator:
clc
clear 
close all
%% GA parameter
Maxiter=100;     %maximum number of iteration
popsize=input('please insert the population size (10*n)   ');

pc=0.5  ;    %percentage crossover

nc= 2*round(pc*popsize/2);   %crossover population size (num of offspring)

pm=0.3 ;     %percentage mutation

nm= round(pm*popsize);     %mutation population size


%% initialization 
A=xlsread('NodeLinkmatrix','sheet2');
[n,m]=size(A);

empty_individual.position=[];
empty_individual.cost=[];

Popinitial=repmat(empty_individual,popsize,1);
for i=1:popsize
 Popinitial(i).position=populationmaker(m,n,A); 
 
 %evaluation
Popinitial(i).cost=Avenumberofunobserved(A,Popinitial(i).position,n);
end
% sort population
Costs=[Popinitial.cost];
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
  popc(k,1).cost=Avenumberofunobserved(A,popc(k,1).position,n);
  popc(k,2).cost=Avenumberofunobserved(A,popc(k,2).position,n);
   
  popcc=popc(:); 
 end
  
 %mutation
 popm=repmat(empty_individual,nm,1);
 for u=1:nm
 ii=randi([1 popsize]);
 ps=Popinitial(ii);
 popm(u).position=mutation(ps.position,A,n);   
     %evaluation in mutants
 popm(u).cost=Avenumberofunobserved(A,popm(u).position,n);
 end
 
 
 %^create merged population
 Popinitial=[Popinitial
              popcc
              popm];
 %sort merged population
 Costss=[Popinitial.cost];
[Costss,sortorder]=sort(Costss);
Popinitial=Popinitial(sortorder);
 
 %truncation
 Popinitial=Popinitial(1:popsize);
 
 %best solution in each iteration
Bestsolution=Popinitial(1);

%store best cost
Bestcost(j)=Bestsolution.cost;


%show iteration information
disp(['Iteration' num2str(j) ': best cost=' num2str(Bestcost(j))]);
end

%% results
figure;
plot(Bestcost,'linewidth', 2);
xlabel('iternation');
ylabel('Cost')
