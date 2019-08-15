import copy
import datetime
import logging
import os
import pdb
import random
import sys
import time
import unittest
from collections import OrderedDict

import pal_rpc
import pd_base_tests
import pltfm_pm_rpc
import ptf.dataplane as dataplane
from conn_mgr_pd_rpc.ttypes import *
from devport_mgr_pd_rpc.ttypes import *
from mc_pd_rpc.ttypes import *
from pal_rpc.ttypes import *
from pltfm_pm_rpc.ttypes import *
from ptf import config
from ptf.testutils import *
from ptf.thriftutils import *
from ptf_port import *
from res_pd_rpc.ttypes import *
from Sketchlearn.p4_pd_rpc.ttypes import *

this_dir = os.path.dirname(os.path.abspath(__file__))

# Front Panel Ports
fp_ports = ["1/0", "3/0"]

class AddEntry(pd_base_tests.ThriftInterfaceDataPlane):
    def __init__(self):
        pd_base_tests.ThriftInterfaceDataPlane.__init__(self, ["Sketchlearn"])
        self.devPorts = []
        self.dev_id = 0
    
    def runTest(self):
        sess_hdl = self.conn_mgr.client_init()
        dev_tgt = DevTarget_t(self.dev_id, hex_to_i16(0xFFFF))
        startt = time.time()
        print datetime.datetime.now(), "Syncing registers"

        self.client.register_hw_sync_sketch_register0(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        # #record = open("register0.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register0(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register1(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register1.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register1(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register2(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register2.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register2(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register3(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register3.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register3(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register4(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register4.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register4(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register5(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register5.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register5(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register6(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register6.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register6(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register7(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register7.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register7(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register8(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register8.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register8(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register9(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register9.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register9(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register10(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register10.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register10(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register11(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register11.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register11(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register12(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register12.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register12(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register13(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register13.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register13(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register14(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register14.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register14(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register15(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register15.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register15(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register16(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register16.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register16(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register17(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register17.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register17(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register18(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register18.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register18(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register19(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register19.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register19(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register20(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register20.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register20(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register21(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register21.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register21(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register22(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register22.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register22(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register23(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register23.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register23(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register24(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register24.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register24(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register25(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register25.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register25(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register26(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register26.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register26(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register27(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register27.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register27(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register28(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register28.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register28(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register29(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register29.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register29(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register30(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register30.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register30(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register31(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register31.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register31(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        self.client.register_hw_sync_sketch_register32(sess_hdl, dev_tgt)
        #print datetime.datetime.now(), "  Done"
        #sys.stdout.flush()

        #print datetime.datetime.now(), "Verifying registers"
        hw_async_flag = Sketchlearn_register_flags_t(read_hw_sync = False)

        #record = open("register32.txt","w")
        for i in range(256):
            x = self.client.register_read_sketch_register32(sess_hdl, dev_tgt, i, hw_async_flag )
            #record.write(str(x[1])+"\n")

        endt = time.time()
        print "done elapse", endt -startt

        self.conn_mgr.client_cleanup(hex_to_i32(sess_hdl))

        # record.close()







        
        