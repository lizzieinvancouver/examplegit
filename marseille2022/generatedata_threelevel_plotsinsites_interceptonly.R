## Started 18 May 2018 ##
## By Lizzie ##

## Trying to make simple intercept-only, from generatedata_threelevel_plotsinsites.R ##
## Seems to return model parameters ##
## Still have divergences. I think we need an NCP on the site level. ##

setwd("~/Documents/git/teaching/stan/nestedmodels/")

library(rstan)
library(shinystan)

rstan_options(auto_write = TRUE)
options(mc.cores = parallel::detectCores())

nreps = 20  # replicate observations per plot
S = 40     # total number of sites
nplots <- 20
J = nplots * S  #total number of plots 
N = nreps*nplots*S

plotnum <- rep(c(1:J), each=nreps)   # list of plot numbers for each observation (length N)
sitenum <- rep(c(1:S), each=nplots)  # list of site numbers for each plot (length J)

# mu_a and sig_a are the mean and variance of the intercept across sites
mu_a <- 5
sig_a <- 2

# draw S=10 site means for slope and intercept
a_site <- rnorm(S,mu_a,sig_a)
# draw S=10 site sds for slope and intercept (variability of plots within sites)
sig_a_site <- rlnorm(S,0,1)

#for each plot, draw the slope and intercept from the appropriate site mean and sd
a_plot <- rep(0,J)
for (j in 1:J){
    a_plot[j] <- rnorm(1,a_site[sitenum[j]], sig_a_site[sitenum[j]]);
 }
# Alternatively, assume same within-site variance for all sites
if(FALSE){
# a single sd for all sites
sig_a_site <- rlnorm(1,0,1)
for (j in 1:J){
  a_plot[j] <- rnorm(1,a_site[sitenum[j]], sig_a_site[1]);
}
}

# draw observations from each plot with sd = sig_y
sig_y <- 1
y <- rep(0,N)
yhat <- rep(0,N)
for (n in 1:N){
  yhat[n] <- a_plot[plotnum[n]] 
  y[n] <- a_plot[plotnum[n]] + rnorm(1,0,sig_y)
}


#call stan model
dat <- list(N=N, S=S, J=J, plotnum=plotnum, sitenum=sitenum, y=y) 
fitme <- stan('marseille2022/generatedata_threelevel_plotsinsites_interceptonly.stan',
              data = dat, iter=4000, warmup=3000, chains=4)

sf <- summary(fitme)$summary

sf[grep("mu_", rownames(sf)),]

par(mfrow=c(1,2))
plot(sf[grep("a_plot\\[", rownames(sf)),][,1]~a_plot)
abline(0,1)
plot(sf[grep("sig_a_site\\[", rownames(sf)),][,1]~sig_a_site)
abline(0,1)

if(FALSE){
mu_a
sig_a
sig_y
a_plot
a_site
sig_a_site
}

launch_shinystan(fitme)
