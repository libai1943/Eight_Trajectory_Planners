function WriteInitialGuess(x, y, theta, v, a, phi, w, tf)
global params_

params_.ig.x = x;
params_.ig.y = y;

nfe = params_.opti.nfe;
ngrids = params_.obs.num_grids;
fid = fopen('ig.INIVAL', 'w');
for ii = 1:nfe
    fprintf(fid, 'let x[%g] := %.10f;\r\n', ii, x(ii));
    fprintf(fid, 'let y[%g] := %.10f;\r\n', ii, y(ii));
    fprintf(fid, 'let theta[%g] := %.10f;\r\n', ii, theta(ii));
    fprintf(fid, 'let v[%g] := %.10f;\r\n', ii, v(ii));
    fprintf(fid, 'let a[%g] := %.10f;\r\n', ii, a(ii));
    fprintf(fid, 'let phi[%g] := %.10f;\r\n', ii, phi(ii));
    fprintf(fid, 'let w[%g] := %.10f;\r\n', ii, w(ii));
    for jj = 1:ngrids
        fprintf(fid, 'let r[%g,%g] := 0;\r\n', ii, jj);
    end
    for jj = 1:4
        fprintf(fid, 'let s[%g,%g] := 0;\r\n', ii, jj);
        fprintf(fid, 'let z[%g,%g] := 0;\r\n', ii, jj);
    end
    for jj = 1:ngrids
        fprintf(fid, 'let lam_r[%g,%g] := 0;\r\n', ii, jj);
    end
    for jj = 1:4
        fprintf(fid, 'let lam_s[%g,%g] := 0;\r\n', ii, jj);
        fprintf(fid, 'let lam_z[%g,%g] := 0;\r\n', ii, jj);
        fprintf(fid, 'let nu[%g,%g] := 0;\r\n', ii, jj);
    end
end
fprintf(fid, 'let tf := %.10f;\r\n', tf);
fclose(fid);
end