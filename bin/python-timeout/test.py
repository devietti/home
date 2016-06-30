import timeout, os, signal
import unittest

class TestTimeout(unittest.TestCase):

    def test_TimeoutKillsProcess(self): 
        t = timeout.TimerTask( "sleep 3", 
                               timeout=1, timeoutSignal=signal.SIGKILL )
        t.run()
        self.assertEqual( t.wait(), -9 )
        return
        
    def test_JoiningProcessGroup(self):
        t0 = timeout.TimerTask( ["/bin/sleep", "2"], childProcessGroup=0 )
        t0.run( shell=False )
        pgid = os.getpgid( t0.subprocess.pid )
        #print "child 0 in pg", pgid, "with pid", t0.subprocess.pid

        t1 = timeout.TimerTask( ["/bin/sleep", "2"], childProcessGroup=pgid )
        t1.run( shell=False )
        #print "child 1 in pg", os.getpgid(t1.subprocess.pid), "with pid", t1.subprocess.pid
        self.assertEqual( os.getpgid( t0.subprocess.pid ), os.getpgid( t1.subprocess.pid ) )
        return

    def test_TimeoutKillsProcessGroup(self):
        t0 = timeout.TimerTask( ["/bin/sleep", "5"], childProcessGroup=0 )
        t0.run( shell=False )
        pgid = os.getpgid( t0.subprocess.pid )

        t1 = timeout.TimerTask( ["/bin/sleep", "5"], timeout=2, childProcessGroup=pgid )
        t1.run( shell=False )
        self.assertEqual( t0.wait(), -9 )
        self.assertEqual( t1.wait(), -9 )
        return
    pass

if __name__ == '__main__':
    unittest.main()
