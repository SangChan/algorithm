#include <stdio.h>

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
	int n,m;

	printf("input n, m: ");
	scanf("%d %d",&n, &m);
	printf("total : %d\n", partition(n,m));
	return 0;
}