function PlotFeatureLF(D,g,Ts,f,Color)

S = 2*D./(g^2+4*pi^2*f.^2);
hold on, loglog(f,S,'Color',Color,'LineWidth',2)
fTF = exp(-4*pi^2*f.^2*Ts^2/24);
S = S.*(fTF.^2);
hold on, loglog(f,S,'Color',Color,'LineWidth',2)
set(gca,'Yscale','log')
set(gca,'Xscale','log')