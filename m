Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4BEB1606A31F
	for <dri-devel@archiver.kernel.org>; Mon, 26 Oct 2026 12:41:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IIinVJ0B
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC3AB10E04D;
	Mon, 26 Oct 2026 12:41:24 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 770B810E04D
 for <dri-devel@lists.freedesktop.org>; Mon, 26 Oct 2026 12:41:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1E88643E69;
 Mon, 26 Oct 2026 12:41:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A85DD1F01825;
 Mon, 26 Oct 2026 12:41:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793018478;
 bh=Z1D4b3hWEFttOMPgYb/8xS4m7R+HyoOLIQJgWDKVFCo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IIinVJ0B1kTBViSg5Hs9yRPaklnh59+Wd6kK6ttKRX1mZ4kwTtBaJDWLZvV50nEC8
 hDYX/n7X1QF0W9JlgZ3UrfNZBsrdnQ2Hsf6nvl0rugPRQQv7N2R9htc/rzSJx3Bdzy
 FwY0FHpj8aMfsl8mjAEcli2n063RotaRXjkfbY6/dC036107+eNv3O5V6XSrtYLvOY
 bMNjb8pM0SKXZzDe735HAoijl0X58OXdhwVo3wCjZggzq1Dbv7ISR57sS3G152fNsg
 308Msz696hUeGxwilzApAM9rbECazFOtQco7I7pzBCN8MgK3CtRtHb+D1TqPhWN7wH
 0ruOr+KG7FNSw==
Message-ID: <sashiko-outbox-185226@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 15/15] drm/imx: dc: Use prefetch engine
To: "Liu Ying" <victor.liu@nxp.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 imx@lists.linux.dev, robh@kernel.org, conor+dt@kernel.org, Frank.Li@kernel.org
In-Reply-To: <20261026-imx8-dc-prefetch-v7-15-a0b50cc4fc65@nxp.com>
References: <20261026-imx8-dc-prefetch-v7-0-a0b50cc4fc65@nxp.com>
 <20261026-imx8-dc-prefetch-v7-15-a0b50cc4fc65@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 12:41:17 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:
- [High] drm/imx: dc: mismatched plane visibility checks in DPRC lifecycle =
paths
- [High] drm/imx: dc: unclocked DPRC access and unused lb_sec in dc_crtc_di=
sable_at_boot()
- [High] drm/imx: dc: dc_plane_atomic_update() starts DPRC on inactive CRTC
--

commit cdc3c29f6a09448d1496c6876f0f852d161beff3
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Use prefetch engine

This commit enables prefetch engine support (DPRC and PRG) for FetchUnits
in the i.MX8 DC KMS driver, configuring and disabling the prefetch engine
alongside FetchUnits during atomic commits and boot disablement. It also
adds PRG burst size and stride fixups in the FetchUnit driver and sets
use_raw_spinlock in the ExtDst PIXENGCFG regmap config.

> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc=
-crtc.c
> index 1ca1c9229e94d..2d17afcae8f2b 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c
[ ... ]
> @@ -216,13 +223,41 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct =
drm_atomic_commit *state)
> =20
>  	enable_irq(dc_crtc->irq_ed_cont_shdload);
> =20
> -	/* flush plane update out to display */
> -	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
> +	if (old_plane_state && new_plane_state)
> +		disabling_plane =3D drm_atomic_plane_disabling(old_plane_state,
> +							     new_plane_state);
> +
> +	if (disabling_plane) {
> +		unsigned long flags;
> +
> +		dc_crtc_dbg(crtc, "disabling plane\n");
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
> +	} else {
> +		/* flush plane update out to display */
> +		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
> +	}
> =20
>  	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(ed_cont_shdload_done);
> =20
>  	disable_irq(dc_crtc->irq_ed_cont_shdload);
> =20
> +	if (disabling_plane)
> +		dc_dprc_disable(dc_plane->fu->dprc);
> +
>  	DC_CRTC_CHECK_FRAMEGEN_FIFO(dc_crtc->fg);
> =20
>  	drm_dev_exit(idx);
[ ... ]
> @@ -338,14 +392,29 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struc=
t drm_atomic_commit *state)
>  {
>  	struct drm_crtc_state *new_crtc_state =3D
>  				drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_crtc_state *old_crtc_state =3D
> +				drm_atomic_get_old_crtc_state(state, crtc);
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
> +	if (old_crtc_state->plane_mask)
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
What happens in dc_crtc_atomic_flush(), dc_crtc_atomic_disable(), and
dc_plane_atomic_update() when a primary plane has a valid fb and crtc,
but is positioned completely off-screen so that plane_state->visible is
false?

In dc_plane_atomic_check(), drm_atomic_helper_check_plane_state() is
called with can_position set to true. When the plane is off-screen,
plane_state->visible becomes false while plane_state->fb and
plane_state->crtc remain set, and crtc_state->plane_mask stays non-zero.

In dc_plane_atomic_update(), when !new_state->visible, the code calls
__dc_plane_atomic_disable(plane) and returns early before calling
dc_dprc_configure():

drivers/gpu/drm/imx/dc/dc-plane.c:dc_plane_atomic_update() {
	...
	bool needs_modeset =3D drm_atomic_crtc_needs_modeset(new_crtc_state);
	bool prefetch_start =3D needs_modeset || !old_state->fb;
	...
	if (!new_state->visible) {
		__dc_plane_atomic_disable(plane);
		goto out;
	}
	...
	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
			  fb->pitches[0], fb->format, baseaddr, prefetch_start);
}

