% dim gloabl var
global P_Nm;
global InputMaxcenterX;
global InputMaxcenterY;
global InputMaxdiam;
global InputMindiam;
% call particle struct definition
Particle_structure;
%if parallel particlepar ~= empty
particlepar = [];
P_id=int32(1);
PathAbort=logical(false);%if PathAbort particle no more moving


%here put particle inital parameters

% InputMaxcenterX=200;
% InputMaxcenterY=200;
% InputMaxdiam=4;
InputMaxNum=P_Nm;
InputMindiam=0.1;
%the method particle intal location and distrubution
RandseedBound=0:pi/50:2*pi;
RandcenterX=rand(1,P_Nm)*InputMaxcenterX;%随机生成一个粒子的X坐标为0到x最大输入坐标
RandcenterY=rand(1,P_Nm)*InputMaxcenterY;%随机生成一个粒子的X坐标为0到y最大输入坐标
Randdiam=InputMindiam+rand(1,P_Nm)*InputMaxdiam;%随机生成一个粒子的直径为10e-6到最大输入直径的直径值0.

if isempty(particlepar) %if series
    %put inital seed into each particle
    for P_id=1:InputMaxNum
        Particle(P_id).centerX=RandcenterX(P_id);
        Particle(P_id).centerY=RandcenterY(P_id);
        Particle(P_id).Diam=Randdiam(P_id);
        Particle(P_id).BoundX=(Particle(P_id).Diam/2)*sin(RandseedBound)+Particle(P_id).centerX;
        Particle(P_id).BoundY=(Particle(P_id).Diam/2)*cos(RandseedBound)+Particle(P_id).centerY;
        Particle(P_id).Pstate=PathActive; %each particle is treated as activation to move in the beginning
        %notice the particle in here could be hitted at the first step
        Particle(P_id).Phit=logical(false);%assume particle not hit each other in the beginning,
        % subplot(2,1,1);
        % plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
        % hold on;
        % axis equal;
        % axis auto;
    end

else
    parfor P_id=1:InputMaxNum %for parallel
        Particle(P_id).centerX=RandcenterX(P_id);
        Particle(P_id).centerY=RandcenterY(P_id);
        Particle(P_id).Diam=Randdiam(P_id);
        Particle(P_id).BoundX=(Particle(P_id).Diam/2)*sin(RandseedBound)+Particle(P_id).centerX;
        Particle(P_id).BoundY=(Particle(P_id).Diam/2)*cos(RandseedBound)+Particle(P_id).centerY;
        Particle(P_id).Pstate=PathActive;
    end
end



