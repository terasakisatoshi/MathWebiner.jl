@def title = "ようこそ"
@def hasmath = true
@def hascode = true
@def hasplotly = true


# このページは

Franklin.jl を使ったWeb page のサンプルです．

## 導入

@@definition (Franklin.jl) \
[Franklin.jl](https://github.com/tlienart/Franklin.jl) は Julia で記述された
静的サイトの生成を行うパッケージである．コーディング，数学などの技術ブログの作成をサポートする．
公式ドキュメントは https://franklinjl.org/ を参照せよ.
@@

\prop{特徴}{
Franklin.jl では次の機能を持っている
- マークダウンで記述することができる.
- 数式のレンダリングは KaTeX を用いている. `$` マークで挟むことで数式を表現できる.
}

@@example
真の分布 $q$ に従う $n$ 個の確率変数の組 $X^n = (X_1,\dots,X_n)$, パラメータ $w$ を持つ確率モデル $p(x|w)$, パラメータの事前分布 $\varphi(w)$ から定まる逆温度 $\beta$ 付きの $w$ の事後分布 $p(w|X^n)$ を次で定義する:
$$
p(w|X^n) = \frac{\displaystyle\prod_{i=1}^n p(X_i|w)^\beta \varphi(w)}{Z_n(\beta)},
$$
$$
Z_n(\beta) = \int \prod_{i=1}^n p(X_i|w)^\beta \varphi(w) dw
$$
@@

@@lemma
次のようにJuliaのコードを記述することができる:
@@

\proof{
```julia:simplecode
x = 3.141592
y = sin(x)
@show y
```
このとき, `y` の値は評価され次の出力を得ることができる:
\output{simplecode}
}

\remark{通し番号について}{
    通し番号は Franklin ではデフォルトでサポートしていない. CSS でカウンタを定義しておく必要がある．
}

# グラフの描画

`PyPlot`, `gr,pyplot` をバックエンドとする `Plots.jl`, `PlotlyJS.jl` を用いた場合で確認している.

```julia:pyplot1
using PyPlot
figure(figsize=(8, 6))
x = range(-2, 2, length=500)
for α in 1:5
    plot(x, sinc.(α .* x))
end
savefig(joinpath(@OUTPUT, "sinc.svg")) # hide
```

\fig{sinc}

```julia:grplot
using Plots
Plots.plot([1,2,3])
Plots.savefig(joinpath(@OUTPUT, "grplot.svg")) # hide
```

\fig{grplot}

```julia:pyplot
pyplot()
Plots.plot(sin)
Plots.savefig(joinpath(@OUTPUT, "pyplotbkend.svg")) # hide
```

\fig{pyplotbkend}

`PlotlyJS` による例はサイドメニューのページを参照
