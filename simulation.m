clear all;

REF_MAG = 2500;
ctrl_i = 4;

[K, tau, Kc] = get_values(ctrl_i);

s = tf('s');
B = 5;
Tc = 0.2 / (2 * pi);

H_s = 1;
P_s = K*s / (1 + tau*s);
C_s = Kc * B * (Tc*s + 1) / (B*Tc*s + 1);

G_s = C_s * P_s;
cl_tr_fn = G_s / (1 + G_s*H_s);
U_s_by_R_s = C_s / (1 + G_s*H_s);

t = 0:0.002:2;
len = length(t);
u = zeros(1, len);
u(50:end) = 3.3;

y = lsim(P_s, u, t);
plot(t, y);
