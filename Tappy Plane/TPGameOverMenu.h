//
//  TPGameOverMenu.h
//  Tappy Plane
//
//  Created by J Hastwell on 8/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger {
    MedalNone,
    MedalBronze,
    MedalSilver,
    MedalGold,
} MedalType;

@protocol TPGameOverMenuDelegate <NSObject>

-(void)pressedStartNewGameButton;

@end


@interface TPGameOverMenu : SKNode

@property (nonatomic) CGSize size;
@property (nonatomic) NSInteger score;
@property (nonatomic) NSInteger bestScore;
@property (nonatomic) MedalType medal;
@property (nonatomic, weak) id<TPGameOverMenuDelegate> delegate;

-(instancetype)initWithSize:(CGSize)size;
-(void)show;

@end
