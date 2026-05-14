Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6A944CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 15:26:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B17B710E3B9;
	Thu, 14 May 2026 15:26:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="QPEyLWhH";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 27E0910E3B9
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:26:30 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 7EE141655;
 Thu, 14 May 2026 08:26:24 -0700 (PDT)
Received: from [10.1.37.28] (e122027.cambridge.arm.com [10.1.37.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EA0F63F836;
 Thu, 14 May 2026 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778772389; bh=Aca4nt0XJ7z4BtUbkxRncNp8MuG2UR/vTMIJmbPedBw=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=QPEyLWhH+sd6QLYwbUSrSJoCK0MqkIpwTuamJsfp2JZ6fUDYkLhqz7y4Tz8Fg1+5N
 WMhbkzyVHU61u7qb449vVIbROcHMEWZtm+VmuOcCOgTbBYHn5FI2lcCwf4LbGk0tAM
 W2XCY/dz5FkWQHxAplv37tNjGPT8d5dKP67mrYKs=
Message-ID: <85837c7d-fe6c-4b07-b804-b6d113bab4e6@arm.com>
Date: Thu, 14 May 2026 16:26:25 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 10/11] drm/panthor: Use the irqsave variant of
 spin_lock in panthor_gpu_irq_handler()
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-10-95c614a739cb@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260512-panthor-signal-from-irq-v2-10-95c614a739cb@collabora.com>
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

On 12/05/2026 12:37, Boris Brezillon wrote:
> This is not a bug per-se, because this lock is never taken in an
> interrupt context, but it's not consistent with the other users of this
> lock. We're also planning on transitioning GPU event processing to
> a hard handler. Again, this alone wouldn't justify using the IRQ-safe
> variant, because then this _lock/unlock sequence would be in the
> hard-IRQ path, where IRQs are already disabled, but let's do it anyway,
> to keep things consistent.
> 
> While at it, transition to a guard() instead of a plain lock/unlock
> sequence.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

Although this now leaves the lock in panthor_pwr_irq_handler() the odd
one out...

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index d0be758ea3e1..b9c51f8a051d 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -110,12 +110,11 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
>  	if (status & GPU_IRQ_PROTM_FAULT)
>  		drm_warn(&ptdev->base, "GPU Fault in protected mode\n");
>  
> -	spin_lock(&ptdev->gpu->reqs_lock);
> +	guard(spinlock_irqsave)(&ptdev->gpu->reqs_lock);
>  	if (status & ptdev->gpu->pending_reqs) {
>  		ptdev->gpu->pending_reqs &= ~status;
>  		wake_up_all(&ptdev->gpu->reqs_acked);
>  	}
> -	spin_unlock(&ptdev->gpu->reqs_lock);
>  }
>  
>  static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
> 

