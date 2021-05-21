package main

import "math/rand"

func GenerateUnbalanced(n int) [][]int {
	elementsCount := n / 2
	pairs := make([][]int, elementsCount)
	for i := 0; i < elementsCount; i++ {
		pairs[i] = []int{n - i, i}
	}
	return pairs
}

func GenerateRandom(n, max_val int) [][]int {
	pairs := make([][]int, n)
	for i := range pairs {
		pairs[i] = []int{rand.Intn(max_val), rand.Intn(max_val)}
	}
	return pairs
}
