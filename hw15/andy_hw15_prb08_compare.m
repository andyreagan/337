% this script compares the speed of the _noplot and the _matrix codes
%
% be warned, it closes and clears everything
% SAVE WORK


clear all;
close all;
test_length = 100;
times = zeros(2,test_length);
for tcount=1:test_length
    clearvars -except test_length times tcount
    tstart = tic;
    andy_hw15_prb08_matrix;
    times(1,tcount) = toc(tstart);
    tstart = tic;
    andy_hw15_prb08_noplots
    times(2,tcount) = toc(tstart);
end

fprintf('average time for matrices is %g\n',mean(times(1,:)));
fprintf('average time for loop is %g\n',mean(times(2,:)));

speedup = mean(times(2,:))/mean(times(1,:));
fprintf('this is a speedup of %g\n',speedup);