Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9A750CA5FFC
	for <dri-devel@archiver.kernel.org>; Wed,  7 Oct 2026 12:51:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F152110E5A2;
	Wed,  7 Oct 2026 12:51:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="uB4aqCXj";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7B22E10E5A2
 for <dri-devel@lists.freedesktop.org>; Wed,  7 Oct 2026 12:51:23 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8661D1595;
 Wed,  7 Oct 2026 05:51:19 -0700 (PDT)
Received: from [10.57.75.203] (unknown [10.57.75.203])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7DB3C3F763;
 Wed,  7 Oct 2026 05:51:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1791377482; bh=5pMbPdR4/kDddHC0N4iWazZ6mHvKQ770DGB9VgRAW0Y=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=uB4aqCXj2ql1Nxh4CfVDpX94fNSzudZALvn/ODs2uAdyT7EfFdG4VFGWBtVd3FvcO
 SD8fU2Jxs+LdKI4ZShvMOnZel8zNsYOQdBpZc0KyshBuiR+N4qho42bPdRCIvrXu1f
 MsIw3ipkFzHfdMbH0rEsLCzeAGxM+x57ld853mW4=
Message-ID: <5bd07106-e9dd-487a-be85-8e6a73c67967@arm.com>
Date: Wed, 7 Oct 2026 13:51:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v12 09/15] drm/panfrost: Add warning messages to fatal
 error conditions
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
 <20260929-claude-fixes-v12-9-62beb08de207@collabora.com>
 <2ea16821-fcd8-4f35-b371-7c7e57f76e7c@arm.com>
 <179129938072.1018806.14660127756555690690.b4-reply@b4>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <179129938072.1018806.14660127756555690690.b4-reply@b4>
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

On 06/10/2026 16:09, Adrián Larumbe wrote:
> On 2026-10-02 15:59:20+01:00, Steven Price wrote:
>> On 29/09/2026 04:44, Adrián Larumbe wrote:
>>
>>> Rather than just failing silently, let's warn the user of device remove not
>>> being able to take an PM reference or the PM suspend path still reporting
>>> inflight jobs. Neither situation should ever happen.
>>>
>>> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
>>> Signed-off-by: Adrián Larumbe <adrian.larumbe@collabora.com>
>>> ---
>>>  drivers/gpu/drm/panfrost/panfrost_device.c | 5 +++--
>>>  1 file changed, 3 insertions(+), 2 deletions(-)
>>>
>>> diff --git a/drivers/gpu/drm/panfrost/panfrost_device.c b/drivers/gpu/drm/panfrost/panfrost_device.c
>>> index c6bf3d0663df..09a5752a3f40 100644
>>> --- a/drivers/gpu/drm/panfrost/panfrost_device.c
>>> +++ b/drivers/gpu/drm/panfrost/panfrost_device.c
>>> @@ -9,6 +9,7 @@
>>>  #include <linux/pm_runtime.h>
>>>  #include <linux/regulator/consumer.h>
>>>  #include <drm/drm_drv.h>
>>> +#include <drm/drm_print.h>
>>>  
>>>  #include "panfrost_device.h"
>>>  #include "panfrost_devfreq.h"
>>> @@ -357,7 +358,7 @@ int panfrost_device_init(struct panfrost_device *pfdev)
>>>  
>>>  void panfrost_device_fini(struct panfrost_device *pfdev)
>>>  {
>>> -	pm_runtime_get_sync(pfdev->base.dev);
>>> +	drm_WARN_ON(&pfdev->base, pm_runtime_get_sync(pfdev->base.dev) < 0);
>>
>> This seems fine.
>>
>>>  	pm_runtime_dont_use_autosuspend(pfdev->base.dev);
>>>  	pm_runtime_disable(pfdev->base.dev);
>>> @@ -516,7 +517,7 @@ static int panfrost_device_runtime_suspend(struct device *dev)
>>>  {
>>>  	struct panfrost_device *pfdev = dev_get_drvdata(dev);
>>>  
>>> -	if (!panfrost_jm_is_idle(pfdev))
>>> +	if (drm_WARN_ON(&pfdev->base, !panfrost_jm_is_idle(pfdev)))
>>
>> I'm a bit wary that this might be something that user space can trigger.
>> My AI says:
>>
>> The runtime-suspend WARN can be reached by ordinary userspace job
>> submissions. The DRM scheduler increments credit_count before calling
>> Panfrost’s job runner (drivers/gpu/drm/scheduler/sched_main.c:1044).
>> Panfrost takes the job’s PM reference later in hardware submission
>> (drivers/gpu/drm/panfrost/panfrost_job.c:213). If autosuspend runs in
>> that interval, the new WARN
>> (drivers/gpu/drm/panfrost/panfrost_device.c:525) sees the credit and
>> fires, even though this is a timing race rather than a broken job.
>> Repeated submissions near the autosuspend boundary could therefore
>> produce repeated stack traces. The PM core treats the resulting -EBUSY
>> as a transient failure.
>>
>> Now I have to admit I don't trust it that much - but I'd want a
>> convincing argument on why panfrost_jm_is_idle() will never be false here.
> 
> You're right. I was in the belief that autosuspend kicking in was proof of no
> inflight or pending jobs present in the scheduler queues, so I came to treat
> this check as things having gone awry.
> 
> I guess its value lies in the ability of the PM runtime suspend handler
> to cancel itself at an autosuspend event, like you said.
> 
> However, it just made me wonder: what would happen in the event that autosuspend
> kicks in and runs panfrost_device_runtime_suspend() right at the same time that
> a scheduler job is picked up by drm_sched_run_job_work(), but hasn't yet reached
> the statement where it does an atomic increment on the credit_count? I guess
> nothing, because panfrost_job_hw_submit() is getting a PM reference before
> accessing any HW registers, and that should take care of dealing with any
> ongoing autosuspend events.
> 
> In that case I'll just delete that warning. However, I'd say it's bad practice
> to have DRM drivers access the internal state of the DRM scheduler. At present,
> only Panfrost and Etnaviv poke it in their RPM suspend handlers, and I've been
> wondering whether we should get rid of this check altogether, or else maybe ask
> the scheduler maintainers whether it makes sense to have a non-racy way to
> query the presence of pending jobs in their queues?

Yes, I'm not sure whether we actually need that check. As you say
there's still a race where panfrost_jm_is_idle() returns true, but
afterwards credit_count is incremented. I think this is safe -
panfrost_job_hw_submit() takes a PM reference which will cause the GPU
to be woken up again. So we could just drop the panfrost_jm_is_idle()
function completely.

Whether that has any performance impact - i.e. do we often race the
autosuspend operation? - I've no idea. Presumably you didn't hit it when
you had the WARN in place. So if you'd prefer to just remove the code
then that's fine by me.

Thanks,
Steve

