Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B3321C5DF7D
	for <dri-devel@archiver.kernel.org>; Tue, 18 Aug 2026 17:08:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 18FEC10E045;
	Tue, 18 Aug 2026 17:08:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="bt/LbUkW";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 61B9D10E045
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 17:08:12 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BD7561A32
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:08:07 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 4635A3F763
 for <dri-devel@lists.freedesktop.org>; Tue, 18 Aug 2026 10:08:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1787072891; bh=KJglFGHzGaoCuVMwhSC+ilm/v2jeiAx3EEhECHJzgCY=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=bt/LbUkWX+1BmhJxyVrj48KqMI/V1jCoIqXvHNClaWC3/r6QjZqy6zOMN4nYhPo5c
 YPgJSBywR5E8JPPKFTdEqVbwvG26AlK9uNYkRjp/EDC2bX6Fs5jK7cpKKOYX6E1Wri
 EBC0bPznciYondsAF6EKdRTBMs7Y9G6PAEq+tuZA=
Date: Tue, 18 Aug 2026 18:08:00 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>, Chia-I Wu <olvaffe@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 3/9] drm/panthor: Replace the panthor_irq macro
 machinery by inline helpers
Message-ID: <aoSRcD1EZ_Q0-NiR@e142607>
References: <20260811-panthor-signal-from-irq-v6-0-12f2ab53d735@collabora.com>
 <20260811-panthor-signal-from-irq-v6-3-12f2ab53d735@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260811-panthor-signal-from-irq-v6-3-12f2ab53d735@collabora.com>
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

