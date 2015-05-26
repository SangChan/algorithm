#include <stdio.h>

#define MAXN 100

void print_arr(int arr[], int arr_len)
{
	for (int i = 0; i < arr_len; i++)
	{
		printf("%d ",arr[i]);
	}
	printf("\n");
}

void subset(int set[], int set_size, int n, int index)
{
	if (index == n)
	{
		print_arr(set, set_size);
		return ;
	}
	set[set_size] = index;
	subset(set, set_size+1, n, index+1);
	subset(set, set_size, n, index+1);
}

int main()
{
	int set[MAXN], n;
	printf("input n : ");
	scanf("%d",&n);
	subset(set,0,n,0);
	return 0;
}