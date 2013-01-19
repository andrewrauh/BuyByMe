//
//  ViewController.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "ViewController.h"
#import "InfoViewController.h"

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
	// Do any additional setup after loading the view, typically from a nib.
    
    locationManager = [[CLLocationManager alloc] init];
    [locationManager startUpdatingLocation];
    locationManager.delegate = self;

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void)locationManager:(CLLocationManager *)manager
    didUpdateToLocation:(CLLocation *)newLocation
           fromLocation:(CLLocation *)oldLocation
{
 //   NSLog(@"Location: %@", [newLocation description]);
    userLocation = newLocation;
}


- (void)locationManager:(CLLocationManager *)manager
       didFailWithError:(NSError *)error
{
	NSLog(@"Error: %@", [error description]);
}

//UITableViewMethods

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSLog(@"Number of rows called");
    // Return the number of rows in the section.
    return [webServices.allItems count];
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier];
    }
    [cell.imageView setImage:[UIImage imageNamed:@"chris2.png"]];
    NSLog(@"CFR: All items are %@", webServices.allItems);
    NSLog(@"CFR: Title is %@", [[webServices.allItems objectAtIndex:indexPath.row]title]);
    [cell.textLabel setText:[[webServices.allItems objectAtIndex:indexPath.row]title]];
    [cell.detailTextLabel setText:@""];
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    InfoViewController *controller = [self.storyboard instantiateViewControllerWithIdentifier:@"InfoVC"];
    [self.navigationController pushViewController:controller animated:YES];
}

- (void) reloadTableView{
    [tbView performSelectorOnMainThread:@selector(reloadData) withObject:self waitUntilDone:YES];
}


@end
