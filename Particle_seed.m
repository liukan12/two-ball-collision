Particle_structure;
clf;
P_Nm=20;

InputMaxcenterX=50;
InputMaxcenterY=50;
InputMaxdiam=2;
InputMaxNum=P_Nm;

RandseedBound=0:pi/50:2*pi;
RandcenterX=rand(1,P_Nm)*InputMaxcenterX;%随机生成一个粒子的X坐标为0到x最大输入坐标
RandcenterY=rand(1,P_Nm)*InputMaxcenterY;%随机生成一个粒子的X坐标为0到y最大输入坐标
Randdiam=0.1+rand(1,P_Nm)*InputMaxdiam;%随机生成一个粒子的直径为10e-6到最大输入直径的直径值0.

for P_id=1:InputMaxNum
Particle(P_id).centerX=RandcenterX(P_id);
Particle(P_id).centerY=RandcenterY(P_id);
Particle(P_id).Diam=Randdiam(P_id);
Particle(P_id).BoundX=(Particle(P_id).Diam/2)*sin(RandseedBound)+Particle(P_id).centerX;
Particle(P_id).BoundY=(Particle(P_id).Diam/2)*cos(RandseedBound)+Particle(P_id).centerY;
Particle(P_id).Pstate=PathActive;
% subplot(2,1,1);
% plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
% hold on;
% axis equal;
% axis auto;
end