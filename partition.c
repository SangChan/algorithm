#include <stdio.h>

#define MAXN 200

int partition_memo(int n, int m)
{
	static int memo[MAXN][MAXN];
	int count = 0;
	if (n < m)
		m = n;
	if (memo[n][m] > 0)
		return memo[n][m];
	if (n == 0)
		return memo[n][m] = 1;

	for (int i = 1; i <= m; i++)
	{
		count += partition_memo(n-i,i);
	}
	return memo[n][m] = count;
}

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

int main()
{
	int num[MAXN],n,m;

	printf("input n, m: ");
	scanf("%d %d",&n, &m);
	printf("total : %d\n", partition_memo(n,m));
	return 0;
}