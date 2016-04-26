global P_Nm;

% axes(handles.axes4);
RandseedBound=0:pi/50:2*pi;

hold(handles.axes4,'on');
if isempty(particlepar)
    for P_id=1:P_Nm
        
        Particle(P_id).BoundX=(Particle(P_id).Diam/2)*sin(RandseedBound)+Particle(P_id).centerX;
        Particle(P_id).BoundY=(Particle(P_id).Diam/2)*cos(RandseedBound)+Particle(P_id).centerY;
%         Particle.BoundX=sin(RandseedBound)*(Particle.Diam)+Particle.centerX;
%         Particle.BoundY=cos(RandseedBound)*(Particle.Diam)+Particle.centerY;
        
        %         handles.axes4.YLimMode='manual';
        %         handles.axes4.YLim=[0,100];
        %         ylim(handles.axes4,[0,200]);
        %          axis manual;
       
        h=plot(handles.axes4,Particle(P_id).BoundX,Particle(P_id).BoundY); 
   
%         h=plot(handles.axes4,Particle.BoundX,Particle.BoundY); 
    
        
%         fill(x1,y1,'k');
    end
%         axis(handles.axes4,'equal');
        axis(handles.axes4,'image');
        xlabel(handles.axes4,'Particle distribution on X position.(unit:¦Ìm)');
        ylabel(handles.axes4,'Y position.(unit:¦Ìm)');
        title(handles.axes4,(sprintf('Two-dimension particle deposition at %g microseconds',i1*TIME_STEP)));
%         h=plot(handles.axes4,Particle.BoundX,Particle.BoundY); 
        x1=get(h,'xdata');
        y1=get(h,'ydata');
        hold(handles.axes4,'off');

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

