clear all;

REF_MAG = 2500;
ctrl_i = 4;

[K, tau, Kc] = get_values(ctrl_i);

s = tf('s');
B = 5;
Tc = 0.2 / (2 * pi);

Kc = 0.0009/B;

H_s = 1;
P_s = K*s / (1 + tau*s);
C_s = Kc * B * (Tc*s + 1) / (B*Tc*s + 1);

G_s = C_s * P_s;
cl_tr_fn = G_s / (1 + G_s*H_s);
U_s_by_R_s = C_s / (1 + G_s*H_s);

t = 0:0.02:28;
len = length(t);
ti0 = 1;
ti1 = floor(len * 1 / 7);
ti2 = floor(len * 2 / 7);
ti3 = floor(len * 3 / 7);
ti4 = floor(len * 4 / 7);
ti5 = floor(len * 5 / 7);
ti6 = floor(len * 6 / 7);
ti7 = len;

r = zeros(1, len);

% sin 1 Hz
r(ti0:ti1) = REF_MAG * sin(2*pi * 1 * t(ti0:ti1));

% sin 4 Hz
r(ti1:ti2) = 0;
r(ti2:ti3) = REF_MAG * sin(2*pi * 4 * (t(ti2:ti3) - t(ti2)));

% step
r(ti3:ti4) = 0;
r(ti4:ti5) = REF_MAG;

% ramp
r(ti5:ti6) = 0;
r(ti6:ti7) = REF_MAG * (t(ti6:ti7) - t(ti6)) / (t(ti7) - t(ti6));

% u = lsim(U_s_by_R_s, r, t);
% y = lsim(cl_tr_fn, r, t);
% figure();
% plot(t, u);
% plot(t, y)
% plot(t, r, t, u);
plot(t, r);
% xlabel('Time (s)');
% ylabel('Force (N)');
% ylabel('Current (A)');
% ylim([-3000, 3000]);

max(y)
