function y = phi(x)
    y = zeros(length(x),1);
    % y(100:121) = ones(length(100:121),1);
    for i=1:length(x)
        if x(i) >= 0 && x(i) <= 2
            y(i) = 1;
        end
    end
end

