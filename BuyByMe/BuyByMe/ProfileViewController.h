//
//  ProfileViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ProfileViewController : UIViewController
@property(nonatomic,retain) UIImageView *profileImage;
@property(nonatomic, retain) UILabel *nameLabel;

-(IBAction)pressedVenmoButton:(id)sender;
@end
