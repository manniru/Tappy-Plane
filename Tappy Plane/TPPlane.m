//
//  TPPlane.m
//  Tappy Plane
//
//  Created by J Hastwell on 20/03/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "TPPlane.h"
#import "TPConstants.h"
#import "TPCollectable.h"
#import "SoundManager.h"

@interface TPPlane()
@property (nonatomic) NSMutableArray *planeAnimations; // Holds animation actions.
@property (nonatomic) SKEmitterNode *puffTrailEmitter;
@property (nonatomic) CGFloat puffTrailBirthRate;
@property (nonatomic) SKAction *crashTintAction;
@property (nonatomic) Sound *engineSound;

@end

static NSString* const kTPKeyPlaneAnimation = @"PlaneAnimation";
static const CGFloat kTPMaxAltitude = 300.0;

@implementation TPPlane

- (id)init
{
    self = [super initWithImageNamed:@"planeBlue1@2x"];
    if (self) {
        
        // Setup physics body with path.
        CGFloat offsetX = self.frame.size.width * self.anchorPoint.x;
        CGFloat offsetY = self.frame.size.height * self.anchorPoint.y;
        
        CGMutablePathRef path = CGPathCreateMutable();
        CGPathMoveToPoint(path, NULL, 43 - offsetX, 18 - offsetY);
        CGPathAddLineToPoint(path, NULL, 34 - offsetX, 36 - offsetY);
        CGPathAddLineToPoint(path, NULL, 11 - offsetX, 35 - offsetY);
        CGPathAddLineToPoint(path, NULL, 0 - offsetX, 28 - offsetY);
        CGPathAddLineToPoint(path, NULL, 10 - offsetX, 4 - offsetY);
        CGPathAddLineToPoint(path, NULL, 29 - offsetX, 0 - offsetY);
        CGPathAddLineToPoint(path, NULL, 37 - offsetX, 5 - offsetY);
        CGPathCloseSubpath(path);
        
        self.physicsBody = [SKPhysicsBody bodyWithPolygonFromPath:path];
        self.physicsBody.mass = 0.08;
        self.physicsBody.categoryBitMask = kTPCategoryPlane;
        self.physicsBody.contactTestBitMask = kTPCategoryGround | kTPCategoryCollectable;
        self.physicsBody.collisionBitMask = kTPCategoryGround;
        
        // Init array to hold animation actions.
        _planeAnimations = [[NSMutableArray alloc] init];
        
        // Load animation plist file.
        NSString *animationPlistPath = [[NSBundle mainBundle] pathForResource:@"PlaneAnimations" ofType:@"plist"];
        NSDictionary *animations = [NSDictionary dictionaryWithContentsOfFile:animationPlistPath];
        for (NSString *key in animations) {
            [self.planeAnimations addObject:[self animationFromArray:[animations objectForKey:key] withDuration:0.4]];
        }
        
        // Setup puff trail particle effect.
        NSString *particleFile = [[NSBundle mainBundle] pathForResource:@"PlanePuffTrail" ofType:@"sks"];
        _puffTrailEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:particleFile];
        _puffTrailEmitter.position = CGPointMake(-self.size.width * 0.5, -5);
        [self addChild:self.puffTrailEmitter];
        self.puffTrailBirthRate = _puffTrailEmitter.particleBirthRate;
        self.puffTrailEmitter.particleBirthRate = 0;
        
        // Setup action to tint plane when it crashes.
        SKAction *tint = [SKAction colorizeWithColor:[SKColor redColor] colorBlendFactor:0.8 duration:0.0];
        SKAction *removeTint = [SKAction colorizeWithColorBlendFactor:0.0 duration:0.2];
        _crashTintAction = [SKAction sequence:@[tint, removeTint]];
        
        // Setup engine sound.
        _engineSound = [Sound soundNamed:@"Engine.caf"];
        _engineSound.looping = YES;
        
        [self setRandomColour];
    }
    return self;
}

- (void)reset
{
    // Set plane's initial values.
    self.crashed = NO;
    self.engineRunning = YES;
    self.physicsBody.velocity = CGVectorMake(0.0, 0.0);
    self.zRotation = 0.0;
    self.physicsBody.angularVelocity = 0.0;
    [self setRandomColour];
}

- (void)setEngineRunning:(BOOL)engineRunning
{
    _engineRunning = engineRunning && !self.crashed;
    if (engineRunning) {
        [self.engineSound play];
        [self.engineSound fadeIn:1.0];
        self.puffTrailEmitter.targetNode = self.parent;
        [self actionForKey:kTPKeyPlaneAnimation].speed = 1;
        self.puffTrailEmitter.particleBirthRate = self.puffTrailBirthRate;
    }
    else {
        [self.engineSound fadeOut:0.5];
        [self actionForKey:kTPKeyPlaneAnimation].speed = 0;
        self.puffTrailEmitter.particleBirthRate = 0;
    }
}

- (void)setAccelerating:(BOOL)accelerating
{
    _accelerating = accelerating && !self.crashed;
}

- (void)setCrashed:(BOOL)crashed
{
    _crashed = crashed;
    if (crashed) {
        self.engineRunning = NO;
        self.accelerating = NO;
    }
}

- (void)setRandomColour
{
    [self removeActionForKey:kTPKeyPlaneAnimation];
    SKAction *animation = [self.planeAnimations objectAtIndex:arc4random_uniform((uint)self.planeAnimations.count)];
    [self runAction:animation withKey:kTPKeyPlaneAnimation];
    if (!self.engineRunning) {
        [self actionForKey:kTPKeyPlaneAnimation].speed = 0;
    }
    
}

- (void)collide:(SKPhysicsBody *)body
{
    // Ignore collision if already crashed.
    if (!self.crashed) {
        if (body.categoryBitMask == kTPCategoryGround) {
            // Hit the ground.
            self.crashed = YES;
            [self runAction:self.crashTintAction];
            [[SoundManager sharedManager] playSound:@"Crunch.caf"];
        }
        if (body.categoryBitMask == kTPCategoryCollectable) {
            if ([body.node respondsToSelector:@selector(collect)]) {
                [body.node performSelector:@selector(collect)];
            }
        }
    }
}

- (SKAction*)animationFromArray:(NSArray*)textureNames withDuration:(CGFloat)duration
{
    // Create array to hold textures.
    NSMutableArray *frames = [[NSMutableArray alloc] init];
    // Get planes atlas.
    SKTextureAtlas *planesAtlas = [SKTextureAtlas atlasNamed:@"Graphics"];
    // Loop through textureNames array and load textures.
    for (NSString *textureName in textureNames) {
        [frames addObject:[planesAtlas textureNamed:textureName]];
    }
    // Calculate time per frame.
    CGFloat frameTime = duration / (CGFloat)frames.count;
    // Create and return animation action.
    return [SKAction repeatActionForever:[SKAction animateWithTextures:frames
                                                          timePerFrame:frameTime
                                                                resize:NO restore:NO]];
}


- (void)update
{
    if (self.accelerating && self.position.y < kTPMaxAltitude) {
        [self.physicsBody applyForce:CGVectorMake(0.0, 100)];
    }
    if(!self.crashed)
    {
        self.zRotation = fmaxf(fminf(self.physicsBody.velocity.dy, 400), -400) / 400;
        self.engineSound.volume = 0.25 + fmaxf(fminf(self.physicsBody.velocity.dy, 300), 0) / 300 * 0.75;
    }
}


@end









