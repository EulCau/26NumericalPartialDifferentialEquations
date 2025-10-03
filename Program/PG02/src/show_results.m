function show_results(v_num_A, v_num_B, v_num_C, v_exact, title_str)
    fprintf('=== %s ===\n', title_str)
    x = linspace(0,1,length(v_num_A));
    v_exact_num = v_exact(x);
    
    % 计算误差
    [err_2_A, err_inf_A] = calc_error(v_num_A, v_exact_num);
    [err_2_B, err_inf_B] = calc_error(v_num_B, v_exact_num);
    [err_2_C, err_inf_C] = calc_error(v_num_C, v_exact_num);
    
    % 输出误差
    fprintf('方案 A: L2 误差 = %.6e, 最大误差 = %.6e\n', err_2_A, err_inf_A);
    fprintf('方案 B: L2 误差 = %.6e, 最大误差 = %.6e\n', err_2_B, err_inf_B);
    fprintf('方案 C: L2 误差 = %.6e, 最大误差 = %.6e\n\n', err_2_C, err_inf_C);
    
    % 绘制图形
    figure;
    plot(x, v_exact_num, 'k-', 'LineWidth', 2, 'DisplayName', '精确解');
    hold on;
    
    % 方案A - 检查是否绘制原曲线
    if err_inf_A > 1
        plot(x, zeros(size(x)), 'r--', 'LineWidth', 1, 'DisplayName', '方案A (前差不稳定)');
    else
        plot(x, v_num_A, 'r--', 'LineWidth', 1.5, 'DisplayName', '方案A (前差)');
    end
    
    % 方案B - 检查是否绘制原曲线
    if err_inf_B > 1
        plot(x, zeros(size(x)), 'g--', 'LineWidth', 1, 'DisplayName', '方案B (中心差不稳定)');
    else
        plot(x, v_num_B, 'g--', 'LineWidth', 1.5, 'DisplayName', '方案B (中心差)');
    end
    
    % 方案C - 检查是否绘制原曲线
    if err_inf_C > 1
        plot(x, zeros(size(x)), 'b--', 'LineWidth', 1, 'DisplayName', '方案C (后差不稳定)');
    else
        plot(x, v_num_C, 'b--', 'LineWidth', 1.5, 'DisplayName', '方案C (后差)');
    end
    
    legend('Location', 'best');
    title(title_str);
    xlabel('x'); ylabel('u');
    grid on;
end

function [err_2, err_inf] = calc_error(v_num, v_exact_num)
    err_2 = sqrt(mean((v_num - v_exact_num).^2));
    err_inf = max(abs(v_num - v_exact_num));
end
