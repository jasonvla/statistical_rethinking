---
aliases: 
tags: [statistics]
---

YouTube Videoreihe als Einführung zu [[Bayesian Statistics]]

# LECTURE A01 - Introduction to Bayesian Workflow

[[Core Bayesian Workflow]]:

Generative Model
(= a scientific model specified enough to make predictions with it)
[[Estimand]]
(Scientific Question you have)

![[Core Bayesian Workflow.png]]

---
Three types of [[Causal Inference]]:

[[Causal Prediction]],
[[Causal Imputation]],
[[Causal Explanation]]

---

A [[Statistical Model]] extracts information from a sample.

---

[[Bayesian Inference]] is practical because we can change our beliefs.

Example: What proportion of the globe is covered in water?
Idea: Select 10 random points on the globe and document whether it landed on Land (L) or Water (W)

Result: L W L L W W W L W W

How should we use the sample to produce an estimate?

How to produce a summary of the results?
- in this case: What proportion of the sample is water?
How to represent uncertainty?
- A larger sample should have less uncertainty than a small sample

=> Go through every datapoint in the dataset and add it to the graph.
[[Bayesian Updating]]

---
Coming back to the [[Core Bayesian Workflow]] with the example given in mind:

Generative model (Globe tossing model)
+
Estimand (Proportion covered in water)
=>
Statistical model ([[Bayesian Estimator]]s)

[[Bayesian Inference]]

For each possible explanation of the sample,
Count all the ways the sample could happen.

Explanations with more ways to produce the sample are more plausible.

==>
Applied to our globe example: 

For each possible proportion of water on the globe,
Count all the ways the sample of tosses could happen.
Proportions with more ways to produce the sample are more plausible.

Idea:![[Four-sided Globe.png]]


All the possible four-sided globes (= The Explanations we need to work through)
![[Garden of Forking Data.png]]

For each sample, count all the ways our observation (W L W) could happen.

Assuming (2) was true; how likely would it be to get our observation.

![[Garden of Forking Data1.png]]

==> 3 Ways to get our observation!

Doing that for the other possibilities too, we will receive:
![[Garden of Forking Data Posterior.png]]


Multiplication is the logical reduction of counting.
![[Bayesian Updating Example.png]]

# LECTURE A04 - Categories and Causes

[[Estimand]] = Influence of height on weight (A specific dataset)

How does height influence weight?

$H$ ----> $W$ <---- $\enclose{circle}{U}$
$U =$ unobserved stuff
the circle is a convention in these diagrams for unobserved!
$$
\rightarrow$$
$W = f(H,U)$

> [!TIP] "Weight is some function of height and unobserved stuff"

$H$ ----> $W$ <---- $\enclose{circle}{U}$
For adults, weight is a proportion of height + influence of unobserved causes:
$$ \large
W = \beta H + U
$$

### **Generative model**:
```R
# func to simulate weights of individuals from height
sim_weight <- function(H,b,sd) {
	U <- rnorm ( length(H), 0, sd)
	W <- b*H + U
	return(W)
}
# create fake data with 200 people that are between 130 and 170 cm
H <- runif(200, min=130, max=170)

W <- sim_weight(H, b=0.5, sd=5)

plot(W ~ H, col=2, lwd=3)
```
[[Describing statistical models]]: 


Tilde ~ bedeutet "ist verteilt gemäß..."

$W_i = \beta H_i + U_i$ Equation for expected height
$U_i \sim \text{Normal}(0, \sigma)$ Gaussian error with standard deviation sigma
$H_i \sim \text{Uniform}(130, 170)$ Height uniformly distributed from 130cm to 170cm

the lower i signifies that this applies to every individual in the dataset
![[Bayes_workflow_example.png]]

### Statistical Model:

Two parts need to be addressed:
1. Structure of the [[Estimator]]
2. How to approximate the posterior

---
#### Estimator

We want to estimate how the average weight changes with height.

$E(W_i|H_i) = \alpha + \beta H_i$
$E = \text{Expectation}$
$\alpha = \text{intercept}$
$\beta = \text{slope}$
$$\rightarrow$$
$W_i \sim \text{Normal}(\mu_i, \sigma)$
$\mu_i = \alpha + \beta H_i$


>  *Weight is distributed normally with a mean that is a linear function of Height*

Think of $\large \alpha$ as the "baseline" value. It represents the predicted weight of an individual when their height is exactly zero

### Approximate posterior

Many posterior distribution are approximately Gaussian (=> Normally distributed)

[[Quadratic Approximation]]: Approximate posterior as multivariate Gaussian. Works well for simple linear models