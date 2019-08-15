#define TF_HASH_TBL_SIZE 4096
#define TF_HASH_BIT_WIDTH 12

void bloomfiler(){
    reg_32 bloom_filter_1 val[TF_HASH_TBL_SIZE];
    reg_32 bloom_filter_2 val[TF_HASH_TBL_SIZE];
    reg_32 bloom_filter_3 val[TF_HASH_TBL_SIZE];
    ti_bloom_filter_1(crc_16_genibus, bloom_filter_1, TF_HASH_BIT_WIDTH);
    ti_bloom_filter_2(xmodem, bloom_filter_2, TF_HASH_BIT_WIDTH);
    ti_bloom_filter_3(crc16, bloom_filter_3, TF_HASH_BIT_WIDTH);
}

void forward(){
    for (i=0; i<5; i++){
        if (p.ipv4.dstAddr & 0xff00 == i){
            metadata.egress_port = i;
        }
    }
}

class MySwitch(){
    void parser(){}
    void ingress(){
        precision();
        forward();
    }
    void egress(){}
    void deparser(){}
}