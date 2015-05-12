#include <stdio.h>

#define MAXN 200

long long fibo2(int n)
{
	static long long memo[MAXN];
	if (memo[n] > 0)
	{
		return memo[n];
	}
	if (n == 1|| n == 2)
	{
		return memo[n] = 1;
	}
	else 
	{
		return memo[n] = fibo2(n-1)+fibo2(n-2);
	}
}

long long fibo(int n)
{
	if (n == 1 || n ==2)
	{
		return 1;
	}
	else
	{
		return fibo(n-1) + fibo(n-2);
	}
}

int main()
{
	int input_n;
	printf("insert n : ");
	scanf("%d",&input_n);
	printf("%lld\n", fibo2(input_n));
	return 0;
}