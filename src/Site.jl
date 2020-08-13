module Site

import Codex
import GenTeX

using GenDoc

project_root()::String = Codex.dirparent(pathof(Site), 2)

include("posts/combinations-permutations.jl")

# At a later point, I might want at least one dynamic element per document.
# So, put all the posts in Julia code.

function generate() 
    text = combinations_permutations()
    frompath = joinpath(project_root(), "src", "posts", "combinations-permutations.jl")
    topath = joinpath(project_root(), "content", "posts", "combinations-permutations.md")
    im_dir = joinpath(project_root(), "static", "latex")
    with_latex = GenTeX.substitute_latex(text, 1.6, im_dir)
    open(topath, "w") do io
        write(io, with_latex)
    end
    "done"
end

end # module
