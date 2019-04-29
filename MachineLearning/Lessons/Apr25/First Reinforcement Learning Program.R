# First Reinforcement Learning Program

# Finding Optimal Policy Navigating 2x2 grid

# MDPtoolBox and Reinforcement Learning Packages
# Non-MDP representation of Reinforcement Learning

# Installation using devtools
install.packages('devtools')

# Donwload and install latest version from GitHub
devtools::install_github('nproellochs/ReinforcementLearning')

# Load the package
library(ReinforcementLearning)

# Template of environment function:
# environment <- function(state, action) {
# ...
# return(list('NextState' = newState,
#             'Reward' = reward))
# }

# We can manually create our own environment function or
# use 'canned' environment fom ReinforcementLearning package.

# Load gridworld environment
?gridworldEnvironment

# We are going to sample experience from an agent that
# navigates from a random starting position to a goal
# position in 2 X 2 version of Grid World

env <- gridworldEnvironment
print(env)


# Define state and action sets
states <- c('s1', 's2', 's3', 's4')
actions <- c('up', 'down', 'left', 'right')

# Sample N = 1000 random sequencess from the environment
# Data format must be (s, a, r, s_new) tuples
# as rows in a dataframe structure

?sampleExperience
data <- sampleExperience(N = 1000,
                         env = env,
                         states = states,
                         actions = actions)

head(data)
data

# Performing Reinforcement 
# Define reinforcement learn
# gamma: 
# set to 1 no discoint; 
# set to 0.5 as the middle discount;
# As agent moves thru the grid future rewards are counted as heavily
# 0.1 means future rewards are discounted heavily
# alpha is the learning rate
# 
control <- list(alpha = 0.1, # low learning 
                gamma = 0.5, 
                # epsilon only relevant when
                # new esperience based on 
                epsilon = 0.1) # low exploration and exploitation

control

# Perform reinforcement learning
?ReinforcementLearning

model <- ReinforcementLearning(data,
                               s = 'State',
                               a = 'Action',
                               r = 'Reward',
                               s_new = 'NextState',
                               control = control)
print(model)

print(policy)

# exploration and exploitation
# e-Greedy action selection strategy
# Extend 2 x 2 Grid World R example by updating polcy solution


# Exploration: Try new, possibly non-optimal actions to learn their reward
# Exploitation: Use current knowledge to choose "best known" action

set.seed(1234)


# Now we update the existing policy with a new data set and we deliberately
# choose 'epsilon-greedy' action selection

# Sample N = 1000 sequences from the environment using epsilon-greedy action selection
data_new <- sampleExperience(N = 1000,
                             env = env,
                             states = states,
                             actions = actions,
                             model = model,
                             actionSelection = 'epsilon-greedy',
                             control = control)


head(data_new)
# State Action Reward NextState
# Updating the existing policy using new training data
model_new <- ReinforcementLearning(data_new,
                                  s = 'State',
                                  a = 'Action',
                                  r = 'Reward',
                                  s_new = 'NextState',
                                  control = control,
                                  model = model)

print(model_new)
summary(model_new)

plot(model)
plot(model_new)


#Ref: packtpub.com