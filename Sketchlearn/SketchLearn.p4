/**
 *
 * Simple switch with Sketchlearn
 * 
 */
#include <tofino/stateful_alu_blackbox.p4>
#include <tofino/intrinsic_metadata.p4>
#include <tofino/constants.p4>

#include "headers.p4"
#include "parser.p4"
/**
 *
 *  Sketchlearn data plane.
 * 
 */

// Max number of flows to track at once.
#define TF_HASH_TBL_SIZE 8192
#define TF_HASH_BIT_WIDTH 16

/*=====================================================
=            next hop table, forward packets           =
======================================================*/
action hop_act(egress_port) {
    modify_field(ig_intr_md_for_tm.ucast_egress_port, egress_port);
}
table hop{
    reads{
        ethernet.dstAddr: exact;
    }
    actions{
        hop_act;
    }
    default_action : hop_act(148);
}

field_list hash_fields { // ip 3 tuple
    ipv4.srcAddr;
    ipv4.dstAddr;
    ipv4.protocol;
}
field_list_calculation sketch_hash { // hash function
    input { 
        hash_fields;
    }
    algorithm : crc16;
    output_width : TF_HASH_BIT_WIDTH;
}
// count min sketch hash
action action_get_hash_val() {
    modify_field_with_hash_based_offset(Meta.hash_index, 0, sketch_hash, TF_HASH_TBL_SIZE);
}
table table_count_min_sketch_hash {
	actions {
        action_get_hash_val;
    }
}


