# This file was generated, do not modify it. # hide
Refpath="/tmp/resultJ.txt"
Tarpath="/tmp/resultJ2.txt"
run(`bash -c "cmp --silent $Refpath $Tarpath || echo \"files are different\""`)

using CSV
using Plots
df = CSV.read(Tarpath,header=false)
img = convert(Matrix, df)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath(@OUTPUT, "mandJ2.svg")) #hide