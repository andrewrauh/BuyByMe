//
//  InfoViewController.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "InfoViewController.h"
#import "WebServices.h"
#import "AppDelegate.h"
#import <Parse/Parse.h>

static NSString *const kVenmoAppId      = @"1220";
static NSString *const kVenmoAppSecret  = @"EmSsSkJWqcGywDCQYh9yfd59kKw5wehT";

@interface InfoViewController ()
@property (nonatomic, strong) User *sellingUser;

@end

@implementation InfoViewController
@synthesize selectedItem, userLocation, sellingUser;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.navigationItem.title = @"";
	// Do any additional setup after loading the view.
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.venmoClient = [VenmoClient clientWithAppId:kVenmoAppId secret:kVenmoAppSecret];
    
    venmoTransaction = [[VenmoTransaction alloc] init];
    venmoTransaction.type = VenmoTransactionTypePay;
    venmoTransaction.amount = [NSDecimalNumber decimalNumberWithString:@"3.45"];
    venmoTransaction.note = @"hello world";
    venmoTransaction.toUserHandle = @"mattdipasquale";
    
    
     CGRect buttonRect = CGRectMake(40.0f, 20.0f, 90.0f, 40.0f);
     UIButton *venmoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     venmoButton.frame = buttonRect;
     [venmoButton setTitle:@"Venmo" forState:UIControlStateNormal];
     [venmoButton addTarget:self action:@selector(openVenmoAction)
     forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:venmoButton];
     
}

- (void)openVenmoAction {
    [self checkLocations];
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    VenmoViewController *venmoViewController = [appDelegate.venmoClient viewControllerWithTransaction:
                                                venmoTransaction];
    if (venmoViewController) {
        [self presentModalViewController:venmoViewController animated:YES];
    }
}

-(IBAction)pressBuy:(id)sender{
    // set Item to inactive
    PFObject *item = [PFObject objectWithClassName:@"Item"];
    [item setObject:[NSNumber numberWithBool:NO] forKey:@"active"];
    [item saveInBackground];
    
    //and create new transaction
    PFObject *newTransaction = [PFObject objectWithClassName:@"Transaction"];
    
    
    [newTransaction setObject:[Item valueForKey:@"poster"] forKey:@"seller"];
    [newTransaction setObject:[PFUser currentUser] forKey:@"buyer"];
    [newTransaction setObject:item forKey:@"item"];
    [newTransaction setObject:[NSNumber numberWithBool:NO] forKey:@"pending"];
    [newTransaction setObject:[item valueForKey:@"price"] forKey:@"price"];
    [newTransaction saveInBackground];
}

-(void)checkLocations{
    CLLocation *otherUserLocation = [[CLLocation alloc] initWithLatitude:36.164488 longitude:-86.781006];
    CLLocationDistance distance = [userLocation distanceFromLocation:otherUserLocation];
    if(distance > 1000){
        NSLog(@"They are more than 1000 meters away from one another");
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
