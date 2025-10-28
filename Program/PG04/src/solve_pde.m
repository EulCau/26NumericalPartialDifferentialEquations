function v = solve_pde(N, J, Tend, v_0, scheme)
    dx = 1 / J;
    dt = Tend / N;
    lambda = dt / dx;
    x = linspace(0, 1, J+1);
    v = v_0(x);

    switch scheme
        case 'CTCS'
            % Central Time Central Space
            v_old = v; % t = 0
            % 第一步使用 FTFS 启动
            v(1:J) = v_old(1:J) - lambda * (v_old(2:J+1) - v_old(1:J));
            v(J+1) = v(1);
            v_older = v_old; % 保存 t=0
            v_old = v;       % 保存 t=dt
            for n = 2:N
                for j = 2:J
                    v(j) = v_older(j) - lambda * (v_old(j+1) - v_old(j-1));
                end
                v(1) = v_older(1) - lambda * (v_old(2) - v_old(J));
                v(J+1) = v(1);
                v_older = v_old;
                v_old = v;
            end

        case 'FTBS'
            % Forward Time Backward Space
            for n = 1:N
                v_old = v;
                for j = 2:J+1
                    v(j) = v_old(j) - lambda * (v_old(j) - v_old(j-1));
                end
                v(1) = v(J+1);
            end
    end
end
