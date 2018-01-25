import unittest, signal

import TimedSubprocess

class TestTimeout(unittest.TestCase):

    def test_Process(self):
        rc = TimedSubprocess.call("sleep 10", shell=True, timeoutPeriod="1s")
        self.assertEqual( rc, -1 * signal.SIGALRM )
        return

    def test_ProcessTree(self):
        rc = TimedSubprocess.call("time sleep 10", shell=True, timeoutPeriod="1s")
        self.assertEqual( rc, -1 * signal.SIGALRM )
        return

    def test_Loop(self):
        rc = TimedSubprocess.call("python -c 'while True: pass'", shell=True, timeoutPeriod="1s")
        self.assertEqual( rc, -1 * signal.SIGALRM )
        return

    def test_Yes(self):
        devnull = open("/dev/null", "r")
        rc = TimedSubprocess.call("yes", shell=True, stdout=devnull, timeoutPeriod="1s")
        devnull.close()
        self.assertEqual( rc, -1 * signal.SIGALRM )
        return
    
    pass

if __name__ == '__main__':
    unittest.main()
