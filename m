Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D0889C79F83
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:14:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DB27410F937;
	Fri,  4 Sep 2026 08:14:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="f1jPqwNb";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 12E9510F935;
 Fri,  4 Sep 2026 08:14:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:From:Cc:To:Subject:
 MIME-Version:Date:Message-ID:From:Reply-To;
 bh=xd+J4ow0HjjbnZnbZaMuQt++InUk3PM21K11/2H6ew8=; b=f1jPqwNbEeBrcZ9UDVYrGdhWMp
 FGmxdOqL/nTpnyAM2xDW67F7ZfwQx9HxKGvls69xZbDiK5Yws/FDOQGuA5PvVaD4knhIIwJtNXYy4
 SM8MEXE7QAIgplp2vJnZ7sXWxPfzO1fW01auiFxXwBD4xO+7/RW0ee7QeCQ9JhxZm6+tRWLT1PKql
 WEiF4t9n2Mw51DM2tPkkQTMCWhmycfykT3IlAmfHrxIQkhdcvnaDAAwo97plFelNzGKEzoVyz9eGj
 B0AEObpkRhjiMIlkPRW0s/FjAoIEgJpeSGej08Rrs8VA9FJ7whcLG9rPB6usWHCPpzeSrms1qCMTc
 cIbwEeBQ==;
Received: from [81.79.79.1] (helo=[192.168.0.116])
 by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_128_GCM:128) (Exim)
 id 1x2P3x-00EmaK-Ln; Fri, 04 Sep 2026 10:14:17 +0200
Message-ID: <496b7662-fbae-40f1-b4e5-cd66493ef887@igalia.com>
Date: Fri, 4 Sep 2026 09:14:16 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] drm: Move drm_timeout_abs_to_jiffies() to
 drm_timeout.c
To: =?UTF-8?Q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Alex Deucher <alexander.deucher@amd.com>,
 =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Melissa Wen <mwen@igalia.com>, Iago Toral <itoral@igalia.com>,
 Jani Nikula <jani.nikula@linux.intel.com>,
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
 Rodrigo Vivi <rodrigo.vivi@intel.com>,
 Dave Stevenson <dave.stevenson@raspberrypi.com>,
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: kernel-dev@igalia.com, dri-devel@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org, intel-gfx@lists.freedesktop.org
References: <20260817-drm-timeout-helpers-v2-0-73052b669f49@igalia.com>
 <20260817-drm-timeout-helpers-v2-1-73052b669f49@igalia.com>
Content-Language: en-GB
From: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>
In-Reply-To: <20260817-drm-timeout-helpers-v2-1-73052b669f49@igalia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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


On 17/08/2026 22:05, Maíra Canal wrote:
> drm_timeout_abs_to_jiffies() began as a static helper inside the syncobj
> wait implementation and was later exported in place, so that it could be
> called by multiple drivers (e.g. panfrost, lima, tegra and accel
> drivers). All of them reach it through drm_utils.h.
> 
> Give it a file of its own, so that timeout conversion helpers have a
> home, which will be useful when we add new timeout handlers. The
> declaration stays in drm_utils.h, so no caller changes.
> 
> No functional change.

I see Thomas suggested some tweaks which look fine to me. Or this patch 
can stay as pure code movement, that is also fine by me, and tweaks to 
kerneldoc or headers can be a follow up. So either way:

Reviewed-by: Tvrtko Ursulin <tvrtko.ursulin@igalia.com>

