Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453A0F557E5
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 08:40:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8DB7210E44F;
	Mon, 20 Apr 2026 08:40:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="pE4IBYNF";
	dkim-atps=neutral
Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com
 [113.46.200.220])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 83BEC10E46E
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 08:40:53 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=KkNSAAu4NiPoiXkjTHA/BRAu/Ve+KKj1eJyn0OtbZT8=;
 b=pE4IBYNFaq3XPFa8q7p6v/QbCio7bojNpxF1dr/bLBGuu5pMxJdbjgs8CLjoPQmd1klC9uNzx
 raUyoKffI/wz2+nByiq9WeIXFk/Otx51ATj8w//68vUOVKCme77HQovoxRZ6XSYYHnvC8Cf4mf2
 bC/puUTyS2JLFh5mTwaFRYo=
Received: from mail.maildlp.com (unknown [172.19.163.104])
 by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fzf175XvPz12LDS;
 Mon, 20 Apr 2026 16:34:35 +0800 (CST)
Received: from dggemv712-chm.china.huawei.com (unknown [10.1.198.32])
 by mail.maildlp.com (Postfix) with ESMTPS id D80BD4056A;
 Mon, 20 Apr 2026 16:40:50 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv712-chm.china.huawei.com (10.1.198.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 16:40:50 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Mon, 20 Apr 2026 16:40:50 +0800
Message-ID: <7407b6cf-70a0-42a0-b63f-5cdaae0eb4b8@huawei.com>
Date: Mon, 20 Apr 2026 16:40:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH for drm-misc-fixes v4 2/4] drm/hisilicon/hibmc: fix no
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
References: <20260416092455.1990632-1-shiyongbang@huawei.com>
 <20260416092455.1990632-3-shiyongbang@huawei.com>
 <cb1f80ec-20af-4e59-a32e-b1e61e66af0d@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <cb1f80ec-20af-4e59-a32e-b1e61e66af0d@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems200002.china.huawei.com (7.221.188.68) To
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
> Am 16.04.26 um 11:24 schrieb Yongbang Shi:
>> From: Lin He <helin52@huawei.com>
>>
>> Our chip support KVM over IP feature, so hibmc driver need to support
>> displaying without any connectors plugged in. If no connectors are
>> connected, the vdac connector status should be set to 'connected' to
>> ensure proper KVM display functionality. Additionally, for
>> previous-generation products that may lack hardware link support and
>> thus cannot detect the monitor, the same approach should be applied
>> to ensure VGA display functionality. Add phys_state in the struct of
>> dp and vdac to check all physical outputs.
>>
>> For get_modes: using BMC modes for connector if no display is attached to
>> phys VGA cable, otherwise use EDID modes by
>> drm_connector_helper_get_modes,
>> because KVM doesn't provide EDID reads.
>>
>> Fixes: 4c962bc929f1 ("drm/hisilicon/hibmc: Add vga connector detect
>> functions")
>> Reported-by: Thomas Zimmermann <tzimmermann@suse.de>
>> Closes: https://lore.kernel.org/
>> all/0eb5c509-2724-4c57-87ad-74e4270d5a5a@suse.de/
> 
> The bug I reported is that the DDC does not return an EDID at all.
> Therefore hibmc fails to detect the connected VGA monitor. AFAIU that's
> not what is being fixed in this patch.
> 


The actual root cause of this bug lies in the board design of older
Huawei servers, where the chip's DDC I2C link was not connected to the
VGA port. There is no way to resolve this issue of being unable to
retrieve the EDID unless the hardware of the existing board is modified.

In the previous hibmc-drm driver, the
`drm_connector_helper_funcs.detect_ctx` callback function was not
registered, see kernel version 6.12.82 at[1], As a result, the DRM
framework returned “connected” by default. Even if no EDID was read, the
display would use the default resolution set in the hibmc-drm driver.
This is why the kernel version prior to the one you reported this bug in
was able to display properly.

However, in this patch[2], we modified this logic by hooking the
`drm_connector_helper_detect_from_ddc` function to the VDAC’s
`detect_ctx` callback. This function determines connectivity based on
whether an EDID is read, which resulted in older servers being unable to
display anything.

From the patch you contributed,，I understand that you are using an
RH1288H V3 server. I have confirmed with our chief hardware engineer
that the board design for this series of servers does not connect the
BMC chip’s DDC I2C to the VGA port.

[1]https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/drivers/gpu/drm/hisilicon/hibmc/hibmc_drm_vdac.c?h=v6.12.82#L60
[2]https://lore.kernel.org/all/20250320101455.2538835-10-shiyongbang@huawei.com/


>> Signed-off-by: Lin He <helin52@huawei.com>
>> Signed-off-by: Yongbang Shi <shiyongbang@huawei.com>
>> ---
> [...]
>> +static int hibmc_vdac_detect(struct drm_connector *connector,
>> +                 struct drm_modeset_acquire_ctx *ctx,
>> +                 bool force)
>> +{
>> +    struct hibmc_drm_private *priv = to_hibmc_drm_private(connector-
>> >dev);
>> +    struct hibmc_vdac *vdac = to_hibmc_vdac(connector);
>> +
>> +    vdac->phys_state = drm_connector_helper_detect_from_ddc(connector,
>> +                                ctx, force);
>> +
>> +    /* If the DP connectors are disconnected, the hibmc_vdac_detect
>> function
>> +     * must return a connected state to ensure KVM display
>> functionality.
>> +     * Additionally, for previous-generation products that may lack
>> hardware
>> +     * link support and thus cannot detect the monitor,
>> hibmc_vdac_detect
>> +     * should also return a connected state.
>> +     */
>> +    if (priv->dp.phys_state != connector_status_connected)
>> +        return connector_status_connected;
>> +
>> +    return vdac->phys_state;
> 
> This will break user-space compositors if DP and VGA are connected at
> the same time. I know, because we had such logic in ast and mgag200.
> 
> Today's compositors expect a single encoder-connector pair on each CRTC.
> That's what most contemporary hardware provides.  But the server
> chipsets usually come with one a single CRTC and multiple connectors
> attached to it.  Compositors fail to configure that. When we had this in
> ast and mgag200, Gnome would display garbage to the screen and mode-
> setting would fail. The bug report is at [1].
> 
> In ast and mgag200, only one connector would be installed on a single
> system. So we could avoid the problem. It looks like that this is not an
> option with hibmc. VGA always seems to be present and DP seems optional.
> I would advice to only report one of the connectors as 'connected' if
> both are installed on a system.
> 

According to our BMC chip specifications, both VGA and DisplayPort
outputs are required, but only one connection is allowed at a time,
which seems impractical.

Do you have any additional details regarding this issue with the Mutter
synthesizer? For example, steps to reproduce the issue or more specific
alert logs. I looked at the issue you submitted to Mutter, which
describes the phenomenon as "a warning that the configuration is
incompatible", Could you clarify what this warning specifically refers
to—is it a message displayed on the screen, or is it a specific entry in
the logs?

Over the next few days, we will focus on testing relevant scenarios
while setting both the VGA and DP ports to `connected` to see if we
encounter similar issues or warnings.

> You also need to increment the connector's epoch_counter if the physical
> status changed. Doing this will trigger DRM clients to re-read the
> connector state and reconfigure display.
> 
> Something like that
> 
> dp_detect()
> {
>     dp.phys_state = detect_from_hw()
> 
>     if (dp.phys_state changed)
>         ++epoch_counter
>     return connected
> }
> 
> vdac_detect()
> {
>     if (dp.phys_state == connected)
>         return disconnected
> 

Only one option is displayed here, but it does not meet our specifications.

>     vdac.phys_state = detect_from_hw()
> 
>     if (vdac.phys_state changed)
>         ++epoch_counter
>     return connected
> }
> 
> This handles the KVM in each connector's helper. The ast driver is
> probably the best reference for the current logic. See [2].
> 

I looked at the implementations of `detect_ctx` in ATS and MGAG200;
these implementations generally always return `connected`.

If my analysis is correct, the logic should be as follows:
  - If the `detect_ctx` function implemented by each vendor returns the
    actual hardware state, there is no need to modify `epoch_counter`;
    the DRM framework will execute `epoch_counter++` based on the return
    value of the `detect_ctx` function;

  - If the `detect_ctx` function in a vendor’s code always returns
    `connected`, then `epoch_counter++` must be performed within the
    vendor’s `detect_ctx` function; the implementations in ATS and
    MGAG200 appear to be like this;


Here is the pseudocode for our current logic. This logic is indeed a bit
hard to grasp, so I've added some more comments; it might be a bit
clearer than the patch:

dp_detect()
{
	dp.phys_state = detect_from_hw()
	
	/* epoch_counter update by drm framework */
	return dp.phys_state;
}

vdac_detect()
{
	/*
         * Scene 1: The driver runs on an older version of the BMC chip,
         *          and `dp.phys_state` is initialized to 0. To maintain
	 *	    consistency with the previous hibmc-drm driver
	 * 	    logic, always return `connected`.
	 * Scene 2: The driver runs on an new version of the BMC chip,
         *          and `dp.phys_state` is real status, witch is real
	 *	    `disconnect`. In this scenario, we must ensure that
	 *	    the VGA is `connected` to guarantee that the KVM
	 *	    displays properly.
	 */
	if (dp.phys_state != connected)
		return connected;

	/*
	 * DP is connected: This driver is definitely running on the
	 *	    latest BMC chip, and the DDC I2C is definitely
	 *	    connected to the VGA port, so we can confirm whether
	 *	    the VGA is present by reading the EDID directly via
	 *	    I2C.
	 */
	vdac.phys_state = detect_from_hw()
	
	/* epoch_counter update by drm framework */
	return vdac.phys_state;
}

Sorry for the delay; it took me a little while to figure out how best to
explain this bug and our current implementation.

Thanks,
Yongbang.

> [1] https://gitlab.gnome.org/GNOME/mutter/-/issues/3858
> [2] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/ast/
> ast_vga.c#L47
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
>>         connector->polled = DRM_CONNECTOR_POLL_CONNECT |
>> DRM_CONNECTOR_POLL_DISCONNECT;
>>   +    vdac->phys_state = connector_status_connected;
>> +
>>       return 0;
>>     err:
> 

