//
//  CompleteTransactionViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>

@interface CompleteTransactionViewController : UIViewController


@property (nonatomic, strong) PFObject *item;
@property (nonatomic, strong) PFObject *transaction;
@property (nonatomic, strong) PFFile *image;



@end
