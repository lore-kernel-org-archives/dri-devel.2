Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18520CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:55:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E5B10E49B;
	Wed,  7 Oct 2026 12:55:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="UvVLNXow";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id DDBDF10E49B
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:55:04 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E8DDB1595;
 Wed,  7 Oct 2026 05:55:00 -0700 (PDT)
Received: from [10.57.75.203] (unknown [10.57.75.203])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9CDC23F763;
 Wed,  7 Oct 2026 05:55:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791377704; bh=SSWZdtrdsZxmDgfG4fuiuGi1BNumHXdCgfUzd/V3Vdo=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=UvVLNXowNrVRYz2maj3a9hLTrvHDX3Nf5+3YoF6tby0e7AAiHHPA9i1+/GSFgS5Q6
 bGu3T7XdGKTww+lF+FLnLPCuJ6BLZn4yGWHAL6R0uF/u3aFonixhdOuh23Pj1JOlTH
 CUAqqlthf3/N6P9Fz6W2Rupkp5lJAyDvbTnHf7fc=
Message-ID: <72338d88-ece1-49ac-af01-ba1e363d53d7@arm.com>
Date: Wed, 7 Oct 2026 13:54:58 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 10/15] drm/panfrost: Add debugfs knob for manually
 triggering a GPU reset
To: =?UTF-8?Q?Adri=C3=A1n_Larumbe?= <adrian.larumbe@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Rob Herring <robh@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Faith Ekstrand <faith.ekstrand@collabora.com>,
 "Marty E. Plummer" <hanetzer@startmail.com>,
 Tomeu Vizoso <tomeu@tomeuvizoso.net>, Eric Anholt <eric@anholt.net>,
 Robin Murphy <robin.murphy@arm.com>, Philipp Zabel <p.zabel@pengutronix.de>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 Collabora Kernel Team <kernel@collabora.com>,
 Neil Armstrong <neil.armstrong@linaro.org>
References: <20260929-claude-fixes-v12-0-62beb08de207@collabora.com>
 <20260929-claude-fixes-v12-10-62beb08de207@collabora.com>
 <1930451a-97e7-4029-91b4-45989e954d7a@arm.com>
 <179129388241.1018806.5773521934450351426.b4-reply@b4>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <179129388241.1018806.5773521934450351426.b4-reply@b4>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
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

On 06/10/2026 14:38, Adrián Larumbe wrote:
> On 2026-10-02 16:10:43+01:00, Steven Price wrote:
>> On 29/09/2026 04:44, Adrián Larumbe wrote:
>>
>>> This will be of great help when testing potential races between the GPU
>>> reset sequence and other parts of the code accessing HW registers.
>>>
>>> We must also disable the reset work item rather than simply cancelling
>>> it, to prevent the knob from triggering another reset when the device
>>> is being removed.
>>>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> ---
>>>  drivers/gpu/drm/panfrost/panfrost_device.c | 42 ++++++++++++++++++++++++++++++
>>>  drivers/gpu/drm/panfrost/panfrost_job.c    |  2 +-
>>>  2 files changed, 43 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
>>> index 09a5752a3f40..94d2de341838 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
>>> @@ -2,6 +2,7 @@
>>>  /* Copyright 2018 Marty E. Plummer <hanetzer@startmail.com> */
>>>  /* Copyright 2019 Linaro, Ltd, Rob Herring <robh@kernel.org> */
>>>  
>>> +#include <linux/debugfs.h>
>>>  #include <linux/clk.h>
>>>  #include <linux/reset.h>
>>>  #include <linux/platform_device.h>
>>> @@ -595,9 +596,50 @@ EXPORT_GPL_DEV_PM_OPS(panfrost_pm_ops) = {
>>>  };
>>>  
>>>  #ifdef CONFIG_DEBUG_FS
>>> +static int reset_get(void *data, u64 *val)
>>> +{
>>> +	struct panfrost_device *pfdev =
>>> +		container_of(data, struct panfrost_device, base);
>>> +
>>> +	*val = atomic_read(&pfdev->reset.pending);
>>> +	return 0;
>>> +}
>>> +
>>> +static int reset_set(void *data, u64 val)
>>> +{
>>> +	struct panfrost_device *pfdev =
>>> +		container_of(data, struct panfrost_device, base);
>>> +	int ret = pm_runtime_get_if_active(pfdev->base.dev);
>>> +
>>> +	if (!ret)
>>> +		return 0;
>>> +
>>> +	panfrost_device_schedule_reset(pfdev);
>>> +	flush_work(&pfdev->reset.work);
>>> +
>>> +	/* ret < 0 means runtime PM for the device is disabled, so we
>>> +	 * only need to return the PM reference in the opposite case
>>> +	 */
>>> +	if (ret > 0)
>>> +		pm_runtime_put(pfdev->base.dev);
>>> +
>>> +	return 0;
>>> +}
>>
>> NIT: If this wasn't debugfs I'd be complaining that you're ignoring
>> 'val' and so this isn't very extensible. But hey, it's debugfs... so:
>>
>> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> I looked into the available debugfs attribute definition macros and none of them provide
> a wrapper that avoid passing the input value when the attribute is to be understood as
> an action rather than a device property. My understanding is that because debugfs doesn't
> become part of the device's uAPI, we can do pretty much whatever we want with it.
> However, on a second thought, maybe in the future we'll want to extend the knob so that
> it performs resets in different ways, and would want to keep backwards compatibility with
> UM binaries that expect certain input values to stand for specific actions.
> 
> I'll change it so that all value other than '1' are returned with -EINVAL.

That would be my preference, but like you say this is debugfs so we
don't consider it part of uAPI. Mostly it seems a bit odd that you could
read the value, get 0 (i.e. no reset), write it back and that would
trigger a reset. But equally this isn't the sort of file which you'd
expect a read-modify-write operation to work on, so it's not a big deal.

Thanks,
Steve

