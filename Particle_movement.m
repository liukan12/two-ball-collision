global P_Nm;
global TIME_STEP;
% Particle_init;
% pause(3);
% clf;
% global P_Nm;
% particlepar = [];%noparallel

% TIME_STEP=1;
N_TIME=10;
TOTAL_TIME=TIME_STEP*N_TIME;
CURRENT_TIME=0;
distanceTimeX=zeros(1,P_Nm);
distanceTimeY=zeros(1,P_Nm);

% for N_step=1:N_TIME
    
    %     RandPVEL_X=rand(1,P_Nm);
    RandPVEL_X=(rand(1,P_Nm)-0.5)*3;
    %     RandPVEL_Y=-3+rand(1,P_Nm);
    RandPVEL_Y=-3*rand(1,P_Nm);
if isempty(particlepar)
    for P_id=1:P_Nm
        if Particle(P_id).Phit~=true&&(Particle(P_id).centerY-Particle(P_id).Diam/2)>0
            Particle(P_id).Pstate==PathActive;
        end     
        if Particle(P_id).Pstate==PathActive
            Particle(P_id).accelerationX=0;
            Particle(P_id).accelerationY=-9.8;
            Particle(P_id).PVEL_X0=RandPVEL_X(P_id);
            Particle(P_id).PVEL_Y0=RandPVEL_Y(P_id);
            
            distanceTimeX(P_id)=Particle(P_id).PVEL_X0*TIME_STEP+0.5*Particle(P_id).accelerationX*TIME_STEP^2;
            distanceTimeY(P_id)=Particle(P_id).PVEL_Y0*TIME_STEP+0.5*Particle(P_id).accelerationY*TIME_STEP^2;
            
            Particle(P_id).centerX=Particle(P_id).centerX+distanceTimeX(P_id);
            Particle(P_id).centerY=Particle(P_id).centerY+distanceTimeY(P_id);
            Particle(P_id).BoundX=Particle(P_id).BoundX+ distanceTimeX(P_id);
            Particle(P_id).BoundY=Particle(P_id).BoundY+ distanceTimeY(P_id);
            
            
%             fprintf('particle %d x is %f,y is %f\n',P_id,Particle(P_id).centerX,Particle(P_id).centerY);
%             fprintf('boundY is %f\n',min(Particle(P_id).BoundY));
        end
        if Particle(P_id).centerY<=(Particle(P_id).Diam/2)
            Particle(P_id).BoundY=Particle(P_id).BoundY+abs(min(Particle(P_id).BoundY));
            %             fprintf('minboundY is %f\n',min(Particle(P_id).BoundY));
            Particle(P_id).centerY=Particle(P_id).Diam/2;
            Particle(P_id).Pstate=PathAbort;
            Particle(P_id).PVEL_X=0;
            Particle(P_id).PVEL_Y=0;
            
%            subplot(1,N_TIME,N_step);
%             hold on;
%             axis ([-InputMaxcenterX*1.2 InputMaxcenterX*1.2 0 InputMaxcenterY*1.2 ]);
%             axis equal;
            %             axis tight;
            %             axis auto;
%          Particle_draw(Particle(P_id).centerX,Particle(P_id).centerY,Particle(P_id).Diam);
%              plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
            
            continue;
        else
%              subplot(2,N_TIME/2,N_step);
            hold on;
%             Particle_draw(Particle(P_id).centerX,Particle(P_id).centerY,Particle(P_id).Diam);
%             plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
%             axis equal;
%             axis ([-InputMaxcenterX*1.2 InputMaxcenterX*1.2 0 InputMaxcenterY*1.2 ]);
            %             axis tight;
            %             axis auto;
            Particle(P_id).PVEL_X=Particle(P_id).PVEL_X0+Particle(P_id).accelerationX*TIME_STEP;
            Particle(P_id).PVEL_Y=Particle(P_id).PVEL_Y0+Particle(P_id).accelerationY*TIME_STEP;
        end
    end
%parallel open   
else
     parfor P_id=1:500
        
        if Particle(P_id).Pstate==PathActive
            Particle(P_id).accelerationX=0;
            Particle(P_id).accelerationY=-9.8;
            Particle(P_id).PVEL_X0=RandPVEL_X(P_id);
            Particle(P_id).PVEL_Y0=RandPVEL_Y(P_id);
            
            distanceTimeX(P_id)=Particle(P_id).PVEL_X0*TIME_STEP+0.5*Particle(P_id).accelerationX*TIME_STEP^2;
            distanceTimeY(P_id)=Particle(P_id).PVEL_Y0*TIME_STEP+0.5*Particle(P_id).accelerationY*TIME_STEP^2;
            
            Particle(P_id).centerX=Particle(P_id).centerX+distanceTimeX(P_id);
            Particle(P_id).centerY=Particle(P_id).centerY+distanceTimeY(P_id);
            Particle(P_id).BoundX=Particle(P_id).BoundX+ distanceTimeX(P_id);
            Particle(P_id).BoundY=Particle(P_id).BoundY+ distanceTimeY(P_id);
            
            
%             fprintf('particle %d x is %f,y is %f\n',P_id,Particle(P_id).centerX,Particle(P_id).centerY);
%             fprintf('boundY is %f\n',min(Particle(P_id).BoundY));
        end
        if Particle(P_id).centerY<=(Particle(P_id).Diam/2)
            Particle(P_id).BoundY=Particle(P_id).BoundY+abs(min(Particle(P_id).BoundY));
            %             fprintf('minboundY is %f\n',min(Particle(P_id).BoundY));
            Particle(P_id).centerY=Particle(P_id).Diam/2;
            Particle(P_id).Pstate=PathAbort;
            Particle(P_id).PVEL_X=0;
            Particle(P_id).PVEL_Y=0;
            
%            subplot(1,N_TIME,N_step);
%             hold on;
%             axis ([-InputMaxcenterX*1.2 InputMaxcenterX*1.2 0 InputMaxcenterY*1.2 ]);
%             axis equal;
            %             axis tight;
            %             axis auto;
%          Particle_draw(Particle(P_id).centerX,Particle(P_id).centerY,Particle(P_id).Diam);
%              plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
            
            continue;
        else
%              subplot(2,N_TIME/2,N_step);
            hold on;
%             Particle_draw(Particle(P_id).centerX,Particle(P_id).centerY,Particle(P_id).Diam);
%             plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
%             axis equal;
%             axis ([-InputMaxcenterX*1.2 InputMaxcenterX*1.2 0 InputMaxcenterY*1.2 ]);
            %             axis tight;
            %             axis auto;
            Particle(P_id).PVEL_X=Particle(P_id).PVEL_X0+Particle(P_id).accelerationX*TIME_STEP;
            Particle(P_id).PVEL_Y=Particle(P_id).PVEL_Y0+Particle(P_id).accelerationY*TIME_STEP;
        end
     end
end
%     subplot(1,N_TIME,N_step);
%     Particle_draw;
% end


% Particle_draw;


