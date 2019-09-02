%%
deng_cluster6=csvread('deng-celltype6.csv',1,1);
data=csvread('deng-logcounts.csv',1,1);;
data(find(sum(data')==0),:)=[];
D_deng=diag(sum(data)/median(sum(data)));


%D_deng=eye(268);
    lambda=1.5;
    [W,H,S]=NMF_NEW(data,30,D_deng,lambda,4);
    H2= H./repmat(sum(H,1),size(H,1),1); % L1 normalize
    I=kmeans(H2',6,'Replicates',100,'MaxIter',250);
    [ARI,RI]=RandIndex(deng_cluster6,I)
    NMI=nmi(deng_cluster6,I)
    length(find(S>0))
    [f1,precision,recall]=compute_f(deng_cluster6,I)
