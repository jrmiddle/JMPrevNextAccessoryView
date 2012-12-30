//
//  JMPrevNextAccessoryView.h
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

#import <UIKit/UIKit.h>

@protocol JMPrevNextAccessoryViewDelegate <NSObject>
@optional

// If implemented by the delegate, these allow for control bar styles
// If these optional methods are NOT implemented, then you should set
// the compiler flag OMIT_DRAWRECT for this class to avoid an
// unecessary -drawRect: override.

- (UIColor *)inputAccessoryBarTintColorForObject:(id)object;
- (UIColor *)inputAccessorySegmentedControlTintColorForObject:(id)object;
- (UIBarStyle)inputAccessoryBarStyleForObject:(id)object;

@required
- (void) inputAccessoryViewPreviousRelativeToObject:(id)object;
- (void) inputAccessoryViewNextRelativeToObject:(id)object;
- (void) inputAccessoryViewDoneForObject:(id)object;

@end

@interface JMPrevNextAccessoryView : UIToolbar

/*
 frame: the frame used for the view.  Generally, 320x36 is good.
 delegate: Self explanatory
 associatedWithObject: This is an optional, weakly-held object with which the instance
 will be associated, and which will be forwarded to the delegate on delegate
 method calls.  If not needed, pass nil.
 */
- (id)initWithFrame:(CGRect)frame
           delegate:(id<JMPrevNextAccessoryViewDelegate>)delegate
     associatedWithObject:(id)associatedObject;

// Same as above, but a (screen width) x 36 frame will be used.
- (id)initWithDelegate:(id <JMPrevNextAccessoryViewDelegate>)delegate
  associatedWithObject:(id)associatedObject;

@property (readonly, nonatomic) int selectedSegmentIndex;
@property (readonly, nonatomic) NSString *selectedSegmentName;
@property (nonatomic, weak) id<JMPrevNextAccessoryViewDelegate> prevNextAccessoryDelegate;
@property (nonatomic, weak) id associatedObject;
@end

