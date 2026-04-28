Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B25C5FF885A
	for <dri-devel@archiver.kernel.org>; Tue, 28 Apr 2026 03:58:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F72210E0A4;
	Tue, 28 Apr 2026 03:58:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="haIvnwVi";
	dkim-atps=neutral
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D63F10E0A4
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Apr 2026 03:58:13 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=9uvAQrGbHqfNFW7sqs72grBEDXAg9CIsXN8dnmzXKOI=;
 b=haIvnwViAbEymquQdqzwSrVA9dX1iaY73J3l9qdXohLMcEHsyLuwtNV38kEV3Mel/QnX5ToH3
 Z4+RNZG/XVDDaL/8eJxxCgMBW6htFnWhNfXFCIPk1aziZkgMd+5ZycEgrl/XwJLnCky6uN98HxR
 PeH40gTxsZ9JqxLYFBwT5QY=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g4RLv6VTTzpSvW;
 Tue, 28 Apr 2026 11:51:35 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id A849340561;
 Tue, 28 Apr 2026 11:58:10 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 11:58:10 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 28 Apr 2026 11:58:09 +0800
Message-ID: <cc33b5df-4048-423f-97d9-b00ca04b2d99@huawei.com>
Date: Tue, 28 Apr 2026 11:58:09 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v5 2/4] drm/hisilicon/hibmc: fix no
 showing when no connectors connected
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
 <20260423063233.1267631-3-shiyongbang@huawei.com>
 <27864583-4211-4553-bdc0-42dadd25d212@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <27864583-4211-4553-bdc0-42dadd25d212@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
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


