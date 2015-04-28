ErlangB <- function(arrival_rate,av_call_duration_sec,n_trunks) {
    #ErlangB function calculates the probability that trunks will be blocked
    # arrival_rate - number of calls per hour
    # av_call_duration_sec - duration of calls in seconds
    # n_trunks - number of trunks
    
    traffic_intensity <- arrival_rate*(av_call_duration_sec/3600)
    return((traffic_intensity^n_trunks/factorial(n_trunks))/sum(traffic_intensity^(0:n_trunks)/factorial(0:n_trunks)))
    
}

Trunks <- function(arrival_rate,av_call_duration_sec,max_block_rate) {
    #Trunks function calculates nesessary number of trunks
    
    # arrival_rate - number of calls per hour
    # av_call_duration_sec - duration of calls in seconds
    
    
    traffic_intensity <- arrival_rate*(av_call_duration_sec/3600)
    n_trunks <- traffic_intensity
    while (ErlangB(arrival_rate,av_call_duration_sec,n_trunks)>max_block_rate) {n_trunks<- n_trunks+1}
    return(n_trunks)
    
}

ErlangC <- function(arrival_rate, av_call_duration_sec, n_agents) {
    # ErlangC function calculates the probability of queue with initial parameters
    
    # arrival_rate - number of calls per interval
    # av_call_duration_sec - average duration of calls in seconds
    # n_agents - number of agents
    traffic_intensity <- arrival_rate*(av_call_duration_sec/3600)
    agents_occupancy <- traffic_intensity/n_agents
    return((traffic_intensity^n_agents/factorial(n_agents))/(traffic_intensity^n_agents/factorial(n_agents)+(1-agents_occupancy)*sum(traffic_intensity^(0:(n_agents-1))/factorial(0:(n_agents-1)))))
    
}


ASA <- function(arrival_rate, av_call_duration_sec, n_agents) {
    #ASA function calculates Average Speed of Answer in seconds
    
    # arrival_rate - number of calls per interval
    # av_call_duration_sec - average duration of calls in seconds
    # n_agents - number of agents
    
    traffic_intensity <- arrival_rate*(av_call_duration_sec/3600)
    agents_occupancy <- traffic_intensity/n_agents
    return(ceiling(ErlangC(arrival_rate, av_call_duration_sec, n_agents)*av_call_duration_sec/(n_agents*(1-agents_occupancy))))
    
}

SL <- function(arrival_rate, av_call_duration_sec, n_agents, max_waiting_time_sec) {
    #SL function calculates average speed of answer in seconds
    
    # arrival_rate - number of calls per interval
    # av_call_duration_sec - average duration of calls in seconds
    # n_agents - number of agents
    
    traffic_intensity <- arrival_rate*(av_call_duration_sec/3600)
    return(1-ErlangC(arrival_rate, av_call_duration_sec, n_agents)*exp(-(n_agents-traffic_intensity)*(max_waiting_time_sec/av_call_duration_sec)))
    
}

Agents <- function(arrival_rate, av_call_duration_sec, wrap_up_time_sec=0, max_waiting_time_sec, sl_target) {
    # Agents function calculates nesessary number of agents to fit the service level requirements
    
    # arrival_rate - number of calls per interval
    # av_call_duration_sec - average duration of calls in seconds
    # wrap_up_time_sec - time in seconds nesessary to wrap up the call
    # max_waiting_time_sec - maximum allowed time to wait in queue, seconds
    # sl_target - target service level (% of calls that should be answered within max_waiting_time_sec time)
    
    total_call_duration_sec <- av_call_duration_sec+wrap_up_time_sec
    traffic_intensity <- arrival_rate*(total_call_duration_sec/3600)
    n_agents <- traffic_intensity
    while (SL(arrival_rate, total_call_duration_sec, n_agents, max_waiting_time_sec)<=sl_target) {n_agents <- n_agents+1}
    return(n_agents)
    
}

Agents_to_schedule <- function(arrival_rate, av_call_duration_sec, wrap_up_time_sec=0, sl_target, max_waiting_time_sec, break_time_min_per_hour) {
    # Agents_to_schedule - function that calculates minimum number of agents nesessary to meet the service level requirements
    
    # arrival_rate - number of calls per interval
    # av_call_duration_sec - average duration of calls in seconds
    # wrap_up_time_sec - time in seconds nesessary to wrap up the call
    # max_waiting_time_sec - maximum allowed time to wait in queue, seconds
    # sl_target - target service level (% of calls that should be answered within max_waiting_time_sec time)
    # average break per agent per hour in minutes
    
    return(ceiling(Agents(arrival_rate, av_call_duration_sec, wrap_up_time_sec=0, sl_target, max_waiting_time_sec)/(1-break_time_min_per_hour/60)))
    
}

#Usage examples
ErlangB(arrival_rate = 120,av_call_duration_sec = 30,n_trunks = 4)

Trunks(arrival_rate = 120,av_call_duration_sec = 30,max_block_rate = 0.02)

ErlangC(arrival_rate=720, av_call_duration_sec=240, n_agents=55)

ASA(arrival_rate=720, av_call_duration_sec=300, n_agents=67)

SL(arrival_rate=720, av_call_duration_sec=240, n_agents=55, max_waiting_time_sec=15)

Agents(arrival_rate=720, av_call_duration_sec=300, wrap_up_time_sec = 0, sl_target=0.8, max_waiting_time_sec=15)

Agents_to_schedule(arrival_rate=720, av_call_duration_sec=300, wrap_up_time_sec = 10, max_waiting_time_sec=15, sl_target=0.8, break_time_min_per_hour=10)