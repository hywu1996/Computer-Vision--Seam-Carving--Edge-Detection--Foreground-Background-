%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% setups paths and reads the data
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% change the paths below to where the data is stored, and where the library
% is stored 
dataFile   = 'C:\Users\Harry Wu\Documents\MATLAB\4442 A1\A1_full.mat';
convnetDir = 'C:\Users\Harry Wu\Documents\MATLAB\matconvnet';

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

percentValidation =  30; % percent of training data to use for validation

more off;
addpath(convnetDir);
addpath(strcat(convnetDir,'/examples'));  % directory where the data generated during training is  stored

% fun vl_setupnn.m file
run(fullfile(convnetDir,'matlab','vl_setupnn.m'));


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% reads data 
readDataForCNN;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Finds the mean image on the validation data
% subtracts it from all samples
normalizeData;


