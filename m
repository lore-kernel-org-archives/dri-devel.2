Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 58D6EC79F80
	for <dri-devel@archiver.kernel.org>; Fri,  4 Sep 2026 08:13:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 97FDF10F92D;
	Fri,  4 Sep 2026 08:13:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IvK8a9D2";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B435E10F92D
 for <dri-devel@lists.freedesktop.org>; Fri,  4 Sep 2026 08:13:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 3D08D42E1D;
 Fri,  4 Sep 2026 08:13:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B980E1F00A3D;
 Fri,  4 Sep 2026 08:13:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788509617;
 bh=8Zek3p/Pt+409LNhjEEkeXL5le1OKSw9hIEyVXA8L8k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IvK8a9D2AZ1ikOA5nphaTwc2KBq2Agpku9Gmo/tLyimrirTsZLg1SEaBwOBC6wYxv
 iFduPbch9emhV3OQ8AkryCkZfPvyrHUSboDgHlVlDQF5b+ksuMtN6N3JDmnnO+fCAc
 ohFjZbln3SZ+H+xjrpnCH0EB0xDxtLRYW8i3IJT+r0OuJJvcjyt/0RS+vOYEVXfw1y
 UmK/iRwzMrp0+Ik3LGSJakP6QBIXoBdr1eJI83KjNAw6iLbgnWFooUeeCbMSylhSFC
 tsjANYv4znBWf9kUHpVLcGkr66O+zX6NBzDGAS54saCBYYwhz8GFUNzd0vt08nR1Jk
 1gnunD6as4uEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 13/13] drm/imx: dc: Use prefetch engine
To: "Liu Ying" <victor.liu@nxp.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, Frank.Li@kernel.org, imx@lists.linux.dev,
 conor+dt@kernel.org
In-Reply-To: <20260904-imx8-dc-prefetch-v6-13-26643e3f6cb7@nxp.com>
References: <20260904-imx8-dc-prefetch-v6-0-26643e3f6cb7@nxp.com>
 <20260904-imx8-dc-prefetch-v6-13-26643e3f6cb7@nxp.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 04 Sep 2026 08:13:36 +0000
Message-Id: <20260904081336.B980E1F00A3D@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

New issues:
- [High] Null pointer dereference when disabling a plane that is not part o=
f the atomic commit.
- [High] Hard lockup and severe latency violation due to polling jiffies wi=
th local interrupts disabled.
- [High] Hardware hang from unconditional DPRC register access at boot when=
 its clocks may be disabled.
- [High] Calling a sleeping runtime PM function from an atomic context.
- [Medium] Double disable of clk_axi leading to clock framework enable coun=
t underflow.
- [Medium] Unbalanced clock disable in dc_dprc_disable_at_boot() causing en=
able count underflow.

Pre-existing issues:
- [High] Undefined behavior from passing a potentially zero DMA address to =
__ffs().
--

commit 35c9e924832406cba349405f526113d99f76a533
Author: Liu Ying <victor.liu@nxp.com>

drm/imx: dc: Use prefetch engine

One prefetch engine consists of one DPR channel and one or two PRGs.
Each PRG handles one planar in a pixel format.  Every FetchUnit used
by KMS may attach to a PRG and hence use a prefetch engine.  So, to
simplify driver code, always use prefetch engines for FetchUnits in
KMS driver and avoid supporting bypassing them.  Aside from configuring
and disabling a prefetch engine along with a FetchUnit for atomic
commits, properly disable the prefetch engine at boot and adapt burst
size/stride fixup requirements from PRG in FetchUnit driver.

> diff --git a/drivers/gpu/drm/imx/dc/dc-crtc.c b/drivers/gpu/drm/imx/dc/dc=
-crtc.c
> index eae9bd164b230..f4b83fa4f65cf 100644
> --- a/drivers/gpu/drm/imx/dc/dc-crtc.c
> +++ b/drivers/gpu/drm/imx/dc/dc-crtc.c

[ ... ]

