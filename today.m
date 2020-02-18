
for u=1:n
    [mm,nn]=size(H(u).position);
    H(u).member=nn;
end  
    
members=[H.member];
[members,sortorder]=sort(members);
H=H(sortorder);
mim=0;
while mim<1
for uuu=1:n
    [nnn,mmm]=size(H(uuu).position);
    kkk=H(uuu).position;
   ttt= datasample(kkk,1);
   Unobserved(1,uuu)=ttt; 
   for  f=1:m
      if T(ttt,f)==1 & mmm>1
      H(uuu).position(find(H(uuu).position==f))=[];  
      kkk=H(uuu).position;
      ttt= randsample(kkk,1);    
      end 
   end
end
   pops(1,Unobserved)=1;
   Tunobserved=A(:,Unobserved);
if   det(Tunobserved)~=0     %n=number of row vector of matrix A
   pop= pops;
    mim=mim+1;
 
   
   
end



end

    






%%

