#define K 32
#define R 2
#define C 256

void sketchlearn(){
    reg_32 val[R][C][k+1];
    for (i=0; i<R; i++){
        l = hash(p.key);
        val[i][l][0] = val[i][l][0] + 1;
        for (k=1; k<=K; k++){
            if ((p.key >> (K-k)) & 0x1 == 1){
                val[i][l][k] = val[i][l][K] + 1;
            }
        }
    }
}