Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3104FC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 07:32:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7BC4510E3B1;
	Wed, 19 Aug 2026 07:32:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="ov4NkIaB";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7C32610E3B1
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 07:32:45 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id AE7F04E412BA;
 Wed, 19 Aug 2026 07:32:43 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8291F5FF42;
 Wed, 19 Aug 2026 07:32:43 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id E759711C753B7; 
 Wed, 19 Aug 2026 09:32:34 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787124758; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=hQKtUNfu32zyyC3Pj0M51woeAuZ2PTZyG0Xqk5Ab96I=;
 b=ov4NkIaBPQjK5QOgWFDAaIX+AGemj/mYur8euDyWKpDKQhIgALpJzcC2rY7O47dazgnCq2
 ldjpBhvTFzT+WKYxCW/IsYATs5b0vLo/ga46XhaR0eg03d7UclrWJ9xT4bhjItk2g+319P
 zy110nlWGd5ujXMq7EI7iYO92jm4soUdn7pBT5YvMNijLkn+t45QSY1VJ1ya3y1tDeW+Wm
 tt6SiD/OAH3iX3OqYjnROILLWbdepOpsiHRNrOSHkRhDbKCPEiaKeRY+lwep9KTx2YY7Ts
 iqSQzMVFSjN5Kt0hpuj5qMezBS4RCPP1840Q2kaSoApEdycxvaml3Piy2wHkhA==
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date: Wed, 19 Aug 2026 09:32:29 +0200
Message-Id: <DKSQUNWA86GP.9NHE4ADGYLQH@bootlin.com>
Subject: Re: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory
 samsung DP DT properties
Cc: <conor+dt@kernel.org>, <devicetree@vger.kernel.org>,
 <dri-devel@lists.freedesktop.org>, <robh@kernel.org>, "Luca Ceresoli"
 <luca.ceresoli@bootlin.com>
To: "Damon Ding" <damon.ding@rock-chips.com>, <sashiko-reviews@lists.linux.dev>
From: "Luca Ceresoli" <luca.ceresoli@bootlin.com>
X-Mailer: aerc 0.22.0
References: <20260707040613.1992841-1-damon.ding@rock-chips.com>
 <20260707040613.1992841-4-damon.ding@rock-chips.com>
 <20260707041711.4F7351F000E9@smtp.kernel.org>
 <00d3f58e-73bb-41da-a2df-dfeeca644b6f@rock-chips.com>
In-Reply-To: <00d3f58e-73bb-41da-a2df-dfeeca644b6f@rock-chips.com>
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

Hello Damon,

On Wed Jul 15, 2026 at 10:32 AM CEST, Damon Ding wrote:
> On 7/7/2026 12:17 PM, sashiko-bot@kernel.org wrote:
>> Thank you for your contribution! Sashiko AI review found 1 potential iss=
ue(s) to consider:
>> - [Critical] Failing probe when deprecated DT properties are missing bre=
aks DT ABI and prevents their deprecation.
>> --
>>
>> --- Patch [3]: [PATCH v6 3/5] drm/bridge: analogix_dp: Restore mandatory=
 samsung DP DT properties ---
>> commit b573dba50acc6087122ffa4a65680322f4d004f8
>> Author: Damon Ding <damon.ding@rock-chips.com>
>>
>> drm/bridge: analogix_dp: Restore mandatory samsung DP DT properties
>>
>> This commit reverts a change that made the samsung,link-rate and
>> samsung,lane-count properties optional for Exynos DP. It adds error chec=
king
>> to fail the probe early if these properties are missing, aiming to preve=
nt
>> link training failures caused by zero values.
>>
>>> diff --git a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c b/drive=
rs/gpu/drm/bridge/analogix/analogix_dp_core.c
>>> index 8cf6b73bceac0..293d8adfe9856 100644
>>> --- a/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>>> +++ b/drivers/gpu/drm/bridge/analogix/analogix_dp_core.c
>> [ ... ]
>>> @@ -1258,10 +1259,14 @@ static int analogix_dp_dt_parse_pdata(struct an=
alogix_dp_device *dp)
>>>   		 * NOTE: those property parseing code is used for
>>>   		 * providing backward compatibility for samsung platform.
>>>   		 */
>>> -		of_property_read_u32(dp_node, "samsung,link-rate",
>>> -				     &video_info->max_link_rate);
>>> -		of_property_read_u32(dp_node, "samsung,lane-count",
>>> -				     &video_info->max_lane_count);
>>> +		if (of_property_read_u32(dp_node, "samsung,link-rate", &val))
>>> +			return dev_err_probe(dp->dev, -EINVAL,
>>> +					     "Failed to get samsung,link-rate\n");
>>
>> [Severity: Critical]
>> Does failing the probe when this property is missing break the DT ABI?
>>
>> Since samsung,link-rate is a deprecated property, a modern schema-compli=
ant
>> Device Tree might intentionally omit it. If a system boots with such a D=
T,
>> this check will fail the probe with -EINVAL and disable the display.
>>
>> Could the driver instead fall back to hardware maximums or sensible defa=
ults
>> when the deprecated property is absent, rather than returning an error?
>>
>
> I'm afraid it's difficult to provide a universal sensible default value
> here.
>
> The samsung,lane-count and samsung,link-rate values vary significantly
> across Exynos DP device trees, so a generic fallback to hardware
> maximums cannot guarantee stable link training.
>
> Even though these two properties are marked deprecated, all existing DTS
> files in our projects have already populated them completely. Moreover,
> the current link training logic relies on these two parameters; omitting
> either will directly cause link training failures at runtime.
>
> Therefore, retaining the mandatory property check in probe is a
> reasonable approach for now.

I'm still not convinced we should turn an optional property into mandatory,
after having been optional since 2016 (based on the commit in the Fixes:
tag).

The sure thing is we cannot break existing devices which upgrade to a new
kernel.

Se the question is: if a device is missing one of these properties, or
both, what happens? The video_info->max_link_rate and/or
video_info->max_lane_count will be zero, correct? And if they are zero, is
there even a remote possibility that the device will work somehow, maybe
only with some rare low resolution or whatever?

If the answer is "yes, there is a remote possibility that one sich device,
with some maybe rare configuration, will work", then no, we cannot make
this property mandatory now. There can be devices out there working without
these proberties, and they would be broken.

If the answer is "there is no way at all a device can work without one or
both properties", with a good explanation based on the code flow and
hardware docs, then we can consider this change.

Luca

--
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com
