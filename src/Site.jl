module Site

import Codex
import GenTeX

using GenDoc

project_root()::String = Codex.dirparent(pathof(Site), 2)

"""
    process_post(filename)

Process (blog) post at `posts/<filename>`.
"""
function process_post(filename)
    include_path = joinpath(project_root(), "src", "posts", filename)
    text = include(include_path)
    frompath = joinpath(project_root(), "src", "posts", filename)
    name = Codex.rmextension(filename) 
    topath = joinpath(project_root(), "content", "posts", "$(name).md")
    im_dir = joinpath(project_root(), "static", "latex")
    extra_packages = raw"""
        \usepackage{amsfonts}
        \usepackage{mathtools}
        """
    with_latex = GenTeX.substitute_latex(text, 1.6, im_dir, extra_packages)
    open(topath, "w") do io
        write(io, with_latex)
    end
    topath
end

# At a later point, I might want at least one dynamic element per document.
# So, put all the posts in Julia code.

function generate() 
    posts = filter(endswith(".jl"), readdir(joinpath(project_root(), "src", "posts")))
    foreach(process_post, posts)
end

end # module
