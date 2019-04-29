# Implementing Grid World

### Initial Setup of Grid World in R

actions <- c('U', 'D', 'L', 'R')
actions

# Build Grid World in terms of x and y
x <- 1:4
x

y <- 1:3

# Create the states
states <- expand.grid(x=x, y=y)
states

# Create the reward matrix
rewards <- matrix(rep(0, 12), nrow = 3)
rewards

rewards[2, 2] <- NA
rewards[1, 4] <- 1
rewards[2, 4] <- -1
rewards

# Having some small negative reward in each state except for the two
# end states encouraging you to finish the game as quickly as possible.
rewards <- matrix(rep(-0.04, 12), nrow=3)
rewards[2, 2] <- NA
rewards[1, 4] <- 1
rewards[2, 4] <- -1
rewards
# Transition probabilities. Here we introduce the notion
# of stochasticity in the chosen action to take in each state

transition <- list('U' = c('U' = 0.8,
                           'D' = 0,
                           'L' = 0.1,
                           'R' = 0.1),
            

                   'D' = c('D' = 0.8,
                           'U' = 0,
                           'L' = 0.1,
                           'R' = 0.1),
                   
                   'L' = c('L' = 0.8,
                           'R' = 0,
                           'U' = 0.1,
                           'D' = 0.1),
                   
                   
                   'R' = c('R' = 0.8,
                           'L' = 0,
                           'U' = 0.1,
                           'D' = 0.1))

transition
# The value of an action (e.g. move up means y + 1)
action.values <- list('U' = c('x' = 0, 'y' = 1),
                      'D' = c('x' = 0, 'y' = 1),
                      'L' = c('x' = -1, 'y' = 0),
                      'R' = c('x' = 1, 'y' = 0))




#Ref: packtpub.com