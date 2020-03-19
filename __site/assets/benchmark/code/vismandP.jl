Cpath="/tmp/resultC.txt"
Ppath="/tmp/resultP.txt"
run(`diff $Cpath $Ppath`)
run(`bash -c "cmp --silent $Cpath $Ppath || echo \"files are different\""`)

using CSV
using Plots
df=CSV.read(Ppath,header=false)
img=convert(Matrix,df)
M,N = img |> size
p=heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath("output", "mandP.svg")) #hide

