# Generative Model (What are the causal processes that create the dataset?) 
# => Globe tossing model

sim_globe <- function( p=0.7, N=9) {
    sample(c("W", "L"), size=N, prob=c(p, 1-p),replace=TRUE)
}
# Estimand (What we want to find out) => Proportion covered in water (p)


# Test simulation on extreme settings!

# print(sim_globe(p=1, N=12))
# print(sum(sim_globe(p=0.5 , N=1e4) == "W") / 1e4)

sample <- c(sim_globe())
W <- sum(sample=="W") # number of W observed
L <- sum(sample=="L") # number of L observed
p <- c(0, 0.25, 0.5, 0.75, 1) # proportions of globe covered in water
ways <- sapply(p, function(q) (q*4)^W * ((1-q)*4)^L)
prob <- ways/sum(ways)
print(cbind(p, ways, prob))

# func to simulate weights of individuals from height
sim_weight <- function(H,b,sd) {
	U <- rnorm ( length(H), 0, sd)
	W <- b*H + U
	return(W)
}

# add synthetic data 
H <- runif(200, min=130, max=170)
W <- sim_weight(H, b=0.5, sd=5)
#quartz()
plot(W ~ H, col=2, lwd=3)

# prior predictive distribution

n <- 1e3
a <- rnorm(n,0,10) # slope
b <- runif(n,0,1) # in most cases; in general weight is a proportion of height
quartz()
plot(NULL, xlim=c(130,170), ylim=c(50,90),
    xlab="height (cm)", ylab="weight (kg)")
for (j in 1:50) abline(a=a[j], b=b[j], lwd=2, col=2)