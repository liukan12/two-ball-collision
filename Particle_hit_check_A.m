%  dim global var
global P_Nm;
global Dimension;  %  Dimension of Cartesian coordinate system,as 1D 2D 3D.
global CHECK_TIMES;  % the number of iteration to adjust the hit particle position(any pariticle position adjustment could influence other paritcle in the plane)
global ITERATION;
global InputMaxdiam;
global InputMindiam;
global InputMaxcenterX;
Dimension=2;
% for ii=1:P_Nm
% outputHit{1,ii}=double(0);
% end
% for inner test
% clf;
% Particle_init;

% initalize the distance between each other,and the hit points'
% location.set total hit number to zero and each particle hit number to zero
% % distanceX=zeros(P_Nm);
% % distanceY=zeros(P_Nm);
% % circleDistance=zeros(P_Nm);
distanceX=single(0);
distanceY=single(0);
circleDistance=single(0);
hitpointX=single(0);
hitpointY=single(0);
contactAngle=single(0);
hitCount=int32(0);   % total hit count
hitBallNumber=int32(1);
cueBallNumber=int32(0); % the particle number as the main ball to hit
cueHitCount=int32(0);  % the main ball hit number(a particle could hit more than one ball)

% dim a struct to perserve the hit particle data,not use if is not
% necessary
% % cueball(1:P_Nm,1:CHECK_TIMES)=struct('cueNumber',int32(0),...
% %     'hitball',double(zeros(P_Nm-1,Dimension+2)),... %last column present hitAngle,first column present the hitnumber,second for hit x cor,third for hit y cor,fourth for hit z cor,
% %     'hitTotalnumber',double(0)...
% %     );


% the below code is perserved for AABB check if it is necessary
% % for P_id=1:P_Nm
% % AABBMaxX(P_id)=Particle(P_id).centerX+Particle(P_id).Diam/2;
% % AABBMaxY(P_id)=Particle(P_id).centerY+Particle(P_id).Diam/2;
% % AABBMinX(P_id)=Particle(P_id).centerX-Particle(P_id).Diam/2;
% % AABBMinY(P_id)=Particle(P_id).centerY-Particle(P_id).Diam/2;
% % end


if isempty(particlepar)  %  for series
    %there should be some times to check if there are no paticles here to hit
    %each other
    for hitcheck=1:CHECK_TIMES
        %  sort Particle struct by Y cordinate each check time to ensure
        %  the lowest particle be set to the first check particle.
        %
        %         tic
        set(handles.edit9,'String',[]);
        if ITERATION ==1
            Particle_sortbyY;
        end
        %         if hitcheck==1
        %             Particle_sortbyY;
        %         end
        cueHitCount=0;
        hitCount=0;
        
        %  from lowest particle to toppest.
        %  notice:1.particle could not hit itself. particle 1 hit particle is
        %  the same as particle 2 hit particle 1.
        %  the hit possiblity between particle N is a upper triangular-
        %  matrix for N X N metrix and the leading diagonal is set to 0.
        for p1=1:P_Nm
            hitBallNumber=1;
            for p2=(p1+1):P_Nm
               
                    
