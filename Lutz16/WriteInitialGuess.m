function WriteInitialGuess(x, y, theta, v, a, phi, w, tf)
global params_

params_.ig.x = x;
params_.ig.y = y;

nfe = params_.opti.nfe;
fid = fopen('ig.INIVAL', 'w');
for ii = 1:nfe
    fprintf(fid, 'let x[%g] := %.12g;\r\n', ii, x(ii));
    fprintf(fid, 'let y[%g] := %.12g;\r\n', ii, y(ii));
    fprintf(fid, 'let theta[%g] := %.12g;\r\n', ii, theta(ii));
    fprintf(fid, 'let v[%g] := %.12g;\r\n', ii, v(ii));
    fprintf(fid, 'let a[%g] := %.12g;\r\n', ii, a(ii));
    fprintf(fid, 'let phi[%g] := %.12g;\r\n', ii, phi(ii));
    fprintf(fid, 'let w[%g] := %.12g;\r\n', ii, w(ii));
end
fprintf(fid, 'let tf := %.12g;\r\n', tf);
fclose(fid);
end