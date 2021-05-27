function [difFromImpulse] = stack_score(signal)
% Return the score according to the EMD
% Input
%  signal -- 2D array: stack of accumulated energy functions (along the
%  radial direction)
% Output
%  difFromImpulse -- Earth Moving Distance (EMD) from a centered pulse
%
% October 24, 2018

gpu_exist = gpuDeviceCount;

signal = bsxfun(@rdivide, signal, max(signal(:)) );
% ============= L1 ===================
if gpu_exist
    difFromImpulse = sum(abs(signal - ones(size(signal), 'gpuArray')), 1);
else
    difFromImpulse = sum(abs(signal - ones(size(signal))), 1);
end

end

