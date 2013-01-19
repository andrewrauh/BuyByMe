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
@property (nonatomic, strong) UITextField *titleItem;
@property (nonatomic, strong) UITextView *description;
@property (nonatomic, strong) NSString *price;
@property (nonatomic, strong) UIImageView *picture;


-(IBAction)addOrTakePic:(id)sender;

@end
