read_times() = read(joinpath(project_root(), "content", "posts", "times.txt"), String)

content = string(
    GenDoc.generate_front_matter(;
        title = "'Building this site with R and Julia'",
        date = "2020-08-14",
        tags = "['Julia', 'Generate', 'Build', 'R']"
    ),
raw"""

After writing a few blog posts, I became annoyed by the fact that I did not have a full programming language available.
Especially the posts on statistics contain a lot of tables and graphs.
I wanted to add these without using copy and paste.
Therefore, a programming language was needed.
R is necessary for some of the statistics but is also not my favourite language.
For example, R it is inconsistent and unsuitable for larger projects (Morandat et al., 2012).
The Julia language is much better and can [call R](https://github.com/JuliaInterop/RCall.jl/).
For Julia, two notebook solutions exist to write text and program output side by side.
Notebooks via [Jupyter](https://jupyter.org/) or [Weave.jl](https://github.com/JunoLab/Weave.jl) are very nice when you remain inside the constraints.
However, if you want to do something outside the constraints, then you need to go through a large part of the documentation or might be out of luck.
So, I made [my own package](https://github.com/rikhuijzer/gendoc.jl) and another to include [LaTeX wihout Javascript](https://github.com/rikhuijzer/gentex.jl).
Now, the build pipeline looks as follows:

$$
\begin{tikzpicture}[align=center]
\tikzstyle{box} = [rectangle, rounded corners, minimum width=2cm, minimum height=0.8cm, text centered, draw=black]
\tikzstyle{arrow} = [thick,->,>=stealth]
{\fontfamily{cmss}\selectfont
    \path 
        (0, 2.5) node[box] (julia) {Julia}
        (0, 1.15) node[box] (r) {R}
        (3, 2.5) node[box] (hugo) {Hugo}
        (6, 2.5) node[box] (html) {HTML};
        
        \draw [arrow] (julia) -- (r);
        \draw [arrow] (r) -- (julia);
        \draw [arrow] (julia) -- (hugo);
        \draw [arrow] (hugo) -- (html);
}
\end{tikzpicture}
$$

Local development is quick thanks to Julia and [Revise.jl](https://github.com/timholy/Revise.jl).

Calling the build for the first time takes a while, but subsequent calls are blazingly fast.
These are the build times for building this website a few times:

""", """

```
$(read_times())
```

This speed is almost unaffected when changing the code since Revise will only reload the parts which have changed.
""", raw"""


## References

Morandat, F., Hill, B., Osvald, L., & Vitek, J. (2012). Evaluating the Design of the R Language. In J. Noble (Ed.), ECOOP 2012 – Object-Oriented Programming (Vol. 7313, pp. 104–131). Springer Berlin Heidelberg. https://doi.org/10.1007/978-3-642-31057-7_6

"""
)
