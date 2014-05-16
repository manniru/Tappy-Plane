//
//  TPWeatherLayer.h
//  Tappy Plane
//
//  Created by J Hastwell on 16/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger {
    WeatherClear,
    WeatherRaining,
    WeatherSnowing,
} WeatherType;


@interface TPWeatherLayer : SKNode

@property (nonatomic) CGSize size;
@property (nonatomic) WeatherType conditions;

-(instancetype)initWithSize:(CGSize)size;


@end
