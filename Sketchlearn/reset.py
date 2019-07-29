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
arrays_m = 32+1
depth_n= 4096

class AddEntry(pd_base_tests.ThriftInterfaceDataPlane):
    def __init__(self):
        pd_base_tests.ThriftInterfaceDataPlane.__init__(self, ["Sketchlearn"])
        self.devPorts = []
        self.dev_id = 0
    
    def runTest(self):
        try:
            sess_hdl = self.conn_mgr.client_init()
            dev_tgt = DevTarget_t(self.dev_id, hex_to_i16(0xFFFF))
            print datetime.datetime.now(), "Syncing registers"

            record = open("time.txt","w")
            for m in range(arrays_m):
                startt = time.time()
                for i in range(m):
                        x = eval("self.client.register_reset_all_sketch_register" + str(i) +\
                            "(sess_hdl, dev_tgt)")
                endt = time.time()
                # print "done ", m, n, endt -startt
                record.writelines("%f," % (endt - startt))
            print datetime.datetime.now(), "Done"
            record.close()
                    
        finally:
            self.conn_mgr.client_cleanup(hex_to_i32(sess_hdl))