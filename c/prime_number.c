#include <stdio.h>

int isPrime(int num)
{
	if(num <= 1) return 0;
	if(num == 2) return 1;

	for (int i = 2; i <= num/2; i++)
	{
		if(num%i == 0) return 0;
	}
	return 1;
}

int main()
{
	for (int i = 0; i < 65535; i++)
	{
		if(isPrime(i) == 1)
			printf("%d is prime number\n",i);
	}
	return 0;
}