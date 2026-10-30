Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA97606A335
	for <dri-devel@archiver.kernel.org>; Fri, 30 Oct 2026 10:29:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=oY42Bi6i
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C73611272B;
	Fri, 30 Oct 2026 10:29:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 952BB11272D
 for <dri-devel@lists.freedesktop.org>; Fri, 30 Oct 2026 10:29:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3994A4146F;
 Fri, 30 Oct 2026 10:29:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BF5901F0093A;
 Fri, 30 Oct 2026 10:29:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793356155;
 bh=BVGHjPJ+QP90C95E0s0SV2PtJx4OgisS4n17VUm85AI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=oY42Bi6iz9/WK7017bHxdxt5TssdnEq4yE6nqECpMbkWSrBgtnxZU7OtBOm6Mg89T
 6AfpuoQdv6e/BMv/qkFfVxL9LA/MxfhXdQYO7JgGSE3Qyrv6H12uyrofWfogkxsWWI
 /VGKf6UW6lqAHJ9INGMP9KV+EKJhZxkEgxSSRA3Pcc5pCs0BpTvMHHiS1Ra1SWPHLZ
 J1H/Pu3c5U7QTtkggljGCi1JyycEUCfxYHC8y84cLcnN1iTg/vKoIx2M1qIglQF+o+
 X7T1SR3a3xa329IkbE1zuryj7yUM3Kviz23ikUVs37X1fu7sARQ+HBue4SH63Wk50A
 PH/z3NVhHXJpg==
Message-ID: <sashiko-outbox-190828@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v8 15/15] drm/imx: dc: Use prefetch engine
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261030-imx8-dc-prefetch-v8-15-c4f81afd4533@nxp.com>
References: <20261030-imx8-dc-prefetch-v8-0-c4f81afd4533@nxp.com>
 <20261030-imx8-dc-prefetch-v8-15-c4f81afd4533@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 30 Oct 2026 10:29:14 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/imx: dc: missing plane visibility check in dc_crtc_atomic_disa=
ble()
- [High] drm/imx: dc: dc_plane_atomic_update() starts DPRC on inactive CRTC
- [High] drm/imx: dc: deadlock and atomic sleep in dc_dprc_disable_repeat_e=
n()
- [Medium] drm/imx: dc: premature source checks in dc_crtc_disable_at_boot()
--

commit 4fa9cf8e39f1e67c71f284dcbe5efb2eaf9658a7
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Use prefetch engine

This commit configures and disables prefetch engines (DPRC and PRG) along
with FetchUnits during atomic commits and boot disablement. It also adds
burst size and stride fixups in the FetchUnit driver and sets
use_raw_spinlock in the ExtDst PIXENGCFG regmap configuration.

> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc=
-crtc.c
> index d03246036d4a7..9d8fbcef79fe4 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
> @@ -25,6 +25,7 @@
>  #include <drm/drm_vblank.h>
> =20
>  #include "dc-de.h"
> +#include "dc-dprc.h"
>  #include "dc-drv.h"
>  #include "dc-kms.h"
>  #include "dc-pe.h"
> @@ -204,7 +205,14 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct d=
rm_atomic_commit *state)
>  				drm_atomic_get_old_crtc_state(state, crtc);
>  	struct drm_crtc_state *new_crtc_state =3D
>  				drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_plane_state *old_plane_state =3D
> +			drm_atomic_get_old_plane_state(state, crtc->primary);
> +	struct drm_plane_state *new_plane_state =3D
> +			drm_atomic_get_new_plane_state(state, crtc->primary);
> +	struct dc_plane *dc_plane =3D to_dc_plane(crtc->primary);
>  	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> +	bool plane_becoming_invisible =3D false;
> +	bool disabling_visible_plane =3D false;
>  	int idx;
> =20
>  	if (drm_atomic_crtc_needs_modeset(new_crtc_state) ||
> @@ -216,13 +224,48 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct =
drm_atomic_commit *state)
> =20
>  	enable_irq(dc_crtc->irq_ed_cont_shdload);
> =20
> -	/* flush plane update out to display */
> -	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
> +	if (old_plane_state && new_plane_state) {
> +		disabling_visible_plane =3D old_plane_state->visible &&
> +					  drm_atomic_plane_disabling(old_plane_state,
> +								     new_plane_state);
> +
> +		plane_becoming_invisible =3D old_plane_state->fb &&
> +					   new_plane_state->fb &&
> +					   old_plane_state->visible &&
> +					   !new_plane_state->visible;
> +	}
> +
> +	if (disabling_visible_plane || plane_becoming_invisible) {
> +		unsigned long flags;
> +
> +		dc_crtc_dbg(crtc, "disabling FetchUnit along with DPRC\n");
> +
> +		/*
> +		 * Don't relinquish CPU until DPRC REPEAT_EN is disabled and
> +		 * sync is triggered.
> +		 */
> +		local_irq_save(flags);
> +		preempt_disable();
> +
> +		DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
> +		dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
> +		/* flush plane update out to display */
> +		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
> +
> +		local_irq_restore(flags);
> +		preempt_enable();

[ ... ]

> @@ -323,14 +366,33 @@ dc_crtc_atomic_enable(struct drm_crtc *crtc, struct=
 drm_atomic_commit *state)
>  	dc_crtc_queue_state_event(new_crtc_state);
>  }
> =20
> -static inline void __dc_crtc_disable_fg(struct drm_crtc *crtc)
> +static inline void
> +dc_crtc_disable_fg_along_with_dprc_repeat_en(struct drm_crtc *crtc)
>  {
> +	struct dc_plane *dc_plane =3D to_dc_plane(crtc->primary);
>  	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> +	unsigned long flags;
> =20
> -	enable_irq(dc_crtc->irq_dec_seqcomplete);
> +	/* Don't relinquish CPU until DPRC REPEAT_EN is disabled. */
> +	local_irq_save(flags);
> +	preempt_disable();
> +
> +	/*
> +	 * Sync to FrameGen frame index moving so that
> +	 * FrameGen can be disabled in the next frame.
> +	 */
> +	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
>  	dc_fg_disable(dc_crtc->fg);
> -	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
> -	disable_irq(dc_crtc->irq_dec_seqcomplete);
> +	/*
> +	 * There is one frame leftover after FrameGen disablement.
> +	 * Sync to FrameGen frame index moving so that DPRC REPEAT_EN
> +	 * can be disabled in the next frame.
> +	 */
> +	DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(dc_crtc->fg);
> +	dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
> +
> +	local_irq_restore(flags);
> +	preempt_enable();
>  }

[Severity: High]
Can calling dc_dprc_disable_repeat_en() from dc_crtc_atomic_flush() and
dc_crtc_disable_fg_along_with_dprc_repeat_en() deadlock with the interrupt
handler or sleep in atomic context on PREEMPT_RT?

Both callers invoke dc_dprc_disable_repeat_en() with local IRQs and
preemption disabled:

    local_irq_save(flags);
    preempt_disable();
    ...
    dc_dprc_disable_repeat_en(dc_plane->fu->dprc);

Inside drivers/gpu/drm/imx/dc/dc-dprc.c, dc_dprc_disable_repeat_en() takes
dprc->lock for the entire function scope, including across
synchronize_hardirq(dprc->wrap_irq):

    void dc_dprc_disable_repeat_en(struct dc_dprc *dprc)
    {
        guard(spinlock)(&dprc->lock);
        regmap_write(dprc->reg, IRQ_MASK + SET, IRQ_DPR_CRTL_DONE);

        synchronize_hardirq(dprc->wrap_irq);

        regmap_write(dprc->reg, SYSTEM_CTRL0 + CLR, REPEAT_EN);
        dev_dbg(dprc->dev, "disable REPEAT_EN\n");
    }

