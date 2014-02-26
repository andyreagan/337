% compare simple euler, modified euler, and midpoint

% true solution
truth = ((1+2)^2)/4;

y0 = 1;

fprintf('h & euler & modified euler & midpoint \n');

% loop over step size
for h=[.05,.1]
    x = 0:h:1;
    
    fprintf('%g ',h);
    
    % simple euler
    y = y0;
    for i=x(2:end)
        y = y+h*sqrt(y);
    end
    fprintf('& %g ',truth-y);
    
    % modified euler
    y = y0;
    for i=x(2:end)
        fg = y+h*sqrt(y);
        y = y+0.5*h*(sqrt(y)+sqrt(fg));
    end
    fprintf('& %g ',truth-y);
    
    % midpoint
    y = y0;
    for i=x(2:end)
        y = y+h*sqrt(y+h*0.5*sqrt(y));
    end
    fprintf('& %g \n',truth-y);
    
end