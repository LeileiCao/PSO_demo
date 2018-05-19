clear all;
clc;
tic;
d=30; %% dimension of variables
n=40;  %% population size of particles
N=500; %% number of generations
Lb=-100;  %% lower limits of variables
Ub=100;  %% upper limits of variables
Vmax=10;  %% upper limits of velocity
Vmin=-10;  %% lower limits of velocity
c=1.49445;
w=0.7;
 for i=1:n
     V(i,:)=Vmin+(Vmax-Vmin)*rand(1,d);   %% initialize velocites
     Sol(i,:)=Lb+(Ub-Lb)*rand(1,d);    %% initialize solutions (positions)
    Fitness(i)= sphere(Sol(i,:));    %% evaluate initializing solutions
 end
 [fmin,I]=min(Fitness);    %% select the global minization 
  Gbest=Sol(I,:);   %% the solution of owning the global minization fitness
  Imin=Fitness;      %%   particle's self best fitness
  Ibest=Sol;      %%    particle's solution with best fitnss
  F_record=fmin;
  %%
  for t=1:N    %% iteration beginning
      
      for i=1:n   
         for q=1:d       
          V(i,q)=w*V(i,q)+c*rand*(Ibest(i,q)-Sol(i,q))+c*rand*(Gbest(q)-Sol(i,q));  %% generate the velocities
         end
          Index1=find(V(i,:)>Vmax);      %% limit velocities
          V(i,Index1)=Vmax;        
          Index2=find(V(i,:)<Vmin);
          V(i,Index2)=Vmin;
          
         Sol(i,:)=Sol(i,:)+V(i,:);    %% generate the position of particles
         Index3=find(Sol(i,:)>Ub);    %% limit position
         Sol(i,Index3)=Ub;
         Index4=find(Sol(i,:)<Lb);
         Sol(i,Index4)=Lb;
         
         Fitness(i)=sphere(Sol(i,:));  %% evaluate fitness
         if Fitness(i)<Imin(i)    %% update the each particle's position
             Ibest(i,:)=Sol(i,:);
             Imin(i)=Fitness(i);
         end
         if Fitness(i)<fmin   %% update the global best position
             Gbest=Sol(i,:);
             fmin=Fitness(i);
         end
      end  
       F_record(t)=fmin;
  end

  toc;
 %%
disp(['fmin=',num2str(fmin)]);
figure
plot(F_record)
%%
function z=sphere(X)
d=length(X);
z=0;
for i=1:d
  z=z+(X(i))^2;
end
end
         
         
         
         
         
         
         
          
          
          
  
  
  
  