//
//  TPObstacleLayer.m
//  Tappy Plane
//
//  Created by J Hastwell on 28/03/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "TPObstacleLayer.h"

@interface TPObstacleLayer()

@property (nonatomic) CGFloat marker;

@end

static const CGFloat kTPMarkerBuffer = 200.0;
@implementation TPObstacleLayer


-(void)updateWithTimeElpased:(NSTimeInterval)timeElapsed
{
    [super updateWithTimeElpased:timeElapsed];
    
    if (self.scrolling && self.scene) {
        // Find marker's location in scene coords.
        CGPoint markerLocationInScene = [self convertPoint:CGPointMake(self.marker, 0) toNode:self.scene];
        // When marker comes onto screen, add new obstacles.
        if (markerLocationInScene.x - (self.scene.size.width * self.scene.anchorPoint.x)
            < self.scene.size.width + kTPMarkerBuffer) {
            [self addObstacleSet];
        }
    }
    
}

-(void)addObstacleSet
{
    
}



@end










