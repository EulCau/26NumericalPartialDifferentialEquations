function v = solve_pde(N, J, Tend, v_0, scheme)
    % 求解对流方程 u_t = u_x 使用不同差分格式
    dx = 1/J;
    dt = Tend / N;
    x = linspace(0,1,J+1);
    v = v_0(x);

    switch scheme
        case 'A'  % 前差近似
            for n = 1:N
                % 更新内部点
                v(1:end-1) = v(1:end-1) + dt/dx * (v(2:end) - v(1:end-1));
                % 周期边界条件
                v(end) = v(1);
            end
                
        case 'B'  % 中心差近似
            for n = 1:N
                v_old = v;
                % 更新内部点
                for j = 2:J
                    v(j) = v_old(j) + ...
                        dt/(2*dx) * (v_old(j+1) - v_old(j-1));
                end
                % 周期边界条件
                v(1) = v_old(1) + dt/(2*dx) * (v_old(2) - v_old(J));
                v(J+1) = v(1);
            end
                
        case 'C'  % 后差近似
            for n = 1:N
                v_old = v;
                % 更新内部点
                for j = 2:J+1
                    v(j) = v_old(j) + dt/dx * (v_old(j) - v_old(j-1));
                end
                % 周期边界条件
                v(1) = v_old(1) + dt/dx * (v_old(1) - v_old(J+1));
            end
    end
end
