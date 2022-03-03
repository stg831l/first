import torch
from torch import Tensor
from torch.nn import Linear, MSELoss, functional as F
from torch.optim import SGD, Adam, RMSprop
from torch.autograd import Variable
import numpy as np

# define our data generation function
def data_generator(data_size=100):
    # f(x) = y = sin(2pi*x) if x in [0, 1/2)
            #y = cos(2pi*x) if x in (1/2, 1]
    inputs = []
    labels = []

    # loop data_size times to generate the data
    for ix in range(data_size):
        # generate a random number between 0 and 1
        x = np.random.randint(0,10000) / 10000

        if 1/2 < x and x <= 1:
            z = 1
        else:
            z = -1

        # calculate the y value using the function f(x)
        y = ((1-z)/2)*np.sin(2*np.pi*x)+((1+z)/2)*np.cos(2*np.pi*x)

        # append the values to our input and labels lists
        x_power = []
        for power in range(5,0,-1):
          x_power.extend([x**power])

        inputs.append(x_power)

        labels.append([y])

    return inputs, labels


# define the model
class Net(torch.nn.Module):
    def __init__(self):
        super(Net, self).__init__()
        self.fc1 = Linear(5, 5)
        self.fc2 = Linear(5, 1)

        
        

    def forward(self, x):
        x = torch.sigmoid(self.fc1(x))
        x = self.fc2(x)
        return x

model = Net()


# define the loss function
critereon = MSELoss()
# define the optimizer
optimizer = SGD(model.parameters(), lr=0.1)


# define the number of epochs and the data set size
nb_epochs = 10001
data_size = 100


# create our training loop
for epoch in range(nb_epochs):
    X, y = data_generator(data_size)
    X = Variable(Tensor(X))
    y = Variable(Tensor(y))

    epoch_loss = 0


    y_pred = model(X)

    loss = critereon(y_pred, y)
    
    epoch_loss = loss.data
    optimizer.zero_grad()

    loss.backward()

    optimizer.step()

    if epoch % 1000 == 0:
      print("Epoch: {} Loss: {}".format(epoch, epoch_loss))


# test the model
model.eval()
test_data = data_generator(1)
prediction = model(Variable(Tensor(test_data[0][0])))
print(model.fc2.weight)
print(model.fc2.bias)