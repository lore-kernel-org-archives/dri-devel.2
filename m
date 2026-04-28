Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64484FF885D
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 07:55:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B729010EA55;
	Tue, 28 Apr 2026 07:55:22 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="0AylN9PY";
	dkim-atps=neutral
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E46610EA55
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 07:55:20 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=dMM1zZxzcfqLuXnRjbxvAd9Sn9DUzIuOxrv48y1vvzQ=;
 b=0AylN9PYW5mrS0hudtBiqhOYkG3DzEICJIWBJiL6vNWawOTcIZCrjJjmLcM+Evo0vYjqYj+1W
 DkOGPngQqND++dYtrWVCGD39YLFpXTNyY5cH+Asd+Lezloj0KXdQuhRrxmWoPkf+f6ogMTmcaSk
 lczJ18wrznciEWAZ7q2n+kQ=
Received: from mail.maildlp.com (unknown [172.19.162.140])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4g4Xbk0W8Mz12LCb;
 Tue, 28 Apr 2026 15:48:02 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 0827220333;
 Tue, 28 Apr 2026 15:55:16 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 15:55:14 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 15:55:14 +0800
Message-ID: <bea1d1d3-c326-48f1-a103-559e7e954001@huawei.com>
Date: Tue, 28 Apr 2026 15:55:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 3/4] drm/hisilicon/hibmc: move
 display contrl config to hibmc_probe()
To: Thomas Zimmermann <tzimmermann@suse.de>,
 <dmitry.baryshkov@oss.qualcomm.com>, <tiantao6@hisilicon.com>,
 <xinliang.liu@linaro.org>, <maarten.lankhorst@linux.intel.com>,
 <mripard@kernel.org>, <airlied@gmail.com>, <daniel@ffwll.ch>,
 <kong.kongxinwei@hisilicon.com>
CC: <liangjian010@huawei.com>, <chenjianmin@huawei.com>,
 <fengsheng5@huawei.com>, <helin52@h-partners.com>, <shenjian15@huawei.com>,
 <shaojijie@huawei.com>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, <shiyongbang@huawei.com>
References: <20260423063233.1267631-1-shiyongbang@huawei.com>
 <20260423063233.1267631-4-shiyongbang@huawei.com>
 <e51bb7e2-0d57-42a1-be53-6560cebf2df6@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <e51bb7e2-0d57-42a1-be53-6560cebf2df6@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems500002.china.huawei.com (7.221.188.17) To
 kwepemq100007.china.huawei.com (7.202.195.175)
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

