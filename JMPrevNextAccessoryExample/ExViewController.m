//
//  ExViewController.m
//  JMPrevNextAccessoryExample
//
//  Created by Justin Middleton on 12/28/12.
//  Copyright (c) 2012 Justin Middleton. All rights reserved.
//

#import "ExViewController.h"

@interface ExViewController ()

// An array of UITextFields and UITextViews, provided in the order
// through which they should be visited using prev/next.

@property (nonatomic, strong) NSArray *textViews;
@property (nonatomic, strong) JMPrevNextAccessoryView *prevNextAccessoryView;

@end

@implementation ExViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self initTextViews];
}

//=============================================
#pragma mark - Setup

- (void)initTextViews
{
    // Navigate through text views in the order in which they
    // appear as subviews of our view.  In reality you'll likely
    // want to do something more sophisticated.
    
    if (! self.textViews) {
        NSMutableArray *viewArray = [[NSMutableArray alloc] initWithCapacity:3];
        
        for (id view in self.view.subviews) {
            if ([view isKindOfClass:[UITextView class]] || [view isKindOfClass:[UITextField class]]) {
                [viewArray addObject:view];
                [view setDelegate:self];
            }
        }
        self.textViews = viewArray;
    }
}

- (JMPrevNextAccessoryView *)prevNextAccessoryView
{
    if (! _prevNextAccessoryView) {
        _prevNextAccessoryView = [[JMPrevNextAccessoryView alloc] initWithDelegate:self
                                                              associatedWithObject:nil];
    }
    return _prevNextAccessoryView;
}

- (void)setupInputAccessoryViewForObject:(id)textObject
{
    self.prevNextAccessoryView.associatedObject = textObject;
    if (![textObject inputAccessoryView])
        [textObject setInputAccessoryView:self.prevNextAccessoryView];
}


//=============================================
#pragma mark - UITextViewDelegate

- (BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    [self setupInputAccessoryViewForObject:textView];
    [textView scrollRangeToVisible:textView.selectedRange];
    return YES;
}

- (BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    return YES;
}

//=============================================
#pragma mark - UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [self setupInputAccessoryViewForObject:textField];
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    return YES;
}

//=============================================
#pragma  mark - JMPrevNextAccessoryViewDelegate

/* optional */
- (UIColor *)inputAccessoryBarTintColorForObject:(id)object {
    return [UIColor darkGrayColor];
}

- (UIColor *)inputAccessorySegmentedControlTintColorForObject:(id)object {
    return [UIColor brownColor];
}

//- (UIBarStyle)inputAccessoryBarStyleForObject:(id)object
//{
//    return UIBarStyleBlackTranslucent;
//}

/* required */

- (void)inputAccessoryViewDoneForObject:(id)object
{
    [object resignFirstResponder];
}

- (void)inputAccessoryViewNextRelativeToObject:(id)object
{
    int currentTextViewIndex = [self.textViews indexOfObject:object];
    
    [object resignFirstResponder];
    if (currentTextViewIndex < self.textViews.count - 1 ) {
        ++currentTextViewIndex;
    } else {
        currentTextViewIndex = 0;
    }
    [self.textViews[currentTextViewIndex] becomeFirstResponder];
}

- (void)inputAccessoryViewPreviousRelativeToObject:(id)object
{
    int currentTextViewIndex = [self.textViews indexOfObject:object];

    [object resignFirstResponder];
    if (currentTextViewIndex > 0 ) {
        --currentTextViewIndex;
    } else {
        currentTextViewIndex = self.textViews.count - 1;
    }
    [self.textViews[currentTextViewIndex] becomeFirstResponder];
}

@end
