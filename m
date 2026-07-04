Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73BBDC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:46:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D557E10E6C0;
	Sat,  4 Jul 2026 18:46:19 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="I2luS15r";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D7FA10E2DD
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:46:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6579A43B6C;
 Sat,  4 Jul 2026 18:46:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 117DE1F00A3A;
 Sat,  4 Jul 2026 18:46:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783190776;
 bh=9RODjiZc145hMmLkcMiBhvWF72gnoto2jsdSjEquu5I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=I2luS15rNSlmemYI8Kl6iHugv+TbN4DOhEaW2R20/YbImkCVFFHdGbcjtOFwaMF1C
 PsuEYcPydfjjrZuZUNVrqC1Hdj5cTs1PCpud0oUZN7kDjLQ15Ou4MQZzqqFwn6oIBE
 aH8Nk3Mcg+uHt6IsQHsuDDDQmjPXqZ271CrHCKfQ7MRrjT77F9dAKiPZT4yPplLkqh
 Wiy6YB+PLYJioUCtCS2CUzidXB9hWmwY8QFrZOHH7ZGYYSqY9c9sjuxYVCLinpeZsz
 hslgU3bHR16qkDmhDZbVsTxPYEme3IU4aHd6MdMESNl7D9FhAqORP70O3SF9M2SGCp
 PJuIPcmU2J6zg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 3/9] drm/imx: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, imx@lists.linux.dev, Frank.Li@kernel.org
In-Reply-To: <20260705-drm-simple-kms-removal-v1-3-b4e1ca053623@oss.qualcomm.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-3-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:46:15 +0000
Message-Id: <20260704184616.117DE1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

New issues:
- [High] CRTC disable operations fail unconditionally due to early mode val=
idation.
- [High] Plane atomic check rejects offline plane updates, breaking display=
 disabling.
- [High] Missing drm_crtc_vblank_on() and drm_crtc_vblank_off() calls break=
 vblank synchronization.
- [High] Missing .enable_vblank hook in drm_crtc_funcs causes kernel warnin=
gs and breaks vblank.

Pre-existing issues:
- [High] Racy direct state access in atomic callbacks leading to potential =
use-after-free.
- [High] Unbounded clock reference count leak on CRTC disable cycles.
--

commit 404ed5ff8b68b90a5ba44e0c6a32b76744948691
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/imx: replace struct drm_simple_display_pipe with regular atomic helpers

This commit converts the i.MX LCDC driver to use explicit primary plane,
CRTC, and encoder objects instead of the simple display pipe helpers. It
retains the no-scaling plane checks and GEM framebuffer prepare callbacks,
adjusting hardware state only when a framebuffer is present.

