#include <stdio.h>

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
	printf("%lld\n", fibo(input_n));
	return 0;
}