%                 if Particle(p2).Pstate == PathActive
                    %  if particle number is very large.this method will allocate a huge RAM.
                    %  this should be avoid.
                    %                 distanceX(p1,p2)=abs(Particle(p1).centerX-Particle(p2).centerX);
                    %                 distanceY(p1,p2)=abs(Particle(p1).centerY-Particle(p2).centerY);
                    %                 circleDistance(p1,p2)=(Particle(p1).Diam+Particle(p2).Diam)/2;
                    if abs(Particle(p2).centerX-Particle(p1).centerX)<=InputMaxdiam+InputMindiam && abs(Particle(p2).centerX-Particle(p1).centerX)<=InputMaxdiam+InputMindiam
                        %                     distanceX=abs(Particle(p1).centerX-Particle(p2).centerX);
                        %                     distanceY=abs(Particle(p1).centerY-Particle(p2).centerY);
                        %                     circleDistance=(Particle(p1).Diam+Particle(p2).Diam)/2;
                        
                        % if two particles' center distance are lese than the sum of two
                        % particles diameter.the two particles are hit.
                        if (Particle(p1).centerX-Particle(p2).centerX)^2+ (Particle(p1).centerY-Particle(p2).centerY)^2<=((Particle(p1).Diam+Particle(p2).Diam)/2)^2
                         
                            hitCount=hitCount+1;  %hit count add 1
                            % set the two particle state to hit
                            Particle(p1).Phit = logical(true);
                            Particle(p2).Phit = logical(true);
                            
                            %  if cueBallNumber is not the current iteration main
                            %  paritcle. set the cueBallNumber to current main
                            %  paritcle number.
                            if cueBallNumber~=p1
                                cueBallNumber=p1;
                                cueHitCount=cueHitCount+1;  % index for a hit particle data struct
                            else
                                %  if the same main particle hit another ball,
                                %  hitBallNumber add 1.
                                hitBallNumber=hitBallNumber+1;
                            end
                            %                     end
                            %  count the hitpoint by contactAngle.In fact the real
                            %  contact angle should be count by a real velocity
                            %  angel.
                            hitpointX=(Particle(p1).centerX*Particle(p2).Diam+Particle(p2).centerX*Particle(p1).Diam)/(Particle(p2).Diam+Particle(p1).Diam);
                            hitpointY=(Particle(p1).centerY*Particle(p2).Diam+Particle(p2).centerY*Particle(p1).Diam)/(Particle(p2).Diam+Particle(p1).Diam);
                            contactAngle=atan((hitpointY-Particle(p1).centerY)/(hitpointX-Particle(p1).centerX));
                            
                            %preserve for future usage in collection hit particle
                            %data.require a huge RAM.
                            % %                     cueball(cueHitCount,hitcheck).cueNumber=p1;%the ball set to hit another ball
                            % %                     cueball(cueHitCount,hitcheck).hitball(hitBallNumber,1)=p2;%which ball the cueball hit
                            % %                     cueball(cueHitCount,hitcheck).hitball(hitBallNumber,2)=hitpointX;
                            % %                     cueball(cueHitCount,hitcheck).hitball(hitBallNumber,3)=hitpointY;
                            % %                     cueball(cueHitCount,hitcheck).hitball(hitBallNumber,Dimension+2)=contactAngle;
                            % %                     cueball(cueHitCount,hitcheck).hitTotalnumber=hitBallNumber;
                            
                            contactAngleDegree=contactAngle/pi*180;  %radian to degree
                            
                            % set sub particle(means above main particle) position by a hitting
                            % method. Notice,only adjust sub Particle position, this method is not
                            % real. because in the real world, the particle movement should follow the
                            % conservation law. sub particle move away from main particle,so they are
                            % out of hitting range.But sub particle's adjust would cause a another hit
                            % happen.this case is complicated,we use a iteration to ensure every
                            % particle is not overlapped.(But this could cause a unreal movement between
                            % particles).if the particles' overlap is heavy,it will cause a domino effect.
                            
                            % Put your hit adjust method below.IMPORTANT!
                            % Put your hit adjust method below.IMPORTANT!
