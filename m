Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 37F00CD98CE
	for <dri-devel@archiver.kernel.org>; Thu, 11 Jun 2026 15:34:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8871610EEEA;
	Thu, 11 Jun 2026 15:34:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="dMInVyTV";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7C2AE10EEEA
 for <dri-devel@lists.freedesktop.org>; Thu, 11 Jun 2026 15:34:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2EEBF25E2;
 Thu, 11 Jun 2026 08:34:22 -0700 (PDT)
Received: from [10.1.29.27] (e122027.cambridge.arm.com [10.1.29.27])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D34C43FB90;
 Thu, 11 Jun 2026 08:34:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1781192066; bh=/sCwt4VmnlRUdYpbYUPm3IxE68ROI+yaC/qYgEqdhvY=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=dMInVyTVVvVKK5+JgcfXSesZeVnF8c53JrVjC34Rv2nIwPYlCpDsE8TpduOEdv822
 jBpEwAe8XS0lvSFLbdcyLZIZbjR4G75zBM6e7lHEOvDEMA5l046U0k+HfXa/U50kdf
 Xxvqrub3wetr7nKmvQRMgFhYZdKZdhmng3pO5j/E=
Message-ID: <dc038a81-3c59-49d5-ab8a-29202c7ce935@arm.com>
Date: Thu, 11 Jun 2026 16:34:22 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC PATCH 08/18] drm/panthor: Skip devfreq when no OPP table is
 present
To: Karunika Choo <karunika.choo@arm.com>, dri-devel@lists.freedesktop.org
Cc: nd@arm.com, Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
References: <20260528150546.3168527-1-karunika.choo@arm.com>
 <20260528150546.3168527-9-karunika.choo@arm.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260528150546.3168527-9-karunika.choo@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
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

On 28/05/2026 16:05, Karunika Choo wrote:
> On Mali v15 AM systems, frequency scaling is handled outside panthor by
> the AM_GOVERNOR block, so the GPU DT node may not provide an OPP table.
> 
> Make panthor_devfreq_init() return early when operating-points-v2 is
> absent, and guard the devfreq helper paths against a missing devfreq
> instance.
> 
> This keeps devfreq enabled for existing platforms while allowing v15 AM
> systems to probe without a local devfreq setup.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>
> ---
>  drivers/gpu/drm/panthor/panthor_devfreq.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_devfreq.c b/drivers/gpu/drm/panthor/panthor_devfreq.c
> index 2249b41ca4af..c3252ce54437 100644
> --- a/drivers/gpu/drm/panthor/panthor_devfreq.c
> +++ b/drivers/gpu/drm/panthor/panthor_devfreq.c
> @@ -148,6 +148,9 @@ int panthor_devfreq_init(struct panthor_device *ptdev)
>  	unsigned long freq = ULONG_MAX;
>  	int ret;
>  
> +	if (!device_property_read_bool(ptdev->base.dev, "operating-points-v2"))

Don't you want device_property_present() here?

I'm also a little wary of encoding operating-points-v2 as the check -
e.g. it potentially breaks if there's ever a "-v3" or some other way of
describing the opps. Can we use the -ENODEV returned from the
devm_pm_opp functions instead?

> +		return 0;
> +
>  	pdevfreq = drmm_kzalloc(&ptdev->base, sizeof(*ptdev->devfreq), GFP_KERNEL);
>  	if (!pdevfreq)
>  		return -ENOMEM;
> @@ -267,7 +270,7 @@ void panthor_devfreq_resume(struct panthor_device *ptdev)
>  {
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	panthor_devfreq_reset(pdevfreq);
> @@ -279,7 +282,7 @@ void panthor_devfreq_suspend(struct panthor_device *ptdev)
>  {
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	drm_WARN_ON(&ptdev->base, devfreq_suspend_device(pdevfreq->devfreq));
> @@ -290,7 +293,7 @@ void panthor_devfreq_record_busy(struct panthor_device *ptdev)
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  	unsigned long irqflags;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
> @@ -306,7 +309,7 @@ void panthor_devfreq_record_idle(struct panthor_device *ptdev)
>  	struct panthor_devfreq *pdevfreq = ptdev->devfreq;
>  	unsigned long irqflags;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return;
>  
>  	spin_lock_irqsave(&pdevfreq->lock, irqflags);
> @@ -323,7 +326,7 @@ unsigned long panthor_devfreq_get_freq(struct panthor_device *ptdev)
>  	unsigned long freq = 0;
>  	int ret;
>  
> -	if (!pdevfreq->devfreq)
> +	if (!pdevfreq || !pdevfreq->devfreq)
>  		return 0;

This has the unfortunate effect of reporting a bogus frequency in
panthor_gpu_show_fdinfo(). We should avoid reporting a frequency at all
if we don't know it. Or of course even better report the actual
frequency the governor block has set.

Thanks,
Steve

>  
>  	ret = pdevfreq->devfreq->profile->get_cur_freq(ptdev->base.dev, &freq);

