/**
 *
 * Simple switch with HashPipe
 * 
 */
#include <tofino/stateful_alu_blackbox.p4>
#include <tofino/intrinsic_metadata.p4>
#include <tofino/constants.p4>

#include "headers.p4"
#include "parser.p4"
/**
 *
 *  HashPipe data plane.
 * 
 */
// Max number of flows to track at once.
#define TF_HASH_TBL_SIZE 4096
#define TF_HASH_BIT_WIDTH 12

/***********************************************************
 *  hash
***********************************************************/
/* Field list describing which fields contribute to the hash. */
field_list bf_hash_fields {
    // ipv4.protocol;
    ipv4.srcAddr;
    // ipv4.dstAddr;
    // tcp.sPort;
    // tcp.dPort;
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
    algorithm: random;
    output_width: TF_HASH_BIT_WIDTH;
}
field_list_calculation bf_hash_2 {
    input { bf_hash_fields; }
    algorithm: crc16;
    output_width: TF_HASH_BIT_WIDTH;
}
field_list_calculation bf_hash_3 {
    input { bf_hash_fields; }
    algorithm: xmodem;
    output_width: TF_HASH_BIT_WIDTH;
}

/***********************************************************
 *  hashpipe stage 0
***********************************************************/
register rSrcAddr_0 {
    width : 64;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu rSrcAddr_0_alu {
    reg: rSrcAddr_0;
    condition_hi: ipv4.srcAddr - register_hi == 0;
    update_hi_1_predicate: condition_hi;
    update_hi_1_value: register_hi;
    update_hi_2_predicate: not condition_hi;
    update_hi_2_value: ipv4.srcAddr;
    update_lo_1_predicate: condition_hi;
    update_lo_1_value: register_lo + 1;
    update_lo_2_predicate: not condition_hi;
    update_lo_2_value: 1;
    output_predicate: not condition_hi;
    output_value : register_hi;
    output_dst : fphdr.readsrcAddr;
}
action aiUpdateSrcAddr_0() {
    rSrcAddr_0_alu.execute_stateful_alu_from_hash(bf_hash_0);
}
table tiUpdateSrcAddr_0 {
    actions {aiUpdateSrcAddr_0;}
    default_action: aiUpdateSrcAddr_0();
    size: 1;
}

register rPktCnt_0 {
    width : 32;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu salu_UpdatePktCnt_0 {
    reg: rPktCnt_0;
    condition_hi:  fphdr.readsrcAddr == 0;
    update_lo_1_predicate: condition_hi;
    update_lo_1_value: register_lo + 1;
    update_lo_2_predicate: not condition_hi;
    update_lo_2_value: 1;
    output_predicate: not condition_hi;
    output_value : register_lo;
    output_dst : fphdr.readpktCt;
}
action aiUpdatePktCnt_0() {
    salu_UpdatePktCnt_0.execute_stateful_alu_from_hash(bf_hash_0);
}
table tiUpdatePktCnt_0 {
    actions {aiUpdatePktCnt_0;}
    default_action: aiUpdatePktCnt_0();
    size: 1;
}


/***********************************************************
 *  hashpipe stage 1
***********************************************************/
register rSrcAddr {
    width : 64;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu rSrcAddr_alu {
    reg: rSrcAddr;
    condition_hi: ipv4.srcAddr - register_hi == 0;
    condition_lo: fphdr.pktCt - register_lo > 0;
    update_hi_1_predicate: condition_hi;
    update_hi_1_value: register_hi;
    update_hi_2_predicate: not condition_hi and condition_lo;
    update_hi_2_value: ipv4.srcAddr;
    update_lo_1_predicate: condition_hi;
    update_lo_1_value: register_lo + fphdr.pktCt;
    update_lo_2_predicate: not condition_hi and condition_lo;
    update_lo_2_value: fphdr.pktCt;
    output_predicate: not condition_hi;
    output_value : register_hi;
    output_dst : fphdr.readsrcAddr;
}
action aiUpdateSrcAddr() {
    rSrcAddr_alu.execute_stateful_alu_from_hash(bf_hash_1);
}
table tiUpdateSrcAddr {
    actions {aiUpdateSrcAddr;}
    default_action: aiUpdateSrcAddr();
    size: 1;
}

register rPktCnt {
    width : 32;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu salu_UpdatePktCnt {
    reg: rPktCnt;
    condition_hi:  fphdr.readsrcAddr == 0;
    condition_lo: fphdr.pktCt - register_lo > 0;
    update_lo_1_predicate: condition_hi;
    update_lo_1_value: register_lo + fphdr.pktCt;
    update_lo_2_predicate: not condition_hi and condition_lo;
    update_lo_2_value: fphdr.pktCt;
    output_predicate: not condition_hi and condition_lo;
    output_value : register_lo;
    output_dst : fphdr.readpktCt;
}
action aiUpdatePktCnt() {
    salu_UpdatePktCnt.execute_stateful_alu_from_hash(bf_hash_1);
}
table tiUpdatePktCnt {
    actions {aiUpdatePktCnt;}
    default_action: aiUpdatePktCnt();
    size: 1;
}

/***********************************************************
 *  hashpipe stage 2
***********************************************************/
register rSrcAddr_2 {
    width : 64;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu rSrcAddr_2_alu {
    reg: rSrcAddr_2;
    condition_hi: ipv4.srcAddr - register_hi == 0;
    condition_lo: fphdr.pktCt - register_lo > 0;
    update_hi_1_predicate: condition_hi;
    update_hi_1_value: register_hi;
    update_hi_2_predicate: not condition_hi and condition_lo;
    update_hi_2_value: ipv4.srcAddr;
    update_lo_1_predicate: condition_hi;
    update_lo_1_value: register_lo + fphdr.pktCt;
    update_lo_2_predicate: not condition_hi and condition_lo;
    update_lo_2_value: fphdr.pktCt;
    output_predicate: not condition_hi;
    output_value : register_hi;
    output_dst : fphdr.readsrcAddr;
}
action aiUpdateSrcAddr_2() {
    rSrcAddr_2_alu.execute_stateful_alu_from_hash(bf_hash_2);
}
table tiUpdateSrcAddr_2 {
    actions {aiUpdateSrcAddr_2;}
    default_action: aiUpdateSrcAddr_2();
    size: 1;
}

register rPktCnt_2 {
    width : 32;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu salu_UpdatePktCnt_2 {
    reg: rPktCnt_2;
    condition_hi:  fphdr.readsrcAddr == 0;
    condition_lo: fphdr.pktCt - register_lo > 0;
    update_lo_1_predicate: condition_hi;
    update_lo_1_value: register_lo + fphdr.pktCt;
    update_lo_2_predicate: not condition_hi and condition_lo;
    update_lo_2_value: fphdr.pktCt;
    output_predicate: not condition_hi and condition_lo;
    output_value : register_lo;
    output_dst : fphdr.readpktCt;
}
action aiUpdatePktCnt_2() {
    salu_UpdatePktCnt_2.execute_stateful_alu_from_hash(bf_hash_2);
}
table tiUpdatePktCnt_2 {
    actions {aiUpdatePktCnt_2;}
    default_action: aiUpdatePktCnt_2();
    size: 1;
}

/***********************************************************
 *  hashpipe stage 3
***********************************************************/
register rSrcAddr_3 {
    width : 64;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu rSrcAddr_3_alu {
    reg: rSrcAddr_3;
    condition_hi: ipv4.srcAddr - register_hi == 0;
    condition_lo: fphdr.pktCt - register_lo > 0;
    update_hi_1_predicate: condition_hi;
    update_hi_1_value: register_hi;
    update_hi_2_predicate: not condition_hi and condition_lo;
    update_hi_2_value: ipv4.srcAddr;
    update_lo_1_predicate: condition_hi;
    update_lo_1_value: register_lo + fphdr.pktCt;
    update_lo_2_predicate: not condition_hi and condition_lo;
    update_lo_2_value: fphdr.pktCt;
    output_predicate: not condition_hi;
    output_value : register_hi;
    output_dst : fphdr.readsrcAddr;
}
action aiUpdateSrcAddr_3() {
    rSrcAddr_3_alu.execute_stateful_alu_from_hash(bf_hash_3);
}
table tiUpdateSrcAddr_3 {
    actions {aiUpdateSrcAddr_3;}
    default_action: aiUpdateSrcAddr_3();
    size: 1;
}

register rPktCnt_3 {
    width : 32;
    instance_count : TF_HASH_TBL_SIZE;
}
blackbox stateful_alu salu_UpdatePktCnt_3 {
    reg: rPktCnt_3;
    condition_hi:  fphdr.readsrcAddr == 0;
    condition_lo: fphdr.pktCt - register_lo > 0;
    update_lo_1_predicate: condition_hi;
    update_lo_1_value: register_lo + fphdr.pktCt;
    update_lo_2_predicate: not condition_hi and condition_lo;
    update_lo_2_value: fphdr.pktCt;
    output_predicate: not condition_hi and condition_lo;
    output_value : register_lo;
    output_dst : fphdr.readpktCt;
}
action aiUpdatePktCnt_3() {
    salu_UpdatePktCnt_3.execute_stateful_alu_from_hash(bf_hash_3);
}
table tiUpdatePktCnt_3 {
    actions {aiUpdatePktCnt_3;}
    default_action: aiUpdatePktCnt_3();
    size: 1;
}

/*=====================================================
=            next hop table, forward packets           =
======================================================*/
table hop{
    actions{hop_act;}
    default_action : hop_act();
}
action hop_act() {
    modify_field(ig_intr_md_for_tm.ucast_egress_port, 148);
}

control ingress {
    if (valid(fphdr)) {
        //stage 0 always insert
        apply(tiUpdateSrcAddr_0);
        apply(tiUpdatePktCnt_0);
        //stage 1
        apply(tiUpdateSrcAddr);
        apply(tiUpdatePktCnt);
        //stage 2
        apply(tiUpdateSrcAddr_2);
        apply(tiUpdatePktCnt_2);
        //stage 3
        apply(tiUpdateSrcAddr_3);
        apply(tiUpdatePktCnt_3);
        //forward
        apply(hop);
	}
}

control egress {

}
