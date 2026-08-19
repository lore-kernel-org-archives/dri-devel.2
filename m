Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5834C5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 08:19:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1DC4110ED72;
	Wed, 19 Aug 2026 08:19:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="Wf49tPG8";
	dkim-atps=neutral
Received: from mail-m10313119130.xmail.ntesmail.com
 (mail-m10313119130.xmail.ntesmail.com [103.131.191.30])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 887E010E104
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 08:19:27 +0000 (UTC)
Received: from [172.16.12.74] (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 4a8a51f76;
 Wed, 19 Aug 2026 16:19:23 +0800 (GMT+08:00)
Message-ID: <ba494eae-c17f-4a15-8276-fd5dfb372337@rock-chips.com>
Date: Wed, 19 Aug 2026 16:19:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory samsung
 DP DT properties
To: Luca Ceresoli <luca.ceresoli@bootlin.com>, sashiko-reviews@lists.linux.dev
Cc: conor+dt@kernel.org, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
References: <20260707040613.1992841-1-damon.ding@rock-chips.com>
 <20260707040613.1992841-4-damon.ding@rock-chips.com>
 <20260707041711.4F7351F000E9@smtp.kernel.org>
 <00d3f58e-73bb-41da-a2df-dfeeca644b6f@rock-chips.com>
 <DKSQUNWA86GP.9NHE4ADGYLQH@bootlin.com>
Content-Language: en-US
From: Damon Ding <damon.ding@rock-chips.com>
In-Reply-To: <DKSQUNWA86GP.9NHE4ADGYLQH@bootlin.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-HM-Tid: 0aa0191a852d03a8kunm2c3020ce32ce50
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1kYFggdWUFKV1ktWUFJV1kPCRoVCBIfWUFZGU4YHVZCGBlJHUtMTU
 9MSR1WFRQJFhoXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0
 tIVUpLSU9PT0hVSktLVUpCS0tZBg++
DKIM-Signature: a=rsa-sha256;
 b=Wf49tPG8AhZEW7l91t2U7ST0bn7Q9Uma0wvhTer+YodE0RYsUe3DaI5jT91B0CDIquudx5ocZAtCaODI9RFFNUxfJE6SNo5z3FSK8txPBySWMw7D2Dd7YIsmdXTSxLjioc9PbXszA7v6LXwcGPJKSZean9Lx/HudYgEFyja85lU=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=rX0hKwWy09ECWrrBOzQzIvYBTC+ahCzcZPwzdinB3ts=;
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

On 8/19/2026 3:32 PM, Luca Ceresoli wrote:
> Hello Damon,
> 
> On Wed Jul 15, 2026 at 10:32 AM CEST, Damon Ding wrote:
>> On 7/7/2026 12:17 PM, sashiko-bot@kernel.org wrote:
>>> Thank you for your contribution! Sashiko AI review found 1 potential issue(s) to consider:
>>> - [Critical] Failing probe when deprecated DT properties are missing breaks DT ABI and prevents their deprecation.
>>> --
>>>
>>> --- Patch [3]: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties ---
>>> commit b573dba50acc6087122ffa4a65680322f4d004f8
>>> Author: Damon Ding <damon.ding@rock-chips.com>
>>>
>>> drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
>>>
>>> This commit reverts a change that made the samsung,link-rate and
>>> samsung,lane-count properties optional for Exynos DP. It adds error checking
>>> to fail the probe early if these properties are missing, aiming to prevent
>>> link training failures caused by zero values.
>>>
>>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>>> index 8cf6b73bceac0..293d8adfe9856 100644
>>>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>> [ ... ]
>>>> @@ -1258,10 +1259,14 @@ static int analogix_dp_dt_parse_pdata(struct analogix_dp_device *dp)
>>>>    		 * NOTE: those property parseing code is used for
>>>>    		 * providing backward compatibility for samsung platform.
>>>>    		 */
>>>> -		of_property_read_u32(dp_node, "samsung,link-rate",
>>>> -				     &video_info->max_link_rate);
>>>> -		of_property_read_u32(dp_node, "samsung,lane-count",
>>>> -				     &video_info->max_lane_count);
>>>> +		if (of_property_read_u32(dp_node, "samsung,link-rate", &val))
>>>> +			return dev_err_probe(dp->dev, -EINVAL,
>>>> +					     "Failed to get samsung,link-rate\n");
>>>
>>> [Severity: Critical]
>>> Does failing the probe when this property is missing break the DT ABI?
>>>
>>> Since samsung,link-rate is a deprecated property, a modern schema-compliant
>>> Device Tree might intentionally omit it. If a system boots with such a DT,
>>> this check will fail the probe with -EINVAL and disable the display.
>>>
>>> Could the driver instead fall back to hardware maximums or sensible defaults
>>> when the deprecated property is absent, rather than returning an error?
>>>
>>
>> I'm afraid it's difficult to provide a universal sensible default value
>> here.
>>
>> The samsung,lane-count and samsung,link-rate values vary significantly
>> across Exynos DP device trees, so a generic fallback to hardware
>> maximums cannot guarantee stable link training.
>>
>> Even though these two properties are marked deprecated, all existing DTS
>> files in our projects have already populated them completely. Moreover,
>> the current link training logic relies on these two parameters; omitting
>> either will directly cause link training failures at runtime.
>>
>> Therefore, retaining the mandatory property check in probe is a
>> reasonable approach for now.
> 
> I'm still not convinced we should turn an optional property into mandatory,
> after having been optional since 2016 (based on the commit in the Fixes:
> tag).
> 
> The sure thing is we cannot break existing devices which upgrade to a new
> kernel.
> 
> Se the question is: if a device is missing one of these properties, or
> both, what happens? The video_info->max_link_rate and/or
> video_info->max_lane_count will be zero, correct? And if they are zero, is
> there even a remote possibility that the device will work somehow, maybe
> only with some rare low resolution or whatever?
> 
> If the answer is "yes, there is a remote possibility that one sich device,
> with some maybe rare configuration, will work", then no, we cannot make
> this property mandatory now. There can be devices out there working without
> these proberties, and they would be broken.
> 
> If the answer is "there is no way at all a device can work without one or
> both properties", with a good explanation based on the code flow and
> hardware docs, then we can consider this change.
> 

Sorry for the confusion, I just submitted the v7 series which crossed 
with your reply.

To answer your question: there is no way at all a device can work
without these properties. Here is the code flow when either
max_link_rate or max_lane_count is 0 (helped by AI):

   analogix_dp_commit()
     -> analogix_dp_full_link_train(dp, max_lanes = 0, max_rate = 0)

   analogix_dp_full_link_train(max_lanes, max_rate):
       // Read sink capabilities via DPCD and sanitize them
       link_rate   = read_dpcd(DP_MAX_LINK_RATE); // >= 0x06 after fixup
       lane_count  = read_dpcd(DP_MAX_LANE_COUNT);// >= 1 after fixup

       // Clamp by the limits from DT
       if (link_rate > max_rate)                // 0x06 > 0, always true
           link_rate = max_rate;                // link_rate = 0
       if (lane_count > max_lanes)              // 1 > 0, always true
           lane_count = max_lanes;              // lane_count = 0

       // Configure TX with the zeroed values
       set_link_bandwidth(link_rate = 0)
           // writel() is only executed for bwtype == 0x06/0x0a,
           // so LINK_BW_SET is never written and stays at reset value;
           // phy_configure() is called with link_rate = 0.

       set_lane_count(lane_count = 0)
           // writel(0, ANALOGIX_DP_LANE_COUNT_SET) enables 0 lanes;
           // phy_configure() is called with lanes = 0.

       // Program sink for link training
       drm_dp_dpcd_write(DP_LINK_BW_SET, {link_rate = 0, lane_count = 0})
           // DP spec requires link rate in {0x06, 0x0a, 0x14} and
           // lane count in {1, 2, 4}. Writing zeros is illegal, so the
           // sink cannot enter the training state.

       // Training loop
       for (lane = 0; lane < lane_count /* 0 */; lane++)
           // loop body never executes; training_lane[] stays
           // uninitialized and no training register is ever programmed

Since the sanitized sink values are always non-zero (link_rate >= 0x06,
lane_count >= 1), the clamping with a zero maximum unconditionally
forces the training parameters to zero. Clock recovery can never be 
achieved, so link training fails deterministically.

Best regards,
Damon

