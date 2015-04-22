#include <stdio.h>

#define QUEUE_CAPACITY 8

int queue[QUEUE_CAPACITY];
int head = 0;
int tail = -1;
int queue_size = 0;

void enqueue(int n)
{
    if (queue_size == QUEUE_CAPACITY)
    {
        printf("queue full!\n");
        return ;
    }
    tail++;
    queue_size++;
    queue[tail] = n;
}

int dequeue()
{
    int r;
    if (queue_size == 0)
    {
        printf("queue empty!\n");
        return 0;
    }

    r = queue[head];
    head++;
    queue_size--;
    
    return r;
}

int main()
{
    int number, r;
    
    do {
        printf("input number: ");
        scanf("%d", &number);
        
        if (number > 0) {
            enqueue(number);
        }
        else if (number == 0) {
            r = dequeue();
            printf("[%d]\n",r);
        }
    } while (number >= 0);
    
    return 0;
}