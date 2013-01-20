//
//  ViewController.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"
#import <Parse/Parse.h>

@interface ViewController ()
@property (nonatomic, strong) WebServices *webServices;
@end

@implementation ViewController
@synthesize tbView, userLocation, locationManager, webServices;

- (void)viewDidLoad
{
    NSLog(@"ViewDidLoad");
    [super viewDidLoad];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
    webServices = [WebServices sharedInstance];
    webServices.delegate =self;
    [webServices retrieveAllPostedItems];
    items = [[NSMutableArray alloc] init];
    
    
	// Do any additional setup after loading the view, typically from a nib.
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    locationManager.delegate = self;
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
    NSLog(@"Location: %@", [newLocation description]);
    userLocation = newLocation;
    [locationManager stopUpdatingLocation];
    [self geoSearch];
}

-(void)geoSearch{
    // User's location
    //PFObject *itemObject = [PFObject objectWithClassName:@"Item"];
    // Create a query for places
    PFQuery *query = [PFQuery queryWithClassName:@"Item"];
    // Interested in locations near user.
    PFGeoPoint *myGeoPoint = [PFGeoPoint geoPointWithLatitude:userLocation.coordinate.latitude longitude:userLocation.coordinate.longitude];
    [query whereKey:@"location" nearGeoPoint:myGeoPoint];
    // Limit what could be a lot of points.
    query.limit = 20;
    // Final list of objects
    items = [query findObjects];
    NSLog(@"items is %@", items);
    [tbView reloadData];
}
//UITableViewMethods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of rows called");
    // Return the number of rows in the section.
    return [items count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"chris2.png"]];
    PFObject *object = [items objectAtIndex:indexPath.row];
    NSString *title = [object objectForKey:@"title"];
    NSString *description = [object objectForKey:@"description"];
    //NSLog(@"CFR: All items are %@", webServices.allItems);
    //NSLog(@"CFR: Title is %@", [[webServices.allItems objectAtIndex:indexPath.row]title]);
    //[cell.textLabel setText:[[webServices.allItems objectAtIndex:indexPath.row]title]];
    //[cell.detailTextLabel setText:@""];
    [cell.textLabel setText:title];
    [cell.detailTextLabel setText:description];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    InfoViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoVC"];
    [controller setSelectedItem:[webServices.allItems objectAtIndex:indexPath.row]];
    [controller setUserLocation:userLocation];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) reloadTableView{
    [tbView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:YES];
}


@end
