@def title = "Implement more Julian"
@def hasmath = true
@def hascode = true

\chapter{パフォーマンスを維持したままJuliaらしく}

```julia:mandJ
using DelimitedFiles

function cnt(ReZ, ImZ, ReC, ImC)
    k::UInt8 = 0
    while (k < 255)
        new_ReZ = ReZ * ReZ - ImZ * ImZ + ReC
        new_ImZ = 2 * ReZ * ImZ + ImC
        if new_ReZ * new_ReZ + new_ImZ * new_ImZ > 4.
            return k
        end
        ReZ = new_ReZ
        ImZ = new_ImZ
        k += 1
    end
    return k
end

function mand(M,N)
    grid = Array{UInt8}(undef, M, N)
    init_Re = 0.0
    init_Im = 0.0
    for j = 1:N
        for i = 1:M
            ReC = 4.0 / (M - 1) * (j - 1) - 2.0
            ImC = 4.0 / (N - 1) * (i - 1) - 2.0
            ReZ = init_Re
            ImZ = init_Im
            grid[i, j] = cnt(ReZ, ImZ, ReC, ImC)
        end
    end
    return grid
end

function main()
    s = time()
    M = N = 5000
    grid = mand(M,N)
    t = time()
    @show(t - s)
    writedlm("/tmp/resultJ.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(5000, 5000);
```

\output{mandJ}

```julia:plotmandJ
Tarpath="/tmp/resultJ.txt"
using CSV
using Plots
df = CSV.read(Tarpath,header=false)
img = convert(Matrix, df)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath(@OUTPUT, "mandJ.svg")) #hide
```

\fig{mandJ}

```julia:mandJ1
using DelimitedFiles

function cnt(z,c)
    k::UInt8 = 0
    while (k < 255)
        z = z^2 + c
        if abs2(z)>4.
            return k
        end
        k += 1
    end
    return k
end

function mand(M, N)
    grid = Array{UInt8}(undef, M, N)
    init_z = ComplexF64(0.0, 0.0)
    xs = range(-2,2,length=N)
    ys = range(-2,2,length=M)
    for (i,x) in enumerate(xs)
        for (j,y) in enumerate(ys)
            grid[j, i] = cnt(init_z,ComplexF64(x, y))
        end
    end
    return grid
end

function main()
    s = time()
    M = N = 5000
    grid = mand(M, N)
    t = time()
    @show(t - s)
    writedlm("/tmp/resultJ1.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(5000, 5000);
```

\output{mandJ1}

```julia:plotmandJ1
Refpath="/tmp/resultJ.txt"
Tarpath="/tmp/resultJ1.txt"
run(`bash -c "cmp --silent $Refpath $Tarpath || echo \"files are different\""`)

using CSV
using Plots
df = CSV.read(Tarpath,header=false)
img = convert(Matrix, df)
M,N = img |> size
p = heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath(@OUTPUT, "mandJ1.svg")) #hide
```

\output{plotmandJ}

\fig{mandJ1}

```julia:mandJ2
using DelimitedFiles

function cnt(z,c)
    k::UInt8 = 0
    while (k < 255)
        z = z^2 + c
        if abs2(z)>4.
            return k
        end
        k += 1
    end
    return k
end

function mand(M, N)
    grid = Array{UInt8}(undef, M, N)
    init_z = ComplexF64(0.0, 0.0)
    xs = range(-2,2,length=N)
    ys = range(-2,2,length=M)
    grid = cnt.(init_z,ComplexF64.(xs',ys))
    return grid
end

function main()
    s = time()
    M = N = 5000
    grid = mand(M, N)
    t = time()
    @show(t - s)
    writedlm("/tmp/resultJ2.txt",grid,",")
end

main()

using BenchmarkTools
@btime mand(5000, 5000);
```

\output{mandJ2}

```julia:plotmandJ2
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
```

\output{plotmandJ}

\fig{mandJ2}
