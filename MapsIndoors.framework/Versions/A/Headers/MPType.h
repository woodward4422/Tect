//
//  MPType.h
//  MapsIndoors for iOS
//
//  Created by Martin Hansen on 7/23/15.
//  Copyright (c) 2015 MapsPeople A/S. All rights reserved.
//

#import "MPJSONModel.h"
#import "MPLocationDisplayRule.h"

/**
 POI types (used by MapsPeoples services)
 */
@interface MPType : MPJSONModel

@property (nonatomic, strong, nullable) NSString* name;
@property (nonatomic, strong, nullable) NSString* icon;
@property (nonatomic, strong, nullable) MPLocationDisplayRule<Optional>* displayRule;

@end