However, the DPRC start and stop conditions check old_state->fb,
drm_atomic_plane_disabling() (which checks old_plane_state->crtc &&
!new_plane_state->crtc), and old_crtc_state->plane_mask instead of plane
visibility:

1. If a visible plane moves off-screen (old_plane_state->visible is true,
new_plane_state->visible is false, new_plane_state->crtc is non-NULL),
__dc_plane_atomic_disable() disables the FetchUnit, but
drm_atomic_plane_disabling() in dc_crtc_atomic_flush() evaluates to
false. Doesn't this skip dc_dprc_disable_repeat_en() and
dc_dprc_disable(), leaving DPRC REPEAT_EN running and leaking the runtime
PM references on dprc->dev and prg->dev?

2. If an off-screen plane moves back on-screen without a modeset
(old_state->visible is false with old_state->fb non-NULL, and
new_state->visible is true), prefetch_start in dc_plane_atomic_update()
is false. Won't dc_dprc_configure() and dc_prg_configure() skip
pm_runtime_resume_and_get(), write to unclocked DPRC and PRG registers
while runtime-suspended, and fail to start the DPRC and PRG?

3. If an off-screen plane (old_plane_state->visible is false,
old_plane_state->crtc is non-NULL) is subsequently disabled via
dc_crtc_atomic_flush() or its CRTC is disabled via
dc_crtc_atomic_disable(), dc_dprc_disable_repeat_en() and
dc_dprc_disable() will be called even though DPRC was never started.
Won't that access unclocked DPRC/PRG registers and underflow the runtime
PM usage counts on dprc->dev and prg->dev?

> @@ -371,7 +440,10 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct=
 drm_atomic_commit *state)
