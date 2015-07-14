//
//  AnimationView.m
//  AnimationExample
//
//  Created by chaos on 7/13/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import "AnimationView.h"

@interface AnimationView()
{
    NSInteger _angle;
    CGFloat _distance;
    CGPoint originPoints[4];
    CGFloat _scale;
    BOOL _isStartAnimation;
    BOOL _isAnimationing;

}

@end

@implementation AnimationView

- (id)initWithWidth:(CGFloat)width Distance:(CGFloat)distance
{
    self = [super initWithFrame:CGRectMake(0, 0, width, width)];
    if (self) {
        _distance = distance;
        
        CGRect roundRect = CGRectMake(_distance / 2, _distance / 2, self.frame.size.width / 2 - _distance, self.frame.size.width / 2 - _distance);
        NSInteger x = 0;
        
        NSArray * colors =@[
                            [UIColor colorWithRed:1 green:219 / 255.0f blue:60 / 255.0f alpha:1],
                            [UIColor colorWithRed:102 / 255.0f green:220 / 255.0f blue:160 / 255.0f alpha:1],
                            [UIColor colorWithRed:93 / 255.0f green:198 / 255.0f blue:193 / 255.0f alpha:1],
                            [UIColor colorWithRed:234 / 255.0f green:85 / 255.0f blue:104 / 255.0f alpha:1]];
        
        for (int i = 0; i < 4; i ++) {
            UIView * view = [[UIView alloc] initWithFrame:roundRect];
            view.layer.cornerRadius = roundRect.size.width / 2.0f;
            view.backgroundColor = colors[i];
            [self addSubview:view];
            
            originPoints[i] = view.frame.origin;
            
            x ++;
            roundRect.origin.x = x * roundRect.size.width + _distance + _distance / 2;
            if (x == 2) {
                roundRect.origin.y += roundRect.size.height + _distance;
                roundRect.origin.x = _distance / 2;
                x = 0;
            }
        }
        
    }
    return self;
}


- (void)rotatAngle:(CGFloat)angle
{
    _angle = angle;
    
    CGAffineTransform rota = CGAffineTransformMakeRotation(_angle * (M_PI / 180.0f));
    self.transform = rota;
}

- (void)beginAnimationWithLayer:(BOOL)flag
{
    if (!flag) {
        if (_isAnimationing) {
            return;
        }
        _isAnimationing = YES;
        [self rotaAnimation];
    }else{
        [self groupAnimation];
    }
}

- (void)rotaAnimation {
    
    [UIView animateWithDuration:0.03 animations:^{
        [self rotatAngle:_angle + 10];
    } completion:^(BOOL finished) {
        if (_isAnimationing) {
            [self rotaAnimation];
            [self centerAnimation];
        }
    }];
}

- (CAAnimationGroup *)createGroupAnimation

{
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation.duration = 1.5;
    animation.fromValue = @(0.1);
    animation.toValue = @(2);
    
    CABasicAnimation *animation2 = [CABasicAnimation animationWithKeyPath:@"transform.rotation.z"];
    animation2.duration = 3;
    animation2.fromValue = @(0);
    animation2.toValue = @(M_PI * 2);
    
    CABasicAnimation *animation3 = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    animation3.duration = 1.5;
    animation3.fromValue = @(2);
    animation3.toValue = @(0.1);
    animation3.beginTime = 1.5;

    CAAnimationGroup *group = [CAAnimationGroup animation];
    group.duration = 3;
    group.animations = @[animation,animation2,animation3];
    group.repeatCount = MAXFLOAT;
    return group;
}

- (void)groupAnimation
{

    [self.layer addAnimation:[self createGroupAnimation] forKey:@"groupAnimation"];
    _isAnimationing = NO;

}

- (void)centerAnimation
{
    if (_isStartAnimation) {
        return;
    }
    _isStartAnimation = YES;
    CGFloat value = _distance / 2 - 1;
    [UIView animateWithDuration:0.25 animations:^{
        for (UIView * v in self.subviews) {
            
            NSInteger index = [self.subviews indexOfObject:v];
            
            CGRect frame = v.frame;
            frame.origin = originPoints[index];
            switch (index) {
                case 0:
                    frame.origin.x += value;
                    frame.origin.y += value;
                    break;
                case 1:
                    frame.origin.x -= value;
                    frame.origin.y += value;
                    break;
                case 2:
                    frame.origin.x += value;
                    frame.origin.y -= value;
                    break;
                case 3:
                    frame.origin.x -= value;
                    frame.origin.y -= value;
                    break;
                default:
                    break;
            }
            
            v.frame = frame;
        }
    } completion:^(BOOL finished) {
        [UIView animateWithDuration:0.25 animations:^{
            for (UIView * v in self.subviews) {
                CGRect frame = v.frame;
                frame.origin = originPoints[[self.subviews indexOfObject:v]];
                v.frame = frame;
            }
        } completion:^(BOOL finished) {
            _isStartAnimation = NO;
        }];
    }];
    
}

- (void)endAnimation
{
    _isAnimationing = NO;
}


@end
