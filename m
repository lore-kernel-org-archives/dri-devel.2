Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B93E9F327BD
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 07:52:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1183910E19D;
	Tue, 21 Apr 2026 07:52:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=huawei.com header.i=@huawei.com header.b="VrYjk2KV";
	dkim-atps=neutral
Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com
 [113.46.200.218])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4005410E19D
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 07:52:26 +0000 (UTC)
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
 c=relaxed/relaxed; q=dns/txt; h=From;
 bh=02xjppyd5rHIz/1RPn7DAMS7HG1chRv3BT7kIDLUWA4=;
 b=VrYjk2KVgrUphpHtDbjjhql56yxGfgYV20aZJ6HpleXbr74ELk4yqRB+sH52lk80ewBJnILtR
 Cv/kc5vtLCBm/jkAQ7HUjmFHbP7fUubNp9P3v5NJcVxcnwW+2zfs8OuDGWKADPgxbhk/gAuGKIZ
 M+EToseY+opmdLbmP6qilec=
Received: from mail.maildlp.com (unknown [172.19.163.0])
 by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4g0Dtc27pqzpSys;
 Tue, 21 Apr 2026 15:46:00 +0800 (CST)
Received: from dggemv705-chm.china.huawei.com (unknown [10.3.19.32])
 by mail.maildlp.com (Postfix) with ESMTPS id 1DC3540576;
 Tue, 21 Apr 2026 15:52:23 +0800 (CST)
Received: from kwepemq100007.china.huawei.com (7.202.195.175) by
 dggemv705-chm.china.huawei.com (10.3.19.32) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 15:52:18 +0800
Received: from [10.159.167.44] (10.159.167.44) by
 kwepemq100007.china.huawei.com (7.202.195.175) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.11; Tue, 21 Apr 2026 15:52:18 +0800
Message-ID: <158b5b4e-3bed-4ef8-872f-e0b75c91af63@huawei.com>
Date: Tue, 21 Apr 2026 15:52:17 +0800
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
 <7407b6cf-70a0-42a0-b63f-5cdaae0eb4b8@huawei.com>
 <d5661982-8710-4a30-862b-dc1ba33860be@suse.de>
 <e3541b7f-9f39-4324-ad4d-eaf6eec3a6f7@huawei.com>
 <42b8989e-fde7-4274-b0a3-ee82a9488092@suse.de>
 <f5388d67-fb5a-4fce-8e2c-9230737e7b7b@huawei.com>
 <0b9d2924-cf19-4164-95fc-0a7b10ebab01@suse.de>
From: Yongbang Shi <shiyongbang@huawei.com>
In-Reply-To: <0b9d2924-cf19-4164-95fc-0a7b10ebab01@suse.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.159.167.44]
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
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
> Am 21.04.26 um 09:24 schrieb Yongbang Shi:
> [...]
>>> That's not really much of a problem. Just filter the older boards by some board identifier and handle it separately. We
>>> use that all over the kernel; including graphics drives. See for example DMI_MATCH. [1]
>>>
>> Okay, we'll need to verify this with the BIOS and do some analysis. If necessary, we'll submit a patch as a feature
>> later on.
> 
> Right. It's a separate thing.
> 
> 
>>> I think the design in the current patch is sound. It just needs to increment epoch_count if the physical status changes;
>>> and it would trigger these user-space bugs.  But we can only work around the latter.
>>>
>> Okay, I understand, but there's one more thing I need to confirm: simply adding logic to increment `epoch_count` within
>> `vdac_detect` isn't enough, is it? We still need to enable the `connector.polled` mechanism for periodic detection,
>> right?
> 
> Exactly. The poll helper will periodically run the detect helper to test if the display is still attached. This is
> required on connectors that do not auto-detect this, such as VGA.
> 
> The VGA standard assumes that the display would be connected while the computer was running. But everyone always
> connected and disconnected monitors at runtime, so we have to support that.
> 

Okay, this will further improve our hibmc-drm driver. The v5 patches are coming soon.

Thanks,
Yongbang.

