global ITERATION;
% clear;
% Particle_parallel;
% clf;
% particlepar = [];
Particle_init;
Particle_sortbyY;
%subplot(2,1,1);
% Particle_draw;
% ITERATION=40;
if isempty(particlepar)
    for i=1:ITERATION
        pause(0.01);
%         cla(handles.axes4);
cla;
        Particle_movement;
        Particle_hit_check;
        Particle_sortbyY;
        Particle_draw;
    end
%     subplot(2,1,2);
%     Particle_draw;
else
    parfor i=1:ITERATION
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