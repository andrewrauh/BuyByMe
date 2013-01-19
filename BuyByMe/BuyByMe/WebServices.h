//
//  WebServices.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Item.h"

@interface WebServices : NSObject

-(void)retrieveAllPostedItems;
-(void)sendNewItemToServer:(Item*)newItem;

@end
