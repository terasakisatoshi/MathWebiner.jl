@def title = "How fast is Julia language?"
@def hasmath = true
@def hascode = true
@def hasplotly = true

\chapter{Is Julia fast ?}

- Julia は LLVM による JIT コンパイルにより高速に動作し C 言語と同等のスピードを出すことができます。ここではベンチマークとしてマンデルブロ集合の生成する計算を例にJulia がどれくらいのパフォーマンスを出すのかを調べてみましょう。まずは, 比較対象として C と Python のプログラムをだしておきましょう.

\section{C のコードを書く}

- C のコードを書いてみました. ヘッダーは `<stdio.h>` と書くべきですが, `#include <stdio.h>` とコードブロックに記述するとヘッダー名が消えてしまう現象があり、ここではそれを回避するために `"stdio.h"` と表記しています。

\Ccode{mandC}{
#include <stdio.h>
#include <stdint.h>
#include <time.h>

uint8_t cnt(double ReZ,double ImZ,double ReC,double ImC){
    uint8_t k=0;
    while(k<100){
        double new_ReZ = ReZ*ReZ - ImZ*ImZ + ReC ;
        double new_ImZ = 2*ReZ*ImZ + ImC;
        if (new_ReZ*new_ReZ+new_ImZ*new_ImZ>4){
            return k;
        }
        ReZ = new_ReZ;
        ImZ = new_ImZ;
        k+=1;
    }
    return k;
}


int main()
{
    clock_t start,end;
    start = clock();
    int N = 2500;
    uint8_t grid[N][N];
    double init_Re = 0.0;
    double init_Im = 0.0;
    for (int j = 0; j < N; j++)
    {
        for (int i = 0; i < N; i++)
        {
            double ReC = 4.0 / (N - 1) * i - 2.0;
            double ImC = 4.0 / (N - 1) * j - 2.0;
            double ReZ = init_Re;
            double ImZ = init_Im;
            grid[j][i] = cnt(ReZ,ImZ,ReC,ImC);
        }
    }
    end = clock();
    double cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;
    printf("Elapsed time %f [sec]\n", cpu_time_used);
    FILE *fp;
    fp = fopen("/tmp/resultC.txt", "w");
    for (int j = 0; j < N; j++)
    {
        for (int i = 0; i < N; i++)
        {
            fprintf(fp, "%d", grid[j][i]);
            if (i != N - 1)
            {
                fprintf(fp, ",");
            }
            else
            {
                fprintf(fp, "\n");
            }
        }
    }
    fclose(fp);
    return 0;
}
}


描画は下記のとおりです。


```julia:plotmandC
using CSV
using Plots
df=CSV.read("/tmp/resultC.txt",header=false)
img=convert(Matrix,df)
M,N = img |> size
p=heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath(@OUTPUT, "mandC.svg")) #hide
```

\fig{mandC}

\section{Python のコード}

\input{python}{mand.py}

\output{mandP}

\input{julia}{vismandP.jl}

\fig{mandP.svg}


\section{Julia のコード}

最後に Julia のコードを見ていきましょう

```julia:mandJ
function cnt(ReZ,ImZ,ReC,ImC)
	k=0
	while(k<100)
		new_ReZ = ReZ*ReZ - ImZ*ImZ + ReC
		new_ImZ = 2*ReZ*ImZ + ImC
		if new_ReZ*new_ReZ+new_ImZ*new_ImZ>4
			return k
		end
		ReZ = new_ReZ
		ImZ = new_ImZ
		k+=1
	end
	return k
end

function main()
	s=time()
	N = 2500
	M = N
	grid = Array{UInt8}(undef,M,N)
	init_Re = 0.0
	init_Im = 0.0
	for j in 1:N
		for i in 1:M
			ReC = 4. / (N - 1) * (i-1) - 2.0
			ImC = 4. / (M - 1) * (j-1) - 2.0
			ReZ = init_Re
			ImZ = init_Im
			grid[i, j] = cnt(ReZ,ImZ,ReC,ImC)
		end
    end
    t=time()
    @show(t - s)
    io = open("/tmp/resultJ.txt", "w")
    for j in 1:M
    	for i in 1:N
    		print(io, grid[i,j])
    		if i!=N
    			print(io,',')
    		else
    			println(io)
    		end
    	end
    end
    close(io)
end

main()

```

\output{mandJ}

```julia:plotmandJ
Cpath="/tmp/resultC.txt"
Jpath="/tmp/resultJ.txt"
run(`bash -c "cmp --silent $Cpath $Jpath || echo \"files are different\""`)

using CSV
using Plots
df=CSV.read(Jpath,header=false)
img=convert(Matrix,df)
M,N = img |> size
p=heatmap(1:N,1:M,img,aspect_ratio=1)
savefig(p, joinpath(@OUTPUT, "mandJ.svg")) #hide
```

\output{plotmandJ}
\fig{mandJ}
