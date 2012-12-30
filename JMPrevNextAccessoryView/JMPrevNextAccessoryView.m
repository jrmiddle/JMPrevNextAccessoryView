//
//  JMPrevNextAccessoryView.m
//
//  Created by Justin Middleton on 4/18/12.
//  Copyright (c) 2012, Justin R. Middleton<jrmiddle@gmail.com>
//  All rights reserved.
//  
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met: 
//  
//  1. Redistributions of source code must retain the above copyright notice, this
//     list of conditions and the following disclaimer. 
//  2. Redistributions in binary form must reproduce the above copyright notice,
//     this list of conditions and the following disclaimer in the documentation
//     and/or other materials provided with the distribution. 
//  
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND
//  ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED
//  WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE ARE
//  DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR CONTRIBUTORS BE LIABLE FOR
//  ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL DAMAGES
//  (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES;
//  LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND
//  ON ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT
//  (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS
//  SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
//  
//  The views and conclusions contained in the software and documentation are those
//  of the authors and should not be interpreted as representing official policies, 
//  either expressed or implied, of the FreeBSD Project.

#import "JMPrevNextAccessoryView.h"


@interface JMPrevNextAccessoryView ()

@property (nonatomic, strong) UISegmentedControl *prevNextSegmentedControl;

@end

@implementation JMPrevNextAccessoryView

- (id)initWithDelegate:(id <JMPrevNextAccessoryViewDelegate>)delegate
  associatedWithObject:(id)associatedObject
{
    CGRect screenRect = [[UIScreen mainScreen] bounds];
    return [self initWithFrame:CGRectMake(0, 0, screenRect.size.width, 36)
                      delegate:delegate
          associatedWithObject:associatedObject];
}

- (id)initWithFrame:(CGRect)frame
           delegate:(id <JMPrevNextAccessoryViewDelegate>)delegate
 associatedWithObject:(id)associatedObject
{
    self = [super initWithFrame:frame];
    if (self) {

        self.prevNextAccessoryDelegate = delegate;
        self.associatedObject = associatedObject;

        UISegmentedControl *control = [[UISegmentedControl alloc] initWithItems:[NSArray arrayWithObjects:@"Previous", @"Next", nil]];
        control.segmentedControlStyle = UISegmentedControlStyleBar;
        control.momentary = YES;
        [control addTarget:self action:@selector(inputAccessoryViewPrevNext) forControlEvents:UIControlEventValueChanged];
        
        self.prevNextSegmentedControl = control;

        UIBarButtonItem *prevNextItem = [[UIBarButtonItem alloc] initWithCustomView:control];
        
        UIBarButtonItem *flexItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
        
        UIBarButtonItem  *doneButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(inputAccessoryViewDone)];
        
        NSArray *items = [[NSArray alloc] initWithObjects:prevNextItem, flexItem, doneButtonItem, nil];
        
        [self setItems:items];
        
#if __has_feature(objc_arc)
#else
        [prevNextItem release];
        [flexItem release];
        [doneButtonItem release];
        [items release];
#endif
    }
    return self;
}

// Generally -drawRect: should be omitted it it's not being customized, for
// perf reasons.  If you're just using the default styles and not defining
// the optional parts of the JMPrevNextAccessoryDelegate protocol, then there's
// no need for drawrect. Pass this in as a compiler directive.

#ifndef OMIT_DRAWRECT
- (void)drawRect:(CGRect)rect
{
    id<JMPrevNextAccessoryViewDelegate> delegate = self.prevNextAccessoryDelegate;
    
    if ([delegate respondsToSelector:@selector(inputAccessoryBarStyleForObject:)]) {
        self.barStyle = [delegate inputAccessoryBarStyleForObject:self.associatedObject];
    }
    else {
        self.barStyle = UIBarStyleDefault;
    }
    
    if ([delegate respondsToSelector:@selector(inputAccessoryBarTintColorForObject:)]) {
        self.tintColor = [delegate inputAccessoryBarTintColorForObject:self.associatedObject];
    }
    
    if ([delegate respondsToSelector:@selector(inputAccessorySegmentedControlTintColorForObject:)]) {
        self.prevNextSegmentedControl.tintColor = [delegate inputAccessorySegmentedControlTintColorForObject:self.associatedObject];
    }

    [super drawRect:rect];
}
#endif

- (void) inputAccessoryViewPrevNext
{
    switch (self.selectedSegmentIndex) {
        case 0:
            [self inputAccessoryViewPrevious];
            break;
        case 1:
            [self inputAccessoryViewNext];
            break;
        default:
            break;
    }
}

- (void) inputAccessoryViewDone
{
    [self.prevNextAccessoryDelegate inputAccessoryViewDoneForObject:self.associatedObject];
}

- (void) inputAccessoryViewPrevious
{
    [self.prevNextAccessoryDelegate inputAccessoryViewPreviousRelativeToObject:self.associatedObject];
}

- (void) inputAccessoryViewNext
{
    [self.prevNextAccessoryDelegate inputAccessoryViewNextRelativeToObject:self.associatedObject];
}

- (int)selectedSegmentIndex
{
    return self.prevNextSegmentedControl.selectedSegmentIndex;
}

- (NSString *)selectedSegmentName
{
    return (NSString*)[self.prevNextSegmentedControl titleForSegmentAtIndex:self.selectedSegmentIndex];
}

#if __has_feature(objc_arc)
#else
- (void) dealloc
{
    [_prevNextSegmentedControl release];
    [super dealloc];
}
#endif

@end
