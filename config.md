<!-----------------------------------------------------
Add here global page variables to use throughout your
website.
The website_* must be defined for the RSS to work
------------------------------------------------------->
@def website_title = "MathSorcerer's daily life"
@def website_descr = "MathSorcerer's blog"
@def website_url   = "https://terasakisatoshi.github.io/MathWebiner.jl"
@def hasplotly = false
@def author = "SatoshiTerasaki"
@def prepath = "MathWebiner.jl"
<!-----------------------------------------------------
Add here global latex commands to use throughout your
pages. It can be math commands but does not need to be.
For instance:
* \newcommand{\phrase}{This is a long phrase to copy.}
------------------------------------------------------->
\newcommand{\R}{\mathbb R}
\newcommand{\Q}{\mathbb Q}
\newcommand{\scal}[1]{\langle #1 \rangle}


<!-- Put a box around something and pass some css styling to the box
(useful for images for instance) e.g. :
\style{width:80%;}{![](path/to/img.png)} -->
\newcommand{\style}[2]{~~~<div style="!#1;margin-left:auto;margin-right:auto;">~~~!#2~~~</div>~~~}

\newcommand{\definition}[2]{
@@definition (!#1) \
#2
@@
}

\newcommand{\prop}[2]{
@@prop (!#1) \
#2
@@
}

\newcommand{\lemma}[2]{
@@lemma (!#1) \
#2
@@
}

\newcommand{\theorem}[2]{
@@theorem (!#1) \
#2
@@
}

\newcommand{\proof}[1]{
@@proof \\
#1
@@
\\
}

\newcommand{\example}[2]{
@@example (!#1) \
#2
@@
}

\newcommand{\remark}[2]{
@@remark (!#1) \
#2
@@
}

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

