---
title: 'Building this site with R, Julia and Hugo'
date: 2020-08-14
tags: ['Julia', 'Generate', 'Build', 'R']
---

[//]: # (GENERATED FILE. DO NOT MODIFY.)


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

<center><img src="/latex/13738612934534280949.svg" width="364.8" height="161.6"></center>

Thanks to Julia, the build is quick.
The first call takes a reasonable amount of time and subsequent calls are blazingly fast.
As a demonstration, the build time for this website is shown below.
Next, the website is built again, which is also shown.


```
julia> Site.generate()
Built website in 98 milliseconds.

julia> Site.generate()
Built website in 66 milliseconds.

julia> Site.generate()
Built website in 68 milliseconds.
```

This speed is also achieved during development since [Revise.jl](https://github.com/timholy/revise.jl) automatically updates code changes.

## Version info

The source code for this website and the full history of builds are available at <https://github.com/rikhuijzer/site>.

```
RCall.RObject{RCall.VecSxp}
R version 3.6.2 (2019-12-12)
Platform: x86_64-pc-linux-gnu (64-bit)
Running under: NixOS 20.03 (Markhor)

Matrix products: default
BLAS/LAPACK: /nix/store/z5zif8fb5s0zdml99l0zm9cd013i05sc-openblas-0.3.7/lib/libopenblasp-r0.3.7.so

locale:
 [1] LC_CTYPE=en_US.UTF-8          LC_NUMERIC=C                 
 [3] LC_TIME=en_US.UTF-8           LC_COLLATE=en_US.UTF-8       
 [5] LC_MONETARY=en_US.UTF-8       LC_MESSAGES=en_US.UTF-8      
 [7] LC_PAPER=en_US.UTF-8          LC_NAME=en_US.UTF-8          
 [9] LC_ADDRESS=en_US.UTF-8        LC_TELEPHONE=en_US.UTF-8     
[11] LC_MEASUREMENT=en_US.UTF-8    LC_IDENTIFICATION=en_US.UTF-8

attached base packages:
[1] stats     graphics  grDevices utils     datasets  methods   base     

loaded via a namespace (and not attached):
[1] compiler_3.6.2
```

```
Julia Version 1.5.0
Commit 96786e22cc (2020-08-01 23:44 UTC)
Platform Info:
  OS: Linux (x86_64-pc-linux-gnu)
  CPU: Intel(R) Core(TM) i5-8259U CPU @ 2.30GHz
  WORD_SIZE: 64
  LIBM: libopenlibm
  LLVM: libLLVM-9.0.1 (ORCJIT, skylake)
```

```
Hugo Static Site Generator v0.64.0/extended linux/amd64
```



## References

Morandat, F., Hill, B., Osvald, L., & Vitek, J. (2012). Evaluating the Design of the R Language. In J. Noble (Ed.), ECOOP 2012 – Object-Oriented Programming (Vol. 7313, pp. 104–131). Springer Berlin Heidelberg. https://doi.org/10.1007/978-3-642-31057-7