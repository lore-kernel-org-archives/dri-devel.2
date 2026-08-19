Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 67413C5DF6D
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 12:38:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAE3C10E400;
	Wed, 19 Aug 2026 12:38:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="fJfmZAIJ";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 106FD10E137
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 12:38:16 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id AC5E71A1741;
 Wed, 19 Aug 2026 12:38:14 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 79BE35FF42;
 Wed, 19 Aug 2026 12:38:14 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id DADCF11C70593; 
 Wed, 19 Aug 2026 14:38:05 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787143089; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=z48CoSpem9ABmdEj0+zBwC5z6rfDTgDxpiGCa8gzQLY=;
 b=fJfmZAIJqfBDmQ5y+R+H/OsXOECRKkMfqd4LjjJD2at3c0v4PKknKXW7U/IlNgE4FKVlXY
 Nr8udvlhB8kixFPWb/f02ZjfXPNuayMRmpSd2qKk5yoAe8Jh8RIfx4aKzG/6ICUwKext8H
 vnvJDSePfLAHlR0dd9GWVYZ11NQks+Sg3OM3IJ8IUB6VLC8/JXe5SeEuP75Jq2war9H2xd
 0b9n2VzgqryPE4zwhO3u03wrHe4Jan7zMEzVERIPqWB6e4aL/yRdL42WslBcpuDOs12baL
 RgBoNJJx5t/vlMFhM1Q+jlAWgGYSKvycBZBJq7c0/wIeQ5d6WI7MDxdzHFj/VQ==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 14:37:59 +0200
Message-Id: <DKSXCKHFS3T7.2UK43K8F0TUGZ@bootlin.com>
Cc: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <robh@kernel.org>
To: "Damon Ding" <damon.ding@rock-chips.com>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>, <sashiko-reviews@lists.linux.dev>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
Subject: Re: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory
 samsung DP DT properties
X-Mailer: aerc 0.22.0
References: <20260707040613.1992841-1-damon.ding@rock-chips.com>
 <20260707040613.1992841-4-damon.ding@rock-chips.com>
 <20260707041711.4F7351F000E9@smtp.kernel.org>
 <00d3f58e-73bb-41da-a2df-dfeeca644b6f@rock-chips.com>
 <DKSQUNWA86GP.9NHE4ADGYLQH@bootlin.com>
 <ba494eae-c17f-4a15-8276-fd5dfb372337@rock-chips.com>
In-Reply-To: <ba494eae-c17f-4a15-8276-fd5dfb372337@rock-chips.com>
X-Last-TLS-Session-Version: TLSv1.3
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

Hello,

On Wed Aug 19, 2026 at 10:19 AM CEST, Damon Ding wrote:
> Hi Luca,
>
> On 8/19/2026 3:32 PM, Luca Ceresoli wrote:
>> Hello Damon,
>>
>> On Wed Jul 15, 2026 at 10:32 AM CEST, Damon Ding wrote:
>>> On 7/7/2026 12:17 PM, sashiko-bot@kernel.org wrote:
>>>> Thank you for your contribution! Sashiko AI review found 1 potential i=
ssue(s) to consider:
>>>> - [Critical] Failing probe when deprecated DT properties are missing b=
reaks DT ABI and prevents their deprecation.
>>>> --
>>>>
>>>> --- Patch [3]: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandato=
ry samsung DP DT properties ---
>>>> commit b573dba50acc6087122ffa4a65680322f4d004f8
>>>> Author: Damon Ding <damon.ding@rock-chips.com>
>>>>
>>>> drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
>>>>
>>>> This commit reverts a change that made the samsung,link-rate and
>>>> samsung,lane-count properties optional for Exynos DP. It adds error ch=
ecking
>>>> to fail the probe early if these properties are missing, aiming to pre=
vent
>>>> link training failures caused by zero values.
>>>>
>>>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/dri=
vers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>>>> index 8cf6b73bceac0..293d8adfe9856 100644
>>>>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>>> [ ... ]
>>>>> @@ -1258,10 +1259,14 @@ static int analogix_dp_dt_parse_pdata(struct =
analogix_dp_device *dp)
>>>>>    		 * NOTE: those property parseing code is used for
>>>>>    		 * providing backward compatibility for samsung platform.
>>>>>    		 */
>>>>> -		of_property_read_u32(dp_node, "samsung,link-rate",
>>>>> -				     &video_info->max_link_rate);
>>>>> -		of_property_read_u32(dp_node, "samsung,lane-count",
>>>>> -				     &video_info->max_lane_count);
>>>>> +		if (of_property_read_u32(dp_node, "samsung,link-rate", &val))
>>>>> +			return dev_err_probe(dp->dev, -EINVAL,
>>>>> +					     "Failed to get samsung,link-rate\n");
>>>>
>>>> [Severity: Critical]
>>>> Does failing the probe when this property is missing break the DT ABI?
>>>>
>>>> Since samsung,link-rate is a deprecated property, a modern schema-comp=
liant
>>>> Device Tree might intentionally omit it. If a system boots with such a=
 DT,
