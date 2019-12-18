#include "mex.h"
#include <stdlib.h>
#include <math.h>

double SampEn(double *data, int m, double threshold, int N);
double distance(double *a, double *b, int n);
double sign(double x);

void mexFunction(int nlhs, mxArray *plhs[],
                 int nrhs, const mxArray *prhs[])
{
    
    double *data;
    int ncols;
    double entropy;
    double threshold;
    int vectorLength;
    
    // Check arguments
    if(nrhs!=3) {
        mexErrMsgIdAndTxt("SampleEntropy:nrhs","Three inputs required.");
    }
    if(nlhs!=1) {
        mexErrMsgIdAndTxt("SampleEntropy:nlhs","One output required.");
    }
    
    // Check individual inputs
    if( !mxIsDouble(prhs[1]) || mxIsComplex(prhs[1]) || mxGetNumberOfElements(prhs[1])!=1 ) {
        mexErrMsgIdAndTxt("SampleEntropy:notScalar","Input Vector Length must be a scalar.");
    }
    if( !mxIsDouble(prhs[2]) || mxIsComplex(prhs[2]) || mxGetNumberOfElements(prhs[2])!=1 ) {
        mexErrMsgIdAndTxt("SampleEntropy:notScalar","Input Threshold must be a scalar.");
    }
    if( !mxIsDouble(prhs[0]) || mxIsComplex(prhs[0])) {
        mexErrMsgIdAndTxt("SampleEntropy:notDouble","Input Data Matrix must be type double.");
    }
    
    if(mxGetM(prhs[0])!=1) {
        mexErrMsgIdAndTxt("SampleEntropy:notRowVector","Input must be a row vector.");
    }
    
    data = mxGetPr(prhs[0]);
    threshold = mxGetScalar(prhs[2]);
    vectorLength = mxGetScalar(prhs[1]);
    ncols = mxGetN(prhs[0]);
    
    plhs[0] = mxCreateDoubleMatrix(1,1,mxREAL);
    entropy = SampEn(data, vectorLength, threshold, ncols);
    *mxGetPr(plhs[0]) = entropy;
    return;
}

double SampEn(double *data, int m, double threshold, int N)
{
    int B = 0;
    int A = 0;
    double D = 0;
    
    int i, j;
    for (i = 0; i < N-m; i++)
    {
        for (j = i+1; j < N-m; j++)
        {
            D = distance(data+i, data+j, m);
            if (D <= threshold)
            {
                B += 1;
                D = (data[i+m]-data[j+m])*sign(data[i+m]-data[j+m]);
                if (D <= threshold) A += 1;
            }
        }
        D = distance(data+i,data+N-m,m);
        if (D <= threshold) B += 1;
    }
    
    double dimension = (double)(N-m);
    //mexPrintf("A=%d,B=%d\n",A,B);
    return -log((double)A*dimension/((dimension-2)*(double)B));
}

double sign(double x)
{
    return (x > 0) - (x < 0);
}

double distance(double *a, double *b, int n)
{
    double d = 0;
    double temp;
    int i;
    for (i = 0; i < n; i++)
    {
        temp = (a[i]-b[i])*sign((a[i]-b[i]));
        if (temp > d) d = temp;
    }
    return d;
}