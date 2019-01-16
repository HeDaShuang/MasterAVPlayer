//
//  UIView+FrameAccessor.h
//  MasterAVPlayer
//  获取UIView的frame相关属性
//  Created by eric on 2019/1/16.
//  Copyright © 2019 eric. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIView (FrameAccessor)
- (CGPoint)origin;
- (void)setOrigin:(CGPoint)newOrigin;

- (CGSize)size;
- (void)setSize:(CGSize)newSize;

- (CGFloat)x;
- (void)setX:(CGFloat)newX;

- (CGFloat)y;
- (void)setY:(CGFloat)newY;

- (CGFloat)height;
- (void)setHeight:(CGFloat)newHeight;

- (CGFloat)width;
- (void)setWidth:(CGFloat)newWidth;


- (CGFloat)maxX;
- (void)setMaxX:(CGFloat)newMaxX;

- (CGFloat)midX;
- (void)setMidX:(CGFloat)newMidX;

- (CGFloat)maxY;
- (void)setMaxY:(CGFloat)newMaxY;

- (CGFloat)midY;
- (void)setMidY:(CGFloat)newMidY;

@property (nonatomic,assign) CGFloat right;

@property (nonatomic,assign) CGFloat bottom;

@end

NS_ASSUME_NONNULL_END
