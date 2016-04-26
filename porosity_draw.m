% hold on;
% global P_Nm;
global ITERATION;
global TIME_STEP;
% global N_TIME;
% global InputMaxcenterX;
% global InputMaxcenterY;
% global InputMaxdiam;
% global CHECK_TIMES;

hold(handles.axes5,'on');
plot(handles.axes5,i1*TIME_STEP,Porosity,'gs');
axis(handles.axes5,[0 ITERATION*TIME_STEP 0 1]);
xlabel(handles.axes5,'Particle deposition time.(unit:¦Ìs)');
ylabel(handles.axes5,'Average Porosity.');
% title(handles.axes5,(sprintf('Average Porosity at 0 to %g microseconds',i1*TIME_STEP)));