> Best regards
> Thomas
> 
>>
>> like this:
>> hibmc_kms_init()
>> {
>>     ...
>>
>>     drm_kms_helper_poll_init(dev);
>>     
>>     ...
>> }
>>
>> a little change like this:
>> vdac_detect()
>> {
>>     phys_state = detect_from_hw()
>>
>>     if (dp.phys_state == connected) {
>>         vdac->phys_state = phys_state;
>>         return vdac->phys_state;  /* return from here, epoch_counter will be update by drm framework */
>>     }
>>     
>>     if (phys_state != vdac->phys_state)
>>         ++epoch_counter;
>>     
>>     vdac->phys_state = phys_state;
>>
>>     return connector_status_connected;
>> }
>>
>> Thanks,
>> Yongbang.
>>
>>> Best regards
>>> Thomas
>>>
>>>
>>>>>> Over the next few days, we will focus on testing relevant scenarios
>>>>>> while setting both the VGA and DP ports to `connected` to see if we
>>>>>> encounter similar issues or warnings.
>>>>>>
>>>>>>> You also need to increment the connector's epoch_counter if the physical
>>>>>>> status changed. Doing this will trigger DRM clients to re-read the
>>>>>>> connector state and reconfigure display.
>>>>>>>
>>>>>>> Something like that
>>>>>>>
>>>>>>> dp_detect()
>>>>>>> {
>>>>>>>        dp.phys_state = detect_from_hw()
>>>>>>>
>>>>>>>        if (dp.phys_state changed)
>>>>>>>            ++epoch_counter
>>>>>>>        return connected
>>>>>>> }
>>>>>>>
>>>>>>> vdac_detect()
>>>>>>> {
>>>>>>>        if (dp.phys_state == connected)
>>>>>>>            return disconnected
>>>>>>>
>>>>>> Only one option is displayed here, but it does not meet our specifications.
>>>>>>
>>>>>>>        vdac.phys_state = detect_from_hw()
>>>>>>>
>>>>>>>        if (vdac.phys_state changed)
>>>>>>>            ++epoch_counter
>>>>>>>        return connected
>>>>>>> }
>>>>>>>
>>>>>>> This handles the KVM in each connector's helper. The ast driver is
>>>>>>> probably the best reference for the current logic. See [2].
>>>>>>>
>>>>>> I looked at the implementations of `detect_ctx` in ATS and MGAG200;
>>>>>> these implementations generally always return `connected`.
>>>>>>
>>>>>> If my analysis is correct, the logic should be as follows:
>>>>>>      - If the `detect_ctx` function implemented by each vendor returns the
>>>>>>        actual hardware state, there is no need to modify `epoch_counter`;
>>>>>>        the DRM framework will execute `epoch_counter++` based on the return
>>>>>>        value of the `detect_ctx` function;
>>>>>>
>>>>>>      - If the `detect_ctx` function in a vendor’s code always returns
>>>>>>        `connected`, then `epoch_counter++` must be performed within the
>>>>>>        vendor’s `detect_ctx` function; the implementations in ATS and
>>>>>>        MGAG200 appear to be like this;
>>>>> Exactly. In ast/mgag200, we had the case that the VGA got disconnected. We'd still return connected, as the BMC/KVM
>>>>> was
>>>>> present. We now had to reconfigure for the KVM. That requires modifying epoch_counter. You can see at [1] that we only
>>>>> increment if the physical status changes. [1]  Same goes for re-connecting the VGA display.
>>>>>
>>>>> [1] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/ast/ast_vga.c#L56
>>>>>
>>>>>> Here is the pseudocode for our current logic. This logic is indeed a bit
>>>>>> hard to grasp, so I've added some more comments; it might be a bit
>>>>>> clearer than the patch:
>>>>>>
>>>>>> dp_detect()
>>>>>> {
>>>>>>       dp.phys_state = detect_from_hw()
>>>>>>            /* epoch_counter update by drm framework */
>>>>>>       return dp.phys_state;
>>>>>> }
>>>>>>
>>>>>> vdac_detect()
>>>>>> {
>>>>>>       /*
>>>>>>             * Scene 1: The driver runs on an older version of the BMC chip,
>>>>>>             *          and `dp.phys_state` is initialized to 0. To maintain
>>>>>>        *        consistency with the previous hibmc-drm driver
>>>>>>        *         logic, always return `connected`.
>>>>>>        * Scene 2: The driver runs on an new version of the BMC chip,
>>>>>>             *          and `dp.phys_state` is real status, witch is real
>>>>>>        *        `disconnect`. In this scenario, we must ensure that
>>>>>>        *        the VGA is `connected` to guarantee that the KVM
>>>>>>        *        displays properly.
>>>>>>        */
>>>>>>       if (dp.phys_state != connected)
>>>>>>           return connected;
>>>>>>
>>>>>>       /*
>>>>>>        * DP is connected: This driver is definitely running on the
>>>>>>        *        latest BMC chip, and the DDC I2C is definitely
>>>>>>        *        connected to the VGA port, so we can confirm whether
>>>>>>        *        the VGA is present by reading the EDID directly via
>>>>>>        *        I2C.
>>>>>>        */
>>>>>>       vdac.phys_state = detect_from_hw()
>>>>>>            /* epoch_counter update by drm framework */
>>>>>>       return vdac.phys_state;
>>>>> Let's assume the DP is disconnected. If VGA's physical status goes from connected to disconnected, user space will not
>>>>> know that it needs to reconfigure for the BMC.   (or vice versa)
>>>>>
>>>>> To give you some context from earlier discussions around the other drivers: We had the scenario that the user boots up
>>>>> without a connected VGA display. This would enable the BMC, which sometimes picks a large resolution; say >2k per
>>>>> dimension. That is problematic for KVM over networks. And if the user now plugs in a physical VGA display, they
>>>>> would be
>>>>> stuck with the large resolution on the framebuffer console. Maybe the VGA display wouldn't even support such a
>>>>> high-res
>>>>> mode.  So we set the default for the BMC to 1024x768. That is well manageable for all of today's VGA displays and does
>>>>> not impose too much overhead for KVM over networks.  As a drawback, it's a bit small on monitors and not nice to look
>>>>> at. So we modify epoch_counter whenever the physical status changes. This triggers compositors to reconfigure their
>>>>> screens for the new display.
>>>>>
>>>> Yes, this issue does exist. If we uses the `connector.polled` mechanism to monitor the VGA's presence in real time and
>>>> update the `epoch_counter`, which might resolve the issue. However, upon further consideration, I don't think this is
>>>> the optimal solution. If we create a separate connector for KVM and distinguish between older-generation BMC chips and
>>>> newer-generation BMC chips, the problem will be easily solved. In addition, DP and VGA, as well as VGA and KVM, will be
>>>> decoupled.
>>>>
>>>> A temporary solution:
>>>> /* called by poll work */
>>>> vdac_detect()
>>>> {
>>>>      /* Let’s examine this logic on its own to gain a better understanding. */
>>>>      if (older-generation)
>>>>          return connected;
>>>>
>>>>      vdac.phys_state = detect_from_hw();
>>>>      if (vdac.phys_state changed)
>>>>          ++epoch_counter;
>>>>
>>>>      if (dp.phys_state != connected) {
>>>>          return connected;
>>>>      }
>>>>
>>>>      return vdac.phys_state;
>>>> }
>>>>
>>>>
>>>> A more elegant solution:
>>>>         |--connector0(KVM): always connected, do not update epoch_counter.
>>>>         |
>>>> crtc--|--connector1(VGA): detect real time by `connector.polled`, update epoch_counter.
>>>>         |
>>>>         |--connector1(DP):  detect real time by hpd interrupt, update epoch_counter.
>>>>
>>>> kvm_detect()
>>>> {
>>>>      return connected;
>>>> }
>>>>
>>>> /* called by poll work */
>>>> vdac_detect()
>>>> {
>>>>      /* for older-generation */
>>>>      if (older-generation)
>>>>          return connected;
>>>>
>>>>      /* for newer-generation */
>>>>      vdac.phys_state = detect_from_hw();
>>>>
>>>>      /* epoch_counter update by drm framework */
>>>>      return vdac.phys_state;
>>>> }
>>>>
>>>> dp_detect()
>>>> {
>>>>      dp.phys_state = detect_from_hw();
>>>>
>>>>      /* epoch_counter update by drm framework */
>>>>      return dp.phys_state;
>>>> }
>>>>
>>>> Thanks,
>>>> Yongbang.
>>>>
>>>>> Best regards
>>>>> Thomas
>>>>>
>>>>>> }
>>>>>>
>>>>>> Sorry for the delay; it took me a little while to figure out how best to
>>>>>> explain this bug and our current implementation.
>>>>>>
>>>>>> Thanks,
>>>>>> Yongbang.
>>>>>>
>>>>>>> [1] https://gitlab.gnome.org/GNOME/mutter/-/issues/3858
>>>>>>> [2] https://elixir.bootlin.com/linux/v7.0/source/drivers/gpu/drm/ast/
>>>>>>> ast_vga.c#L47
>>>>>>>
>>>>>>> Best regards
>>>>>>> Thomas
>>>>>>>
>>>>>>>> +}
>>>>>>>> +
>>>>>>>>      static const struct drm_connector_helper_funcs
>>>>>>>>          hibmc_connector_helper_funcs = {
>>>>>>>>          .get_modes = hibmc_connector_get_modes,
>>>>>>>> -    .detect_ctx = drm_connector_helper_detect_from_ddc,
>>>>>>>> +    .detect_ctx = hibmc_vdac_detect,
>>>>>>>>      };
>>>>>>>>        static const struct drm_connector_funcs hibmc_connector_funcs = {
>>>>>>>> @@ -130,6 +145,8 @@ int hibmc_vdac_init(struct hibmc_drm_private *priv)
>>>>>>>>            connector->polled = DRM_CONNECTOR_POLL_CONNECT |
>>>>>>>> DRM_CONNECTOR_POLL_DISCONNECT;
>>>>>>>>      +    vdac->phys_state = connector_status_connected;
>>>>>>>> +
>>>>>>>>          return 0;
>>>>>>>>        err:
> 

