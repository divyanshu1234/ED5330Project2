clear all;

ctrl_i = 3;

[K, tau, ~] = get_values(ctrl_i);
switch(ctrl_i)
    case 1
        mag_final = 41.5;
    case 2
        mag_final = 40.8;
    case 3
        mag_final = 38.9;
    case 4
        mag_final = 38.2;     
end

s = tf('s');
B = 5;
Tc = 0.2 / (2 * pi);
Kc = 10 ^ (-mag_final/20);

H_s = 1;
P_s = K*s / (1 + tau*s);
C_s = Kc * B * (Tc*s + 1) / (B*Tc*s + 1);

G_s = C_s * P_s;
cl_tr_fn = G_s / (1 + G_s*H_s);

figure();
bode(P_s);
title('Bode - Plant Transfer Function');

figure();
bode(G_s * H_s);
title('Bode - Open Loop Transfer Function');