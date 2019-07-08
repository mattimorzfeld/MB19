function myerrorCloud(x,y,z)
% Color1 = [1 1 1]';
h = patch([z;z(end);z(end:-1:1);z(1)],[(x+y);max(x(end)-y(end),1e-8);max(x(end:-1:1)-y(end:-1:1),1e-9);(x(1)+y(2))],'g');
set(h,'FaceColor','k')
set(h,'EdgeColor','k')
set(h,'LineStyle','-')
set(h,'FaceAlpha',0.05)
set(h,'EdgeAlpha',1)
% hold on, plot(z,exp(x),'Color',Color2,'LineWidth',2)