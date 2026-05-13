---
created: 2026-03-20
updated: 2026-03-21
description: A statistical extrapolation of my data on being sick
tags:
author:
  - Alex Liebscher
---
Each time I get sick, I record a simply binary sick/not sick variable in my daily notes. I recently had a stressful week at work, and as a consequence, I came down with a cold and terrible sore throat. I generally don't make a note of my symptoms, but over the last year I have recorded each episode of sickness. This week, as I was lying around frustrated at being sick once again -- it felt like I was recently _just_ sick -- I wondered: how often had I really been sick, and what I could do to prevent sickness in the future?

This kicked off an hour of research and reflection through old journals. I determined that from 2025-03-30 to 2026-03-20 (the longest period of data I have collected) I have been sick seven different times. As far as I can remember, these have all been upper respiratory tract infections (URTIs), usually known as the common cold, but caused by a variety of viruses. I don't think I've had the flu though, and this current bout of sickness has tested negative for strep throat.

I Googled how many colds the average US adult gets, and to my disbelief the first result suggested 2-4 per year. I was shocked: how could I be getting sick so much more than the average adult? Was I exceptionally sick this last year?

----

To figure out how exceptional this year had been, I wanted to quickly model the distribution of the general adult population's URTI frequency so I can figure out how extreme my experience has been.

I set out to find some incidence figures (epidemiologists use incidence to refer to the number of episodes of an illness per person in some time frame) to encode into a prior distribution. Unfortunately, there are no formal surveillance networks to accurately estimate incidence of the common cold in adults. Figures that are often reported come from retrospective analysis of hospital admissions, which of course, underestimates the true incidence of common cold episodes. Leder et al. (2003) found that only one-third of common colds were associated with a doctor's visit. A bit of digging though and I found some numbers that are close to what I'm looking for (ignore the notation for now, which we introduce later):