>  void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
>  {
>  	struct dc_drm_device *dc_drm =3D to_dc_drm_device(crtc->dev);
> +	struct dc_plane *dc_plane =3D to_dc_plane(crtc->primary);
>  	struct dc_crtc *dc_crtc =3D to_dc_crtc(crtc);
> +	enum dc_link_id ed_src, lb_sec;
> +	bool disable_dprc =3D false;
>  	int ret;
> =20
>  	ret =3D pm_runtime_resume_and_get(dc_crtc->de->dev);
> @@ -381,16 +453,57 @@ void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
>  		return;
>  	}
> =20
> +	ret =3D pm_runtime_resume_and_get(dc_drm->pe->dev);
> +	if (ret) {
> +		dc_crtc_err(crtc, "failed to get DC pixel engine RPM: %d\n",
> +			    ret);
> +		goto out1;
> +	}
> +
>  	if (!dc_fg_wait_for_frame_index_moving(dc_crtc->fg)) {
>  		dc_crtc_dbg(crtc, "FrameGen frame index isn't moving\n");
> -		goto out;
> +		goto out2;
> +	}
> +
> +	ret =3D dc_ed_pec_src_sel_get(dc_crtc->ed_cont, &ed_src);
> +	if (ret) {
> +		dc_crtc_err(crtc, "failed to get content ExtDst's source\n");
> +		goto out2;
> +	}
> +
> +	if (ed_src =3D=3D LINK_ID_CONSTFRAME0 || ed_src =3D=3D LINK_ID_CONSTFRA=
ME1)
> +		goto disable;
> +
> +	ret =3D dc_lb_pec_dynamic_sec_sel_get(dc_plane->lb, &lb_sec);
> +	if (ret) {
> +		dc_crtc_err(crtc,
> +			    "failed to get primary plane LayerBlend secondary source\n");
> +		goto out2;
>  	}
> =20
> -	dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
> -	__dc_crtc_disable_fg(crtc);
> +	disable_dprc =3D true;
> +
> +disable:
> +	enable_irq(dc_crtc->irq_dec_seqcomplete);
> +
> +	if (disable_dprc) {
> +		dc_crtc_dbg(crtc, "disabling FrameGen along with DPRC REPEAT_EN at boo=
t\n");
> +		dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
> +	} else {
> +		dc_crtc_dbg(crtc, "disabling FrameGen at boot\n");
> +		dc_fg_disable(dc_crtc->fg);
> +	}
> +
> +	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
> +	disable_irq(dc_crtc->irq_dec_seqcomplete);
> =20
>  	if (!dc_drv_crtc_was_enabled(dc_drm, drm_crtc_index(crtc)))
> -		goto out;
> +		goto out2;
> +
> +	if (disable_dprc) {
> +		dc_crtc_dbg(crtc, "disabling DPRC at boot\n");
> +		dc_dprc_disable_at_boot(dc_plane->fu->dprc);
> +	}

[Severity: High]
In dc_crtc_disable_at_boot(), lb_sec is read by
dc_lb_pec_dynamic_sec_sel_get() but never inspected afterwards, and
dc_ed_pec_src_sel_get() and dc_lb_pec_dynamic_sec_sel_get() both return 0
when the hardware register is set to LINK_ID_NONE:

drivers/gpu/drm/imx/dc/dc-lb.c:dc_lb_pec_dynamic_sec_sel_get() {
	...
	switch (val) {
	case LINK_ID_NONE:
	case LINK_ID_FETCHWARP2:
	case LINK_ID_FETCHLAYER0:
		*sec =3D val;
		dev_dbg(lb->dev, "get secondary input selection: 0x%02x\n", val);
		return 0;
	...
}

If ed_src or lb_sec is LINK_ID_NONE, disable_dprc is still set to true.
Furthermore, at the disable label,
dc_crtc_disable_fg_along_with_dprc_repeat_en() writes to DPRC
SYSTEM_CTRL0 + CLR via dc_dprc_disable_repeat_en() before
dc_drv_crtc_was_enabled() is checked and without holding a runtime PM
reference on dprc->dev.

If the bootloader enabled FrameGen without using the DPRC (leaving the
DPRC power domain or clocks off, or leaving lb_sec as LINK_ID_NONE),
could calling dc_dprc_disable_repeat_en() or dc_dprc_disable_at_boot()
access unclocked DPRC/PRG registers and trigger a bus abort / SError
during boot, or disable already-disabled DPRC/PRG clocks?

> diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/d=
c-plane.c
> index 42c0a46281cb1..3a9c7548f8279 100644
> --- a/drivers/gpu/drm/imx/dc/dc-plane.c
> +++ b/drivers/gpu/drm/imx/dc/dc-plane.c
[ ... ]
> @@ -158,6 +180,12 @@ dc_plane_atomic_update(struct drm_plane *plane, stru=
ct drm_atomic_commit *state)
>  {
>  	struct drm_plane_state *new_state =3D
>  				drm_atomic_get_new_plane_state(state, plane);
> +	struct drm_plane_state *old_state =3D
> +				drm_atomic_get_old_plane_state(state, plane);
> +	struct drm_crtc_state *new_crtc_state =3D
> +				drm_atomic_get_new_crtc_state(state, new_state->crtc);
> +	bool needs_modeset =3D drm_atomic_crtc_needs_modeset(new_crtc_state);
> +	bool prefetch_start =3D needs_modeset || !old_state->fb;
>  	struct dc_plane *dplane =3D to_dc_plane(plane);
>  	struct drm_framebuffer *fb =3D new_state->fb;
>  	const struct dc_fu_ops *fu_ops;
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
> @@ -193,6 +222,9 @@ dc_plane_atomic_update(struct drm_plane *plane, struc=
t drm_atomic_commit *state)
> =20
>  	dc_plane_dbg(plane, "uses %s\n", fu_ops->get_name(fu));
> =20
> +	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
> +			  fb->pitches[0], fb->format, baseaddr, prefetch_start);

[Severity: High]
Can dc_plane_atomic_update() re-enable DPRC and access suspended Pixel
Engine registers when a CRTC with an active primary plane transitions to
inactive (such as DPMS OFF where new_crtc_state->enable remains true but
new_crtc_state->active becomes false)?

Because the driver uses the default drm_atomic_helper_commit_tail()
without DRM_PLANE_COMMIT_ACTIVE_ONLY, a DPMS OFF commit runs:

1. drm_atomic_helper_commit_modeset_disables() ->
dc_crtc_atomic_disable(), which disables FrameGen, calls
dc_dprc_disable(), and drops runtime PM on dc_drm->pe->dev.

2. drm_atomic_helper_commit_planes(dev, state, 0), where
dc_crtc_atomic_begin() returns early because !new_crtc_state->active:

drivers/gpu/drm/imx/dc/dc-crtc.c:dc_crtc_atomic_begin() {
	...
	if (!drm_atomic_crtc_needs_modeset(new_crtc_state) ||
	    !new_crtc_state->active)
		return;
	...
}

3. dc_plane_atomic_update() then runs on the inactive CRTC. Since
new_crtc_state->active_changed is true,
drm_atomic_crtc_needs_modeset(new_crtc_state) is true, so prefetch_start
is set to true.

Doesn't this cause dc_plane_atomic_update() to write to FetchUnit,
LayerBlend, and ExtDst registers while dc_drm->pe->dev is
runtime-suspended, and call dc_dprc_configure(..., true), which resumes
and starts DPRC and PRG with RUN_EN | REPEAT_EN while the CRTC is disabled
and leaks their runtime PM references?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026-imx8-dc-pr=
efetch-v7-0-a0b50cc4fc65@nxp.com?part=3D15
