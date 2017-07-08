# -*- coding: utf-8 -*-
"""
Created on Sat Jul  1 21:25:02 2017

@author: Ohaddoron
"""

from brian2 import *
I_e = 50*namp # electrode current
thresh = -55*mvolt # threshold potential
V0 = -70*mvolt # starting voltage
Rm = 5*Mohm # memberane resistance
Cm = 1*nF # memberane capacitance
tau_m = Rm * Cm # membrane time constant
E_L = -60*mvolt # leaky potetial
refract = 4*msecond # refractory period
N = 100 # num neurons

start_scope()
eqs = '''
dx/dt = (1-x)/tau_D - u*x*
 '''

G = NeuronGroup(1, eqs, threshold='v>1', reset='v=0', method='linear')
G.v = 'rand()'

spikemon = SpikeMonitor(G)

run(50*ms)

plot(spikemon.t/ms, spikemon.i, '.k')
xlabel('Time (ms)')
ylabel('Neuron index');