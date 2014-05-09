//
//  TPBitmapFontLabel.h
//  Tappy Plane
//
//  Created by J Hastwell on 30/04/2014.
//  Copyright (c) 2014 Code Coalition. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>

typedef enum : NSUInteger {
    BitmapFontAlignmentLeft,
    BitmapFontAlignmentCenter,
    BitmapFontAlignmentRight,
} BitmapFontAlignment;

@interface TPBitmapFontLabel : SKNode

@property (nonatomic) NSString* fontName;
@property (nonatomic) NSString* text;
@property (nonatomic) CGFloat letterSpacing;
@property (nonatomic) BitmapFontAlignment alignment;

-(instancetype)initWithText:(NSString*)text andFontName:(NSString*)fontName;

@end
