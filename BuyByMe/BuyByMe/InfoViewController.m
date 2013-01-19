//
//  InfoViewController.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "InfoViewController.h"
#import "WebServices.h"

static NSString *const kVenmoAppId      = @"1220";
static NSString *const kVenmoAppSecret  = @"EmSsSkJWqcGywDCQYh9yfd59kKw5wehT";

@interface InfoViewController ()

@end

@implementation InfoViewController
@synthesize venmoClient;

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
	// Do any additional setup after loading the view.
    // Do any additional setup after loading the view, typically from a nib.
    venmoClient = [VenmoClient clientWithAppId:kVenmoAppId secret:kVenmoAppSecret];
    
    venmoTransaction = [[VenmoTransaction alloc] init];
    venmoTransaction.type = VenmoTransactionTypePay;
    venmoTransaction.amount = [NSDecimalNumber decimalNumberWithString:@"3.45"];
    venmoTransaction.note = @"hello world";
    venmoTransaction.toUserHandle = @"mattdipasquale";
    
    // Create two buttons: one for Venmo...
    
     CGRect buttonRect = CGRectMake(40.0f, 20.0f, 90.0f, 40.0f);
     UIButton *venmoButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
     venmoButton.frame = buttonRect;
     [venmoButton setTitle:@"Venmo" forState:UIControlStateNormal];
     [venmoButton addTarget:self action:@selector(openVenmoAction)
     forControlEvents:UIControlEventTouchUpInside];
     [self.view addSubview:venmoButton];
     
}

- (void)openVenmoAction {
    VenmoViewController *venmoViewController = [venmoClient viewControllerWithTransaction:
                                                venmoTransaction];
    if (venmoViewController) {
        [self presentModalViewController:venmoViewController animated:YES];
    }
}

-(IBAction)pressBuy:(id)sender{
    WebServices *webServices = [WebServices sharedInstance];
    
    
    
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
