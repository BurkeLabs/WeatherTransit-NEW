//
//  BusStopViewController.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "BusStopViewController.h"
#import "BusStopViewController.h"
#import "UpcomingViewController.h"
#import "BusStops.h"
#import "BusStopService.h"

@interface BusStopViewController () <UISearchBarDelegate, UITableViewDelegate, UITableViewDataSource, NSXMLParserDelegate>

@property (weak, nonatomic) IBOutlet UISearchBar *stopSearch;
@property (weak, nonatomic) IBOutlet UITableView *stopsTableView;

@property NSArray *busStopArray; // XML
@property NSMutableArray *busStopSearchArray; //Search Results
@property NSArray *stopArray; // bus stops from either busStopArray or busStopSearchArray

@end

@implementation BusStopViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.stopSearch.delegate = self;
    self.stopsTableView.delegate = self;
    [self loadBusStopData];
    [self.stopsTableView reloadData];
}

-(void)loadBusStopData{
    NSMutableArray *busStopArray = [NSMutableArray new];
    [busStopArray addObjectsFromArray:[BusStopService loadStopsWithRoute:self.busName.route direction:@"Northbound"]];
    [busStopArray addObjectsFromArray:[BusStopService loadStopsWithRoute:self.busName.route direction:@"Southbound"]];
    [busStopArray addObjectsFromArray:[BusStopService loadStopsWithRoute:self.busName.route direction:@"Eastbound"]];
    [busStopArray addObjectsFromArray:[BusStopService loadStopsWithRoute:self.busName.route direction:@"Westbound"]];

    self.busStopArray = busStopArray;

    // step 2: move the http req & xml parser to a separate class
    //    for (NSString *direction in BusStopService) {
    //        [BusStopService appendStopsTo:self.busStopArray route:self.busName.route direction:direction];
    //    }
    //    self.busStopArray = [BusStopService loadStopsWithRoute:self.busName.route direction:@"Eastbound"];
    //    self.busStopArray = [BusStopService loadStopsWithRoute:self.busName.route direction:@"Westbound"];
    //    self.busStopArray = [BusStopService loadStopsWithRoute:self.busName.route direction:@"Northbound"];
    //    self.busStopArray = [BusStopService loadStopsWithRoute:self.busName.route direction:@"Southbound"];

    // step 3: load all the directions
    // self.busStopArray = [NSMutableArray new];
    // NSArray *directions = [BusRouteDirectionService loadDirectionsForRoute: self.busName.route];
    // for(NSString *direction in directions)
    //   [BusStopService appendStopsTo:self.busStopArray route:self.busName.route direction:direction];


    self.stopArray = self.busStopArray;
}

#pragma mark - UISearchBarDelegate
-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText{
    if (searchText.length > 0) {
        self.busStopSearchArray = [NSMutableArray new];
        for (BusStops *stops in self.busStopArray) {
            NSRange range = [stops.stopName rangeOfString:searchText options:NSCaseInsensitiveSearch];
            if (range.location != NSNotFound) {
                [self.busStopSearchArray addObject:stops];
            }
        }
        self.stopArray = self.busStopSearchArray;
    } else {
        self.stopArray = self.busStopArray;
    }
    [self resignFirstResponder];
    [self.stopsTableView reloadData];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Stops"];
    BusStops *busStops = [self.stopArray objectAtIndex:indexPath.row];
    cell.textLabel.text = busStops.stopName;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%d", busStops.stopID];
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.stopArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    UpcomingViewController *upcomingVC = segue.destinationViewController;
    BusStops *busStopNew = [self.stopArray objectAtIndex:self.stopsTableView.indexPathForSelectedRow.row];
    upcomingVC.busStopNew = busStopNew;
}

@end
