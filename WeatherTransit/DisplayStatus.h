//
//  DisplayStatus.h
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface DisplayStatus : NSObject

@property NSString *Headline;
@property NSString *ShortDescription;
@property NSString *fullDescription;
@property NSString *severityColor;
@property NSString *severityCSS;
@property NSString *impact;
@property NSString *eventStart;
@property NSString *eventEnd;
@property NSString *alertURL;
@property NSString *serviceType;
@property NSString *serviceTypeDescription;
@property NSString *serviceName;
@property NSString *ServiceId;
@property NSString *serviceBackColor;
@property NSString *serviceURL;

-(instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