> Hi
> 
> Am 23.04.26 um 08:32 schrieb Yongbang Shi:
>> From: Lin He <helin52@huawei.com>
>>
>> If there's no VGA output, this encoder modeset won't be called, which
>> will cause displaying data from GPU being cut off. It's actually a
>> common display config for DP and VGA, so move the vdac encoder modeset
>> to driver load stage.
>>
>> Fixes: 5294967f4ae4 ("drm/hisilicon/hibmc: Add support for VDAC")
>> Signed-off-by: Lin He <helin52@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
>> ChangeLog:
>> v1 -> v2:
>>    - remove tag "Reviewed-by: Tao Tian <tiantao6@hisilicon.com>", witch will
>>      be given in public.
>>    - add 'drm-misc-fixes' in subject prefix.
>> ---
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c   | 14 ++++++++++++
>>   .../gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c  | 22 -------------------
>>   2 files changed, 14 insertions(+), 22 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index d409efc34215..f8ab471f92e7 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -217,6 +217,18 @@ void hibmc_set_current_gate(struct hibmc_drm_private *priv, unsigned int gate)
>>       writel(gate, mmio + gate_reg);
>>   }
>>   +static void hibmc_display_ctrl(struct hibmc_drm_private *priv)
>> +{
>> +    u32 reg;
>> +
>> +    reg = readl(priv->mmio + HIBMC_DISPLAY_CONTROL_HISILE);
>> +    reg |= HIBMC_DISPLAY_CONTROL_FPVDDEN(1);
>> +    reg |= HIBMC_DISPLAY_CONTROL_PANELDATE(1);
>> +    reg |= HIBMC_DISPLAY_CONTROL_FPEN(1);
>> +    reg |= HIBMC_DISPLAY_CONTROL_VBIASEN(1);
> 
> That might be stupid question: IDK what these bits mean, but the FPVDDEN and FPEN sound like they enable something. If
> you do this unconditionally in HW init, does it prevent power saving?  And is the system goes through suspend/resume, 
> does it need to be re-enabled?
> 
> My gut feeling would be to put this code into the CRTC.
> 

We discussed this with the chip design team and confirmed, after reviewing the chip's RTL code, that FPVDDEN, FPEN and
VBIASEN are not used in the chip's RTL implementation; only PANELDATE is used, and this bit controls the output of the
data, hsync and vsync signals simultaneously. We will remove FPVDDEN, FPEN and VBIASEN in v6, and do some tests.

This PANELDATE should be enabled during initialization. In older versions of the driver, since there was only one
encoder-connector(VGA), placing it in `encoder_helper` posed no practical issues. Now that it has been moved to the
initialization phase, it is enabled only once during initialization, in accordance with the chip's original design
intent, which better aligns with the original design.

Regarding suspend/resume operations and power saving, we have implemented `atomic_enable` and `atomic_disable` for CRTC.
These hook functions configure hsync and vsync for the DPMS switch[1]. Moving the `DISPLAY_CONTROL_HISILE.PANELDATE`
enable flag to the initialization phase does not affect power saving.

[1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_de.c#L190

Thanks,
Yongbang.

> Best regards
> Thomas
> 
>> +    writel(reg, priv->mmio + HIBMC_DISPLAY_CONTROL_HISILE);
>> +}
>> +
>>   static void hibmc_hw_config(struct hibmc_drm_private *priv)
>>   {
>>       u32 reg;
>> @@ -248,6 +260,8 @@ static void hibmc_hw_config(struct hibmc_drm_private *priv)
>>       reg |= HIBMC_MSCCTL_LOCALMEM_RESET(1);
>>         writel(reg, priv->mmio + HIBMC_MISC_CTRL);
>> +
>> +    hibmc_display_ctrl(priv);
>>   }
>>     static int hibmc_hw_map(struct hibmc_drm_private *priv)
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> index dc40018dbd21..9d924740c110 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> @@ -86,26 +86,6 @@ static const struct drm_connector_funcs hibmc_connector_funcs = {
>>       .atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
>>   };
>>   -static void hibmc_encoder_mode_set(struct drm_encoder *encoder,
>> -                   struct drm_display_mode *mode,
>> -                   struct drm_display_mode *adj_mode)
>> -{
>> -    u32 reg;
>> -    struct drm_device *dev = encoder->dev;
>> -    struct hibmc_drm_private *priv = to_hibmc_drm_private(dev);
>> -
>> -    reg = readl(priv->mmio + HIBMC_DISPLAY_CONTROL_HISILE);
>> -    reg |= HIBMC_DISPLAY_CONTROL_FPVDDEN(1);
>> -    reg |= HIBMC_DISPLAY_CONTROL_PANELDATE(1);
>> -    reg |= HIBMC_DISPLAY_CONTROL_FPEN(1);
>> -    reg |= HIBMC_DISPLAY_CONTROL_VBIASEN(1);
>> -    writel(reg, priv->mmio + HIBMC_DISPLAY_CONTROL_HISILE);
>> -}
>> -
>> -static const struct drm_encoder_helper_funcs hibmc_encoder_helper_funcs = {
>> -    .mode_set = hibmc_encoder_mode_set,
>> -};
>> -
>>   int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>   {
>>       struct drm_device *dev = &priv->dev;
>> @@ -128,8 +108,6 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>           goto err;
>>       }
>>   -    drm_encoder_helper_add(encoder, &hibmc_encoder_helper_funcs);
>> -
>>       ret = drm_connector_init_with_ddc(dev, connector,
>>                         &hibmc_connector_funcs,
>>                         DRM_MODE_CONNECTOR_VGA,
> 

