Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4987FC61DB9
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 13:12:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E32E10EA4E;
	Tue, 25 Aug 2026 13:12:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Lynkkr9J";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 8B6AA10E5F3
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 13:11:59 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CB621A9A
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:11:55 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 C9DB73F66F
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 06:11:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787663519; bh=ip74jrEBcTzJPtVOaT/s5xoO1C2OZn6vFIy6/oB81rg=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=Lynkkr9JDx+onHeSlo22Sw4nwA+QvWzwIRoZrkYgyV2dpJyZpd1jVH4tHzE+gRv6a
 3dSZ4w5han28ECxi9Ma+p0rvTDMiSglDRf7xJTmSA7FznVYn9KW1GkfryGOu+13igp
 3WPh1goJrlnLmXzh47Ub5iGFOihhm8TfJ1OCiJSA=
Date: Tue, 25 Aug 2026 14:11:46 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Steven Price <steven.price@arm.com>
Cc: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Grant Likely <grant.likely@linaro.org>,
 Heiko Stuebner <heiko@sntech.de>, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, kernel@collabora.com
Subject: Re: [PATCH v4 2/3] drm/panthor: Revisit reqs_lock handling in
 flush/reset paths
Message-ID: <ao2UkqH1eHkbTc0h@e142607>
References: <20260812-panthor-cache-flush-fix-v4-0-751e32901898@collabora.com>
 <20260812-panthor-cache-flush-fix-v4-2-751e32901898@collabora.com>
 <3ee78a7a-3600-4b44-bf8b-1ff99b693cda@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <3ee78a7a-3600-4b44-bf8b-1ff99b693cda@arm.com>
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

On Wed, Aug 19, 2026 at 04:37:27PM +0100, Steven Price wrote:
> On 12/08/2026 15:07, Nicolas Frattaroli wrote:
> > panthor_gpu_flush_caches() and panthor_gpu_soft_reset() acquire their
> > reqs_lock spinlock with the IRQ-disabling variants of the spinlocking
> > functions. This isn't necessary, as the lock is never taken from an
> > atomic context, as Panthor uses threaded interrupt handlers. The result
> > of this overly strict locking is that IRQs may be disabled more
> > frequently and for longer than they should be, resulting in increased
> > system latency.
> > 
> > Switch the locking to use non-IRQ-disabling scoped_guard statements for
> > locking. The wait_event_timeout read of pending_reqs outside of the
> > spinlock is fine as wait_event_timeout is a memory barrier according to
> > the Linux Memory Model.
> > 
> > Fixes: 5cd894e258c4 ("drm/panthor: Add the GPU logical block")
> > Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> > Signed-off-by: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> 
> Although one minor formatting nit below.
> 
> > ---
> >  drivers/gpu/drm/panthor/panthor_gpu.c | 72 ++++++++++++++++-------------------
> >  1 file changed, 33 insertions(+), 39 deletions(-)
> > 
> > diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> > index 7088371c6d64..55e33f145b40 100644
> > --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> > +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> > @@ -345,41 +345,36 @@ int panthor_gpu_flush_caches(struct panthor_device *ptdev,
> >  			     u32 l2, u32 lsc, u32 other)
> >  {
> >  	struct panthor_gpu *gpu = ptdev->gpu;
> > -	unsigned long flags;
> >  	u64 start = 0;
> >  	int ret = 0;
> >  
> >  	/* Serialize cache flush operations. */
> >  	guard(mutex)(&ptdev->gpu->cache_flush_lock);
> >  
> > -	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> > -
> > -	if (tracepoint_enabled(gpu_cache_flush))
> > -		start = ktime_get_ns();
> > -
> > -	if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> > -		ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> > -		gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> > -	} else {
> > -		ret = -EIO;
> > -	}
> > -	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> > -
> > -	if (ret) {
> > -		panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc, other, ret);
> > -		return ret;
> > +	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> > +		if (tracepoint_enabled(gpu_cache_flush))
> > +			start = ktime_get_ns();
> > +
> > +		if (!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED)) {
> > +			ptdev->gpu->pending_reqs |= GPU_IRQ_CLEAN_CACHES_COMPLETED;
> > +			gpu_write(gpu->iomem, GPU_CMD, GPU_FLUSH_CACHES(l2, lsc, other));
> > +		} else {
> > +			panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc,
> > +							 other, -EIO);
> > +			return -EIO;
> > +		}
> >  	}
> >  
> >  	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> >  				!(ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED),
> >  				msecs_to_jiffies(100))) {
> > -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> > -		if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
> > -		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
> > -			ret = -ETIMEDOUT;
> > -		else
> > -			ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> > -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> > +		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> > +			if ((ptdev->gpu->pending_reqs & GPU_IRQ_CLEAN_CACHES_COMPLETED) != 0 &&
> > +			!(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_CLEAN_CACHES_COMPLETED))
> 
> NIT: This isn't aligned correctly with the if() above any more.

I've fixed this locally before pushing it to drm-misc-next.

Best regards,
Liviu

> 
> To be honest what we really need here is a helper for this sequence as
> there's basically the same code again in panthor_gpu_soft_reset() below.
> 
> > +				ret = -ETIMEDOUT;
> > +			else
> > +				ptdev->gpu->pending_reqs &= ~GPU_IRQ_CLEAN_CACHES_COMPLETED;
> > +		}
> >  	}
> >  
> >  	panthor_gpu_emit_flush_caches_tp(ptdev, start, l2, lsc, other, ret);
> > @@ -402,27 +397,26 @@ int panthor_gpu_soft_reset(struct panthor_device *ptdev)
> >  {
> >  	struct panthor_gpu *gpu = ptdev->gpu;
> >  	bool timedout = false;
> > -	unsigned long flags;
> >  
> > -	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> > -	if (!drm_WARN_ON(&ptdev->base,
> > -			 ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
> > -		ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
> > -		gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
> > -		gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
> > +	scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> > +		if (!drm_WARN_ON(&ptdev->base,
> > +				ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED)) {
> > +			ptdev->gpu->pending_reqs |= GPU_IRQ_RESET_COMPLETED;
> > +			gpu_write(gpu->irq.iomem, INT_CLEAR, GPU_IRQ_RESET_COMPLETED);
> > +			gpu_write(gpu->iomem, GPU_CMD, GPU_SOFT_RESET);
> > +		}
> >  	}
> > -	spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> >  
> >  	if (!wait_event_timeout(ptdev->gpu->reqs_acked,
> >  				!(ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED),
> >  				msecs_to_jiffies(100))) {
> > -		spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> > -		if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
> > -		    !(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
> > -			timedout = true;
> > -		else
> > -			ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> > -		spin_unlock_irqrestore(&ptdev->gpu->reqs_lock, flags);
> > +		scoped_guard(spinlock, &ptdev->gpu->reqs_lock) {
> > +			if ((ptdev->gpu->pending_reqs & GPU_IRQ_RESET_COMPLETED) != 0 &&
> > +			!(gpu_read(gpu->irq.iomem, INT_RAWSTAT) & GPU_IRQ_RESET_COMPLETED))
> 
> NIT: Same issue here.
> 
> Thanks,
> Steve
> 
> > +				timedout = true;
> > +			else
> > +				ptdev->gpu->pending_reqs &= ~GPU_IRQ_RESET_COMPLETED;
> > +		}
> >  	}
> >  
> >  	if (timedout) {
> > 
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
