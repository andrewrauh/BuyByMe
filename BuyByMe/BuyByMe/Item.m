//
//  Item.m
//  BuyByMe
//
//  Created by Chris Wendel on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "Item.h"

@implementation Item
@synthesize title, description, category, cat, originalLocation, isNegotiable, price, poster, posted_date, end_date, picture, posterId;

-(void)convertStringToCategory:(NSString*)category_string{
    Category categor;
    if([category_string caseInsensitiveCompare:@"technology"]){
        cat = kTechnology;
        categor = kTechnology;
    }

}

@end
