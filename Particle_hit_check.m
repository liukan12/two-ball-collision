global P_Nm;
global Dimension;
global CHECK_TIMES;
Dimension=2;

% clf;
% Particle_init;
distanceX=zeros(P_Nm);
distanceY=zeros(P_Nm);
circleDistance=zeros(P_Nm);
hitpointsX=double(0);
hitpointsY=double(0);
contactAngle=double(0);
hitCount=0;
hitBallNumber=1;
cueBallNumber=0;
cueHitCount=0;
% CHECK_TIMES=5;
% for CHECK_TIMES=1:5
% cueball(1:P_Nm,CHECK_TIMES)=struct('cueNumber',int32(0),...
%     'hitball',double(zeros(P_Nm-1,Dimension+2)),... %last column present hitAngle,first column present the hitnumber,second for hit x cor,third for hit y cor,fourth for hit z cor,
%     'hitTotalnumber',double(0)...
%     );
% end

cueball(1:P_Nm,1:CHECK_TIMES)=struct('cueNumber',int32(0),...
    'hitball',double(zeros(P_Nm-1,Dimension+2)),... %last column present hitAngle,first column present the hitnumber,second for hit x cor,third for hit y cor,fourth for hit z cor,
    'hitTotalnumber',double(0)...
    );
% Ballhit(1:((1+P_Nm)*P_Nm/2))=struct('cueball',double(0),...
% 'hitball',double(0));

%AABBcheck
% for P_id=1:P_Nm
% AABBMaxX(P_id)=Particle(P_id).centerX+Particle(P_id).Diam/2;
% AABBMaxY(P_id)=Particle(P_id).centerY+Particle(P_id).Diam/2;
% AABBMinX(P_id)=Particle(P_id).centerX-Particle(P_id).Diam/2;
% AABBMinY(P_id)=Particle(P_id).centerY-Particle(P_id).Diam/2;
% end
if isempty(particlepar)
    for hitcheck=1:CHECK_TIMES
        %     if hitcheck~=CHECK_TIMES
        %         %     clf;
        %     end
        Particle_sortbyY;
        cueHitCount=0;
        hitCount=0;
        
        for p1=1:P_Nm
            hitBallNumber=1;
            for p2=(p1+1):P_Nm
                
                %             if p1~=p2
                distanceX(p1,p2)=abs(Particle(p1).centerX-Particle(p2).centerX);
                distanceY(p1,p2)=abs(Particle(p1).centerY-Particle(p2).centerY);
                circleDistance(p1,p2)=(Particle(p1).Diam+Particle(p2).Diam)/2;
%                 distanceX=abs(Particle(p1).centerX-Particle(p2).centerX);
%                 distanceY=abs(Particle(p1).centerY-Particle(p2).centerY);
%                 circleDistance=(Particle(p1).Diam+Particle(p2).Diam)/2;
                
                
                
                %if distanceX(p1,p2)<=circleDistance(p1,p2)&&distanceY(p1,p2)<=circleDistance(p1,p2)
                if distanceX(p1,p2)^2+ distanceY(p1,p2)^2<=circleDistance(p1,p2)^2
                    %                 if abs(Particle(p1).centerX-Particle(p2).centerX)^2+ abs(Particle(p1).centerY-Particle(p2).centerY)^2<=((Particle(p1).Diam+Particle(p2).Diam)/2)^2
                    hitCount=hitCount+1;
                    
                    %                 Ballhit(hitcount).cueball=p1;%the ball to hit other ball
                    %                 Ballhit(hitcount).cueball.hitball(hitBallnumber)=p2;%the ball be hit by the cue ball
                    
                    if cueBallNumber~=p1
                        cueBallNumber=p1;
                        cueHitCount=cueHitCount+1;
                        fprintf('another ball hit,total hit ball is %d\n',cueHitCount);
                    else
                        hitBallNumber=hitBallNumber+1;
                    end
                    
                    
                    hitpointX=(Particle(p1).centerX*Particle(p2).Diam+Particle(p2).centerX*Particle(p1).Diam)/(Particle(p2).Diam+Particle(p1).Diam);
                    hitpointY=(Particle(p1).centerY*Particle(p2).Diam+Particle(p2).centerY*Particle(p1).Diam)/(Particle(p2).Diam+Particle(p1).Diam);
                    contactAngle=atan((hitpointY-Particle(p1).centerY)/(hitpointX-Particle(p1).centerX));
                    
%                     cueball(cueHitCount,hitcheck).cueNumber=p1;%the ball set to hit another ball
%                     cueball(cueHitCount,hitcheck).hitball(hitBallNumber,1)=p2;%which ball the cueball hit
%                     cueball(cueHitCount,hitcheck).hitball(hitBallNumber,2)=hitpointX;
%                     cueball(cueHitCount,hitcheck).hitball(hitBallNumber,3)=hitpointY;
%                     cueball(cueHitCount,hitcheck).hitball(hitBallNumber,Dimension+2)=contactAngle;
%                     cueball(cueHitCount,hitcheck).hitTotalnumber=hitBallNumber;
                    contactAngleDegree=contactAngle/pi*180;  %radian to degree
                    
                    Particle(p1).Phit=true;
                    Particle(p2).Phit=true;
%                     if Particle(p2).centerY>Particle(p1).centerY
                        Particle(p2).centerX=Particle(p1).centerX+(Particle(p2).Diam+Particle(p1).Diam)/2*cos(contactAngle);
                        Particle(p2).centerY=Particle(p1).centerY+(Particle(p2).Diam+Particle(p1).Diam)/2*sin(contactAngle);
                        if Particle(p2).centerY<=Particle(p2).Diam/2
                            Particle(p2).centerY=Particle(p2).Diam/2;
                             Particle(p2).state=PathAbort;
                        end
%                        
%                     else
%                         Particle(p1).centerX=Particle(p2).centerX+(Particle(p1).Diam+Particle(p2).Diam)/2*cos(contactAngle);
%                         Particle(p1).centerY=Particle(p2).centerY+(Particle(p1).Diam+Particle(p2).Diam)/2*sin(contactAngle);
                        
%                     end
                    
                    
                    fprintf('same cue ball %d hit anther ball ,this ball hit %d balls,hit ball number is %d,contactAngle is %f,hit points is %f.%f\n',p1,hitBallNumber,p2,contactAngleDegree,hitpointX,hitpointY);
                    %                     rectangle('position',[Particle(p1).centerX-Particle(p1).Diam/2 Particle(p1).centerY-Particle(p1).Diam/2 Particle(p1).Diam Particle(p1).Diam]);
                    %                     plot(hitpointX,hitpointY,'*');
                    %               fprintf('ball %d is hitting ball %d,hitting center is %f,%f and %f,%f \n',cueball(cueHitCount).Number,cueball(cueHitcount).hitball(hitBallNumber),Particle(p1).centerX,Particle(p1).centerY,Particle(p2).centerX,Particle(p2).centerY);
%                     msgout=['same cue ball %d hit anther ball ,this ball hit %d balls,hit ball number is %d,contactAngle is %f,hit points is %f.%f\n',p1,hitBallNumber,p2,contactAngleDegree,hitpointX,hitpointY,10];
%                     set(handles.listbox2,'string', msgout);
                end
            end
            %         end
        end
    end
else
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
                        fprintf('another ball hit,total hit ball is %d\n',cueHitCount);
                    else
                        hitBallNumber=hitBallNumber+1;
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

