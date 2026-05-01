Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C558CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 14:38:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C127D10E1D2;
	Fri,  1 May 2026 14:38:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Dv/iCgCu";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 191EB10E1D2
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 14:38:56 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 25AFD2A9A;
 Fri,  1 May 2026 07:38:50 -0700 (PDT)
Received: from [10.1.29.19] (e122027.cambridge.arm.com [10.1.29.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 34BCB3F7B4;
 Fri,  1 May 2026 07:38:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777646335; bh=2v6jRbxPKRSZ2+J2++WTZBq1zJkmZ0LtnflS79Ax74c=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Dv/iCgCum2czdRKUVOB/k7blYeZiIEgqHPCeL6oo8WKtMbq7HeHscnMWLEXqn0CUh
 xj58I01lgEktrA+OBt1YfTmuoUE/6d1dYz2oM7Bk9Um6PzlK6/0+DFq7f45U4r9PoJ
 byTKxMdUk/mUXKvtGo4FAivNiuL/LSyNAzE+wZaU=
Message-ID: <695b81bf-ee35-4804-aefe-97f685002f07@arm.com>
Date: Fri, 1 May 2026 15:38:50 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 09/10] drm/panthor: Process FW events in IRQ context
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-9-4b92ae4142d2@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260429-panthor-signal-from-irq-v1-9-4b92ae4142d2@collabora.com>
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

On 29/04/2026 10:38, Boris Brezillon wrote:
> Now that everything is set to allow processing FW events in IRQ context,
> go for it. This should reduce the dma_fence signaling latency.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Another AI-found locking bug...

With this change there's a callpath:

  panthor_job_irq_raw_handler()
    panthor_job_irq_handler()
      panthor_sched_report_fw_events()
        sched_process_csg_irq_locked()
          if (csg_events & CSG_SYNC_UPDATE)
            csg_slot_sync_update_locked()
              group_check_job_completion()
                queue_check_job_completion()
                  if (job->profiling.mask)
                    update_fdinfo_stats()
                      spin_lock(&group->fdinfo.lock)

However group->fdinfo.lock is also held in process context via:

 panthor_gpu_show_fdinfo()
   panthor_fdinfo_gather_group_samples()
     guard(spinlock)(&group->fdinfo.lock);

So panthor_fdinfo_gather_group_samples() will need to use
spinlock_irqsave to be safe.

Thanks,
Steve

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 33 +++++++++++++++++++++++++++++++--
>  1 file changed, 31 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index f5e0ceca4130..05c632913359 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1087,9 +1087,38 @@ static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
>  	}
>  }
>  
> +static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
> +{
> +	struct panthor_irq *pirq = data;
> +
> +	if (!gpu_read(pirq->iomem, INT_STAT))
> +		return IRQ_NONE;
> +
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +		if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)
> +			return IRQ_NONE;
> +
> +		pirq->state = PANTHOR_IRQ_STATE_PROCESSING;
> +	}
> +
> +	panthor_job_irq_handler(pirq, gpu_read(pirq->iomem, INT_RAWSTAT));
> +
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING)
> +			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
> +	}
> +
> +	return IRQ_HANDLED;
> +}
> +
>  static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
>  {
> -	return panthor_irq_default_threaded_handler(data, panthor_job_irq_handler);
> +	struct panthor_irq *pirq = data;
> +
> +	/* We never return IRQ_WAKE_THREAD, so we're not supposed to be called. */
> +	drm_WARN_ON_ONCE(&pirq->ptdev->base,
> +			 "threaded IRQ handler should never be called.");
> +	return IRQ_NONE;
>  }
>  
>  static int panthor_fw_start(struct panthor_device *ptdev)
> @@ -1489,7 +1518,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  
>  	ret = panthor_irq_request(ptdev, &fw->irq, irq, 0,
>  				  ptdev->iomem + JOB_INT_BASE, "job",
> -				  panthor_irq_default_raw_handler,
> +				  panthor_job_irq_raw_handler,
>  				  panthor_job_irq_threaded_handler);
>  	if (ret) {
>  		drm_err(&ptdev->base, "failed to request job irq");
> 

