header_type ethernet_t {
    fields {
        dstAddr : 48;
        srcAddr : 48;
        etherType : 16;
    }
}

header ethernet_t ethernet;


header_type ipv4_t {
    fields {
        version : 4;
        ihl : 4;
        diffserv : 8;
        totalLen : 16;
        identification : 16;
        flags : 3;
        fragOffset : 13;
        ttl : 8;
        protocol : 8;
        hdrChecksum : 16;
        srcAddr : 32;
        dstAddr : 32;
    }
}

header ipv4_t ipv4;


header_type ipv6_t {
    fields {
        version : 4;
        trafficClass : 8;
        flowLabel : 20;
        payloadLen : 16;
        nextHdr : 8;
        hopLimit : 8;
        srcAddr : 128;
        dstAddr : 128;
    }
}

header ipv6_t ipv6;

header_type tcp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        seqNo : 32;
        ackNo : 32;
        dataOffset : 4;
        res : 3;
        ecn : 3;
        ctrl : 6;
        window : 16;
        checksum : 16;
        urgentPtr : 16;
    }
}

header tcp_t tcp;

header_type udp_t {
    fields {
        srcPort : 16;
        dstPort : 16;
        hdr_length : 16;
        checksum : 16;
    }
}

header udp_t udp;

header_type l4ports_t {
    fields {
        ports : 32;
        bind : 16;
    }
}

header l4ports_t l4ports;

/*==========================================
            FP Headers.            
==========================================*/

// Metadata for processing.
header_type user_metadata_t {
    fields {
        bf_tmp_1 : 1;
        bf_tmp_2 : 1;
        bf_tmp_3 : 1;
    }
}
metadata user_metadata_t md;


// Headers for exporting an evicted flow record.
header_type fphdr_t {
    fields {
        hashVal : 16;
        srcAddr : 32;
        dstAddr : 32;
        ports : 32;
        protocol : 32;

        //degbug flieds
        pad : 15;
        matchFlag : 1;
        byteCt : 32;
        pktCt : 16;
    }
}

header fphdr_t fphdr;
