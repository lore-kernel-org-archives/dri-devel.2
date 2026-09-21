Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B610C982ED
	for <dri-devel@archiver.kernel.org>; Mon, 21 Sep 2026 16:16:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DF6C610E233;
	Mon, 21 Sep 2026 16:16:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Wj6vV4gW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CE5C810E233
 for <dri-devel@lists.freedesktop.org>; Mon, 21 Sep 2026 16:16:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id F12B860120;
 Mon, 21 Sep 2026 16:16:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F0AB1F000FF;
 Mon, 21 Sep 2026 16:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790007416;
 bh=OV8mH8fcvwUQXaq/WcT/lqfgA3XD2C0A7MvVYAUdge0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Wj6vV4gWbolRlbg5cvOXrCexbfeUAaDSD/RL8/ZELmI30WvjdzMiSaTV5J9QzgZva
 PrqxqrU4aAywML6PPJxq3N6VafvYRxc4d3T/U2zWjy62NYYS0SSVmEfvB6lOCmCkuA
 lDaKSKxSMRlsbf3ZOLeabXIjNwFj6axwTvsyyc4ReBlh2M4uyt2d3BS6PGeGWBKuCT
 phO7uqKavZL/Pm3vOgE7gQvNXxW7VwvyrLnl3qNiq2gm76qEAs6BT4gLmn7KxrwM6+
 3SyVpACG7a+/UHjzp9PyHgz5sdeeuXUPGnUeeS0lr8NsOGqc4KcGRHu0RykEEenh1s
 6wkpuNZQNssGA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 11/25] drm/rockchip: vop2: Enable VRR
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260921-vrr-limiter-uapi-v1-11-2fcd7d011646@collabora.com>
References: <20260921-vrr-limiter-uapi-v1-0-2fcd7d011646@collabora.com>
 <20260921-vrr-limiter-uapi-v1-11-2fcd7d011646@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 16:16:56 +0000
Message-Id: <20260921161656.7F0AB1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] drm/rockchip: vop2: VRR stretching breaks on commits without events
- [High] drm/rockchip: vop2: VRR functionality missing in RK3576 ISR
- [High] drm/rockchip: vop2: Cannot disable VRR due to vrr_enabled guard
- [High] drm/rockchip: vop2: vop2_vp_set_vrr_vtotal fails to restore base v=
total
--

commit dc9e1b8fad941cfe2c30467e7788b4889403d827
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Date:   Mon Sep 21 15:51:37 2026 +0000

    drm/rockchip: vop2: Enable VRR
   =20
    Use the new VRR state tracking to handle VRR front porch adjustment.
   =20
    To avoid indenting too deeply, refactor the vblank handling into its own
    function while at it, where scope-based cleanup helpers for the lock can
    be used.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index bfb3841425687..e79081c044378 100644
