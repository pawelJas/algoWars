#include "twod_rucksack.h"
#include <stdlib.h>
#include <stdio.h>
#include <time.h>

int max_elements(int capacity_a, int capacity_b, int elements_count, int elements[elements_count][2]) {
  int matrix[capacity_a + 1][capacity_b + 1];
  int left, right;

  /* Fill matrix with zeros */
  for (size_t a = 0; a <= capacity_a; a++) {
    for (size_t b = 0; b <= capacity_b; b++) {
      matrix[a][b] = 0;
    }
  }

  for (int i = 0; i < elements_count; i++) {
    left = elements[i][0];
    right = elements[i][1];

    for (int a_cap = capacity_a; a_cap >= left; a_cap--) {
      for (int b_cap = capacity_b; b_cap >= right; b_cap--) {
        /* Note - checking equality and incrementing the count by one would not work if */
        /* each pair was also assigned a value. In that case, you would need to check */
        /* matrix[a_cap - left][b_cap - right] + value > matrix[a_cap][b_cap], and add */
        /* the value instead of incrementing by 1 */
        if (matrix[a_cap - left][b_cap - right] == matrix[a_cap][b_cap]) {
          matrix[a_cap][b_cap]++;
        }
      }
    }
  }

  return matrix[capacity_a][capacity_b];
}

void generate_random(int pairs_count, int max_size, int pairs[pairs_count][2]) {
  srand((unsigned int) time(NULL));

  for (int i = 0; i < pairs_count; i++) {
    pairs[i][0] = rand() % max_size;
    pairs[i][1] = rand() % max_size;
  }
}

void print_matrix(int capacity_a, int capacity_b, int matrix[capacity_a + 1][capacity_b + 1]) {
  printf("[\n");
  for (int a = 0; a <= capacity_a; a++) {
    printf("  [");
    for (int b = 0; b <= capacity_b; b++) {
      printf("%d", matrix[a][b]);
      if (b < capacity_b) {
        printf(", ");
      }
    }
    printf("]\n");
  }
  printf("]\n");
}

void print_pairs(int pairs_count, int pairs[pairs_count][2]) {
  printf("[\n");
  for (int i = 0; i < pairs_count; i++) {
    printf("  [%d, %d]\n", pairs[i][0], pairs[i][1]);
  }
  printf("]\n");
}

int main(void) {
  clock_t start, end;
  double cpu_time_used;
  int result;

  int pairs_count = 5000;
  int cap_a = 500;
  int cap_b = 500;
  int pairs[pairs_count][2];

  generate_random(pairs_count, 20, pairs);

  start = clock();
  result = max_elements(cap_a, cap_b, pairs_count, pairs);
  end = clock();

  cpu_time_used = ((double) (end - start)) / CLOCKS_PER_SEC;

  printf("Result with A: %d; B: %d - %d\n", cap_a, cap_b, result);
  printf("Time taken: %f", cpu_time_used);
}
