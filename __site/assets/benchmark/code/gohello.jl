# This file was generated, do not modify it. # hide
C_code = raw"""
#include<stdio.h>
int main(){
    printf("Hello Kyu\n");
    return 0;
}
"""

exefile = tempname()
open(`gcc -Wall -O3 -march=native -xc -o $exefile -`, "w") do f
    print(f, C_code)
end

run(`$exefile`)