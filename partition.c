#include <stdio.h>

void print_arr(int arr[], int arr_len)
{
	for (int i = 0; i < arr_len; ++i)
		printf("%d",arr[i]);
	printf("\n");
}

int partition_print(int n, int m, int arr[], int arr_len)
{
	int count = 0;
	int i;

	if(n<m)
		m = n;
	if(n == 0) 
	{
		print_arr(arr, arr_len);
		return 1;
	}

	for (i = 1; i <= m; i++)
	{
		arr[arr_len] = i;
		count += partition_print(n-i , i, arr, arr_len + 1);
	}
	return count;
}

int partition(int n, int m)
{
	int count = 0;
	int i;

	if(n<m)
		m = n;
	if(n == 0)
		return 1;

	for (i = 1; i <= m; i++)
		count += partition(n-i , i);
	return count;
}

#define MAXN 50

int main()
{
	int num[MAXN],n,m;

	printf("input n, m: ");
	scanf("%d %d",&n, &m);
	printf("total : %d\n", partition_print(n,m,num,0));
	return 0;
}