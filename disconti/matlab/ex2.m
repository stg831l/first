input = zeros(5,100);
labels = zeros(1,100);

for ix = 1:100

    x = randi([1 10000])/10000;
    
    if (1/2 < x) && (x <= 1)
        z = 1;
    else
        z = -1;
    end
    
    y = ((1-z)/2)*sin(2*pi*x)+((1+z)/2)*cos(2*pi*x);
    
    for i = 1:5
        input(i,ix) = x^i;
    end
    
    labels(ix) = y;

end

% [input,labels] = dataset;


plot(input(1,1:100),labels,'.')
axis([0 1 -1 1])
title('Function to approximate.')
xlabel('x')
ylabel('y')

% 隨機權重避免
% setdemorandstream(491218382)

% 單層5個神經元
net = fitnet(5);
view(net)

[net,tr] = train(net,input,labels);

plotperform(tr)



% % % % % % % % % % % % % % % % % % % % % % % % % % % % % % % 

input_test = zeros(5,100);
labels_test = zeros(1,100);

for ix = 1:100

    x = randi([1 10000])/10000;
    
    if (1/2 < x) && (x <= 1)
        z = 1;
    else
        z = -1;
    end
    
    y = ((1-z)/2)*sin(2*pi*x)+((1+z)/2)*cos(2*pi*x);
    
    for i = 1:5
        input_test(i,ix) = x^i;
    end
    
    labels_test(ix) = y;

end
testX = input_test;
testT = labels_test;

testY = net(testX);

% 樣本的均方差
perf = mse(net,testT,testY);

% 觀察回歸圖
Y = net(input);
plotregression(labels,Y)