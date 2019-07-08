function MyPlotLine(x,y,C,W,S)
colors
if isempty(S)
    plot(x,y,'Color',Color(:,C),'LineWidth',W)
else
    plot(x,y,S,'Color',Color(:,C),'LineWidth',W)
end
set(gcf,'Color','w')
set(gca,'FontSize',16)
box off
