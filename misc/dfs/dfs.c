#include <stddef.h>
#include <stdio.h>

typedef struct {
  int *data;
  size_t size;
  size_t capacity;
} Array;

void array_init(Array *a, size_t initial_capacity) {
  a->data = malloc(initial_capacity * sizeof(int));
  a->size = 0;
  a->capacity = initial_capacity;
}

void array_append(Array *a, int value) {
  if (a->size == a->capacity) {
    a->capacity *= 2;
    a->data = realloc(a->data, a->capacity * sizeof(int));
  }
  a->data[a->size++] = value;
}

void array_free(Array *a) {
  free(a->data);
  a->data = NULL;
  a->size = a->capacity = 0;
}

typedef struct {
  Array *adjacency_list;
  size_t size;
} Graph;

void graph_init(Graph *g, size_t initial_size) {
  g->adjacency_list = malloc(initial_size * sizeof(Array));
  g->size = initial_size;
  for (int i = 0; i < initial_size; ++i) {
    array_init(&g->adjacency_list[i], 1);
  }
}

void graph_free(Graph *g) {
  for (int i = 0; i < g->size; ++i) {
    array_free(&g->adjacency_list[i]);
  }
  free(g->adjacency_list);
  g->adjacency_list = NULL;
  g->size = 0;
}

void graph_add_edge(Graph *g, int from, int to) {
  array_append(&g->adjacency_list[from], to);
  array_append(&g->adjacency_list[to], from);
}

void dfs(Graph *g, int *visited, int node){
  visited[node] = 1;
  for (int i = 0; i < g->adjacency_list[node].size; ++i) {
    if (visited[g->adjacency_list[node].data[i]]) {
      continue;
    }
    dfs(g, visited, g->adjacency_list[node].data[i]);
  }
}

void dfs_on_tree(Graph *g, int v, int p) {
  for (int i = 0; i < g->adjacency_list[v].size; ++i) {
    // 頂点vの隣接頂点のうち、親がpでないものに対してdfsを行う
    // (= 探索済みの頂点は親pのみ)
    if (g->adjacency_list[v].data[i] == p) {
      continue;
    }
    dfs_on_tree(g, g->adjacency_list[v].data[i], v);
  }
}
