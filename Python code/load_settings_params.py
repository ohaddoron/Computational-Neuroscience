# -*- coding: utf-8 -*-
"""
Created on Sat Jul  1 21:07:49 2017

@author: Ohaddoron
"""

class settings:
    def __init__(self):
        import os.path
        self.path2results = os.path.join('..','results')
        self.path2figures = os.path.join('..','figures')
        
class params:
    def __init__(self):
        self.I_e = 50 # electrode current
        self.thresh = -55 # threshold potential
        self.V0 = -70 # starting voltage
        self.Rm = 5 # memberane resistance
        self.Cm = 1 # memberane capacitance
        self.tau_m = self.Rm * self.Cm # membrane time constant
        self.E_L = -60 # leaky potetial
        self.refract = 4 # refractory period
        