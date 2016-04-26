global ITERATION;
global TIME_STEP;
global END_REQUEST;
END_REQUEST=0;
% profile on;
% clear;
% Particle_parallel;
% clf;
% particlepar = [];
Particle_init;
Particle_sortbyY;
Pdraw=get(handles.Pdrawlast,'value') ;
Porosity1=single(zeros(1,ITERATION));
%subplot(2,1,1);
% Particle_draw;
% ITERATION=40;
cla(handles.axes5);
% tic
if isempty(particlepar)
    for i1=1:ITERATION
        if END_REQUEST==1
            break
        end
        
        set(handles.text9,'String',sprintf('Current time is %f second, %d iterations remain.',i1*TIME_STEP,ITERATION-i1));
        pause(0.01);
        cla(handles.axes4);

        Particle_movement;
%         Particle_sortbyY;
        Particle_hit_check_C;
        Particle_porosity;
        if Pdraw ~=1
        Particle_draw;
        porosity_draw;
        end
  
        Porosity1(i1)=Porosity;
  
    end
   porosity_draw1;
   Particle_draw; 
   Particle_porosity_byY;
   Particle_porosity_stepY;
   
%    toc
%    profile off;
%    profile viewer;
%     subplot(2,1,2);
%     Particle_draw;
else
    parfor i1=1:ITERATION
        Particle_movement;
        Particle_hit_check;
    end
    subplot(2,1,2);
    Particle_draw;
end

% for P_id=1:P_Nm
% %     if Particle(P_id).centerY<=Particle(P_id).Diam/2
% %         Particle(P_id).BoundY=Particle(P_id).BoundY+(Particle(P_id).Diam/2-Particle(P_id).centerY);
% %         Particle(P_id).centerY=Particle(P_id).Diam/2;
% %     end
%     plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
% %     subplot(2,1,2);
%     hold on;
%     axis equal;
%     axis auto;
% end