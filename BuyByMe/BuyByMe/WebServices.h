//
//  WebServices.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"
#import "User.h"

@interface WebServices : NSObject {
    User *loggedInUser;
}

@property(nonatomic, strong) User *loggedInUser;

-(void)retrieveAllPostedItems;
-(void)retrieveAllUserData;
-(void)sendNewItemToServer:(Item*)newItem;

@end
