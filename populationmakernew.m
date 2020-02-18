%function   pop=populationmakernew(m,n,A)
clc
clear
A=[	
	1	0	0	0	-1	0	1	0	-1	0	0	0	0	0	0	0	0	0
	0	1	1	0	1	-1	-1	1	0	0	-1	-1	0	0	0	0	0	0
	0	0	0	1	0	1	0	-1	0	-1	0	0	0	0	0	0	0	0
	0	0	0	0	0	0	0	0	1	0	1	0	-1	1	-1	0	0	0
	0	0	0	0	0	0	0	0	0	1	0	1	1	-1	0	-1	0	0
	0	0	0	0	0	0	0	0	0	0	0	0	0	0	1	1	-1	-1];

[n,m]=size(A);
AA=abs(A);
AAA=abs(A);
T=zeros(m,m);
pop=zeros(1,m);
pops=zeros(1,m);
ss=0;
t=zeros(1,n);
%%build matrix if bidirectionals!
for j=1:m
  for jj=1:m
 if AA(:,j)==AA(:,jj) & sum(AA(:,j))>1 & j~=jj
    T(j,jj)=1;
        end
  end
end
  
  
  %%
empty_individual.position=[];
H.position=repmat(empty_individual,n,1);
F.position=repmat(empty_individual,n,1);
H.member=repmat(empty_individual,n,1);
newlink.position=repmat(empty_individual,n,1);
newlinknumber.position=repmat(empty_individual,n,1);
i=1;
while i<n+1
   if sum(AA(i,:))~=0
    newlink(i).position=randsample(sum(AA(i,:)),1);
    newlinknumber(i).position=find(AA(i,:)>0);
    H(i).position=randsample(newlinknumber(i).position,newlink(i).position);
    F(i).position=[H(i).position];
   [row,column]=size(H(i).position);
   for p=1:column
   for pp=1:m 
       AW=sum(find(H(i).position==pp));
       if  T(H(i).position(1,column),pp)==1 && AW==0
   F(i).position=[H(i).position,pp]; 
   T(H(i).position(1,column),pp)=0;
   T(pp,H(i).position(1,column))=0;
       
           
       end
   end
   end    
       
  
  AA(:,F(i).position)=0;
   
   elseif sum(AA(i,:))==0
       
      newlink(i).position=randsample(sum(AAA(i,:)),1); 
       F(i).position=newlink(i).position;
       i=i+1;
       for ii=1:i
           if i<ii
        b=find(F(ii).position==F(i).position);
        F(ii).position(b)=[];
           end 
       end
   end
i=i+1;
end

%%randomly pick a value from each matrix of new links (we need to make sure to not make a bidirectional graph)
Unobserved=zeros(1,n);

%




