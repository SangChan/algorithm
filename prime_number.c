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
	printf("1: %d\n",isPrime(1));
	printf("2: %d\n",isPrime(2));
	printf("3: %d\n",isPrime(3));
	printf("4: %d\n",isPrime(4));
	printf("5: %d\n",isPrime(5));
	printf("6: %d\n",isPrime(6));
	printf("7: %d\n",isPrime(7));
	printf("8: %d\n",isPrime(8));
	printf("9: %d\n",isPrime(9));
	printf("10: %d\n",isPrime(10));
	printf("11: %d\n",isPrime(11));
	printf("12: %d\n",isPrime(12));
	printf("13: %d\n",isPrime(13));
	printf("14: %d\n",isPrime(14));
	printf("15: %d\n",isPrime(15));
	printf("16: %d\n",isPrime(16));
	printf("17: %d\n",isPrime(17));
	printf("18: %d\n",isPrime(18));
	printf("19: %d\n",isPrime(19));
	printf("20: %d\n",isPrime(20));
	return 0;
}