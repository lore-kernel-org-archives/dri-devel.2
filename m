Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EB3A606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 23:16:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F0a1A69Z
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 83E8110E2A8;
	Thu, 12 Nov 2026 23:16:39 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EF88110E2A8
 for <dri-devel@lists.freedesktop.org>; Thu, 12 Nov 2026 23:16:32 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id D2D0945C90;
 Thu, 12 Nov 2026 23:16:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D0D21F000C4;
 Thu, 12 Nov 2026 23:16:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794525392;
 bh=Wkl8yE7BTEE5mfWlk6tmVd/IGKJXfVqzcfL2r2EeFS8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=F0a1A69ZVgPjmTQOtDxA6DNDJtcrVjrsfmYRNHPphdOPzIn7ZkdQhvNvmDXdv23n4
 K+p5BtgPVBARQOG1QTQt6oOBm+6aLQC+8gagYCA6HmvGknOUuSQTVC8E2HTQ+424Mr
 5yrytfce8p2+Z42GI9H6+mLCH6RbeuOTHRu6xK9eqEsQCKDVhiF2QMzM3cV0FE1jpS
 TXEMT9tKuPZ5v4iaHousfVBmFn13rgfXuzQOnW1bLBDSL4KOn+HDF9IdiDMoYblULt
 zw8bjv0z1lLBUORKorckspKiK3HiuNYRdPNU+5HaJN5c7Lzs4DshIQxzgU9QKmJHz6
 yaYm6R7+NT+Vw==
Message-ID: <sashiko-outbox-211937@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 05/13] drm/powervr_sgx: Add the core table,
 registers and device bring-up
To: "Joseph Telaak" <joseph@telaak.dev>, dri-devel@lists.freedesktop.org
Cc: media-ci@linuxtv.org
In-Reply-To: <20261112-powervr-sgx-v1-5-c69b84bac011@telaak.dev>
References: <20261112-powervr-sgx-v1-0-c69b84bac011@telaak.dev>
 <20261112-powervr-sgx-v1-5-c69b84bac011@telaak.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 23:16:32 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential
issues to consider:
- [High] drm/powervr_sgx: missing cache invalidation in
  pvrsgx_pages_wc() on ARM
- [High] drm/powervr_sgx: unchecked GFP_KERNEL allocation in
  pvrsgx_reset()
- [Medium] drm/powervr_sgx: mismatched hostctl interrupt flags in
  pvrsgx_irq()
- [Medium] drm/powervr_sgx: NULL sdev race in irq_teardown() behind
  gma500
- [Medium] drm/powervr_sgx: pvrsgx_gma_irq() queues fence work on
  non-WQ_MEM_RECLAIM wq
- [Low] drm/powervr_sgx: missing allow_unisolated entry in driver
  documentation
--

commit b0a257171905ef3814429e591ec9fc642208ebbe
Author: Joseph Telaak <joseph@telaak.dev>

drm/powervr_sgx: Add the core table, registers and device bring-up

This commit adds the SGX5xx core description tables, register definitions,
two-level MMU page table management, and device initialization and reset
handling for the powervr_sgx driver.

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_cache.h b/drivers/gpu/drm=
/powervr_sgx/pvrsgx_cache.h
> new file mode 100644
> index 0000000000000..76ccee62ed18c
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_cache.h
[ ... ]
> +static inline int pvrsgx_pages_wc(struct device *dev, struct page **page=
s, unsigned int n)
> +{
> +	for (unsigned int i =3D 0; i < n; i++) {
> +		/* Mapping for the device writes back the page's dirty lines. */
> +		dma_addr_t a =3D dma_map_page(dev, pages[i], 0, PAGE_SIZE, DMA_TO_DEVI=
CE);
> +
> +		if (dma_mapping_error(dev, a))
> +			return -ENOMEM;
> +		dma_unmap_page(dev, a, PAGE_SIZE, DMA_TO_DEVICE);
> +	}
> +	return 0;
> +}

[Severity: High]
Does using DMA_TO_DEVICE here leave valid cache lines resident in the CPU
data cache on ARM?

pvrsgx_kmem_alloc() and table_page_alloc() allocate pages with __GFP_ZERO,
which zeroes them through the cacheable linear mapping.  On ARM,
dma_map_page() and dma_unmap_page() with DMA_TO_DEVICE clean dirty lines to
DRAM on map and do nothing on unmap, so the zero-filled lines stay valid in
the cache.  When the CPU later reads GPU-written firmware control blocks
(such as HOSTCTL or TA3DCTL) through the write-combined vmap alias, PIPT
caches can satisfy those reads with stale zeros instead of reading DRAM.
Using DMA_BIDIRECTIONAL cleans on map and invalidates on unmap.

Also, pvrsgx_kmem_alloc() and table_page_alloc() pass sdev->base.dev to
pvrsgx_pages_wc() instead of drm_dev_dma_dev(&sdev->base), which uses the
auxiliary device rather than the parent PCI DMA device when running behind
gma500.

