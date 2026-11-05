Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4AB33606A328
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 17:40:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EEyhxOtn
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A528710E32C;
	Thu,  5 Nov 2026 17:40:16 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BA3C10E32C
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 17:40:10 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id DFA7E40303;
 Thu,  5 Nov 2026 17:40:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7E131F000C1;
 Thu,  5 Nov 2026 17:40:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793900409;
 bh=eVjK4SMiqXBSliB7Lio+T4A9UWE3c+S1/kg/9xOjcno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EEyhxOtnunLySyreFAZTXYWsX8kI7nnZRiJSCHrgnBpRblzpZFqsRbTfmjxABp7Fb
 UdtiMKJPpoDxgGG35yPt8H4cslA0+M/900Q8EZPWbrQHSh1E2P9/tFOzroLxXmtFri
 BTdh5dRjSYFdHz7qiaQ7aXumTH26JxrMkmFKcJ+7v6zy44KkCCzGufEGGeF8Ebv8Jk
 Wyu+LcvfP5P2ShIxfidkKFosV2tR/YuunbObPQbPYwNXvX3ylqrL+LoqCOL8hOi7Px
 yTUF+WebYh0JRzNfTXRMX1Perj3Sj9SNyCYBL6h1h7+DeQBad7ofsyj6QXxJ6cRcCs
 TGyIvAuV9y1DQ==
Message-ID: <sashiko-outbox-199648@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 14/27] drm/rockchip: vop2: Enable VRR
To: "Nicolas Frattaroli" <nicolas.frattaroli@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261105-vrr-limiter-uapi-v2-14-55f4215be2c2@collabora.com>
References: <20261105-vrr-limiter-uapi-v2-0-55f4215be2c2@collabora.com>
 <20261105-vrr-limiter-uapi-v2-14-55f4215be2c2@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 17:40:09 +0000
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm/rockchip: vop2: vop2_vp_handle_vblank() skips VRR vsync withou=
t vp->event
- [High] drm/rockchip: vop2: vrr_enabled guards prevent VRR state reset and=
 modeset sync
- [High] drm/rockchip: vop2: missing VRR state validation in vop2_crtc_atom=
ic_check()
- [Medium] drm/rockchip: vop2: rk3576_vp_isr() omits vop2_vp_handle_vblank(=
) refactoring
- [Medium] drm/rockchip: vop2: race on vrr_state across crtc->state duplica=
tion and swap
- [Medium] drm/rockchip: vop2: vop2_crtc_atomic_flush() clears VRR vblank I=
RQ
--

commit fd4256e3d8d21803c823cd3f851049669be3d956
Author: Nicolas Frattaroli <nicolas.frattaroli@collabora.com>

drm/rockchip: vop2: Enable VRR

This commit enables Variable Refresh Rate (VRR) front porch adjustment on
Rockchip VOP2 using DRM CRTC VRR state tracking helpers, refactored vblank
event handling, and VRR limiter properties on RK3588 video ports.

