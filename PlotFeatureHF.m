
function PlotFeatureHF(D,g,a,f,Color)

S = 2*D./(g^2+4*pi^2*f.^2);
S = (S*a^2)./(a^2+4*pi*f.^2); % colored noise

hold on,loglog(f,S,'Color',Color,'LineWidth',2)
set(gca,'Yscale','log')
set(gca,'Xscale','log')