function [T_e, area_b, area_w, area_g, albedo_p] = simulate_world( ...
    ... % Incoming radiation properties
    S_0, l, ... 
    ... % Albedoes
    a_b, a_w, a_g, ...
    ... % Initial areas
    area_b_ini, area_w_ini, ...
    ... % Constants
    q, mu, p, f, sigma)

    T_e = zeros(length(l),1);
    area_g = zeros(length(l),1);
    area_b = zeros(length(l),1);
    area_w = zeros(length(l),1);
    albedo_p = zeros(length(l),1);

    area_b(1) = area_b_ini;
    area_w(1) = area_w_ini;
    area_g(1) = p - area_b_ini - area_w_ini;
    albedo_p(1) = area_g(1)*a_g + area_b_ini*a_b + area_w_ini*a_w;
    T_e(1) = (l(1)*S_0*(1-albedo_p(1))/sigma)^0.25-273;
    

    for i=2:length(l)
            % Values at step n 
        [T_e(i),area_b(i),area_w(i), area_g(i), albedo_p(i)] = update_world( ...
        ... % Values at step n-1
        T_e(i-1), area_b(i-1), area_w(i-1), area_g(i-1), albedo_p(i-1), ...
        ... % Constants
        a_b, a_w, a_g, q, f, mu(i), p, S_0, sigma, ...
        ... % Luminosity
        l(i));
    end

end


function [T_e_1,area_b_1,area_w_1, area_g_1, albedo_p_1] = update_world( ...
    ... % Values at step n-1
    T_e_0, area_b_0, area_w_0, area_g_0, albedo_p_0, ...
    ... % Constants
    a_b, a_w, a_g, q, f, mu, p, S_0, sigma, ...
    ... % Luminosity
    l)

    % Computing temperatures
    T_b = q*(albedo_p_0-a_b) + T_e_0;
    T_w = q*(albedo_p_0-a_w) + T_e_0;

    g_b = 1 - f*(22.5-T_b)^2;
    g_w = 1 - f*(22.5-T_w)^2;

    da_b = area_b_0*(area_g_0*g_b - mu);
    da_w = area_w_0*(area_g_0*g_w - mu);

    area_b_1 = area_b_0 + da_b;
    area_w_1 = area_w_0 + da_w;

    area_g_1 = p - area_b_1 - area_w_1;
    albedo_p_1 = area_g_1*a_g + area_b_1*a_b + area_w_1*a_w;
    T_e_1 = (l*S_0*(1-albedo_p_1)/sigma)^0.25-273;
end