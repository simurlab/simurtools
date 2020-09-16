% esfera.m
P = ones(13);
P(:,1)=10*rand(1,13);
P(:,13)=P(:,1);
P(:,7)=10*rand(1,13);
P(:,4)=10*rand(1,13);
P(7,:)=10*rand(1,13);
P(:,10)=10*rand(1,13);
sphere3d(-P,-pi,pi,-pi/2,pi/2,20,1,'surf','spline',0.001);
figure
imagesc(-P)