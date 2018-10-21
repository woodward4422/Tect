//
//  SMSService.swift
//  MIAIOSUITests
//
//  Created by Noah Woodward on 10/20/18.
//  Copyright © 2018 MapsPeople A/S. All rights reserved.
//

import Foundation
import Alamofire

struct SMSService {
    public static func SMSSend(message: String){
        let parameters: Parameters = [
            "From":Constants.twilioFromNumber,
            "To": Constants.twilioToNumber,
            "Body": message]
        
        Alamofire.request(Constants.twilioURL, method: .post, parameters: parameters)
            .authenticate(user: Constants.twilioSID , password:Constants.twilioAuth)
            .responseJSON { response in
                debugPrint(response)
                
        }
        
    }
}
