@def title = "PlotlyJS Example2"
@def hasmath = true
@def hascode = true
@def hasplotly = true

~~~
<div class="increment count1">
~~~

# 今日も一日

@@definition
ゴマちゃんとは
@@

```julia:plotly3d
using PlotlyJS
function random_line()
    a=0.1

    us = 0:0.05π:2π
    ts = -1:0.05:1
    traces=typeof(scatter3d())[]
    marker=attr(
        color="#1f77b4",
        size=12,
        symbol="circle",
        line=attr(color="rgb(0,0,0)", width=0),
    )
    for t in ts
        x=@. (t^2+a)*cos(us)
        y=@. (t^2+a)*sin(us)
        z=t*ones(length(x))
        push!(
            traces,
            scatter3d(
                x=x,y=y,z=z,
                mode="lines",
                marker=marker,
                showlegend=false,
            )
        )
    end

    for u in us
        x = @. (ts^2+a)*cos(u)
        y = @. (ts^2+a)*sin(u)
        z = ts
        push!(
            traces,
            scatter3d(
                x=x,y=y,z=z,
                mode="lines",
                marker=marker,
                showlegend=false
            )
        )
    end

    layout = Layout(
        autosize=true,
        width=500,
        height=500,
        margin=attr(l=0, r=0, b=150, t=0),
    )
    plot(traces,layout)
end

p = random_line()
fdplotly(json(p)) # hide
```

\textoutput{plotly3d}

$$
1+1
$$

$$
1+2
$$

@@reset@@

## Section goma

@@theorem
これは定理
@@

$$
\begin{bmatrix}
1 & 0 \\
0 & 1 \\
\end{bmatrix}
$$

@@reset@@

### SubSection kyu

@@theorem
アレも定理
@@

@@theorem
これも定理
@@

@@prop
みんなみんな命題なんだ
@@

@@reset@@

## Azarashi

@@theorem
キュ！ $x y z$
@@

@@reset@@

## ピカピカ

@@theorem
ピッピカチュウ $x y z$
@@


@@reset@@

# Oh Yes

@@prop
aa
@@

# aaa
# bbb

reference: ![alt text][ref]

[ref]: https://juliacon.org/2018/assets/img/julia-logo-dots.png
Notes:
