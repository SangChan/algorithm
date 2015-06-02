#include <stdio.h>

void print_arr(int arr[], int arr_len)
{
	for (int i = 0; i < arr_len; i++)
	{
		printf("%d ",arr[i]);
	}
	printf("\n");
}

int check_self_descriptive(int arr[],int len)
{
	int count;
	for (int i = 0; i < len; i++)
	{
		count = 0;
		for (int j = 0; j < len; j++)
		{
			if(i == arr[j])
				count++;
		}
		if (count != arr[i])
			return 0;
	}
	return 1;
}

void rperm_self_descriptive3(int arr[], int len, int n, int k)
{
	int t = 0, s = 0;
	if (len == k)
	{
		if (check_self_descriptive(arr,len))
		{
			print_arr(arr, len);
		}
		return;
	}

	for (int i = 0; i < len; i++)
	{
		if(arr[i] == len)
			t++;
		s += arr[i];
	}

	for (int i = t; i < n; i++)
	{
		arr[len] = i;
		rperm_self_descriptive3(arr, len+1, n, k);
	}
}

void rperm_self_descriptive2(int arr[], int len, int n, int k)
{
	int t = 0;
	if (len == k)
	{
		if (check_self_descriptive(arr,len))
		{
			print_arr(arr, len);
		}
		return;
	}

	for (int i = 0; i < len; i++)
	{
		if(arr[i] == len)
			t++;
	}

	for (int i = t; i < n; i++)
	{
		arr[len] = i;
		rperm_self_descriptive2(arr, len+1, n, k);
	}
}

void rperm_self_descriptive(int arr[], int len, int n, int k)
{
	if (len == k)
	{
		if (check_self_descriptive(arr,len))
		{
			print_arr(arr, len);
		}
		return;
	}

	for (int i = 0; i < n; i++)
	{
		arr[len] = i;
		rperm_self_descriptive(arr, len+1, n, k);
	}
}

#define MAXN 20

int main()
{
	int arr[MAXN], n;

	scanf("%d", &n);
	rperm_self_descriptive3(arr,0,n,n);
	return 0;

}