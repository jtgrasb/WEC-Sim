function FormatPlot(fig,heading,subtitle,x_lables,y_lables,X_data,Y_data,legends,notes)
axes1 = axes('Parent',fig,'Position',[0.0731 0.3645 0.2521 0.4720]);
hold(axes1,'on');
box(axes1,'on');
title(subtitle(1));
xlabel(x_lables(1),'Interpreter','latex');
ylabel(y_lables(1),'Interpreter','latex');

axes2 = axes('Parent',fig,'Position',[0.3983 0.3645 0.2521 0.4720]);
hold(axes2,'on');
box(axes2,'on');
title(subtitle(2));
xlabel(x_lables(2),'Interpreter','latex');
ylabel(y_lables(2),'Interpreter','latex');

axes3 = axes('Parent',fig,'Position',[0.7235 0.3645 0.2521 0.4720]);
hold(axes3,'on');
box(axes3,'on');
title(subtitle(3));
xlabel(x_lables(3),'Interpreter','latex');
ylabel(y_lables(3),'Interpreter','latex');

annotation(fig,'textbox',[0.0 0.9 1.0 0.1],...
    'String',heading,...
    'Interpreter','latex',...
    'HorizontalAlignment','center',...
    'FitBoxToText','off',...
    'FontWeight','bold',...
    'FontSize',12,...
    'EdgeColor','none');
annotation(fig,'textbox',[0.0 0.0 1.0 0.2628],...
    'String',notes,...
    'Interpreter','latex',...
    'FitBoxToText','off',...
    'EdgeColor','none');

[p,b,s]=size(Y_data);
for i = 1:b
    plot(X_data,squeeze(Y_data(1,i,:)),'LineWidth',1,'Parent',axes1);
    plot(X_data,squeeze(Y_data(2,i,:)),'LineWidth',1,'Parent',axes2);
    plot(X_data,squeeze(Y_data(3,i,:)),'LineWidth',1,'Parent',axes3);
end
legend(axes1,legends(1,:),'location','best','Box','off','Interpreter','none')
legend(axes2,legends(2,:),'location','best','Box','off','Interpreter','none')
legend(axes3,legends(3,:),'location','best','Box','off','Interpreter','none')
end