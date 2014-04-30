//
//  TPGameScene.h
//  Tappy Plane
//
//  Created by J Hastwell on 20/03/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "TPCollectable.h"

@interface TPGameScene : SKScene <SKPhysicsContactDelegate, TPCollectableDelegate>

@end
