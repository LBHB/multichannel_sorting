% CRH 11-9-2019
% Copy of createChannelMapFile, set up for lbhb / the 128P UCLA probe
% geometry

%  create a channel map file

% load UCLA probe geometry
[s, ~] = probe_128P_bottom;

Nchannels = 128;
connected = true(Nchannels, 1);
chanMap   = 1:Nchannels;
chanMap0ind = chanMap - 1;
xcoords   = s.x;
ycoords   = s.y;
kcoords   =  ones(Nchannels, 1); % grouping of channels (i.e. probe shanks)
shank1_idx = find(s.x > 300);
shank2_idx = find(s.x < 300);
kcoords(shank2_idx) = 2 * ones(length(shank2_idx), 1);

fs = 30000; % sampling frequency
save('/auto/data/code/KiloSort/chanMap_128P_bottom.mat', ...
    'chanMap','connected', 'xcoords', 'ycoords', 'kcoords', 'chanMap0ind', 'fs')

%%

% kcoords is used to forcefully restrict templates to channels in the same
% channel group. An option can be set in the master_file to allow a fraction 
% of all templates to span more channel groups, so that they can capture shared 
% noise across all channels. This option is

% ops.criterionNoiseChannels = 0.2; 

% if this number is less than 1, it will be treated as a fraction of the total number of clusters

% if this number is larger than 1, it will be treated as the "effective
% number" of channel groups at which to set the threshold. So if a template
% occupies more than this many channel groups, it will not be restricted to
% a single channel group. 