> Hi,
> 
> sorry for not getting to the review earlier. See my comments below.
> 
> 
> Am 23.04.26 um 08:32 schrieb Yongbang Shi:
> [...]
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> index 31316fe1ea8d..dfaeabd05d46 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/dp/dp_hw.h
>> @@ -55,6 +55,7 @@ struct hibmc_dp {
>>       struct drm_dp_aux aux;
>>       struct hibmc_dp_cbar_cfg cfg;
>>       u32 irq_status;
>> +    int phys_state;
> 
> I think the correct term is 'status' instead of 'state'.
> 

Okay. The `status` is a better fit, and it corresponds to `drm_connector_status`.

>>   };
>>     int hibmc_dp_hw_init(struct hibmc_dp *dp);
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> index 35dff7bfbf76..8fe2eb51a0b3 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_dp.c
>> @@ -61,27 +61,38 @@ static int hibmc_dp_detect(struct drm_connector *connector,
>>   {
>>       struct hibmc_dp *dp = to_hibmc_dp(connector);
>>       struct hibmc_dp_dev *dp_dev = dp->dp_dev;
>> -    int ret;
>> +    int ret = connector_status_disconnected;
>>         if (dp->irq_status) {
>> -        if (dp_dev->hpd_status != HIBMC_HPD_IN)
>> -            return connector_status_disconnected;
>> +        if (dp_dev->hpd_status != HIBMC_HPD_IN) {
>> +            ret = connector_status_disconnected;
>> +            goto exit;
>> +        }
>>       }
>>   -    if (!hibmc_dp_get_dpcd(dp_dev))
>> -        return connector_status_disconnected;
>> +    if (!hibmc_dp_get_dpcd(dp_dev)) {
>> +        ret = connector_status_disconnected;
>> +        goto exit;
>> +    }
>>   -    if (!dp_dev->is_branch)
>> -        return connector_status_connected;
>> +    if (!dp_dev->is_branch) {
>> +        ret = connector_status_connected;
>> +        goto exit;
>> +    }
>>         if (drm_dp_read_sink_count_cap(connector, dp_dev->dpcd, &dp_dev->desc) &&
>>           dp_dev->downstream_ports[0] & DP_DS_PORT_HPD) {
>>           ret = drm_dp_read_sink_count(dp_dev->aux);
>> -        if (ret > 0)
>> -            return connector_status_connected;
>> +        if (ret > 0) {
>> +            ret = connector_status_connected;
>> +            goto exit;
>> +        }
>>       }
>>   -    return connector_status_disconnected;
>> +exit:
>> +    dp->phys_state = ret;
>> +
>> +    return ret;
>>   }
>>     static int hibmc_dp_mode_valid(struct drm_connector *connector,
>> @@ -243,5 +254,7 @@ int hibmc_dp_init(struct hibmc_drm_private *priv)
>>         connector->polled = DRM_CONNECTOR_POLL_HPD;
>>   +    dp->phys_state = connector_status_disconnected;
>> +
>>       return 0;
>>   }
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> index 289304500ab0..d409efc34215 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.c
>> @@ -24,6 +24,7 @@
>>   #include <drm/drm_managed.h>
>>   #include <drm/drm_module.h>
>>   #include <drm/drm_vblank.h>
>> +#include <drm/drm_probe_helper.h>
>>     #include "hibmc_drm_drv.h"
>>   #include "hibmc_drm_regs.h"
>> @@ -162,6 +163,8 @@ static int hibmc_kms_init(struct hibmc_drm_private *priv)
>>       drm_for_each_encoder(encoder, dev)
>>           encoder->possible_clones = clone_mask;
>>   +    drm_kms_helper_poll_init(dev);
> 
> So I think this is too early. This function will periodically poll connector, but they may have not been set up fully.
> Rather call this function after drm_mode_config_reset() in hibmc_load().
> 

You're right; calling `drm_kms_helper_poll_init` immediately starts the timer, so this call should be placed after
`drm_mode_config_reset`.

>> +
>>       return 0;
>>   }
>>   @@ -279,6 +282,7 @@ static int hibmc_hw_init(struct hibmc_drm_private *priv)
>>     static void hibmc_unload(struct drm_device *dev)
>>   {
>> +    drm_kms_helper_poll_fini(dev);
> 
> Init with drmm_kms_helper_poll_init() [1] and avoid this clean-up call entirely.  In DRM we generally prefer managed
> init/cleanup over manual one.
> 

Okay.

> [1] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/drm_probe_helper.c#L963
> 
>>       drm_atomic_helper_shutdown(dev);
>>   }
>>   diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> index ca8502e2760c..6abb49b5107b 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_drv.h
>> @@ -31,6 +31,7 @@ struct hibmc_vdac {
>>       struct drm_connector connector;
>>       struct i2c_adapter adapter;
>>       struct i2c_algo_bit_data bit_data;
>> +    int phys_state;
> 
> 'phys_status' would again be more appropriate.
> 

Okay.

>>   };
>>     struct hibmc_drm_private {
>> diff --git a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> index 841e81f47b68..dc40018dbd21 100644
>> --- a/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> +++ b/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c
>> @@ -25,27 +25,20 @@
>>   static int hibmc_connector_get_modes(struct drm_connector *connector)
>>   {
>>       struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
>> -    const struct drm_edid *drm_edid;
>> -    int count;
>> +    int count = 0;
>>   -    drm_edid = drm_edid_read_ddc(connector, &vdac->adapter);
>> +    if (vdac->phys_state == connector_status_connected)
>> +        count = drm_connector_helper_get_modes(connector);
>>   -    drm_edid_connector_update(connector, drm_edid);
>> -
>> -    if (drm_edid) {
>> -        count = drm_edid_connector_add_modes(connector);
>> -        if (count)
>> -            goto out;
>> -    }
>> +    if (count > 0)
>> +        return count;
> 
> There's a problem with the overall logic here: if the physical status is 'connected' and the helper could not retrieve
> any modes, the helper should return 0 here. Then the DRM helpers do the right thing with setting up a few modes or an
> EDID override as a fallback. See [2]. For example, on my broken test system, I'd be able to provide my display's EDID
> and get the correct output.
> 
> [2] https://elixir.bootlin.com/linux/v7.0.1/source/drivers/gpu/drm/drm_probe_helper.c#L436
> 
> Any code below is BMC setup and should run in an else branch, just like in ast.
> 

The `drm_edid_override_connector_update` interface is used to retrieve an overridden EDID from debugfs or from firmware:
  * Debugfs: Requires the user to manually perform file operations to configure it;
  * Firmware: Requires the distribution’s operating system or the user to place the EDID binary file in the
              `/lib/firmware/` directory, and the `drm.edid_firmware` parameter must be specified in the GRUB boot
              parameters;

The modification method you provided allows for display even when the EDID cannot be retrieved. But both of these
methods require cooperation from the user or the distribution's operating system, making implementation relatively
difficult.

Our use case requires that the KVM's display functionality remain intact even when no VGA or DisplayPort monitor is
connected. I believe setting `drm_set_preferred_mode` (1024x768) as the default resolution when no monitor is present
would be a more universal solution. Similarly, on your test system, this approach would ensure basic display functionality.

> 
>>   +    drm_edid_connector_update(connector, NULL);
>>       count = drm_add_modes_noedid(connector,
>>                        connector->dev->mode_config.max_width,
>>                        connector->dev->mode_config.max_height);
>>       drm_set_preferred_mode(connector, 1024, 768);
>>   -out:
>> -    drm_edid_free(drm_edid);
>> -
>>       return count;
>>   }
>>   @@ -57,10 +50,32 @@ static void hibmc_connector_destroy(struct drm_connector *connector)
>>       drm_connector_cleanup(connector);
>>   }
>>   +static int hibmc_vdac_detect(struct drm_connector *connector,
>> +                 struct drm_modeset_acquire_ctx *ctx,
>> +                 bool force)
>> +{
>> +    struct hibmc_drm_private *priv = to_hibmc_drm_private(connector->dev);
>> +    int state = drm_connector_helper_detect_from_ddc(connector, ctx,
>> +                             force);
> 
> 'state' -> 'status'
> 

Okay.

>> +    struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
>> +
>> +    if (priv->dp.phys_state == connector_status_connected)
>> +        return vdac->phys_state = state;
> 
> Please only one statement per line. First assign, then return.
> 

Yes, Sorry about that. According to the Linux kernel coding guidelines, this line of code should be split.


Thanks,
Yongbang.

>> +
>> +    if (state != vdac->phys_state)
>> +        ++connector->epoch_counter;
>> +    vdac->phys_state = state;
>> +
>> +    /* If both the DP and VDAC physical states are disconnected,
>> +     * the "connected" status is returned to support KVM display.
>> +     */
>> +    return connector_status_connected;
> 
> I haven't tried, but I think this should also resolve the problems on my test systems. Great, thanks a lot! I might just
> get default resolutions for now, but that's OK.
> 
> Best regards
> Thomas
> 
>> +}
>> +
>>   static const struct drm_connector_helper_funcs
>>       hibmc_connector_helper_funcs = {
>>       .get_modes = hibmc_connector_get_modes,
>> -    .detect_ctx = drm_connector_helper_detect_from_ddc,
>> +    .detect_ctx = hibmc_vdac_detect,
>>   };
>>     static const struct drm_connector_funcs hibmc_connector_funcs = {
>> @@ -130,6 +145,8 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>         connector->polled = DRM_CONNECTOR_POLL_CONNECT | DRM_CONNECTOR_POLL_DISCONNECT;
>>   +    vdac->phys_state = connector_status_connected;
>> +
>>       return 0;
>>     err:
> 

