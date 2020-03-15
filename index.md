@def title = "ようこそ"
@def hasmath = true
@def hascode = true


\chapter{このページは}

Franklin.jl を使った Web page のサンプルです．

Web 生成に使われたコードは全て [こちら](https://github.com/terasakisatoshi/MathWebiner.jl) にて管理さてれています．

\section{導入}

\definition{(Franklin.jl について)}{
[Franklin.jl](https://github.com/tlienart/Franklin.jl) は Julia で記述された
静的サイトの生成を行うパッケージである．コーディング，数学などの技術ブログの作成をサポートする．
公式ドキュメントは https://franklinjl.org/ を参照せよ. なお，公式ドキュメントも Franklin.jl で作成されており, https://github.com/tlienart/franklindocs にてソースが公開されている.
}

\prop{(特徴)}{
Franklin.jl では次の機能を持っている
- マークダウンで記述することができる.
- 数式のレンダリングは KaTeX を用いている. `$` マークで挟むことで数式を表現できる.
- 記述した Julia のコードを記述し, 対応する出力を自動で表示することができる.
- グラフ描画結果を表示することができ, 数学の概念を可視化することができる.
- HTML, CSS, JavaScript の知識があれば，ページの表示を変更することができる．
}

\example{(事後分布の定義)}{
真の分布 $q(x)$ に従う $n$ 個の確率変数の組 $X^n = (X_1,\dots,X_n)$, パラメータ $w \in W \subset \R^d$ を持つ確率モデル $p(x|w)$, パラメータの事前分布 $\varphi(w)$ から定まる逆温度 $\beta$ 付きの $w$ の事後分布 $p(w|X^n)$ を次で定義する:
$$
p(w|X^n) = \frac{\displaystyle\prod_{i=1}^n p(X_i|w)^\beta \varphi(w)}{Z_n(\beta)}.
$$

ここで $Z_n(\beta)$ は $p(w|X^n)$ の事後分布の正規化定数であり具体的には下記のように定義する:

$$
Z_n(\beta) = \int_W \prod_{i=1}^n p(X_i|w)^\beta \varphi(w) dw .
$$

}

\lemma{}{
次のようにJuliaのコードを記述することができる:
}

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

\chapter{`newcommand` によるタイピングの簡略化}

`config.md` は文章を記述する上での設定を記述するために用いる.
$\LaTeX$ の `\newcommand` と同様に数式を記述するコマンドを簡略化できる.

\example{($\mathbb{R}$ の例)}{
`config.md` に次を追加しておく:
    ```
    \newcommand{\R}{\mathbb R}
    ```
これで `\R` で $\R$ を表記できる.
}




\chapter{グラフの描画}

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

\chapter{Python のコードの実行結果の表示}

`config.md` のコマンドを定義しておく.

`````plaintext
\newcommand{\pycode}[2]{
```julia:!#1
#hideall
using PyCall
lines = replace("""!#2""", r"(^|\n)([^\n]+)\n?$" => s"\1res = \2")
py"""
$$lines
"""
println(py"res")
```
```python
#2
```
\codeoutput{!#1}
}
`````

そして該当する Markdown ファイルに例えば下記のように `\pycode` コマンドと組み合わせたものを記述しておく.

\prop{(ソースコードの表示)}{Pythonのコードの実行結果を貼り付けることができる.}


`````
\pycode{py1}{
import numpy as np
np.random.seed(2)
x = np.random.randn(5)
r = np.linalg.norm(x) / len(x)
np.round(r, 2)
}
`````

と記述することで下記のようになる:

\pycode{py1}{
import numpy as np
np.random.seed(2)
x = np.random.randn(5)
r = np.linalg.norm(x) / len(x)
np.round(r, 2)
}
