function plot_w = plot_world(S_0, l, T, a_b, a_w, alpha, t)
    
    m = tiledlayout(4,1);
    m.Padding = 'tight';
    m.TileSpacing = 'tight';

    nexttile
    plot(t,S_0*l)
    ylabel('R_i [W/m^2]')
    set(gca,'xticklabel',{[]})
    grid on
    set(gca,'box','off')
    set(gca,'FontSize',12,'FontName','Calibri');

    nexttile
    plot(t,T)
    ylabel('T_e [°C]')
    set(gca,'xticklabel',{[]})
    grid on
    set(gca,'box','off')
    set(gca,'FontSize',12,'FontName','Calibri');

    nexttile
    plot(t,a_b,'DisplayName','Black')
    hold on
    plot(t,a_w,'DisplayName','White')
    ylabel('Area')
    set(gca,'xticklabel',{[]})
    grid on
    legend
    set(gca,'box','off')
    set(gca,'FontSize',12,'FontName','Calibri');

    nexttile
    plot(t,alpha)
    xlabel('Steps')
    grid on
    ylabel('Total albedo')
    set(gca,'box','off')
    set(gca,'FontSize',12,'FontName','Calibri');
    hold off

    plot_w = 1;
end