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
    NSString *name;
    bool isBuyer;
    bool isVerified;
    
}

@property(nonatomic,retain) NSString *venmoId;
@property(nonatomic,retain) NSString *name;
@property(nonatomic) bool isBuyer;
@property(nonatomic) bool isVerified;

@end
