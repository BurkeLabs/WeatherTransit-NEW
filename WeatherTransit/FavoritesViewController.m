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
#import "FavoritedBus+CoreDataProperties.h"

@interface FavoritesViewController () <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, retain) NSMutableArray *favorited;
@property (nonatomic, retain) IBOutlet UITableView *tableView;
@property NSManagedObjectContext *moc;
//@property NSArray *favorites;

@end

@implementation FavoritesViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    AppDelegate *delegate = (AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.moc = delegate.managedObjectContext;

    self.favorited = [NSMutableArray new];
    [self load];
}

//-(void)populateBusListIfEmpty {
//    if (self.favorited.count <=0) {
//        for (BusName *favoritedBusName in self.busName) {
//            NSManagedObject *busList = [NSEntityDescription insertNewObjectForEntityForName:@"FavoritedBus" inManagedObjectContext:self.moc];
//            [busList setValue:favoritedBusName.route forKey:@"route"];
//            [busList setValue:favoritedBusName.routeName forKey:@"routeName"];
//            [self.moc save:nil];
//            [self load];
//        }
//    }
//}

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

#pragma mark - loading busses
-(void)load{
    NSSortDescriptor *sortDescriptor = [[NSSortDescriptor alloc] initWithKey:@"route" ascending:NO];
    NSFetchRequest *request = [[NSFetchRequest alloc] initWithEntityName:@"FavoritedBus"];
    request.sortDescriptors = @[sortDescriptor];
    NSArray *favorites;
    favorites = [self.moc executeFetchRequest:request error:nil];

    for (FavoritedBus *favoritedBus in favorites) {
        BusName *busName = [BusName new];
        busName.route = favoritedBus.route;
        busName.routeName = favoritedBus.routeName;
        // ...
        [self.favorited addObject:busName];
    }
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
    NSManagedObject *storeBus = [NSEntityDescription insertNewObjectForEntityForName:@"FavoritedBus" inManagedObjectContext:self.moc];
    [storeBus setValue:value.route forKey:@"route"];
    [storeBus setValue:value.routeName forKey:@"routeName"];
    [self.moc save:nil];
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
