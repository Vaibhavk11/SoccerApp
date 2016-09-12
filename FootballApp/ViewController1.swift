
import UIKit
import CoreMotion
class ViewController1: UIViewController {
    
    @IBOutlet weak var activityState: UILabel!
    @IBOutlet weak var steps: UILabel!
    
    var days:[String] = []
    var stepsTaken:[Int] = []
    
    @IBOutlet weak var stateImageView: UIImageView!
    let activityManager = CMMotionActivityManager()
    let pedoMeter = CMPedometer()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        let cal = NSCalendar.currentCalendar()
        //    var comps = cal.components(NSCalendarUnit.YearCalendarUnit | .MonthCalendarUnit | .DayCalendarUnit | .HourCalendarUnit | .MinuteCalendarUnit | .SecondCalendarUnit, fromDate: NSDate())
        let comps = cal.components([.Year, .Month, .Day, .Hour, .Minute, .Second], fromDate: NSDate())
        comps.hour = 0
        comps.minute = 0
        comps.second = 0
        let timeZone = NSTimeZone.systemTimeZone()
        cal.timeZone = timeZone
        
        let midnightOfToday = cal.dateFromComponents(comps)!
        
        
        if(CMMotionActivityManager.isActivityAvailable()){
            
            self.activityManager.startActivityUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (dat:CMMotionActivity?) in
            })
            self.activityManager.startActivityUpdatesToQueue(NSOperationQueue.mainQueue(), withHandler: { (data: CMMotionActivity?) in
                
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if(data!.stationary == true){
                        self.activityState.text = "Stationary"
                        self.stateImageView.image = UIImage(named: "Sitting")
                    } else if (data!.walking == true){
                        self.activityState.text = "Walking"
                        self.stateImageView.image = UIImage(named: "Walking")
                    } else if (data!.running == true){
                        self.activityState.text = "Running"
                        self.stateImageView.image = UIImage(named: "Running")
                    } else if (data!.automotive == true){
                        self.activityState.text = "Automotive"
                    }
                })
                
            })
        }
        if(CMPedometer.isStepCountingAvailable()){
            let fromDate = NSDate(timeIntervalSinceNow: -86400 * 7)
            self.pedoMeter.queryPedometerDataFromDate(fromDate, toDate: NSDate()) { (data : CMPedometerData?, error) in
                print(data)
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    if(error == nil){
                        self.steps.text = "\(data!.numberOfSteps)"
                    }
                })
                
            }
            
            self.pedoMeter.startPedometerUpdatesFromDate(midnightOfToday) { (data: CMPedometerData?, error) in
                dispatch_async(dispatch_get_main_queue(), { () in
                    if(error == nil){
                        self.steps.text = "\(data!.numberOfSteps)"
                    }
                })
            }
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    
}