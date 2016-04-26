% dim global var
global P_Nm;
global TIME_STEP;
global ITERATION;
%velocity at first time step
initPvelX=str2double(get(handles.Pxv,'String'));
initPvelY=str2double(get(handles.Pyv,'String'));

%for single script test
%Particle_init;
% pause(3);
% clf;
% particlepar = [];%noparallel
% TIME_STEP=1;

%for inner test
% N_TIME=10;
% TOTAL_TIME=TIME_STEP*N_TIME;

CURRENT_TIME=0;
%every TIME_STEP the particle moving distance
% % distanceTimeX=zeros(1,P_Nm);
% % distanceTimeY=zeros(1,P_Nm);
distanceTimeX=single(0);
distanceTimeY=single(0);
%intitalize moving velocity at first time step
RandPVEL_X=(rand(1,P_Nm)-0.5)*initPvelX;
RandPVEL_Y=-initPvelY*rand(1,P_Nm);

if isempty(particlepar) % for series
    for P_id=1:P_Nm
        
        if Particle(P_id).Phit~=true&&(Particle(P_id).centerY-Particle(P_id).Diam/2)>0  %if paritcle not hitted and about the floor,the particle should move.
            Particle(P_id).Pstate=PathActive;
        end
        % if  particle state is active, initalize particle's velocity and--
        % acceleration at this time step
        if Particle(P_id).Pstate==PathActive
            %fix acceleration
            Particle(P_id).accelerationX=0;
            Particle(P_id).accelerationY=-9.8;
            
            % if at fisrt time step, velocity equal to you setting;
            % else particle velocity equal to last velocity plus
            % acceleration times TIME_STEP;
            if ITERATION ==1
                Particle(P_id).PVEL_X0=RandPVEL_X(P_id);
                Particle(P_id).PVEL_Y0=RandPVEL_Y(P_id);
                
                distanceTimeX=Particle(P_id).PVEL_X0*TIME_STEP+0.5*Particle(P_id).accelerationX*TIME_STEP^2;
                distanceTimeY=Particle(P_id).PVEL_Y0*TIME_STEP+0.5*Particle(P_id).accelerationY*TIME_STEP^2;
                
                Particle(P_id).PVEL_X=Particle(P_id).PVEL_X0+Particle(P_id).accelerationX*TIME_STEP;
                Particle(P_id).PVEL_Y=Particle(P_id).PVEL_Y0+Particle(P_id).accelerationY*TIME_STEP;
            else
                distanceTimeX=Particle(P_id).PVEL_X*TIME_STEP+0.5*Particle(P_id).accelerationX*TIME_STEP^2;
                distanceTimeY=Particle(P_id).PVEL_Y*TIME_STEP+0.5*Particle(P_id).accelerationY*TIME_STEP^2;
                Particle(P_id).PVEL_X=Particle(P_id).PVEL_X+Particle(P_id).accelerationX*TIME_STEP;
                Particle(P_id).PVEL_Y=Particle(P_id).PVEL_Y+Particle(P_id).accelerationY*TIME_STEP;
            end
            
            %  update particle position
            Particle(P_id).centerX=Particle(P_id).centerX+distanceTimeX;
            Particle(P_id).centerY=Particle(P_id).centerY+distanceTimeY;
            Particle(P_id).BoundX=Particle(P_id).BoundX+ distanceTimeX;
            Particle(P_id).BoundY=Particle(P_id).BoundY+ distanceTimeY;
            
           
                
            
            %  for inner test
            %   fprintf('particle %d x is %f,y is %f\n',P_id,Particle(P_id).centerX,Particle(P_id).centerY);
            %   fprintf('boundY is %f\n',min(Particle(P_id).BoundY));
        else
            % if particle state is abort.all speed set to zero.
            Particle(P_id).accelerationX=0;
            Particle(P_id).accelerationY=0;
            Particle(P_id).PVEL_X0=0;
            Particle(P_id).PVEL_Y0=0;
            Particle(P_id).PVEL_X=0;
            Particle(P_id).PVEL_Y=0;
        end
        
        %if particle hit the floor,particle no longer move. particle state-
        %set to abort.
        if Particle(P_id).centerY<=(Particle(P_id).Diam/2)
            
            % if particle below the floor,put the particle upon the floor
            % and set particle state to abort.
            Particle(P_id).BoundY=Particle(P_id).BoundY+abs(min(Particle(P_id).BoundY));        
            Particle(P_id).centerY=Particle(P_id).Diam/2;
            Particle(P_id).Pstate=PathAbort;
            
            %  for hit test
            %             fprintf('minboundY is %f\n',min(Particle(P_id).BoundY));
            %             subplot(1,N_TIME,N_step);
            %             hold on;
            %             axis ([-InputMaxcenterX*1.2 InputMaxcenterX*1.2 0 InputMaxcenterY*1.2 ]);
            %             axis equal;
            %             axis tight;
            %             axis auto;
            %             Particle_draw(Particle(P_id).centerX,Particle(P_id).centerY,Particle(P_id).Diam);
            %             plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
            
            continue;
            
            %  if particle not hit the floor,and particle coule move, set-
            %  the particle new velocity.
%         else
%             if Particle(P_id).Pstate==PathActive
%             %  for inner test
%             %             subplot(2,N_TIME/2,N_step);
%             %             hold on;
%             %             Particle_draw(Particle(P_id).centerX,Particle(P_id).centerY,Particle(P_id).Diam);
%             %             plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
%             %             axis equal;
%             %             axis ([-InputMaxcenterX*1.2 InputMaxcenterX*1.2 0 InputMaxcenterY*1.2 ]);
%             %             axis tight;
%             %             axis auto;
%             Particle(P_id).PVEL_X=Particle(P_id).PVEL_X0+Particle(P_id).accelerationX*TIME_STEP;
%             Particle(P_id).PVEL_Y=Particle(P_id).PVEL_Y0+Particle(P_id).accelerationY*TIME_STEP;
%             end
        end
    end
    
    
    %  for parallel
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


