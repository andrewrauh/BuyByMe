//
//  WebServices.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices
@synthesize loggedInUser;

+(id)sharedInstance
{
    static id sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

-(void)retrieveAllPostedItems {
    
    
}

-(void)retrieveAllUserData {
    
}


-(void)sendNewItemToServer:(Item*)newItem {
  
    
}

- (NSData *) takeNewItemAndCreateJSON:(Item*)newItem
{
    NSDictionary *jsonDictionary = [NSDictionary dictionaryWithObjectsAndKeys:newItem.description,@"description", newItem.price, @"price", newItem.title, @"title", nil];
    
    NSMutableData *jsonData = [[NSMutableData alloc] init];
    NSKeyedArchiver *archiver = [[NSKeyedArchiver alloc] initForWritingWithMutableData:jsonData];
    [archiver encodeObject:jsonDictionary forKey:@"item"];
    
    NSData *data = [NSJSONSerialization JSONObjectWithData:jsonData options:NSJSONReadingMutableContainers error:nil];
    return data;
}


@end
