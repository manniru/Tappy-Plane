//
//  TPGetReadyMenu.h
//  Tappy Plane
//
//  Created by J Hastwell on 15/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TPGetReadyMenu : SKNode

@property (nonatomic) CGSize size;

-(instancetype)initWithSize:(CGSize)size andPlanePosition:(CGPoint)planePosition;

-(void)show;
-(void)hide;


@end
