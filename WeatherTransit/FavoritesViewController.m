//
//  FavoritesViewController.m
//  WeatherTransit
//
//  Created by Michelle Burke on 4/18/17.
//  Copyright © 2017 BurkeLabs. All rights reserved.
//

#import "FavoritesViewController.h"
#import "BusTrackerViewController.h"
#import "AppDelegate.h"
#import "BusStopViewController.h"

//#import <CoreData/NSEntityDescription.h>
//#import <CoreData/NSManagedObject.h>
//#import <CoreData/NSManagedObjectContext.h>
//#import <CoreData/NSFetchRequest.h>

@interface FavoritesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *favorited;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property NSManagedObjectContext *moc;
@property NSArray *favorites;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    self.favorited = [NSMutableArray new];
    [self load];
    [BusName retrieveBusWithCompletion:^(NSMutableArray *busList){
        self.favorited = busList;
        [self populateBusListIfEmpty];
    }];
    self.favorites = self.favorited;
}

-(void)populateBusListIfEmpty {
    if (self.favorited.count <=0) {
        for (BusName *favoritedBusName in self.busName) {
            NSManagedObject *busList = [NSEntityDescription insertNewObjectForEntityForName:@"BusName" inManagedObjectContext:self.moc];
            [busList setValue:favoritedBusName.route forKey:@"route"];
            [busList setValue:favoritedBusName.routeName forKey:@"routeName"];
            [self.moc save:nil];
            [self load];
        }
    }
}

-(void)showBusList:(NSMutableArray *)bus{
    bus = bus;
    [self.tableView reloadData];
}

#pragma mark - adding busses
- (IBAction)onAddButtonPressed:(UIBarButtonItem *)sender {
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
    BusTrackerViewController *busListVC = [storyboard instantiateViewControllerWithIdentifier:@"BusList"];
    busListVC.delegate = self;
    busListVC.modalPresentationStyle = UIModalPresentationFullScreen;
    [self presentViewController:busListVC animated:YES completion:nil];
}

-(void)load{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"route" ascending:NO];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"routeName"];
    request.sortDescriptors = @[sortDescriptor];
    self.favorites = [self.moc executeFetchRequest:request error:nil];
}

#pragma mark - UITableViewDataSource and UITableViewDelegate
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"favorite"];
    BusName *busName = [self.favorited objectAtIndex:indexPath.row];
    cell.textLabel.text = busName.route;
    cell.detailTextLabel.text = busName.routeName;
    return cell;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.favorited.count;
}

-(void)busTrackerViewController:(BusTrackerViewController *)viewController didChooseValue:(BusName *)value{
    [self.favorited addObject:value];
    [self.tableView reloadData];
}

#pragma mark - Navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    BusStopViewController *busStopVC = segue.destinationViewController;
    BusName *busName = [self.favorited objectAtIndex:self.tableView.indexPathForSelectedRow.row];
    busStopVC.busName = busName;
}

@end
