Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6291FC4450E
	for <dri-devel@archiver.kernel.org>; Thu, 16 Jul 2026 09:15:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11E9210E752;
	Thu, 16 Jul 2026 09:15:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mkxR4kr1";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E3E3D10E318
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Jul 2026 09:15:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 9EFAC432FC;
 Thu, 16 Jul 2026 09:15:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E55091F00A3A;
 Thu, 16 Jul 2026 09:14:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1784193300;
 bh=beDs4q6LIP/ICO3PEO+bqt4Qyqd6MpXFAZiNd6b6t/c=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mkxR4kr166Ksbc5iS8CmyorZnmGNJcr37iSb0vlGnoVkxrLVZ1XCTx3t6qIxhYZTD
 w4ndDTBYrgsBGagyLOKONz/b4ilIFurICWidObcKsSezM3PEM/jVP3OZMYIPJZ/UdK
 fAmciQVIMA7wKl/TjQyDoMU9hkXN+AciFoyx3Lb2tj+Bcd4kdslvseJLYYhiAY2sld
 sAT3YbHYxk77hu7ZiLLWhzvrWsxXRIWYn8uUX9QtvMtK8O/p+olbkT3q4p8gMDZSEs
 +tAl+1Ty+xCdQbZkx60gJksWtTsW04lbXgoeFbfqHZjyWx2HMHTq5cmGnXGa/W1Ku7
 DIMaFXW8LmCLQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 5/8] drm/gm12u320: replace struct
 drm_simple_display_pipe with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: imx@lists.linux.dev, dri-devel@lists.freedesktop.org, Frank.Li@kernel.org
In-Reply-To: <20260716-drm-simple-kms-removal-v2-5-1133a8fc3785@oss.qualcomm.com>
References: <20260716-drm-simple-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com>
 <20260716-drm-simple-kms-removal-v2-5-1133a8fc3785@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 09:14:59 +0000
Message-Id: <20260716091459.E55091F00A3A@smtp.kernel.org>
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
- [High] Time-of-Check to Time-of-Use (TOCTOU) race condition causing a NUL=
L pointer dereference when accessing the global `plane.state`.
--

--- Patch [5]: [PATCH v2 5/8] drm/gm12u320: replace struct drm_simple_displ=
ay_pipe with regular atomic helpers ---
commit cb5be3218f14cd65e9bd1d82ce85f0bd23c4cc07
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/gm12u320: replace struct drm_simple_display_pipe with regular atomic he=
lpers

Convert gm12u320 to direct primary plane, CRTC and encoder setup, while
keeping shadow-plane helper state and framebuffer access helpers.

> diff --git a/drivers/gpu/drm/tiny/gm12u320.c b/drivers/gpu/drm/tiny/gm12u=
320.c
> index 4ad074337af07..0fc251f07e247 100644
> --- a/drivers/gpu/drm/tiny/gm12u320.c
> +++ b/drivers/gpu/drm/tiny/gm12u320.c

[ ... ]

> @@ -555,43 +560,104 @@ static int gm12u320_conn_init(struct gm12u320_devi=
ce *gm12u320)
>  }
> =20
>  /* ------------------------------------------------------------------ */
> -/* gm12u320 (simple) display pipe				      */
> +/* gm12u320 display pipe					      */
> =20
> -static void gm12u320_pipe_enable(struct drm_simple_display_pipe *pipe,
> -				 struct drm_crtc_state *crtc_state,
> -				 struct drm_plane_state *plane_state)
> +static void gm12u320_crtc_helper_atomic_enable(struct drm_crtc *crtc,
> +					       struct drm_atomic_commit *commit)
>  {
>  	struct drm_rect rect =3D { 0, 0, GM12U320_USER_WIDTH, GM12U320_HEIGHT };
> -	struct gm12u320_device *gm12u320 =3D to_gm12u320(pipe->crtc.dev);
> +	struct gm12u320_device *gm12u320 =3D to_gm12u320(crtc->dev);
> +	struct drm_plane_state *plane_state =3D gm12u320->plane.state;

[Severity: High]
Could this lead to a NULL pointer dereference if a concurrent atomic commit
modifies the state?

When gm12u320_crtc_helper_atomic_enable() reads the global
gm12u320->plane.state directly instead of extracting the stable plane state
from the atomic commit context (such as by using
drm_atomic_get_new_plane_state(commit, &gm12u320->plane)), it appears to
expose a race condition.

If a non-blocking commit is immediately followed by a blocking disable
commit, the plane's fb pointer might become NULL before this worker
has a chance to execute.=20

Passing this NULL fb into gm12u320_fb_mark_dirty() would then cause a panic
when the function unconditionally dereferences fb->dev.

> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(plane_state);
> =20
>  	gm12u320->fb_update.draw_status_timeout =3D FIRST_FRAME_TIMEOUT;
>  	gm12u320_fb_mark_dirty(plane_state->fb, &shadow_plane_state->data[0], &=
rect);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716-drm-simple=
-kms-removal-v2-0-1133a8fc3785@oss.qualcomm.com?part=3D5