%                                 if Particle(p1).centerY-Particle(p1).Diam/2 == 0 && Particle(p2).centerY-Particle(p2).Diam/2==0
%                                   
%                                     Particle(p2).centerX=Particle(p1).centerX+(Particle(p2).Diam+Particle(p1).Diam)/2*cos(contactAngle);
% %                                     Particle(p1).centerX=Particle(p1).centerX-(Particle(p2).Diam+Particle(p1).Diam)/2*cos(contactAngle)/2;
%                                 end 
%                                 if Particle(p1).Pstate == PathAbort && Particle(p2).Pstate == PathActive
                                     Rise_Angle=acos((Particle(p2).centerX-Particle(p1).centerX)/((Particle(p1).Diam+Particle(p2).Diam)/2));
                                     if Particle(p2).centerY-Particle(p2).Diam/2>Particle(p1).centerY-Particle(p1).Diam/2
                                     if Rise_Angle<pi/2
                                     Particle(p2).centerY=sin(Rise_Angle)*((Particle(p1).Diam+Particle(p2).Diam)/2)+Particle(p1).centerY;
                                     else
                                     Particle(p2).centerY=-sin(Rise_Angle)*((Particle(p1).Diam+Particle(p2).Diam)/2)+Particle(p1).centerY;
                                     end
                                     end
                                

                            Particle(p2).centerX=Particle(p1).centerX+(Particle(p2).Diam+Particle(p1).Diam)/2*cos(contactAngle);
                            Particle(p2).centerY=Particle(p1).centerY+(Particle(p2).Diam+Particle(p1).Diam)/2*sin(contactAngle);
                            
                            % if sub particle is below floor ,set it back to the
                            % floor.For the sub one is above main one, this
                            % possiblity is small.
                            if Particle(p2).centerY<=Particle(p2).Diam/2
                                Particle(p2).centerY=Particle(p2).Diam/2;
                                Particle(p2).state=PathAbort;
                            end
                            % if X over boundary,set X equal boundary
%                             if Particle(p2).centerX+Particle(p2).Diam/2>=InputMaxcenterX
%                                 Particle(p2).centerX=InputMaxcenterX-Particle(p2).Diam/2;
%                             end
                                
                            %                     set(handles.edit9,'Max',P_Nm);
                            %                     set(handles.edit9,'ListboxTop',hitCount);
%                                                 outputHit{1,end+1}=sprintf('Particle %d hit particle %d ,the contactangle is %f,hit points is (%f ; %f).\n This particle have hit %d Particles.Total hitting is %d.Hitting check is %d now.\n',p1,p2,contactAngleDegree,hitpointX,hitpointY,hitBallNumber,hitCount,hitcheck);
%                                                 set(handles.edit9,'String',outputHit);
                            %                     fprintf('same cue ball %d hit another ball ,this ball hit %d balls,hit ball number is %d,contactAngle is %f,hit points is %f.%f\n',p1,hitBallNumber,p2,contactAngleDegree,hitpointX,hitpointY);
                            %                     rectangle('position',[Particle(p1).centerX-Particle(p1).Diam/2 Particle(p1).centerY-Particle(p1).Diam/2 Particle(p1).Diam Particle(p1).Diam]);
                            %                     plot(hitpointX,hitpointY,'*');
                            %               fprintf('ball %d is hitting ball %d,hitting center is %f,%f and %f,%f \n',cueball(cueHitCount).Number,cueball(cueHitcount).hitball(hitBallNumber),Particle(p1).centerX,Particle(p1).centerY,Particle(p2).centerX,Particle(p2).centerY);
                            %                     msgout=['same cue ball %d hit anther ball ,this ball hit %d balls,hit ball number is %d,contactAngle is %f,hit points is %f.%f\n',p1,hitBallNumber,p2,contactAngleDegree,hitpointX,hitpointY,10];
                            %                     set(handles.listbox2,'string', msgout);
                        end
                    end
                end
            end
            %        toc
        end