> diff --git a/drivers/gpu/drm/rockchip/rockchip_drm_vop2.c b/drivers/gpu/d=
rm/rockchip/rockchip_drm_vop2.c
> index bfb3841425687..d93b490257952 100644
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
> +
> +	/* Value is 13 bits at most, saturate it if too large */
> +	if (vtotal > RK3568_VP_DSP_VTOTAL_VS_END__DSP_VTOTAL >> 16)
> +		vtotal =3D RK3568_VP_DSP_VTOTAL_VS_END__DSP_VTOTAL >> 16;
> +
> +	vop2_vp_update_bits(vp, RK3568_VP_DSP_VTOTAL_VS_END, mask,
> +			    vtotal << 16 | RK3568_VP_DSP_VTOTAL_VS_END__IMD);
> +}
> +
>  static void vop2_crtc_atomic_flush(struct drm_crtc *crtc,
>  				   struct drm_atomic_commit *state)
>  {
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
As reported by Sashiko on RFC [1], does guarding drm_crtc_helper_vrr_flush()
and drm_crtc_helper_vrr_vsync() with vrr_enabled prevent the VRR state from
being reset when VRR is disabled?

Both drm_crtc_helper_vrr_flush() and drm_crtc_helper_vrr_vsync() have
!crtc_state->vrr_enabled branches that reset vrr->cur_vtotal =3D 0 (and
vrr->cur_err =3D 0 in vsync) and return true so vop2_vp_set_vrr_vtotal() can
take its !vtotal branch and clear RK3568_VP_DSP_VTOTAL_VS_END__IMD.

Because both vop2_crtc_atomic_flush() and vop2_vp_handle_vblank() check
vrr_enabled before calling those helpers, the reset paths and the !vtotal
branch in vop2_vp_set_vrr_vtotal() are never reached.

Furthermore, vop2_crtc_duplicate_state() copies rockchip_crtc_state via
kmemdup(), preserving any stale vrr_state.cur_vtotal across a modeset or
VRR disable/re-enable cycle. When vop2_crtc_atomic_enable() writes
mode->crtc_vtotal << 16 | vsync_len (with IMD =3D 0) to
RK3568_VP_DSP_VTOTAL_VS_END, a stale cur_vtotal that already equals
base_vtotal causes drm_crtc_helper_vrr_flush() (and
drm_crtc_helper_vrr_vsync() in integer fixed-rate mode) to see no change and
return false, leaving hardware running at mode->crtc_vtotal with IMD cleare=
d.

> +
>  	if (crtc->state->event) {
>  		WARN_ON(drm_crtc_vblank_get(crtc));
>  		vp->event =3D crtc->state->event;

[Severity: Medium]
Can calling vop2_vp_set_vrr_vtotal() before drm_crtc_vblank_get() in
vop2_crtc_atomic_flush() lose the vblank interrupt for a VRR page flip?

If the vblank disable timer has expired during an idle period while the vid=
eo
port is scanning out in the extended VRR front porch (at max_vtotal),
VP_INT_FS_FIELD is masked in RK3568_VP_INT_EN(vp->id).

When vop2_crtc_atomic_flush() then runs:

vop2_crtc_atomic_flush()
  vop2_vp_set_vrr_vtotal()
    /* writes base_vtotal with RK3568_VP_DSP_VTOTAL_VS_END__IMD */
  drm_crtc_vblank_get()
    vop2_crtc_enable_vblank()
      vop2_crtc_enable_irq(vp, VP_INT_FS_FIELD)
        vop2_writel(vop2, RK3568_VP_INT_CLR(vp->id), irq << 16 | irq);
        vop2_writel(vop2, RK3568_VP_INT_EN(vp->id), irq << 16 | irq);

Reducing DSP_VTOTAL to base_vtotal with the immediate bit set can end the
current frame immediately in hardware and assert VP_INT_FS_FIELD before
drm_crtc_vblank_get() is called. vop2_crtc_enable_irq() then clears
RK3568_VP_INT_CLR(vp->id) before unmasking the interrupt, dropping the
pending vblank IRQ and delaying vp->event and drm_crtc_helper_vrr_vsync()
by a full frame.

> @@ -2371,6 +2396,30 @@ static irqreturn_t rk3576_vp_isr(int irq, void *da=
ta)
>  	return ret;
>  }

[Severity: Medium]
As reported by Sashiko on RFC [2], should rk3576_vp_isr() also call
vop2_vp_handle_vblank(vp) instead of keeping the open-coded vblank event
handling block?

In drivers/gpu/drm/rockchip/rockchip_drm_vop2.c:rk3576_vp_isr():

	if (irqs & VP_INT_FS_FIELD) {
		drm_crtc_handle_vblank(crtc);
		spin_lock(&crtc->dev->event_lock);
		if (vp->event) {
			u32 val =3D vop2_readl(vop2, RK3568_REG_CFG_DONE);

			if (!(val & BIT(vp->id))) {
				drm_crtc_send_vblank_event(crtc, vp->event);
				vp->event =3D NULL;
				drm_crtc_vblank_put(crtc);
			}
		}
		spin_unlock(&crtc->dev->event_lock);

		ret =3D IRQ_HANDLED;
	}

vop2_isr() only handles video port interrupts for vop2->version <
VOP_VERSION_RK3576, while rk3576_vp_isr() still duplicates the old event
handling without calling vop2_vp_handle_vblank(vp).

> +
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
As reported by Sashiko on RFC [3], what happens to VRR timing when a vblank
occurs without a pending vp->event?

In vop2_vp_handle_vblank(), returning early when !vp->event (and dropping t=
he
vblank reference via drm_crtc_vblank_put() as soon as vp->event is sent)
means drm_crtc_helper_vrr_vsync() is only ever called on vblanks that compl=
ete
a page-flip event:

1. In dynamic VRR mode, if an atomic commit without DRM_MODE_PAGE_FLIP_EVENT
   (such as a synchronous commit or cursor update) runs,
   vop2_crtc_atomic_flush() calls drm_crtc_helper_vrr_flush() and shrinks
   cur_vtotal and RK3568_VP_DSP_VTOTAL_VS_END to base_vtotal. Because
   vp->event is NULL, vop2_vp_handle_vblank() returns early on the following
   vblank without calling drm_crtc_helper_vrr_vsync(), leaving the display
   stuck at base_vtotal instead of stretching back to max_vtotal.

2. In fixed-rate VRR mode (enabled via vrr_limiter_capable on RK3588),
   drm_crtc_helper_vrr_flush() always returns false and relies on
   drm_crtc_helper_vrr_vsync() running on every vblank to dither cur_vtotal
   between base_vtotal and base_vtotal + 1 and accumulate cur_err. Whenever
   no page-flip event is pending (or if VRR is enabled without requesting a
   page-flip event), vop2_vp_handle_vblank() returns early and fixed-rate V=
RR
   updates stop completely.

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
> +	}
> +}

