Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 177E2CD6E4A
	for <dri-devel@archiver.kernel.org>; Thu,  4 Jun 2026 02:49:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 300C11125B1;
	Thu,  4 Jun 2026 02:49:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ih0M909S";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D93B1125B1
 for <dri-devel@lists.freedesktop.org>; Thu,  4 Jun 2026 02:49:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 87AFD601DD;
 Thu,  4 Jun 2026 02:49:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D131F00893;
 Thu,  4 Jun 2026 02:49:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780541362;
 bh=is8JgiAyYpeCizHS/TjMLXxGrQo5eMnM5+nKIo5pDOc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ih0M909SWhS0u6UWdmgSRE/VDRkqohY5NTEodjGLM71iQL/hHj/qeZKqmjTMuZ6kc
 r6E6GoG8mw4qmPLS11qEQnGUG+HznYGUeW+Q8kIgjPtWyZUHjiauLY0PXHxhrgHH9/
 LnoZVEra1jQ73eyzrRh9mmaUgsaJSnRllbRIjgCFHB1bcwS37/BL5QjZLvaG1l0g66
 cwDhEP8EJYzo7giBfuzy+DJWWfLSUt2/4EL2aWh2l+CqiQEOV0P1Q8DBP2Gdz+wqBt
 X8AJwy21fomJyoEzWUyMZRxz2WcXlrRLFQhkBy67mnp2G6w3a/1OoMKhjDYB2HmYnI
 nwyeoG4RBhlOg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 03/14] drm/v3d: Use inline lock for dma fence
 initialization
To: =?utf-8?b?TWHDrXJhIENhbmFs?= <mcanal@igalia.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260603-v3d-sched-misc-fixes-v3-3-d7114bba55a0@igalia.com>
References: <20260603-v3d-sched-misc-fixes-v3-3-d7114bba55a0@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 04 Jun 2026 02:49:21 +0000
Message-Id: <20260604024922.11D131F00893@smtp.kernel.org>
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
Reply-To: sashiko-reviews@lists.linux.dev
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Critical] Decoupling the DMA fence lock from the queue lock breaks impli=
cit synchronization, causing a Use-After-Free of `bin_job` in `v3d_overflow=
_mem_work()`.
--

commit f6b0f3208abbe884d00ac4c3eab910833b936a7f
Author: Ma=C3=ADra Canal <mcanal@igalia.com>
Subject: drm/v3d: Use inline lock for dma fence initialization

This patch changes dma_fence_init() to accept a NULL external lock,
falling back to an inline spinlock embedded in the fence itself. This
decouples the lock and the fence lifetime, allowing queue_lock to use
spin_(un)lock() instead of the IRQ variants in all its uses.

> diff --git a/drivers/gpu/drm/v3d/v3d_fence.c b/drivers/gpu/drm/v3d/v3d_fe=
nce.c
> index c500136d04557..9b1a882a4c159 100644
> --- a/drivers/gpu/drm/v3d/v3d_fence.c
> +++ b/drivers/gpu/drm/v3d/v3d_fence.c
> @@ -15,7 +15,7 @@ struct dma_fence *v3d_fence_create(struct v3d_dev *v3d,=
 enum v3d_queue q)
>  	fence->dev =3D &v3d->drm;
>  	fence->queue =3D q;
>  	fence->seqno =3D ++queue->emit_seqno;
> -	dma_fence_init(&fence->base, &v3d_fence_ops, &queue->queue_lock,
> +	dma_fence_init(&fence->base, &v3d_fence_ops, NULL,

[Severity: Critical]
Does decoupling the DMA fence lock from the queue lock here break implicit
synchronization and cause a use-after-free of bin_job in
v3d_overflow_mem_work()?

It looks like v3d_overflow_mem_work() runs in a workqueue and accesses
bin_job =3D (struct v3d_bin_job *)queue->active_job under queue_lock:

drivers/gpu/drm/v3d/v3d_irq.c:v3d_overflow_mem_work() {
    ...
    spin_lock_irqsave(&queue->queue_lock, irq_flags);
    ...
    list_add_tail(&bo->unref_head, &bin_job->render->unref_list);
    ...
}

Meanwhile, the interrupt handler v3d_irq_signal_fence() clears
queue->active_job and signals the job's fence:

drivers/gpu/drm/v3d/v3d_irq.c:v3d_irq_signal_fence() {
    ...
    queue->active_job =3D NULL;
    ...
    dma_fence_signal(&fence->base);
    ...
}

Before this patch, the fence's external lock was set to &queue->queue_lock,
so dma_fence_signal() would block on queue_lock, preventing the DRM schedul=
er
from waking up and freeing the job while v3d_overflow_mem_work() was execut=
ing.

By changing the fence's external lock to NULL, dma_fence_signal() uses its
own inline lock and returns immediately. Could this allow the DRM scheduler=
's
wait queue to wake up and free bin_job concurrently, leading to a
use-after-free when v3d_overflow_mem_work() dereferences bin_job->render?

>  		       queue->fence_context, fence->seqno);
> =20
>  	return &fence->base;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260603-v3d-sched-=
misc-fixes-v3-0-d7114bba55a0@igalia.com?part=3D3
