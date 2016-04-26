global P_Nm;
Thick_Y=single(0);
% global ITERATION;
% global TIME_STEP;
% global N_TIME;
global InputMaxcenterX;
% global InputMaxcenterY;
% global InputMaxdiam;
% global CHECK_TIMES;
cla(handles.axes6);
Total_Parea_Y=single(0);
Circle_Angle=single(0);%arch angle
Arch_Area=single(0);
Circle_area=single(0);
Y_N=20;
Thick_Y=single(zeros(1,Y_N));
Porosity_Y=single(zeros(1,Y_N));

for STEP_H1=1:Y_N
   
    Thick_Y(STEP_H1)=STEP_H1*max([Particle.centerY])/Y_N;
    Total_area_Y=Thick_Y(STEP_H1)*(InputMaxcenterX);
    Total_Parea_Y=0;
    for ii=1:P_Nm
        
            Circle_area=pi*(Particle(ii).Diam^2)/4;
         if Particle(ii).centerX+Particle(ii).Diam/2<=InputMaxcenterX
            if Particle(ii).centerY+Particle(ii).Diam/2 <= Thick_Y(STEP_H1)
                Parea_Y=Circle_area;
            end
            if Particle(ii).centerY+Particle(ii).Diam/2>Thick_Y(STEP_H1) && Particle(ii).centerY<=Thick_Y(STEP_H1)
                Circle_Angle=acos((Thick_Y(STEP_H1)-Particle(ii).centerY)/(Particle(ii).Diam/2));
                Arch_Area=0.125*Particle(ii).Diam^2*(Circle_Angle-sin(Circle_Angle));
                Parea_Y=Circle_area- Arch_Area;
            end
            if Particle(ii).centerY>Thick_Y(STEP_H1) && Particle(ii).centerY-Particle(ii).Diam/2<Thick_Y(STEP_H1)
                Circle_Angle=acos((Particle(ii).centerY-Thick_Y(STEP_H1))/(Particle(ii).Diam/2));
                Arch_Area=0.125*Particle(ii).Diam^2*(Circle_Angle-sin(Circle_Angle));
                Parea_Y=Arch_Area;
            end
            if Particle(ii).centerY-Particle(ii).Diam/2 >= Thick_Y(STEP_H1)
                Parea_Y=0;
            end
            Total_Parea_Y=Total_Parea_Y+Parea_Y;
        end
        Porosity_Y(STEP_H1)=(Total_area_Y-Total_Parea_Y)/Total_area_Y;

     
    end
       
%         title(handles.axes6,(sprintf('Average Porosity at %g microseconds',i1*TIME_STEP)));
end
        hold(handles.axes6,'on');
        plot(handles.axes6,Thick_Y,Porosity_Y,'r*');
        axis(handles.axes6,[0 max([Particle.centerY]) 0 1]);
        xlabel(handles.axes6,'Average Particle Porosity below Y direction.(unit:¦Ìm)');
        ylabel(handles.axes6,'Average Porosity.');