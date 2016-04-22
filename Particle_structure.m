global P_Nm;
% 
PathActive = logical(true);
PathAbort=logical(false);
P_id=int32(1);
Particle(1:P_Nm)=struct('centerX',double(0),...
'centerY',double(0),...
'Diam',double(0),...
'PVEL_X',double(0),...
'PVEL_Y',double(0),...
'Mass',double(0),...
'PVEL_X0',double(0),...
'PVEL_Y0',double(0),...
'accelerationX',double(0),...
'accelerationY',double(0),...
'PforceX',double(0),...
'PforceY',double(0),...
'BoundX',zeros(1,200),...
'BoundY',zeros(1,200),...
'Pstate',logical(true),...
'Phit',logical(false)...
);
% Particle(1:P_Nm).Phit=struct(...
% 'PhitId',double(zeros(1,P_Nm))...
% );
% 'PhitId',struct('PhitX',double(zeros(1,P_Nm-1)),'PhitY',double(zeros(1,P_Nm-1)))...
% Particle(1:P_Nm).PhitId(1:P_Nm)=struct('PhitX',double(zeros(1,P_Nm-1))),...
% 'PhitY',double(zeros(1,P_Nm-1)...
% );
% for P_id=1:P_Nm
% Particle(P_id).centerX=double(0);%particle center y coordinate
% Particle(P_id).centerY=double(0);%particle center x coordinate
% Particle(P_id).Diam=double(0);%particle Diameter
% Particle(P_id).Density=double(0);%particle Density
% Particle(P_id).PVEL_X=double(0);%particle speed at x direction
% Particle(P_id).PVEL_Y=double(0);%particle speed at y direction
% Particle(P_id).Mass=double(0);%particle mass.For circle mass=density*PI*Diam^2/4
% Particle(P_id).PVEL_X0=double(0);%particle speed at x direction in last state
% Particle(P_id).PVEL_Y0=double(0);%particle speed at y direction in last state
% % Particle(P_id).PVEL_X_Init=double(0);%particle speed at x direction at initialization
% % Particle(P_id).PVEL_Y_Init=double(0);%particle speed at x direction at initialization
% Particle(P_id).accelerationX=double(0);%particle acceleration at x direction
% Particle(P_id).accelerationY=double(0);%particle acceleration  at x direction
% Particle(P_id).PforceX=double(0);%particle force at x direction
% Particle(P_id).PforceY=double(0);%particle force at x direction
% Particle(P_id).BoundX=double(0);
% Particle(P_id).BoundY=double(0);
% Particle(P_id).Pstate=PathActive(P_id);
% end



