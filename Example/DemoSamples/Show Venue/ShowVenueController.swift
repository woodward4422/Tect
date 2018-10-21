//
//  ViewController.swift
//  SimpleMapSwift
//
//  Created by Daniel Nielsen on 25/01/2018.
//  Copyright © 2018 MapsPeople A/S. All rights reserved.
//

import UIKit
import GoogleMaps
import MapsIndoors
import PureLayout

class ShowVenueController: UIViewController, MPMapControlDelegate {
    
    var map: GMSMapView? = nil
    var mapControl: MPMapControl? = nil
    var emergencyTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        self.map = GMSMapView.init(frame: CGRect.zero)
        
        self.view = self.map
        
        
        
        let emergencyTextFieldFrame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 30.0)
        emergencyTextField = UITextField(frame: emergencyTextFieldFrame)
        emergencyTextField.autoPinEdgetosuperviewEdge
        self.view.addSubview(emergencyTextField)
        
        self.map?.camera = .camera(withLatitude: 57.057964, longitude: 9.9504112, zoom: 20)
        
        self.mapControl = MPMapControl.init(map: self.map!)
        
        self.mapControl?.delegate = self
    }
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        self.view.bringSubview(toFront: emergencyTextField)
    }
    
    func mapContentReady() {
        self.mapControl?.venue = "rtx"
    }
}
