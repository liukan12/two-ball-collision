%this script sort the particle structure by center Y cordinate
ParticleSortY= struct2table(Particle);
ParticleSortY1=sortrows(ParticleSortY,2);
Particle=table2struct(ParticleSortY1);