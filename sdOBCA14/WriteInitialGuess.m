function WriteInitialGuess(x, y, theta, v, a, phi, w, tf)
global params_
params_.ig.x = x;
params_.ig.y = y;
nfe = params_.opti.nfe;
ngrids = params_.obs.num_grids;
lw = params_.vehicle.lw;
lf = params_.vehicle.lf;
lr = params_.vehicle.lr;
lb = params_.vehicle.lb;
A = params_.obs.A;
B = params_.obs.B;
C = params_.obs.C;
fid = fopen('ig.INIVAL', 'w');
for ii = 1:nfe
    fprintf(fid, 'let x[%g] := %.10f;\r\n', ii, x(ii));
    fprintf(fid, 'let y[%g] := %.10f;\r\n', ii, y(ii));
    fprintf(fid, 'let theta[%g] := %.10f;\r\n', ii, theta(ii));
    fprintf(fid, 'let v[%g] := %.10f;\r\n', ii, v(ii));
    fprintf(fid, 'let a[%g] := %.10f;\r\n', ii, a(ii));
    fprintf(fid, 'let phi[%g] := %.10f;\r\n', ii, phi(ii));
    fprintf(fid, 'let w[%g] := %.10f;\r\n', ii, w(ii));
    best_score = -inf;
    best_index = 1;
    best_lambda = 1;
    best_mu = zeros(1, 4);
    ct = cos(theta(ii));
    st = sin(theta(ii));
    for jj = 1:ngrids
        nx = A(jj);
        ny = B(jj);
        norm_n = hypot(nx, ny);
        if norm_n < 1e-10
            continue;
        end
        lambda_j = 1 / norm_n;
        qx = nx * lambda_j;
        qy = ny * lambda_j;
        r1 = ct * qx + st * qy;
        r2 = -st * qx + ct * qy;
        mu1 = max(-r1, 0);
        mu2 = max(r1, 0);
        mu3 = max(-r2, 0);
        mu4 = max(r2, 0);
        score = -(lf + lw) * mu1 - lr * mu2 - 0.5 * lb * mu3 - 0.5 * lb * mu4 + (A(jj) * x(ii) + B(jj) * y(ii) + C(jj)) * lambda_j;
        if score > best_score
            best_score = score;
            best_index = jj;
            best_lambda = lambda_j;
            best_mu = [mu1, mu2, mu3, mu4];
        end
    end
    for jj = 1:ngrids
        if jj == best_index
            lambda0 = best_lambda;
        else
            lambda0 = 0;
        end
        fprintf(fid, 'let lambda[%g,%g] := %.10f;\r\n', ii, jj, lambda0);
    end
    for jj = 1:4
        fprintf(fid, 'let mu[%g,%g] := %.10f;\r\n', ii, jj, best_mu(jj));
    end
end
fprintf(fid, 'let tf := %.10f;\r\n', tf);
fclose(fid);
end