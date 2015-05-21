#include <stdio.h>

#define N 100

int max(int x, int y)
{
	if(x > y)
		return x;
	return y;
}

int c[N];

void calculate_max_consecutive_sum(int s[],int n)
{
	c[0] = s[0];
	for (int i = 0; i < n; i++)
	{
		c[i] = max(s[i],s[i]+c[i-1]);
	}
}

int find_max_consecutive_sum2(int s[], int n)
{
	int max_sum = 0;

	for(int i = 0; i < n; i++)
	{
		if (c[i] > max_sum)
		{
			max_sum = c[i];
		}
		return max_sum;
	}
}

int find_max_consecutive_sum(int s[], int n)
{
	if (n == 1)
	{
		return s[0];
	}
	return max(c[n-1], find_max_consecutive_sum(s,n-1));
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