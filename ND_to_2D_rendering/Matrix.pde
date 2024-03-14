
float[][] matrixMult(float[][] matrix1, float[][] matrix2){
    int l1 = matrix1.length;
    int c1 = matrix1[0].length;
    int l2 = matrix2.length;
    int c2 = matrix2[0].length;
    if (c1==l2){
        float[][] fmatrix = new float[l1][c2];
        for (int i=0; i<l1; i++)
            for (int j=0; j<c2; j++){
                fmatrix[i][j]=0;
                for (int k=0; k<c1; k++)
                    fmatrix[i][j]+=matrix1[i][k]*matrix2[k][j];
            }
        return fmatrix;
    }else{
        println("matrices of size " + l1 + 'x' + c1 + " and " + l2 + 'x' + c2 + " cannot be multiplied");
        return matrix2;
    }
}

float[][] matrixMult(float[][] matrix1, PVector v){
    float[][] matrix2 = new float[3][1];
    matrix2[0][0] = v.x;
    matrix2[1][0] = v.y;
    matrix2[2][0] = v.z;
    return matrixMult(matrix1, matrix2);
}

float[][] matrixMult(float[][] matrix1, float[] arr){
    float[][] matrix2 = new float[3][1];
    for (int i=0; i<arr.length; i++)
        matrix2[i][0] = arr[i];
    return matrixMult(matrix1, matrix2);
}

float[][] rotate(float[][] matrix, int d1, float a){
    int D = matrix.length;
    float[][] rotm = new float[D][D];
    d1%=D; int d2=(d1+1)%D;
    for (int i=0; i<D; i++)
        for (int j=0; j<D; j++){
            if (i==d1 && j==d1)
                rotm[i][j]=cos(a);
            else if (i==d1 && j==d2)
                rotm[i][j]=-sin(a); 
            else if (i==d2 && j==d1)
                rotm[i][j]=sin(a); 
            else if (i==d2 && j==d2)
                rotm[i][j]=cos(a); 
            else if (i==j)
                rotm[i][j]=1;
            else 
                rotm[i][j]=0;
        }
    return matrixMult(rotm, matrix);
}

float[][] project(float[][] matrix, float dist, String mode){
    //float[][] projm = new float[matrix.length-1][matrix.length];
    //for (int i=0; i<projm.length; i++)
    //    for (int j=0; j<projm[0].length; j++)
    //        if (i==j)
    //            projm[i][j]=size.state/(dist-matrix[matrix.length-1][i]);
    //        else
    //            projm[i][j]=0;
    //return matrixMult(projm, matrix); //<>//
    float[][] projm = new float[matrix.length-1][matrix[0].length];
    for (int i=0; i<matrix[0].length; i++)
        for(int j=0; j<projm.length; j++)
            switch (mode){
                case "perspective":
                    {projm[j][i]=matrix[j][i]/(dist-matrix[matrix.length-1][i])*size.state; break;}
                case "stereographic":
                    {projm[j][i]=matrix[j][i]*size.state/100/4; break;}
            }
    return projm;
}

int X=1, Y=2, Z=3, W=4;

float dist(float[][] matrix, int c1, int c2){
    float dsq=0;
    for (int i=0; i<matrix.length; i++)
        dsq+=(matrix[i][c2]-matrix[i][c1])*(matrix[i][c2]-matrix[i][c1]);
    return sqrt(dsq);
}
float dist(float[][] m1, float[][] m2){
    float dsq=0;
    for (int i=0; i<m1.length; i++)
        dsq+=(m2[i][0]-m1[i][0])*(m2[i][0]-m1[i][0]);
    return sqrt(dsq);
}
