//
//  MLHotCell.h
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "MLLiveModel.h"
@interface MLHotCell : UITableViewCell
@property(nonatomic,strong)MLLiveModel *liveM;
+ (id)hotCellWithTableview:(UITableView *)tableView;
@end
