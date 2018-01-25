import os, signal, subprocess, sys

def timeoutPeriodToSeconds(period):
    """Parse `period` and return its equivalent in seconds. `period` is of
the form 12s, 12m or 12h for a timeout of 12 seconds, minutes or
hours, respectively.
    """
    units = period[-1]
    if units not in ['s','m','h']:
        raise "Invalid timeout units (should be one of s, m, or h): "+period
    duration = None
    try:
        duration = int(period[:-1])
        assert duration > 0, "Invalid timeout value (should be a positive integer): "+period
    except ValueError:
        raise "Invalid timeout value (should be a positive integer): "+period

    if units == 's':
        pass
    elif units == 'm':
        duration *= 60
    elif units == 'h':
        duration *= (60 * 60)
        pass
    return duration


def setupTimeout(timeoutSecs,timeoutSignal):
    # NB: this code runs in child
    #print "child pid:", os.getpid()
    #print timeoutSecs, timeoutSignal

    # put ourselves in our own process group
    os.setpgid( 0, 0 )
    # setup handler before scheduling the alarm, to eliminate a race
    signal.signal( signal.SIGALRM, 
                   lambda sig,frame : os.killpg(os.getpgid(0),timeoutSignal) )
    signal.alarm( timeoutSecs )
    return

def call(args, timeoutPeriod=None, 
         timeoutSignal=signal.SIGKILL,
         **namedParams):
    "Timeout-enabled wrapper of subprocess.call()"

    preFun = None
    assert isinstance( timeoutSignal, int )
    if timeoutPeriod is not None:
        timeoutSecs = timeoutPeriodToSeconds(timeoutPeriod)
        preFun = lambda : setupTimeout(timeoutSecs, timeoutSignal)
        pass
    
    return subprocess.call(args, preexec_fn=preFun, **namedParams)


def check_call(args, timeoutPeriod=None, 
               timeoutSignal=signal.SIGKILL,
               **namedParams):
    "Timeout-enabled wrapper of subprocess.check_call()"

    #print "parent pid:", os.getpid()

    preFun = None
    assert isinstance( timeoutSignal, int )
    if timeoutPeriod is not None:
        timeoutSecs = timeoutPeriodToSeconds(timeoutPeriod)
        preFun = lambda : setupTimeout(timeoutSecs, timeoutSignal)
        pass
    
    return subprocess.check_call(args, preexec_fn=preFun, **namedParams)


def check_output(args, timeoutPeriod=None, 
                 timeoutSignal=signal.SIGKILL,
                 **namedParams):
    "Timeout-enabled wrapper of subprocess.check_output()"

    preFun = None
    assert isinstance( timeoutSignal, int )
    if timeoutPeriod is not None:
        timeoutSecs = timeoutPeriodToSeconds(timeoutPeriod)
        preFun = lambda : setupTimeout(timeoutSecs, timeoutSignal)
        pass

    return subprocess.check_output(args, preexec_fn=preFun, **namedParams)


if __name__ == "__main__":
    if len(sys.argv) <= 2:
        print "Usage:", sys.argv[0], "TIMEOUT COMMAND..."
        print

        descrip = """Runs COMMAND for up to TIMEOUT, sending COMMAND a SIGKILL if it
attempts to run longer. Exits sooner if COMMAND does so, passing along COMMAND's
exit code. TIMEOUT is of the form 12s, 12m or 12h for a timeout of 12 seconds,
minutes or hours, respectively.

All of COMMAND's children run in a new process group, and the entire group is
SIGKILL'ed when the timeout expires. """
        print descrip

        sys.exit( 1 )
        pass

    rc = call( " ".join(sys.argv[2:]),
               timeoutPeriod=sys.argv[1], shell=True )
    sys.exit( rc )
