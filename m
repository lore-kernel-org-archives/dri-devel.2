Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14C71C5B572
	for <dri-devel@archiver.kernel.org>; Tue, 11 Aug 2026 14:33:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C61710E336;
	Tue, 11 Aug 2026 14:33:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="MF84XBJt";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5F3F910E336
 for <dri-devel@lists.freedesktop.org>; Tue, 11 Aug 2026 14:33:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1786458816;
 bh=I3dRmbBpdwny4y/7VrHAWNz1deG+tVyE+EN7OXSUR4M=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=MF84XBJtAwfyV0rHzkGfhyaKFX7bViz0e8PRCWlDM6QHI9852mB8cbevnBEK/7ErY
 5uTudJwqEQxZDqZMS2hePSNHWI5aCpqkTHzfMFdOu09Ug6O8haih6u2Dkt2h4wO8+i
 ZNaMnGhaL7CS/QPIoVQqgWVNkEbjpUH1jUNuWN0DwjNoxoCf0TR6fpOr7lghXwbprW
 Std8Wxz79R1W0/ZYfyKX3DPaeUa601f4OwyfwFjJQ1w7w18Hg2wtr0oh3lbKd6Lu/8
 g4alnQqG1MkRzPWmt61LgzPiqb/KwNY6tvROSlge+yQ1ROD5PVa7Mkj4y0vgj0Toph
 zVbxzKPlUDyUA==
Received: from fedora-21.home (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 8FB8A17E0048;
 Tue, 11 Aug 2026 16:33:35 +0200 (CEST)
Date: Tue, 11 Aug 2026 16:33:30 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, Grant Likely
 <grant.likely@linaro.org>, Heiko Stuebner <heiko@sntech.de>,
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 kernel@collabora.com
Subject: Re: [PATCH v3 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
Message-ID: <20260811163330.6b0d302a@fedora-21.home>
In-Reply-To: <20260811-panthor-cache-flush-fix-v3-2-47d2c1bb1dab@collabora.com>
References: <20260811-panthor-cache-flush-fix-v3-0-47d2c1bb1dab@collabora.com>
 <20260811-panthor-cache-flush-fix-v3-2-47d2c1bb1dab@collabora.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
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

On Tue, 11 Aug 2026 16:08:32 +0200
Nicolas Frattaroli <nicolas.frattaroli@collabora.com> wrote:

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

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>

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

