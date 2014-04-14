//
//  TPGameScene.m
//  Tappy Plane
//
//  Created by J Hastwell on 20/03/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "TPGameScene.h"
#import "TPPlane.h"
#import "TPScrollingLayer.h"

@interface TPGameScene ()

@property (nonatomic) TPPlane *player;
@property (nonatomic) SKNode *world;
@property (nonatomic) TPScrollingLayer *background;

@end

static const CGFloat kMinFPS = 10.0 / 60.0;

@implementation TPGameScene

-(id)initWithSize:(CGSize)size
{
    if (self = [super initWithSize:size]) {
        
        // Set background colour to sky blue.
        self.backgroundColor = [SKColor colorWithRed:0.835294118 green:0.929411765 blue:0.968627451 alpha:1.0];
        
        // Get atlas file.
        SKTextureAtlas *graphics = [SKTextureAtlas atlasNamed:@"Graphics"];
        
        // Setup physics.
        self.physicsWorld.gravity = CGVectorMake(0.0, -5.5);
        
        // Setup world.
        _world = [SKNode node];
        [self addChild:_world];
        
        // Setup background.
        NSMutableArray *backgroudTiles = [[NSMutableArray alloc] init];
        for (int i = 0; i < 3; i++) {
            [backgroudTiles addObject:[SKSpriteNode spriteNodeWithTexture:[graphics textureNamed:@"background"]]];
        }
        
        _background = [[TPScrollingLayer alloc] initWithTiles:backgroudTiles];
        _background.position = CGPointMake(0, 30);
        _background.horizontalScrollSpeed = -60;
        _background.scrolling = YES;
        [_world addChild:_background];
        
        
        // Setup player.
        _player = [[TPPlane alloc] init];
        _player.position = CGPointMake(self.size.width * 0.5, self.size.height * 0.5);
        _player.physicsBody.affectedByGravity = NO;
        [_world addChild:_player];
        _player.engineRunning = YES;
        
        
    }
    return self;
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        _player.physicsBody.affectedByGravity = YES;
        self.player.accelerating = YES;
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event
{
    for (UITouch *touch in touches) {
        self.player.accelerating = NO;
    }
}

-(void)update:(NSTimeInterval)currentTime
{
    static NSTimeInterval lastCallTime;
    NSTimeInterval timeElapsed = currentTime - lastCallTime;
    if (timeElapsed > kMinFPS) {
        timeElapsed = kMinFPS;
    }
    lastCallTime = currentTime;
    
    [self.player update];
    [self.background updateWithTimeElpased:timeElapsed];
    
}


@end










