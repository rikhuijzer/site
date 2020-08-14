import InteractiveUtils
import RCall

read_times() = read(joinpath(project_root(), "content", "posts", "times.txt"), String)

content = string(
    GenDoc.generate_front_matter(;
        title = "'Building this site with R, Julia and Hugo'",
        date = string(Dates.today()),
        tags = "['Julia', 'Generate', 'Build', 'R']"
    ),
raw"""

After writing a few blog posts, it became apparent that the lack of a full programming environment is inefficient.
Especially posts on statistics since they contain lots of tables and graphs.
I wanted these posts without using copy and paste.
Therefore, a programming language was needed.
R is necessary for some of the statistics but is also not my favourite language.
For example, R it is inconsistent and unsuitable for larger projects (Morandat et al., 2012).
The Julia language is much better and can [call R](https://github.com/JuliaInterop/RCall.jl/).
Two notebook solutions exist for Julia to write text and program output side by side, namely [Jupyter](https://jupyter.org) and [Weave.jl](https://github.com/JunoLab/Weave).
These are very nice when you remain inside the constraints.
However, if you want to do something outside the constraints, then you need to read the documentation or might be out of luck.
So, I made my own package for [generating webpages](https://github.com/rikhuijzer/gendoc.jl) and another to include [LaTeX wihout Javascript](https://github.com/rikhuijzer/gentex.jl).
Now, the build pipeline looks much better:

$$
\begin{tikzpicture}[align=center]
\tikzstyle{box} = [rectangle, rounded corners, minimum width=2cm, minimum height=0.8cm, text centered, draw=black]
\tikzstyle{arrow} = [thick,->,>=stealth]
{\fontfamily{cmss}\selectfont
    \path 
        (0, 3.85) node[box] (latex) {LaTeX}
        (0, 2.5) node[box] (julia) {Julia}
        (0, 1.15) node[box] (r) {R}
        (3, 2.5) node[box] (hugo) {Hugo}
        (6, 2.5) node[box] (html) {HTML};
        
        \draw [arrow] (julia) -- (latex);
        \draw [arrow] (latex) -- (julia);
        \draw [arrow] (julia) -- (r);
        \draw [arrow] (r) -- (julia);
        \draw [arrow] (julia) -- (hugo);
        \draw [arrow] (hugo) -- (html);
}
\end{tikzpicture}
$$

Thanks to Julia, the build is quick.
The first call takes a reasonable amount of time and subsequent calls are blazingly fast.
As a demonstration, the build time for this website is shown below.
Next, the website is built again, which is also shown.

""", """

```
$(read_times())```

This speed is also achieved during development since [Revise.jl](https://github.com/timholy/revise.jl) automatically updates code changes.

## Version info

The source code for this website and the full history of builds are available at <https://github.com/rikhuijzer/site>.

```
$(begin
    string(RCall.R"sessionInfo()")
end)```

```
$(begin
    try
        mktemp() do path, io
            run(pipeline(`julia -e 'using InteractiveUtils; versioninfo()'`, stdout=path))
            return read(io, String)
        end
    catch
    end
end)```

```
$(begin
    mktemp() do path, io
        run(pipeline(`hugo version`, stdout=path))
        return read(path, String)
    end
end)
```

""", raw"""


## References

Morandat, F., Hill, B., Osvald, L., & Vitek, J. (2012). Evaluating the Design of the R Language. In J. Noble (Ed.), ECOOP 2012 – Object-Oriented Programming (Vol. 7313, pp. 104–131). Springer Berlin Heidelberg. https://doi.org/10.1007/978-3-642-31057-7_6

"""
)
