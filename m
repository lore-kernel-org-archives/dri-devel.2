Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA3E8C531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:04:29 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BFDC10E659;
	Sat, 25 Jul 2026 05:04:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="W8iof5dT";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046BE10E672
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:04:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C087843BE9;
 Sat, 25 Jul 2026 05:04:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33AE91F000E9;
 Sat, 25 Jul 2026 05:04:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784955867;
 bh=ut+438AG3bp1406wS3uQ/QfvCDFxEWBO9W7UtMXiDew=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=W8iof5dTQBVMQ+pWzQUGbIOAbSnCoZpG7k76AX4rfnZFz1MgYiJVcUeyVmmAV7dHz
 GgsvJyzW+BxZSV8LAFxbGc6vUp0igMxs2ba1bCYOo9fqqg3GT7fJa5n0dwPht/i+nQ
 XESPVtr9431i7QlfFTJgjxx7EdAWpNCVrOvkLOHz0Ouj42fuc/64aDXvkr5bKWFwrz
 jyGXMoRR4QRf1zzsA6Bi7NluFN/87/r0JRDYNd6WPLPAFLRcDkK9ec0ilPrdKv7EGh
 9WDoSGpwKBICUlK2x0OtodkWFv+vyCu4nXHHmR6buTanD0QlKKM5gXR2xJk1/sLGPR
 JxLzW79PAQnag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RESEND 10/17] drm/spacemit: add Saturn DPU KMS pipeline
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-phy@lists.infradead.org,
 olteanv@gmail.com, conor+dt@kernel.org, vkoul@kernel.org,
 neil.armstrong@linaro.org, robh@kernel.org, devicetree@vger.kernel.org
In-Reply-To: <20260725-k3-display-v1-10-6de34d80e86c@gmail.com>
References: <20260725-k3-display-v1-0-6de34d80e86c@gmail.com>
 <20260725-k3-display-v1-10-6de34d80e86c@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:04:26 +0000
Message-Id: <20260725050427.33AE91F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 10 potential issue=
(s) to consider:
- [High] Sleeping functions are called from CRTC atomic enable and disable =
callbacks, which execute in atomic context.
- [High] TOCTOU race when updating the `clocks_on` flag and gating hardware=
 clocks leads to MMIO stalls.
- [High] Calling `devm_drm_dev_alloc` inside a component `bind` callback le=
aks the DRM device on rebinds.
- [High] Enabling the DPU interrupt before hardware is initialized leads to=
 an unhandled IRQ storm.
- [High] `spacemit_plane_reset` bypasses the custom state destructor, leaki=
ng DMA coherent memory.
- [High] `disable_irq()` is called before `drm_atomic_helper_shutdown()` du=
ring driver unbind, causing shutdown to hang.
- [High] `spacemit_plane_atomic_check()` assigns RDMA channels based on unv=
alidated `zpos`, leading to channel collisions.
- [High] Unconditional `spin_unlock_irq` used in atomic context improperly =
re-enables interrupts.
- [Medium] Leaking DRM property blob references in `spacemit_crtc_duplicate=
_state` on error.
- [Medium] Missing NULL check on `plane->state` in `spacemit_plane_atomic_d=
uplicate_state` causes a crash if the state is missing.
--

--- Patch [10]: [PATCH RESEND 10/17] drm/spacemit: add Saturn DPU KMS pipel=
ine ---
commit cf6665928c2c5fcf07a88c5cd2141feb18245e17
Author: Cody Kang <codykang.hk@gmail.com>
Subject: drm/spacemit: add Saturn DPU KMS pipeline

Add the atomic KMS implementation on top of the hardware backend: one
CRTC and one primary plane per DPU instance. atomic_check validates
the plane rectangle 1:1 against the mode and sizes the per-channel FBC
line buffer.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/s=
pacemit/spacemit_crtc.c
> new file mode 100644
> index 0000000000000..b75ff63205011
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c

[ ... ]

