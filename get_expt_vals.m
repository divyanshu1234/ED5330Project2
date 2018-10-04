function [K, tau] = get_expt_vals(step, I0)

force = step(:,3);
time = step(:,1);

f0 = max(force);
len = length(force);

for i = 1 : len
    if force(i) > 10
        t0_i = i;
        break;
    end
end

for i = t0_i+10 : len
    if force(i)/f0 < 0.02
        ts = time(i) - time(t0_i);
        break;
    end
end

tau = ts / 3.9120;
K = f0 * tau / I0;