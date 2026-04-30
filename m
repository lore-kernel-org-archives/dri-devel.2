Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 54CDDCCFA13
	for <dri-devel@archiver.kernel.org>; Thu, 30 Apr 2026 10:43:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0FA710F2F3;
	Thu, 30 Apr 2026 10:43:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="p4fc7xYL";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6420C10F2F3
 for <dri-devel@lists.freedesktop.org>; Thu, 30 Apr 2026 10:43:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777545797;
 bh=0TArDSqKQnJoyS+4+hXGGSJttY5ZbKBWzIZ0WAh39Uc=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=p4fc7xYLwuC6CYi2pGkXDdogow3v6vrQFUYxQgSR63OyeESYD0IoMLBA4FZliCUIu
 hg5q3lQUkOuAZ7fMdlhaemAaCIPOKJDafoZ/d6Wy4UZNC+oyKy5TrpxeCP+887Bb36
 m+ASqNiL+gLUTxP2Q2GU9B2QeFEtyqZjtjXQdj5HPaucLEjfa/59bOYXUdaCi6o53a
 e5sgydXH+u+MJocMq5eQqbsZG9ZSgc59UcLwxni8aMoR1QPULzfZjlUTxtSmx6j1RB
 mHO3wZjQcxAQlxbfdIrTgYxxQrbUpyT9RYNVqeIT4jnlw9fJo2UcOnuemrr76/LcoX
 bFq2pewYuPa2Q==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id A85FF17E0EBB;
 Thu, 30 Apr 2026 12:43:16 +0200 (CEST)
Date: Thu, 30 Apr 2026 12:43:12 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Karunika Choo <karunika.choo@arm.com>
Cc: dri-devel@lists.freedesktop.org, nd@arm.com, Steven Price
 <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>, Maarten
 Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/8] drm/panthor: Store IRQ register base iomem
 pointer in panthor_irq
Message-ID: <20260430124312.40f6a62c@fedora>
In-Reply-To: <20260427155934.416502-5-karunika.choo@arm.com>
References: <20260427155934.416502-1-karunika.choo@arm.com>
 <20260427155934.416502-5-karunika.choo@arm.com>
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

On Mon, 27 Apr 2026 16:59:30 +0100
Karunika Choo <karunika.choo@arm.com> wrote:

