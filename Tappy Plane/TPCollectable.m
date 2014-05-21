//
//  TPCollectable.m
//  Tappy Plane
//
//  Created by J Hastwell on 29/04/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "TPCollectable.h"

@implementation TPCollectable

-(void)collect
{
    [self.collectionSound play];
    [self runAction:[SKAction removeFromParent]];
    if (self.delegate) {
        [self.delegate wasCollected:self];
    }
}

@end
