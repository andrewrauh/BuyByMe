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
#import <Parse/Parse.h>

@interface InfoViewController : UIViewController{
    
    VenmoTransaction            *venmoTransaction;
    CLLocation                  *userLocation;
    NSString                    *itemId;
    
}

@property (nonatomic, strong)  Item *selectedItem;
@property (nonatomic, strong) IBOutlet UIImageView *pic;
@property (nonatomic, strong) IBOutlet UILabel *titleL;
@property (nonatomic, strong) IBOutlet UITextView *descript;
@property (nonatomic, strong) IBOutlet UILabel *priceL;
@property (nonatomic, strong) NSString *itemId;
@property (nonatomic, strong) CLLocation *userLocation;
@property (nonatomic, strong) PFObject *item;

-(IBAction)pressBuy:(id)sender;
-(void)checkLocations;

@end
