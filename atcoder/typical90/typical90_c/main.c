#include <stdio.h>
#include <stdlib.h>

typedef struct {
  int *data;
  int size;
  int capacity;
} Vector;

void vector_init(Vector *vector)
{
  vector->size = 0;
  vector->capacity = 4;
  vector->data = malloc(sizeof(int) * vector->capacity);
}

void vector_append(Vector *vector, int value)
{
  if (vector->size >= vector->capacity) {
    vector->capacity *= 2;
    vector->data = realloc(vector->data, sizeof(int) * vector->capacity);
  }
  vector->data[vector->size++] = value;
}

void vector_free(Vector *vector)
{
  free(vector->data);
}

typedef struct {
  Vector *adj;
  int size;
} Graph;

void graph_init(Graph *g, int n)
{
  g->size = n;
  g->adj = malloc(sizeof(Vector) * n);
  for (int i = 0; i < n; i++) {
    vector_init(&g->adj[i]);
  }
}

void graph_free(Graph *g)
{
  for (int i = 0; i < g->size; i++) {
    vector_free(&g->adj[i]);
  }
  free(g->adj);
}

void graph_add_edge(Graph *g, int u, int v)
{
  vector_append(&g->adj[u], v);
  vector_append(&g->adj[v], u);
}

void calc_lengths(Graph *g, int* visited, int node, int* lengths)
{
  visited[node] = 1;

  for (int i = 0; i < g->adj[node].size; i++) {
    int next = g->adj[node].data[i];

    if (visited[next]) continue;
    lengths[next] = lengths[node] + 1;
    calc_lengths(g, visited, next, lengths);
  }
}


int main(int argc, char *argv[])
{
  int n; scanf("%d", &n);
  Graph g; graph_init(&g, n);

  for (int i = 0; i < n - 1; i++) {
    int u, v; scanf("%d %d", &u, &v);
    graph_add_edge(&g, u - 1, v - 1);
  }

  int lengths[n];
  int visited[n];
  for (int i = 0; i < n; i++) {
    lengths[i] = 0;
    visited[i] = 0;
  }

  calc_lengths(&g, visited, 0, lengths);

  int max = 0;
  int max_index = 0;
  for (int i = 0; i < n; i++) {
    if (lengths[i] > max) {
      max = lengths[i];
      max_index = i;
    }
  }

  for (int i = 0; i < n; i++) {
    lengths[i] = 0;
    visited[i] = 0;
  }

  calc_lengths(&g, visited, max_index, lengths);

  max = 0;
  for (int i = 0; i < n; i++) {
    if (lengths[i] > max) {
      max = lengths[i];
    }
  }

  printf("%d\n", max + 1);
}
