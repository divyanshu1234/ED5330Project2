% Finds dominant frequency and plots the Bode plot

clear all;

load('Project_2_data/freq.mat')
NUM_FREQ = 15;

max_in = zeros(NUM_FREQ,1);
max_out = zeros(NUM_FREQ,1);
max_in_f = zeros(NUM_FREQ,1);
max_out_f = zeros(NUM_FREQ,1);

for i = 1:15
    F_i = eval(strcat('F_', num2str(i), 'Hz'));
    [max_in(i), max_in_f(i), max_out(i), max_out_f(i)] = spectrum(F_i(:,2), F_i(:,3), i);
end

% plot(log10(2*pi*max_out_f), 20*log10(max_out ./ max_in));

figure();
semilogx(2*pi*max_in_f, 20*log10(max_out ./ max_in));
xlabel('\omega (rad s^-^1)');
ylabel('Gain (dB)');

figure();
stem(max_in_f, max_in);
hold on;
stem(max_out_f, max_out);
legend('Input', 'Output');
xlabel('Frequency (Hz)');
ylabel('Force (N)');
