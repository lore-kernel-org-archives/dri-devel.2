Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83DDFC4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:28:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D581310F24C;
	Thu, 16 Jul 2026 09:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="c2nQjMbQ";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 96D0710F24C
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:28:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1AA61600B0;
 Thu, 16 Jul 2026 09:28:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8E0941F000E9;
 Thu, 16 Jul 2026 09:28:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784194102;
 bh=ox80bVAjERr9E6luimNbMz2v6ARzkJVHlZVI10y3Hm0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=c2nQjMbQsYUdE1Orbf0GsuHvHF1NMLAbiBCaLVl5gfqPLCjiltx5i3cGEosLHzjHy
 W9oAE/UWhCaZ0l0jsyjKDAyGLZIQ1w92e0W8c7CivZEmJOJztNcHJTM9OoJ0R22N3A
 +MnkWYH52HLPvwUAHxgyXtMRas6P2s2BC/bXkmU447bbezdVNOYJSI3Z8zeJiY60zf
 9dPiz5S1CQLNPM6xDZF4cTKyKYvHyLQcvZTuhCLd5Tm2K5l4394sdcnCcNrD/i3QlY
 Cn4RRmNiuO5V7sni3eq3OBOobt6Cm4cEBLyNzPdzS5txr3xRjsVZGEyJ1Vda7eCCKf
 NJdNclR7+gMcw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 8/8] drm/xen: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: dri-devel@lists.freedesktop.org, Frank.Li@kernel.org, imx@lists.linux.dev
In-Reply-To: <20260716-drm-simple-kms-removal-v2-8-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-8-1133a8fc3785@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:28:22 +0000
Message-Id: <20260716092822.8E0941F000E9@smtp.kernel.org>
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

New issues:
- [Critical] Global state data race in `atomic_enable` leading to a NULL po=
inter dereference.
- [High] Pending vblank events are leaked when the CRTC is disabled, causin=
g userspace to hang.

Pre-existing issues:
- [High] Global state data race in `atomic_update` causing stolen events an=
d userspace hangs.
--

--- Patch [8]: [PATCH v2 8/8] drm/xen: replace struct drm_simple_display_pi=
pe with regular atomic helpers ---
commit 545da3a98a8e32db9ed9bc44680620afafb3b601
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/xen: replace struct drm_simple_display_pipe with regular atomic helpers

Replace Xen frontend simple display pipe with explicit plane, CRTC and
encoder objects for each pipeline.

