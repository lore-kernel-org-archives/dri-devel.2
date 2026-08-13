Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D4E9DC5B572
	for <dri-devel@archiver.kernel.org>; Thu, 13 Aug 2026 10:00:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C75EC10F272;
	Thu, 13 Aug 2026 10:00:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="SVvQuSOj";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDAC210F283
 for <dri-devel@lists.freedesktop.org>; Thu, 13 Aug 2026 10:00:27 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 65B9D436E7;
 Thu, 13 Aug 2026 10:00:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 349761F000E9;
 Thu, 13 Aug 2026 10:00:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786615227;
 bh=Mnnwx3buYGAR+y6Kd9qqNMdP1QK7b2k2j6sXnsneZmQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=SVvQuSOjjRTB4iWyI45TaDEN7nnL8UjoOrzNqMuqxO/uQ4SfjgytxVdXLNmE6opeP
 klhbIMKLKq+WW8SOUNUhi9SYBzkS8BCXEO/sIYaIV5mHLIrWmxazSWUIIbA536mj96
 zxIg3rq+C1mc6ugKPl6/I001WLhpTlWRXZJFM5ddq5x0Sgw6PMIQS+Huoh++otPWZ3
 gc4ohwoc+VGdKb5uBOleKf7FoTNEUPY/DsU+m4UH+B+0WytF5IzrVDtL7xz5s+w+dL
 C8KLnTP83iGZi/pbgTkVh6VMrAZhpgdV03qY+hDaPF5l8NzERqegPtD5Ypao73LA01
 8yPpw+dCsxncA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] drm/rockchip: vop2: Scale the AXI clock to the
 bandwidth the mode needs
To: "Igor Paunovic" <royalnet026@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260813094614.9072-1-royalnet026@gmail.com>
References: <20260813094614.9072-1-royalnet026@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 13 Aug 2026 10:00:26 +0000
Message-Id: <20260813100027.349761F000E9@smtp.kernel.org>
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
- [High] Out-of-order execution of non-blocking atomic commits causes AXI c=
lock rate inversion, leading to hardware starvation.
- [High] Premature AXI clock lowering during simultaneous CRTC disables cau=
ses FIFO underruns.
- [Medium] Missing cleanup of `rockchip_rgb` resources on `drm_atomic_priva=
te_obj_init` failure in `vop2_bind`.
--

--- Patch [1]: [PATCH v2] drm/rockchip: vop2: Scale the AXI clock to the ba=
ndwidth the mode needs ---
commit e3a0edc8d8cda30a6d024161b316416c1d467e17
Author: Igor Paunovic <royalnet026@gmail.com>

drm/rockchip: vop2: Scale the AXI clock to the bandwidth the mode needs

VOP2 fetches the scanout data for all of its video ports over a single
AXI clock.  On RK3588 that clock is pinned to 500 MHz by the device tree
and nothing ever raises it, so a mode whose pixel rate outruns what the
AXI clock can deliver underruns the internal scanout FIFO.

Link: https://lore.kernel.org/all/20260808104240.13776-1-royalnet026@gmail.=
com/
Link: https://lore.kernel.org/all/20767137.geO5KgaWL5@diego/ [1]

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index 4cce3e336f5b3..fdee08042ac74 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c

[ ... ]

> @@ -1008,6 +1022,72 @@ static bool vop2_gamma_lut_in_use(struct vop2 *vop=
2, struct vop2_video_port *vp)
[ ... ]
> +static void vop2_apply_aclk_rate(struct vop2 *vop2, struct drm_atomic_co=
mmit *state)
> +{
> +	struct drm_private_state *priv_state;
> +
> +	if (vop2->version !=3D VOP_VERSION_RK3588)
> +		return;
> +
> +	priv_state =3D drm_atomic_get_new_private_obj_state(state, &vop2->aclk_=
obj);
> +	if (!priv_state)
> +		return;
> +
> +	clk_set_rate(vop2->aclk,
> +		     vop2_aclk_rate(vop2, to_vop2_aclk_state(priv_state)));

[Severity: High]
Does this allow older state snapshots to overwrite newer ones when
non-blocking atomic commits execute out of order?

Since the driver doesn't implement the atomic_commit_setup hook, DRM core
does not enforce execution ordering for commits that only share a
drm_private_obj.

If a compositor submits a non-blocking modeset on CRTC A (C1), followed
closely by a non-blocking modeset on CRTC B (C2), C1's atomic state captures
a snapshot of aclk_obj before C2's requirements exist.=20

If C1 is delayed and C2 applies its high clock rate first, when C1 finally
executes, it might apply its stale state snapshot here.

Could this override C2's higher clock requirement, dropping the AXI clock
and causing hardware starvation for the active video ports?

> +}
> +
>  static void vop2_crtc_atomic_disable(struct drm_crtc *crtc,
>  				     struct drm_atomic_commit *state)
>  {
> @@ -1053,6 +1133,8 @@ static void vop2_crtc_atomic_disable(struct drm_crt=
c *crtc,
>  	if (!vop2->enable_count)
>  		vop2_disable(vop2);
> =20
> +	vop2_apply_aclk_rate(vop2, state);

[Severity: High]
Can this cause premature AXI clock lowering when a single atomic commit
disables multiple active CRTCs?

During a multi-CRTC disable commit, drm_atomic_helper_commit_crtc_disable()
disables them sequentially. For the first CRTC disabled, this call applies
the new atomic state. Since the new state reflects that all participating
CRTCs will be disabled, the AXI clock is instantly dropped to its baseline.

However, the subsequent CRTCs have not yet been disabled and are still
scanning out pixels while waiting for dsp_hold_completion.

During this time window, could the lowered AXI clock be insufficient for the
remaining active CRTCs, resulting in FIFO underruns?

> +
>  	vop2_unlock(vop2);
> =20
>  	if (crtc->state->event && !crtc->state->active) {

[ ... ]

> @@ -2944,6 +3044,11 @@ static int vop2_bind(struct device *dev, struct de=
vice *master, void *data)
> =20
>  	rockchip_drm_dma_init_device(vop2->drm, vop2->dev);
> =20
> +	ret =3D drm_atomic_private_obj_init(vop2->drm, &vop2->aclk_obj,
> +					  &vop2_aclk_state_funcs);
> +	if (ret)
> +		goto err_crtcs;

[Severity: Medium]
Does this error path leak rockchip_rgb resources?

If drm_atomic_private_obj_init() fails, the code jumps to the err_crtcs
label. However, the err_crtcs block only calls vop2_destroy_crtcs(vop2),
bypassing the rockchip_rgb_fini(vop2->rgb) cleanup for the RGB encoder
resources allocated earlier in vop2_bind().

> +
>  	pm_runtime_enable(&pdev->dev);
> =20
>  	return 0;
> =20
>  err_crtcs:
>  	vop2_destroy_crtcs(vop2);
> =20
>  	return ret;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260813094614.9072=
-1-royalnet026@gmail.com?part=3D1
