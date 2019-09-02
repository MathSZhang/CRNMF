function [W, H, S]=NMF_NEW(data,maxitr,D,lambda,r) 
% data is the input matrix (log2(1+count))
% maxitr is the max iteration number
% D is the weight matrix
% lambda is the tuning parameter
% r is the rank number

window=(data==0); 
dim=size(data);

%
rand('seed',23);
S=rand(dim).*window;
S=0;
[W,H]=NNDSVD(data,r,0);

cost_old=2;
cost=sum(sum(((data+S)-W*H).*((data+S)-W*H)));

omega=D;

for iter=1:maxitr
       iter;
   % while abs(cost_old-cost)/cost_old>0.00001 %%10^{-4} before
    %while abs(cost_old-cost)>1000
    k=0;
    while abs(cost_old-cost)/dim(1)/dim(2)>10^(-4)
        k=k+1;
        W=W.*(((data+S)*H')./((W*H)*H')+1e-10);     
        W= W./repmat(sqrt(sum(W.^2,1)),size(W,1),1);
        H=H.*((W'*(data+S))./((W'*W)*H)+1e-10); 
       % H= H./repmat(sqrt(sum(H.^2,2)),1,size(H,2));
        cost_old=cost;
        cost=sum(sum(((data+S)-W*H).*((data+S)-W*H)));
    end
     k;
    %max(max((data+S)-W*H))
    %abs(cost_old-cost)/cost_old  
    temp=-data+W*H;
    S=SoftThreshold(temp,ones(dim)*(lambda*omega));
    S=S.*window;
    
    cost_old=cost;
    cost=sum(sum(((data+S)-W*H).*((data+S)-W*H)));
   
end
 