> --- a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
> +++ b/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c
[ ... ]
> @@ -2011,6 +2012,25 @@ static void vop2_crtc_atomic_begin(struct drm_crtc=
 *crtc,
>  	vop2->ops->setup_overlay(vp);
>  }
> =20
> +static void vop2_vp_set_vrr_vtotal(struct vop2_video_port *vp, unsigned =
int vtotal)
> +{
> +	const u32 mask =3D RK3568_VP_DSP_VTOTAL_VS_END__DSP_VTOTAL |
> +			 RK3568_VP_DSP_VTOTAL_VS_END__IMD;
> +
> +	if (!vtotal) {
> +		vop2_vp_update_bits(vp, RK3568_VP_DSP_VTOTAL_VS_END,
> +				    RK3568_VP_DSP_VTOTAL_VS_END__IMD, 0);
> +		return;
> +	}

[Severity: High]
When VRR is disabled, this early return clears the IMD bit but skips
restoring the DSP_VTOTAL bits.

Because RK3568_VP_DSP_VTOTAL_VS_END is also used for normal base timing,
could leaving the DSP_VTOTAL field at its previous max_vtotal value corrupt
the base display timing and leave the refresh rate permanently stretched?

[ ... ]
> @@ -2029,6 +2049,11 @@ static void vop2_crtc_atomic_flush(struct drm_crtc=
 *crtc,
> =20
>  	spin_lock_irq(&crtc->dev->event_lock);
> =20
> +	if (crtc_state->vrr_enabled) {
> +		if (drm_crtc_helper_vrr_flush(crtc_state))
> +			vop2_vp_set_vrr_vtotal(vp, crtc_state->vrr_state.cur_vtotal);
> +	}

[Severity: High]
If userspace disables VRR, crtc_state->vrr_enabled will be false, and this
condition will skip calling drm_crtc_helper_vrr_flush().

Since drm_crtc_helper_vrr_flush() is designed to handle the !vrr_enabled ca=
se
and return a 0 vtotal to disable VRR in hardware, doesn't guarding it here
trap the display hardware in VRR mode?

> +
>  	if (crtc->state->event) {
>  		WARN_ON(drm_crtc_vblank_get(crtc));
[ ... ]
> @@ -2371,6 +2396,30 @@ static irqreturn_t rk3576_vp_isr(int irq, void *da=
ta)
>  	return ret;
>  }
> =20
> +static void vop2_vp_handle_vblank(struct vop2_video_port *vp)
> +{
> +	struct drm_crtc *crtc =3D &vp->crtc;
> +	struct vop2 *vop2 =3D vp->vop2;
> +	u32 val;
> +
> +	guard(spinlock)(&crtc->dev->event_lock);
> +
> +	if (!vp->event)
> +		return;

[Severity: High]
This early return bypasses the VRR vsync adjustment when no event is attach=
ed
to the commit.

If a compositor issues a commit without a vblank event (such as a cursor
update), drm_crtc_helper_vrr_flush() shrinks vtotal to base_vtotal, but the
subsequent vblank interrupt will hit this return and skip restoring the
hardware vtotal to max_vtotal.

Could this cause VRR frame stretching to fail for subsequent idle frames?

> +
> +	val =3D vop2_readl(vop2, RK3568_REG_CFG_DONE);
> +
> +	if (!(val & BIT(vp->id))) {
> +		drm_crtc_send_vblank_event(crtc, vp->event);
> +		vp->event =3D NULL;
> +		drm_crtc_vblank_put(crtc);
> +
> +		if (crtc->state->vrr_enabled)
> +			if (drm_crtc_helper_vrr_vsync(crtc->state))
> +				vop2_vp_set_vrr_vtotal(vp, crtc->state->vrr_state.cur_vtotal);

[Severity: High]
Similar to the logic in atomic_flush, preventing drm_crtc_helper_vrr_vsync()
from running when VRR is disabled might miss the transition update.

Is it intentional to skip the vsync helper when vrr_enabled is false?

> +	}
> +}
> +
>  static irqreturn_t vop2_isr(int irq, void *data)
>  {
>  	struct vop2 *vop2 =3D data;
> @@ -2402,18 +2451,7 @@ static irqreturn_t vop2_isr(int irq, void *data)
> =20
>  			if (irqs & VP_INT_FS_FIELD) {
>  				drm_crtc_handle_vblank(crtc);
> -				spin_lock(&crtc->dev->event_lock);
> -				if (vp->event) {
> -					u32 val =3D vop2_readl(vop2, RK3568_REG_CFG_DONE);
> -
> -					if (!(val & BIT(vp->id))) {
> -						drm_crtc_send_vblank_event(crtc, vp->event);
> -						vp->event =3D NULL;
> -						drm_crtc_vblank_put(crtc);
> -					}
> -				}
> -				spin_unlock(&crtc->dev->event_lock);
> -
> +				vop2_vp_handle_vblank(vp);
>  				ret =3D IRQ_HANDLED;
>  			}

[Severity: High]
This refactors vop2_isr() to use the new vop2_vp_handle_vblank() function
which includes the VRR updates.

Looking at rk3576_vp_isr() earlier in this file, it still uses the old inli=
ne
vblank event handling and was not updated to use vop2_vp_handle_vblank().

Does this mean VRR functionality is completely missing on RK3576 platforms,=
 as
the hardware will never stretch frames without the vsync helper?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921-vrr-limite=
r-uapi-v1-0-2fcd7d011646@collabora.com?part=3D11
