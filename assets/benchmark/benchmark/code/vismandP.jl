Refpath="/tmp/benchC.txt"
Tarpath="/tmp/benchP.txt"
run(`bash -c "cmp --silent $Refpath $Tarpath || echo \"files are different\""`)

using DelimitedFiles
using Plots

img = readdlm(Tarpath, ',', Int)
M,N = img |> size
p=heatmap(1:N,1:M,img,aspect_ratio=1, size=(400,400))
savefig(p, joinpath("output", "mandP.svg")) #hide
