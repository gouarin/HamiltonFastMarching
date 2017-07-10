% Copyright Jean-Marie Mirebeau, University Paris-Sud, CNRS, University Paris-Saclay

if verLessThan('matlab','8.1')
    cxxFlags = ['CXXFLAGS="-std=c++11" ' ...
        'CXXLIBS="\$CXXLIBS -lc++" ' ]; % This flag is required on some platforms, but must be commented on others...
    outputFlag = '-o ';
else
    cxxFlags = 'CXXFLAGS="-std=c++11" '; 
    outputFlag = '-output ';
end

compileHFM = @(binary_Dir,JMM_CPPLibs_Dir,flag) eval(['mex ' ...
    outputFlag 'MatlabHFM_' flag ' ../MatlabHFM.cpp' ... 
    ' -outdir ' binary_Dir ...
    ' ' cxxFlags  '-D' flag ...
    ' -I' '../../../Headers' ... % Main headers
    ' -I' [JMM_CPPLibs_Dir '/LinearAlgebra'] ...
    ' -I' [JMM_CPPLibs_Dir '/DataStructures'] ...
    ' -I' [JMM_CPPLibs_Dir '/Output'] ...
    ]);

compileHFMAll = @(binary_Dir,JMM_CPPLibs_Dir) cellfun(@(flag) compileHFM(binary_Dir,JMM_CPPLibs_Dir,flag), ...
    {'Isotropic','Curvature2','Curvature3','Riemann', 'RiemannExtra'}); %'RiemannExtra', 'Custom', 'Experimental0', 'Experimental1'

fprintf(['\nPlease execute the function compileHFMAll(binary_Dir,JMM_CPPLibs_Dir) to build \n'...
'the Hamilton Fast Marching executables in directory binary_Dir, \n' ...
'where JMM_CPPLibs can be downloaded from github.com/Mirebeau/JMM_CPPLibs. \n\n' ...
'Use compileHFM(binary_Dir,JMM_CPPLibs_Dir,flag) to build a specific model,\nsuch as Isotropic, Curvature2, Curvature3, Riemann, RiemannExtra.\n']);

%For me : binary_Dir = '/Users/mirebeau/Dropbox/Programmes/MATLAB/MexBin'; JMM_CPPLibs_Dir = '/Users/mirebeau/Dropbox/Programmes/Distributed/JMM_CPPLibs';
