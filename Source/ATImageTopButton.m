//
//  ATImageTopButton.m
//  Postre
//
//  Created by 王炜圣 on 2017/4/6.
//  Copyright © 2017年 王炜圣. All rights reserved.
//

#import "ATImageTopButton.h"

@implementation UIButton (ImagePosition)
- (void)setImagePosition:(UIButtonImagePosition)postion spaceToTitle:(CGFloat)space {
    // 1. 得到imageView和titleLabel的宽、高
    CGFloat imageWith = self.imageView.frame.size.width;
    CGFloat imageHeight = self.imageView.frame.size.height;
    
    CGFloat labelWidth = 0.0;
    CGFloat labelHeight = 0.0;
    
    labelWidth = self.titleLabel.intrinsicContentSize.width;
    labelHeight = self.titleLabel.intrinsicContentSize.height;
    
    // 2. 声明全局的imageEdgeInsets和labelEdgeInsets
    UIEdgeInsets imageEdgeInsets = UIEdgeInsetsZero;
    UIEdgeInsets labelEdgeInsets = UIEdgeInsetsZero;
    
    // 3. 根据style和space得到imageEdgeInsets和labelEdgeInsets的值
    switch (postion) {
        case UIBUttonImagePositionTop: {
            imageEdgeInsets = UIEdgeInsetsMake(-labelHeight - space/2, 0, 0, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith, -imageHeight - space/2, 0);
        }
            break;
        case UIBUttonImagePositionLeft: {
            imageEdgeInsets = UIEdgeInsetsMake(0, -space/2, 0, space/2);
            labelEdgeInsets = UIEdgeInsetsMake(0, space/2, 0, -space/2);
        }
            break;
        case UIBUttonImagePositionBottom: {
            imageEdgeInsets = UIEdgeInsetsMake(0, 0, -labelHeight - space/2, -labelWidth);
            labelEdgeInsets = UIEdgeInsetsMake(-imageHeight - space/2, -imageWith, 0, 0);
        }
            break;
        case UIBUttonImagePositionRight: {
            imageEdgeInsets = UIEdgeInsetsMake(0, labelWidth + space/2, 0, -labelWidth - space/2);
            labelEdgeInsets = UIEdgeInsetsMake(0, -imageWith - space/2, 0, imageWith + space/2);
        }
            break;
        default:
            break;
    }
    
    // 4. 赋值
    self.titleEdgeInsets = labelEdgeInsets;
    self.imageEdgeInsets = imageEdgeInsets;
}
@end

@implementation ATImageTopButton
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    contentRect = self.bounds;
    CGSize textSize = self.titleLabel.intrinsicContentSize;
    CGSize imgSize = self.currentImage.size;
    if (contentRect.size.width > 0 && imgSize.width > contentRect.size.width) {
        imgSize.height *= contentRect.size.width / imgSize.width;
        imgSize.width = contentRect.size.width;
    }
    CGFloat maxH = (contentRect.size.height - textSize.height - self.imageMarning);
    if (maxH > 0 && imgSize.height > maxH) {
        imgSize.width *= maxH / imgSize.height;
        imgSize.height = maxH;
    }
    return CGRectMake((contentRect.size.width - imgSize.width)/2,
                      (contentRect.size.height - imgSize.height - textSize.height - self.imageMarning)/2,
                      imgSize.width,
                      imgSize.height);
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    contentRect = self.bounds;
    CGSize imgSize = self.currentImage.size;
    CGRect rect = contentRect;
    rect.size.width += imgSize.width;
    CGSize textSize = [super titleRectForContentRect:rect].size;
    if (contentRect.size.width > 0 && imgSize.width > contentRect.size.width) {
        imgSize.height *= contentRect.size.width / imgSize.width;
        imgSize.width = contentRect.size.width;
    }
    CGFloat maxH = (contentRect.size.height - textSize.height - self.imageMarning);
    if (maxH > 0 && imgSize.height > maxH) {
        imgSize.width *= maxH / imgSize.height;
        imgSize.height = maxH;
    }
    return CGRectMake((contentRect.size.width - textSize.width)/2,
                      (contentRect.size.height - textSize.height + imgSize.height + self.imageMarning)/2,
                      textSize.width,
                      textSize.height);
}
- (CGSize)intrinsicContentSize {
    CGSize textSize = self.titleLabel.intrinsicContentSize;
    CGSize imgSize = self.currentImage.size;
    return CGSizeMake(MAX(textSize.width, imgSize.width), imgSize.height + textSize.height + self.imageMarning);
}
@end

@implementation ATImageRightButton
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect rect = [super imageRectForContentRect:contentRect];
    if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentCenter) {
        rect.origin.x = contentRect.size.width - rect.size.width - rect.origin.x + self.imageMarning/2;
    }
    else if (self.contentHorizontalAlignment == UIControlContentHorizontalAlignmentRight) {
        rect.origin.x = contentRect.size.width - rect.size.width - self.imageEdgeInsets.right;
    }
    return rect;
}

- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect rect = [super titleRectForContentRect:contentRect];
    CGSize imgSize = self.currentImage.size;
    rect.origin.x = rect.origin.x - imgSize.width - self.imageMarning/2;
    return rect;
}
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    size.width += self.imageMarning;
    return size;
}
@end

@implementation ATMargingButton
- (CGRect)imageRectForContentRect:(CGRect)contentRect {
    CGRect rect = [super imageRectForContentRect:contentRect];
    rect.origin.x -= self.currentImage ? self.imageMarning/2 : 0;
    return rect;
}
- (CGRect)titleRectForContentRect:(CGRect)contentRect {
    CGRect rect = [super titleRectForContentRect:contentRect];
    rect.origin.x += self.currentImage ? self.imageMarning/2 : 0;
    return rect;
}
- (void)setImageMarning:(CGFloat)imageMarning {
    _imageMarning = imageMarning;
    [self invalidateIntrinsicContentSize];
}
- (CGSize)intrinsicContentSize {
    CGSize size = [super intrinsicContentSize];
    if (self.currentImage && self.currentTitle) {
        size.width += self.imageMarning;
    }
    else if (self.currentTitle) {
        return [self.titleLabel intrinsicContentSize];
    }
    return size;
}
- (CGSize)sizeThatFits:(CGSize)size {
    CGSize s = [super sizeThatFits:size];
    if (self.currentImage && self.currentTitle) {
        s.width += self.imageMarning;
    }
    else if (self.currentTitle) {
        return [self.titleLabel sizeThatFits:size];
    }
    return s;
}
@end


@implementation ATBorderButton
- (void)setSelected:(BOOL)selected {
    [super setSelected:selected];
    self.layer.borderColor = [self currentTitleColor].CGColor;
}
@end
