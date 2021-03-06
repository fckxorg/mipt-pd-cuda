#include <KernelMatrixAdd.cuh>

__global__ void KernelMatrixAdd(int height, int width, size_t pA, size_t pB, size_t pC, float* A, float* B, float* result) {
  int row = blockIdx.x * blockDim.x + threadIdx.x;
  int col = blockIdx.y * blockDim.y + threadIdx.y;
	int stride_row = blockDim.x * gridDim.x;
	int stride_col = blockDim.y * gridDim.y;

  for (int i = row; i < height; i += stride_row) {
    float* rowA = (float*)((char*)A + i * pA);
    float* rowB = (float*)((char*)B + i * pB);
    float* rowC = (float*)((char*)result + i * pC);

    for(int j = col; j < width; j += stride_col) {
      rowC[j] = rowA[j] + rowB[j];
    }
	}
}