> 
> Signed-off-by: Maíra Canal <mcanal@igalia.com>
> ---
>   drivers/gpu/drm/Makefile      |  1 +
>   drivers/gpu/drm/drm_syncobj.c | 33 ------------------------------
>   drivers/gpu/drm/drm_timeout.c | 47 +++++++++++++++++++++++++++++++++++++++++++
>   3 files changed, 48 insertions(+), 33 deletions(-)
> 
> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index e97faabcd783..0a0d7ea08347 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -68,6 +68,7 @@ drm-y := \
>   	drm_rect.o \
>   	drm_syncobj.o \
>   	drm_sysfs.o \
> +	drm_timeout.o \
>   	drm_trace_points.o \
>   	drm_vblank.o \
>   	drm_vblank_work.o \
> diff --git a/drivers/gpu/drm/drm_syncobj.c b/drivers/gpu/drm/drm_syncobj.c
> index 2fa170a29a62..cf03681de6f7 100644
> --- a/drivers/gpu/drm/drm_syncobj.c
> +++ b/drivers/gpu/drm/drm_syncobj.c
> @@ -1193,39 +1193,6 @@ static signed long drm_syncobj_array_wait_timeout(struct drm_syncobj **syncobjs,
>   	return timeout;
>   }
>   
> -/**
> - * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute value
> - *
> - * @timeout_nsec: timeout nsec component in ns, 0 for poll
> - *
> - * Calculate the timeout in jiffies from an absolute time in sec/nsec.
> - */
> -signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
> -{
> -	ktime_t abs_timeout, now;
> -	u64 timeout_ns, timeout_jiffies64;
> -
> -	/* make 0 timeout means poll - absolute 0 doesn't seem valid */
> -	if (timeout_nsec == 0)
> -		return 0;

As a side comment to this specific check - it looks not that great the 
core helper ended having this special case which conflates uapi and 
dma-resv semantics with the helper, but it may be laborious to untangle.

Hm, or actually.. the !ktime_after check below could be even making it 
redundant.

Regards,

Tvrtko

> -
> -	abs_timeout = ns_to_ktime(timeout_nsec);
> -	now = ktime_get();
> -
> -	if (!ktime_after(abs_timeout, now))
> -		return 0;
> -
> -	timeout_ns = ktime_to_ns(ktime_sub(abs_timeout, now));
> -
> -	timeout_jiffies64 = nsecs_to_jiffies64(timeout_ns);
> -	/*  clamp timeout to avoid infinite timeout */
> -	if (timeout_jiffies64 >= MAX_SCHEDULE_TIMEOUT - 1)
> -		return MAX_SCHEDULE_TIMEOUT - 1;
> -
> -	return timeout_jiffies64 + 1;
> -}
> -EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> -
>   static int drm_syncobj_array_wait(struct drm_device *dev,
>   				  struct drm_file *file_private,
>   				  struct drm_syncobj_wait *wait,
> diff --git a/drivers/gpu/drm/drm_timeout.c b/drivers/gpu/drm/drm_timeout.c
> new file mode 100644
> index 000000000000..78e9f65e5477
> --- /dev/null
> +++ b/drivers/gpu/drm/drm_timeout.c
> @@ -0,0 +1,47 @@
> +// SPDX-License-Identifier: MIT
> +/*
> + * Timeout conversion helpers for wait ioctls.
> + *
> + * Copyright 2017 Red Hat
> + * Copyright 2016 Advanced Micro Devices, Inc.
> + */
> +
> +#include <linux/export.h>
> +#include <linux/jiffies.h>
> +#include <linux/ktime.h>
> +#include <linux/sched.h>
> +
> +#include <drm/drm_utils.h>
> +
> +/**
> + * drm_timeout_abs_to_jiffies - calculate jiffies timeout from absolute value
> + *
> + * @timeout_nsec: timeout nsec component in ns, 0 for poll
> + *
> + * Calculate the timeout in jiffies from an absolute time in sec/nsec.
> + */
> +signed long drm_timeout_abs_to_jiffies(int64_t timeout_nsec)
> +{
> +	ktime_t abs_timeout, now;
> +	u64 timeout_ns, timeout_jiffies64;
> +
> +	/* make 0 timeout means poll - absolute 0 doesn't seem valid */
> +	if (timeout_nsec == 0)
> +		return 0;
> +
> +	abs_timeout = ns_to_ktime(timeout_nsec);
> +	now = ktime_get();
> +
> +	if (!ktime_after(abs_timeout, now))
> +		return 0;
> +
> +	timeout_ns = ktime_to_ns(ktime_sub(abs_timeout, now));
> +
> +	timeout_jiffies64 = nsecs_to_jiffies64(timeout_ns);
> +	/*  clamp timeout to avoid infinite timeout */
> +	if (timeout_jiffies64 >= MAX_SCHEDULE_TIMEOUT - 1)
> +		return MAX_SCHEDULE_TIMEOUT - 1;
> +
> +	return timeout_jiffies64 + 1;
> +}
> +EXPORT_SYMBOL(drm_timeout_abs_to_jiffies);
> 

