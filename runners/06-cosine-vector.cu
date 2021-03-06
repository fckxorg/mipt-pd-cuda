#include <CosineVector.cuh>
#include <stdio.h>
#include <assert.h>

int main() {
  const int vec_size = 1 << 20;
  float *vec1 = new float[vec_size]();
  float *vec2 = new float[vec_size]();

  vec1[0] = 1.0f;
  vec2[0] = 1.0f;
  vec2[1] = 1.0f;

  cudaEvent_t start;
  cudaEvent_t stop;

  cudaEventCreate(&start);
  cudaEventCreate(&stop);

  cudaEventRecord(start);
  float result = CosineVector(vec_size, vec1, vec2);
  cudaEventRecord(stop);
  cudaEventSynchronize(stop);

  float millis = 0;
  cudaEventElapsedTime(&millis, start, stop);
  printf("Elpased: %f\n", millis);
  printf("%f\n", result);
  fflush(stdout);
  assert(result - 0.707f < 0.001f);

  delete[] vec1;
  delete[] vec2;
  return 0;
}

