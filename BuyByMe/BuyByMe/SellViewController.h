//
//  SellViewController.h
//  BuyByMe
//
//  Created by Andrew Rauh on 1/18/13.
//  Copyright (c) 2013 Andrew Rauh. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <MobileCoreServices/UTCoreTypes.h>


@interface SellViewController : UIViewController <UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate, UIActionSheetDelegate>
@property (nonatomic, strong) IBOutlet UITextField *titleItem;
@property (nonatomic, strong) IBOutlet UITextView *description;
@property (nonatomic, strong) IBOutlet UITextField *price;
@property (nonatomic, strong) IBOutlet UIImageView *picture;


-(IBAction)addOrTakePic:(id)sender;
-(IBAction)didPressDone:(id)sender;

@end
