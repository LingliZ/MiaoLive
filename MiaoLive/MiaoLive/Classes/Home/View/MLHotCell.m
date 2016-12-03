//
//  MLHotCell.m
//  MiaoLive
//
//  Created by 王鑫 on 16/12/3.
//  Copyright © 2016年 王鑫. All rights reserved.
//

#import "MLHotCell.h"
#import "UIImage+ALinExtension.h"

@interface MLHotCell()
@property (weak, nonatomic) IBOutlet UIImageView *headerIcon;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *addressLabel;
@property (weak, nonatomic) IBOutlet UIImageView *levelLabel;
@property (weak, nonatomic) IBOutlet UILabel *seeNumLable;
@property (weak, nonatomic) IBOutlet UIImageView *bgView;

@end


@implementation MLHotCell


+ (id)hotCellWithTableview:(UITableView *)tableView{
    static NSString *identifier = @"MLHotCell";
    UINib *nib = [UINib nibWithNibName:@"MLHotCell" bundle:nil];
    [tableView registerNib:nib forCellReuseIdentifier:identifier];
    return [[nib instantiateWithOwner:nib options:nil] lastObject];
}

- (void)awakeFromNib {
    [super awakeFromNib];
    
}


- (void)setLiveM:(MLLiveModel *)liveM{
    [self.headerIcon sd_setImageWithURL:[NSURL URLWithString:liveM.smallpic]
                       placeholderImage:[UIImage imageNamed:@"placeholder_head"]
                                options:SDWebImageRefreshCached completed:^(UIImage *image, NSError *error, SDImageCacheType cacheType, NSURL *imageURL) {
        image = [UIImage  circleImage:image borderColor:[UIColor redColor] borderWidth:1];
        self.headerIcon.image = image;
    }];
    
    self.nameLabel.text = liveM.myname;
    // 如果没有地址, 给个默认的地址
    if (!liveM.gps.length) {
        liveM.gps = @"喵星";
    }
//    [self.addressLabel setTitle:live.gps forState:UIControlStateNormal];
    [self.addressLabel setText:liveM.gps];
    [self.bgView sd_setImageWithURL:[NSURL URLWithString:liveM.bigpic]
                       placeholderImage:[UIImage imageNamed:@"profile_user_414x414"]];
    self.levelLabel.image  = liveM.starImage;
    self.levelLabel.hidden = !liveM.starlevel;
    
    // 设置当前观众数量
    NSString *fullChaoyang = [NSString stringWithFormat:@"%ld人在看", liveM.allnum];
    NSRange range = [fullChaoyang rangeOfString:[NSString stringWithFormat:@"%ld", liveM.allnum]];
    NSMutableAttributedString *attr = [[NSMutableAttributedString alloc] initWithString:fullChaoyang];
    [attr addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:17] range: range];
    [attr addAttribute:NSForegroundColorAttributeName value:[UIColor redColor] range:range];
    self.nameLabel.attributedText = attr;
}
@end
