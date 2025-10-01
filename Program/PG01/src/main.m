clear; clc; close all;

v_0 = @(x) sin(2*pi*x);
Tend = 0.3;
v_exact = @(x) sin(2*pi*(x+Tend));

N = 30; J = 100;
v_num = solve_pde(N, J, Tend, v_0);
shou_result(v_num, v_exact, Tend / N)

N = 10; J = 100;
v_num = solve_pde(N, J, Tend, v_0);
shou_result(v_num, v_exact, Tend / N)

%%

function v = solve_pde(N, J, Tend, v_0)
    dx = 1/J;
    dt = Tend / N;
    x = linspace(0,1,J+1);
    v = v_0(x);

    for n = 1:N
        v(1:end-1) = v(1:end-1) + dt/dx * (v(2:end) - v(1:end-1));
        v(end) = v(1);
    end
end

%%

function shou_result(v_num, v_exact, dt)
    x = linspace(0,1,length(v_num));
    v_exact_num = v_exact(x);
    [err_2, err_inf] = calc_error(v_num, v_exact_num);
    fprintf('\\Delta t = %.2f, err_2 = %.6e, err_inf = %.6e\n', ...
        dt, err_2, err_inf);

    figure;
    plot(x, v_num,'b--','DisplayName','Numerical solution');
    hold on; 
    plot(x, v_exact_num,'r-','DisplayName','Exact solution');
    legend; title(sprintf('\\Delta t = %.2f', dt));
    xlabel('x'); ylabel('u');
end

%%

function [err_2, err_inf] = calc_error(v_num, v_exact_num)
    err_2 = sqrt(mean((v_num - v_exact_num).^2));
    err_inf = max(abs(v_num - v_exact_num));
end
