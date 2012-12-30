JMPrevNextAccessoryView
=======================

An easy-to-use accessory view for Safari-like textField/textView navigation from the keyboard.

# Intro

When filling out forms in Safari, the user is presented with a nice accessory above the keyboard which
provides easy navigation from text field (whether a textField or textView) to text field.  JMPrevNextAccessoryView
aims to replicate that functionality with a minimum of developer overhead.

# Usage

To use JMPrevNextAccessoryView, you need to do the following:

1.Add the source to your project.

2. In your UITextViewDelegate and UITextFieldDelegate methods, add an instance of JMPrevNextAccessoryView using the -setInputAccessoryView method.

3. Implement the JMPrevNextAccessoryViewDelegate methods to receive prev/next/done events from the accessory.

# Example

Example code can be found in the JMPrevNextAccessoryExample project; in ExViewController.m.


