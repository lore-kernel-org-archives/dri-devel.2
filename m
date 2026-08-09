Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A1F87C5AC80
	for <dri-devel@archiver.kernel.org>; Sun,  9 Aug 2026 13:35:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C39E410E57A;
	Sun,  9 Aug 2026 13:35:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Ar6NuZ/r";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D3C3310E57A
 for <dri-devel@lists.freedesktop.org>; Sun,  9 Aug 2026 13:35:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 7E2B340946;
 Sun,  9 Aug 2026 13:35:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A5571F000E9;
 Sun,  9 Aug 2026 13:35:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786282531;
 bh=927VDy+W9OJhCJrIe7xI6bBSIoS9rsBuAeo8D7ujAr8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Ar6NuZ/r5u/DnX3HaMSZHyVeCpQU6UC9V2Aa/N6Dd9k2GJolsO+r0MPqKzR7ppQa1
 rkWvgUafxNUwExTryRhH1HZFlnxIlF3ALMXROk+NwNorsSoqMmwzaqEizBI7s/46Qe
 DHhHUN0T1brhLDUcRpjkPrSy1bs2804+gsx9STmBbfojSMa8mQX5FCyOPImij4nbqw
 6vtRSpLKi7LYuE/XJYCwLy/UvFp/AiJN5SqxFov/Iwfg1whIk/3W53/6tYbl+2S42o
 fUFnC2QS59AAO+gMsPF4vUBLBc9llqHlo08kGJHSffgnIWLPwh72vs9qezgusO7tCw
 J/OW5WpUG2Ygg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/17] drm/spacemit: add Saturn DPU KMS pipeline
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: vkoul@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, olteanv@gmail.com, linux-phy@lists.infradead.org,
 neil.armstrong@linaro.org, robh@kernel.org
In-Reply-To: <20260809-k3-display-v2-10-327d7910bf71@gmail.com>
References: <20260809-k3-display-v2-0-327d7910bf71@gmail.com>
 <20260809-k3-display-v2-10-327d7910bf71@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 09 Aug 2026 13:35:28 +0000
Message-Id: <20260809133529.9A5571F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [Critical] Early return in atomic_disable due to drm_dev_enter skips hard=
ware teardown and timer cancellation.
- [Critical] Permanent physical memory leak due to unbalanced page pinning =
in spacemit_dmmu_map.
- [High] Sleeping functions called from atomic context in CRTC atomic_enabl=
e and atomic_disable callbacks.
- [High] Plane atomic_update callback invokes sleeping GEM helpers.
- [High] Interrupt storm due to unhandled IRQ during device bind.
- [High] Race condition between IRQ synchronization and clock gating.
- [High] Memory leak of DRM device on component unbind.
- [High] Unconditional interrupt enable via spin_unlock_irq in atomic conte=
xt.
- [High] Ignored return value of get_cl_rdma_buf leads to Use-After-Free of=
 command list registers.
--

--- Patch [10]: [PATCH v2 10/17] drm/spacemit: add Saturn DPU KMS pipeline =
---
commit f9572a94b08eefdd84a13496054fbc00b42837b7
Author: Cody Kang <codykang.hk@gmail.com>
Subject: drm/spacemit: add Saturn DPU KMS pipeline

Add the atomic KMS implementation on top of the hardware backend: one
CRTC and one primary plane per DPU instance. atomic_check validates
the plane rectangle 1:1 against the mode and sizes the per-channel FBC
line buffer; atomic commit builds the cmdlist batches, maps the
framebuffer through the DMMU and arms the cfg-ready handshake, with
vblank events driven from the DPU interrupt.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/s=
pacemit/spacemit_crtc.c
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c

[ ... ]