> diff --git a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c b/drivers/gpu/drm/imx/lc=
dc/imx-lcdc.c
> index c67fe80b8115e..f0c4c19f91166 100644
> --- a/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
> +++ b/drivers/gpu/drm/imx/lcdc/imx-lcdc.c
[ ... ]
> -static void imx_lcdc_update_hw_registers(struct drm_simple_display_pipe =
*pipe,
> +static void imx_lcdc_update_hw_registers(struct drm_crtc *crtc,
>  					 struct drm_plane_state *old_state,
>  					 bool mode_set)
>  {
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> -	struct drm_plane_state *new_state =3D pipe->plane.state;
> +	struct drm_plane_state *new_state =3D crtc->primary->state;

[Severity: High]
This is a pre-existing issue, but does this direct state access create a ra=
ce
condition?

In non-blocking atomic commits, the DRM core synchronously swaps these obje=
ct
pointers before the asynchronous worker executes. If multiple commits are
queued, we might retrieve the state for a future commit instead of the
current one, which could lead to programming hardware with an unpinned or
incorrect framebuffer.

[ ... ]
> @@ -230,34 +231,34 @@ static void imx_lcdc_pipe_enable(struct drm_simple_=
display_pipe *pipe,
[ ... ]
>  	imx_lcdc_update_hw_registers(crtc, NULL, true);
> =20
>  	/* Enable VBLANK Interrupt */
>  	writel(INTR_EOF, lcdc->base + IMX21LCDC_LIER);
>  }

[Severity: High]
Should drm_crtc_vblank_on() be called here?

Without notifying the DRM core that the hardware vblank interrupt is enable=
d,
the core might consider the vblank state as off. This causes vblank waits to
fail unconditionally, forcing the plane atomic update to immediately send p=
age
flip events to userspace rather than waiting for vsync.

[ ... ]
> -static void imx_lcdc_pipe_disable(struct drm_simple_display_pipe *pipe)
> +static void imx_lcdc_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +						struct drm_atomic_commit *state)
>  {
> -	struct imx_lcdc *lcdc =3D imx_lcdc_from_drmdev(pipe->crtc.dev);
> -	struct drm_crtc *crtc =3D &lcdc->pipe.crtc;
> +	struct imx_lcdc *lcdc =3D imx_lcdc_from_drmdev(crtc->dev);
>  	struct drm_pending_vblank_event *event;
> =20
>  	clk_disable_unprepare(lcdc->clk_ahb);
>  	clk_disable_unprepare(lcdc->clk_ipg);
> =20
> -	if (pipe->crtc.enabled)
> +	if (crtc->enabled)
>  		clk_disable_unprepare(lcdc->clk_per);

[Severity: High]
This is a pre-existing issue, but does this leak a clock reference?

The atomic_disable callback runs after the DRM core updates legacy state
variables, so crtc->enabled is guaranteed to be false here. This means the
clock might never be disabled during a DPMS cycle.

[ ... ]
>  	spin_unlock_irq(&lcdc->drm.event_lock);
> =20
>  	/* Disable VBLANK Interrupt */
>  	writel(0, lcdc->base + IMX21LCDC_LIER);
>  }

[Severity: High]
Is a call to drm_crtc_vblank_off() needed here to synchronously disable vbl=
ank
processing in the DRM core when shutting down the hardware interrupt?

[ ... ]
> -static int imx_lcdc_pipe_check(struct drm_simple_display_pipe *pipe,
> -			       struct drm_plane_state *plane_state,
> -			       struct drm_crtc_state *crtc_state)
> +static int imx_lcdc_crtc_helper_atomic_check(struct drm_crtc *crtc,
> +					     struct drm_atomic_commit *state)
>  {
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
>  	const struct drm_display_mode *mode =3D &crtc_state->mode;
> -	const struct drm_display_mode *old_mode =3D &pipe->crtc.state->mode;
> +	const struct drm_display_mode *old_mode =3D &crtc->state->mode;
> +	int ret;
> =20
>  	if (mode->hdisplay < LCDC_MIN_XRES || mode->hdisplay > LCDC_MAX_XRES ||
>  	    mode->vdisplay < LCDC_MIN_YRES || mode->vdisplay > LCDC_MAX_YRES ||
>  	    mode->hdisplay % 0x10) { /* must be multiple of 16 */

[Severity: High]
Will this cause CRTC disable operations to fail?

When userspace disables the CRTC (like via DPMS OFF), crtc_state->enable is
false and the display mode might be zeroed out. Validating the mode dimensi=
ons
before checking crtc_state->enable could cause this check to return -EINVAL
unconditionally.

[ ... ]
> -static void imx_lcdc_pipe_update(struct drm_simple_display_pipe *pipe,
> -				 struct drm_plane_state *old_state)
> +static void imx_lcdc_plane_helper_atomic_update(struct drm_plane *plane,
> +						struct drm_atomic_commit *state)
>  {
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> -	struct drm_pending_vblank_event *event =3D crtc->state->event;
> -	struct drm_plane_state *new_state =3D pipe->plane.state;
> +	struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_state(st=
ate, plane);
> +	struct drm_plane_state *new_state =3D plane->state;

[Severity: High]
This is a pre-existing issue, but does assigning new_state directly from
plane->state risk a race condition?

For non-blocking commits, fetching the new plane state from the
drm_atomic_commit object avoids reading state from a potentially concurrent
future commit.

[ ... ]
> +static int imx_lcdc_plane_helper_atomic_check(struct drm_plane *plane,
> +					      struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +	struct drm_crtc *crtc =3D plane_state->crtc;
> +	struct drm_crtc_state *crtc_state =3D NULL;
> +	int ret;
> +
> +	if (crtc)
> +		crtc_state =3D drm_atomic_get_new_crtc_state(state, crtc);
> +
> +	ret =3D drm_atomic_helper_check_plane_state(plane_state, crtc_state,
> +						  DRM_PLANE_NO_SCALING,
> +						  DRM_PLANE_NO_SCALING,
> +						  false, false);

[Severity: High]
Does passing false for the can_update_disabled parameter reject offline pla=
ne
updates?

If userspace tries to disable the CRTC without detaching the framebuffer, t=
he
helper will see a plane on a disabled CRTC and return -EINVAL, which breaks
display disabling.

[ ... ]
> +static const struct drm_crtc_funcs imx_lcdc_crtc_funcs =3D {
> +	.reset			=3D drm_atomic_helper_crtc_reset,
> +	.destroy		=3D drm_crtc_cleanup,
> +	.set_config		=3D drm_atomic_helper_set_config,
> +	.page_flip		=3D drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state	=3D drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state	=3D drm_atomic_helper_crtc_destroy_state,
> +};

[Severity: High]
Should this struct include implementations for .enable_vblank and
.disable_vblank?

When drm_vblank_get() is called to wait for vsync, the DRM core requires the
enable_vblank hook. Omitting these causes a kernel warning and makes the wa=
it
return -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-drm-simple=
-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com?part=3D3
