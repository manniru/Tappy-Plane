//
//  TPObstacleLayer.h
//  Tappy Plane
//
//  Created by J Hastwell on 28/03/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "TPScrollingNode.h"
#import "TPCollectable.h"

@interface TPObstacleLayer : TPScrollingNode

@property (nonatomic, weak) id<TPCollectableDelegate> collectableDelegate;

@property (nonatomic) CGFloat floor;
@property (nonatomic) CGFloat ceiling;

-(void)reset;

@end
