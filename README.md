# CYTimer
A swift timer。Avoid problems with native Timer class strong references, stalls, inaccuracies, etc.

###Feature
* Based entirely on swift.
* Without any dependency.
* Support custom queue.
* Use Block to avoid strong reference issues with `target`.
* Stable and accurate.
* Memory security.

### Usage
Drag the `CYTimer` folder to your project，and follow the example below:

```SWIFT
  /*
         ATTENTION :
            After the timer is created, it must be held by an instance, otherwise it will be destroyed immediately
         PARAMETER :
            queue : Specify the timer to run the queue, Default `main queue`
            timeInterval : Specify timer interval
            repeats : Mark timer to repeat tasks
            isIMEXE : Whether the timer is executed immediately after it is created。This parameter is only valid for reaped timer. Default `false`
         
         */
        timer = CYTimer.init(queue: DispatchQueue.init(label: "custom-queue"), timeInterval: 2, repeats: true, isIMEXE: true, block: {[weak self]  (timer) in
            self?.timerAction()
        })
        /* 
        Call the timer methods without worrying about memory problems or crashes
        */
        // The timer suspend
        timer?.suspend()
        // The timer start or restart
        timer?.resume()
        //The timer cancel.If you want to  use it again, you need to reset the timer
        timer?.cancel()
        
        // reset the timer
        func resetTimer(_ sender: UIButton) {
        timer?.timer(queue: DispatchQueue.global(), timeInterval: 4, repeats: true, block: { [weak self](_) in
            self?.timerAction()
        })
        
    }

```

