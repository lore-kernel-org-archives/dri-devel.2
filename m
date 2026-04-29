Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 91435FF8867
	for <dri-devel@archiver.kernel.org>; Wed, 29 Apr 2026 12:29:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BEC5210EFEF;
	Wed, 29 Apr 2026 12:29:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="tYGOyPfq";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 26ADE10EFE8
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 12:29:19 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 114EA2574
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 05:29:13 -0700 (PDT)
Received: from [192.168.0.1] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id
 518433F763
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Apr 2026 05:29:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777465758; bh=dPXWKsyfDbSfXYr+w3ukUCn5uBHKawsKXgfUBUuDLyo=;
 h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
 b=tYGOyPfqVBa7Jlc+8P5pRhga8wAvdTPYRFQeHfeshkjZyYeDZ407AGSgsqIB73gFa
 lSMfjB1O8RqWgwMYV6wIVzwvzE/htKreHeghkiPwmgfoFm3WtcPDwnWTE/Mx22DfsV
 yk/hE4ZLkQVocI6H/AspBG0jvAWiLnybQ5pkGE+w=
Date: Wed, 29 Apr 2026 13:29:10 +0100
From: Liviu Dudau <liviu.dudau@arm.com>
To: Boris Brezillon <boris.brezillon@collabora.com>
Cc: Steven Price <steven.price@arm.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 01/10] drm/panthor: Make panthor_irq::state a non-atomic
 field
Message-ID: <afH5lnARqAqBUHiU@e142607>
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-1-4b92ae4142d2@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260429-panthor-signal-from-irq-v1-1-4b92ae4142d2@collabora.com>
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

On Wed, Apr 29, 2026 at 11:38:28AM +0200, Boris Brezillon wrote:
> The only place where panthor_irq::state is accessed without
> panthor_irq::mask_lock held is in the prologue of _irq_suspend(),
> which is not really a fast-path. So let's simplify things by assuming
> panthor_irq::state must always be accessed with the mask_lock held,
> and add a scoped_guard() in _irq_suspend().
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Liviu Dudau <liviu.dudau@arm.com>

Best regards,
Liviu

> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 35 ++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 4e4607bca7cc..3f91ba73829d 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
> @@ -101,8 +101,12 @@ struct panthor_irq {
>  	 */
>  	spinlock_t mask_lock;
>  
> -	/** @state: one of &enum panthor_irq_state reflecting the current state. */
> -	atomic_t state;
> +	/**
> +	 * @state: one of &enum panthor_irq_state reflecting the current state.
> +	 *
> +	 * Must be accessed with mask_lock held.
> +	 */
> +	enum panthor_irq_state state;
>  };
>  
>  /**
> @@ -510,18 +514,15 @@ const char *panthor_exception_name(struct panthor_device *ptdev,
>  static irqreturn_t panthor_ ## __name ## _irq_raw_handler(int irq, void *data)			\
>  {												\
>  	struct panthor_irq *pirq = data;							\
> -	enum panthor_irq_state old_state;							\
>  												\
>  	if (!gpu_read(pirq->iomem, INT_STAT))							\
>  		return IRQ_NONE;								\
>  												\
>  	guard(spinlock_irqsave)(&pirq->mask_lock);						\
> -	old_state = atomic_cmpxchg(&pirq->state,						\
> -				   PANTHOR_IRQ_STATE_ACTIVE,					\
> -				   PANTHOR_IRQ_STATE_PROCESSING);				\
> -	if (old_state != PANTHOR_IRQ_STATE_ACTIVE)						\
> +	if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)						\
>  		return IRQ_NONE;								\
>  												\
> +	pirq->state = PANTHOR_IRQ_STATE_PROCESSING;						\
>  	gpu_write(pirq->iomem, INT_MASK, 0);							\
>  	return IRQ_WAKE_THREAD;									\
>  }												\
> @@ -551,13 +552,10 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
>  	}											\
>  												\
>  	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
> -		enum panthor_irq_state old_state;						\
> -												\
> -		old_state = atomic_cmpxchg(&pirq->state,					\
> -					   PANTHOR_IRQ_STATE_PROCESSING,			\
> -					   PANTHOR_IRQ_STATE_ACTIVE);				\
> -		if (old_state == PANTHOR_IRQ_STATE_PROCESSING)					\
> +		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING) {				\
> +			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;					\
>  			gpu_write(pirq->iomem, INT_MASK, pirq->mask);				\
> +		}										\
>  	}											\
>  												\
>  	return ret;										\
> @@ -566,18 +564,19 @@ static irqreturn_t panthor_ ## __name ## _irq_threaded_handler(int irq, void *da
>  static inline void panthor_ ## __name ## _irq_suspend(struct panthor_irq *pirq)			\
>  {												\
>  	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {					\
> -		atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDING);				\
> +		pirq->state = PANTHOR_IRQ_STATE_SUSPENDING;					\
>  		gpu_write(pirq->iomem, INT_MASK, 0);						\
>  	}											\
>  	synchronize_irq(pirq->irq);								\
> -	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_SUSPENDED);					\
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock)					\
> +		pirq->state = PANTHOR_IRQ_STATE_SUSPENDED;					\
>  }												\
>  												\
>  static inline void panthor_ ## __name ## _irq_resume(struct panthor_irq *pirq)			\
>  {												\
>  	guard(spinlock_irqsave)(&pirq->mask_lock);						\
>  												\
> -	atomic_set(&pirq->state, PANTHOR_IRQ_STATE_ACTIVE);					\
> +	pirq->state = PANTHOR_IRQ_STATE_ACTIVE;							\
>  	gpu_write(pirq->iomem, INT_CLEAR, pirq->mask);						\
>  	gpu_write(pirq->iomem, INT_MASK, pirq->mask);						\
>  }												\
> @@ -610,7 +609,7 @@ static inline void panthor_ ## __name ## _irq_enable_events(struct panthor_irq *
>  	 * on the PROCESSING -> ACTIVE transition.						\
>  	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
>  	 */											\
> -	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
> +	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
>  		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
>  }												\
>  												\
> @@ -624,7 +623,7 @@ static inline void panthor_ ## __name ## _irq_disable_events(struct panthor_irq
>  	 * on the PROCESSING -> ACTIVE transition.						\
>  	 * If the IRQ is suspended/suspending, the mask is restored at resume time.		\
>  	 */											\
> -	if (atomic_read(&pirq->state) == PANTHOR_IRQ_STATE_ACTIVE)				\
> +	if (pirq->state == PANTHOR_IRQ_STATE_ACTIVE)						\
>  		gpu_write(pirq->iomem, INT_MASK, pirq->mask);					\
>  }
>  
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
