
using JuMP
using Ipopt

### problem 1
#-----------------------------------------------
q1 = Model(solver = IpoptSolver())

@variable(q1, x1)
@variable(q1, x2)
@variable(q1, x3)

@objective(q1, Min, x1^2 + 0.5*x2^2 + 0.25*x3^2)

@constraint(q1, cons1b, 0.5*x1 + x2 == 10)
@constraint(q1, cons1c, 0.5*x1 + x3 == 20)

# print optimization model
print(q1)

# save the status
status = solve(q1)

# output results
println("Objective value: ", getobjectivevalue(q1))
println("x1 = ", getvalue(x1))
println("x2 = ", getvalue(x2))
println("x3 = ", getvalue(x3))
println("Lagrangian Multiplier for constraint (1b) = ", getdual(cons1b))
println("Lagrangian Multiplier for constraint (1c) = ", getdual(cons1c))

### problem 1
#-----------------------------------------------
q2 = Model(solver = IpoptSolver())

@variable(q2, x1)
@variable(q2, x2)

@objective(q2, Min, x1 + x2)

@constraint(q2, cons2b, 2*x1 + x2 >= 10)
@constraint(q2, cons2c, x1 + 2*x2 >= 5)

# print optimization model
print(q2)

# save the status
status = solve(q2)

# output results
println("Objective value: ", getobjectivevalue(q2))
println("x1 = ", getvalue(x1))
println("x2 = ", getvalue(x2))
println("Lagrangian Multiplier for constraint (2b) = ", getdual(cons2b))
println("Lagrangian Multiplier for constraint (2c) = ", getdual(cons2c))

### problem 3.1
#-----------------------------------------------
q31 = Model(solver = IpoptSolver())

# define power output
@variable(q31, 100 <= p1 <= 200)
@variable(q31, 50 <= p2 <= 150)
@variable(q31, p3 >= 0)
@variable(q31, p4 >= 0)

# write with the cost expressions for each generator
@expression(q31, cost1, 300 + 12*p1 + 0.05*p1^2)
@expression(q31, cost2, 250 + 13*p2 + 0.06*p2^2)
@expression(q31, cost3, 150 + 11*p3 + 0.08*p3^2)
@expression(q31, cost4, 200 + 10*p4 + 0.07*p4^2)

# objective is to minimize total cost
@objective(q31, Min, cost1 + cost2 + cost3 + cost4)

# power balance constraint
@constraint(q31, consPowerBalance, p1 + p2 + p3 + p4 == 800)

# print optimization model
print(q31)

# save the status
status = solve(q31)

# output results
println("Objective value: ", getobjectivevalue(q31))
println("P1 = ", getvalue(p1))
println("P2 = ", getvalue(p2))
println("P3 = ", getvalue(p3))
println("P4 = ", getvalue(p4))
println("Lagrangian Multiplier = ", getdual(consPowerBalance))

### problem 3.2
#-----------------------------------------------
q32 = Model(solver = IpoptSolver())

# define power output
@variable(q32, 100 <= p1 <= 200)
@variable(q32, 50 <= p2 <= 150)
@variable(q32, 100 <= p3 <= 300)
@variable(q32, 150 <= p4 <= 300)

# write with the cost expressions for each generator
@expression(q32, cost1, 300 + 12*p1 + 0.05*p1^2)
@expression(q32, cost2, 250 + 13*p2 + 0.06*p2^2)
@expression(q32, cost3, 150 + 11*p3 + 0.08*p3^2)
@expression(q32, cost4, 200 + 10*p4 + 0.07*p4^2)

# objective is to minimize total cost
@objective(q32, Min, cost1 + cost2 + cost3 + cost4)

# power balance constraint
@constraint(q32, consPowerBalance, p1 + p2 + p3 + p4 == 800)

# print optimization model
print(q32)

# save the status
status = solve(q32)

# output results
println("Objective value: ", getobjectivevalue(q32))
println("P1 = ", getvalue(p1))
println("P2 = ", getvalue(p2))
println("P3 = ", getvalue(p3))
println("P4 = ", getvalue(p4))
println("Lagrangian Multiplier = ", getdual(consPowerBalance))


