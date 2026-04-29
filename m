Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A01BCFF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 13:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0852B10EFFD;
	Wed, 29 Apr 2026 13:32:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="EDbyTLJC";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 7C4A510EFFD
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 13:32:48 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5374E2574
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:32:42 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 899573F62B
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 06:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777469567; bh=3dXqKoJqwgm37N7FLXaKeBBy5Wv7SRCuC+mUA6/f2+I=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=EDbyTLJC4CD5kKFmSRNqUOjlQx/ZDd5l9F+DX8xDEiRiKAC3uc9npQYmIvcmY4Yqt
 c3Kg0K6kAdx0Oxz5bJnTP3o9E8xMr1r4iNhajJqOgRtNMbnTRvIQ5GdwSrsKJoLMpD
 WBSCzoTQTC5rRXMlVfxMWsBcucrt/1ZOOcoC9zYQ=
Date: Wed, 29 Apr 2026 14:32:39 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 04/10] drm/panthor: Extend the IRQ logic to allow
 fast/raw IRQ handlers
Message-ID: <afIId-2Ej-WGBN1b@e142607>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-4-4b92ae4142d2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429-panthor-signal-from-irq-v1-4-4b92ae4142d2@collabora.com>
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

On Wed, Apr 29, 2026 at 11:38:31AM +0200, Boris Brezillon wrote:
> All drivers except panthor signal their fences from their interrupt
> handler to minimize latency. We could do the same from the interrupt
> handler, but the latency is still quite high in that case, so let's
> allow components to choose the context they want their IRQ handler
> to run in.

Starting here

> 
> This takes the form of an extra fast_handler() returning an irqreturn_t
> reflecting the need to wake-up a thread or not.
> A new PANTHOR_IRQ_ADV_HANDLER() macro taking this extra fast_handler
> argument is added, PANTHOR_IRQ_HANDLER() is implemented as a wrapper
> around PANTHOR_IRQ_ADV_HANDLER() with a default fast_handler
> returning IRQ_WAKE_THREAD.

up to here: there is no code matching the description. Left over from
earlier iteration?

> The fast and slow handler are still assumed
> to be mutually exclusive. In case a fast handler is provided, the
> slow_handler is expected to be run when the event can't be processed
> directly in the fast handler, or when the driver thinks it would be
> beneficial to coalesce interrupts by polling in the thread rather than
> re-enabling interrupts immediately.

This part is not really describing any code, just the intent. Maybe worth
moving it inside the code as a comment?

Otherwise, the change looks fine to me.

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 5 ++---
>  drivers/gpu/drm/panthor/panthor_fw.c     | 1 +
>  drivers/gpu/drm/panthor/panthor_gpu.c    | 1 +
>  drivers/gpu/drm/panthor/panthor_mmu.c    | 1 +
>  drivers/gpu/drm/panthor/panthor_pwr.c    | 1 +
>  5 files changed, 6 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index afa202546316..1c130b8394ab 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -672,6 +672,7 @@ static inline void panthor_irq_disable_events(struct panthor_irq *pirq, u32 mask
>  static inline int
>  panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pirq,
>  		    int irq, u32 mask, void __iomem *iomem, const char *name,
> +		    irqreturn_t (*raw_handler)(int, void *data),
>  		    irqreturn_t (*threaded_handler)(int, void *data))
>  {
>  	const char *full_name;
> @@ -687,9 +688,7 @@ panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pirq,
>  	if (!full_name)
>  		return -ENOMEM;
>  
> -	return devm_request_threaded_irq(ptdev->base.dev, irq,
> -					 panthor_irq_default_raw_handler,
> -					 threaded_handler,
> +	return devm_request_threaded_irq(ptdev->base.dev, irq, raw_handler, threaded_handler,
>  					 IRQF_SHARED, full_name, pirq);
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index eaf599b0a887..8239a6951569 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1483,6 +1483,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  
>  	ret = panthor_irq_request(ptdev, &fw->irq, irq, 0,
>  				  ptdev->iomem + JOB_INT_BASE, "job",
> +				  panthor_irq_default_raw_handler,
>  				  panthor_job_irq_threaded_handler);
>  	if (ret) {
>  		drm_err(&ptdev->base, "failed to request job irq");
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index ce208e384762..d0be758ea3e1 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -177,6 +177,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
>  				  GPU_INTERRUPTS_MASK,
>  				  ptdev->iomem + GPU_INT_BASE, "gpu",
> +				  panthor_irq_default_raw_handler,
>  				  panthor_gpu_irq_threaded_handler);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index a0d0a9b2926f..2cb07933b629 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -3260,6 +3260,7 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	ret = panthor_irq_request(ptdev, &mmu->irq, irq,
>  				  panthor_mmu_fault_mask(ptdev, ~0),
>  				  ptdev->iomem + MMU_INT_BASE, "mmu",
> +				  panthor_irq_default_raw_handler,
>  				  panthor_mmu_irq_threaded_handler);
>  	if (ret)
>  		return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index 80cf78007896..1efb7f3482ba 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -491,6 +491,7 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	err = panthor_irq_request(
>  		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
>  		pwr->iomem + PWR_INT_BASE, "pwr",
> +		panthor_irq_default_raw_handler,
>  		panthor_pwr_irq_threaded_handler);
>  	if (err)
>  		return err;
> 
> -- 
> 2.53.0
> 

-- 
====================
| I would like to |
| fix the world,  |
| but they're not |
| giving me the   |
 \ source code!  /
  ---------------
    ¯\_(ツ)_/¯
