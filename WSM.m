function [Z]=WSM(A,t,w1,w2)
Tunobserved=A(:,find(t==1));
Tobserved=A(:,find(t==0));

S=abs(inv(Tunobserved)*(Tobserved));
[mm,nn]=size(S);
%=sum((sum(S,2)).^2);
Z11=max((sum(S,2)));
Z2=max(sum(S));


Z=Z11;
end
