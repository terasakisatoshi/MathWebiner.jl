import time
import numpy as np


def cnt(ReZ, ImZ, ReC, ImC):
    k = 0
    while k < 255:
        new_ReZ = ReZ * ReZ - ImZ * ImZ + ReC
        new_ImZ = 2 * ReZ * ImZ + ImC
        if new_ReZ * new_ReZ + new_ImZ * new_ImZ > 4:
            return k
        ReZ = new_ReZ
        ImZ = new_ImZ
        k += 1
    return k


def main():
    s = time.time()
    N = 2500
    M = N
    grid = np.empty((M, N), dtype=np.uint8)
    init_Re = 0.0
    init_Im = 0.0
    for j in range(M):
        for i in range(N):
            ReC = 4. / (N - 1) * i - 2.0
            ImC = 4. / (M - 1) * j - 2.0
            ReZ = init_Re
            ImZ = init_Im
            grid[j, i] = cnt(ReZ, ImZ, ReC, ImC)
    t = time.time()
    elapsed = f"elapsed time {t-s}"
    with open("/tmp/benchP.txt", "w") as f:
        for j in range(M):
            for i in range(N):
                f.write(str(grid[j, i]))
                if i == N - 1:
                    f.write('\n')
                else:
                    f.write(',')
    return elapsed


main()
