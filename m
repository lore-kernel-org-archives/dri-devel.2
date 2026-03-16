Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6C31F30295
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 03:22:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 15BFC10E2C1;
	Mon, 16 Mar 2026 03:22:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="BnqeoqLs";
	dkim-atps=neutral
Received: from mail-m1973198.qiye.163.com (mail-m1973198.qiye.163.com
 [220.197.31.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E29AA10E273
 for <dri-devel@lists.freedesktop.org>; Mon, 16 Mar 2026 03:22:39 +0000 (UTC)
Received: from [172.16.12.43] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 370ae76b1;
 Mon, 16 Mar 2026 11:17:30 +0800 (GMT+08:00)
Message-ID: <bebadd3b-2fd1-404e-bc64-205c8b44880c@rock-chips.com>
Date: Mon, 16 Mar 2026 11:17:30 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v10 11/18] drm/bridge: analogix_dp: Apply
 drm_bridge_connector helper
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, andrzej.hajda@intel.com,
 neil.armstrong@linaro.org, rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch,
 shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
 festevam@gmail.com, inki.dae@samsung.com, sw0312.kim@samsung.com,
 kyungmin.park@samsung.com, krzk@kernel.org, alim.akhtar@samsung.com,
 jingoohan1@gmail.com, p.zabel@pengutronix.de, hjc@rock-chips.com,
 heiko@sntech.de, andy.yan@rock-chips.com, dmitry.baryshkov@oss.qualcomm.com,
 dianders@chromium.org, m.szyprowski@samsung.com, jani.nikula@intel.com,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 imx@lists.linux.dev, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org
References: <20260310012458.169272-1-damon.ding@rock-chips.com>
 <20260310012458.169272-12-damon.ding@rock-chips.com>
 <DH1TKWREZMFK.3BY4NY36BXLXG@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DH1TKWREZMFK.3BY4NY36BXLXG@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9cf4a612fb03a3kunm3b3e64f61969b4
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGkpLSFZMThlITR4aQx8eHh9WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=BnqeoqLsGb84BqtPqXiW77m3kBjYMloScvhA6p+8X+sHkdC6G2lBx0K6yTjyx2Pd+6UWnlkIoQZFCKdzbWmIIexPdLKAY2fA5Z0jwBTHiGasgpMISS4eqkCCCA+fPdJ/F+0mi5Gxidvpe/xNvUK/wY8tWC6CoTyvjZ0pFwGHc0A=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=euD4SQJWyl0XJtyrMHkwNbP+gc8j+sYgCcDACn9mPo4=;
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

On 3/14/2026 1:10 AM, Luca Ceresoli wrote:
> Hello Damon,
> 
> On Tue Mar 10, 2026 at 2:24 AM CET, Damon Ding wrote:
>> Initialize bridge_connector for both Rockchip and Exynos encoder sides.
>> Then, make DRM_BRIDGE_ATTACH_NO_CONNECTOR mandatory for Analogix bridge
>> side, as the private &drm_connector is no longer created.
>>
>> The previous &drm_connector_funcs and &drm_connector_helper_funcs APIs
>> are replaced by the corresponding &drm_bridge_funcs APIs:
>>
>> analogix_dp_atomic_check() -> analogix_dp_bridge_atomic_check()
>> analogix_dp_detect()       -> analogix_dp_bridge_detect()
>> analogix_dp_get_modes()    -> analogix_dp_bridge_get_modes()
>>                                analogix_dp_bridge_edid_read()
>>
>> Additionally, the compatibilities of Analogix DP bridge based on whether
>> the next bridge is a 'panel'. If it is, OP_MODES and OP_DETECT are
>> supported; If not (the next bridge is a 'monitor' or a bridge chip),
>> OP_EDID and OP_DETECT are supported.
>>
>> The devm_drm_bridge_add() is placed in analogix_dp_bind() instead of
>> analogix_dp_probe(), because the type of next bridge (the panel, monitor
>> or bridge chip) can only be determined after the probe process has fully
>> completed.
>>
>> Signed-off-by: Damon Ding <damon.ding@rock-chips.com>
>> Tested-by: Marek Szyprowski <m.szyprowski@samsung.com>
>> Tested-by: Heiko Stuebner <heiko@sntech.de> (on rk3588)
> 
> ...
> 
>> @@ -73,15 +72,12 @@ static int exynos_dp_bridge_attach(struct analogix_dp_plat_data *plat_data,
>>   				   struct drm_bridge *bridge)
>>   {
>>   	struct exynos_dp_device *dp = to_dp(plat_data);
>> -	enum drm_bridge_attach_flags flags = 0;
>>   	int ret;
>>
>>   	/* Pre-empt DP connector creation if there's a bridge */
>>   	if (plat_data->next_bridge) {
>> -		if (dp->has_of_bridge)
>> -			flags = DRM_BRIDGE_ATTACH_NO_CONNECTOR;
>> -
>> -		ret = drm_bridge_attach(&dp->encoder, plat_data->next_bridge, bridge, flags);
>> +		ret = drm_bridge_attach(&dp->encoder, plat_data->next_bridge, bridge,
>> +					DRM_BRIDGE_ATTACH_NO_CONNECTOR);
> 
> Should this be 'flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR' to be future-proof?
> 

Aha, the exynos_dp_bridge_attach() and even 
&analogix_dp_plat_data.attach() have been removed in [PATCH v10 16/18] 
for consistency and simplification. Since the only bridge flag supported 
right now is DRM_BRIDGE_ATTACH_NO_CONNECTOR, let’s leave this as is for 
now. ;-)

Best regards,
Damon

