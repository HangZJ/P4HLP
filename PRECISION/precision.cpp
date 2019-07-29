#define MAX_STAGE 4
#define MAX_SIZE 65536

void precision(){
    reg_32 key[MAX_STAGE][MAX_SIZE];
    reg_32 val[MAX_STAGE][MAX_SIZE];
    matched = false;
    carry_min = 0x7fffffff;
    min_stage = -1;
    //for normal packets, find the minimum bucket
    if (p.resubmit == 0){ 
        for (i=0; i<MAX_STAGE; i++){
            l = hash(p.key);
            if (key[i][l] == p.key){
                matched = true;
                val[i][l] = val[i][l] + 1;
            }else if (val[i][l] < carry_min){
                carry_min = val[i][l];
                min_stage = i;}
        }
        if (!matched){ //decide replace or not
            new_val = roof(carry_min);
            R = random(0, new_val);
            if (R == 0) {resubmit(new_val, min_stage);}
        }
    }else{ //for cloned packets, update key and value
        l = hash(p.key);
        key[min_stage][l] = p.key;
        val[min_stage][l] = new_val;
        drop();
    }
}

void forward(){
    for (i=0; i<5; i++){
        if (p.ipv4.dstAddr & 0xff00 == i){
            metadata.egress_port = i;
        }
    }
}

void count(){
    reg_32 rx[MAX_SIZE];
    reg_32 tx[MAX_SIZE];
    rx[metadata.ingress_port] += 
        rx[metadata.ingress_port] + 1;
    tx[metadata.egress_port] = 
        tx[metadata.egress_portt] + 1;
}

class MySwitch(){
    void parser(){}
    void ingress(){
        precision();
        forward();
        count();
    }
    void egress(){}
    void deparser(){}
}