> Update common IRQ handling code to work from an IRQ-local iomem base
> instead of referencing block-specific interrupt register offsets.
> 
> Store the interrupt base address iomem pointer in struct panthor_irq and
> switch the shared IRQ helpers to use generic INT_* offsets from that
> local base. This removes the need for each caller to expose absolute IRQ
> register addresses while keeping the common IRQ flow unchanged.
> 
> No functional change intended.
> 
> v3:
> - Clean up definition of pwr->irq.iomem.
> v2:
> - Change IRQ request function to accept an iomem pointer instead of
>   computing it from an offset argument.
> 
> Signed-off-by: Karunika Choo <karunika.choo@arm.com>

Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
Tested-by: Boris Brezillon <boris.brezillon@collabora.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.h   | 32 ++++++++++++++--------
>  drivers/gpu/drm/panthor/panthor_fw.c       |  5 ++--
>  drivers/gpu/drm/panthor/panthor_fw_regs.h  |  2 ++
>  drivers/gpu/drm/panthor/panthor_gpu.c      |  6 ++--
>  drivers/gpu/drm/panthor/panthor_gpu_regs.h |  3 ++
>  drivers/gpu/drm/panthor/panthor_mmu.c      |  5 ++--
>  drivers/gpu/drm/panthor/panthor_mmu_regs.h |  3 ++
>  drivers/gpu/drm/panthor/panthor_pwr.c      |  6 ++--
>  8 files changed, 42 insertions(+), 20 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 285bf7e4439e..4e4607bca7cc 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -82,6 +82,9 @@ struct panthor_irq {
>  	/** @ptdev: Panthor device */
>  	struct panthor_device *ptdev;
>  
> +	/** @iomem: CPU mapping of IRQ base address */
> +	void __iomem *iomem;
> +
>  	/** @irq: IRQ number. */
>  	int irq;
>  
> @@ -488,6 +491,11 @@ panthor_exception_is_fault(u32 exception_code)
>  const char *panthor_exception_name(struct panthor_device *ptdev,
>  				   u32 exception_code);
>  
> +#define INT_RAWSTAT 0x0
> +#define INT_CLEAR   0x4
> +#define INT_MASK    0x8
> +#define INT_STAT    0xc
> +
>  /**
>   * PANTHOR_IRQ_HANDLER() - Define interrupt handlers and the interrupt
>   * registration function.
> @@ -498,14 +506,13 @@ const char *panthor_exception_name(struct panthor_device *ptdev,
>   *
>   * void (*handler)(struct panthor_device *, u32 status);
>   */
> -#define PANTHOR_IRQ_HANDLER(__name, __reg_prefix, __handler)					\
> +#define PANTHOR_IRQ_HANDLER(__name, __handler)							\
>  static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
>  {												\
>  	struct panthor_irq *pirq = data;							\
> -	struct panthor_device *ptdev = pirq->ptdev;						\
>  	enum panthor_irq_state old_state;							\
>  												\
> -	if (!gpu_read(ptdev->iomem, __reg_prefix ## _INT_STAT))					\
> +	if (!gpu_read(pirq->iomem, INT_STAT))							\
>  		return IRQ_NONE;								\
>  												\
>  	guard(spinlock_irqsave)(&pirq->mask_lock);						\
> @@ -515,7 +522,7 @@ static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)
>  	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
>  		return IRQ_NONE;								\
>  												\
> -	gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, 0);					\
> +	gpu_write(pirq->iomem, INT_MASK, 0);							\
>  	return IRQ_WAKE_THREAD;									\
>  }												\
>  												\
> @@ -534,7 +541,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
>  		 * right before the HW event kicks in. TLDR; it's all expected races we're	\
>  		 * covered for.									\
>  		 */										\
> -		u32 status = gpu_read(ptdev->iomem, __reg_prefix ## _INT_RAWSTAT) & pirq->mask;	\
> +		u32 status = gpu_read(pirq->iomem, INT_RAWSTAT) & pirq->mask;			\
>  												\
>  		if (!status)									\
>  			break;									\
> @@ -550,7 +557,7 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
>  					   PANTHOR_IRQ_STATE_PROCESSING,			\
>  					   PANTHOR_IRQ_STATE_ACTIVE);				\
>  		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
> -			gpu_write(ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
> +			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
>  	}											\
>  												\
>  	return ret;										\
> @@ -560,7 +567,7 @@ static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)
>  {												\
>  	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
>  		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
> -		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, 0);			\
> +		gpu_write(pirq->iomem, INT_MASK, 0);						\
>  	}											\
>  	synchronize_irq(pirq->irq);								\
>  	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
> @@ -571,17 +578,18 @@ static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)
>  	guard(spinlock_irqsave)(&pirq->mask_lock);						\
>  												\
>  	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
> -	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_CLEAR, pirq->mask);			\
> -	gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);			\
> +	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
> +	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
>  }												\
>  												\
>  static int panthor_request_ ## __name ## _irq(struct panthor_device *ptdev,			\
>  					      struct panthor_irq *pirq,				\
> -					      int irq, u32 mask)				\
> +					      int irq, u32 mask, void __iomem *iomem)		\
>  {												\
>  	pirq->ptdev = ptdev;									\
>  	pirq->irq = irq;									\
>  	pirq->mask = mask;									\
> +	pirq->iomem = iomem;									\
>  	spin_lock_init(&pirq->mask_lock);							\
>  	panthor_ ## __name ## _irq_resume(pirq);						\
>  												\
> @@ -603,7 +611,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
>  	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
>  	 */											\
>  	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
> -		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
> +		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
>  }												\
>  												\
>  static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq *pirq, u32 mask)\
> @@ -617,7 +625,7 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
>  	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
>  	 */											\
>  	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
> -		gpu_write(pirq->ptdev->iomem, __reg_prefix ## _INT_MASK, pirq->mask);		\
> +		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
>  }
>  
>  extern struct workqueue_struct *panthor_cleanup_wq;
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index 4a0c23e987b6..73ef07a37e22 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1088,7 +1088,7 @@ static void panthor_job_irq_handler(struct panthor_device *ptdev, u32 status)
>  		trace_gpu_job_irq(ptdev->base.dev, status, duration);
>  	}
>  }
> -PANTHOR_IRQ_HANDLER(job, JOB, panthor_job_irq_handler);
> +PANTHOR_IRQ_HANDLER(job, panthor_job_irq_handler);
>  
>  static int panthor_fw_start(struct panthor_device *ptdev)
>  {
> @@ -1470,7 +1470,8 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  	if (irq <= 0)
>  		return -ENODEV;
>  
> -	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0);
> +	ret = panthor_request_job_irq(ptdev, &fw->irq, irq, 0,
> +				      ptdev->iomem + JOB_INT_BASE);
>  	if (ret) {
>  		drm_err(&ptdev->base, "failed to request job irq");
>  		return ret;
> diff --git a/drivers/gpu/drm/panthor/panthor_fw_regs.h b/drivers/gpu/drm/panthor/panthor_fw_regs.h
> index d523d41e18dd..eeb41aff249b 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_fw_regs.h
> @@ -15,6 +15,8 @@
>  #define   MCU_STATUS_HALT				2
>  #define   MCU_STATUS_FATAL				3
>  
> +#define JOB_INT_BASE					0x1000
> +
>  #define JOB_INT_RAWSTAT					0x1000
>  #define JOB_INT_CLEAR					0x1004
>  #define JOB_INT_MASK					0x1008
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index 747ac332be64..f00f3d9be240 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -110,7 +110,7 @@ static void panthor_gpu_irq_handler(struct panthor_device *ptdev, u32 status)
>  	}
>  	spin_unlock(&ptdev->gpu->reqs_lock);
>  }
> -PANTHOR_IRQ_HANDLER(gpu, GPU, panthor_gpu_irq_handler);
> +PANTHOR_IRQ_HANDLER(gpu, panthor_gpu_irq_handler);
>  
>  /**
>   * panthor_gpu_unplug() - Called when the GPU is unplugged.
> @@ -162,7 +162,9 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq, GPU_INTERRUPTS_MASK);
> +	ret = panthor_request_gpu_irq(ptdev, &ptdev->gpu->irq, irq,
> +				      GPU_INTERRUPTS_MASK,
> +				      ptdev->iomem + GPU_INT_BASE);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu_regs.h b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> index 75474b7d7341..3f60c45985a7 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_gpu_regs.h
> @@ -4,6 +4,8 @@
>  #ifndef __PANTHOR_GPU_REGS_H__
>  #define __PANTHOR_GPU_REGS_H__
>  
> +#define GPU_CONTROL_BASE				0x0
> +
>  #define GPU_ID						0x0
>  #define   GPU_ARCH_MAJOR(x)				((x) >> 28)
>  #define   GPU_ARCH_MINOR(x)				(((x) & GENMASK(27, 24)) >> 24)
> @@ -28,6 +30,7 @@
>  #define GPU_AS_PRESENT					0x18
>  #define GPU_CSF_ID					0x1C
>  
> +#define GPU_INT_BASE					0x20
>  #define GPU_INT_RAWSTAT					0x20
>  #define GPU_INT_CLEAR					0x24
>  #define GPU_INT_MASK					0x28
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu.c b/drivers/gpu/drm/panthor/panthor_mmu.c
> index 853f5ebfe5c6..64d53e7cb763 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu.c
> +++ b/drivers/gpu/drm/panthor/panthor_mmu.c
> @@ -584,7 +584,7 @@ static u32 panthor_mmu_as_fault_mask(struct panthor_device *ptdev, u32 as)
>  
>  /* Forward declaration to call helpers within as_enable/disable */
>  static void panthor_mmu_irq_handler(struct panthor_device *ptdev, u32 status);
> -PANTHOR_IRQ_HANDLER(mmu, MMU, panthor_mmu_irq_handler);
> +PANTHOR_IRQ_HANDLER(mmu, panthor_mmu_irq_handler);
>  
>  static int panthor_mmu_as_enable(struct panthor_device *ptdev, u32 as_nr,
>  				 u64 transtab, u64 transcfg, u64 memattr)
> @@ -3247,7 +3247,8 @@ int panthor_mmu_init(struct panthor_device *ptdev)
>  		return -ENODEV;
>  
>  	ret = panthor_request_mmu_irq(ptdev, &mmu->irq, irq,
> -				      panthor_mmu_fault_mask(ptdev, ~0));
> +				      panthor_mmu_fault_mask(ptdev, ~0),
> +				      ptdev->iomem + MMU_INT_BASE);
>  	if (ret)
>  		return ret;
>  
> diff --git a/drivers/gpu/drm/panthor/panthor_mmu_regs.h b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> index cc9cf603cec6..de460042651d 100644
> --- a/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> +++ b/drivers/gpu/drm/panthor/panthor_mmu_regs.h
> @@ -5,6 +5,9 @@
>  #define __PANTHOR_MMU_REGS_H__
>  
>  /* MMU regs */
> +
> +#define MMU_INT_BASE					0x2000
> +
>  #define MMU_INT_RAWSTAT					0x2000
>  #define MMU_INT_CLEAR					0x2004
>  #define MMU_INT_MASK					0x2008
> diff --git a/drivers/gpu/drm/panthor/panthor_pwr.c b/drivers/gpu/drm/panthor/panthor_pwr.c
> index aafb0c5c7d23..705d998447b5 100644
> --- a/drivers/gpu/drm/panthor/panthor_pwr.c
> +++ b/drivers/gpu/drm/panthor/panthor_pwr.c
> @@ -70,7 +70,7 @@ static void panthor_pwr_irq_handler(struct panthor_device *ptdev, u32 status)
>  	}
>  	spin_unlock(&ptdev->pwr->reqs_lock);
>  }
> -PANTHOR_IRQ_HANDLER(pwr, PWR, panthor_pwr_irq_handler);
> +PANTHOR_IRQ_HANDLER(pwr, panthor_pwr_irq_handler);
>  
>  static void panthor_pwr_write_command(struct panthor_device *ptdev, u32 command, u64 args)
>  {
> @@ -464,7 +464,9 @@ int panthor_pwr_init(struct panthor_device *ptdev)
>  	if (irq < 0)
>  		return irq;
>  
> -	err = panthor_request_pwr_irq(ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK);
> +	err = panthor_request_pwr_irq(
> +		ptdev, &pwr->irq, irq, PWR_INTERRUPTS_MASK,
> +		ptdev->iomem + PWR_CONTROL_BASE);
>  	if (err)
>  		return err;
>  

