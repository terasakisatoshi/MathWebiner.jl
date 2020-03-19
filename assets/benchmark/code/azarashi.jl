# This file was generated, do not modify it. # hide
#hideall

#=
https://discourse.julialang.org/t/how-to-make-a-c-function-compiled-by-myself-available-to-ccall/7972/26
=#

C_code=raw"""
#include <stdio.h>
int main(){
    printf("Hello Pika\n");
return 0;
}
"""

exefile = tempname()

open(`gcc -Wall -O2 -march=native -xc -o $exefile -`, "w") do f
    print(f, C_code)
end

run(`$exefile`)