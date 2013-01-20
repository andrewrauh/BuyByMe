//
//  User.h
//  BuyByMe
//
//  Created by Chris Wendel on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject{
    
    NSString *venmoId;
    NSString *firstname;
    NSString *lastname;
    bool isBuyer;
    bool isVerified;
    UIImage *profilePic;
    
}

@property(nonatomic,retain) NSString *venmoId;
@property(nonatomic,retain) NSString *firstname;
@property(nonatomic, retain) NSString *lastname;
@property(nonatomic) bool isBuyer;
@property(nonatomic) bool isVerified;
@property(nonatomic, retain) UIImage *profilePic;

@end
