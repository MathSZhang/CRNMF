function r=selectr(data)
s=svd(data);
diags=s;
diags=diags-min(diags);
for i=1:(length(diags)-1)
    ratiodiff(i)=diags(i)/diags(i+1);
end
ratiodiff1=ratiodiff(2:end);
ratiodiff1=[ratiodiff1,1];
ratiodiffall=[ratiodiff;ratiodiff1];
%r=min(find(max(ratiodiffall)<1.05));
r=min(find(ratiodiff<1.05));