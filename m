Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 525ACC531C9
	for <dri-devel@archiver.kernel.org>; Sat, 25 Jul 2026 05:18:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA51810F510;
	Sat, 25 Jul 2026 05:18:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="cpQGxhpK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7AC5110F50F
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Jul 2026 05:18:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3460A44098;
 Sat, 25 Jul 2026 05:18:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6C041F000E9;
 Sat, 25 Jul 2026 05:18:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784956690;
 bh=FGTOwC9l0p3K39rI4nwYUnhRdmfc8VuDMzntBdqs1BA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=cpQGxhpKZsAKU/iPBxxJS3gqNQU6LnkiR3SQklpgZm1crcAMJoop2FHYgzVGWLNHn
 l6/RoeZ0r/EuSS4WvVURetDv68dsBlTKz0MFihslUqQB0POWr0W+rZ0I3QE1ZpVLdY
 j2sc5J9yymoVjlksSdsfYsKAP89DKnt4xbNcDBImbE6CnjuFdyqFxxTahmL1e6Cs13
 nukD2ZxyvM52VIaTQMZo54iytqcWBc1glXwt/ft1F8/c9sbFUXSZMLXoDABHxv+mCb
 HhrNVLsQJRxCo6zwOGJFGX/4yZi+Vo2lgOP1K9HW0RzsuYdnElHecXOHw1La5oGZ8r
 FnbuSkYRvwHlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 10/17] drm/spacemit: add Saturn DPU KMS pipeline
To: "Cody Kang" <codykang.hk@gmail.com>
Cc: olteanv@gmail.com, neil.armstrong@linaro.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org, vkoul@kernel.org,
 linux-phy@lists.infradead.org, devicetree@vger.kernel.org
In-Reply-To: <20260724-k3-display-v1-10-f22a10a52867@gmail.com>
References: <20260724-k3-display-v1-0-f22a10a52867@gmail.com>
 <20260724-k3-display-v1-10-f22a10a52867@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 25 Jul 2026 05:18:09 +0000
Message-Id: <20260725051809.B6C041F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 13 potential issue=
(s) to consider:
- [Critical] Ignored return value of `get_cl_rdma_buf()` in `spacemit_plane=
_atomic_update` leads to Use-After-Free and Double-Free.
- [High] Sleeping functions called from CRTC atomic commit callbacks (`atom=
ic_enable` / `atomic_disable`), violating atomic context requirements.
- [High] `spacemit_plane_reset` open-codes state destruction, permanently l=
eaking the plane's DMA allocations.
- [High] Dynamic memory allocation occurs in the `atomic_update` fast path.
- [High] Enabling the DPU IRQ before hardware reset causes an interrupt sto=
rm.
- [High] TOCTOU race condition in `spacemit_crtc_atomic_disable` allows MMI=
O access while clocks are gated.
- [High] Unbounded DMA allocations in `atomic_check` lead to memory leaks o=
n retries and unprivileged Denial of Service.
- [High] Incorrect teardown order in `spacemit_drm_master_unbind` causes VB=
LANK timeouts.
- [High] DRM ioctls can access freed `priv` and `hwdev` after driver unbind=
 due to missing unplug state.
- [Medium] TOCTOU race setting `a_crtc->clocks_on =3D true` before the hard=
ware clocks are actually resumed.
- [Medium] Unbounded accumulation of `use_cnt` in `saturn_count_rdma_use`.
- [Medium] `spacemit_crtc_duplicate_state` leaks DRM property blobs on erro=
r path.
- [Medium] Hardware resets are deasserted before clocks are enabled during =
PM resume.
--

--- Patch [10]: [PATCH 10/17] drm/spacemit: add Saturn DPU KMS pipeline ---
commit f6c949f848ca8fa43777ef224d0be429d2966ff6
Author: Cody Kang <codykang.hk@gmail.com>

drm/spacemit: add Saturn DPU KMS pipeline

