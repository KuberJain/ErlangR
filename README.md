---
author: Dennis Lyubyvy, dennis.lyubyvy@gmail.com
layout: post
description: ErlangR set of functions discription
---
# ErlangR

### Set of functions to calculate call center agents and trunks requirements using ErlangB and ErlangC functions in R

####ErlangB 
Calculates the probability that trunks will be blocked
arrival_rate - number of calls per hour
av_call_duration_sec - duration of calls in seconds
n_trunks - number of trunks
    
####Trunks 
 Calculates nesessary number of trunks
    
arrival_rate - number of calls per hour
av_call_duration_sec - duration of calls in seconds
    
 
####ErlangC function calculates the probability of queue with initial parameters
    
arrival_rate - number of calls per interval
av_call_duration_sec - average duration of calls in seconds
n_agents - number of agents

####ASA 
Calculates Average Speed of Answer in seconds
    
arrival_rate - number of calls per interval
av_call_duration_sec - average duration of calls in seconds
n_agents - number of agents
    
####SL
Calculates average speed of answer in seconds
    
arrival_rate - number of calls per interval
av_call_duration_sec - average duration of calls in seconds
n_agents - number of agents

####Agents
Calculates nesessary number of agents to fit the service level requirements
    
arrival_rate - number of calls per interval
av_call_duration_sec - average duration of calls in seconds
wrap_up_time_sec - time in seconds nesessary to wrap up the call
max_waiting_time_sec - maximum allowed time to wait in queue, seconds
sl_target - target service level (% of calls that should be answered within max_waiting_time_sec time)
    

####Agents_to_schedule
Calculates minimum number of agents nesessary to meet the service level requirements
    
arrival_rate - number of calls per interval
av_call_duration_sec - average duration of calls in seconds
wrap_up_time_sec - time in seconds nesessary to wrap up the call
max_waiting_time_sec - maximum allowed time to wait in queue, seconds
sl_target - target service level (% of calls that should be answered within max_waiting_time_sec time)
average break per agent per hour in minutes
    

####Usage examples
ErlangB(arrival_rate = 120,av_call_duration_sec = 30,n_trunks = 4)

Trunks(arrival_rate = 120,av_call_duration_sec = 30,max_block_rate = 0.02)

ErlangC(arrival_rate=720, av_call_duration_sec=240, n_agents=55)

ASA(arrival_rate=720, av_call_duration_sec=300, n_agents=67)

SL(arrival_rate=720, av_call_duration_sec=240, n_agents=55, max_waiting_time_sec=15)

Agents(arrival_rate=720, av_call_duration_sec=300, wrap_up_time_sec = 0, sl_target=0.8, max_waiting_time_sec=15)

Agents_to_schedule(arrival_rate=720, av_call_duration_sec=300, wrap_up_time_sec = 10, max_waiting_time_sec=15, sl_target=0.8, break_time_min_per_hour=10)