1. Leder et al. ([2003](https://pubmed.ncbi.nlm.nih.gov/14705301/)) reported from a community-based diary study of 600 families in Melbourne an average of 2.2 respiratory episodes per person per 68 weeks of observation. More specifically, they find that of 113 individuals age 21-30, there were 215 total number of episodes recorded (mean episodes per person per year = 1.4).
	1. $1.4$ episodes per person per year
2. Raposo et al ([2017](https://www.nature.com/articles/ejcn2016261)) conducted a 9-month prospective cohort study among 1,533 Swedish adults, and found the number of URTI events per person ranged from 0 to 8 with a mean of 0.90 and an average follow-up time of 32 weeks. Zero, one, two, and three or more events were reported by 44%, 33%, 15%, and 7.8%. 607 men reported 0.71 events.
	1. $\lambda = 0.71 * (52/32) = 1.15$ episodes per male per year (I use the male figure since I am male)
3. Berggren et al ([2011](https://pubmed.ncbi.nlm.nih.gov/20803023/)) conduct a 12-week RCT of probiotics on 135 placebo individuals (33% male), and report 170 episodes. They report 15% of placebo participants experienced 3 or more episodes.
	1. $\lambda = 170 / (135 * 12/52) = 5.46$ episodes per person per year
4. Shida et al ([2015](https://pmc.ncbi.nlm.nih.gov/articles/PMC5290054/)) conducted an RCT with 47 placebo adult men in Tokyo, and found 25 episodes over 12 weeks (December to March).
	1. $\lambda = 25 / (47 * 12/52) = 2.30$ episodes per person per year
5. Jawad et al ([2012](https://onlinelibrary.wiley.com/doi/10.1155/2012/841315)) conducted an RCT that found 188 cold episodes in the placebo group of 362 students at Cardiff University during 4 winter months.
	1. $\lambda = 188 / (362 * 16 / 52) = 1.69$ episodes per person per year
6. Tobin et al. ([2025](https://www.ncbi.nlm.nih.gov/books/NBK532961/)) report that the incidence of the common cold in the general adult population is between 2 and 5 events per year.

If I could come up with the ideal study, it'd be a year-long prospective cohort study of adults ages 25-35 in New York City, but hyperspecific research like that doesn't exist. The above studies vary in details, and one of the biggest disadvantages of these is that they tend to sample during the winter months, which overrepresents year-long incidence. 

Using these data, I can create a prior distribution. First I need a model though. The number of events recorded in a time period is a Poisson count model (i.e. count of discrete events in a fixed time window). The Poisson has a single parameter, $\lambda$ , where X ~ Poisson($\lambda$).

Using Bayesian probability we can treat $\lambda$ as an uncertain distribution instead of a fixed parameter. The natural conjugate prior on $\lambda$ is a Gamma($\alpha$, $\beta$) distribution, so we'll use a Gamma to represent the distribution of values that $\lambda$ can be.

From the above data, there are five point estimates of the mean of this distribution: 1.4, 1.15, 5.46, 2.3, and 1.69. These come from a variety of ages, climates, and seasons. Other reports say that the general adult population has between 2 and 5 episodes per year. Thus, from these figures, we can very roughly estimate that the mean of the Gamma should be about 2.5.

I really don't have too much more information from the literature though, so I'll set a weak prior with shape and rate parameters of $\alpha = 5$ and $\beta = 2$. With this, 91.8% of the mass of the distribution falls between 1 and 5, and $\mu = \alpha / \beta = 2.5$. This prior distribution for $\lambda$ looks like:

![[Pasted image 20260320190515.png]]


So my prior distribution on $\lambda$ to kick things off is Gamma(5, 2). This incorporates the heterogeneity of the studies I found, which vary from 1.15 to 5.46 episodes per person per year. It's also consistent with general literature estimates of 2-5 episodes for adults. Still, I have a good amount of uncertainty regarding values of $\lambda$.

The question I want to answer is: how unusual is 7 colds in a year for a random adult? To answer this is basically to figure out: for a random adult, how many colds can we expect they'll have over the course of a year? Then once we have that distribution, it's easy to ask how likely 7 is.

How do we get this distribution though? First off, let's clarify by calling this distribution (of number of colds per person per year) a distribution of _observed_ outcomes. This differs from a parameter distribution -- like the Gamma prior we established for $\lambda$. To figure out the distribution of observed outcomes, we average the Poisson probability of a given $k$ value for all possible $\lambda$ values, weighted by how probable each $\lambda$ is under the Gamma(5,2) prior. In other words, p($X = k$) = $\int$ p($X = k$|$\lambda$)p($\lambda$) $d\lambda$. We don't know exactly what $\lambda$ is, so we compute the probability of observing $k$ colds for all values of $\lambda$, and take the weighted average where the weights are how likely each $\lambda$ is given the Gamma.

Thankfully, we don't need to actually compute this integral. This is a textbook relationship we don't need to prove, and it says that the weighted average of a Poisson likelihood and a Gamma-distributed $\lambda$ parameter is a Negative Binomial distribution: p($X = k$|$\alpha, \beta$). This Negative Binomial is also known as the _prior predictive_.

Now we can call upon the Negative Binomial functions in R to compute $P(X \le k)$ for all $k$ values of interest using the shape and rate parameters we identified before:

```r
tibble(
  k = 0:6,
  p = pnbinom(k, size = 5, mu = 5 / 2)
)
#       k     p
# 1     0 0.132
# 2     1 0.351
# 3     2 0.571
# 4     3 0.741
# 5     4 0.855
# 6     5 0.923
# 7     6 0.961
```

Taking the complement of these probabilities (p($X > k$) = 1 - p($X \le k$)) gives us the following distribution:

![[Pasted image 20260320191449.png]]

Thus, according to our data, there's an 87% probability a randomly sampled adult has at least 1 common cold over a year, and a 13% probability they have 0 colds.

Finally, according to our model and data, the probability of a randomly observed adult having 7 or more colds is: P(X >= 7) = P(X > 6) = 3.86%.

Said plainly, only about 3.9% of the general adult population would have as many colds as I did last year. I'm shocked at how extreme my experience has been, and I'm definitely making some changes to my work and travel habits for the upcoming year.

### References

https://ods.od.nih.gov/factsheets/ImmuneFunction-HealthProfessional/