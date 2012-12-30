//
//  ExViewController.h
//  JMPrevNextAccessoryExample
//
//  Created by Justin Middleton on 12/28/12.
//  Copyright (c) 2012 Justin Middleton. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "JMPrevNextAccessoryView.h"

@interface ExViewController : UIViewController <UITextFieldDelegate, UITextViewDelegate, JMPrevNextAccessoryViewDelegate>

@property (strong, nonatomic) IBOutletCollection(UIView) NSArray *navigableTextFields;

@end
