//
//  TPButton.m
//  Tappy Plane
//
//  Created by J Hastwell on 7/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "TPButton.h"

@interface TPButton()

@property (nonatomic) CGRect fullSizeFrame;

@end

@implementation TPButton

+(instancetype)spriteNodeWithTexture:(SKTexture *)texture
{
    TPButton *instance = [super spriteNodeWithTexture:texture];
    instance.pressedScale = 0.9;
    instance.userInteractionEnabled = YES;
    return instance;
}


-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    self.fullSizeFrame = self.frame;
    [self touchesMoved:touches withEvent:event];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        if (CGRectContainsPoint(self.fullSizeFrame, [touch locationInNode:self.parent])) {
            [self setScale:self.pressedScale];
        } else {
            [self setScale:1.0];
        }
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setScale:1.0];
    for (UITouch *touch in touches) {
        if (CGRectContainsPoint(self.fullSizeFrame, [touch locationInNode:self.parent])) {
            // Pressed button.
        }
    }
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self setScale:1.0];
}

@end
