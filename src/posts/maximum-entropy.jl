using DataFrames
using GenDoc
using RCall

function plot_distribution(name, Y) 
    df = DataFrame(n = 1:6, y = Y)
    p = R"
    library(ggplot2)
    library(latex2exp)
    # Transparant theme for ggplot which looks better on website.
    transparent_theme <- theme(
        panel.background = element_rect(fill = 'transparent'), # bg of the panel
        plot.background = element_rect(fill = 'transparent', color = NA), # bg of the plot
        panel.grid.major = element_blank(), # get rid of major grid
        panel.grid.minor = element_blank(), # get rid of minor grid
        legend.background = element_rect(fill = 'transparent'), # get rid of legend bg
        legend.box.background = element_rect(fill = 'transparent'), # get rid of legend panel bg
        legend.key = element_rect(fill = 'transparent', colour = NA), # get rid of key legend fill, and of the surrounding
        axis.line = element_line(colour = 'black') # adding a black line for x and y axis
    )

    ggplot($df, aes(n, y)) + 
        ylab(TeX('$P_n$')) +
        transparent_theme +
        # Force print all 6 labels.
        scale_x_discrete(limits=1:6) +
        coord_cartesian(ylim=c(0,1)) +
        geom_bar(stat='identity')
    "
    path_prefix = joinpath(project_root(), "static", "plots")
    this_filename = first(split(basename(@__FILE__), '.'))
    dir = joinpath(path_prefix, this_filename)
    path_prefix = mkpath(dir)
    @show path_prefix
    path = joinpath(dir, "$name.png")
    rplot("$name.svg"; path_prefix=path_prefix, uri_prefix="/plots/$this_filename", width=4, height=0.8, scale=1.6, bg="transparent")
end

title = "Principle of maximum entropy"

content = "
$(GenDoc.generate_front_matter(; title="Principle of maximum entropy", date="2020-09-26"))

Say that you are a statistician and are asked to come up with a probability distribution for the current state of knowledge on some particular topic you know nothing about.
(This, in Bayesian statistics, is known as choosing a suitable prior.)
To do this, the safest bet is coming up with the least informative distribution via the *principle of maximum entropy*.

The principle is clearly explained by Jaynes (1968):
Consider a die which has been tossed a very large number of times \$N\$.
We expect the average to be \$3.5\$, that is, we expect the following distribution where \$P_n = \\frac{1}{6}\$ for each \$n\$.

$(plot_distribution("unbiased", [1/6, 1/6, 1/6, 1/6, 1/6, 1/6]))

Instead, we are told that the average is \$4.5\$.
How likely is it for each number \$n = 1,2, \\ldots, 6\$ to come up for the next toss?

Since we know that \$P\$ always sums to 1, we have

\\[ \\sum_{n=1}^6 P_n = 1. \\]

We also know that the average is \$4.5\$, that is,

\\[ \\sum_{n=1}^6 n \\cdot P_n = 4.5. \\]

We could satisfy these constraints by choosing \$P_4 = P_5 = \\frac{1}{2}\$

$(plot_distribution("naive", [0, 0, 0, 0.5, 0.5, 0]))

This is unlikely to be the distribution for our data since it can be derived in relatively few ways, namely: by only throwing \$4\$ and \$5\$, and in such a way that the throws average to \$4.5\$.
A more likely distribution would be 

$(plot_distribution("quarters", [0, 0, 1/4, 1/4, 1/4, 1/4]))

This is still not the least informative distribution since it assumes \$n = 1\$ and \$n = 2\$ to be impossible events.
Jaynes presents the straight line solution \$P_n = (12n - 7)/210\$,

$(plot_distribution("straight", map(n -> (12n - 7)/210, 1:6)))

This solution would also fail if the mean would have been higher, because then \$P_0 = 0\$ would occur again.
The correct measure is the following information measure (Shannon, 1948), which is also known as information entropy,

\\[ S_I = - \\sum_i p_i \\log p_i. \\]

We can find \$p_i\$ for \$p_i = 1, 2, \\ldots, 6\$ by maximizing \$S_I\$ for given constraints.
This problem, known as MaxEnt, is hard to solve since there are \$6\$ unknowns and various constraints.
The solution can be approximated by rewriting the problem as a linear program.

Alternatively, analytic solutions exist for some subsets of this Shanon entropy maximization problem (Zabarankin and Uryasev, 2014).
Here, we have that only the mean is known, so the number of moments \$m\$ is \$1\$.
Then, the maximum entropy distribution takes the form (Zabarankin and Uryasev, 2014; Eq. 5.1.7)

\\[ P_n = \\frac{e^{\\rho n}}{\\sum_{n=1}^6 e^{\\rho n}}, \\: \\text{ for } n = 1, 2, ..., 6. \\]

This function satisfies \$\\sum_{n=1}^6 P_n = 1\$ for any \$\\rho\$.
Now, we only have to find the \$\\rho\$ for which the average is \$4.5\$.
After some [trial and error](#trial-and-error), you'll find that \$\\rho = 0.3715\$ gives \$\\sum_{n=1}^6 n \\cdot P_n \\approx 4.501\$.

$(plot_distribution("entropy", [0.05426741458481561, 0.07868275019416264, 0.11408273685935422, 0.165409455277101, 0.2398284670256302, 0.3477291760589363]))

This is the least informative distribution which satisfies the constraints.
In other words, this is the distribution which can be obtained in the largest number of ways, given the constraints.
For another example of maximum entropy distributions, see Chapter 10.1 of McElreath (2020).

### References
Jaynes, E. T. (1968). Prior Probabilities. IEEE Transactions on Systems Science and Cybernetics. 4 (3): 227–241. 
https://doi.org/10.1109/TSSC.1968.300117

McElreath, R. (2020). Statistical Rethinking: A Bayesian course with examples in R and Stan. CRC press.

Shannon, C. E. (1948). A mathematical theory of communication. The Bell System Technical Journal (Volume: 27 , Issue: 3 , July 1948). https://doi.org/10.1002/j.1538-7305.1948.tb01338.x

Zabarankin M., Uryasev S. (2014) Entropy Maximization. In: Statistical Decision Problems. Springer Optimization and Its Applications, vol 85. Springer, New York, NY. https://doi.org/10.1007/978-1-4614-8471-4_5

## Trial and error

```julia
julia > p(k, rho) = exp(rho*k) / sum([exp(rho*1), exp(rho*2), exp(rho*3), exp(rho*4), exp(rho*5), exp(rho*6)])
julia > function ps(rho)
    values = map(k -> p(k, rho), 1:6)
    @show values
    sum_values = sum(values)
    @show sum_values
    average = sum([values[1]*1, values[2]*2, values[3]*3, values[4]*4, values[5]*5, values[6]*6])
    @show average
    nothing
end

julia> ps(0.4)
values = [0.04906874617024226, 0.0732019674190579, 0.1092045029116822, 0.16291397453728548, 0.24303909080562353, 0.36257171815610867]
sum_values = 1.0
average = 4.565367850857316

julia> ps(0.34)
values = [0.0605247711421319, 0.08503413138555115, 0.11946849800579816, 0.16784697842149762, 0.23581620791666263, 0.3313094131283586]
sum_values = 1.0
average = 4.427323959970084

...

julia> ps(0.3715)
values = [0.05426741458481561, 0.07868275019416264, 0.11408273685935422, 0.165409455277101, 0.2398284670256302, 0.3477291760589363]
sum_values = 1.0
average = 4.501036338141376
```

"
