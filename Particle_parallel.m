global PARALLEL_SIZE;
PARALLEL_SIZE=12;
p=gcp('nocreate');
if isempty(p)
particlepar=parpool('local',PARALLEL_SIZE);
else
    fprintf('Current parallel setting is %d workers',p.NumWorkers);
end
delete(gcp('nocreate'));