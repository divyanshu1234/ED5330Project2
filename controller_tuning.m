clear all;

REF_MAG = 2500;
ctrl_i = 1;

[K, tau, Kc] = get_values(ctrl_i);

s = tf('s');
B = 5;
Tc = 0.2;

H_s = 1;
P_s = K*s / (1 + tau*s);
C_s = Kc * B * (Tc*s + 1) / (B*Tc*s + 1);

G_s = C_s * P_s;
cl_tr_fn = G_s / (1 + G_s*H_s);
U_s_by_R_s = C_s / (1 + G_s*H_s);

t = 0:0.02:24;
len = length(t);
ti0 = 1;
ti1 = floor(len * 1 / 6);
ti2 = floor(len * 2 / 6);
ti3 = floor(len * 3 / 6);
ti4 = floor(len * 4 / 6);
ti5 = floor(len * 5 / 6);
ti6 = len;

r = zeros(1, len);

% sin 1 Hz
r(ti0:ti1) = REF_MAG * sin(2*pi * 1 * t(ti0:ti1));

% sin 4 Hz
r(ti1:ti2) = REF_MAG * sin(2*pi * 4 * (t(ti1:ti2) - t(ti1)));

% step
r(ti2:ti3) = 0;
r(ti3:ti4) = REF_MAG;

% ramp
r(ti4:ti5) = 0;
r(ti5:ti6) = REF_MAG * (t(ti5:ti6) - t(ti5)) / (t(ti6) - t(ti5));

u = lsim(U_s_by_R_s, r, t);
% y = lsim(cl_tr_fn, r, t);
plot(t, r, t, u);
% plot(t, r, t, y);