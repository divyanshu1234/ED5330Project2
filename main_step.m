clear all;

% f(0) = K I0 / tau
% f(t) = e^(-t/tau) * K I0 / tau
% Ts = 3.9120 tau

load('Project_2_data/time.mat')

NUM_SIMS = 4;
step_str = ["Step_2", "Step_2_5", "Step_3", "Step_3_3"];
ar_I0 = [2, 2.5, 3, 3.3];

ar_K = zeros(1, NUM_SIMS);
ar_tau = zeros(1, NUM_SIMS);

for i = 1 : NUM_SIMS
    step_i = eval(step_str(i));
    [ar_K(i), ar_tau(i)] = get_expt_vals(step_i, ar_I0(i));
end