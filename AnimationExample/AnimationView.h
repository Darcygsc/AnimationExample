//
//  AnimationView.h
//  AnimationExample
//
//  Created by chaos on 7/13/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AnimationView : UIView

- (id) initWithWidth:(CGFloat)width Distance:(CGFloat)distance;

- (void)rotatAngle:(CGFloat)angle;

- (void)beginAnimationWithLayer:(BOOL)flag;
- (void)endAnimation;

@end
