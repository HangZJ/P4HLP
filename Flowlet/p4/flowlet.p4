#include <tofino/stateful_alu_blackbox.p4>
#include <tofino/intrinsic_metadata.p4>
#include <tofino/constants.p4>

#include "headers.p4"
#include "parser.p4"

#define NUM_FLOWLETS 65536
#define TF_HASH_BIT_WIDTH 16
#define NUM_HOPS 20
#define THRESH 10

field_list hash_fields { // ip 3 tuple
    ipv4.srcAddr;
    ipv4.dstAddr;
    ipv4.protocol;
}
field_list_calculation hash { // hash function
    input { 
        hash_fields;
    }
    algorithm : crc16;
    output_width : TF_HASH_BIT_WIDTH;
}
action action_get_hash_val_0() {
    modify_field_with_hash_based_offset(Meta.idx, 0, hash, NUM_FLOWLETS);
}
table table_hash_0 {
	actions {
        action_get_hash_val_0;
    }
}

action action_get_hash_val_1() {
    modify_field_with_hash_based_offset(Meta.new_hop, 0, hash, NUM_HOPS);
}
table table_hash_1 {
	actions {
        action_get_hash_val_1;
    }
}

register last_time {
    width : TF_HASH_BIT_WIDTH;
    instance_count : NUM_FLOWLETS;
}
blackbox stateful_alu last_time_alu {
    reg: last_time;
    update_lo_1_value: ig_intr_md.ingress_mac_tstamp;
}
action action_last_time () {
    last_time_alu.execute_stateful_alu(Meta.idx);
}
table table_last_time {
    actions {
        action_last_time;
    }
    default_action: action_last_time;
}

register saved_hop {
    width : TF_HASH_BIT_WIDTH;
    instance_count : NUM_HOPS;
}
blackbox stateful_alu saved_hop_alu {
    reg: saved_hop;
    condition_lo : ig_intr_md.ingress_mac_tstamp - register_lo > THRESH
    update_lo_1_value: Meta.new_hop;
}
action action_saved_hop () {
    saved_hop_alu.execute_stateful_alu(Meta.idx);
}
table table_saved_hop {
    actions {
        action_saved_hop;
    }
    default_action: action_saved_hop;
}

action hop_act() {
    modify_field(ig_intr_md_for_tm.ucast_egress_port, Meta.new_hop);
}
table hop{
    actions{
        hop_act;
    }
    default_action : hop_act();
}

control ingress {
    apply(table_hash_0);
    apply(table_hash_1);
    apply(table_last_time);
    apply(table_saved_hop);
    apply(hop);
}


control egress {

}
