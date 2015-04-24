#include <stdio.h>
#include <stdlib.h>

typedef struct _node {
    int key;
    struct _node *next;
}node_t;

node_t *head = NULL;
node_t *tail = NULL;

void insert_node(int n)
{
    node_t *new_node = (node_t *) malloc(sizeof(node_t));
    new_node->key = n;
    new_node->next = NULL;
    if (head == NULL)
    {
        head = new_node;
        tail = new_node;
    } 
    else 
    {
        tail->next = new_node;
        tail = new_node;
    }
}

int delete_node()
{
    node_t *node;
    int r;
    if (head == NULL) return -1;

    node = head;
    head = head->next;
    if (head == NULL)
    {
        tail = NULL;
    }

    r = node->key;
    free(node);
    return r;
}

void print_list(node_t *from)
{
    node_t *node = from;
    while(node != NULL) {
        printf("%d ", node->key);
        node = node->next;
    }
}

void print_list_recursive(node_t *from)
{
    if (from == NULL)
    {
        return ;
    }
    printf("%d ", from->key);
    print_list_recursive(from->next);
}

void print_list_recursive_reverse(node_t *from)
{
    if (from == NULL)
    {
        return ;
    }
    print_list_recursive_reverse(from->next);
    printf("%d ", from->key);
}

int main()
{
    int number, r;
    
    do {
        printf("input number: ");
        scanf("%d", &number);
        
        if (number > 0) {
            insert_node(number);
        }
        else if (number == 0) {
            r = delete_node();
            printf("[%d]\n",r);
        }
    } while (number >= 0);

    printf(">>iterator\n");
    print_list(head);
    printf("\n>>recursive\n");
    print_list_recursive(head);
    printf("\n>>reverse recursive\n");
    print_list_recursive_reverse(head);
    printf("\n>>the end\n");
    
    return 0;
}