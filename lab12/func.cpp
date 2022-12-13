#include <math.h>
#include <mex.h>
#include <matrix.h>

void get_pair_d2(int L, int N1, int N2, const double *V1, const double *V2, double *D2)
{
int i, j, ki, qi, qj, k, iL;
double dv;
for (i = 0; i < N2; i++) {
    ki = i * N1;
    qi = i * L;
    for (j = 0; j < N1; j++) {
        qj = j * L;
        k = ki + j; // linear index in D2
        D2[k] = 0;
        for (iL = 0; iL < L; iL++) {
        dv = V2[qi+iL] - V1[qj+iL];
        D2[k] += dv * dv;
        }
        D2[k] = sqrt(D2[k]);
    }
}
}
void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
/* input argument checking */
if (nrhs != 2 || nlhs != 1) {
mexErrMsgTxt("(pairwise squared distances) usage: D2=getPairD2(V1,V2)");
}
if (mxGetN(prhs[2]) != 2) {
mexErrMsgTxt("V2 should have two cols");
}
/* inputs V1 and V2 (2-D array) */
double *V1 = mxGetPr(prhs[0]);
double *V2 = mxGetPr(prhs[1]);
int L = mxGetM(prhs[0]); // dimension of the points
int N1 = mxGetN(prhs[0]); // # points in V1
int N2 = mxGetN(prhs[1]); // # points in V2
/* output D2 (2-D array) */
plhs[0] = mxCreateDoubleMatrix(N1, N2, mxREAL);
double *D2 = mxGetPr(plhs[0]);
/* actual computation */
get_pair_d2(L, N1, N2, V1, V2, D2);
}