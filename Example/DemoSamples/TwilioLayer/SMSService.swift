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
            "Parameters":"{\"Body\":\"\(message)\"}"]
        
        Alamofire.request("https://studio.twilio.com/v1/Flows/FWc63377a30d6493bed1b198ebd4333d86/Executions", method: .post, parameters: parameters, encoding: URLEncoding.httpBody)
            .authenticate(user: Constants.twilioSID , password:Constants.twilioAuth)
            .responseJSON { response in
                debugPrint(response)
                
        }
        
    }
}
