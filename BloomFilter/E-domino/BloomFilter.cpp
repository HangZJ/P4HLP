#define TF_HASH_TBL_SIZE 4096
#define TF_HASH_BIT_WIDTH 12

void bloomfiler(){
    reg_32 bloom_filter_1[TF_HASH_TBL_SIZE];
    reg_32 bloom_filter_2[TF_HASH_TBL_SIZE];
    reg_32 bloom_filter_3[TF_HASH_TBL_SIZE];
    tmp1 = hash(crc_16_genibus, TF_HASH_BIT_WIDTH);
    tmp2 = hash(xmodem, TF_HASH_BIT_WIDTH);
    tmp3 = hash(crc16, TF_HASH_BIT_WIDTH);
    bloom_filter_1[tmp1] = 1;
    bloom_filter_1[tmp2] = 1;
    bloom_filter_1[tmp3] = 1;
}