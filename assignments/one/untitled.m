%% CS591 - Data Mining Assignment One
% Aaron Gonzales
% 


%%
% Manual Principle Component Analysis of the given data: 
A=dlmread('~/Desktop/data.txt');
A = zscore(A);
C = (A' * A);
[V,D] = eig(C);
V(:,999);
A*V(:,999);
plot(A*V(:,999), A*V(:,1000),'*')
%% Clusters
% we can see that there are nine clusters, though two of them are somewhat mixed and could be open for interpretation.
% 