Meanwhile, the interrupt handler dc_dprc_wrap_irq_handler() for
dprc->wrap_irq also acquires dprc->lock:

    scoped_guard(spinlock, &dprc->lock) {
        /* cache valid IRQ status */
        regmap_read(dprc->reg, IRQ_MASK, &mask);

If dprc->wrap_irq fires on another CPU just before
dc_dprc_disable_repeat_en() acquires dprc->lock, dc_dprc_disable_repeat_en()
will spin in synchronize_hardirq() while holding dprc->lock, waiting for
dc_dprc_wrap_irq_handler() to finish, while dc_dprc_wrap_irq_handler() spins
waiting for dprc->lock.

In addition, although this patch sets use_raw_spinlock in
dc_ed_pec_regmap_config for PREEMPT_RT, dprc->lock is a non-raw spinlock_t
(and dev_dbg() is called while interrupts and preemption are disabled). On
PREEMPT_RT, acquiring dprc->lock inside local_irq_save() and
preempt_disable() sleeps in atomic context and triggers a lockdep splat, and
devm_request_irq() without IRQF_NO_THREAD threads dc_dprc_wrap_irq_handler()
so synchronize_hardirq() will not synchronize with it.

> =20
>  static void
> @@ -338,14 +400,31 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struc=
t drm_atomic_commit *state)
>  {
>  	struct drm_crtc_state *new_crtc_state =3D
>  				drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_crtc_state *old_crtc_state =3D
> +				drm_atomic_get_old_crtc_state(state, crtc);
> +	struct drm_plane_state *old_plane_state =3D
> +			drm_atomic_get_old_plane_state(state, crtc->primary);
>  	struct dc_drm_device *dc_drm =3D to_dc_drm_device(crtc->dev);
> +	struct dc_plane *dc_plane =3D to_dc_plane(crtc->primary);
>  	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
>  	int idx;
> =20
>  	if (!drm_dev_enter(crtc->dev, &idx))
>  		goto out;
> =20
> -	__dc_crtc_disable_fg(crtc);
> +	enable_irq(dc_crtc->irq_dec_seqcomplete);
> +
> +	if (old_crtc_state->plane_mask && old_plane_state->visible)
> +		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
> +	else
> +		dc_fg_disable(dc_crtc->fg);
> +
> +	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
> +	disable_irq(dc_crtc->irq_dec_seqcomplete);
> +
> +	if (old_crtc_state->plane_mask)
> +		dc_dprc_disable(dc_plane->fu->dprc);

[Severity: High]
As reported by Sashiko on v7 [1], what happens in dc_crtc_atomic_disable()
when the primary plane is attached to the CRTC (so
old_crtc_state->plane_mask is non-zero) but positioned completely off-screen
(so old_plane_state->visible is false)?

In dc_plane_atomic_check(), drm_atomic_helper_check_plane_state() is called
with can_position set to true, allowing a plane with a valid framebuffer and
CRTC to have plane_state->visible =3D=3D false. When that happens, DPRC and=
 PRG
are either never started in dc_plane_atomic_update() or were already stopped
by dc_dprc_disable() in a previous commit's dc_crtc_atomic_flush() when
plane_becoming_invisible was true.

In dc_crtc_atomic_disable(), the first check tests both
old_crtc_state->plane_mask and old_plane_state->visible, but the second che=
ck
only tests old_crtc_state->plane_mask before calling dc_dprc_disable():

    if (old_crtc_state->plane_mask && old_plane_state->visible)
        dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
    else
        dc_fg_disable(dc_crtc->fg);

    DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
    disable_irq(dc_crtc->irq_dec_seqcomplete);

    if (old_crtc_state->plane_mask)
        dc_dprc_disable(dc_plane->fu->dprc);

Won't calling dc_dprc_disable() when old_plane_state->visible is false write
to unclocked PRG registers via dc_prg_disable() while runtime-suspended and
underflow the runtime PM usage counts on prg->dev and dprc->dev? Should the
second check also require old_plane_state->visible?

> +
>  	dc_fg_disable_clock(dc_crtc->fg);
> =20
>  	/* request pixel engine power-off as plane is off too */
> @@ -371,7 +450,11 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct=
 drm_atomic_commit *state)
