global P_Nm;

% global fighandles;
% particlepar = ExEmpty.empty;
%     minbounx=0;
%     maxbounx=1;
%     minbouny=0;
%     maxbouny=1;
% clf;
RandseedBound=0:pi/50:2*pi;
if isempty(particlepar)
    for P_id=1:P_Nm
        
        Particle(P_id).BoundX=(Particle(P_id).Diam/2)*sin(RandseedBound)+Particle(P_id).centerX;
        Particle(P_id).BoundY=(Particle(P_id).Diam/2)*cos(RandseedBound)+Particle(P_id).centerY;
        %     subplot(2,1,2);
        %
        hold on;
        plot(handles.axes3,Particle(P_id).BoundX,Particle(P_id).BoundY);
        axis equal;
        axis auto;
    end
    %     if min(Particle(P_id).BoundX)<minbounx
    %         minbounx=min(Particle(P_id).BoundX);
    %     end
    %     if max(Particle(P_id).BoundX)>minbounx
    %         minbounx=min(Particle(P_id).BoundX);
    %     end
    %     if min(Particle(P_id).BoundY)<minbouny
    %         minbouny=min(Particle(P_id).BoundY);
    %     end
    %     if max(Particle(P_id).BoundY)>maxbouny
    %         maxbouny=max(Particle(P_id).BoundY);
    %     end
    %     axis([minbounx maxbounx minbouny maxbouny]);
    %     axis image;
    % axis square;
    %     axis auto;
    % axis manual;
    
    
else
    %parallel open
    parfor P_id=1:P_Nm
        
        Particle(P_id).BoundX=(Particle(P_id).Diam/2)*sin(RandseedBound)+Particle(P_id).centerX;
        Particle(P_id).BoundY=(Particle(P_id).Diam/2)*cos(RandseedBound)+Particle(P_id).centerY;
        %     subplot(2,1,2);
        hold on;
        plot(Particle(P_id).BoundX,Particle(P_id).BoundY);
        axis equal;
        axis auto;
        
        
        %     if min(Particle(P_id).BoundX)<minbounx
        %         minbounx=min(Particle(P_id).BoundX);
        %     end
        %     if max(Particle(P_id).BoundX)>minbounx
        %         minbounx=min(Particle(P_id).BoundX);
        %     end
        %     if min(Particle(P_id).BoundY)<minbouny
        %         minbouny=min(Particle(P_id).BoundY);
        %     end
        %     if max(Particle(P_id).BoundY)>maxbouny
        %         maxbouny=max(Particle(P_id).BoundY);
        %     end
        %     axis([minbounx maxbounx minbouny maxbouny]);
        %     axis image;
        % axis square;
        %     axis auto;
        % axis manual;
    end
end

