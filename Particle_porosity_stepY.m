global P_Nm;
Thick_YT=single(0);
% global ITERATION;
% global TIME_STEP;
% global N_TIME;
global InputMaxcenterX;
% global InputMaxcenterY;
% global InputMaxdiam;
% global CHECK_TIMES;

%initialize var
cla(handles.axes7);
Total_Parea_YT=single(0);
Circle_Angle_T=single(0);%arch angle
Arch_Area_T=single(0);
Circle_area_T=single(0);
Y_N=20;
STEP_H=1;

%initialize axes
hold(handles.axes7,'on');
xlabel(handles.axes7,sprintf('Average Particle Porosity at Y direction step %g.(unit:¦Ìm)',max([Particle.Diam])));
ylabel(handles.axes7,'Average Porosity.');
axis(handles.axes7,[0 max([Particle.centerY]) 0 1]);
%do while the current top line below the max particle height
while Thick_YT<=max([Particle.centerY])+max([Particle.Diam])
    %initialize ever line step var
    STEP_YT=max([Particle.Diam]);
    Thick_YT=STEP_YT*STEP_H;
    Total_Area_YT=max([Particle.Diam])*(InputMaxcenterX);
    Total_Parea_YT=0;
    Topline_YT=Thick_YT;
    Bottomline_YT=Thick_YT-STEP_YT;
    
    for ii1=1:P_Nm
        Ctop=Particle(ii1).centerY+Particle(ii1).Diam/2;
        Cbottom=Particle(ii1).centerY-Particle(ii1).Diam/2;
        Circle_area_T=pi*(Particle(ii1).Diam^2)/4;
        if Particle(ii1).centerX+Particle(ii1).Diam/2<=InputMaxcenterX
            %above top line
            if Cbottom >= Topline_YT
                Parea_Y_T=0;
            end
            %half above top line
            if Ctop>Topline_YT && Particle(ii1).centerY<=Topline_YT
                Circle_Angle_T=2*acos((Topline_YT-Particle(ii1).centerY)/(Particle(ii1).Diam/2));
                Arch_Area_T=0.125*Particle(ii1).Diam^2*(Circle_Angle_T-sin(Circle_Angle_T));
                Parea_Y_T=Circle_area_T-Arch_Area_T;
            end
            %half below top line
            if Particle(ii1).centerY>Topline_YT && Cbottom<=Topline_YT
                Circle_Angle_T=2*acos((Particle(ii1).centerY-Topline_YT)/(Particle(ii1).Diam/2));
                Arch_Area_T=0.125*Particle(ii1).Diam^2*(Circle_Angle_T-sin(Circle_Angle_T));
                Parea_Y_T=Arch_Area_T;
            end
            %between two lines,this case should make sure the diameter is
            %smaller than the tow line distance or there will be another
            %case which the ball inlay the two lines
            if Ctop < Topline_YT && Cbottom>=Bottomline_YT
                Parea_Y_T=Circle_area_T;
            end
            %half above bottom line
            if Particle(ii1).centerY>Bottomline_YT && Cbottom<=Bottomline_YT
                Circle_Angle_T=2*acos((Particle(ii1).centerY-(Bottomline_YT))/(Particle(ii1).Diam/2));
                Arch_Area_T=0.125*Particle(ii1).Diam^2*(Circle_Angle_T-sin(Circle_Angle_T));
                Parea_Y_T=Circle_area_T-Arch_Area_T;
            end
            %half below bottom line
            if Particle(ii1).centerY<Bottomline_YT && Ctop>=Bottomline_YT
                Circle_Angle_T=2*acos((Particle(ii1).centerY-(Bottomline_YT))/(Particle(ii1).Diam/2));
                Arch_Area_T=0.125*Particle(ii1).Diam^2*(Circle_Angle_T-sin(Circle_Angle_T));
                Parea_Y_T=Arch_Area_T;
            end
            %below bottom line
            if Ctop < Bottomline_YT
                Parea_Y_T=0;
            end
            
            Total_Parea_YT=Total_Parea_YT+Parea_Y_T;
        end
        %count the area with each case to sum the total filled area
        Porosity_Y_T=(Total_Area_YT-Total_Parea_YT)/Total_Area_YT;
        
        
    end
    %plot the porosity for current top and bottom line position
    plot(handles.axes7,Thick_YT,Porosity_Y_T,'ko');
    
    % title(handles.axes7,(sprintf('Average Porosity at %g microseconds',i1*TIME_STEP)));

    %for next line position
    STEP_H=STEP_H+1;
end
