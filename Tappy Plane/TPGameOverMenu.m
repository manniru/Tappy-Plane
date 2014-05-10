//
//  TPGameOverMenu.m
//  Tappy Plane
//
//  Created by J Hastwell on 8/05/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import "TPGameOverMenu.h"
#import "TPBitmapFontLabel.h"
#import "TPButton.h"

@interface TPGameOverMenu()

@property (nonatomic) SKSpriteNode *medalDisplay;
@property (nonatomic) TPBitmapFontLabel *scoreText;
@property (nonatomic) TPBitmapFontLabel *bestScoreText;

@end

@implementation TPGameOverMenu


-(instancetype)initWithSize:(CGSize)size
{
    if (self = [super init]) {
        _size = size;
        
        // Get texture atlas.
        SKTextureAtlas *atlas = [SKTextureAtlas atlasNamed:@"Graphics"];
        
        // Setup game over title text.
        SKSpriteNode *gameOverTitle = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"textGameOver"]];
        gameOverTitle.position = CGPointMake(size.width * 0.5, size.height - 70);
        [self addChild:gameOverTitle];
        
        // Setup node to act as group for panel elements.
        SKNode *panelGroup = [SKNode node];
        [self addChild:panelGroup];
        
        // Setup background panel.
        SKSpriteNode *panelBackground = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"UIbg"]];
        panelBackground.position = CGPointMake(size.width * 0.5, size.height - 150.0);
        panelBackground.centerRect = CGRectMake(10 / panelBackground.size.width,
                                                10 / panelBackground.size.height,
                                                (panelBackground.size.width - 20) / panelBackground.size.width,
                                                (panelBackground.size.height - 20) / panelBackground.size.height);
        panelBackground.xScale = 175.0 / panelBackground.size.width;
        panelBackground.yScale = 115.0 / panelBackground.size.height;
        [panelGroup addChild:panelBackground];
        
        // Setup score title.
        SKSpriteNode *scoreTitle = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"textScore"]];
        scoreTitle.anchorPoint = CGPointMake(1.0, 1.0);
        scoreTitle.position = CGPointMake(CGRectGetMaxX(panelBackground.frame) - 20, CGRectGetMaxY(panelBackground.frame) - 10);
        [panelGroup addChild:scoreTitle];
        
        // Setup score text label.
        _scoreText = [[TPBitmapFontLabel alloc] initWithText:@"0" andFontName:@"number"];
        _scoreText.alignment = BitmapFontAlignmentRight;
        _scoreText.position = CGPointMake(CGRectGetMaxX(scoreTitle.frame), CGRectGetMinY(scoreTitle.frame) - 15);
        [_scoreText setScale:0.5];
        [panelGroup addChild:_scoreText];
        
        // Setup best title.
        SKSpriteNode *bestTitle = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"textBest"]];
        bestTitle.anchorPoint = CGPointMake(1.0, 1.0);
        bestTitle.position = CGPointMake(CGRectGetMaxX(panelBackground.frame) - 20, CGRectGetMaxY(panelBackground.frame) - 60);
        [panelGroup addChild:bestTitle];
        
        // Setup best score text label.
        _bestScoreText = [[TPBitmapFontLabel alloc] initWithText:@"0" andFontName:@"number"];
        _bestScoreText.alignment = BitmapFontAlignmentRight;
        _bestScoreText.position = CGPointMake(CGRectGetMaxX(bestTitle.frame), CGRectGetMinY(bestTitle.frame) - 15);
        [_bestScoreText setScale:0.5];
        [panelGroup addChild:_bestScoreText];
        
        // Setup medal title.
        SKSpriteNode *medalTitle = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"textMedal"]];
        medalTitle.anchorPoint = CGPointMake(0.0, 1.0);
        medalTitle.position = CGPointMake(CGRectGetMinX(panelBackground.frame) + 20, CGRectGetMaxY(panelBackground.frame) - 10);
        [panelGroup addChild:medalTitle];
        
        // Setup display of medal.
        _medalDisplay = [SKSpriteNode spriteNodeWithTexture:[atlas textureNamed:@"medalBlank"]];
        _medalDisplay.anchorPoint = CGPointMake(0.5, 1.0);
        _medalDisplay.position = CGPointMake(CGRectGetMidX(medalTitle.frame), CGRectGetMinY(medalTitle.frame) - 15);
        [panelGroup addChild:_medalDisplay];
        
        // Setup play button.
        TPButton *playButton = [TPButton spriteNodeWithTexture:[atlas textureNamed:@"buttonPlay"]];
        playButton.position = CGPointMake(CGRectGetMidX(panelBackground.frame), CGRectGetMinY(panelBackground.frame) - 25);
        [playButton setPressedTarget:self withAction:@selector(pressedPlayButton)];
        [self addChild:playButton];
        
        
        // Set initial values.
        self.medal = MedalGold;
        self.score = 0;
        self.bestScore = 0;
        
    }
    return self;
}

-(void)pressedPlayButton
{
    self.score += 1;
}

-(void)setScore:(NSInteger)score
{
    _score = score;
    self.scoreText.text = [NSString stringWithFormat:@"%ld", (long)score];
}

-(void)setBestScore:(NSInteger)bestScore
{
    _bestScore = bestScore;
    self.bestScoreText.text = [NSString stringWithFormat:@"%ld", (long)bestScore];
}

-(void)setMedal:(MedalType)medal
{
    _medal = medal;
    switch (medal) {
        case MedalBronze:
            self.medalDisplay.texture = [[SKTextureAtlas atlasNamed:@"Graphics"] textureNamed:@"medalBronze"];
            break;
        case MedalSilver:
            self.medalDisplay.texture = [[SKTextureAtlas atlasNamed:@"Graphics"] textureNamed:@"medalSilver"];
            break;
        case MedalGold:
            self.medalDisplay.texture = [[SKTextureAtlas atlasNamed:@"Graphics"] textureNamed:@"medalGold"];
            break;
        default:
            self.medalDisplay.texture = [[SKTextureAtlas atlasNamed:@"Graphics"] textureNamed:@"medalBlank"];
            break;
    }
}


@end