On Tue, Aug 11, 2026 at 01:23:37PM +0200, Boris Brezillon wrote:
> Now that panthor_irq contains the iomem region, there's no real need
> for the macro-based panthor_irq helper generation logic. We can just
> provide inline helpers that do the same and let the compiler optimize
> indirect function calls. The only extra annoyance is the fact we have
> to open-code the panthor_xxx_irq_threaded_handler() implementation, but
> those are single-line functions, so it's acceptable.
> 
> While at it, we changed the prototype of the IRQ handlers to take
> a panthor_irq instead of panthor_device, since that's the thing
> that's passed around when it comes to panthor_irq, and the
> panthor_device can be directly extracted from there.
> 
> Reviewed-by: Steven Price <steven.price@arm.com>
> Reviewed-by: Chia-I Wu <olvaffe@gmail.com>
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 247 +++++++++++++++----------------
>  drivers/gpu/drm/panthor/panthor_fw.c     |  22 ++-
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  28 ++--
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  39 ++---
>  drivers/gpu/drm/panthor/panthor_pwr.c    |  24 +--
>  5 files changed, 188 insertions(+), 172 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index b102ea77fd1a..b55a3f9edd41 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -571,132 +571,127 @@ static inline u64 gpu_read64_counter(void __iomem *iomem, u32 reg)
>  #define INT_MASK    0x8
>  #define INT_STAT    0xc
>  
> -/**
> - * PANTHOR_IRQ_HANDLER() - Define interrupt handlers and the interrupt
> - * registration function.
> - *
> - * The boiler-plate to gracefully deal with shared interrupts is
> - * auto-generated. All you have to do is call PANTHOR_IRQ_HANDLER()
> - * just after the actual handler. The handler prototype is:
> - *
> - * void (*handler)(struct panthor_device *, u32 status);
> - */
> -#define PANTHOR_IRQ_HANDLER(__name, __handler)							\
> -static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
> -{												\
> -	struct panthor_irq *pirq = data;							\
> -												\
> -	guard(spinlock_irqsave)(&pirq->lock);							\
> -	if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)						\
> -		return IRQ_NONE;								\
> -												\
> -	if (!gpu_read(pirq->iomem, INT_STAT))							\
> -		return IRQ_NONE;								\
> -												\
> -	pirq->state = PANTHOR_IRQ_STATE_PROCESSING;						\
> -	gpu_write(pirq->iomem, INT_MASK, 0);							\
> -	return IRQ_WAKE_THREAD;									\
> -}												\
> -												\
> -static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *data)		\
> -{												\
> -	struct panthor_irq *pirq = data;							\
> -	struct panthor_device *ptdev = pirq->ptdev;						\
> -	irqreturn_t ret = IRQ_NONE;								\
> -												\
> -	while (true) {										\
> -		/* It's safe to access pirq->mask without the lock held here. If a new		\
> -		 * event gets added to the mask and the corresponding IRQ is pending,		\
> -		 * we'll process it right away instead of adding an extra raw -> threaded	\
> -		 * round trip. If an event is removed and the status bit is set, it will	\
> -		 * be ignored, just like it would have been if the mask had been adjusted	\
> -		 * right before the HW event kicks in. TLDR; it's all expected races we're	\
> -		 * covered for.									\
> -		 */										\
> -		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;			\
> -												\
> -		if (!status)									\
> -			break;									\
> -												\
> -		__handler(ptdev, status);							\
> -		ret = IRQ_HANDLED;								\
> -	}											\
> -												\
> -	scoped_guard(spinlock_irqsave, &pirq->lock) {						\
> -		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING) {				\
> -			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;					\
> -			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
> -		}										\
> -	}											\
> -												\
> -	return ret;										\
> -}												\
> -												\
> -static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)			\
> -{												\
> -	scoped_guard(spinlock_irqsave, &pirq->lock) {						\
> -		pirq->state = PANTHOR_IRQ_STATE_SUSPENDING;					\
> -		gpu_write(pirq->iomem, INT_MASK, 0);						\
> -	}											\
> -	synchronize_irq(pirq->irq);								\
> -	scoped_guard(spinlock_irqsave, &pirq->lock)						\
> -		pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;					\
> -}												\
> -												\
> -static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)			\
> -{												\
> -	guard(spinlock_irqsave)(&pirq->lock);							\
> -												\
> -	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;							\
> -	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
> -	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
> -}												\
> -												\
> -static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
> -					      struct panthor_irq *pirq,				\
> -					      int irq, void __iomem *iomem)			\
> -{												\
> -	pirq->ptdev = ptdev;									\
> -	pirq->irq = irq;									\
> -	pirq->mask = 0;										\
> -	pirq->iomem = iomem;									\
> -	spin_lock_init(&pirq->lock);								\
> -	pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;						\
> -	gpu_write(pirq->iomem, INT_MASK, 0);							\
> -												\
> -	return devm_request_threaded_irq(ptdev->base.dev, irq,					\
> -					 panthor_ ## __name ## _irq_raw_handler,		\
> -					 panthor_ ## __name ## _irq_threaded_handler,		\
> -					 IRQF_SHARED, KBUILD_MODNAME "-" # __name,		\
> -					 pirq);							\
> -}												\
> -												\
> -static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *pirq, u32 mask)	\
> -{												\
> -	guard(spinlock_irqsave)(&pirq->lock);							\
> -	pirq->mask |= mask;									\
> -												\
> -	/* The only situation where we need to write the new mask is if the IRQ is active.	\
> -	 * If it's being processed, the mask will be restored for us in _irq_threaded_handler()	\
> -	 * on the PROCESSING -> ACTIVE transition.						\
> -	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
> -	 */											\
> -	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
> -		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
> -}												\
> -												\
> -static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
> -{												\
> -	guard(spinlock_irqsave)(&pirq->lock);							\
> -	pirq->mask &= ~mask;									\
> -												\
> -	/* The only situation where we need to write the new mask is if the IRQ is active.	\
> -	 * If it's being processed, the mask will be restored for us in _irq_threaded_handler()	\
> -	 * on the PROCESSING -> ACTIVE transition.						\
> -	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
> -	 */											\
> -	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
> -		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
> +static inline irqreturn_t panthor_irq_default_raw_handler(int irq, void *data)
> +{
> +	struct panthor_irq *pirq = data;
> +
> +	guard(spinlock_irqsave)(&pirq->lock);
> +	if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)
> +		return IRQ_NONE;
> +
> +	if (!gpu_read(pirq->iomem, INT_STAT))
> +		return IRQ_NONE;
> +
> +	pirq->state = PANTHOR_IRQ_STATE_PROCESSING;
> +	gpu_write(pirq->iomem, INT_MASK, 0);
> +	return IRQ_WAKE_THREAD;
> +}
> +
> +static __always_inline irqreturn_t
> +panthor_irq_default_threaded_handler(void *data,
> +				     void (*slow_handler)(struct panthor_irq *, u32))
> +{
> +	struct panthor_irq *pirq = data;
> +	irqreturn_t ret = IRQ_NONE;
> +
> +	while (true) {
> +		/* It's safe to access pirq->mask without the lock held here. If a new
> +		 * event gets added to the mask and the corresponding IRQ is pending,
> +		 * we'll process it right away instead of adding an extra raw -> threaded
> +		 * round trip. If an event is removed and the status bit is set, it will
> +		 * be ignored, just like it would have been if the mask had been adjusted
> +		 * right before the HW event kicks in. TLDR; it's all expected races we're
> +		 * covered for.
> +		 */
> +		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;
> +
> +		if (!status)
> +			break;
> +
> +		slow_handler(pirq, status);
> +		ret = IRQ_HANDLED;
> +	}
> +
> +	scoped_guard(spinlock_irqsave, &pirq->lock) {
> +		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING) {
> +			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
> +			gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +		}
> +	}
> +
> +	return ret;
> +}
> +
> +static inline void panthor_irq_suspend(struct panthor_irq *pirq)
> +{
> +	scoped_guard(spinlock_irqsave, &pirq->lock) {
> +		pirq->state = PANTHOR_IRQ_STATE_SUSPENDING;
> +		gpu_write(pirq->iomem, INT_MASK, 0);
> +	}
> +	synchronize_irq(pirq->irq);
> +	scoped_guard(spinlock_irqsave, &pirq->lock)
> +		pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;
> +}
> +
> +static inline void panthor_irq_resume(struct panthor_irq *pirq)
> +{
> +	guard(spinlock_irqsave)(&pirq->lock);
> +	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
> +	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);
> +	gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +}
> +
> +static inline void panthor_irq_enable_events(struct panthor_irq *pirq, u32 mask)
> +{
> +	guard(spinlock_irqsave)(&pirq->lock);
> +	pirq->mask |= mask;
> +
> +	/* The only situation where we need to write the new mask is if the IRQ is active.
> +	 * If it's being processed, the mask will be restored for us in _irq_threaded_handler()
> +	 * on the PROCESSING -> ACTIVE transition.
> +	 * If the IRQ is suspended/suspending, the mask is restored at resume time.
> +	 */
> +	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)
> +		gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +}
> +
> +static inline void panthor_irq_disable_events(struct panthor_irq *pirq, u32 mask)
> +{
> +	guard(spinlock_irqsave)(&pirq->lock);
> +	pirq->mask &= ~mask;
> +
> +	/* The only situation where we need to write the new mask is if the IRQ is active.
> +	 * If it's being processed, the mask will be restored for us in _irq_threaded_handler()
> +	 * on the PROCESSING -> ACTIVE transition.
> +	 * If the IRQ is suspended/suspending, the mask is restored at resume time.
> +	 */
> +	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)
> +		gpu_write(pirq->iomem, INT_MASK, pirq->mask);
> +}
> +
> +static inline int
> +panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pirq,
> +		    int irq, void __iomem *iomem, const char *name,
> +		    irqreturn_t (*threaded_handler)(int, void *data))
> +{
> +	const char *full_name;
> +
> +	pirq->ptdev = ptdev;
> +	pirq->irq = irq;
> +	pirq->mask = 0;
> +	pirq->iomem = iomem;
> +	spin_lock_init(&pirq->lock);
> +	pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;
> +
> +	full_name = devm_kasprintf(ptdev->base.dev, GFP_KERNEL, KBUILD_MODNAME "-%s", name);
> +	if (!full_name)
> +		return -ENOMEM;
> +
> +	gpu_write(pirq->iomem, INT_MASK, 0);
> +	return devm_request_threaded_irq(ptdev->base.dev, irq,
> +					 panthor_irq_default_raw_handler,
> +					 threaded_handler,
> +					 IRQF_SHARED, full_name, pirq);
>  }
>  
>  extern struct workqueue_struct *panthor_cleanup_wq;
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index fc1a423e48a8..68965175105f 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1072,8 +1072,9 @@ static void panthor_fw_init_global_iface(struct panthor_device *ptdev)
>  			 msecs_to_jiffies(PING_INTERVAL_MS));
>  }
>  
> -static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
> +static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
>  {
> +	struct panthor_device *ptdev = pirq->ptdev;
>  	u32 duration;
>  	u64 start = 0;
>  
> @@ -1099,7 +1100,11 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
>  		trace_gpu_job_irq(ptdev->base.dev, status, duration);
>  	}
>  }
> -PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
> +
> +static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
> +{
> +	return panthor_irq_default_threaded_handler(data, panthor_job_irq_handler);
> +}
>  
>  static int panthor_fw_start(struct panthor_device *ptdev)
>  {
> @@ -1107,8 +1112,8 @@ static int panthor_fw_start(struct panthor_device *ptdev)
>  	bool timedout = false;
>  
>  	ptdev->fw->booted = false;
> -	panthor_job_irq_enable_events(&ptdev->fw->irq, ~0);
> -	panthor_job_irq_resume(&ptdev->fw->irq);
> +	panthor_irq_enable_events(&ptdev->fw->irq, ~0);
> +	panthor_irq_resume(&ptdev->fw->irq);
>  	gpu_write(fw->iomem, MCU_CONTROL, MCU_CONTROL_AUTO);
>  
>  	if (!wait_event_timeout(ptdev->fw->req_waitqueue,
> @@ -1218,7 +1223,7 @@ void panthor_fw_pre_reset(struct panthor_device *ptdev, bool on_hang)
>  			ptdev->reset.fast = true;
>  	}
>  
> -	panthor_job_irq_suspend(&ptdev->fw->irq);
> +	panthor_irq_suspend(&ptdev->fw->irq);
>  	panthor_fw_stop(ptdev);
>  }
>  
> @@ -1287,7 +1292,7 @@ void panthor_fw_unplug(struct panthor_device *ptdev)
>  
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev)) {
>  		/* Make sure the IRQ handler cannot be called after that point. */
> -		panthor_job_irq_suspend(&ptdev->fw->irq);
> +		panthor_irq_suspend(&ptdev->fw->irq);
>  		panthor_fw_stop(ptdev);
>  	}
>  
> @@ -1482,8 +1487,9 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq,
> -				      ptdev->iomem + JOB_INT_BASE);
> +	ret = panthor_irq_request(ptdev, &fw->irq, irq,
> +				  ptdev->iomem + JOB_INT_BASE, "job",
> +				  panthor_job_irq_threaded_handler);
>  	if (ret) {
>  		drm_err(&ptdev->base, "failed to request job irq");
>  		return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index c013d6bf9a59..7f287242285a 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -86,8 +86,9 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
>  }
>  
> -static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
> +static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
>  {
> +	struct panthor_device *ptdev = pirq->ptdev;
>  	struct panthor_gpu *gpu = ptdev->gpu;
>  
>  	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
> @@ -116,7 +117,11 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  	}
>  	spin_unlock(&ptdev->gpu->reqs_lock);
>  }
> -PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
> +
> +static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
> +{
> +	return panthor_irq_default_threaded_handler(data, panthor_gpu_irq_handler);
> +}
>  
>  /**
>   * panthor_gpu_unplug() - Called when the GPU is unplugged.
> @@ -128,7 +133,7 @@ void panthor_gpu_unplug(struct panthor_device *ptdev)
>  
>  	/* Make sure the IRQ handler is not running after that point. */
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> -		panthor_gpu_irq_suspend(&ptdev->gpu->irq);
> +		panthor_irq_suspend(&ptdev->gpu->irq);
>  
>  	/* Wake-up all waiters. */
>  	spin_lock_irqsave(&ptdev->gpu->reqs_lock, flags);
> @@ -169,13 +174,14 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
> -				      ptdev->iomem + GPU_INT_BASE);
> +	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
> +				  ptdev->iomem + GPU_INT_BASE, "gpu",
> +				  panthor_gpu_irq_threaded_handler);
>  	if (ret)
>  		return ret;
>  
> -	panthor_gpu_irq_enable_events(&ptdev->gpu->irq, GPU_INTERRUPTS_MASK);
> -	panthor_gpu_irq_resume(&ptdev->gpu->irq);
> +	panthor_irq_enable_events(&ptdev->gpu->irq, GPU_INTERRUPTS_MASK);
> +	panthor_irq_resume(&ptdev->gpu->irq);
>  	return 0;
>  }
>  
> @@ -183,7 +189,7 @@ int panthor_gpu_power_changed_on(struct panthor_device *ptdev)
>  {
>  	guard(pm_runtime_active)(ptdev->base.dev);
>  
> -	panthor_gpu_irq_enable_events(&ptdev->gpu->irq, GPU_POWER_INTERRUPTS_MASK);
> +	panthor_irq_enable_events(&ptdev->gpu->irq, GPU_POWER_INTERRUPTS_MASK);
>  
>  	return 0;
>  }
> @@ -192,7 +198,7 @@ void panthor_gpu_power_changed_off(struct panthor_device *ptdev)
>  {
>  	guard(pm_runtime_active)(ptdev->base.dev);
>  
> -	panthor_gpu_irq_disable_events(&ptdev->gpu->irq, GPU_POWER_INTERRUPTS_MASK);
> +	panthor_irq_disable_events(&ptdev->gpu->irq, GPU_POWER_INTERRUPTS_MASK);
>  }
>  
>  /**
> @@ -425,7 +431,7 @@ void panthor_gpu_suspend(struct panthor_device *ptdev)
>  	else
>  		panthor_hw_l2_power_off(ptdev);
>  
> -	panthor_gpu_irq_suspend(&ptdev->gpu->irq);
> +	panthor_irq_suspend(&ptdev->gpu->irq);
>  }
>  
>  /**
> @@ -437,7 +443,7 @@ void panthor_gpu_suspend(struct panthor_device *ptdev)
>   */
>  void panthor_gpu_resume(struct panthor_device *ptdev)
>  {
> -	panthor_gpu_irq_resume(&ptdev->gpu->irq);
> +	panthor_irq_resume(&ptdev->gpu->irq);
>  	panthor_hw_l2_power_on(ptdev);
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 0182b72f1932..d43ba1c7cd2a 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -601,17 +601,13 @@ static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
>  	return BIT(as);
>  }
>  
> -/* Forward declaration to call helpers within as_enable/disable */
> -static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status);
> -PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
> -
>  static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  				 u64 transtab, u64 transcfg, u64 memattr)
>  {
>  	struct panthor_mmu *mmu = ptdev->mmu;
>  
> -	panthor_mmu_irq_enable_events(&ptdev->mmu->irq,
> -				      panthor_mmu_as_fault_mask(ptdev, as_nr));
> +	panthor_irq_enable_events(&ptdev->mmu->irq,
> +				  panthor_mmu_as_fault_mask(ptdev, as_nr));
>  
>  	gpu_write64(mmu->iomem, AS_TRANSTAB(as_nr), transtab);
>  	gpu_write64(mmu->iomem, AS_MEMATTR(as_nr), memattr);
> @@ -629,8 +625,8 @@ static int panthor_mmu_as_disable(struct panthor_device *ptdev, u32 as_nr,
>  
>  	lockdep_assert_held(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_mmu_irq_disable_events(&ptdev->mmu->irq,
> -				       panthor_mmu_as_fault_mask(ptdev, as_nr));
> +	panthor_irq_disable_events(&ptdev->mmu->irq,
> +				   panthor_mmu_as_fault_mask(ptdev, as_nr));
>  
>  	/* Flush+invalidate RW caches, invalidate RO ones. */
>  	ret = panthor_gpu_flush_caches(ptdev, CACHE_CLEAN | CACHE_INV,
> @@ -1859,8 +1855,9 @@ static void panthor_vm_unlock_region(struct panthor_vm *vm)
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  }
>  
> -static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
> +static void panthor_mmu_irq_handler(struct panthor_irq *pirq, u32 status)
>  {
> +	struct panthor_device *ptdev = pirq->ptdev;
>  	struct panthor_mmu *mmu = ptdev->mmu;
>  	bool has_unhandled_faults = false;
>  
> @@ -1923,6 +1920,11 @@ static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status)
>  		panthor_sched_report_mmu_fault(ptdev);
>  }
>  
> +static irqreturn_t panthor_mmu_irq_threaded_handler(int irq, void *data)
> +{
> +	return panthor_irq_default_threaded_handler(data, panthor_mmu_irq_handler);
> +}
> +
>  /**
>   * panthor_mmu_suspend() - Suspend the MMU logic
>   * @ptdev: Device.
> @@ -1947,7 +1949,7 @@ void panthor_mmu_suspend(struct panthor_device *ptdev)
>  	}
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_mmu_irq_suspend(&ptdev->mmu->irq);
> +	panthor_irq_suspend(&ptdev->mmu->irq);
>  }
>  
>  /**
> @@ -1966,7 +1968,7 @@ void panthor_mmu_resume(struct panthor_device *ptdev)
>  	ptdev->mmu->as.faulty_mask = 0;
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_mmu_irq_resume(&ptdev->mmu->irq);
> +	panthor_irq_resume(&ptdev->mmu->irq);
>  }
>  
>  /**
> @@ -1983,7 +1985,7 @@ void panthor_mmu_pre_reset(struct panthor_device *ptdev)
>  {
>  	struct panthor_vm *vm;
>  
> -	panthor_mmu_irq_suspend(&ptdev->mmu->irq);
> +	panthor_irq_suspend(&ptdev->mmu->irq);
>  
>  	mutex_lock(&ptdev->mmu->vm.lock);
>  	ptdev->mmu->vm.reset_in_progress = true;
> @@ -2020,7 +2022,7 @@ void panthor_mmu_post_reset(struct panthor_device *ptdev)
>  
>  	mutex_unlock(&ptdev->mmu->as.slots_lock);
>  
> -	panthor_mmu_irq_resume(&ptdev->mmu->irq);
> +	panthor_irq_resume(&ptdev->mmu->irq);
>  
>  	/* Restart the VM_BIND queues. */
>  	mutex_lock(&ptdev->mmu->vm.lock);
> @@ -3352,7 +3354,7 @@ panthor_mmu_reclaim_priv_bos(struct panthor_device *ptdev,
>  void panthor_mmu_unplug(struct panthor_device *ptdev)
>  {
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> -		panthor_mmu_irq_suspend(&ptdev->mmu->irq);
> +		panthor_irq_suspend(&ptdev->mmu->irq);
>  
>  	mutex_lock(&ptdev->mmu->as.slots_lock);
>  	for (u32 i = 0; i < ARRAY_SIZE(ptdev->mmu->as.slots); i++) {
> @@ -3413,8 +3415,9 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> -	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
> -				      ptdev->iomem + MMU_INT_BASE);
> +	ret = panthor_irq_request(ptdev, &mmu->irq, irq,
> +				  ptdev->iomem + MMU_INT_BASE, "mmu",
> +				  panthor_mmu_irq_threaded_handler);
>  	if (ret)
>  		return ret;
>  
> @@ -3435,8 +3438,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  	if (ret)
>  		return ret;
>  
> -	panthor_mmu_irq_enable_events(&mmu->irq, panthor_mmu_fault_mask(ptdev, ~0));
> -	panthor_mmu_irq_resume(&mmu->irq);
> +	panthor_irq_enable_events(&mmu->irq, panthor_mmu_fault_mask(ptdev, ~0));
> +	panthor_irq_resume(&mmu->irq);
>  	return 0;
>  }
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index f2c2c3000590..dd7b6ef8ea20 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -56,8 +56,9 @@ struct panthor_pwr {
>  	wait_queue_head_t reqs_acked;
>  };
>  
> -static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
> +static void panthor_pwr_irq_handler(struct panthor_irq *pirq, u32 status)
>  {
> +	struct panthor_device *ptdev = pirq->ptdev;
>  	struct panthor_pwr *pwr = ptdev->pwr;
>  
>  	spin_lock(&ptdev->pwr->reqs_lock);
> @@ -75,7 +76,11 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>  	}
>  	spin_unlock(&ptdev->pwr->reqs_lock);
>  }
> -PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
> +
> +static irqreturn_t panthor_pwr_irq_threaded_handler(int irq, void *data)
> +{
> +	return panthor_irq_default_threaded_handler(data, panthor_pwr_irq_handler);
> +}
>  
>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>  {
> @@ -454,7 +459,7 @@ void panthor_pwr_unplug(struct panthor_device *ptdev)
>  
>  	/* Make sure the IRQ handler is not running after that point. */
>  	if (!IS_ENABLED(CONFIG_PM) || pm_runtime_active(ptdev->base.dev))
> -		panthor_pwr_irq_suspend(&ptdev->pwr->irq);
> +		panthor_irq_suspend(&ptdev->pwr->irq);
>  
>  	/* Wake-up all waiters. */
>  	spin_lock_irqsave(&ptdev->pwr->reqs_lock, flags);
> @@ -484,13 +489,14 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq,
> -				      pwr->iomem + PWR_INT_BASE);
> +	err = panthor_irq_request(ptdev, &pwr->irq, irq,
> +				  pwr->iomem + PWR_INT_BASE, "pwr",
> +				  panthor_pwr_irq_threaded_handler);
>  	if (err)
>  		return err;
>  
> -	panthor_pwr_irq_enable_events(&pwr->irq, PWR_INTERRUPTS_MASK);
> -	panthor_pwr_irq_resume(&pwr->irq);
> +	panthor_irq_enable_events(&pwr->irq, PWR_INTERRUPTS_MASK);
> +	panthor_irq_resume(&pwr->irq);
>  	return 0;
>  }
>  
> @@ -566,7 +572,7 @@ void panthor_pwr_suspend(struct panthor_device *ptdev)
>  	if (!ptdev->pwr)
>  		return;
>  
> -	panthor_pwr_irq_suspend(&ptdev->pwr->irq);
> +	panthor_irq_suspend(&ptdev->pwr->irq);
>  }
>  
>  void panthor_pwr_resume(struct panthor_device *ptdev)
> @@ -574,5 +580,5 @@ void panthor_pwr_resume(struct panthor_device *ptdev)
>  	if (!ptdev->pwr)
>  		return;
>  
> -	panthor_pwr_irq_resume(&ptdev->pwr->irq);
> +	panthor_irq_resume(&ptdev->pwr->irq);
>  }
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
