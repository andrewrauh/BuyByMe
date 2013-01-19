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
    
    VenmoClient                 *venmoClient;
    VenmoTransaction            *venmoTransaction;
    
}

@property (nonatomic, strong) VenmoClient *venmoClient;
@property (nonatomic, strong)  Item *selectedItem;

-(IBAction)pressBuy:(id)sender;

@end
