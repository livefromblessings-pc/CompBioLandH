
## A Function for the Logistic Growth Model
The provided script is for turning the logistic growth model equation into an R function. 
 image of output from model

### Logistic Growth Model, what the heck is that?
A logistic growth model (LGMod) allows ecologist to determine the abundance of a population over a certain amount of time. This is determined with specified parameters. The parameters are

* `n`: population size
* `r`:  growth rate
* `K`: environment carrying capacity
* `t`: time

And the equation for this model is as follows: 
> `n[t] = n[t-1] + ( r * n[t-1] * (K - n[t-1])/K )`

### The Script 
This provided script (the .R file in this directory) takes this LGMod equation and turns it into a function that allows you to determine abundance using your own specified parameters. The output is a csv data file and also a plot of `abundance` vs `generation`(time). 
1. An example data file (the .csv file in this directory) has been provided. Column 1 of the data file is `generation` and column 2 is `abundance`. 
2. Here is an example of what your ![plot]( https://github.com/livefromblessings-pc/CompBioLandH/blob/master/Labs/Lab08/LGMod_Function_plot.jpeg) could look like.

The parameters used to generate this file are:
```
n = 2500
r = 0.8
K = 10000
t = 12
```

LGMod_Function is an assignment from [Lab08](https://github.com/flaxmans/CompBio_on_git/blob/master/Labs/Lab08/Lab08_documentation_and_metadata.md) for EBIO5240 Comp Bio.

> Written with [StackEdit](https://stackedit.io/).
