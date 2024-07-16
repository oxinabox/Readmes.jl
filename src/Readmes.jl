module Readmes
export generate_readme

function header_text(template_file)
    """
    <!-- DO NOT EDIT THIS FILE DIRECTLY -->
    <!-- This file is machine generated from $template_file -->
    """
end

"""
    generate_readme([outfile], [template_file], [module_name])

Generates the readme from `template_file` storing the result in template_file.
it automatically load the module of `module_name`
If none of the options are provided, they are defaulted for the current directory.
i.e. if in the top level project directory can just run `generate_readme()`.
"""
function generate_readme(;
    out_file = "README.md",
    template_file = "README.template.md",
    module_name = Symbol(basename(pwd())[1:end-3])
)
    isfile(template_file) || error("Template file: $template_file not found")
    Main.eval(:(using $module_name))
    buf = generate_readme(IOBuffer, template_file) 
    open(out_file, "w") do fh 
        write(fh, read(buf))
    end
    return out_file
end

"""
    generate_readme(IOBuffer, template_file)

Generates the readme from the templace file, returning the result in an IOBuffer which can be read.
"""
function generate_readme(::Type{IOBuffer}, template_file)
    template = read(template_file, String)
    
    outbuf = IOBuffer()
    print(outbuf, header_text(template_file))
    last_read_loc = 1
    for docblock_match in eachmatch(r"```@docs\n(.*?)```"s, template)
        # insert text between docstrings
        println(outbuf, @view template[last_read_loc : docblock_match.offset-1])
        last_read_loc = docblock_match.offset + length(docblock_match.match)
        
        println(outbuf, "\n---\n")
        # insert docstrings
        for func_name in split(only(docblock_match), "\n")
            func_name = strip(func_name)
            isempty(func_name) && continue
            docstring = get_docstring(func_name)
            println(outbuf, docstring)
        end
        println(outbuf, "\n---\n")
    end
    # insert text after docstrings
    println(outbuf, @view template[last_read_loc : end])
    return seek(outbuf, 0)
end

function get_docstring(func_name::AbstractString)
    # TODO: insert better code here that gets the docs programatically
    docstring = (@eval Main (@doc $(Meta.parse(func_name))))
    isnothing(docstring) && error("docstring for $func_name not found")
    return docstring
end

"""
    generate_readme(String, template_file)

Generates the readme from the templace file, returning the result as a `String`
"""
generate_readme(String, template_file) = read(generate_readme(IOBuffer, template_file), String)


end