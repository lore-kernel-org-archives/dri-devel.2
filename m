Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 51490CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 11:50:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B054310E63A;
	Tue, 12 May 2026 11:50:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="YlAHk6rH";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B522110E63A
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 11:50:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1778586646;
 bh=5s9AyZU56idpcmF3s2TYPadfxaWaybAtmlJtq8dFaEw=;
 h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
 b=YlAHk6rHRp2Xp8pPVFQyMLag2hSI7lPJ+0uPdmWf034zs6hdpbczlTpMDUzmHytuE
 g+WXhfEgl0pW1AMSizdP8I311RcEU2vNnKfwtgcF1pVVuzHgySYQ1g8OL5MIPKTBiV
 SntHzMj6mlmkoivDsfqnCPA99YqmdUKJju4V4kocQKT8or8qwNR+set+NWpJSLXVlk
 R/2/PQUEwwHBJxJ7BOuN5OLgtR/fadGOx6Xml9hFE+/2ugcJ4KLvObFQHN2qRZpPlv
 Uq2VbOEwIHfhiIqhAmabrwSZO+O65Eh/H5S/PGBqUOEoDmda02It3TTQlhQkhlkqR8
 PtWANiWZ7yYgg==
Received: from fedora (unknown [100.64.0.11])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: bbrezillon)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 04C3117E12D3;
 Tue, 12 May 2026 13:50:45 +0200 (CEST)
Date: Tue, 12 May 2026 13:50:41 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Steven Price <steven.price@arm.com>, Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, Maxime Ripard
 <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, David Airlie
 <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 11/11] drm/panthor: Process GPU events in IRQ context
Message-ID: <20260512135041.7801aa88@fedora>
In-Reply-To: <20260512-panthor-signal-from-irq-v2-11-95c614a739cb@collabora.com>
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-11-95c614a739cb@collabora.com>
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

On Tue, 12 May 2026 13:37:41 +0200
Boris Brezillon <boris.brezillon@collabora.com> wrote:

> The current panthor_gpu_irq_handler() logic is already IRQ-safe
> (no sleep or sleeping locks, spinlocks taken with irqsave in other
> contexts, etc), so let's toggle the switch and make it an hard IRQ
> handler.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>
> ---
>  drivers/gpu/drm/panthor/panthor_gpu.c | 15 ++++++++-------
>  1 file changed, 8 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_gpu.c b/drivers/gpu/drm/panthor/panthor_gpu.c
> index b9c51f8a051d..04c8f23baf3f 100644
> --- a/drivers/gpu/drm/panthor/panthor_gpu.c
> +++ b/drivers/gpu/drm/panthor/panthor_gpu.c
> @@ -86,10 +86,15 @@ static void panthor_gpu_l2_config_set(struct panthor_device *ptdev)
>  	gpu_write(gpu->iomem, GPU_L2_CONFIG, l2_config);
>  }
>  
> -static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
> +static irqreturn_t panthor_gpu_irq_raw_handler(int irq, void *data)
>  {
> +	struct panthor_irq *pirq = data;
>  	struct panthor_device *ptdev = pirq->ptdev;
>  	struct panthor_gpu *gpu = ptdev->gpu;
> +	u32 status = gpu_read(gpu->irq.iomem, INT_STAT);
> +
> +	if (!status)
> +		return IRQ_NONE;
>  

Forgot to add the pirq state transition here:

       scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
               if (pirq->state != PANTHOR_IRQ_STATE_ACTIVE)
                       return IRQ_NONE;

               pirq->state = PANTHOR_IRQ_STATE_PROCESSING;
       }

>  	gpu_write(gpu->irq.iomem, INT_CLEAR, status);
>  
> @@ -115,11 +120,8 @@ static void panthor_gpu_irq_handler(struct panthor_irq *pirq, u32 status)
>  		ptdev->gpu->pending_reqs &= ~status;
>  		wake_up_all(&ptdev->gpu->reqs_acked);
>  	}
> -}
>  
> -static irqreturn_t panthor_gpu_irq_threaded_handler(int irq, void *data)
> -{
> -	return panthor_irq_default_threaded_handler(data, panthor_gpu_irq_handler);

and restore it here:

       scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
               if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING)
                       pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
       }

> +	return IRQ_HANDLED;
>  }
>  
>  /**
> @@ -176,8 +178,7 @@ int panthor_gpu_init(struct panthor_device *ptdev)
>  	ret = panthor_irq_request(ptdev, &ptdev->gpu->irq, irq,
>  				  GPU_INTERRUPTS_MASK,
>  				  ptdev->iomem + GPU_INT_BASE, "gpu",
> -				  panthor_irq_default_raw_handler,
> -				  panthor_gpu_irq_threaded_handler);
> +				  panthor_gpu_irq_raw_handler, NULL);
>  	if (ret)
>  		return ret;
>  
> 

