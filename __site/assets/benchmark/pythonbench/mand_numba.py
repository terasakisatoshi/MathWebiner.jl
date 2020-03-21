import time

import numba
import numpy as np


@numba.jit(numba.uint8(numba.complex64, numba.complex64))
def cnt(z, c):
    k = 0
    while k < 100:
        z = z * z + c
        if z.real**2 + z.imag**2 > 4:
            break
        k += 1
    return k


@numba.jit
def mand(M, N):
    init_z = complex(0.0, 0.0)
    grid = np.empty((M, N), dtype=np.uint8)
    xs = np.linspace(-2, 2, N)
    ys = np.linspace(-2, 2, M)
    for j, y in enumerate(ys):
        for i, x in enumerate(xs):
            grid[j, i] = cnt(init_z, complex(x, y))
    return grid


def main():
    s = time.time()
    M = N = 2500
    grid = mand(M, N)
    e = time.time()
    elapsed = f"elapsed time {e-s}"
    np.savetxt("result.txt", grid, fmt="%d", delimiter=',')
    return elapsed


print(main())
