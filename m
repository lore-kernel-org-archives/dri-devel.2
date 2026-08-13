Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7F512C5CFCF
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 15:29:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E036910F3AA;
	Thu, 13 Aug 2026 15:29:37 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="ju/9fQy0";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id BB80710F3AA
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 15:29:35 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52C2D1596
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:29:31 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 127603F632
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 08:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1786634975; bh=HX5lmoJ8U40GOQvbc7bCue8HQIqzzve9G5mKtq7Eh0Y=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=ju/9fQy0S45v9Z9qrCIgBKSKgRXHmP34XFg5fMPqDB9RtWYGkETAffQNj2SDVdKS1
 EZjeLNuhK3IwhsAOW4FPagnaQXBJ+aK8h1/VsIuglzvAdaIzoLk7KiOmfJu6KXzMjT
 C9+RzKKtXYQaSJyjzGUlUmPSRpkDLK2kdUqT51wo=
Date: Thu, 13 Aug 2026 16:29:22 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Boris Brezillon <boris.brezillon@collabora.com>,
 Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v3 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
Message-ID: <an3i0skoO9BlRdlK@e142607>
References: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
 <20260811-panthor-cache-flush-fix-v3-2-47d2c1bb1dab@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-panthor-cache-flush-fix-v3-2-47d2c1bb1dab@collabora.com>
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

On Tue, Aug 11, 2026 at 04:08:32PM +0200, Nicolas Frattaroli wrote:
> panthor_gpu_flush_caches() and panthor_gpu_soft_reset() acquire their
> reqs_lock spinlock with the IRQ-disabling variants of the spinlocking
> functions. This isn't necessary, as the lock is never taken from an
> atomic context, as Panthor uses threaded interrupt handlers. The result
> of this overly strict locking is that IRQs may be disabled more
> frequently and for longer than they should be, resulting in increased
> system latency.
> 
> Switch the locking to use non-IRQ-disabling scoped_guard statements for
> locking. The wait_event_timeout read of pending_reqs outside of the
> spinlock is fine as wait_event_timeout is a memory barrier according to
> the Linux Memory Model.
> 
> Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 66 ++++++++++++++++-------------------
>  1 file changed, 30 insertions(+), 36 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 68e2dd2527df..cb5319d1c5de 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -330,37 +330,32 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  			     u32 l2, u32 lsc, u32 other)
>  {
>  	struct panthor_gpu *gpu = ptdev->gpu;
> -	unsigned long flags;
>  	int ret = 0;
>  
>  	/* Serialize cache flush operations. */
>  	guard(mutex)(&ptdev->gpu->cache_flush_lock);
>  
> -	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> -	trace_gpu_cache_flush_start(ptdev->base.dev, l2, lsc, other);
> -	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> -		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> -		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> -	} else {
> -		ret = -EIO;
> -	}
> -	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> -
> -	if (ret) {
> -		trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
> -		return ret;
> +	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> +		trace_gpu_cache_flush_start(ptdev->base.dev, l2, lsc, other);
> +		if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> +			ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> +			gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> +		} else {
> +			trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
> +			return -EIO;
> +		}
>  	}
>  
>  	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
>  				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
>  				msecs_to_jiffies(100))) {
> -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> -		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
> -		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
> -			ret = -ETIMEDOUT;
> -		else
> -			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> +		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> +			if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
> +			!(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
> +				ret = -ETIMEDOUT;
> +			else
> +				ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> +		}
>  	}
>  
>  	trace_gpu_cache_flush_end(ptdev->base.dev, l2, lsc, other);
> @@ -383,27 +378,26 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
>  {
>  	struct panthor_gpu *gpu = ptdev->gpu;
>  	bool timedout = false;
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> -	if (!drm_WARN_ON(&ptdev->base,
> -			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
> -		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
> -		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
> -		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
> +	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> +		if (!drm_WARN_ON(&ptdev->base,
> +				ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
> +			ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
> +			gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
> +			gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
> +		}
>  	}
> -	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
>  
>  	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
>  				!(ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED),
>  				msecs_to_jiffies(100))) {
> -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> -		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
> -		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
> -			timedout = true;
> -		else
> -			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> +		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> +			if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
> +			!(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
> +				timedout = true;
> +			else
> +				ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> +		}
>  	}
>  
>  	if (timedout) {
> 
> -- 
> 2.55.0
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
