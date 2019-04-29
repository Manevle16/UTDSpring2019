# MARKOV DECISION PROCESSES - MDP
# Building State-Model-Action-Reward MDP problem framework
# Optimal Policy -- as an MDP Solution

# Markovian Property - only The Present Matters
# pi(s) -> a: Policy as a function, given the state s what action to take
# pi* optimal policy - maximizes long term expected rewards

# RL dependend on State, Action, Reward triples: <s, a, r> 
# SL dependend on State Action Pairs: <s, a>

# Series of actions is better to be defined as the plan
# Policy what actions to take?


install.packages('MDPtoolbox')
library(MDPtoolbox)

# MDP Policy Iteration

# Design an MDP that finds the optimal
# policy to that 2 x 2 grid problem


# These transition matrices reflect the following randomness of action taken
# When agent selects an action, there is a 70% probability that that action
# selected will occur. There is a 20% probability the agent will stay in the
# same state (no action taken) and 10% probability that the agent will move
# in a lateral direction to the action selected.

up <- matrix(c(   1,    0,   0,   0,
                0.7,  0.2, 0.1,   0,
                  0,  0.1, 0.2, 0.7,
                  0,    0,   0,   1),
             nrow=4, ncol=4, byrow = TRUE)

# Agent is in:      S1    S2  S3   S4
# up <- matrix(c(   1,    0,   0,   0,
# Goes to:        0.7,  0.2, 0.1,   0,
# Goes to:          0,  0.1, 0.2, 0.7,
# Goes to:          0,    0,   0,   1),
#         nrow=4, ncol=4, byrow = TRUE)

# If an agent is in State S1 and tries to go up: 100% prob will remain in S1
# If an agent is in State S2 and tries to go up: 70% prob will go up to S1; 20% remain in S2
# If an agent is in State S3 and tries to go up: 70% prob will go up to S4; 20% will remain in S3; 10% prob move left to S2
# If an agent is in State S4 and tries to go up: 100% prob will remain in S4

left <- matrix(c( 0.9,  0.1,   0,   0,
                  0.1,  0.9,   0,   0,
                  0,    0.7, 0.2, 0.1,
                  0,    0,   0.1, 0.9),
             nrow=4, ncol=4, byrow = TRUE)

down <- matrix(c( 0.3,  0.7,   0,   0,
                  0,    0.9, 0.1,   0,
                  0,    0.1, 0.9,   0,
                  0,    0,   0.7, 0.3),
               nrow=4, ncol=4, byrow = TRUE)

right <- matrix(c( 0.9,  0.1,   0,   0,
                   0.1,  0.2, 0.7,   0,
                   0,    0,   0.9, 0.1,
                   0,    0,   0.1, 0.9),
               nrow=4, ncol=4, byrow = TRUE)

T <- list(up=up, left=left, down=down, right=right)

R <- matrix(c(-1, -1, -1, -1, # enter State S1 from anywhere, reward is -1
              -1, -1, -1, -1,
              -1, -1, -1, -1,
              10, 10, 10, 10),
            nrow=4, ncol=4, byrow=TRUE)

?mdp_check
mdp_check(T, R) # emptly list output means everything is OK

?mdp_policy_iteration
m <- mdp_policy_iteration(P=T,
                          R=R,
                          discount=0.9)

m$policy
names(T)[m$policy]
m$V

# Value of following policy as we move from state to state
# by taking the action chosen; our cumulative value increases
# you need to have knowledge of transition probability

# [1]  58.25663  69.09102  83.19292 100.00000

#Ref: packtpub.com