[Severity: Medium]
Can mutating crtc->state->vrr_state in vop2_crtc_atomic_flush() and
vop2_vp_handle_vblank() race with state duplication and swap in a subsequent
atomic commit?

vop2_crtc_duplicate_state() copies crtc->state via kmemdup() under
crtc->mutex without holding crtc->dev->event_lock and before
drm_atomic_helper_setup_commit() runs:

drm_mode_atomic_ioctl()
  drm_atomic_get_crtc_state()
    vop2_crtc_duplicate_state()
      kmemdup(to_rockchip_crtc_state(crtc->state), ...)

If a new commit duplicates crtc->state after the previous commit's
vop2_crtc_atomic_flush() set cur_vtotal =3D base_vtotal, but before
vop2_vp_handle_vblank() runs drm_crtc_helper_vrr_vsync() and sets
cur_vtotal =3D max_vtotal (and programs max_vtotal into
RK3568_VP_DSP_VTOTAL_VS_END), the duplicated new_crtc_state retains
cur_vtotal =3D=3D base_vtotal and stale cur_err.

When drm_atomic_helper_swap_state() later installs that new_crtc_state as
crtc->state and vop2_crtc_atomic_flush() runs for the new commit,
drm_crtc_helper_vrr_flush() sees vrr->cur_vtotal =3D=3D vrr->base_vtotal and
returns false, skipping vop2_vp_set_vrr_vtotal() while the hardware register
is still programmed to max_vtotal from the previous vblank ISR.

[ ... ]

> @@ -2635,6 +2673,9 @@ static int vop2_create_crtcs(struct vop2 *vop2)
> =20
>  		drm_crtc_attach_background_color_property(&vp->crtc);
> =20
> +		if (vp->data->vrr_limiter_capable)
> +			drm_crtc_attach_vrr_limiter_properties(&vp->crtc);

[Severity: High]
What prevents userspace from enabling VRR or changing VRR limiter properties
on a CRTC when crtc_state->vrr_state has not been validated and populated?

__drm_crtc_init_with_planes() attaches VRR_ENABLED to every atomic CRTC, and
vop2_create_crtcs() attaches the VRR limiter properties to all four RK3588
video ports regardless of the connected encoder/connector type (for example
eDP, DP, MIPI DSI, or DPI on VP3). However, crtc_state->vrr_state
(base_vtotal, max_vtotal, denom, per_frame_err) is only validated and
populated by hdmi_validate_vrr() inside drm_atomic_helper_connector_hdmi_ch=
eck()
when an HDMI connector is part of the atomic state.

Neither vop2_crtc_atomic_check() nor rockchip_drm_atomic_check() checks
whether the video port and connector support VRR or whether vrr_state was
populated, and rockchip_drm_atomic_check() does not add affected connectors
when the CRTC VRR limiter properties change while vrr_enabled is already tr=
ue:

1. If userspace enables fixed-rate VRR (vrr_min =3D=3D vrr_max !=3D 0) on a
   non-HDMI connector on RK3588, vrr_state.base_vtotal and vrr_state.denom
   remain 0. In vop2_vp_handle_vblank(), drm_crtc_helper_vrr_vsync() then
   evaluates vrr->cur_err >=3D (int)(vrr->denom / 2) (0 >=3D 0), sets
   vrr->cur_vtotal =3D vrr->base_vtotal + 1 (1), and calls
   vop2_vp_set_vrr_vtotal(vp, 1), programming DSP_VTOTAL =3D 1 into
   RK3568_VP_DSP_VTOTAL_VS_END.

2. If userspace updates the VRR limiter properties on an HDMI CRTC while
   vrr_enabled is already true without a modeset, the connector is not added
   to the atomic state, bypassing hdmi_validate_vrr() and VTEM infoframe
   updates.

[1] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-11-2fcd7d011646@=
collabora.com
[2] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-11-2fcd7d011646@=
collabora.com
[3] https://lore.kernel.org/r/20260921-vrr-limiter-uapi-v1-11-2fcd7d011646@=
collabora.com

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105-vrr-limite=
r-uapi-v2-0-55f4215be2c2@collabora.com?part=3D14
