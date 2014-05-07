//
//  TPButton.h
//  Tappy Plane
//
//  Created by J Hastwell on 7/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@interface TPButton : SKSpriteNode

@property (nonatomic) CGFloat pressedScale;

+(instancetype)spriteNodeWithTexture:(SKTexture *)texture;

@end
