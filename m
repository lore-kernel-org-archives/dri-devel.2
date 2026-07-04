Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 43D6EC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:52:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 827DA10E07A;
	Sat,  4 Jul 2026 18:52:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EmVtg+tx";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 287BF10E07A
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:52:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id AC68843754;
 Sat,  4 Jul 2026 18:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 477A51F000E9;
 Sat,  4 Jul 2026 18:52:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783191170;
 bh=e8FalOy76n0dzL+wfRO0R9e3ZnYmOQZjh3kDi9wju7Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EmVtg+tx+gFrGfzqNk3/p7pvd+cckFcb6fwt/p2VsZzNQC4uci2JoyNmKejk3Ck5Y
 G6/tb2mk6FI4/vL6fUh5qMtjoGnY1kYQwtytRNcfxyw+1y4T+NgAIPbLkIFHect8jA
 V+0fNSbRq20yG5FbOKPkESU2URmuf62J6bknGR9ZGRWXKfnPj6XI68d/HgFGtpXa/U
 NjDOUvPJvV1lCXp7i4QArLnABZVQWbO7BUn1wfM1Dpng+l7Y9hVm+QL1uy3UTEmnGC
 lMMGWRI8bWoqxWz/fHUC1ZLdbTwaIEUU+UTbR5XU3Hc0XzRx5KPKLS/ypB2d3Ftj/Y
 o2VLseTBx/mEg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/9] drm/aspeed: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260705-drm-simple-kms-removal-v1-2-b4e1ca053623@oss.qualcomm.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-2-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:52:49 +0000
Message-Id: <20260704185250.477A51F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless access to global atomic state pointers in commit path cau=
ses TOCTOU races and potential NULL pointer dereferences.
- [High] CRTC vblank events are prematurely consumed in the plane's atomic_=
update callback.
--

commit 7172c80142608f5bf7d738f64624b3135c44fdba
Author: Ze Huang <ze.huang@oss.qualcomm.com>
Subject: drm/aspeed: replace struct drm_simple_display_pipe with regular at=
omic helpers

This patch replaces the simple display pipe in the aspeed DRM driver with
explicit plane, CRTC, and encoder objects. It removes the intermediate layer
and wires up the standard atomic helpers for modesetting and page flips.

> diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/a=
speed/aspeed_gfx_crtc.c
> index 7877a57b8e265..3294795c31c4c 100644
> --- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
> +++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c

[ ... ]

>  static int aspeed_gfx_set_pixel_fmt(struct aspeed_gfx *priv, u32 *bpp)
>  {
> -	struct drm_crtc *crtc =3D &priv->pipe.crtc;
> +	struct drm_crtc *crtc =3D &priv->crtc;
>  	struct drm_device *drm =3D crtc->dev;
>  	const u32 format =3D crtc->primary->state->fb->format->format;
>  	u32 ctrl1;

[Severity: High]
This is a pre-existing issue, but does this lockless access to the global
state pointers in aspeed_gfx_set_pixel_fmt risk a NULL pointer dereference =
or
TOCTOU race?

If a concurrent non-blocking atomic commit disables the primary plane while
this runs in a worker thread, the global state could be swapped, potentially
making the framebuffer pointer NULL.

Would it be safer to extract the commit-specific state using the atomic
helpers instead of reading directly from crtc->primary->state->fb?

[ ... ]

>  static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
>  {
> -	struct drm_display_mode *m =3D &priv->pipe.crtc.state->adjusted_mode;
> +	struct drm_display_mode *m =3D &priv->crtc.state->adjusted_mode;
>  	u32 ctrl1, d_offset, t_count, bpp;
>  	int err;

[Severity: High]
This is also a pre-existing issue carried over during the conversion, but c=
an
reading directly from the global crtc.state cause a similar TOCTOU race?

Reading the adjusted_mode directly from the global state pointer bypasses t=
he
atomic commit's local state. Could this function be updated to use the local
state passed to the atomic hooks?

[ ... ]

> -static void aspeed_gfx_pipe_update(struct drm_simple_display_pipe *pipe,
> -				   struct drm_plane_state *plane_state)
> +static void aspeed_gfx_plane_helper_atomic_update(struct drm_plane *plan=
e,
> +						  struct drm_atomic_commit *state)
>  {
> -	struct aspeed_gfx *priv =3D drm_pipe_to_aspeed_gfx(pipe);
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> -	struct drm_framebuffer *fb =3D pipe->plane.state->fb;
> +	struct aspeed_gfx *priv =3D container_of(plane, struct aspeed_gfx, plan=
e);
> +	struct drm_crtc *crtc =3D &priv->crtc;
> +	struct drm_framebuffer *fb =3D plane->state->fb;
>  	struct drm_pending_vblank_event *event;
>  	struct drm_gem_dma_object *gem;

[Severity: High]
This is a pre-existing issue, but does consuming the vblank event directly =
in
the plane update phase risk premature signaling?

Looking at aspeed_gfx_plane_helper_atomic_update, the driver steals the eve=
nt
from the global state (crtc->state->event) before the CRTC is fully enabled
and programmed.=20

Could userspace prematurely free or overwrite the framebuffer while the
hardware is still scanning it out due to this early signaling?=20

Would it be more appropriate to handle the event in an atomic_flush hook
where standard atomic flush mechanisms can ensure hardware changes are fully
complete?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-drm-simple=
-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com?part=3D2