> @@ -204,7 +205,13 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct d=
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
> +	bool disabling_plane;
>  	int idx;
> =20
>  	if (drm_atomic_crtc_needs_modeset(new_crtc_state) ||
> @@ -216,13 +223,40 @@ dc_crtc_atomic_flush(struct drm_crtc *crtc, struct =
drm_atomic_commit *state)
> =20
>  	enable_irq(dc_crtc->irq_ed_cont_shdload);
> =20
> -	/* flush plane update out to display */
> -	dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
> +	disabling_plane =3D drm_atomic_plane_disabling(old_plane_state,
> +						     new_plane_state);

[Severity: High]
Does this code risk a NULL pointer dereference in dc_crtc_atomic_flush()?

If an atomic commit updates a CRTC property or a different plane without
including the primary plane, drm_atomic_get_old_plane_state() and
drm_atomic_get_new_plane_state() will return NULL.

When these NULL plane states are passed directly to
drm_atomic_plane_disabling(), the helper will unconditionally dereference t=
he
pointers (e.g. new_plane_state->crtc), which could cause a kernel panic.

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

[Severity: High]
Could polling jiffies with local interrupts disabled cause a hard lockup?

The driver disables local interrupts using local_irq_save() and then calls
DC_CRTC_WAIT_FOR_FRAMEGEN_FRAME_INDEX_MOVING(), which internally loops
while checking a jiffies-based timeout (via time_before(jiffies, timeout)).

With interrupts disabled, the timer tick cannot fire on the local CPU to
update jiffies. On UP systems or if this CPU handles the tick, jiffies will
never increment, turning the timeout fallback into an infinite loop if the
hardware takes too long or fails to update the frame index.

> +		dc_dprc_disable_repeat_en(dc_plane->fu->dprc);
> +		/* flush plane update out to display */
> +		dc_ed_pec_sync_trigger(dc_crtc->ed_cont);
> +
> +		local_irq_restore(flags);
> +		preempt_enable();

[ ... ]

> @@ -367,7 +435,10 @@ dc_crtc_atomic_disable(struct drm_crtc *crtc, struct=
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
> @@ -377,13 +448,53 @@ void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
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
>  	}
> =20
> -	dc_crtc_dbg(crtc, "disabling at boot\n");
> -	__dc_crtc_disable_fg(crtc);
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
> +	}
> +
> +	disable_dprc =3D true;

[Severity: High]
Does this code risk a hardware hang by unconditionally accessing DPRC regis=
ters
at boot?

dc_crtc_disable_at_boot() reads the secondary source into lb_sec, but
entirely ignores the value and unconditionally sets disable_dprc =3D true.

If the bootloader didn't use the DPRC (so lb_sec is LINK_ID_NONE), its cloc=
ks
will remain gated. The driver then attempts to write to the DPRC's SYSTEM_C=
TRL0
register (via dc_dprc_disable_at_boot() -> dc_dprc_disable_repeat_en() /
dc_prg_disable_at_boot()) without enabling its clocks via PM runtime, which
could cause an immediate bus fault.

> +
> +disable:
> +	enable_irq(dc_crtc->irq_dec_seqcomplete);
> +
> +	if (disable_dprc) {
> +		dc_crtc_dbg(crtc, "disabling along with DPRC REPEAT_EN at boot\n");
> +		__dc_crtc_disable_fg_along_with_dprc_repeat_en(crtc);
> +	} else {
> +		dc_crtc_dbg(crtc, "disabling at boot\n");
> +		dc_fg_disable(dc_crtc->fg);
> +	}
> +
> +	DC_CRTC_WAIT_FOR_COMPLETION_TIMEOUT(dec_seqcomplete_done);
> +	disable_irq(dc_crtc->irq_dec_seqcomplete);
> +
> +	if (disable_dprc)
> +		dc_dprc_disable_at_boot(dc_plane->fu->dprc);

[Severity: Medium]
Will this result in an unbalanced clock disable in dc_dprc_disable_at_boot(=
)?

dc_dprc_disable_at_boot() unconditionally calls clk_bulk_disable_unprepare()
on dprc->clks. Because dc_crtc_disable_at_boot() does not resume the DPRC
device first (unlike the DE and PE devices), the clock framework considers
the DPRC clocks to be disabled (count =3D 0). Disabling them explicitly here
could cause a negative enable count and a kernel WARN_ON.

