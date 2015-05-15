#include <stdio.h>

void print_gray_reverse(int code[], int n, int index);
void print_gray(int code[], int n, int index);

void print_code(int code[], int len)
{
	for(int i = 0; i < len; i++)
		printf("%d",code[i]);
	printf("\n");
}

void print_gray_reverse(int code[], int n, int index)
{
	if(index == n) {
		print_code(code, n);
		return ;
	}

	code[index] = 1;
	print_gray(code, n, index+1);
	code[index] = 0;
	print_gray_reverse(code,n,index+1);
}

void print_gray(int code[], int n, int index)
{
	if(index == n) {
		print_code(code, n);
		return ;
	}

	code[index] = 0;
	print_gray(code, n, index+1);
	code[index] = 1;
	print_gray_reverse(code,n,index+1);
}



#define MAXN 20

int main()
{
	int code[MAXN], n;
	printf("input n :");
	scanf("%d",&n);
	print_gray(code,n,0);
	return 0;
}