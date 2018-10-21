//
//  MPPointXY.h
//  MIAIOS
//
//  Created by Martin Hansen on 5/21/15.
//  Copyright (c) 2015-2018 MapsPeople A/S. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface MPPointXY : NSObject

@property (nonatomic) double X;
@property (nonatomic) double Y;
@property (nonatomic) double distance;
@property (nonatomic) CLLocationCoordinate2D latlng;

+ (CLLocationCoordinate2D) getRefPoint;

@end
