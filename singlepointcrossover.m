function  [off1  off2]=singlepointcrossover(A,n,m,Popinitial,popsize)

nvar=m;
c=randi([1 nvar-1]);

l=0;
while l<1
%select first parent
 i1=randi([1 popsize]);
 p1=Popinitial(i1);
  
 %select second parent
 i2=randi([1 popsize]);
 
 p2=Popinitial(i2);
  
  if sum(p1.position(1:c))==sum(p2.position(1:c)) 
      
      y1=[p1.position(1:c)  p2.position(c+1:end)];

      y2=[p2.position(1:c)  p1.position(c+1:end)];

   Tunobserved1=A(:,find(y1==1));
   Tunobserved2=A(:,find(y2==1));
      if det(Tunobserved1)~=0 & det(Tunobserved2)~=0
    off1=y1;
    off2=y2;
l=l+1;
  end
end



end     
   
end