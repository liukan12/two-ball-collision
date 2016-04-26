global P_Nm;
% global ITERATION;
% global TIME_STEP;
% global N_TIME;
global InputMaxcenterX;
% global InputMaxcenterY;
% global InputMaxdiam;
% global CHECK_TIMES;

Total_Parea=0;

Total_area=max([Particle.centerY])*(InputMaxcenterX);
for ii=1:P_Nm
    Parea=pi*(Particle(ii).Diam^2)/4;
    if Particle(ii).centerX+Particle(ii).Diam/2<=InputMaxcenterX
        Total_Parea=Total_Parea+Parea;
    end
end
Porosity=(Total_area-Total_Parea)/Total_area;