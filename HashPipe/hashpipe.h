#define MAX_STAGE 3
#define MAX_SIZE 65536

void HashPipe(){
    reg_32 key[MAX_STAGE][MAX_SIZE];
    reg_32 val[MAX_STAGE][MAX_SIZE];
    l = hash(p.key);
    carry_key = p.key;
    carry_min = 1;
    if (key[0][l] == p.key){
        val[0][l] = val[0][l] + 1;
    }else{
        swap(carry_min, val[0][l]);
        swap(carry_key, key[0][l]);
    }
    for (i=1; i<MAX_STAGE; i++){
        l = hash(carry_key);
        if (key[i][l] == carry_key){
            val[i][l] = val[i][l] + 1;
        }else if (val[i][l] < carry_min){
            swap(carry_min, val[i][l]);
            swap(carry_key, key[i][l]);
        }
    }
}