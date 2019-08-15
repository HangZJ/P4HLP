#define NUM_FLOWLETS 65536
#define TF_HASH_BIT_WIDTH 16
#define NUM_HOPS 20
#define THRESH 10

void flowlet(){
    reg_32 saved_hop[HASH_SIZE];
    reg_32 last_time[HASH_SIZE];
    idx = hash(p.key, NUM_FLOWLETS);
    new_hop = hash(p.key, NUM_HOPS);
    if (p.ts - last_time[idx] > THRESH){
        saved_hop[idx] = new_hop;
    }
    last_time[idx] = p.ts;
    p.port = new_hop;
}