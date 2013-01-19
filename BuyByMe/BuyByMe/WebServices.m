//
//  WebServices.m
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import "WebServices.h"

@implementation WebServices
@synthesize loggedInUser, allItems, delegate;
+(id)sharedInstance
{
    static id sharedInstance = nil;
    if (sharedInstance == nil) {
        sharedInstance = [[self alloc] init];
    }
    return sharedInstance;
}

-(void)retrieveAllPostedItems {
    
    NSURLRequest *main = [NSURLRequest requestWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"http://buybyme.herokuapp.com/api/api/api/item/"]]];
    
    allItems = [[NSMutableArray alloc]init];
    
    dispatch_queue_t queue = dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0);
    dispatch_async(queue, ^{
        NSURLResponse *response = nil;
        NSError *error = nil;
        NSData *data = [NSURLConnection sendSynchronousRequest:main
                                             returningResponse:&response
                                                         error:&error];
        
        NSString *json = [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
        
        id parsedObject = nil;
        NSError *parseError = nil;
        
        if (json != nil && [json isKindOfClass:[NSString class]] && [json length] > 0) {
            parsedObject = [NSJSONSerialization JSONObjectWithData:[json dataUsingEncoding:NSASCIIStringEncoding]
                                                           options:0
                                                             error:&parseError];
        }
        
        if ([parsedObject isKindOfClass:[NSArray class]]) {
            NSArray *parsedArray = (NSArray *)parsedObject;
            
            for (NSDictionary *dict in parsedArray) {
                Item *newItem = [[Item alloc]init];
                [newItem setTitle:[dict objectForKey:@"description"]];
                [allItems addObject:newItem];
//                [allItems addObject:[dict objectForKey:@"description"]];
//                NSLog(@"AllItems is %@",allItems);
                [[self delegate] reloadTableView];

            }
        }
       
    });
    
    NSLog(@"AllItems is %@",allItems);
        
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
