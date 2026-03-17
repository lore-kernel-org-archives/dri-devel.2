Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A17C9FB5E8B
	for <dri-devel@archiver.kernel.org>; Tue, 17 Mar 2026 01:29:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 13D5010E1AF;
	Tue, 17 Mar 2026 01:29:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="PJJ2468G";
	dkim-atps=neutral
Received: from mail-m49221.qiye.163.com (mail-m49221.qiye.163.com
 [45.254.49.221])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 76BBA10E1AF
 for <dri-devel@lists.freedesktop.org>; Tue, 17 Mar 2026 01:29:55 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 372ee763f;
 Tue, 17 Mar 2026 09:29:50 +0800 (GMT+08:00)
Message-ID: <a24e2a09-86a6-4c59-b219-7bfe9c74a4a5@rock-chips.com>
Date: Tue, 17 Mar 2026 09:29:50 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v1 3/4] drm/bridge: analogix_dp: Add support for RK3576
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, alchark@gmail.com,
 cristian.ciocaltea@collabora.com, sebastian.reichel@collabora.com,
 kever.yang@rock-chips.com, dmitry.baryshkov@oss.qualcomm.com,
 luca.ceresoli@bootlin.com, dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org
References: <20260310105307.309765-1-damon.ding@rock-chips.com>
 <20260310105307.309765-4-damon.ding@rock-chips.com>
 <2032185.PYKUYFuaPT@workhorse>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <2032185.PYKUYFuaPT@workhorse>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0a9cf969dbe503a3kunm8ccf497d220f1e
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGUNKSlZOSB8dQk9KHk8eT0lWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=PJJ2468GOrg1YUeWzfIDkcNmJ93zOHxs2Aqc+k9HqwCiHWzw6l7ATKA+c/pDZKGoII0WDacnZmHNKE5yxtnzLMvHZ5VIfc4R+7iD0rgoqt9aWl8OJvGBiHpo869fXb5vGZbLS4vw2/Kzk06d4gvMsWl2g3m2+2GZAYK4/X/rUO0=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=/B8DeTrHPb3y1Zv+MpxLUNG3NZwclQ3c6Iyu/xxMENc=;
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

Hi Nicolas,

On 3/16/2026 7:14 PM, Nicolas Frattaroli wrote:
> On Tuesday, 10 March 2026 11:53:06 Central European Standard Time Damon Ding wrote:
>> Expand enum analogix_dp_devtype with RK3576_EDP, and add max_link_rate
>> and max_lane_count configs for it.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> ---
>>   drivers/gpu/drm/bridge/analogix/analogix_dp_core.c | 1 +
>>   include/drm/bridge/analogix_dp.h                   | 3 ++-
>>   2 files changed, 3 insertions(+), 1 deletion(-)
>>
>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> index fe7158d9edde..c4e49e8186ab 100644
>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> @@ -1248,6 +1248,7 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
>>   		video_info->max_link_rate = 0x0A;
>>   		video_info->max_lane_count = 0x04;
>>   		break;
>> +	case RK3576_EDP:
>>   	case RK3588_EDP:
>>   		video_info->max_link_rate = 0x14;
>>   		video_info->max_lane_count = 0x04;
>> diff --git a/include/drm/bridge/analogix_dp.h b/include/drm/bridge/analogix_dp.h
>> index 854af692229b..d1a6e6d44a2b 100644
>> --- a/include/drm/bridge/analogix_dp.h
>> +++ b/include/drm/bridge/analogix_dp.h
>> @@ -16,12 +16,13 @@ enum analogix_dp_devtype {
>>   	EXYNOS_DP,
>>   	RK3288_DP,
>>   	RK3399_EDP,
>> +	RK3576_EDP,
>>   	RK3588_EDP,
>>   };
>>   
>>   static inline bool is_rockchip(enum analogix_dp_devtype type)
>>   {
>> -	return type == RK3288_DP || type == RK3399_EDP || type == RK3588_EDP;
>> +	return type == RK3288_DP || type == RK3399_EDP || type == RK3576_EDP || type == RK3588_EDP;
> 
> I think we can make this easier to read with a switch statement. In
> a separate patch, we may also want to rename `is_rockchip` to
> `analogix_dp_is_rockchip`, as e.g. rockchip_drm_vop.c and exynos_dp.c
> both include his header file as well.
> 
> Switch statement would make the function look something like:
> 
> static inline bool is_rockchip(enum analogix_dp_devtype type)
> {
> 	switch (type) {
> 	case RK3288_DP:
> 	case RK3399_EDP:
> 	case RK3576_EDP:
> 	case RK3588_EDP:
> 		return true;
> 	default:
> 		return false;
> 	}
> }
> 

Good idea, will do in v2. :-)

Best regards,
Damon