>  int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
>  {
>  	struct dc_drm_device *dc_drm =3D to_dc_drm_device(crtc->dev);
> +	struct dc_plane *dc_plane =3D to_dc_plane(crtc->primary);
>  	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> +	enum dc_link_id ed_src, lb_sec;
> +	bool disable_dprc =3D false;
> +	bool crtc_is_enabled;
>  	int ret;
> =20
>  	ret =3D pm_runtime_resume_and_get(dc_crtc->de->dev);
> @@ -381,16 +464,71 @@ int dc_crtc_disable_at_boot(struct drm_crtc *crtc)
>  		goto out1;
>  	}
> =20
> +	crtc_is_enabled =3D dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)=
);
> +
> +	ret =3D pm_runtime_resume_and_get(dc_drm->pe->dev);
> +	if (ret) {
> +		dc_crtc_err(crtc, "failed to get DC pixel engine RPM: %d\n",
> +			    ret);
> +		goto out2;
> +	}
> +
>  	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
>  		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> -		goto out2;
> +		goto out3;
>  	}
> =20
> -	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
> -	__dc_crtc_disable_fg(crtc);
> +	ret =3D dc_ed_pec_src_sel_get(dc_crtc->ed_cont, &ed_src);
> +	if (ret || ed_src =3D=3D LINK_ID_NONE) {
> +		dc_crtc_err(crtc, "failed to get content ExtDst's source\n");
> +		if (ret =3D=3D 0)
> +			ret =3D -EINVAL;
> +		goto out3;
> +	}
> =20
> -	if (!dc_drv_crtc_is_enabled(dc_drm, drm_crtc_index(crtc)))
> -		goto out2;
> +	if (ed_src =3D=3D LINK_ID_CONSTFRAME0 || ed_src =3D=3D LINK_ID_CONSTFRA=
ME1)
> +		goto disable;
> +
> +	ret =3D dc_lb_pec_dynamic_sec_sel_get(dc_plane->lb, &lb_sec);
> +	if (ret || lb_sec =3D=3D LINK_ID_NONE) {
> +		dc_crtc_err(crtc,
> +			    "failed to get primary plane LayerBlend secondary source\n");
> +		if (ret =3D=3D 0)
> +			ret =3D -EINVAL;
> +		goto out3;
> +	}
> +
> +	/*
> +	 * If CRTC was enabled by bootloader instead of this driver, we don't
> +	 * know if DPRC was enabled or not.  In this case, enforcing DPRC
> +	 * disablement potentially causes imbalanced clock enable count for
> +	 * DPRC and PRG clocks.  So, we presume bootloader doesn't bother to
> +	 * use prefetch engines.
> +	 */
> +	if (crtc_is_enabled)
> +		disable_dprc =3D true;

[Severity: Medium]
In dc_crtc_disable_at_boot(), if the CRTC was enabled by the bootloader
rather than this driver (so crtc_is_enabled is false), disable_dprc is never
set to true. However, dc_ed_pec_src_sel_get() and
dc_lb_pec_dynamic_sec_sel_get() are still evaluated beforehand and abort
with -EINVAL (skipping FrameGen disablement and failing driver bind in
dc_drm_bind()) if ed_src or lb_sec is LINK_ID_NONE or an unrecognized link
ID.

If the bootloader enabled the display using only the safety stream (leaving
ed_cont at LINK_ID_NONE), using LayerBlend in neutral mode (leaving lb_sec =
at
LINK_ID_NONE), or using a FetchDecode unit not listed in sec_sels[], won't
dc_crtc_disable_at_boot() fail to disable FrameGen and cause driver probe to
fail? Should we jump straight to the disable label when !crtc_is_enabled
before querying ed_src and lb_sec?

[ ... ]

> diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/d=
c-plane.c
> index 42c0a46281cb1..2b58c4e2b7e45 100644
> --- a/drivers/gpu/drm/imx/dc/dc-plane.c
> +++ b/drivers/gpu/drm/imx/dc/dc-plane.c

[ ... ]

