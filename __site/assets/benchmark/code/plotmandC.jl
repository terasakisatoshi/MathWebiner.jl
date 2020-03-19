# This file was generated, do not modify it. # hide
using CSV
using Plots
df=CSV.read("/tmp/resultC.txt",header=false)
img=convert(Matrix,df)
M,N = img |> size
p=heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath(@OUTPUT, "mandC.svg"))