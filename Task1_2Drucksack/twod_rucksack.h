#ifndef TWOD_RUCKSACK_H
#define TWOD_RUCKSACK_H

int max_elements(int capacity_a, int capacity_b, int elements_count, int elements[elements_count][2]);
void print_matrix(int capacity_a, int capacity_b, int matrix[capacity_a + 1][capacity_b + 1]);
void generate_random(int pairs_count, int max_size, int pairs[pairs_count][2]);
void print_pairs(int pairs_count, int pairs[pairs_count][2]);

#endif /* TWOD_RUCKSACK_H */
