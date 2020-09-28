from xpedite import Probe, TxnBeginProbe, TxnEndProbe

appName = 'Life'                      # Name of the application
appHost = '127.0.0.1'                 # Host, where the application is running
appInfo = '/tmp/xpedite-appinfo.txt'  # Path of the appinfo file

probes = [
  TxnBeginProbe('Life Begin', sysName = 'LifeBegin'),     # Txn begins with probe 'LifeBegin', marks the beginning of 'eat()'
  Probe('Code Begin', sysName = 'CodeBegin'),             # Marks the beginning of 'code()'
  Probe('Sleep Begin', sysName = 'SleepBegin'),           # Marks the beginning of 'sleep()'
  TxnEndProbe('Life End', sysName = 'LifeEnd'),           # Txn ends with probe 'LifeEnd', marks the end of 'sleep()'
  TxnBeginProbe('Eat Begin', sysName = 'EatBegin'),     # Txn begins with probe 'EatBegin', marks the beginning of 'eat()'
  Probe('Eat More Begin', sysName = 'EatMoreBegin'),           # Marks the beginning of 'eat more'
  Probe('Eat Even More Begin', sysName = 'EatEvenMoreBegin'),           # Marks the beginning of 'eat even more'
  TxnEndProbe('Eat End', sysName = 'EatEnd'),           # Txn ends with probe 'EatEnd', marks the end of 'eat()'
]

benchmarkPaths = [
    '/tmp/baseline'
]

from xpedite import TopdownNode, Metric, Event

# List of performance counters to be collected for this profile
pmc = [
  TopdownNode('Root'),                                      # Top down analysis for Root node of the hierarchy
  Metric('IPC'),                                            # Instructions retired per cycle
  Event('Data L1 Miss',   'L2_RQSTS.DEMAND_DATA_RD_HIT'),   # Demand Data Read requests that hit L2 cache
  Event('Data L2 Miss',   'L2_RQSTS.DEMAND_DATA_RD_MISS'),  # Demand Data Read requests that miss L2 cache
]

# List of cpu, where the hardware performance counters will be enabled
cpuSet = [5]
