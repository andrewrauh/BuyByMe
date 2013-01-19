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


@protocol ProcessDataDelegate <NSObject>
@required

- (void) reloadTableView;

@end


@interface WebServices : NSObject {
    User *loggedInUser;
    NSMutableArray *allItems;
    id <ProcessDataDelegate> delegate;

}

@property(nonatomic, strong) User *loggedInUser;
@property (nonatomic, strong) NSMutableArray *allItems;
@property (strong, nonatomic) id delegate;
@property (strong,nonatomic) NSMutableDictionary *sellingUser;


+(id)sharedInstance;
-(void)retrieveAllPostedItems;
-(void)retrieveAllUserData;
-(void)sendNewItemToServer:(Item*)newItem;
-(void)retrieveSellerUserData:(NSString*)postedID;

@end
