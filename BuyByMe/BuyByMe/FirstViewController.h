//
//  FirstViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CLController.h"
#import <Parse/Parse.h>

@interface FirstViewController : UIViewController<PFLogInViewControllerDelegate, PFSignUpViewControllerDelegate>
    
-(IBAction)didPressBuy:(id)sender;
-(IBAction)didPressSell:(id)sender;
-(IBAction)didPressProfile:(id)sender;

@end
