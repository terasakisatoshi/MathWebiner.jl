# This file was generated, do not modify it. # hide
function cnt(ReZ, ImZ, ReC, ImC)
    k = 0
    while (k < 100)
        new_ReZ = ReZ * ReZ - ImZ * ImZ + ReC
        new_ImZ = 2 * ReZ * ImZ + ImC
        if new_ReZ * new_ReZ + new_ImZ * new_ImZ > 4
            return k
        end
        ReZ = new_ReZ
        ImZ = new_ImZ
        k += 1
    end
    return k
end

function main()
    s = time()
    N = 2500
    M = N
    grid = Array{UInt8}(undef, M, N)
    init_Re = 0.0
    init_Im = 0.0
    for j = 1:N
        for i = 1:M
            ReC = 4.0 / (N - 1) * (i - 1) - 2.0
            ImC = 4.0 / (M - 1) * (j - 1) - 2.0
            ReZ = init_Re
            ImZ = init_Im
            grid[i, j] = cnt(ReZ, ImZ, ReC, ImC)
        end
    end
    t = time()
    @show(t - s)
    io = open("/tmp/resultJ.txt", "w")
    for j = 1:M
        for i = 1:N
            print(io, grid[i, j])
            if i != N
                print(io, ',')
            else
                println(io)
            end
        end
    end
    close(io)
end

main()