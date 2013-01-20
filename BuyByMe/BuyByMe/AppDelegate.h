//
//  AppDelegate.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Venmo/Venmo.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    VenmoClient                 *venmoClient;
}

@property (nonatomic, strong) VenmoClient *venmoClient;
@property (strong, nonatomic) UIWindow *window;

@end