Add the atomic KMS implementation on top of the hardware backend: one
CRTC and one primary plane per DPU instance. atomic_check validates
the plane rectangle 1:1 against the mode and sizes the per-channel FBC
line buffer; atomic commit builds the cmdlist batches, maps the
framebuffer through the DMMU and arms the cfg-ready handshake, with
vblank events driven from the DPU interrupt.

> diff --git a/drivers/gpu/drm/spacemit/spacemit_crtc.c b/drivers/gpu/drm/s=
pacemit/spacemit_crtc.c
> --- a/drivers/gpu/drm/spacemit/spacemit_crtc.c
> +++ b/drivers/gpu/drm/spacemit/spacemit_crtc.c
> @@ -43,18 +43,15 @@
>  static void saturn_count_rdma_use(struct drm_crtc_state *crtc_state)
>  {
>  	struct drm_plane *plane;
>  	struct spacemit_crtc_state *spacemit_state =3D
>  			to_spacemit_crtc_state(crtc_state);
>  	struct spacemit_crtc_rdma *rdmas =3D spacemit_state->rdmas;
>  	u32 rdma_id =3D 0;
>  	const struct drm_plane_state *pstate;
> =20
>  	drm_atomic_crtc_state_for_each_plane_state(plane, pstate, crtc_state) {
>  		rdma_id =3D to_spacemit_plane_state(pstate)->rdma_id;
>  		if (rdma_id !=3D RDMA_INVALID_ID)
>  			rdmas[rdma_id].use_cnt++;

[Severity: Medium]
Will this counter accumulate values incorrectly if atomic_check is called
multiple times on the same CRTC state? If the DRM core retries the commit d=
ue
to -EDEADLK backoff, it seems the counter might increment repeatedly since =
it
is not cleared first.

>  	}
>  }
> =20
[ ... ]
> @@ -95,21 +92,20 @@
>  static void spacemit_crtc_atomic_enable(struct drm_crtc *crtc,
>  					struct drm_atomic_commit *old_state)
>  {
>  	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
>  	int idx;
> =20
>  	if (!drm_dev_enter(crtc->dev, &idx))
>  		return;
> =20
>  	trace_spacemit_crtc_atomic_enable(a_crtc->dev_id);
> =20
>  	/*
>  	 * U-Boot leaves its boot-logo pipeline running. Hard-stop it with the
>  	 * resets alone; the clocks are not ours to gate until we have enabled
>  	 * them.
>  	 */
>  	if (unlikely(a_crtc->first_modeset)) {
>  		dpu_reset_assert(a_crtc->dev, "lcd", a_crtc->lcd_reset);
>  		dpu_reset_assert(a_crtc->dev, "esc", a_crtc->esc_reset);
>  		dpu_reset_assert(a_crtc->dev, "mclk", a_crtc->mclk_reset);
>  		dpu_reset_assert(a_crtc->dev, "aclk", a_crtc->aclk_reset);
>  		dpu_reset_assert(a_crtc->dev, "dsc", a_crtc->dsc_reset);
>  		usleep_range(10000, 20000);

[Severity: High]
Is it safe to call usleep_range() here? CRTC atomic enable callbacks are
invoked in atomic context during non-blocking commits, where sleeping funct=
ions
are strictly forbidden and can cause kernel panics or system instability.

>  		a_crtc->first_modeset =3D false;
>  	}
> =20
>  	if (!a_crtc->clocks_on) {
>  		a_crtc->clocks_on =3D true;
>  		dpu_pm_resume(a_crtc->dev);

[Severity: Medium]
Does setting a_crtc->clocks_on to true before the hardware clocks are actua=
lly
resumed in dpu_pm_resume() introduce a TOCTOU race? If a spurious or pending
interrupt fires in this window, the ISR might read MMIO registers before the
clocks are fully resumed, which could lead to a bus stall.

> =20
>  		/*
>  		 * The DPU must settle after reset deassert or CFG_RDY races
>  		 * the flush.
>  		 */
>  		usleep_range(10000, 20000);
>  	}
> =20
[ ... ]
> @@ -124,31 +120,29 @@
>  static void spacemit_crtc_atomic_disable(struct drm_crtc *crtc,
>  					 struct drm_atomic_commit *old_state)
>  {
>  	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
>  	struct drm_device *drm =3D a_crtc->crtc.dev;
>  	int idx;
> =20
>  	if (!drm_dev_enter(drm, &idx))
>  		return;
> =20
>  	trace_spacemit_crtc_atomic_disable(a_crtc->dev_id);
> =20
>  	spacemit_crtc_uninit(a_crtc);
> =20
>  	drm_crtc_vblank_off(&a_crtc->crtc);
> =20
>  	/*
>  	 * MMIO on a clock-gated DPU stalls the bus, so an in-flight handler
>  	 * must finish its status reads before dpu_pm_suspend() gates the
>  	 * clocks.
>  	 */
>  	if (a_crtc->irq_online > 0)
>  		synchronize_irq(a_crtc->irq_online);
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
Are there calls to multiple blocking and sleeping functions within this ato=
mic
disable path? Functions like synchronize_irq(), timer_delete_sync(), and any
potential sleeping inside dpu_pm_suspend() violate atomic context requireme=
nts.

[Severity: High]
Could setting a_crtc->clocks_on =3D false after calling synchronize_irq() c=
reate
a TOCTOU race window? A new interrupt could fire immediately after
synchronize_irq() returns, and the new ISR instance would see clocks_on as
true and access MMIO concurrently while dpu_pm_suspend() gates the clocks,
potentially hanging the bus.

> =20
>  	spin_lock_irq(&drm->event_lock);
>  	if (crtc->state->event) {
>  		drm_crtc_send_vblank_event(crtc, crtc->state->event);
>  		crtc->state->event =3D NULL;
[ ... ]
> @@ -171,15 +165,14 @@
>  static int spacemit_crtc_atomic_check(struct drm_crtc *crtc,
>  				      struct drm_atomic_commit *atomic_state)
>  {
>  	struct drm_crtc_state *state =3D
>  			drm_atomic_get_new_crtc_state(atomic_state, crtc);
>  	struct spacemit_crtc_state *cstate =3D to_spacemit_crtc_state(state);
>  	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(crtc);
>  	int ret =3D 0;
> =20
>  	trace_spacemit_crtc_atomic_check(a_crtc->dev_id);
> =20
>  	ret =3D spacemit_crtc_atomic_check_fbmem(crtc, state);
>  	if (ret) {
>  		drm_dbg_kms(crtc->dev,
>  			    "failed to satisfy fbcmem size for all rdmas\n");
>  		return ret;
>  	}
> =20
>  	saturn_count_rdma_use(state);
> =20
>  	ret =3D spacemit_cmdlist_alloc(a_crtc->dev, &cstate->cl);
>  	if (ret)
>  		return ret;

[Severity: High]
Is it possible for this DMA allocation in atomic_check() to cause memory le=
aks?
If the DRM core retries the commit (for example, due to -EDEADLK backoff),
atomic_check() is called again on the same state. This would overwrite the
pointer and permanently leak the previous allocation, allowing unprivileged
userspace to trigger a denial of service via TEST_ONLY commits.

> =20
>  	return 0;
>  }
> =20
[ ... ]
> @@ -211,21 +204,18 @@
>  static struct drm_crtc_state *
>  spacemit_crtc_duplicate_state(struct drm_crtc *crtc)
>  {
>  	struct spacemit_crtc_state *state;
>  	struct spacemit_drm_private *priv =3D crtc->dev->dev_private;
>  	struct spacemit_hw_device *hwdev =3D priv->hwdev;
>  	u8 n_rdma;
> =20
>  	if (WARN_ON(!crtc->state))
>  		return NULL;
> =20
>  	state =3D kzalloc_obj(*state);
>  	if (!state)
>  		return NULL;
> =20
>  	__drm_atomic_helper_crtc_duplicate_state(crtc, &state->base);
> =20
>  	n_rdma =3D hwdev->rdma_nums;
>  	state->rdmas =3D kzalloc_objs(*state->rdmas, n_rdma);
>  	if (!state->rdmas) {
>  		kfree(state);
>  		return NULL;
>  	}

[Severity: Medium]
Will this error path leak DRM property blob references? The call to
__drm_atomic_helper_crtc_duplicate_state() increments blob refcounts, but if
kzalloc_objs() fails, kfree(state) is called without dropping those blob
references via __drm_atomic_helper_crtc_destroy_state().

> =20
>  	state->cl.type =3D CMDLIST_CRTC;
> =20
>  	return &state->base;
>  }
[ ... ]
> @@ -481,26 +471,21 @@
>  static int spacemit_drm_master_bind(struct device *dev)
>  {
>  	struct spacemit_drm_private *priv =3D dev_get_drvdata(dev);
>  	struct device_node *np =3D dev->of_node;
>  	struct device_node *ports =3D NULL, *port =3D NULL;
>  	struct spacemit_crtc *a_crtc;
>  	struct drm_plane *plane;
>  	struct spacemit_kms *kms;
>  	struct drm_device *drm;
>  	int ret;
> =20
>  	ret =3D aperture_remove_all_conflicting_devices(spacemit_drm_drv.name);
>  	if (ret) {
>  		dev_err(dev, "failed to remove existing framebuffers: %d\n",
>  			ret);
>  		return ret;
>  	}
> =20
>  	kms =3D devm_drm_dev_alloc(dev, &spacemit_drm_drv,
>  				 struct spacemit_kms, drm);
>  	if (IS_ERR(kms))
>  		return PTR_ERR(kms);
>  	drm =3D &kms->drm;
>  	priv->ddev =3D drm;
>  	drm->dev_private =3D priv;
> =20
>  	ret =3D spacemit_drm_mode_config_init(drm);
>  	if (ret)
>  		return ret;
> =20
>  	a_crtc =3D drmm_kzalloc(drm, sizeof(*a_crtc), GFP_KERNEL);
>  	if (!a_crtc) {
>  		ret =3D -ENOMEM;
>  		goto err_dc;
>  	}
>  	a_crtc->dev =3D dev;
>  	a_crtc->first_modeset =3D true;
>  	priv->a_crtc =3D a_crtc;
> =20
>  	a_crtc->clk_ctx =3D priv->clk_ctx;
>  	a_crtc->aclk =3D DPU_AXICLK_DEFAULT;
>  	a_crtc->mclk_reset =3D priv->mclk_reset;
>  	a_crtc->esc_reset =3D priv->esc_reset;
>  	a_crtc->lcd_reset =3D priv->lcd_reset;
>  	a_crtc->aclk_reset =3D priv->aclk_reset;
>  	a_crtc->dsc_reset =3D priv->dsc_reset;
>  	a_crtc->irq_online =3D priv->irq_online;
> =20
>  	/* Both K3 DPU instances are COMPOSER1 in the Saturn IRQ tables. */
>  	a_crtc->dev_id =3D COMPOSER1;
> =20
>  	/* The K3 pipeline always hands RGB888 to the DP/eDP encoder. */
>  	a_crtc->out_format =3D OUTFMT_RGB888;
> =20
>  	a_crtc->core =3D &dpu_saturn_ops;
> =20
>  	timer_setup(&a_crtc->cfg_rdy_timer, spacemit_cfg_rdy_timer_handler, 0);
> =20
>  	plane =3D spacemit_plane_init(drm, a_crtc);
>  	if (IS_ERR(plane)) {
>  		ret =3D PTR_ERR(plane);
>  		goto err_dc;
>  	}
> =20
>  	ports =3D of_get_child_by_name(np, "ports");
>  	if (!ports) {
>  		dev_err(dev, "CRTC %pOF has no ports node\n", np);
>  		ret =3D -EINVAL;
>  		goto err_dc;
>  	}
> =20
>  	port =3D of_get_child_by_name(ports, "port");
>  	if (!port) {
>  		dev_err(dev, "CRTC %pOF has no port@X node\n", np);
>  		ret =3D -EINVAL;
>  		goto err_ports_put;
>  	}
> =20
>  	ret =3D spacemit_crtc_bind_init(drm, &a_crtc->crtc, plane, port);
>  	of_node_put(port);
>  	of_node_put(ports);
>  	port =3D NULL;
>  	ports =3D NULL;
>  	if (ret)
>  		goto err_dc;
> =20
>  	/*
>  	 * component_bind_all() unbinds what it bound before returning an error.
>  	 */
>  	ret =3D component_bind_all(dev, drm);
>  	if (ret) {
>  		dev_err(dev, "failed to bind all components\n");
>  		goto err_dc;
>  	}
> =20
>  	ret =3D drm_vblank_init(drm, drm->mode_config.num_crtc);
>  	if (ret) {
>  		dev_err(dev, "failed to initialize vblank\n");
>  		goto err_unbind_all;
>  	}
> =20
>  	drm_mode_config_reset(drm);
>  	drmm_kms_helper_poll_init(drm);
>  	drm_helper_hpd_irq_event(drm);
> =20
>  	enable_irq(priv->irq_online);

[Severity: High]
Does unmasking the OS IRQ here before the hardware state is prepared cause =
an
interrupt storm? If the bootloader left the display pipeline active, an
interrupt fires immediately. The ISR in spacemit_dpu_isr() will see
clocks_on =3D=3D false and bail out with IRQ_NONE without acknowledging the
interrupt, forcing the kernel to permanently disable the IRQ line.

> =20
>  	ret =3D drm_dev_register(drm, 0);
>  	if (ret < 0)
>  		goto err_disable_irq;
>  	drm_client_setup(drm, NULL);
> =20
>  	return 0;
[ ... ]
> @@ -591,16 +576,14 @@
>  static void spacemit_drm_master_unbind(struct device *dev)
>  {
>  	struct spacemit_drm_private *priv =3D dev_get_drvdata(dev);
>  	struct drm_device *drm =3D priv->ddev;
> =20
>  	disable_irq(priv->irq_online);
> =20
>  	drm_dev_unregister(drm);
>  	drm_atomic_helper_shutdown(drm);

[Severity: High]
Is the teardown order correct here? Calling disable_irq() before
drm_atomic_helper_shutdown() can cause multi-second stalls, as the shutdown
process issues a full modeset to disable CRTCs and waits for vblank interru=
pts
that will never arrive since the IRQ is disabled.

[Severity: High]
Could calling drm_dev_unregister() without setting the unplugged state via
drm_dev_unplug() leave ioctl entry paths open while devm resources are free=
d?
If userspace holds an open DRM file descriptor, ioctls can still execute
because drm_dev_enter() will succeed, leading to a Use-After-Free when they
dereference the freed priv pointer.

>  	component_unbind_all(dev, drm);
> =20
>  	/* .shutdown and a later re-bind must not touch the stale instance. */
>  	priv->ddev =3D NULL;
>  	priv->a_crtc =3D NULL;
>  }
[ ... ]
> @@ -747,21 +730,17 @@
>  static int dpu_pm_resume(struct device *dev)
>  {
>  	struct spacemit_drm_private *priv =3D dev_get_drvdata(dev);
>  	struct spacemit_crtc *a_crtc =3D priv->a_crtc;
> =20
>  	dpu_reset_deassert(dev, "mclk", a_crtc->mclk_reset);
>  	dpu_reset_deassert(dev, "esc", a_crtc->esc_reset);
>  	dpu_reset_deassert(dev, "lcd", a_crtc->lcd_reset);
>  	dpu_reset_deassert(dev, "aclk", a_crtc->aclk_reset);
>  	dpu_reset_deassert(dev, "dsc", a_crtc->dsc_reset);
> =20
>  	if (a_crtc->core && a_crtc->core->enable_clk)
>  		a_crtc->core->enable_clk(a_crtc);

[Severity: Medium]
Are hardware resets being deasserted before clocks are enabled? Reset edges
cannot propagate through gated hardware blocks, so the clocks should likely=
 be
enabled before deasserting resets to ensure a clean initialization and avoid
hardware state machine violations.

> =20
>  	return 0;
>  }
> =20
>  static const struct of_device_id dpu_match_table[] =3D {
>  	{
>  		.compatible =3D "spacemit,k3-saturn-dpu",
>  		.data =3D &k3_saturn_dpu,
>  	},
>  	{},
>  };
>  MODULE_DEVICE_TABLE(of, dpu_match_table);
> =20
>  static struct platform_driver spacemit_dpu_driver =3D {
>  	.probe =3D spacemit_dpu_probe,
>  	.remove =3D spacemit_dpu_remove,
>  	.shutdown =3D spacemit_dpu_shutdown,
>  	.driver =3D {
>  		.name =3D "spacemit-dpu-drv",
>  		.of_match_table =3D dpu_match_table,
>  		.suppress_bind_attrs =3D true,
>  	},
>  };
>  module_platform_driver(spacemit_dpu_driver);
> =20
>  MODULE_DESCRIPTION("SpacemiT DRM KMS master driver");
>  MODULE_LICENSE("GPL");
> diff --git a/drivers/gpu/drm/spacemit/spacemit_planes.c b/drivers/gpu/drm=
/spacemit/spacemit_planes.c
> --- a/drivers/gpu/drm/spacemit/spacemit_planes.c
> +++ b/drivers/gpu/drm/spacemit/spacemit_planes.c
> @@ -107,31 +104,27 @@
>  static int spacemit_plane_atomic_check(struct drm_plane *plane,
>  				       struct drm_atomic_commit *atomic_state)
>  {
>  	struct drm_plane_state *state =3D
>  			drm_atomic_get_new_plane_state(atomic_state, plane);
>  	struct drm_framebuffer *fb =3D state->fb;
>  	u32 src_w, src_h, src_x, src_y;
>  	u32 crtc_w, crtc_h;
>  	struct spacemit_plane_state *cur_state =3D to_spacemit_plane_state(stat=
e);
>  	u32 cur_rdma_id =3D cur_state->rdma_id;
>  	struct spacemit_drm_private *priv =3D plane->dev->dev_private;
>  	struct spacemit_hw_device *hwdev =3D priv->hwdev;
>  	struct spacemit_crtc *a_crtc =3D NULL;
> =20
>  	struct drm_crtc_state *crtc_state =3D NULL;
>  	int ret;
> =20
>  	if (state->crtc)
>  		crtc_state =3D drm_atomic_get_new_crtc_state(atomic_state,
>  							   state->crtc);
> =20
>  	ret =3D drm_atomic_helper_check_plane_state(state, crtc_state,
>  						  DRM_PLANE_NO_SCALING,
>  						  DRM_PLANE_NO_SCALING,
>  						  true, false);
>  	if (ret)
>  		return ret;
> =20
>  	if (!state->visible)
>  		return 0;
> =20
>  	a_crtc =3D to_spacemit_crtc(state->crtc);
>  	trace_spacemit_plane_atomic_check(a_crtc->dev_id);
> =20
>  	src_x =3D state->src_x >> 16;
>  	src_y =3D state->src_y >> 16;
>  	src_w =3D state->src_w >> 16;
>  	src_h =3D state->src_h >> 16;
>  	crtc_w =3D state->crtc_w;
>  	crtc_h =3D state->crtc_h;
> =20
>  	/* The programming paths use the raw rectangles, so refuse to clip. */
>  	if ((state->src.x1 >> 16) !=3D src_x || (state->src.y1 >> 16) !=3D src_=
y ||
>  	    (drm_rect_width(&state->src) >> 16) !=3D src_w ||
>  	    (drm_rect_height(&state->src) >> 16) !=3D src_h ||
>  	    state->dst.x1 !=3D state->crtc_x || state->dst.y1 !=3D state->crtc_=
y ||
>  	    drm_rect_width(&state->dst) !=3D crtc_w ||
>  	    drm_rect_height(&state->dst) !=3D crtc_h) {
>  		drm_dbg_kms(plane->dev,
>  			    "clipped plane rectangles not supported\n");
>  		return -EINVAL;
>  	}
> =20
>  	/* One-dimensional sources are invalid (only 0x0 =3D constant fill) */
>  	if ((src_w =3D=3D 0) !=3D (src_h =3D=3D 0)) {
>  		drm_dbg_kms(plane->dev, "unsupported src_w %d src_h %d\n",
>  			    src_w, src_h);
>  		return -EINVAL;
>  	}
> =20
>  	if (src_w =3D=3D 0 && src_h =3D=3D 0)
>  		cur_rdma_id =3D RDMA_INVALID_ID;	/* constant-fill layer, no RDMA */
>  	else if (cur_rdma_id =3D=3D RDMA_INVALID_ID)
>  		cur_rdma_id =3D state->zpos;	/* first commit: bind channel by zpos */
>  	cur_state->rdma_id =3D cur_rdma_id;
> =20
>  	if (cur_rdma_id !=3D RDMA_INVALID_ID) {
>  		if (cur_rdma_id >=3D hwdev->rdma_nums) {
>  			drm_dbg_kms(plane->dev, "invalid rdma id %d\n",
>  				    cur_rdma_id);
>  			return -EINVAL;
>  		}
> =20
>  		if (a_crtc->core->cal_layer_fbcmem_size(plane, state)) {
>  			drm_dbg_kms(plane->dev,
>  				    "plane %d: invalid fbcmem size\n",
>  				    state->zpos);
>  			return -EINVAL;
>  		}
> =20
>  		cur_state->mmu_tbl.size =3D
>  			((PAGE_ALIGN(fb->obj[0]->size) >> PAGE_SHIFT) +
>  			 HW_ALIGN_TTB_NUM) * 4;
>  		cur_state->mmu_tbl.va =3D
>  			dma_alloc_coherent(a_crtc->dev, cur_state->mmu_tbl.size,
>  					   &cur_state->mmu_tbl.pa,
>  					   GFP_KERNEL | __GFP_ZERO);
>  		if (!cur_state->mmu_tbl.va)
>  			return -ENOMEM;

[Severity: High]
Does allocating DMA memory directly into the state here in atomic_check()
cause memory leaks on retries? Just like with spacemit_cmdlist_alloc(), if =
the
commit is retried due to -EDEADLK backoff, this will overwrite the pointer =
and
permanently leak the previous allocation.

>  	}
> =20
>  	/*
>  	 * The commit cannot fail, so take the DMA buffer while -ENOMEM is an
>  	 * answer.
>  	 */
>  	ret =3D spacemit_cmdlist_alloc(a_crtc->dev, &cur_state->cl);
>  	if (ret)
>  		return ret;
> =20
>  	cur_state->format =3D spacemit_plane_hw_get_format_id(fb->format->forma=
t);
>  	if (cur_state->format =3D=3D SPACEMIT_DPU_INVALID_FORMAT_ID) {
>  		drm_dbg_kms(plane->dev, "unsupported format %p4cc\n",
>  			    &fb->format->format);
>  		return -EINVAL;
>  	}
> =20
>  	return 0;
>  }
> =20
>  static void spacemit_plane_atomic_update(struct drm_plane *plane,
>  					 struct drm_atomic_commit *state)
>  {
>  	int ret =3D 0;
>  	struct spacemit_crtc *a_crtc =3D to_spacemit_crtc(plane->state->crtc);
>  	struct spacemit_plane_state *spacemit_pstate =3D
>  			to_spacemit_plane_state(plane->state);
>  	struct spacemit_drm_private *priv =3D plane->dev->dev_private;
>  	struct spacemit_hw_device *hwdev =3D priv->hwdev;
>  	u32 rdma_id =3D spacemit_pstate->rdma_id;
>  	struct cmdlist *cl =3D NULL;
>  	int idx;
> =20
>  	if (!drm_dev_enter(plane->dev, &idx))
>  		return;
> =20
>  	trace_spacemit_plane_atomic_update(a_crtc->dev_id);
> =20
>  	hwdev->get_cl_rdma_buf(a_crtc);

[Severity: High]
Is it safe to perform dynamic memory allocation in the atomic_update fast p=
ath?
The DRM atomic update phase is forbidden to fail or sleep. Any temporary me=
mory
should be pre-allocated in atomic_check() or prepare_fb().

[Severity: Critical]
Does ignoring the return value of get_cl_rdma_buf() lead to a Use-After-Free
or Double-Free? If it fails, a_crtc->cl_rdma retains its previous value. Wh=
en
free_cmdlist_regs(a_crtc->cl_rdma) is called later, it frees the memory but
does not set the pointer to NULL, making a_crtc->cl_rdma a dangling pointer=
 on
subsequent failures.

> =20
>  	hwdev->plane_update_hw_channel(plane);
> =20
>  	/* Solid-fill layers have no RDMA and no page table */
>  	if (rdma_id < hwdev->rdma_nums && spacemit_pstate->mmu_tbl.va) {
>  		u8 tbu_id =3D rdma_id * 2;
> =20
>  		ret =3D spacemit_dmmu_map(plane->state->fb,
>  					&spacemit_pstate->mmu_tbl, tbu_id,
>  					a_crtc->cl_rdma, plane);
>  		if (!ret)
>  			cmdlist_regs_packing(plane_to_cl(plane),
>  					     CMDLIST_MOD_RDMA, a_crtc->cl_rdma);
>  		else
>  			drm_err(plane->dev, "failed to map plane: %d\n", ret);
>  	}
> =20
>  	cl =3D &spacemit_pstate->cl;
>  	cl->rch_start_cmps_y =3D CMDLIST_SENTINEL_POISON;
>  	cl->cmdlist_ch_y_other =3D CMDLIST_SENTINEL_POISON;
>  	free_cmdlist_regs(a_crtc->cl_rdma);

[Severity: Critical]
Does this free_cmdlist_regs() call leave a_crtc->cl_rdma as a dangling poin=
ter?
As mentioned above, since the pointer is not cleared after being freed, a
subsequent allocation failure will leave the pointer pointing to freed memo=
ry.

> =20
>  	drm_dev_exit(idx);
>  }
> =20
[ ... ]
> @@ -201,15 +190,14 @@
>  static void spacemit_plane_reset(struct drm_plane *plane)
>  {
>  	struct spacemit_plane_state *s;
> =20
>  	if (plane->state) {
>  		s =3D to_spacemit_plane_state(plane->state);
>  		__drm_atomic_helper_plane_destroy_state(plane->state);
>  		kfree(s);
>  		plane->state =3D NULL;
>  	}

[Severity: High]
Should this cleanup logic utilize the driver-specific custom cleanup hook? =
By
open-coding the state destruction and calling kfree(s) directly, it bypasses
spacemit_plane_atomic_destroy_state(). This permanently leaks the plane's D=
MA
allocations (mmu_tbl.va and cl.va) when spacemit_plane_reset() executes on a
plane that already has a state.

> =20
>  	s =3D kzalloc(sizeof(*s), GFP_KERNEL);
>  	if (s) {
>  		__drm_atomic_helper_plane_reset(plane, &s->state);
>  		s->rdma_id =3D RDMA_INVALID_ID;
>  	}
>  }
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260724-k3-display=
-v1-0-f22a10a52867@gmail.com?part=3D10
