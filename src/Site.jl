module Site

import Codex
import GenTeX

using Dates
using TimeZones
using GenDoc

project_root()::String = Codex.dirparent(pathof(Site), 2)

"""
    process_page(filename, fromdir, topath)

Process a webpage.
"""
function process_page(filename, fromdir, topath)
    include_path = joinpath(fromdir, filename)
    text = include(include_path)
    im_dir = joinpath(project_root(), "static", "latex")
    extra_packages = raw"""
        \usepackage{amsfonts}
        \usepackage{mathtools}
        \usepackage{tikz}
        """
    with_latex = GenTeX.substitute_latex(text, 1.6, im_dir; extra_packages)
    open(topath, "w") do io
        write(io, with_latex)
    end
    topath
end

"""
    process_post(filename)

Process (blog) post at `posts/<filename>`.
"""
function process_post(filename)
    fromdir = joinpath(project_root(), "src", "posts")
    name = Codex.rmextension(filename) 
    topath = joinpath(project_root(), "content", "posts", "$(name).md")
    process_page(filename, fromdir, topath)
end

function generate() 
    posts = filter(endswith(".jl"), readdir(joinpath(project_root(), "src", "posts")))
    foreach(process_post, posts)
end

"""
    generate_and_time()

Generate website multiple times and stores the time required per build.
"""
function generate_and_time()
    # Writing to file since it avoids cluttering the code with passing the message.
    function write_times(times)
        open(joinpath(project_root(), "static", "times.txt"), "w") do io
            write(io, times)
        end
    end
    function bench()::String 
        start_time = Dates.now()
        generate()
        duration = string(Dates.now() - start_time)
    end
    write_times("undefined\n")
    times = map(i -> bench(), 1:4)
    show_time(time::String) = """
    julia> Site.generate()
    Built website in $(time).
    """
    times = join(map(show_time, times), '\n')
    write_times(times)
    fromdir = joinpath(project_root(), "src")
    topath = joinpath(project_root(), "content", "about-site.md")
    process_page("about-site.jl", fromdir, topath)
end

end # module
