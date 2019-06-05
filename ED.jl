using JuMP
using CPLEX
const g_max=[1000,1000];
const g_min=[0,300];
const c_g=[50,100];
const c_g0=[1000,0];
const c_w = 50;
const d = [1500, 1400];
const w_f = [200,150];
function solve_ed(g_max, g_min, c_g, c_w, d, w_f)
ed=Model(with_optimizer(CPLEX.Optimizer))
    @variable(ed, 0 <= g[i=1:2,t=1:2]) # power output of generators
    @variable(ed, 0 <= w[t=1:2]) # wind power injection
    # Define the objective function
    @objective(ed,Min,sum(sum(c_g[i] * g[i,t] for i=1:2)+c_w * w[t] for t=1:2))
# Define the constraint on the maximum and minimum power output of each generator
    for i in 1:2, t=1:2
        @constraint(ed,  g[i,t] <= g_max[i]) #maximum
        @constraint(ed,  g[i,t] >= g_min[i]) #minimum
    end
    # Define the constraint on the wind power injection
    for t in 1:2
        @constraint(ed, w[t] <= w_f[t])
    end
    # Define the power balance constraint
    for t in 1:2
        @constraint(ed, sum(g[i,t] for i=1:2) + w[t] == d[t])
    end
@time optimize!(ed)
println(termination_status(ed))
return JuMP.value.(g), JuMP.value.(w), w_f- JuMP.value.(w), objective_value(ed)
end
# Solve the economic dispatch problem

(g_opt,w_opt,ws_opt,obj)=solve_ed(g_max, g_min, c_g, c_w, d, w_f);