> @@ -96,25 +96,25 @@ static void spacemit_crtc_atomic_enable(struct drm_cr=
tc *crtc,
> 					struct drm_atomic_commit *old_state)
> {

[ ... ]

> 	if (unlikely(a_crtc->first_modeset)) {
> 		ret =3D reset_control_bulk_assert(ARRAY_SIZE(priv->pipe_resets),
> 						priv->pipe_resets);
> 		if (ret)
> 			dev_warn(a_crtc->dev,
> 				 "failed to assert resets: %d\n", ret);
> 		usleep_range(10000, 20000);
> 		a_crtc->first_modeset =3D false;
> 	}
>=20
> 	if (!a_crtc->clocks_on) {
> 		dpu_pm_resume(a_crtc->dev);
> 		a_crtc->clocks_on =3D true;
>=20
> 		/*
> 		 * The DPU must settle after reset deassert or CFG_RDY races
> 		 * the flush.
> 		 */
> 		usleep_range(10000, 20000);
> 	}

[Severity: High]
Could the usleep_range() calls cause system instability?

The DRM subsystem requires CRTC atomic_enable and atomic_disable callbacks =
to
execute in atomic context, where sleeping is strictly forbidden.

Because usleep_range() sleeps, calling it directly here violates the atomic
context constraints.

[ ... ]

> @@ -131,23 +129,20 @@ static void spacemit_crtc_atomic_disable(struct drm=
_crtc *crtc,
> 					 struct drm_atomic_commit *old_state)
> {
> 	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
> 	struct drm_device *drm =3D a_crtc->crtc.dev;
> 	int idx;
>=20
> 	if (!drm_dev_enter(drm, &idx))
> 		return;

[Severity: Critical]
Does checking drm_dev_enter() here inadvertently skip hardware teardown
during unbind?

During driver unbind, spacemit_drm_master_unbind() calls drm_dev_unregister=
(),
which sets the unplugged flag. It then calls drm_atomic_helper_shutdown(),
which invokes spacemit_crtc_atomic_disable().

Because the device is already marked unplugged, drm_dev_enter() evaluates to
false. This causes an immediate return, bypassing the timer cancellation
(which leaves a pending timer pointing to freed memory) and the VBLANK event
signaling (which can stall the teardown commit).

[ ... ]

> 	/*
> 	 * MMIO on a clock-gated DPU stalls the bus, so an in-flight handler
> 	 * must finish its status reads before dpu_pm_suspend() gates the
> 	 * clocks.
> 	 */
> 	if (a_crtc->irq_online > 0)
> 		synchronize_irq(a_crtc->irq_online);

[Severity: High]
Is it safe to call synchronize_irq() in atomic context?

This function can sleep, which violates the requirement that atomic_disable
callbacks execute in atomic context without sleeping.

> 	/*
> 	 * Nothing else cancels the watchdog; it would fire against freed state.
> 	 */
> 	timer_delete_sync(&a_crtc->cfg_rdy_timer);
>=20
> 	/* Close the ISR's MMIO gate before the clocks actually stop. */
> 	a_crtc->clocks_on =3D false;
> 	dpu_pm_suspend(a_crtc->dev);

[Severity: High]
Might this sequence allow a new interrupt to slip in?

If synchronize_irq() completes, it only guarantees that in-flight handlers
have finished. Because a_crtc->clocks_on is still true when it returns, a
newly triggered interrupt could immediately enter the ISR.

Meanwhile, this thread continues, setting a_crtc->clocks_on to false and
calling dpu_pm_suspend() to gate the clocks. If the racing ISR attempts
MMIO reads on the clock-gated hardware, it could stall the system bus.

Additionally, does dpu_pm_suspend() sleep in this atomic context? It
invokes usleep_range() internally, which would violate the atomic_disable
constraints.

> 	spin_lock_irq(&drm->event_lock);
> 	if (crtc->state->event) {
> 		drm_crtc_send_vblank_event(crtc, crtc->state->event);
> 		crtc->state->event =3D NULL;
> 	}
> 	spin_unlock_irq(&drm->event_lock);

[Severity: High]
Will this unconditionally re-enable local interrupts?

Because spacemit_crtc_atomic_disable() executes in atomic context, the call=
er
might have already disabled interrupts. Calling spin_unlock_irq() re-enables
them unconditionally.

Would it be better to use spin_unlock_irqrestore() to preserve the original
CPU interrupt state?

[ ... ]

> @@ -467,20 +465,19 @@ static int spacemit_drm_master_bind(struct device *=
dev)
> {

[ ... ]

> 	kms =3D devm_drm_dev_alloc(dev, &spacemit_drm_drv,
> 				 struct spacemit_kms, drm);
> 	if (IS_ERR(kms))
> 		return PTR_ERR(kms);

[Severity: High]
Will this leak the DRM device structure on component unbind?

The KMS structure is allocated with devm_drm_dev_alloc() inside
spacemit_drm_master_bind(). The devm_* lifecycle is tied to the platform
device's probe and remove cycle, not the component bind and unbind cycle.

When spacemit_drm_master_unbind() is called, the DRM device is unregistered
but never freed because the platform device is not removed. A subsequent
re-bind would allocate a new instance, permanently leaking the old one along
with all drmm_* managed allocations.

[ ... ]

> 	enable_irq(priv->irq_online);
>=20
> 	ret =3D drm_dev_register(drm, 0);

[Severity: High]
Could enabling the IRQ here lead to an interrupt storm?

At this point during bind, the hardware might not be fully reset and
a_crtc->clocks_on is still false. If a bootloader left the display pipeline
active, the hardware will continuously assert the interrupt.

When the ISR fires, it sees !a_crtc->clocks_on and immediately returns
IRQ_NONE without clearing the hardware interrupt status. This causes the
interrupt to fire repeatedly, potentially hanging the system.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_planes.c b/drivers/gpu/drm=
/spacemit/spacemit_planes.c
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_planes.c

[ ... ]

> @@ -170,25 +170,24 @@ static void spacemit_plane_atomic_update(struct drm=
_plane *plane,
> 					 struct drm_atomic_commit *state)
> {

[ ... ]

> 	hwdev->get_cl_rdma_buf(a_crtc);

[Severity: High]
What happens if hwdev->get_cl_rdma_buf() fails here?

If the return value is ignored and it fails to allocate, a_crtc->cl_rdma co=
uld
remain uninitialized or retain a dangling pointer from a previous iteration.

Later, free_cmdlist_regs(a_crtc->cl_rdma) frees the pointer but does not set
it to NULL. If a subsequent plane update fails its allocation, it would
double-free the old pointer.

> 	hwdev->plane_update_hw_channel(plane);
>=20
> 	/* Solid-fill layers have no RDMA and no page table */
> 	if (rdma_id < hwdev->rdma_nums && spacemit_pstate->mmu_tbl.va) {
> 		u8 tbu_id =3D rdma_id * 2;
>=20
> 		ret =3D spacemit_dmmu_map(plane->state->fb,
> 					&spacemit_pstate->mmu_tbl, tbu_id,
> 					a_crtc->cl_rdma, plane);

[Severity: High]
Does this path invoke sleeping functions from atomic context?

The spacemit_plane_atomic_update() callback executes in atomic context.
However, it calls spacemit_dmmu_map(), which subsequently calls
drm_gem_shmem_get_pages_sgt().

The drm_gem_shmem_get_pages_sgt() helper acquires the pages_lock mutex and
can block for disk I/O or GFP_KERNEL allocations, which is unsafe in
atomic context. Should this mapping be deferred to the prepare_fb phase?

[Severity: Critical]
Is there a missing unpin for the pages acquired inside the mapping function?

Calling drm_gem_shmem_get_pages_sgt() retrieves the scatter-gather table
and implicitly pins the backing physical pages by incrementing the object's
pages_use_count.

Since this occurs on every plane atomic update, and there appears to be no
matching drm_gem_shmem_put_pages() call during cleanup, the pages_use_count
will continually inflate. This prevents the GEM SHMEM core from releasing t=
he
physical pages when the framebuffer is destroyed, leading to a permanent
memory leak.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260809-k3-display=
-v2-0-327d7910bf71@gmail.com?part=3D10
