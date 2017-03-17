//
//  LWLabel.h
//  LabelText
//
//  Created by 吴狄 on 16/9/5.
//  Copyright © 2016年 Leven. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef void(^SelectRange) (NSString *, NSRange range);
@interface LWLabel : UILabel
@property (nonatomic,retain)NSMutableArray *rangeArr;
@property (nonatomic,copy)SelectRange selectBlobk;
@end
