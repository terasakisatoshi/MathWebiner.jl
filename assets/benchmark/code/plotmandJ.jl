# This file was generated, do not modify it. # hide
Cpath="/tmp/resultC.txt"
Jpath="/tmp/resultJ.txt"
run(`bash -c "cmp --silent $Cpath $Jpath || echo \"files are different\""`)

using CSV
using Plots
df=CSV.read(Jpath,header=false)
img=convert(Matrix,df)
M,N = img |> size
p=heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath(@OUTPUT, "mandJ.svg"))