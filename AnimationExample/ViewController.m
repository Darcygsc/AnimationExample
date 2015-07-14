//
//  ViewController.m
//  AnimationExample
//
//  Created by chaos on 7/13/15.
//  Copyright (c) 2015 ace. All rights reserved.
//

#import "ViewController.h"
#import "AnimationView.h"

@interface ViewController ()

@property (nonatomic ,weak) AnimationView *animationView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AnimationView *animationView = [[AnimationView alloc] initWithWidth:40 Distance:5];
    animationView.center = CGPointMake(self.view.frame.size.width/2, self.view.frame.size.height/2);
    [self.view addSubview:animationView];
    self.animationView = animationView;
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    [button setTitle:@"layer层动画" forState:UIControlStateNormal];
    [button setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button.bounds = CGRectMake(0, 0, 150, 50);
    button.center = CGPointMake(self.view.frame.size.width/2+50, self.view.frame.size.height/2-100);
    [self.view addSubview:button];
    [button addTarget:self action:@selector(clicked1) forControlEvents:UIControlEventTouchDown];
    
    UIButton *button2 = [UIButton buttonWithType:UIButtonTypeCustom];
    [button2 setTitle:@"view层动画" forState:UIControlStateNormal];
    [button2 setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    button2.bounds = CGRectMake(0, 0, 150, 50);
    button2.center = CGPointMake(self.view.frame.size.width/2-50, self.view.frame.size.height/2-100);
    [self.view addSubview:button2];
    [button2 addTarget:self action:@selector(clicked2) forControlEvents:UIControlEventTouchDown];

}

- (void)clicked1
{
    [self.animationView beginAnimationWithLayer:YES];
}

- (void)clicked2
{
    [self.animationView beginAnimationWithLayer:NO];
}


@end
