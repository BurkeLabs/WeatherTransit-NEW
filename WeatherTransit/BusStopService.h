//
//  BusStopService.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>

@interface BusStopService : NSObject

+(NSArray*)loadStopsWithRoute:(NSString*)route direction:(NSString*)direction;

@end
