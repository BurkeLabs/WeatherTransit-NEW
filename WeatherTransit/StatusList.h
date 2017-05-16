//
//  StatusList.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StatusList : NSObject

@property NSString *Route;
@property NSString *RouteColorCode;
@property NSString *RouteTextColor;
@property NSString *ServiceId;
@property NSString *RouteURL;
@property NSString *RouteStatus;
@property NSString *RouteStatusColor;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
