#include <stdio.h>

int factorial(int n) 
{
	int r = 1;

	for (int i = 1; i <= n; ++i)
	{
		r *= i;
	}

	return r;
}

int main() 
{
	printf("1!= %d\n", factorial(1));
	printf("2!= %d\n", factorial(2));
	printf("3!= %d\n", factorial(3));
	printf("4!= %d\n", factorial(4));
	printf("5!= %d\n", factorial(5));
	printf("6!= %d\n", factorial(6));
	return 0;
}