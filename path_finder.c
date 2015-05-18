#include <stdio.h>

#define M 100
#define N 100

int map[M][N];
long long path[M][N];

void calculate_path(int m, int n)
{
	int i,j;

	path[0][0] = map[0][0];

	for(i = 1; i < m; i++)
	{
		if(map[i][0] == 0)
			path[i][0] = 0;
		else
			path[i][0] = path[i-1][0];
	}

	for(j = 1; j < n; j++)
	{
		if(map[0][j] == 0)
			path[0][j] = 0;
		else
			path[0][j] = path[0][j-1];
	}

	for (i = 1; i < m; i++)
	{
		for (j = 1; j < n; j++)
		{
			if(map[i][j] == 0)
				path[i][j] = 0;
			else
				path[i][j] = path[i-1][j] + path[i][j-1];
		}
	}
}

long long num_path(int m, int n)
{
	if(map[m][n] == 0)
		return 0;
	if(m==0 && n==0)
		return 1;

	return ((m>0)?num_path(m-1,n):0)+((n>0)?num_path(m,n-1):0);
}

int main()
{
	int m,n;

	scanf("%d %d", &m, &n);
	for (int i = 0; i < m; i++)
	{
		for (int j = 0; j < n; j++)
		{
			scanf("%d",&map[i][j]);
		}
	}
	calculate_path(m,n);
	printf("%lld\n",path[m-1][n-1]);
	return 0;
}