Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E8378CCFA13
	for <dri-devel@archiver.kernel.org>; Fri,  1 May 2026 13:22:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4CBB510E54D;
	Fri,  1 May 2026 13:22:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=arm.com header.i=@arm.com header.b="Z8zROnp6";
	dkim-atps=neutral
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
 by gabe.freedesktop.org (Postfix) with ESMTP id 293E010E54D
 for <dri-devel@lists.freedesktop.org>; Fri,  1 May 2026 13:22:51 +0000 (UTC)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
 by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 57C88176A;
 Fri,  1 May 2026 06:22:45 -0700 (PDT)
Received: from [10.1.29.19] (e122027.cambridge.arm.com [10.1.29.19])
 by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B09383F62B;
 Fri,  1 May 2026 06:22:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
 t=1777641770; bh=Vl/38uUXb1vcLhlCxqhynRT/sZn/K6DtlcLPfQs7zx8=;
 h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
 b=Z8zROnp60PcCKe0rVmpSHFEEgWK1fMQS+2w2i72wzYif2UODw4vDgnhOYM8R63410
 SKzMCHLcip25uD3Jxum1551zXs7eB6+l3haVR2G0oDtBfPpe5AjqY5tEsjmIYW6soJ
 i7rSonVxdh3ctjohXPN3faknDCfIX45dnRayvHTc=
Message-ID: <6c53d87b-5101-4b84-9902-3972a8635721@arm.com>
Date: Fri, 1 May 2026 14:22:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 03/10] drm/panthor: Replace the panthor_irq macro
 machinery by inline helpers
To: Boris Brezillon <boris.brezillon@collabora.com>,
 Liviu Dudau <liviu.dudau@arm.com>
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
References: <20260429-panthor-signal-from-irq-v1-0-4b92ae4142d2@collabora.com>
 <20260429-panthor-signal-from-irq-v1-3-4b92ae4142d2@collabora.com>
From: Steven Price <steven.price@arm.com>
Content-Language: en-GB
In-Reply-To: <20260429-panthor-signal-from-irq-v1-3-4b92ae4142d2@collabora.com>
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
> Signed-off-by: Boris Brezillon <boris.brezillon@collabora.com>

Nice! I've never liked those macros. One minor issue below but with that
fixed:

Reviewed-by: Steven Price <steven.price@arm.com>

> ---
>  drivers/gpu/drm/panthor/panthor_device.h | 245 +++++++++++++++----------------
>  drivers/gpu/drm/panthor/panthor_fw.c     |  22 ++-
>  drivers/gpu/drm/panthor/panthor_gpu.c    |  26 ++--
>  drivers/gpu/drm/panthor/panthor_mmu.c    |  37 ++---
>  drivers/gpu/drm/panthor/panthor_pwr.c    |  20 ++-
>  5 files changed, 183 insertions(+), 167 deletions(-)
> 
> diff --git a/drivers/gpu/drm/panthor/panthor_device.h b/drivers/gpu/drm/panthor/panthor_device.h
> index 768fc1992368..afa202546316 100644
> --- a/drivers/gpu/drm/panthor/panthor_device.h
> +++ b/drivers/gpu/drm/panthor/panthor_device.h
[...]
> +static inline int
> +panthor_irq_request(struct panthor_device *ptdev, struct panthor_irq *pirq,
> +		    int irq, u32 mask, void __iomem *iomem, const char *name,
> +		    irqreturn_t (*threaded_handler)(int, void *data))
> +{
> +	const char *full_name;
> +
> +	pirq->ptdev = ptdev;
> +	pirq->irq = irq;
> +	pirq->mask = mask;
> +	pirq->iomem = iomem;
> +	spin_lock_init(&pirq->mask_lock);
> +	panthor_irq_resume(pirq);
> +
> +	full_name = devm_kasprintf(ptdev->base.dev, GFP_KERNEL, KBUILD_MODNAME "-%s", name);
> +	if (!full_name)
> +		return -ENOMEM;

You should probably move this failure path up before the
panthor_irq_resume() call.

Thanks,
Steve

