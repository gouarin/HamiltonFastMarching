% Copyright Jean-Marie Mirebeau, University Paris-Sud, CNRS, University Paris-Saclay

if verLessThan('matlab','8.1')
    cxxFlags = ['CXXFLAGS="-std=c++11" ' ...
        'CXXLIBS="\$CXXLIBS -lc++" ' ]; % This flag is required on some platforms, but must be commented on others...
    outputFlag = '-o ';
else
    cxxFlags = 'CXXFLAGS="-std=c++11" '; 
    outputFlag = '-output ';
end

compileHFM = @(binary_Dir,JMM_CPPLibs_Dir,name,flag) eval(['mex ' ...
    outputFlag 'MatlabHFM_' name ' ../MatlabHFM.cpp' ... 
    ' -outdir ' binary_Dir ...
    ' ' cxxFlags  '-D' flag ...
    ' -I' '../../../Headers' ... % Main headers
    ' -I' [JMM_CPPLibs_Dir '/LinearAlgebra'] ...
    ' -I' [JMM_CPPLibs_Dir '/DataStructures'] ...
    ' -I' [JMM_CPPLibs_Dir '/Output'] ...
    ]);

compileModelsHFM = @(binary_Dir,JMM_CPPLibs_Dir,modelNames) ... 
    cellfun(@(name) compileHFM(binary_Dir,JMM_CPPLibs_Dir,name,['ModelName=' name]), modelNames);

standardModelsHFM = {'Isotropic2','Isotropic3','Diagonal2','Diagonal3',...
    'Riemann2','Riemann3','ReedsShepp2','ReedsSheppForward2','Elastica2',...
    'Dubins2','ReedsShepp3','ReedsSheppForward3'};

% Experimental models involved in some of the examples
experimentalModelsHFM = {'IsotropicDiff2','RiemannLifted2_Periodic','DubinsExt2'};

fprintf(['\nPlease execute the function compileModelsHFM(binary_Dir,JMM_CPPLibs_Dir,standardModelsHFM) to build \n'...
'the Hamilton Fast Marching executables in directory binary_Dir, \n' ...
'where JMM_CPPLibs can be downloaded from github.com/Mirebeau/JMM_CPPLibs. \n\n' ...
'In case of need, replace standardModelsHFM with experimentalModelsHFM, or any list of desired models.\n']);

%For me : binary_Dir = '/Users/mirebeau/Dropbox/Programmes/MATLAB/MexBin'; JMM_CPPLibs_Dir = '/Users/mirebeau/Dropbox/Programmes/Distributed/JMM_CPPLibs';
%For debug : compileHFM(binary_Dir,JMM_CPPLibs_Dir,'Custom','Custom')