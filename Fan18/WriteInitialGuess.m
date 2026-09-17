function WriteInitialGuess(x, y, theta, v, a, phi, w, tf)
global params_
params_.ig.x = x;
params_.ig.y = y;

nfe = params_.opti.nfe;
N = params_.obs.num_grids;
gamma = 0.75;
xc_obs = mean(params_.obs.x(1:N));
yc_obs = mean(params_.obs.y(1:N));
fid = fopen('ig.INIVAL', 'w');
for ii = 1:nfe
    fprintf(fid, 'let x[%g] := %.12g;\r\n', ii, x(ii));
    fprintf(fid, 'let y[%g] := %.12g;\r\n', ii, y(ii));
    fprintf(fid, 'let theta[%g] := %.12g;\r\n', ii, theta(ii));
    fprintf(fid, 'let v[%g] := %.12g;\r\n', ii, v(ii));
    fprintf(fid, 'let a[%g] := %.12g;\r\n', ii, a(ii));
    fprintf(fid, 'let phi[%g] := %.12g;\r\n', ii, phi(ii));
    fprintf(fid, 'let w[%g] := %.12g;\r\n', ii, w(ii));
    dx = x(ii) - xc_obs;
    dy = y(ii) - yc_obs;
    dist = hypot(dx, dy);
    if dist > 1e-10
        lambda_x0 = dx / dist;
        lambda_y0 = dy / dist;
    else
        lambda_x0 = cos(theta(ii));
        lambda_y0 = sin(theta(ii));
    end
    x_sep = gamma * x(ii) + (1 - gamma) * xc_obs;
    y_sep = gamma * y(ii) + (1 - gamma) * yc_obs;
    mu0 = lambda_x0 * x_sep + lambda_y0 * y_sep;
    fprintf(fid, 'let lambda_x[%g] := %.12g;\r\n', ii, lambda_x0);
    fprintf(fid, 'let lambda_y[%g] := %.12g;\r\n', ii, lambda_y0);
    fprintf(fid, 'let mu[%g] := %.12g;\r\n', ii, mu0);
end
fprintf(fid, 'let tf := %.12g;\r\n', tf);
fclose(fid);
end