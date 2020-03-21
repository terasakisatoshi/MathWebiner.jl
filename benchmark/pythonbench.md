@def title = "Implement more Pythonic"
@def hasmath = true
@def hascode = true

\chapter{Pythonらしくかつハイパフォーマンスに!}

PyCall.jl から `import numba` を試みるとクラッシュする現象を確認しているので下記の実行結果は動的に出力せず，手元の iMac によるベンチマークである.

\section{numbaを使う}

```python
@numba.jit(numba.uint8(numba.complex64, numba.complex64))
def cnt(z, c):
    k = 0
    while k < 255:
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
```

```plaintext
elapsed time 0.5772097110748291
```

ipython の `%timeit` を用いると正確な値を得ることができる.

```plaintext
%timeit mand(2500,2500)
468 ms ± 1.5 ms per loop (mean ± std. dev. of 7 runs, 1 loop each)
```
