//
//  FirstViewController.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "FirstViewController.h"

@interface FirstViewController ()
@property(nonatomic, strong) IBOutlet UILabel *label;

@end

@implementation FirstViewController
@synthesize label;

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
    NSLog(@"ViewDIdLoad on first view controller");
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"top_bar"]
                                                  forBarMetrics:UIBarMetricsDefault];

    UIFont* font = [UIFont fontWithName:@"Novecentowide-Book" size:22];
    
    [label setFont:font];

    //157 54
    
	// Do any additional setup after loading the view.
}

-(void)viewDidAppear:(BOOL)animated {

}

-(IBAction)didPressBuy:(id)sender {
    
}

-(IBAction)didPressSell:(id)sender {
    
}

-(IBAction)didPressProfile:(id)sender {
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
