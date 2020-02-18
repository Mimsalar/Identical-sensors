function   pop=populationmaker(m,n,A)

s=0;
%t=zeros(1,m);
  while s<1   
 t=zeros(1,m);
k=randsample(m,n);
t(k)=1;
Tunobserved=A(:,find(t==1));  
if   det(Tunobserved)~=0     %n=number of row vector of matrix A
   pop=t;
    s=s+1;
else 
Tunobserved=zeros(n,n);
end 

  end

end