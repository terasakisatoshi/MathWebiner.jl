dir = @__DIR__
"""
genplain(s)

Small helper function to run some code and redirect the output (stdout) to a file.
"""
function genplain(s::String)
    open(joinpath(dir, "output", "$(splitext(s)[1]).out"), "w") do outf
        redirect_stdout(outf) do
            include(joinpath(dir, s))
        end
    end
end
# run `script1.jl` and redirect what it prints to `output/script1.out`

genplain("mandP.jl")
include("vismandP.jl")
