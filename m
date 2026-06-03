Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6301CCD6E57
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:34:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A91113BD6;
	Wed,  3 Jun 2026 01:34:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="gzwYSJAZ";
	dkim-atps=neutral
Received: from mail-m6086.netease.com (mail-m6086.netease.com [210.79.60.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DD67A113BD6
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:34:32 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40d4cc4e8;
 Wed, 3 Jun 2026 09:34:29 +0800 (GMT+08:00)
Message-ID: <a473c5a2-b1f9-4cf8-85bb-d3ec1572cbe8@rock-chips.com>
Date: Wed, 3 Jun 2026 09:34:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] drm/rockchip: dsi: Add dphy_get_timing support for
 multiple PHY types
To: Heiko Stuebner <heiko@sntech.de>
Cc: dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
 Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guochun Huang <hero.huang@rock-chips.com>, Chaoyi Chen <kernel@airkyi.com>
References: <20260324085838.90-1-kernel@airkyi.com>
 <20260324085838.90-2-kernel@airkyi.com> <7091445.e8TTKsaY2g@phil>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <7091445.e8TTKsaY2g@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8b1e272b03a7kunm90780f18321e8e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVlCSE8dVkNMTR9DSUNMGkxMSFYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=gzwYSJAZtEjsJiFDXTJx3X3klY2kxyRngymRyZO/CboKLZ4h8irwxcCEeGyX/4ik7HcJIYhtzRcN48RWubO1+CNdphs94VR4/HiD0dJq7ShOOng0FAHP3mmqLCnuMneIWFjfLaJ6qckQdBgFJ7eHVyPbITPJ1a+LXjFeJvoGu9M=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=/YTKzn8x+ScPY0xOlbOt0GetCsCtokkL6paqigkGfsw=;
 h=date:mime-version:subject:message-id:from;
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Unsubscribe: <https://lists.freedesktop.org/mailman/options/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=unsubscribe>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Hi Heiko,

On 6/3/2026 5:02 AM, Heiko Stuebner wrote:
> Am Dienstag, 24. März 2026, 09:58:38 Mitteleuropäische Sommerzeit schrieb Chaoyi Chen:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Currently, there are generally two types of DPHY for Rockchip. One is
>> the DPHY used by RK3288/RK3399, whose timing is described by Table A-3
>> High-Speed Transition Times in the databook. The other is the DPHY used
>> by PX30 and its successors. If its timing is still described using
>> RK3288/RK3399, it may not perform correctly on some DSI panel.
>>
>> Add dphy_get_timing for different D-PHY types to adapt to timing
>> differences.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 45 ++++++++++++++++++-
>>  1 file changed, 43 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> index d3bacfae174e..2d1c9e54ff85 100644
>> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> @@ -247,6 +247,7 @@ enum {
>>  	BIASEXTR_127_7,
>>  };
>>  
>> +struct dw_mipi_dsi_rockchip;
>>  struct rockchip_dw_dsi_chip_data {
>>  	u32 reg;
>>  
>> @@ -262,6 +263,9 @@ struct rockchip_dw_dsi_chip_data {
>>  	u32 lanecfg2_grf_reg;
>>  	u32 lanecfg2;
>>  
>> +	int (*dphy_get_timing)(struct dw_mipi_dsi_rockchip *dsi, unsigned int lane_mbps,
>> +			       struct dw_mipi_dsi_dphy_timing *timing);
>> +
>>  	int (*dphy_rx_init)(struct phy *phy);
>>  	int (*dphy_rx_power_on)(struct phy *phy);
>>  	int (*dphy_rx_power_off)(struct phy *phy);
>> @@ -721,8 +725,9 @@ static struct hstt hstt_table[] = {
>>  };
>>  
>>  static int
>> -dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
>> -			   struct dw_mipi_dsi_dphy_timing *timing)
>> +dw_mipi_dsi_phy_rk3288_get_timing(struct dw_mipi_dsi_rockchip *dsi,
>> +				  unsigned int lane_mbps,
>> +				  struct dw_mipi_dsi_dphy_timing *timing)
>>  {
>>  	int i;
>>  
>> @@ -738,6 +743,32 @@ dw_mipi_dsi_phy_get_timing(void *priv_data, unsigned int lane_mbps,
>>  	return 0;
>>  }
>>  
>> +static const struct dw_mipi_dsi_dphy_timing dphy_timing_px30 = {
>> +	.clk_lp2hs = 0x40,
>> +	.clk_hs2lp = 0x40,
>> +	.data_lp2hs = 0x10,
>> +	.data_hs2lp = 0x14,
>> +};
> 
> so just to make sure, the timing on the px30 (and later) variant is the
> same for all lane speeds?
>

More precisely, it applies to this fixed value for INNO PHY used after PX30.

> Please include that bit in the commit description
> 

I will add more details in v2. Thank you!

-- 
Best, 
Chaoyi
