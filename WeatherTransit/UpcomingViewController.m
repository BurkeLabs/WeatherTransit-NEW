//
//  UpcomingViewController.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "UpcomingViewController.h"
#import "Upcoming.h"

@interface UpcomingViewController () <UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate> {
    NSDateFormatter *dateFormatter;
    NSDateFormatter *timeFormatter;
}

@property (weak, nonatomic) IBOutlet UITableView *upcomingTableView;

@property NSMutableArray *upcomingArray;
@property NSXMLParser *busTimes;
@property Upcoming *up;
//@property NSDateFormatter *timeFormatter;
//@property NSDateFormatter *dateFormatter;

typedef enum {
    NONE, stpid, vid, msg, tmstmp, stpnm, dstp, rt, rtdir, des, prdtm, rtdst, dly,
} Prediction;

@property Prediction currentField;

@end

@implementation UpcomingViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    NSLog(@"%@ loading with busStopNew = %@", self, self.busStopNew);
    [self loadUpcomingBusData];
}

-(void)loadUpcomingBusData{
    self.upcomingArray = [NSMutableArray new];
    self.up = NULL;
    self.currentField = 0;

    BOOL success;
    NSString *url = [NSString stringWithFormat:@"http://www.ctabustracker.com/bustime/api/v1/getpredictions?key=Awu5sVzWPUXFske5WVnHMyDgF&stpid=%d", self.busStopNew.stopID];
    NSLog(@"request link %@", url);
    NSURL *xmlURL = [NSURL URLWithString: url];

    self.busTimes = [[NSXMLParser alloc] initWithContentsOfURL:xmlURL];
    [self.busTimes setDelegate:self];
    success = [self.busTimes parse];
    NSLog(@"%@", self.upcomingArray);
    [self.upcomingTableView reloadData];
}

-(void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName attributes:(NSDictionary<NSString *,NSString *> *)attributeDict{
    NSLog(@"START ELEMENT %@", elementName);
    if ([elementName isEqual:@"prd"]) {
        self.up = [Upcoming new];
    } else if (self.up) {
        if ([elementName isEqual:@"stpid"]) {
            self.currentField = stpid;
        } else if ([elementName isEqual:@"stpnm"]){
            self.currentField = stpnm;
        } else if ([elementName isEqual:@"vid"]){
            self.currentField = vid;
        } else if ([elementName isEqual:@"rtdir"]){
            self.currentField = rtdir;
        } else if ([elementName isEqual:@"rt"]){
            self.currentField = rt;
        } else if ([elementName isEqual:@"rtdst"]){
            self.currentField = rtdst;
        } else if ([elementName isEqual:@"prdtm"]){
            self.currentField = prdtm;
        } else if ([elementName isEqual:@"dly"]){
            self.currentField = dly;
        }
    }
}

-(void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    // NSLog(@"END ELEMENT %@", elementName);
    if ([elementName isEqual:@"prd"]) {
        [self.upcomingArray addObject:self.up];
        self.up = NULL;
    } else {
        self.currentField = NONE;
    }
}

-(void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string{
    NSDateFormatter *fmt = [NSDateFormatter new];
    fmt.dateFormat = @"yyyyMMdd HH:mm";
    // NSLog(@"CHARS \"%@\"", string);
    if (self.up) {
        switch (self.currentField) {
            case stpid:
                self.up.stopID = [string intValue];
                break;
            case vid:
                self.up.vehicleID = string;
                break;
            case msg:
                self.up.message = string;
                break;
            case tmstmp:
                self.up.timeStamp = string;
                break;
            case stpnm:
                self.up.stopName = string;
                break;
            case dstp:
                self.up.destinationPoint = [string intValue];
                break;
            case rt:
                self.up.route = string;
                break;
            case rtdir:
                self.up.routeDirection = string;
                break;
            case des:
                self.up.destination = string;
                break;
            case prdtm:
                self.up.predictionTime = [fmt dateFromString:string];
                break;
            case rtdst:
                self.up.routeDestination = string;
                break;
            case dly:
                self.up.delay = YES;
                break;
            case NONE:
                break;
            default:
                break;
        }
    }
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Upcoming"];
    Upcoming *upcomingBus = [self.upcomingArray objectAtIndex:indexPath.row];

    if (!dateFormatter) {
        dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setLocale:[NSLocale currentLocale]];
        [dateFormatter setDateStyle:NSDateFormatterLongStyle];
    }

    if (!timeFormatter) {
        timeFormatter = [[NSDateFormatter alloc] init];
        [timeFormatter setTimeStyle:NSDateFormatterShortStyle];
    }

    cell.textLabel.text = [timeFormatter stringFromDate:upcomingBus.predictionTime];
    cell.detailTextLabel.text = upcomingBus.routeDirection;

    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.upcomingArray.count;
}

@end
