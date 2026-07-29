Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B84FDC53219
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 03:12:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D0E1D10EA6E;
	Wed, 29 Jul 2026 03:12:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="UBUCqsfr";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B6E1110EA6E
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 03:12:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 62AB6433D1;
 Wed, 29 Jul 2026 03:12:08 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 239C31F000E9;
 Wed, 29 Jul 2026 03:12:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1785294728;
 bh=Ak1I+AXQ45jeyWo2bS1E8G3Uo6bwpKVOe3xCEWEr0Ws=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UBUCqsfrxS7eR3kZkvCMftp80CpspflbihUEpOt4TFwDkH+rQgX4f6xi6B47MmYuo
 1brE+D3v2LNgDU/QYJQ3U+JamM2IB/LVx0ze1HeNv3rw87C1KKzhBP4nQu1OdBe5nu
 ixu2KylHJCxNVN8XQUCqbOBLZ48l1PtvgdTdmgIYIRaGFs7KSnMTxJ9mYhaGAVX08q
 i+lTtNXe+CwcgLgZ626TjdL2caIzesFhzcMQv8uKfpXcTjwRaM3xIA4vfi7sA1KIfh
 54BNFuyI8Z6kvWxqp9LmJjEdZqz7Cvb417WbJhI3HQjc3AdnrUGbCLDPFMYjzQqsGj
 0JgHUqBhwSpxQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 07/13] drm/panfrost: Sync with IRQ before MMU disable
 and reset
To: =?utf-8?b?QWRyacOhbiBMYXJ1bWJl?= <adrian.larumbe@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260729-claude-fixes-v4-7-01968f2ec77a@collabora.com>
References: <20260729-claude-fixes-v4-0-01968f2ec77a@collabora.com>
 <20260729-claude-fixes-v4-7-01968f2ec77a@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 29 Jul 2026 03:12:07 +0000
Message-Id: <20260729031208.239C31F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] Deadlock between DRM scheduler fence signalling and the MMU thread=
ed IRQ handler during device reset.

Pre-existing issues:
- [High] Incomplete IRQ synchronization during initialization and probe fai=
lure leads to use-after-free and NULL pointer dereferences on `pfdev->reset=
.wq`.
- [High] TOCTOU race in MMU and JM threaded IRQ handlers can lead to IRQ st=
orms after device suspend.
--

--- Patch [7]: [PATCH v4 07/13] drm/panfrost: Sync with IRQ before MMU disa=
ble and reset ---
commit 46502e10e9742128c205fa36652f0fba77751f65
Author: Adri=C3=A1n Larumbe <adrian.larumbe@collabora.com>
Subject: drm/panfrost: Sync with IRQ before MMU disable and reset

The patch ensures that the MMU threaded IRQ handler is synchronized before
disabling the MMU during a reset or device teardown. It adds an IRQ
synchronization call during device reset and uses the suspend IRQ routine
in the MMU teardown sequence.

> --- a/drivers/gpu/drm/panfrost/panfrost_mmu.c
> +++ b/drivers/gpu/drm/panfrost/panfrost_mmu.c
> @@ -347,6 +347,7 @@ void panfrost_mmu_reset(struct panfrost_device *pfdev)
>  	struct panfrost_mmu *mmu, *mmu_tmp;
> =20
>  	clear_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
> +	synchronize_irq(pfdev->mmu_irq);

[Severity: High]
Does this code introduce a deadlock between DRM scheduler fence signalling =
and
the MMU threaded IRQ handler during device reset?

During a job timeout recovery, panfrost_reset() establishes a DMA fence
signalling critical section via dma_fence_begin_signalling() before calling
panfrost_device_reset().

By adding synchronize_irq(pfdev->mmu_irq) here, the fence signalling thread
waits for the MMU threaded IRQ handler to complete.

However, the page fault handler panfrost_mmu_irq_handler_thread() allocates
memory with GFP_KERNEL:

    bo->sgts =3D kvmalloc_objs(struct sg_table,
                             bo->base.base.size / SZ_2M,
                             GFP_KERNEL | __GFP_ZERO);

If low memory conditions trigger direct reclaim, and direct reclaim waits f=
or
GPU fences to signal, will this create a circular lock dependency since the
fence signalling thread is blocked on synchronize_irq()?

> =20
>  	spin_lock(&pfdev->as_lock);
> =20

[ ... ]

> @@ -983,11 +984,6 @@ int panfrost_mmu_init(struct panfrost_device *pfdev)
>  	return 0;
>  }
> =20
> -void panfrost_mmu_fini(struct panfrost_device *pfdev)
> -{
> -	mmu_write(pfdev, MMU_INT_MASK, 0);
> -}
> -
>  void panfrost_mmu_suspend_irq(struct panfrost_device *pfdev)
>  {
>  	set_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended);
> @@ -995,3 +991,8 @@ void panfrost_mmu_suspend_irq(struct panfrost_device =
*pfdev)
>  	mmu_write(pfdev, MMU_INT_MASK, 0);
>  	synchronize_irq(pfdev->mmu_irq);
>  }

[Severity: High]
This isn't a bug introduced by this patch, but does panfrost_mmu_suspend_ir=
q()
race with panfrost_mmu_irq_handler_thread() and cause an IRQ storm?

In the MMU threaded IRQ handler, the suspended state is checked before
unmasking:

    if (!test_bit(PANFROST_COMP_BIT_MMU, pfdev->is_suspended)) {
        spin_lock(&pfdev->as_lock);
        mmu_write(pfdev, MMU_INT_MASK, ~pfdev->as_faulty_mask);
        ...
    }

If the threaded handler is preempted immediately after passing the test_bit=
()
check, panfrost_mmu_suspend_irq() can execute, set the suspended bit, mask
the interrupts, and block on synchronize_irq().

When the threaded handler resumes, does it blindly write the unmask value b=
ack
to MMU_INT_MASK?

Since the hardirq handler panfrost_mmu_irq_handler() returns IRQ_NONE when
the suspended bit is set, will any subsequent unmasked interrupt cause an
endless IRQ loop?

> +
> +void panfrost_mmu_fini(struct panfrost_device *pfdev)
> +{
> +	panfrost_mmu_suspend_irq(pfdev);
> +}

[Severity: High]
This is a pre-existing issue, but can incomplete IRQ synchronization during
initialization or probe failure lead to use-after-free or NULL pointer
dereferences on pfdev->reset.wq?

During initialization, panfrost_device_init() calls panfrost_mmu_init() whi=
ch
enables MMU interrupts, and then it calls panfrost_jm_init() which allocates
pfdev->reset.wq.

If an MMU interrupt triggers between these two calls, can the handler call
panfrost_device_schedule_reset() and invoke queue_work() with a NULL
pfdev->reset.wq?

During probe failure unwinding, panfrost_device_init() handles errors by
executing panfrost_jm_fini() (destroying the workqueue) before calling
panfrost_mmu_fini().

If an MMU interrupt fires in this teardown window, will it execute
queue_work() on the already freed pfdev->reset.wq?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260729-claude-fix=
es-v4-0-01968f2ec77a@collabora.com?part=3D7
