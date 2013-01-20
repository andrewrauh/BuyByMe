//
//  InfoViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Venmo/Venmo.h>
#import "Item.h"

@interface InfoViewController : UIViewController{
    
    VenmoTransaction            *venmoTransaction;
    CLLocation                  *userLocation;
    
}

@property (nonatomic, strong)  Item *selectedItem;
@property (nonatomic, strong) CLLocation *userLocation;

-(IBAction)pressBuy:(id)sender;
-(void)checkLocations;

@end
