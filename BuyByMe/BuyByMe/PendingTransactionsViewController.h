//
//  PendingTransactionsViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/19/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PendingTransactionsViewController : UIViewController <UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, retain) NSArray *pendingTransactions;
@property (nonatomic, retain) IBOutlet UITableView *mytableView;
@end