[ ... ]

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c b/drivers/gpu/drm/=
powervr_sgx/pvrsgx_core.c
> new file mode 100644
> index 0000000000000..dd8fd14ebd816
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_core.c
[ ... ]
> +bool pvrsgx_allow_unisolated;
> +module_param_named(allow_unisolated, pvrsgx_allow_unisolated, bool, 0444=
);
> +MODULE_PARM_DESC(allow_unisolated,
> +		 "Run a single-context core (SGX530), where clients can reach the firm=
ware and each other's commands (default off)");

[Severity: Low]
The allow_unisolated module parameter is not listed in the Module
parameters section of Documentation/gpu/powervr_sgx/index.rst.

[ ... ]

> diff --git a/drivers/gpu/drm/powervr_sgx/pvrsgx_device.c b/drivers/gpu/dr=
m/powervr_sgx/pvrsgx_device.c
> new file mode 100644
> index 0000000000000..9328e8e063f70
> --- /dev/null
> +++ b/drivers/gpu/drm/powervr_sgx/pvrsgx_device.c
[ ... ]
> +void pvrsgx_reset(struct pvrsgx_device *sdev, bool recovery)
> +{
[ ... ]
> +		/* Let each faulting request complete on a scratch page. */
> +		for (int n =3D 0; n < 32; n++) {
> +			u32 stat =3D sgx_rd(sdev, SGX_CR_BIF_INT_STAT), addr;
> +
> +			if (!(stat & sdev->cr->bif_int_stat_fault_req))
> +				break;
> +			addr =3D sgx_rd(sdev, SGX_CR_BIF_FAULT) & sdev->cr->bif_fault_addr;
> +			drm_warn(&sdev->base, "reset: page fault 0x%x at 0x%08x\n", stat, add=
r);
> +			soft_reset(sdev, true);
> +			pvrsgx_mmu_map_pages(sdev->reset_mmu, addr, &sdev->reset_page, 1, 0);

[Severity: High]
Can pvrsgx_mmu_map_pages(sdev->reset_mmu, ...) allocate with GFP_KERNEL on
the GPU reset path?

sdev->reset_mmu is created with only a top-level page directory, so the
first fault in a 4 MiB range allocates a second-level page table via
pte_get() -> table_page_alloc(), using GFP_KERNEL and set_pages_array_wc()
or vmap().  During hang recovery, pvrsgx_timedout_job() ->
pvrsgx_fw_start() -> pvrsgx_reset() runs inside a dma_fence signalling
section under sdev->reset_lock, where GFP_KERNEL allocations can deadlock
against memory reclaim waiting on an in-flight GPU fence.

In addition, the return value of pvrsgx_mmu_map_pages() is ignored; if the
allocation fails, addr stays unmapped in sdev->reset_mmu and the recovery
loop repeats the same fault for all 32 iterations.

[ ... ]

> +/* The microkernel raises SW_EVENT when it wants the host. */
> +static irqreturn_t pvrsgx_irq(int irq, void *arg)
> +{
> +	struct pvrsgx_device *sdev =3D arg;
> +	u32 status;
> +
> +	if (!READ_ONCE(sdev->powered))
> +		return IRQ_NONE;
> +	status =3D sgx_rd(sdev, SGX_CR_EVENT_STATUS) & sgx_rd(sdev, SGX_CR_EVEN=
T_HOST_ENABLE);
> +	if (!(status & SGX_CR_EVENT_STATUS_SW_EVENT))
> +		return IRQ_NONE;
> +	trace_pvrsgx_irq(status);
> +	sgx_wr(sdev, SGX_CR_EVENT_HOST_CLEAR,
> +	       SGX_CR_EVENT_HOST_CLEAR_SW_EVENT | SGX_CR_EVENT_HOST_CLEAR_MASTE=
R_INTERRUPT);
> +	atomic_inc(&sdev->irq_count);
> +	/*
> +	 * The microkernel may interrupt at TA and 3D completion too: wake the
> +	 * thread only for a finished job or a lockup report.
> +	 */
> +	if (!sdev->fw_running || pvrsgx_job_oldest_done(sdev) ||
> +	    (pvrsgx_fw_hostctl(sdev, HOSTCTL_INTERRUPT_FLAGS) & HOSTCTL_INTERRU=
PT_HWR))
> +		return IRQ_WAKE_THREAD;
> +	return IRQ_HANDLED;
> +}
> +
> +static irqreturn_t pvrsgx_irq_thread(int irq, void *arg)
> +{
> +	struct pvrsgx_device *sdev =3D arg;
> +	u32 flags, clear;
> +
> +	if (!sdev->fw_running)
> +		return IRQ_HANDLED;
> +
> +	flags =3D pvrsgx_fw_hostctl(sdev, HOSTCTL_INTERRUPT_FLAGS);
> +	clear =3D pvrsgx_fw_hostctl(sdev, HOSTCTL_INTERRUPT_CLEAR);
> +	if ((flags & HOSTCTL_INTERRUPT_HWR) && !(clear & HOSTCTL_INTERRUPT_HWR))
> +		drm_err_ratelimited(&sdev->base, "microkernel reports a lockup (%u)\n",
> +				    pvrsgx_fw_hostctl(sdev, HOSTCTL_UK_LOCKUPS));
> +	/*
> +	 * The microkernel's idle notice: acknowledge it in the interrupt clear=
 word.
> +	 * Powering down is runtime PM's business, so nothing else happens here.
> +	 */
> +	if ((flags & ~clear) & HOSTCTL_INTERRUPT_ACTIVE_POWER)
> +		pvrsgx_fw_hostctl_set(sdev, HOSTCTL_INTERRUPT_CLEAR,
> +				      clear | HOSTCTL_INTERRUPT_ACTIVE_POWER);
> +
> +	pvrsgx_job_process_done(sdev);
> +	return IRQ_HANDLED;
> +}

[Severity: Medium]
Do pvrsgx_irq() and pvrsgx_irq_thread() disagree on how
HOSTCTL_INTERRUPT_FLAGS and HOSTCTL_INTERRUPT_CLEAR are handled?

pvrsgx_irq_thread() acknowledges HOSTCTL_INTERRUPT_ACTIVE_POWER in
HOSTCTL_INTERRUPT_CLEAR, but pvrsgx_irq() does not check for
HOSTCTL_INTERRUPT_ACTIVE_POWER before returning IRQ_HANDLED, so an idle
notice raised after the last job has finished never wakes the thread and is
left unacknowledged.

Conversely, pvrsgx_irq_thread() checks !(clear & HOSTCTL_INTERRUPT_HWR)
before logging a lockup, but never sets HOSTCTL_INTERRUPT_HWR in
HOSTCTL_INTERRUPT_CLEAR, and pvrsgx_irq() checks HOSTCTL_INTERRUPT_HWR
without masking out clear.  Once HOSTCTL_INTERRUPT_HWR is set, every later
SW_EVENT interrupt wakes the thread and logs the lockup again.

Also, pvrsgx_irq() returns IRQ_WAKE_THREAD when !sdev->fw_running, even
though pvrsgx_irq_thread() immediately returns IRQ_HANDLED in that case.

[ ... ]

> +#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_GMA500)
> +/* Behind gma500 the hard handler runs from gma500's; its thread is a wo=
rk item. */
> +static irqreturn_t pvrsgx_gma_irq(void *data)
> +{
> +	struct pvrsgx_device *sdev =3D data;
> +	irqreturn_t ret =3D pvrsgx_irq(sdev->irq, sdev);
> +
> +	if (ret =3D=3D IRQ_WAKE_THREAD) {
> +		queue_work(system_highpri_wq, &sdev->irq_work);
> +		return IRQ_HANDLED;
> +	}
> +	return ret;
> +}

[Severity: Medium]
Should sdev->irq_work be queued on sdev->wq instead of system_highpri_wq?

pvrsgx_gma_irq_work() calls pvrsgx_irq_thread() ->
pvrsgx_job_process_done(), which signals hardware dma_fences.
system_highpri_wq does not have WQ_MEM_RECLAIM, so fence signalling can
stall under memory pressure if its workers are blocked in memory reclaim
waiting on GPU fences.

[ ... ]

> +static void irq_teardown(struct pvrsgx_device *sdev)
> +{
> +#if IS_ENABLED(CONFIG_DRM_POWERVR_SGX_GMA500)
> +	if (sdev->gma_sgx) {
> +		sdev->gma_sgx->set_irq_handler(sdev->gma_sgx, NULL, NULL);
> +		cancel_work_sync(&sdev->irq_work);
> +		return;
> +	}
> +#endif
> +	free_irq(sdev->irq, sdev);
> +}

[Severity: Medium]
Can passing NULL for data to set_irq_handler() cause a NULL pointer
dereference in pvrsgx_gma_irq() if an interrupt fires concurrently on
another CPU?

In commit "drm/gma500: Export the Cedarview SGX545 on the auxiliary bus",
gma_sgx_set_irq_handler() overwrites dev_priv->sgx_data before clearing
dev_priv->sgx_handler and before calling synchronize_irq(), while
gma_irq_handler() reads them without irqmask_lock:

CPU0                                  CPU1
gma_irq_handler()                     irq_teardown()
  sgx_handler =3D smp_load_acquire(       gma_sgx_set_irq_handler(..., NULL=
, NULL)
    &dev_priv->sgx_handler);              dev_priv->sgx_data =3D NULL;
                                          smp_store_release(
                                            &dev_priv->sgx_handler, NULL);
  sgx_handler(dev_priv->sgx_data)
    pvrsgx_gma_irq(NULL)
      sdev->irq  <-- NULL dereference

Keeping dev_priv->sgx_data intact until after synchronize_irq() in
gma_sgx_set_irq_handler(), or passing sdev instead of NULL here, avoids
clearing the pointer while an in-flight handler call can still read it.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112-powervr-sg=
x-v1-0-c69b84bac011@telaak.dev?part=3D5
