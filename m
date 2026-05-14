Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4CED3CD4F25
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 15:23:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A593F10E37D;
	Thu, 14 May 2026 15:23:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="anD7SvoD";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id E466C10F27F
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 15:23:27 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 162A21655;
 Thu, 14 May 2026 08:23:22 -0700 (PDT)
Received: from [10.1.37.28] (e122027.cambridge.arm.com [10.1.37.28])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 8F7D23F836;
 Thu, 14 May 2026 08:23:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1778772207; bh=69LAz44gXqc4NIyDtpSy///c51rYIp3PaLqICN+TdLA=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=anD7SvoDWSwk/qlgZM/tkS6/ZxmRPeISNNt9sZED/edYJ1MQnY1nnpZqltSdCS/gr
 GzOY7q1MDSVdfERcDG6VdBkUrTMCFWL0qcqxV1ISsbWzF3ohuXfEeu9xjyi7yhBsND
 Dc/6ce+TYubrBOD71iWguGbdff0U9WIYqh5yIPtM=
Message-ID: <c5b6e08f-066c-4894-af9a-5dd248ac9adf@arm.com>
Date: Thu, 14 May 2026 16:23:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 09/11] drm/panthor: Process FW events in IRQ context
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260512-panthor-signal-from-irq-v2-0-95c614a739cb@collabora.com>
 <20260512-panthor-signal-from-irq-v2-9-95c614a739cb@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260512-panthor-signal-from-irq-v2-9-95c614a739cb@collabora.com>
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
> Now that everything is set to allow processing FW events in IRQ context,
> go for it. This should reduce the dma_fence signaling latency.
> 
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_fw.c | 27 +++++++++++++++++++++++----
>  1 file changed, 23 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_fw.c b/drivers/gpu/drm/panthor/panthor_fw.c
> index f5e0ceca4130..8cfebf180de7 100644
> --- a/drivers/gpu/drm/panthor/panthor_fw.c
> +++ b/drivers/gpu/drm/panthor/panthor_fw.c
> @@ -1087,9 +1087,29 @@ static void panthor_job_irq_handler(struct panthor_irq *pirq, u32 status)
>  	}
>  }
>  
> -static irqreturn_t panthor_job_irq_threaded_handler(int irq, void *data)
> +static irqreturn_t panthor_job_irq_raw_handler(int irq, void *data)
>  {
> -	return panthor_irq_default_threaded_handler(data, panthor_job_irq_handler);
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
> +	/* We can use INT_STAT here, because we didn't mask the IRQs. */
> +	panthor_job_irq_handler(pirq, gpu_read(pirq->iomem, INT_STAT));
> +
> +	scoped_guard(spinlock_irqsave, &pirq->mask_lock) {
> +		if (pirq->state == PANTHOR_IRQ_STATE_PROCESSING)
> +			pirq->state = PANTHOR_IRQ_STATE_ACTIVE;
> +	}
> +
> +	return IRQ_HANDLED;
>  }
>  
>  static int panthor_fw_start(struct panthor_device *ptdev)
> @@ -1489,8 +1509,7 @@ int panthor_fw_init(struct panthor_device *ptdev)
>  
>  	ret = panthor_irq_request(ptdev, &fw->irq, irq, 0,
>  				  ptdev->iomem + JOB_INT_BASE, "job",
> -				  panthor_irq_default_raw_handler,
> -				  panthor_job_irq_threaded_handler);
> +				  panthor_job_irq_raw_handler, NULL);
>  	if (ret) {
>  		drm_err(&ptdev->base, "failed to request job irq");
>  		return ret;
> 

