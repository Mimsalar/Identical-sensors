function y=mutation(x,A,n)
[e,nvar]=size(x);

s=0;
while s<1
j1=randi([1 nvar]);
j2=randi([1 nvar]);
yy=x;
yy(j1)=x(j2);
yy(j2)=x(j1);
Tunobservede=A(:,find(yy==1));
if det(Tunobservede)~=0
y=yy;
s=s+1;
end
end
end