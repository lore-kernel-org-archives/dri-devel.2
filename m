Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 47402C5DF81
	for <dri-devel@archiver.kernel.org>; Wed, 19 Aug 2026 15:37:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A6AC710EB1A;
	Wed, 19 Aug 2026 15:37:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="tCZ2XBoL";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id C1DE310EB1A
 for <dri-devel@lists.freedesktop.org>; Wed, 19 Aug 2026 15:37:38 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7AC1B153B;
 Wed, 19 Aug 2026 08:37:34 -0700 (PDT)
Received: from [10.57.6.96] (unknown [10.57.6.96])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id CCD8D3F763;
 Wed, 19 Aug 2026 08:37:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787153858; bh=Bcl7ATx82rvNijdxt9tvBXiMkc0XKfjlbSxk8dlJAg0=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=tCZ2XBoLcCkTRdQr2Bjo41H2XKSpulSrht1SxRplw5Ywr4F1V0P9sXf5J3NI3NZTf
 bsmPprodyxJfR1OPEmwcLSbJ7gpVkrrGkU7YG6WZMhnfssyx0tXXb3CZVLELi7l/pv
 60YgYdU9RdcaYK4zJq45VwHehpQsT1ETQwqgeaQk=
Message-ID: <3ee78a7a-3600-4b44-bf8b-1ff99b693cda@arm.com>
Date: Wed, 19 Aug 2026 16:37:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v4 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
References: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
 <20260812-panthor-cache-flush-fix-v4-2-751e32901898@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260812-panthor-cache-flush-fix-v4-2-751e32901898@collabora.com>
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

On 12/08/2026 15:07, Nicolas Frattaroli wrote:
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
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Although one minor formatting nit below.

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 72 ++++++++++++++++-------------------
>  1 file changed, 33 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 7088371c6d64..55e33f145b40 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -345,41 +345,36 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
>  			     u32 l2, u32 lsc, u32 other)
>  {
>  	struct panthor_gpu *gpu = ptdev->gpu;
> -	unsigned long flags;
>  	u64 start = 0;
>  	int ret = 0;
>  
>  	/* Serialize cache flush operations. */
>  	guard(mutex)(&ptdev->gpu->cache_flush_lock);
>  
> -	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> -
> -	if (tracepoint_enabled(gpu_cache_flush))
> -		start = ktime_get_ns();
> -
> -	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> -		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> -		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> -	} else {
> -		ret = -EIO;
> -	}
> -	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> -
> -	if (ret) {
> -		panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc, other, ret);
> -		return ret;
> +	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> +		if (tracepoint_enabled(gpu_cache_flush))
> +			start = ktime_get_ns();
> +
> +		if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> +			ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> +			gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> +		} else {
> +			panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc,
> +							 other, -EIO);
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

NIT: This isn't aligned correctly with the if() above any more.

To be honest what we really need here is a helper for this sequence as
there's basically the same code again in panthor_gpu_soft_reset() below.

> +				ret = -ETIMEDOUT;
> +			else
> +				ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> +		}
>  	}
>  
>  	panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc, other, ret);
> @@ -402,27 +397,26 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
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

NIT: Same issue here.

Thanks,
Steve

> +				timedout = true;
> +			else
> +				ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> +		}
>  	}
>  
>  	if (timedout) {
> 

