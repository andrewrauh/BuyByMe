//
//  CompleteTransactionViewController.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "CompleteTransactionViewController.h"
#import "AppDelegate.h"

static NSString *const kVenmoAppId      = @"1220";
static NSString *const kVenmoAppSecret  = @"EmSsSkJWqcGywDCQYh9yfd59kKw5wehT";

@interface CompleteTransactionViewController ()

@end

@implementation CompleteTransactionViewController

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
    // Do any additional setup after loading the view, typically from a nib.
    AppDelegate *appDelegate = [[UIApplication sharedApplication]delegate];
    appDelegate.venmoClient = [VenmoClient clientWithAppId:kVenmoAppId secret:kVenmoAppSecret];
    
    venmoTransaction = [[VenmoTransaction alloc] init];
    venmoTransaction.type = VenmoTransactionTypePay;
    venmoTransaction.amount = [NSDecimalNumber decimalNumberWithString:@"3.45"];
    venmoTransaction.note = @"hello world";
    venmoTransaction.toUserHandle = @"mattdipasquale";
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
