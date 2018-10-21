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
        
        SMSService.SMSSend(message:"Sup Homie")
        self.map = GMSMapView.init(frame: CGRect.zero)
        let emergencyTextFieldFrame = CGRect(x: 0.0, y: 0.0, width: 100.0, height: 30.0)
        emergencyTextField = UITextField(frame: emergencyTextFieldFrame)
        self.view.addSubview(emergencyTextField)
        emergencyTextField.autoPinEdge(toSuperviewEdge: .top, withInset: 50)
        emergencyTextField.autoPinEdge(toSuperviewEdge: .left, withInset: 15)
        emergencyTextField.autoPinEdge(toSuperviewEdge: .right, withInset: 15)
        emergencyTextField.heightAnchor.constraint(equalToConstant: 50).isActive = true
        emergencyTextField.text = "Hey"
        
        self.view.addSubview(self.map!)
        self.map?.autoPinEdge(toSuperviewEdge:.top)
        self.map?.autoPinEdge(toSuperviewEdge: .right)
        self.map?.autoPinEdge(toSuperviewEdge: .bottom)
        self.map?.autoPinEdge(toSuperviewEdge: .left)
        
        
        
        
        
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
