//
//  ViewController.swift
//  BahamaAirChapte4
//
//  Created by Junna on 3/3/16.
//  Copyright © 2016 Junna. All rights reserved.
//

import UIKit

func delay(seconds seconds: Double, completion:()->()) {
    let popTime = dispatch_time(DISPATCH_TIME_NOW, Int64( Double(NSEC_PER_SEC) * seconds ))
    
    dispatch_after(popTime, dispatch_get_main_queue()) {
        completion()
    }
}
class ViewController: UIViewController {

    @IBOutlet weak var bgImage: UIImageView!
    @IBOutlet weak var time: UILabel!
    @IBOutlet weak var departingFrom: UILabel!
    @IBOutlet weak var arrivingTo: UILabel!
    @IBOutlet weak var flight: UILabel!
    @IBOutlet weak var gate: UILabel!
    @IBOutlet weak var status: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        changeFlightDataTo(parisToRome)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func changeFlightDataTo(data: FlightData) {
        time.text = data.summary
        flight.text = data.flightNr
        gate.text = data.gateNr
        departingFrom.text = data.departingFrom
        arrivingTo.text = data .arrivingTo
        status.text = data.flightStatus
        bgImage.image = UIImage(named: data.weatherImageName)
        
        delay(seconds: 3.0) { () -> () in
            self.changeFlightDataTo(data.isTakingOff ? parisToRome : londonToParis)
        }
        
    }


}



