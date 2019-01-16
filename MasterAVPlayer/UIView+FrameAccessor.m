//
//  UIView+FrameAccessor.m
//  MasterAVPlayer
//
//  Created by eric on 2019/1/16.
//  Copyright © 2019 eric. All rights reserved.
//

#import "UIView+FrameAccessor.h"

@implementation UIView (FrameAccessor)
- (CGPoint)origin {
    return self.frame.origin;
}

- (void)setOrigin:(CGPoint)newOrigin {
    CGRect newFrame = self.frame;
    newFrame.origin = newOrigin;
    self.frame = newFrame;
}

- (CGSize)size {
    return self.frame.size;
}

- (void)setSize:(CGSize)newSize {
    CGRect newFrame = self.frame;
    newFrame.size = newSize;
    self.frame = newFrame;
}

- (CGFloat)x {
    return self.frame.origin.x;
}

- (void)setX:(CGFloat)newX {
    CGRect newFrame = self.frame;
    newFrame.origin.x = newX;
    self.frame = newFrame;
}

- (CGFloat)y {
    return self.frame.origin.y;
}

- (void)setY:(CGFloat)newY {
    CGRect newFrame = self.frame;
    newFrame.origin.y = newY;
    self.frame = newFrame;
}

- (CGFloat)height {
    return self.frame.size.height;
}

- (void)setHeight:(CGFloat)newHeight {
    CGRect newFrame = self.frame;
    newFrame.size.height = newHeight;
    self.frame = newFrame;
}

- (CGFloat)width {
    return self.frame.size.width;
}

- (void)setWidth:(CGFloat)newWidth {
    CGRect newFrame = self.frame;
    newFrame.size.width = newWidth;
    self.frame = newFrame;
}


- (CGFloat)maxX {
    return CGRectGetMaxX(self.frame);
}

- (void)setMaxX:(CGFloat)newMaxX {
    CGRect newFrame = self.frame;
    newFrame.origin.x = newMaxX - self.width;
    self.frame = newFrame;
}

- (CGFloat)midX {
    return self.center.x;
}

- (void)setMidX:(CGFloat)newMidX {
    CGRect newFrame = self.frame;
    newFrame.origin.x = newMidX - self.width/2;
    [self setFrame:newFrame];
}

- (CGFloat)maxY {
    return CGRectGetMaxY(self.frame);
}

- (void)setMaxY:(CGFloat)newMaxY {
    CGRect newFrame = self.frame;
    newFrame.origin.y = newMaxY - self.height;
    self.frame = newFrame;
}

- (CGFloat)midY {
    return self.center.y;
}

- (void)setMidY:(CGFloat)newMidY {
    CGRect newFrame = self.frame;
    newFrame.origin.y = newMidY - self.height/2;
    [self setFrame:newFrame];
}

- (CGFloat)right{
    return self.frame.origin.x + self.frame.size.width;
}

- (void)setRight:(CGFloat)right{
    CGRect frame = self.frame;
    frame.origin.x = right - frame.size.width;
    self.frame = frame;
}

- (CGFloat)bottom{
    return self.frame.origin.y + self.frame.size.height;
}

- (void)setBottom:(CGFloat)bottom{
    CGRect frame = self.frame;
    frame.origin.y = bottom - frame.size.height;
    self.frame = frame;
}
@end
