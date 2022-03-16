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


plot(input(1,1:100),labels,'.')
axis([0 1 -1 1])
title('Function to approximate.')
xlabel('x')
ylabel('y')



net = fitnet(5,'trainlm');
net.trainParam.epochs = 1000000;
net.trainParam.goal = 1e-12;
net.trainParam.max_fail = 100000;


[net,tr] = train(net,input,labels);

plotperform(tr)

yp = sim(net,input);
performance = perform(net, labels,yp);

view(net)
