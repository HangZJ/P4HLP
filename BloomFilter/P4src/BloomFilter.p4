/****************************************************************************** 
 *
 * Bloom Filter Table
 *
 *****************************************************************************/
#include <tofino/stateful_alu_blackbox.p4>
#include <tofino/intrinsic_metadata.p4>
#include <tofino/constants.p4>

#include "headers.p4"
#include "parser.p4"

#define TF_HASH_TBL_SIZE 4096
#define TF_HASH_BIT_WIDTH 12

/* Field list describing which fields contribute to the hash. */
field_list bf_hash_fields {
    ipv4.protocol;
    ipv4.srcAddr;
    ipv4.dstAddr;
    tcp.srcPort;
    tcp.dstPort;
}

/* 
 * hash functions
 */
field_list_calculation bf_hash_0 {
    input { bf_hash_fields; }
    algorithm: crc_16_genibus;
    output_width: TF_HASH_BIT_WIDTH;
}
field_list_calculation bf_hash_1 {
    input { bf_hash_fields; }
    algorithm: xmodem;
    output_width: TF_HASH_BIT_WIDTH;
}
field_list_calculation bf_hash_2 {
    input { bf_hash_fields; }
    algorithm: crc16;
    output_width: TF_HASH_BIT_WIDTH;
}

/* Three registers implementing the bloom filter.*/
register bloom_filter_1 {
    width : 1;
    instance_count : TF_HASH_TBL_SIZE;
}
register bloom_filter_2 {
    width : 1;
    instance_count : TF_HASH_TBL_SIZE;
}
register bloom_filter_3 {
    width : 1;
    instance_count : TF_HASH_TBL_SIZE;
}

/* Three stateful ALU blackboxes running the bloom filter.*/
blackbox stateful_alu bloom_filter_alu_1 {
    reg: bloom_filter_1;
    update_lo_1_value: set_bitc;
}
blackbox stateful_alu bloom_filter_alu_2 {
    reg: bloom_filter_2;
    update_lo_1_value: set_bitc;
}
blackbox stateful_alu bloom_filter_alu_3 {
    reg: bloom_filter_3;
    update_lo_1_value: set_bitc;
}

action check_bloom_filter_1() {
    bloom_filter_alu_1.execute_stateful_alu_from_hash(bf_hash_1);
}
action check_bloom_filter_2() {
    bloom_filter_alu_2.execute_stateful_alu_from_hash(bf_hash_2);
}
action check_bloom_filter_3() {
    bloom_filter_alu_3.execute_stateful_alu_from_hash(bf_hash_3);
}

table ti_bloom_filter_1 {
    actions { check_bloom_filter_1; }
    size : 1;
}
table ti_bloom_filter_2 {
    actions { check_bloom_filter_2; }
    size : 1;
}
table ti_bloom_filter_3 {
    actions { check_bloom_filter_3; }
    size : 1;
}

/*=====================================================
=            next hop table, forward packets           =
======================================================*/
table hop{
    actions{hop_act;}
}
action hop_act(port) {
    modify_field(ig_intr_md_for_tm.ucast_egress_port, port);
}

control ingress {
    if (valid(fphdr)) {
        apply(ti_bloom_filter_1);
        apply(ti_bloom_filter_2);
        apply(ti_bloom_filter_3);
        apply(hop);
	}
}

control egress {

}