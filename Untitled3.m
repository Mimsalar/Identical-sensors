%function   pop=populationmakernew(m,n,A)
clc
clear


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

newlink.position=repmat(empty_individual,m,1);
newlinknumber.position=repmat(empty_individual,m,1);

R=zeros(n,1);
%%
for ja=1:m
  C=find(AA(:,ja)>0);
  
 if sum(T(:,ja))==0
    newlink(ja).position=C(randsample(length(C),1));
    if R(newlink(ja).position)==1 && sum(AA(:,ja)>0)>1
      AA(newlink(ja).position,ja)=0;
      C=find(AA(:,ja)>0);
      newlink(ja).position=C(randsample(length(C),1));  
    end
    R(newlink(ja).position)=1;
 else
     O=find(T(:,ja)==1);
     newlink(ja).position=C(randsample(length(C),1));
    newlink(O).position= newlink(ja).position;
 end
end
U=zeros(n,1);
for jb=1:m
    
        
   U(jb,1)=newlink(jb).position ;    
        
        
 
end
Y=zeros(n,m);

for ic=1:n
    for jc=1:m
     if U(jc,1)==ic    
  Y(ic,jc)=1;     
        
     end     
        
    end
end

for id=1:n 
    for jd=1:m
      H(id).position=find(Y(id,:)==1) ; 
        
        
        
    end
end
%%randomly pick a value from each matrix of new links (we need to make sure to not make a bidirectional graph)




