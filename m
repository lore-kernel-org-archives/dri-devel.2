Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2128EC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:45:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 82C8510E2C8;
	Sat,  4 Jul 2026 18:45:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kpfewIH9";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0372210E2C8
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:45:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 6C36360052;
 Sat,  4 Jul 2026 18:45:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E20261F000E9;
 Sat,  4 Jul 2026 18:45:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783190739;
 bh=U0rJZII0EG7rFWT/8EXCPNC9YJ4bC3NYPkP/MvwoJ9Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kpfewIH9PRa4Ew4eOnR+7vNQc59AaJPDR/Vsbu5oZcEeIhXG5iVogfEBY1Lic0Kxw
 CYJ94/6GHNy6NHBET6C/HxPuVIsSy1kC3u3jbC8c4FQCgfskby4MhArG0h8yXRGiY2
 vB29peihBZ3cK6bnCCnAKb8Uj89X4+nKB33EOygGzARH0uCOyWnNmAC9e2KIuCbrFb
 Hmmf6YwvVHyemQuYgnVmqvWA7+R8OHAQ4ceiRPIfTcQvAIcbRNsW7mMJKTZNSiASd5
 m9fPXJtaRzdTYSCcTKxtPOHv1ZPpIneXdIgf06fAeBxVoepCalXDbQlgjXiwhX1DTN
 HBIipulfLgcEA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/9] drm/gm12u320: replace struct
 drm_simple_display_pipe with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, imx@lists.linux.dev, dri-devel@lists.freedesktop.org
In-Reply-To: <20260705-drm-simple-kms-removal-v1-6-b4e1ca053623@oss.qualcomm.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-6-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:45:38 +0000
Message-Id: <20260704184538.E20261F000E9@smtp.kernel.org>
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

New issues:
- [High] Race condition and potential NULL pointer dereference due to direc=
t access to `plane->state` and missing visibility checks in atomic callback=
s.

Pre-existing issues:
- [High] Sleeping in atomic context within CRTC and plane atomic callbacks.
--

commit a10b3d5781e3b7143f432c86643ef47e8ddc3a9a
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/gm12u320: replace struct drm_simple_display_pipe with regular atomic he=
lpers

Convert gm12u320 to direct primary plane, CRTC and encoder setup.
Keep shadow-plane helper state, framebuffer access helpers and
no-scaling plane-state check from simple-KMS path.

> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u=
320.c
> index 4ad074337af07..b476793d0401e 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c

[ ... ]

> +static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					       struct drm_atomic_commit *commit)
>  {
>  	struct drm_rect rect =3D { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
> -	struct gm12u320_device *gm12u320 =3D to_gm12u320(pipe->crtc.dev);
> +	struct gm12u320_device *gm12u320 =3D to_gm12u320(crtc->dev);
> +	struct drm_plane_state *plane_state =3D crtc->primary->state;

[Severity: High]
Will this cause a NULL pointer dereference if a subsequent commit disables
the plane?

Because non-blocking commits execute asynchronously, crtc->primary->state
reflects the state of the most recently queued commit, rather than the
commit currently executing. If a fast subsequent commit disables the plane,
plane_state->fb could be NULL.

Should this use drm_atomic_get_new_plane_state(commit, crtc->primary) to
get the state tied to this specific commit?

>  	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(plane_state);
> =20
>  	gm12u320->fb_update.draw_status_timeout =3D FIRST_FRAME_TIMEOUT;
>  	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &=
rect);
>  }
> =20
> -static void gm12u320_pipe_disable(struct drm_simple_display_pipe *pipe)
> +static void gm12u320_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +						struct drm_atomic_commit *commit)
>  {
> -	struct gm12u320_device *gm12u320 =3D to_gm12u320(pipe->crtc.dev);
> +	struct gm12u320_device *gm12u320 =3D to_gm12u320(crtc->dev);
> =20
>  	gm12u320_stop_fb_update(gm12u320);

[Severity: High]
This isn't a bug introduced by this patch, but does gm12u320_stop_fb_update=
()
sleep in atomic context?

gm12u320_stop_fb_update() calls cancel_delayed_work_sync() and mutex_lock().
Since CRTC atomic disable callbacks can run in atomic context during
non-blocking commits, sleeping here is forbidden and could cause kernel
warnings or deadlocks.

>  }
> =20
> -static void gm12u320_pipe_update(struct drm_simple_display_pipe *pipe,
> -				 struct drm_plane_state *old_state)
> +static void gm12u320_plane_helper_atomic_update(struct drm_plane *plane,
> +						struct drm_atomic_commit *commit)
>  {
> -	struct drm_plane_state *state =3D pipe->plane.state;
> +	struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_state(co=
mmit, plane);
> +	struct drm_plane_state *state =3D plane->state;

[Severity: High]
Could accessing plane->state directly here lead to a crash?

Similar to the CRTC enable function, reading plane->state directly instead =
of
using drm_atomic_get_new_plane_state(commit, plane) accesses the future
state.

If a subsequent commit disables the plane, state->fb will be NULL. In this
scenario, drm_atomic_helper_damage_merged() returns true for plane
disablements, leading to gm12u320_fb_mark_dirty() being called with a NULL
fb, which will oops when trying to dereference fb->dev.

This wasn't possible before because the drm_simple_kms_helper explicitly
checked if (!plane->state->visible) before calling the update hook, but
that protection is dropped in this conversion.

> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(state);
>  	struct drm_rect rect;
> =20
> -	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
> +	if (drm_atomic_helper_damage_merged(old_state, state, &rect))
>  		gm12u320_fb_mark_dirty(state->fb, &shadow_plane_state->data[0], &rect);

[Severity: High]
This is a pre-existing issue, but does gm12u320_fb_mark_dirty() sleep in
atomic context?

It calls mutex_lock(&gm12u320->fb_update.lock), which is unsafe to call
from a plane update callback during non-blocking commits, as these run
in atomic context.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-drm-simple=
-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com?part=3D6
