//
//  TPWeatherLayer.m
//  Tappy Plane
//
//  Created by J Hastwell on 16/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "TPWeatherLayer.h"

@interface TPWeatherLayer()

@property (nonatomic) SKEmitterNode *rainEmitter;
@property (nonatomic) SKEmitterNode *snowEmitter;

@end


@implementation TPWeatherLayer

- (instancetype)initWithSize:(CGSize)size
{
    self = [super init];
    if (self) {
        _size = size;
        
        // Load rain effect.
        NSString *rainEffectPath = [[NSBundle mainBundle] pathForResource:@"RainEffect" ofType:@"sks"];
        _rainEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:rainEffectPath];
        _rainEmitter.position = CGPointMake(size.width * 0.5 + 32, size.height + 5);
        
        // Load snow effect.
        NSString *snowEffectPath = [[NSBundle mainBundle] pathForResource:@"SnowEffect" ofType:@"sks"];
        _snowEmitter = [NSKeyedUnarchiver unarchiveObjectWithFile:snowEffectPath];
        _snowEmitter.position = CGPointMake(size.width * 0.5, size.height + 5);
    }
    return self;
}


-(void)setConditions:(WeatherType)conditions
{
    if (_conditions != conditions) {
        _conditions = conditions;
        // Remove existing weather effect.
        [self removeAllChildren];
        
        // Add weather conditions.
        switch (conditions) {
            case WeatherRaining:
                [self addChild:self.rainEmitter];
                [self.rainEmitter advanceSimulationTime:5];
                break;
                
            case WeatherSnowing:
                [self addChild:self.snowEmitter];
                [self.snowEmitter advanceSimulationTime:5];
                break;
                
            default:
                break;
        }

    }
}



@end