> @@ -158,12 +180,18 @@ dc_plane_atomic_update(struct drm_plane *plane, str=
uct drm_atomic_commit *state)
>  {
>  	struct drm_plane_state *new_state =3D
>  				drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_plane_state *old_state =3D
> +				drm_atomic_get_old_plane_state(state, plane);
> +	struct drm_crtc_state *new_crtc_state =3D
> +				drm_atomic_get_new_crtc_state(state, new_state->crtc);
> +	bool needs_modeset =3D drm_atomic_crtc_needs_modeset(new_crtc_state);
>  	struct dc_plane *dplane =3D to_dc_plane(plane);
>  	struct drm_framebuffer *fb =3D new_state->fb;
>  	const struct dc_fu_ops *fu_ops;
>  	struct dc_lb *lb =3D dplane->lb;
>  	struct dc_fu *fu =3D dplane->fu;
>  	dma_addr_t baseaddr;
> +	bool prefetch_start;
>  	int src_w, src_h;
>  	int idx;
> =20
> @@ -184,7 +212,8 @@ dc_plane_atomic_update(struct drm_plane *plane, struc=
t drm_atomic_commit *state)
> =20
>  	fu_ops->set_layerblend(fu, lb);
>  	fu_ops->set_burstlength(fu, baseaddr);
> -	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, fb->pitches[0]);
> +	fu_ops->set_src_stride(fu, DC_FETCHUNIT_FRAC0, src_w,
> +			       fb->format->cpp[0] * 8, baseaddr);
>  	fu_ops->set_src_buf_dimensions(fu, DC_FETCHUNIT_FRAC0, src_w, src_h);
>  	fu_ops->set_fmt(fu, DC_FETCHUNIT_FRAC0, fb->format);
>  	fu_ops->set_framedimensions(fu, src_w, src_h);
> @@ -193,6 +222,11 @@ dc_plane_atomic_update(struct drm_plane *plane, stru=
ct drm_atomic_commit *state)
> =20
>  	dc_plane_dbg(plane, "uses %s\n", fu_ops->get_name(fu));
> =20
> +	prefetch_start =3D needs_modeset || !old_state->fb ||
> +			 (!old_state->visible && new_state->visible);
> +	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
> +			  fb->pitches[0], fb->format, baseaddr, prefetch_start);

[Severity: High]
As reported by Sashiko on v7 [2], when a CRTC with a visible primary plane
transitions to inactive (new_crtc_state->active =3D=3D false while
new_crtc_state->enable =3D=3D true, such as during DPMS OFF or system suspe=
nd via
dc_suspend() -> drm_mode_config_helper_suspend()), won't
dc_plane_atomic_update() re-enable DPRC and PRG after
dc_crtc_atomic_disable() has already disabled them?

Because dc_kms_init() uses the default drm_atomic_helper_commit_tail()
without DRM_PLANE_COMMIT_ACTIVE_ONLY:

1. drm_atomic_helper_commit_modeset_disables() runs dc_crtc_atomic_disable(=
),
   which calls dc_dprc_disable(dc_plane->fu->dprc) and drops the runtime PM
   reference on dc_drm->pe->dev.
2. drm_atomic_helper_commit_planes() then runs dc_crtc_atomic_begin() (which
   returns early because !new_crtc_state->active, leaving dc_drm->pe->dev
   suspended) followed by dc_plane_atomic_update().
3. In dc_plane_atomic_update(), new_state->visible is still true and
   needs_modeset is true (because new_crtc_state->active_changed is true), =
so
   prefetch_start is set to true. This accesses FetchUnit, LayerBlend, and
   ExtDst registers while pe->dev is runtime-suspended and calls
   dc_dprc_configure() with start =3D true, which calls
   pm_runtime_resume_and_get() on dprc->dev and prg->dev and starts DPRC and
   PRG with RUN_EN | REPEAT_EN while the CRTC is off, leaking those runtime
   PM references on subsequent commits.

Should dc_plane_atomic_update() check new_crtc_state->active (or should the
driver set DRM_PLANE_COMMIT_ACTIVE_ONLY in mode_config.helper_private)?

[1] https://lore.kernel.org/r/20261026-imx8-dc-prefetch-v7-15-a0b50cc4fc65@=
nxp.com
[2] https://lore.kernel.org/r/20261026-imx8-dc-prefetch-v7-15-a0b50cc4fc65@=
nxp.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030-imx8-dc-pr=
efetch-v8-0-c4f81afd4533@nxp.com?part=3D15
