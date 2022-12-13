#include <math.h>
#include <mex.h>
#include <matrix.h>
#include <iostream>
void check_interval(int n, int row_B, const double *A, const double *B, double *C){
    
    for(int i = 0;i < n;i++){
        bool found = false;
        int row = 0;
//         printf("%lf %lf %lf\n", A[i], B[row], B[row + row_B]);
        while(true){
            if(A[i] >= B[row] && A[i] < B[row + row_B]){
                C[i] = row + 1;
                found = true;
                break;
            }
            row ++;
            if(row >= row_B){
                break;
            }
        }       
        if(!found){
            C[i] = 0.0;
        }
    }
}

// B(n, 1) < A <= B(n, 2)

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
    /* input argument checking */
    if (nrhs != 2 || nlhs != 1) {
    mexErrMsgTxt("(pairwise squared distances) usage: D2=getPairD2(V1,V2)");
    }
    /* inputs V1 and V2 (2-D array) */
    double *A = mxGetPr(prhs[0]); // input A
    double *B = mxGetPr(prhs[1]); // input B
    int n = mxGetNumberOfElements(prhs[0]);
    int row_A = mxGetM(prhs[0]); // rows of A
    int row_B = mxGetM(prhs[1]); // rows of B
    int col_A = mxGetN(prhs[0]); // cols of A    
    int col_B = mxGetN(prhs[1]); // cols of B
    for(int i = 0;i < row_A;i++){
        mexPrintf("%lf ", A[i]);
    }
    mexPrintf("\n");
    /* output D2 (2-D array) */
    plhs[0] = mxCreateDoubleMatrix(row_A, col_A, mxREAL);
    double *C = mxGetPr(plhs[0]);
    /* actual computation */
    check_interval(n, row_B, A, B, C);
}