function show_results(J, t, method, v_num, v_exact, x)
    [l2loss, linfloss] = calcloss(v_num, v_exact);

    fprintf('J = %d, t = %.1f, %s:\n L_2 = %.2e, L_inf = %.2e\n', ...
            J, t, method, l2loss, linfloss);

    figure('Position', [100, 100, 600, 400]);
    plot(x, v_num, 'ro-', 'LineWidth', 1.5, 'MarkerSize', 4, 'DisplayName', '数值解');
    hold on;
    plot(x, v_exact, 'b-', 'LineWidth', 2, 'DisplayName', '精确解');
    hold off;

    xlabel('x', 'FontSize', 12);
    ylabel('u(x,t)', 'FontSize', 12);
    title(sprintf('%s方法 (J=%d, t=%.1f)', method, J, t), 'FontSize', 14);
    legend('Location', 'best', 'FontSize', 10);
    grid on;

    filename = sprintf('fig/result_J%d_t%.1f_%s.eps', J, t, method);
    if ~exist('fig', 'dir')
        mkdir('fig');
    end
    saveas(gcf, filename, 'epsc');
    close(gcf);
end

%%

function [l2loss, linfloss] = calcloss(v_num, v_exact)
    l2loss = norm(v_num - v_exact) / norm(v_exact);
    linfloss = max(abs(v_num - v_exact));
end