>>>> this check will fail the probe with -EINVAL and disable the display.
>>>>
>>>> Could the driver instead fall back to hardware maximums or sensible de=
faults
>>>> when the deprecated property is absent, rather than returning an error=
?
>>>>
>>>
>>> I'm afraid it's difficult to provide a universal sensible default value
>>> here.
>>>
>>> The samsung,lane-count and samsung,link-rate values vary significantly
>>> across Exynos DP device trees, so a generic fallback to hardware
>>> maximums cannot guarantee stable link training.
>>>
>>> Even though these two properties are marked deprecated, all existing DT=
S
>>> files in our projects have already populated them completely. Moreover,
>>> the current link training logic relies on these two parameters; omittin=
g
>>> either will directly cause link training failures at runtime.
>>>
>>> Therefore, retaining the mandatory property check in probe is a
>>> reasonable approach for now.
>>
>> I'm still not convinced we should turn an optional property into mandato=
ry,
>> after having been optional since 2016 (based on the commit in the Fixes:
>> tag).
>>
>> The sure thing is we cannot break existing devices which upgrade to a ne=
w
>> kernel.
>>
>> Se the question is: if a device is missing one of these properties, or
>> both, what happens? The video_info->max_link_rate and/or
>> video_info->max_lane_count will be zero, correct? And if they are zero, =
is
>> there even a remote possibility that the device will work somehow, maybe
>> only with some rare low resolution or whatever?
>>
>> If the answer is "yes, there is a remote possibility that one sich devic=
e,
>> with some maybe rare configuration, will work", then no, we cannot make
>> this property mandatory now. There can be devices out there working with=
out
>> these proberties, and they would be broken.
>>
>> If the answer is "there is no way at all a device can work without one o=
r
>> both properties", with a good explanation based on the code flow and
>> hardware docs, then we can consider this change.
>>
>
> Sorry for the confusion, I just submitted the v7 series which crossed
> with your reply.
>
> To answer your question: there is no way at all a device can work
> without these properties. Here is the code flow when either
> max_link_rate or max_lane_count is 0 (helped by AI):
>
>    analogix_dp_commit()
>      -> analogix_dp_full_link_train(dp, max_lanes =3D 0, max_rate =3D 0)
>
>    analogix_dp_full_link_train(max_lanes, max_rate):
>        // Read sink capabilities via DPCD and sanitize them
>        link_rate   =3D read_dpcd(DP_MAX_LINK_RATE); // >=3D 0x06 after fi=
xup
>        lane_count  =3D read_dpcd(DP_MAX_LANE_COUNT);// >=3D 1 after fixup
>
>        // Clamp by the limits from DT
>        if (link_rate > max_rate)                // 0x06 > 0, always true
>            link_rate =3D max_rate;                // link_rate =3D 0
>        if (lane_count > max_lanes)              // 1 > 0, always true
>            lane_count =3D max_lanes;              // lane_count =3D 0
>
>        // Configure TX with the zeroed values
>        set_link_bandwidth(link_rate =3D 0)
>            // writel() is only executed for bwtype =3D=3D 0x06/0x0a,
>            // so LINK_BW_SET is never written and stays at reset value;
>            // phy_configure() is called with link_rate =3D 0.
>
>        set_lane_count(lane_count =3D 0)
>            // writel(0, ANALOGIX_DP_LANE_COUNT_SET) enables 0 lanes;
>            // phy_configure() is called with lanes =3D 0.
>
>        // Program sink for link training
>        drm_dp_dpcd_write(DP_LINK_BW_SET, {link_rate =3D 0, lane_count =3D=
 0})
>            // DP spec requires link rate in {0x06, 0x0a, 0x14} and
>            // lane count in {1, 2, 4}. Writing zeros is illegal, so the
>            // sink cannot enter the training state.
>
>        // Training loop
>        for (lane =3D 0; lane < lane_count /* 0 */; lane++)
>            // loop body never executes; training_lane[] stays
>            // uninitialized and no training register is ever programmed
>
> Since the sanitized sink values are always non-zero (link_rate >=3D 0x06,
> lane_count >=3D 1), the clamping with a zero maximum unconditionally
> forces the training parameters to zero. Clock recovery can never be
> achieved, so link training fails deterministically.

Thank you very much for the detailed analysis! To it is enough to
proceed. I'll review your v7.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
