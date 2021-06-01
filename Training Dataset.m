clc
clear all
close all
warning off
allImages=imageDatastore('Database','IncludeSubfolders',true,'LabelSource','foldernames');
layers=[imageInputLayer([227 227 3]),
    convolution2dLayer(5,20)
    reluLayer
    maxPooling2dLayer(10,'Stride',10)
    fullyConnectedLayer(10)
    softmaxLayer
    classificationLayer()];
options = trainingOptions('sgdm', ... 
    'LearnRateSchedule','piecewise', ...
    'LearnRateDropFactor',0.2, ...
    'LearnRateDropPeriod',5, ...
    'MaxEpochs',30,...
    'ValidationData',allImages, ...
    'ValidationFrequency',30, ...
    'MiniBatchSize',100,...
    'InitialLearnRate',0.0001,...
    'Plots','training-progress');
convnet=trainNetwork(allImages,layers,options);
save convnet;