> diff --git a/drivers/gpu/drm/xen/xen_drm_front_kms.c b/drivers/gpu/drm/xe=
n/xen_drm_front_kms.c
> --- a/drivers/gpu/drm/xen/xen_drm_front_kms.c
> +++ b/drivers/gpu/drm/xen/xen_drm_front_kms.c
> @@ -105,24 +111,21 @@ static void send_pending_event(struct xen_drm_front=
_drm_pipeline *pipeline)
>  	spin_unlock_irqrestore(&dev->event_lock, flags);
>  }
> =20
> -static void display_enable(struct drm_simple_display_pipe *pipe,
> -			   struct drm_crtc_state *crtc_state,
> -			   struct drm_plane_state *plane_state)
> +static void xen_drm_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					      struct drm_atomic_commit *commit)
>  {
> -	struct xen_drm_front_drm_pipeline *pipeline =3D
> -			to_xen_drm_pipeline(pipe);
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> +	struct xen_drm_front_drm_pipeline *pipeline =3D xen_drm_pipeline_from_c=
rtc(crtc);
> +	struct drm_plane_state *plane_state =3D pipeline->plane.state;
> +	struct drm_framebuffer *fb =3D plane_state->fb;
>  	int ret, idx;
> =20
> -	if (!drm_dev_enter(pipe->crtc.dev, &idx))
> +	if (!drm_dev_enter(crtc->dev, &idx))
>  		return;
> =20
>  	ret =3D xen_drm_front_mode_set(pipeline, crtc->x, crtc->y,
>  				     fb->width, fb->height,

[Severity: Critical]
Can this sequence cause a NULL pointer dereference?

In xen_drm_crtc_helper_atomic_enable(), the global plane state is
read asynchronously and fb is dereferenced directly.

If userspace submits two non-blocking atomic commits rapidly (the
first enabling the CRTC and plane, and the second disabling the plane),
the global state pointer (pipeline->plane.state) is swapped
synchronously during the ioctl.

When the first commit's worker executes, it reads the newer state where
fb is NULL, and unconditionally dereferences fb->width.

Would it be safer to extract the state from the commit object using
drm_atomic_get_new_plane_state(commit, &pipeline->plane)?

>  				     fb->format->cpp[0] * 8,
>  				     xen_drm_front_fb_to_cookie(fb));
> -
>  	if (ret) {
>  		DRM_ERROR("Failed to enable display: %d\n", ret);

[ ... ]

> @@ -131,13 +134,13 @@ static void display_enable(struct drm_simple_displa=
y_pipe *pipe,
>  	drm_dev_exit(idx);
>  }
> =20
> -static void display_disable(struct drm_simple_display_pipe *pipe)
> +static void xen_drm_crtc_helper_atomic_disable(struct drm_crtc *crtc,
> +					       struct drm_atomic_commit *commit)
>  {
> -	struct xen_drm_front_drm_pipeline *pipeline =3D
> -			to_xen_drm_pipeline(pipe);
> +	struct xen_drm_front_drm_pipeline *pipeline =3D xen_drm_pipeline_from_c=
rtc(crtc);
>  	int ret =3D 0, idx;
> =20
> -	if (drm_dev_enter(pipe->crtc.dev, &idx)) {
> +	if (drm_dev_enter(crtc->dev, &idx)) {
>  		ret =3D xen_drm_front_mode_set(pipeline, 0, 0, 0, 0, 0,
>  					     xen_drm_front_fb_to_cookie(NULL));
>  		drm_dev_exit(idx);
> @@ -147,6 +150,11 @@ static void display_disable(struct drm_simple_displa=
y_pipe *pipe)
> =20
>  	/* Make sure we can restart with enabled connector next time */
>  	pipeline->conn_connected =3D true;
> +
> +	/* release stalled event if any */
> +	send_pending_event(pipeline);
> +}

[Severity: High]
Does this function leak the vblank event when the CRTC is disabled?

When moving away from drm_simple_kms_helper, the driver loses the core
helper's automatic consumption of crtc_state->event during CRTC
disable.

If userspace submits an atomic commit that disables the CRTC and
requests a vblank event (e.g., modeset to 0 or DPMS off),
xen_drm_crtc_helper_atomic_disable() completely omits the consumption and
signaling of the event.

This leaves the event dangling, which causes a kernel warning in the
commit tail and hangs the userspace compositor indefinitely as it waits
for the pageflip event.

Should this function pull and signal the event from
drm_atomic_get_new_crtc_state(commit, crtc)->event?

[ ... ]

> @@ -242,12 +261,12 @@ static int display_check(struct drm_simple_display_=
pipe *pipe,
>  	return 0;
>  }
> =20
> -static void display_update(struct drm_simple_display_pipe *pipe,
> -			   struct drm_plane_state *old_plane_state)
> +static void xen_drm_plane_helper_atomic_update(struct drm_plane *plane,
> +					       struct drm_atomic_commit *commit)
>  {
> -	struct xen_drm_front_drm_pipeline *pipeline =3D
> -			to_xen_drm_pipeline(pipe);
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(commit, plane);
> +	struct xen_drm_front_drm_pipeline *pipeline =3D xen_drm_pipeline_from_p=
lane(plane);
> +	struct drm_crtc *crtc =3D &pipeline->crtc;
>  	struct drm_pending_vblank_event *event;
>  	int idx;

[Severity: High]
This is a pre-existing issue, but can this code steal events from
future commits?

In xen_drm_plane_helper_atomic_update(), the global CRTC state's event
is accessed directly:

event =3D crtc->state->event;

Since crtc->state is swapped synchronously, it may reflect a future
commit's state by the time this worker runs. The worker would then steal
the future commit's event and clear it.

When the future commit's worker runs, it finds no event, while the
current commit's original event is stranded on its old state object and
never signaled, resulting in userspace hangs.

Should the event be fetched reliably from the specific commit object
using drm_atomic_get_new_crtc_state(commit, crtc)->event?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-drm-simple=
-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com?part=3D8
