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
