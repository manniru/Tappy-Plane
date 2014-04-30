//
//  TPCollectable.h
//  Tappy Plane
//
//  Created by J Hastwell on 29/04/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

@class TPCollectable;

@protocol TPCollectableDelegate <NSObject>

-(void)wasCollected:(TPCollectable*)collectable;

@end


@interface TPCollectable : SKSpriteNode

@property (nonatomic, weak) id<TPCollectableDelegate> delegate;
@property (nonatomic) NSInteger pointValue;

-(void)collect;

@end
