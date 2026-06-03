Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF13ECD6E5D
	for <dri-devel@archiver.kernel.org>; Wed,  3 Jun 2026 01:33:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03CDB113BD3;
	Wed,  3 Jun 2026 01:33:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="DpCRBhYh";
	dkim-atps=neutral
X-Greylist: delayed 303 seconds by postgrey-1.36 at gabe;
 Wed, 03 Jun 2026 01:33:53 UTC
Received: from mail-m81147.netease.com (mail-m81147.netease.com [47.88.81.147])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9375D113BD3
 for <dri-devel@lists.freedesktop.org>; Wed,  3 Jun 2026 01:33:53 +0000 (UTC)
Received: from [172.16.12.90] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 40d472abe;
 Wed, 3 Jun 2026 09:28:46 +0800 (GMT+08:00)
Message-ID: <91378132-8a8e-4bcc-9aa7-4de9fb135a6a@rock-chips.com>
Date: Wed, 3 Jun 2026 09:28:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 1/2] drm/rockchip: dsi: Add maximum per lane bit rate
 calculation
To: Heiko Stuebner <heiko@sntech.de>
Cc: Sandy Huang <hjc@rock-chips.com>, Andy Yan <andy.yan@rock-chips.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Guochun Huang <hero.huang@rock-chips.com>, Chaoyi Chen <kernel@airkyi.com>,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20260324085838.90-1-kernel@airkyi.com> <4888940.6M6d0yLqnL@phil>
Content-Language: en-US
From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
In-Reply-To: <4888940.6M6d0yLqnL@phil>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9e8b18ebda03a7kunma7a4b39932116e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaTU1NVktKGkhCGUhOSkodQ1YVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSU
 9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=DpCRBhYhHsk59imJ+FGOLy8d4MOtCjg9bDkKtXvNrDk5iWWBwZS1A4x0JDviW1oUGeFdDFS2d0NWdJVtU4YkUlRC3PajKAKdjolU8I8op2P1QcWAmkz2FKNW1VnFI1EwqOqeverIZpow5QyF0+1N/oei5IaiUWhLDi9TV/7d7fg=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=m1cnttQcMrvUZx5o8JPHBR3oI+NYB+tDa2bCbLIj358=;
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

On 6/3/2026 4:59 AM, Heiko Stuebner wrote:
> Am Dienstag, 24. März 2026, 09:58:37 Mitteleuropäische Sommerzeit schrieb Chaoyi Chen:
>> From: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>>
>> Different chips have varying support for the maximum bit rate per lane.
>>
>> Add calculation for the maximum per lane bit rate for various chip
>> platforms, and relax the bandwidth margin requirements.
>>
>> Signed-off-by: Chaoyi Chen <chaoyi.chen@rock-chips.com>
>> ---
>>  .../gpu/drm/rockchip/dw-mipi-dsi-rockchip.c   | 21 +++++++++++++++----
>>  1 file changed, 17 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> index 3547d91b25d3..d3bacfae174e 100644
>> --- a/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> +++ b/drivers/gpu/drm/rockchip/dw-mipi-dsi-rockchip.c
>> @@ -268,6 +268,7 @@ struct rockchip_dw_dsi_chip_data {
>>  
>>  	unsigned int flags;
>>  	unsigned int max_data_lanes;
>> +	unsigned long max_bit_rate_per_lane;
>>  };
>>  
>>  struct dw_mipi_dsi_rockchip {
>> @@ -565,7 +566,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>>  	int bpp;
>>  	unsigned long mpclk, tmp;
>>  	unsigned int target_mbps = 1000;
>> -	unsigned int max_mbps = dppa_map[ARRAY_SIZE(dppa_map) - 1].max_mbps;
>> +	unsigned int max_mbps;
>>  	unsigned long best_freq = 0;
>>  	unsigned long fvco_min, fvco_max, fin, fout;
>>  	unsigned int min_prediv, max_prediv;
>> @@ -573,6 +574,7 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>>  	unsigned long _fbdiv, best_fbdiv;
>>  	unsigned long min_delta = ULONG_MAX;
>>  
>> +	max_mbps = dsi->cdata->max_bit_rate_per_lane;
> 
> I may be blind, but how do the values come together?
> In the dppa_map table we have mbps values of 89 to 1500
> (MHz)
> 
> While below the values set are
> 	.max_bit_rate_per_lane = 1500000000UL,
> in Hz I guess
> 
> And I don't see the needed conversion somehow.
> 
>

Oh! It should be:

max_mbps = dsi->cdata->max_bit_rate_per_lane / USEC_PER_SEC;

Will fix in v2.

>>  	dsi->format = format;
>>  	bpp = mipi_dsi_pixel_format_to_bpp(dsi->format);
>>  	if (bpp < 0) {
>> @@ -584,8 +586,8 @@ dw_mipi_dsi_get_lane_mbps(void *priv_data, const struct drm_display_mode *mode,
>>  
>>  	mpclk = DIV_ROUND_UP(mode->clock, MSEC_PER_SEC);
>>  	if (mpclk) {
>> -		/* take 1 / 0.8, since mbps must big than bandwidth of RGB */
>> -		tmp = mpclk * (bpp / lanes) * 10 / 8;
>> +		/* take 1 / 0.9, since mbps must big than bandwidth of RGB */
>> +		tmp = mpclk * (bpp / lanes) * 10 / 9;
> 
> Please do this in a separate patch, especially as I would expect some
> sort of explanation on why this is ok to do.
>

Sure! I'll split this out in the new series.

-- 
Best, 
Chaoyi
