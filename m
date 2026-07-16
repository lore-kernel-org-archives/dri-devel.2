Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2A7B5C4450A
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:21:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8BA6610F24A;
	Thu, 16 Jul 2026 09:21:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="DjLLtH8Q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF63910F24A
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:21:11 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 25F92600BB;
 Thu, 16 Jul 2026 09:21:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A755F1F00A3A;
 Thu, 16 Jul 2026 09:21:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784193670;
 bh=B58Km/DKdFbZCCahpnlAGIeIC6FNei/VJUvEQJSabnY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=DjLLtH8QsivXomVKqQ9naBL1H9/XJ8lTfls07i0Bg/nu2dz+gwejiqolUCGIlD5cR
 iCk5pqpTQgzazZhO4ZyqPcei0nUE3Pw4QmGYWiWXBJ4U/A+iIVNo4aaXhODZfxN+lp
 +xNkW2dVi40iCBQwR/DVbPcAoMcVjrliUViAXSk3+e4R7NxNWk7HsKKwjVmTqB+agQ
 XEhDxSiOCST8m1vFJ0FvBFHVODuORPip/2vQN56rCom35QjkfK/wSIbMJQrkOjd+zf
 F09RGk10JKSEKVBZhswGhowe93gLkecZu7N6mB3GwsKrAs48CBY07Dgqs7qR8Rw37q
 I4Ffv2SY7iJRg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/8] drm/mcde: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260716-drm-simple-kms-removal-v2-3-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-3-1133a8fc3785@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:21:09 +0000
Message-Id: <20260716092109.A755F1F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Race condition in atomic commit causing display hang in oneshot mo=
de due to premature hardware start.
--

--- Patch [3]: [PATCH v2 3/8] drm/mcde: replace struct drm_simple_display_p=
ipe with regular atomic helpers ---
commit 24a767bb6a2c4adfefe9e0a5de7e9c8bbe7b2a64
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/mcde: replace struct drm_simple_display_pipe with regular atomic helpers

Convert MCDE to explicit plane, CRTC and encoder objects. Handle pending
page-flip events from the CRTC atomic flush path using the commit-local
CRTC state.

> diff --git a/drivers/gpu/drm/mcde/mcde_display.c b/drivers/gpu/drm/mcde/m=
cde_display.c
> index 257a6e84dd583..86edf94c52372 100644
> --- a/drivers/gpu/drm/mcde/mcde_display.c
> +++ b/drivers/gpu/drm/mcde/mcde_display.c
[ ... ]
> @@ -1381,44 +1398,13 @@ static void mcde_set_extsrc(struct mcde *mcde, u3=
2 buffer_address)
> -static void mcde_display_update(struct drm_simple_display_pipe *pipe,
> -				struct drm_plane_state *old_pstate)
> +static void mcde_plane_helper_atomic_update(struct drm_plane *plane,
> +					    struct drm_atomic_commit *commit)
>  {
> -	struct drm_crtc *crtc =3D &pipe->crtc;
> -	struct drm_device *drm =3D crtc->dev;
> -	struct mcde *mcde =3D to_mcde(drm);
> -	struct drm_pending_vblank_event *event =3D crtc->state->event;
> -	struct drm_plane *plane =3D &pipe->plane;
> -	struct drm_plane_state *pstate =3D plane->state;
> +	struct drm_plane_state *pstate =3D drm_atomic_get_new_plane_state(commi=
t, plane);
> +	struct mcde *mcde =3D to_mcde(plane->dev);
>  	struct drm_framebuffer *fb =3D pstate->fb;
> =20
> -	/*
> -	 * Handle any pending event first, we need to arm the vblank
> -	 * interrupt before sending any update to the display so we don't
> -	 * miss the interrupt.
> -	 */
> -	if (event) {
[ ... ]
> -		spin_unlock_irq(&crtc->dev->event_lock);
> -	}
> -
>  	/*
>  	 * We do not start sending framebuffer updates before the
>  	 * display is enabled. Update events will however be dispatched
[ ... ]
> -static int mcde_display_enable_vblank(struct drm_simple_display_pipe *pi=
pe)
> +static void mcde_crtc_helper_atomic_flush(struct drm_crtc *crtc,
> +					  struct drm_atomic_commit *commit)
> +{
> +	struct drm_crtc_state *crtc_state =3D drm_atomic_get_new_crtc_state(com=
mit, crtc);
> +	struct drm_pending_vblank_event *event =3D crtc_state->event;
> +
> +	/*
> +	 * Handle any pending event first, we need to arm the vblank
> +	 * interrupt before sending any update to the display so we don't
> +	 * miss the interrupt.
> +	 */
> +	if (!event)
> +		return;

[Severity: High]
Does this split introduce a race condition that could hang the pipeline in
oneshot mode?

Because the DRM core executes the plane's atomic_update callback before the
CRTC's atomic_flush callback, the hardware flow is now started before the
vblank event is armed.

If mcde_start_flow() is triggered during mcde_plane_helper_atomic_update()
(which happens just below the quoted block), it could complete the hardware
transfer and fire its interrupt before the vblank event gets armed later in
mcde_crtc_helper_atomic_flush().

The relocated comment in atomic_flush still notes this exact requirement:
"we need to arm the vblank interrupt before sending any update to the
display so we don't miss the interrupt."

If the interrupt fires early in oneshot mode, it will be missed, and the
atomic commit could wait indefinitely for an event that will never complete.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-drm-simple=
-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com?part=3D3
