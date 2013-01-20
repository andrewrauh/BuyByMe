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
@synthesize tbView, userLocation, locationManager, webServices, filteredItemArray, itemSearchBar;

- (void)viewDidLoad
{
    NSLog(@"ViewDidLoad");
    [super viewDidLoad];
    self.tbView.delegate = self;
    self.tbView.dataSource = self;
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
    self.filteredItemArray = [NSMutableArray arrayWithCapacity:[items count]];

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
    if (tableView == self.searchDisplayController.searchResultsTableView) {
        return [filteredItemArray count];
    } else {
        return [items count];
    }
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    PFObject *object;
    if (tableView == self.searchDisplayController.searchResultsTableView) {
       object = [filteredItemArray objectAtIndex:indexPath.row];
    } else {
        object = [items objectAtIndex:indexPath.row];
    }
    PFFile *img = [object objectForKey:@"image"];
    if (img) {
        NSData *imgData = [img getData];
        [cell.imageView setImage:[UIImage imageWithData:imgData] ];
    } else {
        [cell.imageView setImage:[UIImage imageNamed:@"chris2.png"]];
    }

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
    // Check to see whether the normal table or search results table is being displayed and return the count from the appropriate array
    if (tableView == self.searchDisplayController.searchResultsTableView) 
        [self performSegueWithIdentifier:@"itemDetail" sender:tableView];
    else{
        NSIndexPath *indexPath = [self.tbView indexPathForSelectedRow];
        PFObject *itemObject = [items objectAtIndex:indexPath.row];
        NSString *itemId = itemObject.objectId;
        [controller setItemId:itemId];

        [self.navigationController pushViewController:controller animated:YES];
    }
}

- (void) reloadTableView{
    [tbView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:YES];
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredItemArray removeAllObjects];
    // Filter the array using NSPredicate
    NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.title contains[c] %@",searchText];
    filteredItemArray = [NSMutableArray arrayWithArray:[items filteredArrayUsingPredicate:predicate]];
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    // Tells the table data source to reload when text changes
    [self filterContentForSearchText:searchString scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:[self.searchDisplayController.searchBar selectedScopeButtonIndex]]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:
     [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption]];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


#pragma mark - Segue
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if ([[segue identifier] isEqualToString:@"itemDetail"]) {
        InfoViewController *itemDetailViewController = [segue destinationViewController];
        // In order to manipulate the destination view controller, another check on which table (search or normal) is displayed is needed
            NSIndexPath *indexPath = [self.searchDisplayController.searchResultsTableView indexPathForSelectedRow];
        PFObject *itemObject = [filteredItemArray objectAtIndex:indexPath.row];
        NSString *itemId = itemObject.objectId;
        [itemDetailViewController setItemId:itemId];
    }
}

@end
