% clear;
global P_Nm;
global InputMaxcenterX;
global InputMaxcenterY;
global InputMaxdiam;
Particle_structure;
particlepar = [];
% clf;
% P_Nm=500;
% PathActive = ones(1,P_Nm);
PathAbort=0;
P_id=int32(1);
% Particle(1:P_Nm)=struct('centerX',double(0),...
% 'centerY',double(0),...
% 'Diam',double(0),...
% 'PVEL_X',double(0),...
% 'PVEL_Y',double(0),...
% 'Mass',double(0),...
% 'PVEL_X0',double(0),...
% 'PVEL_Y0',double(0),...
% 'accelerationX',double(0),...
% 'accelerationY',double(0),...
% 'PforceX',double(0),...
% 'PforceY',double(0),...
% 'BoundX',zeros(1,200),...
% 'BoundY',zeros(1,200),...
% 'Pstate',logical(true)...
% );

% InputMaxcenterX=200;
% InputMaxcenterY=200;
% InputMaxdiam=4;
InputMaxNum=P_Nm;

RandseedBound=0:pi/50:2*pi;
RandcenterX=rand(1,P_Nm)*InputMaxcenterX;%随机生成一个粒子的X坐标为0到x最大输入坐标
RandcenterY=rand(1,P_Nm)*InputMaxcenterY;%随机生成一个粒子的X坐标为0到y最大输入坐标
Randdiam=0.1+rand(1,P_Nm)*InputMaxdiam;%随机生成一个粒子的直径为10e-6到最大输入直径的直径值0.
if isempty(particlepar)
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

else
    parfor P_id=1:InputMaxNum
        Particle(P_id).centerX=RandcenterX(P_id);
        Particle(P_id).centerY=RandcenterY(P_id);
        Particle(P_id).Diam=Randdiam(P_id);
        Particle(P_id).BoundX=(Particle(P_id).Diam/2)*sin(RandseedBound)+Particle(P_id).centerX;
        Particle(P_id).BoundY=(Particle(P_id).Diam/2)*cos(RandseedBound)+Particle(P_id).centerY;
        Particle(P_id).Pstate=PathActive;
    end
end



