clc;
clear all;

% prompt= 'Enter the sequence number of test Image out 0f 10000 images sequence(any value from 1 to 10000):';
% ImgNo=input(prompt);
% prompt= 'Enter the number of Neighbours,K (Recommended: 5 to 10):';
% K=input(prompt);
% 
% prompt= 'Enter the size of the trainset you want to use (Any value between K+1 to 60000, Recommended: 200 to 1000):';
% TrainSetSize=input(prompt);
K=5;

TrainSetSize=60000;
for ImgNo=1:10000
    
% ImgNo=1;
% TrainSetSize=100;
% K=5;
Test=csvread('TestImages.csv',0,0);
TestLabels=csvread('TestLabels.csv',0,0);
TestLabels=TestLabels';
% TestIm=reshape(Test(:,1),[28 28]);
% imshow(TestIm);
 

Train=csvread('TrainingImages.csv',0,0);
TrainLabels=csvread('TrainingLabels.csv',0,0);
TrainLabels=TrainLabels';
mergedTrainSet=[Train;TrainLabels];
[rows,cols]=size(mergedTrainSet);
% K=5;

for r=1:TrainSetSize
 
    Dist{r}=Train(:,r)-Test(:,ImgNo);
    E_Dist{r}=sum(sum(cell2mat(Dist(r)).^2));
   
end

EuclideanDist=cell2mat(E_Dist);

[minVal minIndex]= mink(EuclideanDist,K);

probableLabels=TrainLabels(minIndex);
CalculatedTestImageLabel{ImgNo}=mode(probableLabels);
% ActualTestImageLabel=TestLabels(ImgNo);
end
CalculatedTestImageLabel=cell2mat(CalculatedTestImageLabel);
ActualTestImageLabel=TestLabels(1:ImgNo);

HitMiss=CalculatedTestImageLabel-ActualTestImageLabel;
Hit=ImgNo-nnz(HitMiss);
Accuracy= Hit/ImgNo


