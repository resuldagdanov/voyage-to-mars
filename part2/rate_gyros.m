
function w = rate_gyros(w_0, RG_std)
    w = w_0 + RG_std * randn(1, 3);
end
