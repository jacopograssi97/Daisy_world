function[l_f,T_e_f, area_b_f, area_w_f, area_g_f, albedo_p_f, frec] = fourier_analysis(...
    l, T_e, area_b, area_w, area_g, albedo_p, plt)

    [l_f,frec] = four(l);
    [T_e_f,frec] = four(T_e);
    [area_b_f,frec] = four(area_b);
    [area_w_f,frec] = four(area_w);
    [area_g_f,frec] = four(area_g);
    [albedo_p_f,frec] = four(albedo_p);

    if plt == 1
        F2 = figure;
        F2.Position = [90 90 600 700];

        m1 = tiledlayout(4,1);
        m1.Padding = 'tight';
        m1.TileSpacing = 'tight';
        
        nexttile
        plot(1./frec,l_f)
        ylabel('R_i [W/m^2]')
        set(gca,'xticklabel',{[]})
        grid on
        set(gca,'box','off')
        set(gca,'FontSize',12,'FontName','Calibri');
        xlim([0 300])

        nexttile
        plot(1./frec,T_e_f)
        ylabel('T_e [°C]')
        set(gca,'xticklabel',{[]})
        grid on
        set(gca,'box','off')
        set(gca,'FontSize',12,'FontName','Calibri');
        xlim([0 300])

        nexttile
        plot(1./frec,area_b_f,'DisplayName','Black')
        hold on
        plot(1./frec,area_w_f,'DisplayName','White')
        ylabel('Area')
        set(gca,'xticklabel',{[]})
        grid on
        legend
        set(gca,'box','off')
        set(gca,'FontSize',12,'FontName','Calibri');
        xlim([0 300])

        nexttile
        plot(1./frec,albedo_p_f)
        xlabel('Period')
        grid on
        ylabel('Total albedo')
        set(gca,'box','off')
        set(gca,'FontSize',12,'FontName','Calibri');
        xlim([0 300])
        hold off
    end
end



function [f_s,frec] = four(s)
    s_f = fft(s);
    P_s_f = abs(s_f/length(s));
    f_s = P_s_f(1:length(s)/2+1);
    f_s(2:end-1) = 2*f_s(2:end-1);
    frec = (0:(length(s)/2))/length(s);
end