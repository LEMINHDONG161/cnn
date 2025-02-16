%function test_example_CNN


close('all');
clear;
load('C:\Users\OSElab\Desktop\MINH DONG\LEMINHDONG_trituenhantao\new_data10'); 
read_data_train = data_train;
read_data_test = data_test;
 train=single(read_data_train(1:32000,1:2048)');
 train_label=single( read_data_train(:,2049)');
 test=single(read_data_test(1:8000,1:2048)');
 test_label= single(read_data_test(:,2049)');

train_cnn = reshape(train,64,32,32000);
test_cnn = reshape(test,64,32,8000);

%load mnist_uint8;

%train_x = double(reshape(train_x',28,28,60000))/255;
%test_x = double(reshape(test_x',28,28,10000))/255;
%train_y = double(train_y');
%test_y = double(test_y');


%% ex1 Train a 6c-2s-12c-2s Convolutional neural network 
%will run 1 epoch in about 200 second and get around 11% error. 
%With 100 epochs you'll get around 1.2% error

rand('state',0)

cnn.layers = {
    struct('type', 'i') %input layer
    struct('type', 'c', 'outputmaps', 6, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %sub sampling layer
    struct('type', 'c', 'outputmaps', 12, 'kernelsize', 5) %convolution layer
    struct('type', 's', 'scale', 2) %subsampling layer
};


opts.alpha = 1;
opts.batchsize = 10;
opts.numepochs = 1;

cnn = cnnsetup(cnn, train_cnn, train_label);
cnn = cnntrain(cnn, train_cnn, train_label, opts);

[er, bad] = cnntest(cnn, test_cnn, test_label);

%plot mean squared error
figure; plot(cnn.rL);
assert(er<0.12, 'Too big error');
