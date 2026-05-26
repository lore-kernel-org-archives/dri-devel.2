Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 131C4CD5BB1
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 12:35:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 749F910E19D;
	Tue, 26 May 2026 12:35:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Mri3/IGc";
	dkim-atps=neutral
Received: from mail-m82126.xmail.ntesmail.com (mail-m82126.xmail.ntesmail.com
 [156.224.82.126])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 85B1510E19D
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 12:35:36 +0000 (UTC)
Received: from [172.16.12.74] (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3fe38e512;
 Tue, 26 May 2026 20:35:31 +0800 (GMT+08:00)
Message-ID: <00565241-3962-4418-8711-859dc98dba13@rock-chips.com>
Date: Tue, 26 May 2026 20:35:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 2/2] drm/bridge: analogix_dp: Add support for optional
 data-lanes mapping
To: Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Marek Szyprowski <m.szyprowski@samsung.com>
Cc: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org, Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 dmitry.baryshkov@oss.qualcomm.com, dianders@chromium.org,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260525094731.121380-1-damon.ding@rock-chips.com>
 <20260525094731.121380-3-damon.ding@rock-chips.com>
 <177979727057.297330.10691183273720133245.b4-review@b4>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <177979727057.297330.10691183273720133245.b4-review@b4>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9e6448786d03a8kunm591ab7c8b8886b
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkZHktNVhhKTRhCH0gaHxoaTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Mri3/IGcBzNc+G9t8s5zfRoweaS3NFeHeZAVbKn66fIdfriaFiCCbSNgVT9cecYd24uwwupB6hn52vIM91IrI4Vc2uMrMpQwV1SrQ8zA1M2u2YsdZRT9h1lZC4z+ANp/d5pgObI9xFP5vO798m9/dNx7HD/Gkg8btotIad81iTk=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=oQ+OHMp99D8xoRZvJBBEvxSuLKoEVBXtdAFFTNEa6Rw=;
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

Hi Luca,

On 5/26/2026 8:07 PM, Luca Ceresoli wrote:
> On Mon, 25 May 2026 17:47:31 +0800, Damon Ding <damon.ding@rock-chips.com> wrote:
> 
> Hello Damon,
> 
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index 8cf6b73bceac..d53ab25bc57b 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -1234,6 +1234,59 @@ static const struct drm_bridge_funcs analogix_dp_bridge_funcs = {
>> [ ... skip 11 lines ... ]
>> +	int ret, i;
>> +
>> +	memcpy(video_info->lane_map, map, sizeof(map));
>> +
>> +	num_lanes = drm_of_get_data_lanes_count_ep(dp->dev->of_node, 1, 0, 1,
>> +						   video_info->max_lane_count);
> 
> Should num_lanes be > 4, the buffers could overflow. I realize it should
> not happen, but analogix_dp_dt_parse_pdata() can set max_lane_count from
> the device tree, so a bogus dtb could cause such overflow.
> 
> Perhaps you should just (in a separate patch) error out in
> analogix_dp_dt_parse_pdata() to prevent this. And maybe even adding an
> BUG_ON(lane_count > 4) here.
> 
> Otherwise LGTM.
> 

Thank you for the review.

I think it would be a better idea to add a separate patch to validate 
the max_link_rate and max_lane_count values for Exynos DP.

I checked the Exynos DP related DTS files:
- The maximum value of samsung,lane-count is 4
- The maximum value of samsung,link-rate is 0x0a, which corresponds to 
the HBR lane rate.

Could Marek please help confirm if we can set these as the upper limits 
for the checks?

Best regards,
Damon

