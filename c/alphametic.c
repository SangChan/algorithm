#include <stdio.h>

void print_arr(int arr[], int arr_len)
{
	for (int i = 0; i < arr_len; i++)
	{
		printf("%d ",arr[i]);
	}
	printf("\n");
}

void swap_arr(int arr[], int i, int j)
{
	int temp;

	temp = arr[i];
	arr[i] = arr[j];
	arr[j] = temp;
}

int check_alphametic(int x[])
{
	if (x[2] == 0)
	{
		return 0;
	}
	if (x[6] == 0)
	{
		return 0;
	}

	if (1000 * x[6] + 100 * x[1] + 10 * x[3] + x[0] + 1000 * x[2] + 100 * x[4]+ 10 * x[5] + x[1] == 10000 * x[2] + 1000 * x[4] + 100 * x[3] + 10 * x[1] + x[7])
	{
		return 1;
	}

	return 0;
}

void perm_alphametic(int arr[], int len, int n, int k)
{
	if (len == k)
	{
		if(check_alphametic(arr) == 1)
			print_arr(arr, len);
		return;
	}

	for (int i = len; i < n ; i++)
	{
		swap_arr(arr, i, len);
		perm_alphametic(arr, len+1, n, k);
		swap_arr(arr, i, len);
	}
}

#define MAXN 10

int main()
{
	int arr[MAXN], n, k;

	n = 10;
	k = 8;
	for (int i = 0; i < n; i++)
	{
		arr[i]=i;
	}
	perm_alphametic(arr, 0, n, k);
	return 0;
}