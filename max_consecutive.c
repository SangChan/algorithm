#include <stdio.h>

int max(int x, int y)
{
	if(x > y)
		return x;
	return y;
}

int max_sum2(int s[], int n)
{
	if (n == 1)
	{
		return s[0];
	}
	return max(max_sum2(s,n-1)+s[n-1],s[n-1]);
}

int max_sum1(int s[], int n)
{
	if (n == 1)
	{
		return s[0]
	}
	return max(max_sum2(s,n), max_sum1(s, n-1));
}

int max_consecutive_sum(int s[], int n)
{
	int sum;
	int max_sum = s[0];


	for (int i = 0; i < n; i++)
	{
		for (int j = i; j < n; j++)
		{
			sum = 0;
			for (int k = i; k <= j; k++)
			{
				sum += s[k];
			}
			if(sum > max_sum)
				max_sum = sum;
		}
	}

	return max_sum;
}

int max_consecutive_sum2(int s[], int n)
{
	int sum;
	int max_sum = s[0];


	for (int i = 0; i < n; i++)
	{
		sum = 0;
		for (int j = i; j < n; j++)
		{
			sum += s[j];
			if(sum > max_sum)
				max_sum = sum;
		}
	}

	return max_sum;
}



int main()
{
	return 0;
}