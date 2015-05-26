#include <stdio.h>

#define MAXN 100

int weight[MAXN], value[MAXN], capacity;
int max_set[MAXN];
int max_set_size = 0;
int max_value = 0;

void print_arr(int arr[], int arr_len)
{
	for (int i = 0; i < arr_len; i++)
	{
		printf("%d ",arr[i]);
	}
	printf("\n");
}

void evaluate_knapsack(int set[], int set_size)
{
	int current_volume = 0;
	int current_value = 0;
	for (int i = 0; i < set_size; i++)
	{
		current_volume += weight[set[i]];
		current_value += value[set[i]];
	}

	if (current_volume > capacity)
	{
		return ;
	}

	if (current_value > max_value)
	{
		max_value = current_value;
		max_set_size = set_size;
		for (int i = 0; i < set_size; i++)
		{
			max_set[i] = set[i];
		}
	}
}

void subset_knapsack(int set[], int set_size, int n, int index)
{
	if (index == n)
	{
		evaluate_knapsack(set, set_size);
		return ;
	}
	set[set_size] = index;
	subset_knapsack(set, set_size+1, n, index+1);
	subset_knapsack(set, set_size, n, index+1);
}

int main()
{
	int set[MAXN], n, i;

	scanf("%d %d", &n, &capacity);

	
	for (i = 0; i < n; i++)
	{
		scanf("%d", &value[i]);
	}

	for (i = 0; i < n; i++)
	{
		scanf("%d", &weight[i]);
	}
	subset_knapsack(set,0,n,0);

	printf("Max value: %d\n", max_value);
	print_arr(max_set,max_set_size);
	return 0;
}