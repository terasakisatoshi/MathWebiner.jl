# This file was generated, do not modify it. # hide
Tarpath="/tmp/resultJ.txt"
using CSV
using Plots
df = CSV.read(Tarpath,header=false)
img = convert(Matrix, df)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath(@OUTPUT, "mandJ.svg")) #hide