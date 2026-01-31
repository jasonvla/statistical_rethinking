# Generative Model (What are the causal processes that create the dataset?) 
# => Globe tossing model

sim_globe <- function( p=0.7, N=9) {
    sample(c("W", "L"), size=N, prob=c(p, 1-p),replace=TRUE)
}
# Estimand (What we want to find out) => Proportion covered in water (p)


# Test simulation on extreme settings!
print(sim_globe(p=1, N=12))
print(sum(sim_globe(p=0.5 , N=1e4) == "W") / 1e4)