%     end
else
    
    % for parallel
    P_Nmpar=P_Nm;
    for hitcheck=1:CHECK_TIMES
        %     if hitcheck~=CHECK_TIMES
        %         %     clf;
        %     end
        cueHitCount=0;
        hitCount=0;
        cueBallNumber1=0;
        for p1=1:P_Nmpar
            hitBallNumber=1;
            for p2=2:P_Nmpar
                
                %             if p1~=p2
                %                 distanceX(p1,p2)=abs(Particle(p1).centerX-Particle(p2).centerX);
                %                 distanceY(p1,p2)=abs(Particle(p1).centerY-Particle(p2).centerY);
                %                 circleDistance(p1,p2)=(Particle(p1).Diam+Particle(p2).Diam)/2;
                %                 distanceX=abs(Particle(p1).centerX-Particle(p2).centerX);
                %                 distanceY=abs(Particle(p1).centerY-Particle(p2).centerY);
                %                 circleDistance=(Particle(p1).Diam+Particle(p2).Diam)/2;
                
                
                
                %if distanceX(p1,p2)<=circleDistance(p1,p2)&&distanceY(p1,p2)<=circleDistance(p1,p2)
                %                 if distanceX(p1,p2)^2+ distanceY(p1,p2)^2<=circleDistance(p1,p2)^2
                if abs(Particle(p1).centerX-Particle(p2).centerX)^2+ abs(Particle(p1).centerY-Particle(p2).centerY)^2<=((Particle(p1).Diam+Particle(p2).Diam)/2)^2
                    hitCount=hitCount+1;
                    
                    %                 Ballhit(hitcount).cueball=p1;%the ball to hit other ball
                    %                 Ballhit(hitcount).cueball.hitball(hitBallnumber)=p2;%the ball be hit by the cue ball
                    
                    if cueBallNumber1~=p1
                        cueBallNumber1=p1;
                        cueHitCount=cueHitCount+1;
                    else
                        cueHitCount=cueHitCount+1;
                    end
                    
                    
                    hitpointX=(Particle(p1).centerX*Particle(p2).Diam+Particle(p2).centerX*Particle(p1).Diam)/(Particle(p2).Diam+Particle(p1).Diam);
                    hitpointY=(Particle(p1).centerY*Particle(p2).Diam+Particle(p2).centerY*Particle(p1).Diam)/(Particle(p2).Diam+Particle(p1).Diam);
                    contactAngle=atan((hitpointY-Particle(p1).centerY)/(hitpointX-Particle(p1).centerX));
                    
                    %                                         cueball(cueHitCount,hitcheck).cueNumber=p1;%the ball set to hit another ball
                    %                                         cueball(cueHitCount,hitcheck).hitball(hitBallNumber,1)=p2;%which ball the cueball hit
                    %                                         cueball(cueHitCount,hitcheck).hitball(hitBallNumber,2)=hitpointX;
                    %                                         cueball(cueHitCount,hitcheck).hitball(hitBallNumber,3)=hitpointY;
                    %                                         cueball(cueHitCount,hitcheck).hitball(hitBallNumber,Dimension+2)=contactAngle;
                    %                                         cueball(cueHitCount,hitcheck).hitTotalnumber=hitBallNumber;
                    contactAngleDegree=contactAngle/pi*180;  %radian to degree
                    
                    Particle(p1).Phit=true;
                    Particle(p2).Phit=true;
                    %                     if  Particle(p2).centerY> Particle(p1).centerY
                    Particle(p2).centerX=Particle(p1).centerX+(Particle(p2).Diam+Particle(p1).Diam)/2*cos(contactAngle);
                    Particle(p2).centerY=Particle(p1).centerY+(Particle(p2).Diam+Particle(p1).Diam)/2*sin(contactAngle);
                    Particle(p2).state=PathAbort;
                    %                     else
                    %                          Particle(p1).centerX=Particle(p2).centerX+(Particle(p1).Diam+Particle(p2).Diam)/2*cos(contactAngle);
                    %                          Particle(p1).centerY=Particle(p2).centerY+(Particle(p1).Diam+Particle(p2).Diam)/2*sin(contactAngle);
                    %                     end
                    
                    fprintf('same cue ball %d hit anther ball ,this ball hit %d balls,hit ball number is %d,contactAngle is %f,hit points is %f.%f\n',p1,hitBallNumber,p2,contactAngleDegree,hitpointX,hitpointY);
                    %                     rectangle('position',[Particle(p1).centerX-Particle(p1).Diam/2 Particle(p1).centerY-Particle(p1).Diam/2 Particle(p1).Diam Particle(p1).Diam]);
                    %                     plot(hitpointX,hitpointY,'*');
                    %               fprintf('ball %d is hitting ball %d,hitting center is %f,%f and %f,%f \n',cueball(cueHitCount).Number,cueball(cueHitcount).hitball(hitBallNumber),Particle(p1).centerX,Particle(p1).centerY,Particle(p2).centerX,Particle(p2).centerY);
                end
            end
            %         end
        end
    end
    %     end
end

% subplot(2,1,2);
% Particle_draw;