>  	dc_fg_disable_clock(dc_crtc->fg);
> =20
>  	if (!dc_drm->pe_clk_axi_disabled) {
> @@ -391,7 +502,9 @@ void dc_crtc_disable_at_boot(struct drm_crtc *crtc)
>  		dc_drm->pe_clk_axi_disabled =3D true;
>  	}
> =20
> -out:
> +out2:
> +	pm_runtime_put(dc_drm->pe->dev);

[Severity: Medium]
Could this lead to a double disable of clk_axi?

The code above explicitly calls clk_disable_unprepare(dc_drm->pe->clk_axi).
Immediately after, it calls pm_runtime_put(dc_drm->pe->dev).=20
If this triggers a runtime suspend callback that unconditionally calls
clk_disable_unprepare() again on the same clock, it could drive the enable
count negative and trigger a kernel splat.

> +out1:
>  	pm_runtime_put(dc_crtc->de->dev);
>  }
> =20

> diff --git a/drivers/gpu/drm/imx/dc/dc-fu.c b/drivers/gpu/drm/imx/dc/dc-f=
u.c
> index 8339f44c00919..28f962af69746 100644
> --- a/drivers/gpu/drm/imx/dc/dc-fu.c
> +++ b/drivers/gpu/drm/imx/dc/dc-fu.c
> @@ -124,13 +124,28 @@ static inline void dc_fu_set_numbuffers(struct dc_f=
u *fu, unsigned int num)
>  			  SETNUMBUFFERS_MASK, SETNUMBUFFERS(num));
>  }
> =20
> -static void dc_fu_set_burstlength(struct dc_fu *fu, dma_addr_t baddr)
> +static unsigned int dc_fu_burst_size_fixup(dma_addr_t baddr)
>  {
> -	unsigned int burst_size, burst_length;
> +	unsigned int burst_size;
> =20
>  	burst_size =3D 1 << __ffs(baddr);

[Severity: High]
This is a pre-existing issue, but does this code cause undefined behavior if
baddr is zero?

If the IOMMU or DMA allocator returns an IOVA of 0 (which is valid on many
platforms), baddr is 0. Passing 0 to __ffs() triggers undefined behavior
(on some architectures returning 64, causing 1 << 64 which is also UB). This
could lead to wild burst size calculations.

>  	burst_size =3D round_up(burst_size, 8);
>  	burst_size =3D min(burst_size, 128U);
> +
> +	return burst_size;
> +}

[ ... ]

> diff --git a/drivers/gpu/drm/imx/dc/dc-plane.c b/drivers/gpu/drm/imx/dc/d=
c-plane.c
> index dea7404fe6590..bf4b00c54c94d 100644
> --- a/drivers/gpu/drm/imx/dc/dc-plane.c
> +++ b/drivers/gpu/drm/imx/dc/dc-plane.c
> @@ -152,7 +180,8 @@ dc_plane_atomic_update(struct drm_plane *plane, struc=
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
> @@ -161,6 +190,9 @@ dc_plane_atomic_update(struct drm_plane *plane, struc=
t drm_atomic_commit *state)
> =20
>  	dc_plane_dbg(plane, "uses %s\n", fu_ops->get_name(fu));
> =20
> +	dc_dprc_configure(fu->dprc, new_state->crtc->index, src_w, src_h,
> +			  fb->pitches[0], fb->format, baseaddr, prefetch_start);

[Severity: High]
Does dc_dprc_configure() call a sleeping function in an atomic context?

dc_plane_atomic_update() executes in an atomic context where sleeping is
forbidden. However, it calls dc_dprc_configure(), which internally calls
pm_runtime_resume_and_get(), a function that sleeps while waiting on PM loc=
ks
and executing device resume callbacks.

> +
>  	dc_lb_pec_dynamic_prim_sel(lb, dc_cf_get_link_id(dplane->cf));
>  	dc_lb_pec_dynamic_sec_sel(lb, fu_ops->get_link_id(fu));
>  	dc_lb_mode(lb, LB_BLEND);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260904-imx8-dc-pr=
efetch-v6-0-26643e3f6cb7@nxp.com?part=3D13
