function out = sampleOutput(t_vec, vals)
    mods = mod(t_vec, System.SAMPLING_INTERVAL);
    ids = mods == 0;
    nums = vals(ids);
    rounded = nums > 0.5;
    out = num2str(rounded);
end