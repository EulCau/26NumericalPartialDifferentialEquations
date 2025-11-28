function v = solve_pde(N, J, Tend, v_0, scheme)
    dx = 1/J;
    dt = Tend / N;
    lambda = dt / dx;
    x = linspace(0,1,J+1);
    v = v_0(x);

    switch scheme
        case 'FTCS'
            for n = 1:N
                v_old = v;
                for j = 2:J
                    v(j) = v_old(j) - ...
                        dt/(2*dx) * (v_old(j+1) - v_old(j-1));
                end
                v(1) = v_old(1) - dt/(2*dx) * (v_old(2) - v_old(J));
                v(J+1) = v(1);
            end
                
        case 'FTBS'
            for n = 1:N
                v_old = v;
                for j = 2:J+1
                    v(j) = v_old(j) - dt/dx * (v_old(j) - v_old(j-1));
                end
                v(1) = v_old(1) - dt/dx * (v_old(1) - v_old(J+1));
            end

        case 'Lax-Friedrich'
            for n = 1:N
                v_old = v;
                for j = 2:J
                    v(j) = 0.5*(v_old(j+1) + v_old(j-1)) ...
                         - 0.5*lambda*(v_old(j+1) - v_old(j-1));
                end
                v(1) = 0.5*(v_old(2) + v_old(J)) ...
                     - 0.5*lambda*(v_old(2) - v_old(J));
                v(J+1) = v(1);
            end

        case 'Lax-Wendroff'
            for n = 1:N
                v_old = v;
                for j = 2:J
                    v(j) = v_old(j) ...
                         - 0.5*lambda*(v_old(j+1) - v_old(j-1)) ...
                         + 0.5*lambda^2*(v_old(j+1) - 2*v_old(j) + v_old(j-1));
                end
                v(1) = v_old(1) ...
                     - 0.5*lambda*(v_old(2) - v_old(J)) ...
                     + 0.5*lambda^2*(v_old(2) - 2*v_old(1) + v_old(J));
                v(J+1) = v(1);
            end
    end
end
