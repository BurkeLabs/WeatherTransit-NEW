//
//  BusStopService.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "BusStopService.h"
#import "BusStops.h"

@interface BusStopService () <NSXMLParserDelegate>

@property NSString *route;
@property NSString *direction;
@property NSMutableArray *stops;
@property BusStops *busStops;

typedef enum {
    NONE,
    rt,
    dir,
    stpid,
    stpnm,
} StopField;

@property StopField currentField;


@end

@implementation BusStopService

+(NSArray*)loadStopsWithRoute:(NSString*)route direction:(NSString*)direction {
    BusStopService *service = [BusStopService newWithRoute:route direction:direction];
    return [service result];
}

+(BusStopService*)newWithRoute:(NSString*)route direction:(NSString*)direction {
    return [[BusStopService alloc] initWithRoute:route direction:direction];
}

-(BusStopService*)initWithRoute:(NSString*)route direction:(NSString*)direction {
    self.route = route;
    self.direction = direction;
    return self;
}

-(NSArray*)result {
    if (self.stops == NULL) {
        BOOL success;
        NSURL *xmlURL = [NSURL URLWithString:[NSString stringWithFormat:@"http://www.ctabustracker.com/bustime/api/v1/getstops?key=Awu5sVzWPUXFske5WVnHMyDgF&rt=%@&dir=%@", self.route, self.direction]];

        self.stops = [NSMutableArray new];
        NSXMLParser *busStop = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
        [busStop setDelegate:self];
        success = [busStop parse];
    }
    return self.stops;
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary *)attributeDict{
    // NSLog(@"START ELEMENT %@", elementName);
    if ([elementName isEqual:@"stop"]) {
        self.busStops = [BusStops new];
    } else if (self.busStops) {
        if ([elementName isEqual:@"rt"]) {
            self.currentField = rt;
        } else if ([elementName isEqual:@"dir"]){
            self.currentField = dir;
        } else if ([elementName isEqual:@"stpid"]) {
            self.currentField = stpid;
        } else if ([elementName isEqual:@"stpnm"]) {
            self.currentField = stpnm;
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName{
    // NSLog(@"END ELEMENT %@", elementName);
    if ([elementName isEqual:@"stop"]) {
        [self.stops addObject:self.busStops];
        self.busStops = NULL;
    } else {
        self.currentField = NONE;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    // NSLog(@"CHARS \"%@\"", string);
    if (self.busStops) {
        switch (self.currentField) {
            case rt:
                self.busStops.route = string;
                break;
            case dir:
                self.busStops.direction = string;
                break;
            case stpid:
                self.busStops.stopID = [string intValue];
                break;
            case stpnm:
                self.busStops.stopName = string;
                break;
            case NONE:
                break;
            default:
                break;
        }
    }
}

@end