register sketch_register0 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_0_alu {
    reg: sketch_register0;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr0 () {
    reg_0_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr0 {
    actions {
        action_count_min_sketch_incr0;
    }
    default_action: action_count_min_sketch_incr0;
}

register sketch_register1 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_1_alu {
    reg: sketch_register1;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr1 () {
    reg_1_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr1 {
    actions {
        action_count_min_sketch_incr1;
    }
    default_action: action_count_min_sketch_incr1;
}

register sketch_register2 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_2_alu {
    reg: sketch_register2;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr2 () {
    reg_2_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr2 {
    actions {
        action_count_min_sketch_incr2;
    }
    default_action: action_count_min_sketch_incr2;
}

register sketch_register3 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_3_alu {
    reg: sketch_register3;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr3 () {
    reg_3_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr3 {
    actions {
        action_count_min_sketch_incr3;
    }
    default_action: action_count_min_sketch_incr3;
}

register sketch_register4 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_4_alu {
    reg: sketch_register4;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr4 () {
    reg_4_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr4 {
    actions {
        action_count_min_sketch_incr4;
    }
    default_action: action_count_min_sketch_incr4;
}

register sketch_register5 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_5_alu {
    reg: sketch_register5;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr5 () {
    reg_5_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr5 {
    actions {
        action_count_min_sketch_incr5;
    }
    default_action: action_count_min_sketch_incr5;
}

register sketch_register6 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_6_alu {
    reg: sketch_register6;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr6 () {
    reg_6_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr6 {
    actions {
        action_count_min_sketch_incr6;
    }
    default_action: action_count_min_sketch_incr6;
}

register sketch_register7 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_7_alu {
    reg: sketch_register7;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr7 () {
    reg_7_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr7 {
    actions {
        action_count_min_sketch_incr7;
    }
    default_action: action_count_min_sketch_incr7;
}

register sketch_register8 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_8_alu {
    reg: sketch_register8;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr8 () {
    reg_8_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr8 {
    actions {
        action_count_min_sketch_incr8;
    }
    default_action: action_count_min_sketch_incr8;
}

register sketch_register9 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_9_alu {
    reg: sketch_register9;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr9 () {
    reg_9_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr9 {
    actions {
        action_count_min_sketch_incr9;
    }
    default_action: action_count_min_sketch_incr9;
}

register sketch_register10 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_10_alu {
    reg: sketch_register10;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr10 () {
    reg_10_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr10 {
    actions {
        action_count_min_sketch_incr10;
    }
    default_action: action_count_min_sketch_incr10;
}

register sketch_register11 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_11_alu {
    reg: sketch_register11;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr11 () {
    reg_11_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr11 {
    actions {
        action_count_min_sketch_incr11;
    }
    default_action: action_count_min_sketch_incr11;
}

register sketch_register12 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_12_alu {
    reg: sketch_register12;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr12 () {
    reg_12_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr12 {
    actions {
        action_count_min_sketch_incr12;
    }
    default_action: action_count_min_sketch_incr12;
}

register sketch_register13 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_13_alu {
    reg: sketch_register13;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr13 () {
    reg_13_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr13 {
    actions {
        action_count_min_sketch_incr13;
    }
    default_action: action_count_min_sketch_incr13;
}

register sketch_register14 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_14_alu {
    reg: sketch_register14;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr14 () {
    reg_14_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr14 {
    actions {
        action_count_min_sketch_incr14;
    }
    default_action: action_count_min_sketch_incr14;
}

register sketch_register15 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_15_alu {
    reg: sketch_register15;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr15 () {
    reg_15_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr15 {
    actions {
        action_count_min_sketch_incr15;
    }
    default_action: action_count_min_sketch_incr15;
}

register sketch_register16 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_16_alu {
    reg: sketch_register16;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr16 () {
    reg_16_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr16 {
    actions {
        action_count_min_sketch_incr16;
    }
    default_action: action_count_min_sketch_incr16;
}

register sketch_register17 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_17_alu {
    reg: sketch_register17;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr17 () {
    reg_17_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr17 {
    actions {
        action_count_min_sketch_incr17;
    }
    default_action: action_count_min_sketch_incr17;
}

register sketch_register18 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_18_alu {
    reg: sketch_register18;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr18 () {
    reg_18_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr18 {
    actions {
        action_count_min_sketch_incr18;
    }
    default_action: action_count_min_sketch_incr18;
}

register sketch_register19 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_19_alu {
    reg: sketch_register19;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr19 () {
    reg_19_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr19 {
    actions {
        action_count_min_sketch_incr19;
    }
    default_action: action_count_min_sketch_incr19;
}

register sketch_register20 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_20_alu {
    reg: sketch_register20;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr20 () {
    reg_20_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr20 {
    actions {
        action_count_min_sketch_incr20;
    }
    default_action: action_count_min_sketch_incr20;
}

register sketch_register21 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_21_alu {
    reg: sketch_register21;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr21 () {
    reg_21_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr21 {
    actions {
        action_count_min_sketch_incr21;
    }
    default_action: action_count_min_sketch_incr21;
}

register sketch_register22 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_22_alu {
    reg: sketch_register22;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr22 () {
    reg_22_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr22 {
    actions {
        action_count_min_sketch_incr22;
    }
    default_action: action_count_min_sketch_incr22;
}

register sketch_register23 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_23_alu {
    reg: sketch_register23;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr23 () {
    reg_23_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr23 {
    actions {
        action_count_min_sketch_incr23;
    }
    default_action: action_count_min_sketch_incr23;
}

register sketch_register24 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_24_alu {
    reg: sketch_register24;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr24 () {
    reg_24_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr24 {
    actions {
        action_count_min_sketch_incr24;
    }
    default_action: action_count_min_sketch_incr24;
}

register sketch_register25 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_25_alu {
    reg: sketch_register25;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr25 () {
    reg_25_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr25 {
    actions {
        action_count_min_sketch_incr25;
    }
    default_action: action_count_min_sketch_incr25;
}

register sketch_register26 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_26_alu {
    reg: sketch_register26;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr26 () {
    reg_26_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr26 {
    actions {
        action_count_min_sketch_incr26;
    }
    default_action: action_count_min_sketch_incr26;
}

register sketch_register27 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_27_alu {
    reg: sketch_register27;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr27 () {
    reg_27_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr27 {
    actions {
        action_count_min_sketch_incr27;
    }
    default_action: action_count_min_sketch_incr27;
}

register sketch_register28 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_28_alu {
    reg: sketch_register28;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr28 () {
    reg_28_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr28 {
    actions {
        action_count_min_sketch_incr28;
    }
    default_action: action_count_min_sketch_incr28;
}

register sketch_register29 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_29_alu {
    reg: sketch_register29;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr29 () {
    reg_29_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr29 {
    actions {
        action_count_min_sketch_incr29;
    }
    default_action: action_count_min_sketch_incr29;
}

register sketch_register30 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_30_alu {
    reg: sketch_register30;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr30 () {
    reg_30_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr30 {
    actions {
        action_count_min_sketch_incr30;
    }
    default_action: action_count_min_sketch_incr30;
}

register sketch_register31 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_31_alu {
    reg: sketch_register31;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr31 () {
    reg_31_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr31 {
    actions {
        action_count_min_sketch_incr31;
    }
    default_action: action_count_min_sketch_incr31;
}

register sketch_register32 {
    width : TF_HASH_BIT_WIDTH;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu reg_32_alu {
    reg: sketch_register32;
    update_lo_1_value: register_lo + 1;
}
action action_count_min_sketch_incr32 () {
    reg_32_alu.execute_stateful_alu(Meta.hash_index);
}
table table_count_min_sketch_incr32 {
    actions {
        action_count_min_sketch_incr32;
    }
    default_action: action_count_min_sketch_incr32;
}



control ingress {
    if (valid(ethernet)){
        apply(hop);
    }
    if (valid(fphdr)) {
        apply(table_count_min_sketch_hash);
        apply(table_count_min_sketch_incr0);
        if (ipv4.srcAddr & 0x00000001 != 0) {
            apply(table_count_min_sketch_incr1);
        }
        if (ipv4.srcAddr & 0x00000002 != 0) {
            apply(table_count_min_sketch_incr2);
        }
        if (ipv4.srcAddr & 0x00000004 != 0) {
            apply(table_count_min_sketch_incr3);
        }
        if (ipv4.srcAddr & 0x00000008 != 0) {
            apply(table_count_min_sketch_incr4);
        }
        if (ipv4.srcAddr & 0x00000010 != 0) {
            apply(table_count_min_sketch_incr5);
        }
        if (ipv4.srcAddr & 0x00000020 != 0) {
            apply(table_count_min_sketch_incr6);
        }
        if (ipv4.srcAddr & 0x00000040 != 0) {
            apply(table_count_min_sketch_incr7);
        }
        if (ipv4.srcAddr & 0x00000080 != 0) {
            apply(table_count_min_sketch_incr8);
        }
        if (ipv4.srcAddr & 0x00000100 != 0) {
            apply(table_count_min_sketch_incr9);
        }
        if (ipv4.srcAddr & 0x00000200 != 0) {
            apply(table_count_min_sketch_incr10);
        }
        if (ipv4.srcAddr & 0x00000400 != 0) {
            apply(table_count_min_sketch_incr11);
        }
        if (ipv4.srcAddr & 0x00000800 != 0) {
            apply(table_count_min_sketch_incr12);
        }
        if (ipv4.srcAddr & 0x00001000 != 0) {
            apply(table_count_min_sketch_incr13);
        }
        if (ipv4.srcAddr & 0x00002000 != 0) {
            apply(table_count_min_sketch_incr14);
        }
        if (ipv4.srcAddr & 0x00004000 != 0) {
            apply(table_count_min_sketch_incr15);
        }
        if (ipv4.srcAddr & 0x00008000 != 0) {
            apply(table_count_min_sketch_incr16);
        }
        if (ipv4.srcAddr & 0x00010000 != 0) {
            apply(table_count_min_sketch_incr17);
        }
        if (ipv4.srcAddr & 0x00020000 != 0) {
            apply(table_count_min_sketch_incr18);
        }
        if (ipv4.srcAddr & 0x00040000 != 0) {
            apply(table_count_min_sketch_incr19);
        }
        if (ipv4.srcAddr & 0x00080000 != 0) {
            apply(table_count_min_sketch_incr20);
        }
        if (ipv4.srcAddr & 0x00100000 != 0) {
            apply(table_count_min_sketch_incr21);
        }
        if (ipv4.srcAddr & 0x00200000 != 0) {
            apply(table_count_min_sketch_incr22);
        }
        if (ipv4.srcAddr & 0x00400000 != 0) {
            apply(table_count_min_sketch_incr23);
        }
        if (ipv4.srcAddr & 0x00800000 != 0) {
            apply(table_count_min_sketch_incr24);
        }
        if (ipv4.srcAddr & 0x01000000 != 0) {
            apply(table_count_min_sketch_incr25);
        }
        if (ipv4.srcAddr & 0x02000000 != 0) {
            apply(table_count_min_sketch_incr26);
        }
        if (ipv4.srcAddr & 0x04000000 != 0) {
            apply(table_count_min_sketch_incr27);
        }
        if (ipv4.srcAddr & 0x08000000 != 0) {
            apply(table_count_min_sketch_incr28);
        }
        if (ipv4.srcAddr & 0x10000000 != 0) {
            apply(table_count_min_sketch_incr29);
        }
        if (ipv4.srcAddr & 0x20000000 != 0) {
            apply(table_count_min_sketch_incr30);
        }
        if (ipv4.srcAddr & 0x40000000 != 0) {
            apply(table_count_min_sketch_incr31);
        }
        if (ipv4.srcAddr & 0x80000000 != 0) {
            apply(table_count_min_sketch_incr32);
        }
	}
}


control egress {

}
