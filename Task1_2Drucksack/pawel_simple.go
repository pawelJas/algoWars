package main

import (
	"fmt"
	"time"
)

func main() {
	runSmall()
	n := 500
	fmt.Println("Random test, n=", n, solve(n, n, GenerateRandom(n, n)))
	fmt.Println("Unbalanced test, n=", n, solve(n, n, GenerateUnbalanced(n)))
	n = 1000
	fmt.Println("Random test, n=", n, solve(n, n, GenerateRandom(n, n)))
	fmt.Println("Unbalanced test, n=", n, solve(n, n, GenerateUnbalanced(n)))
	n = 2000
	fmt.Println("Random test, n=", n, solve(n, n, GenerateRandom(n, n)))
	fmt.Println("Unbalanced test, n=", n, solve(n, n, GenerateUnbalanced(n)))
}

func runSmall() {
	input1 := [][]int{{0, 1}, {2, 1}, {1, 1}, {1, 3}}
	input2 := [][]int{{1, 1}, {2, 1}, {1, 1}, {1, 2}}
	input3 := [][]int{{3, 1}, {3, 1}, {3, 1}, {3, 2}}
	input4 := [][]int{{0, 1}, {0, 1}, {0, 1}, {0, 2}}
	fmt.Println("expected 3, received", solve(5, 5, input1))
	fmt.Println("expected 4, received", solve(5, 5, input2))
	fmt.Println("expected 0, received", solve(2, 5, input3))
	fmt.Println("expected 3, received", solve(12, 3, input3))
	fmt.Println("expected 4, received", solve(2, 5, input4))
	n := 5
	fmt.Println("Random test, n=", n, solve(n, n, GenerateRandom(n, n)))
	fmt.Println("Unbalanced test, n=", n, solve(n, n, GenerateUnbalanced(n)))
}

func checkTime(start time.Time) {
	fmt.Println(time.Since(start))
}

func solve(a int, b int, pairs [][]int) int {
	defer checkTime(time.Now())
	bests := make([][]int, a+1)
	for i := range bests {
		bests[i] = make([]int, b+1)
	}

	for _, ele := range pairs {
		ai := ele[0]
		bi := ele[1]
		for i := a; i >= ai; i-- {
			for j := b; j >= bi; j-- {
				if bests[i][j] < bests[i-ai][j-bi]+1 {
					bests[i][j] = bests[i-ai][j-bi] + 1
				}
			}
		}
	}
	return bests[a][b]
}