> @@ -91,7 +91,7 @@ static void spacemit_crtc_atomic_enable(struct drm_crtc=
 *crtc,
>  		dpu_reset_assert(a_crtc->dev, "lcd", a_crtc->lcd_reset);
>  		dpu_reset_assert(a_crtc->dev, "esc", a_crtc->esc_reset);
>  		dpu_reset_assert(a_crtc->dev, "mclk", a_crtc->mclk_reset);
>  		dpu_reset_assert(a_crtc->dev, "aclk", a_crtc->aclk_reset);
>  		dpu_reset_assert(a_crtc->dev, "dsc", a_crtc->dsc_reset);
>  		usleep_range(10000, 20000);

[Severity: High]
Does this sleep in an atomic context? The spacemit_crtc_atomic_enable
callback is executed during a non-blocking DRM atomic commit, which runs
in an atomic context. Calling usleep_range() here might violate atomic
context rules and lead to scheduling-while-atomic warnings.

[ ... ]

> @@ -145,13 +145,13 @@ static void spacemit_crtc_atomic_disable(struct drm=
_crtc *crtc,
>  	 * must finish its status reads before dpu_pm_suspend() gates the
>  	 * clocks.
>  	 */
>  	if (a_crtc->irq_online > 0)
>  		synchronize_irq(a_crtc->irq_online);

[Severity: High]
Can synchronize_irq() safely execute here? This callback runs in an atomic
context, but synchronize_irq() blocks waiting for executing handlers.

[Severity: High]
Does this code leave a race window before the flags are updated? An interru=
pt
could fire immediately after synchronize_irq() returns but before clocks_on
is toggled to false, leading the ISR to access MMIO while dpu_pm_suspend()
is shutting down the clocks.

> =20
>  	/*
>  	 * Nothing else cancels the watchdog; it would fire against freed state.
>  	 */
>  	timer_delete_sync(&a_crtc->cfg_rdy_timer);
> =20
>  	/* Close the ISR's MMIO gate before the clocks actually stop. */
>  	a_crtc->clocks_on =3D false;
>  	dpu_pm_suspend(a_crtc->dev);

[Severity: High]
Does dpu_pm_suspend() sleep in this atomic context? It calls usleep_range()
which could trigger kernel warnings and deadlocks when reached via
spacemit_crtc_atomic_disable().

> =20
>  	spin_lock_irq(&drm->event_lock);
>  	if (crtc->state->event) {
>  		drm_crtc_send_vblank_event(crtc, crtc->state->event);
>  		crtc->state->event =3D NULL;
>  	}
>  	spin_unlock_irq(&drm->event_lock);

[Severity: High]
Is it safe to use unconditional spin_unlock_irq() here? Since this callback
executes in an atomic context (e.g. from drm_atomic_helper_commit_tail),
unconditionally re-enabling interrupts breaks the caller's atomic assumptio=
ns.
Should this use spin_lock_irqsave() and spin_unlock_irqrestore() instead?

[ ... ]

> @@ -231,6 +231,5 @@ static struct drm_crtc_state *
>  	__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
> =20
>  	n_rdma =3D hwdev->rdma_nums;
>  	state->rdmas =3D kzalloc_objs(*state->rdmas, n_rdma);
>  	if (!state->rdmas) {
>  		kfree(state);
>  		return NULL;
>  	}

[Severity: Medium]
Does this error path leak DRM property blob references?
__drm_atomic_helper_crtc_duplicate_state() increments references on blobs
like mode_blob, ctm, and gamma_lut. Returning NULL here without releasing
them could leak those references.

[ ... ]

> @@ -418,6 +418,5 @@ static irqreturn_t spacemit_dpu_isr(int irq, void *da=
ta)
>  	/* Reading a clock-gated DPU's status registers stalls the bus. */
>  	if (unlikely(!a_crtc->clocks_on)) {
>  		drm_dev_exit(idx);
>  		return IRQ_NONE;
>  	}

[Severity: High]
Does this code cause an IRQ storm? By returning IRQ_NONE without clearing
the hardware interrupt status when clocks_on is false, the interrupt
controller might continuously re-trigger the ISR if the bootloader left the
interrupt asserted.

[ ... ]

> @@ -496,6 +496,5 @@ static int spacemit_drm_master_bind(struct device *de=
v)
>  	}
> =20
>  	kms =3D devm_drm_dev_alloc(dev, &spacemit_drm_drv,
>  				 struct spacemit_kms, drm);
>  	if (IS_ERR(kms))

[Severity: High]
Will this leak the DRM device on rebind? devm_drm_dev_alloc ties the
allocation lifetime to the platform device's probe/remove cycle. If the
component unbinds and rebinds, new DRM devices are allocated but the old
ones are never freed.

[ ... ]

> @@ -573,6 +573,5 @@ static int spacemit_drm_master_bind(struct device *de=
v)
>  	drm_mode_config_reset(drm);
>  	drmm_kms_helper_poll_init(drm);
>  	drm_helper_hpd_irq_event(drm);
> =20
>  	enable_irq(priv->irq_online);

[Severity: High]
Is it safe to enable the IRQ before the hardware state is fully initialized?
If the bootloader left the display hardware active, the ISR might fire
immediately while a_crtc->clocks_on is still false, leading to the IRQ storm
mentioned above.

[ ... ]

> @@ -594,6 +594,5 @@ static void spacemit_drm_master_unbind(struct device =
*dev)
> =20
>  	disable_irq(priv->irq_online);
> =20
>  	drm_dev_unregister(drm);
>  	drm_atomic_helper_shutdown(drm);
>  	component_unbind_all(dev, drm);

[Severity: High]
Will calling drm_atomic_helper_shutdown() hang if the IRQ is already
disabled? The shutdown helper flushes pending atomic commits and disables
CRTCs, which requires the hardware vblank interrupt to signal completion.
Without it, the commit wait could time out.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_planes.c b/drivers/gpu/drm=
/spacemit/spacemit_planes.c
> new file mode 100644
> index 0000000000000..3442013b0c37f
> --- /dev/null
> +++ b/drivers/gpu/drm/spacemit/spacemit_planes.c

[ ... ]

> @@ -98,6 +98,5 @@ static int spacemit_plane_atomic_check(struct drm_plane=
 *plane,
>  	if (src_w =3D=3D 0 && src_h =3D=3D 0)
>  		cur_rdma_id =3D RDMA_INVALID_ID;	/* constant-fill layer, no RDMA */
>  	else if (cur_rdma_id =3D=3D RDMA_INVALID_ID)
>  		cur_rdma_id =3D state->zpos;	/* first commit: bind channel by zpos */
>  	cur_state->rdma_id =3D cur_rdma_id;

[Severity: High]
Does this code assign RDMA channels based on unvalidated zpos? Userspace
could submit a configuration with duplicate zpos values across multiple
planes, resulting in channel collisions where planes overwrite each other's
hardware registers during spacemit_plane_atomic_update().

[ ... ]

> @@ -193,7 +193,6 @@ static void spacemit_plane_reset(struct drm_plane *pl=
ane)
>  	if (plane->state) {
>  		s =3D to_spacemit_plane_state(plane->state);
>  		__drm_atomic_helper_plane_destroy_state(plane->state);
>  		kfree(s);
>  		plane->state =3D NULL;
>  	}

[Severity: High]
Does freeing the state directly bypass the driver's custom destructor?
Calling kfree(s) directly in spacemit_plane_reset() skips
spacemit_plane_atomic_destroy_state(), which means the DMA coherent buffers
for mmu_tbl.va and cl.va could be permanently leaked when a plane is reset.

[ ... ]

> @@ -211,6 +211,5 @@ static struct drm_plane_state *
>  spacemit_plane_atomic_duplicate_state(struct drm_plane *plane)
>  {
>  	struct spacemit_plane_state *s;
>  	struct spacemit_plane_state *old_state =3D
>  			to_spacemit_plane_state(plane->state);
>  	struct spacemit_crtc *a_crtc =3D NULL;

[Severity: Medium]
Will this crash if plane->state is NULL? The to_spacemit_plane_state()
macro uses container_of, which will produce a negative pointer if
plane->state is NULL. Dereferencing old_state->rdma_id later would trigger
a fault.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260725-k3-display=
-v1-0-6de34d80e86c@gmail.com?part=3D10
