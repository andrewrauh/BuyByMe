//
//  CompleteTransactionViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>
<<<<<<< HEAD
#import <Venmo/Venmo.h>
@interface CompleteTransactionViewController : UIViewController{
    
    VenmoTransaction            *venmoTransaction;
    
}

@interface CompleteTransactionViewController : UIViewController
@property (nonatomic, strong) IBOutlet UIImageView *pic;
@property (nonatomic, strong) IBOutlet UILabel *titleLabel;
@property (nonatomic, strong) IBOutlet UITextView *description;
@property (nonatomic, strong) IBOutlet UILabel *priceLabel;

@end
