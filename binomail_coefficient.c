#include <stdio.h>

long long choose(int n, int r)
{
	if (r == 0 || n == r)
	{
		return 1;
	}
	return choose(n-1,r-1) + choose(n-1,r);
}

int main()
{
	int n,r;

	printf("input n, r: ");
	scanf("%d %d",&n, &r);
	printf("%lld\n", choose(n,r));
}