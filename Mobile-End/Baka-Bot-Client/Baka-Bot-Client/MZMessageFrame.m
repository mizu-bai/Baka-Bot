//
// Created by mizu bai on 2021/8/21.
//

#import "MZMessageFrame.h"
#import "MZMessage.h"

@implementation MZMessageFrame {

}

- (void)setMessage:(MZMessage *)message {
    _message = message;

    // time label
    CGFloat timeLabelX = 0;
    CGFloat timeLabelY = 0;
    CGFloat timeLabelWidth = kScreenWidth;
    CGFloat timeLabelHeight = 15;
    _timeLabelFrame = CGRectMake(timeLabelX, timeLabelY, timeLabelWidth, timeLabelHeight);

    // icon image
    CGFloat iconImageWidth = 30;
    CGFloat iconImageHeight = 30;
    CGFloat iconImageY = message.timeLabelHidden ? 0 : CGRectGetMaxY(_timeLabelFrame) + kMargin;
    CGFloat iconImageX = message.type == MZMessageServer ? kMargin : kScreenWidth - kMargin - iconImageWidth;
    _iconImageFrame = CGRectMake(iconImageX, iconImageY, iconImageWidth, iconImageHeight);

    // text button
    CGSize textSize = [self sizeOfText:message.content WithMaxSize:CGSizeMake(kScreenWidth * 0.6, CGFLOAT_MAX) font:kTextFont];
    CGFloat textButtonWidth = textSize.width;
    CGFloat textButtonHeight = textSize.height;
    CGFloat textButtonX = message.type == MZMessageServer ? CGRectGetMaxX(_iconImageFrame) : (kScreenWidth - kMargin - iconImageWidth - textButtonWidth);
    CGFloat textButtonY = iconImageY;
    _textButtonFrame = CGRectMake(textButtonX, textButtonY, textButtonWidth, textButtonHeight);

    // row height
    _rowHeight = MAX(CGRectGetMaxY(_textButtonFrame), CGRectGetMaxY(_iconImageFrame)) + kMargin;
}

// calculate text size
- (CGSize)sizeOfText:(NSString *)text WithMaxSize:(CGSize)maxSize font:(UIFont *)font {
    NSDictionary *attrs = @{NSFontAttributeName : font};
    CGSize textSize = [text boundingRectWithSize:maxSize options:NSStringDrawingUsesLineFragmentOrigin attributes:attrs context:nil].size;
    return textSize;
}


@end