Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBFB9C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 18:43:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EC6FB10E0CC;
	Sat,  4 Jul 2026 18:43:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="S+UNCVPL";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EBC1510E0CC
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 18:43:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0456B60052;
 Sat,  4 Jul 2026 18:43:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6567A1F000E9;
 Sat,  4 Jul 2026 18:43:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783190584;
 bh=Z9ORjIX2/EqdpQwJAVYAW/eO0/SguTcqo8LPnRWzmN0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=S+UNCVPLiUQNscHgV1L7BbncmOVVNBeIhbj8uoQM88x7WuQu+Sya8FoTRlSL2XxK7
 bSz5JZ2QbVf2GTY/ea3MXV/3evSB4S+drl5VOpjgjmVwEboIjywBG4DrdQwS7rk4Ow
 WaHLUNLtksV/MjZHoIpx0glbJElb9bSbHjqR8XjJwQjuB5A4txY9gFRrI7uPMqdHpw
 /Io+z7Zb98Uu62W+9XzkcVvYIhAjPNTlDu29n8jS38rgIW8xw4ZZLbouv5NbaWzwIO
 SPVDR4FfKSNhfu4uhxYUkPa5f4t9sOyk+CuZ9spRTPxqGuqJHphijMFEwqrkDDDygV
 EEZ1An+1inhtA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/9] drm/arcpgu: replace struct drm_simple_display_pipe
 with regular atomic helpers
To: "Ze Huang" <ze.huang@oss.qualcomm.com>
Cc: Frank.Li@kernel.org, dri-devel@lists.freedesktop.org, imx@lists.linux.dev
In-Reply-To: <20260705-drm-simple-kms-removal-v1-1-b4e1ca053623@oss.qualcomm.com>
References: <20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com>
 <20260705-drm-simple-kms-removal-v1-1-b4e1ca053623@oss.qualcomm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 04 Jul 2026 18:43:03 +0000
Message-Id: <20260704184304.6567A1F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference when enabling CRTC without a primary plan=
e framebuffer.

Pre-existing issues:
- [High] Unsafe direct access of global plane and CRTC state pointers in at=
omic commit callbacks.
--

commit 6344532446cab68117e44660f110ef0c8aec15d7
Author: Ze Huang <ze.huang@oss.qualcomm.com>

drm/arcpgu: replace struct drm_simple_display_pipe with regular atomic help=
ers

This commit replaces drm_simple_display_pipe with regular atomic helpers.
It instantiates the plane, CRTC, and encoder directly, wiring them up with
standard atomic helpers to remove the dependency on the simple-KMS interfac=
e.

> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb75..375cdb79e4e89 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
[ ... ]
> @@ -117,7 +117,7 @@ static const u32 arc_pgu_supported_formats[] =3D {
> =20
>  static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
>  {
> -	const struct drm_framebuffer *fb =3D arcpgu->pipe.plane.state->fb;
> +	const struct drm_framebuffer *fb =3D arcpgu->plane.state->fb;

[Severity: High]
This isn't a bug introduced by this patch, but does reading the global=20
plane->state pointer here instead of using the state passed via the=20
drm_atomic_commit parameter cause issues during non-blocking atomic commits?

If multiple non-blocking commits are queued rapidly, the global pointers=20
advance to the newest state. When the first commit's commit_tail finally=20
executes, reading plane->state directly instead of extracting the specific=
=20
commit's state could cause the older commit to program the hardware using a=
=20
future commit's state.

[Severity: High]
Can this dereference a NULL pointer if the CRTC is enabled without a primar=
y=20
plane framebuffer?

The transition from drm_simple_display_pipe to generic atomic helpers remov=
ed=20
the underlying protection that previously prevented the CRTC from enabling=
=20
without a valid framebuffer. If userspace performs an atomic commit that=20
enables the CRTC but sets the primary plane's framebuffer to 0 (NULL),=20
drm_atomic_helper_check_crtc_primary_plane verifies the plane is attached b=
ut=20
does not enforce plane_state->fb !=3D NULL.

This would allow the commit to proceed to arcpgu_crtc_helper_atomic_enable(=
),=20
which calls arc_pgu_mode_set(), and then arc_pgu_set_pxl_fmt(), blindly=20
dereferencing fb->format->format here.

>  	uint32_t pixel_format =3D fb->format->format;
>  	u32 format =3D DRM_FORMAT_INVALID;
>  	int i;
[ ... ]
> @@ -155,7 +155,7 @@ static enum drm_mode_status arc_pgu_mode_valid(struct=
 drm_simple_display_pipe *p
> =20
>  static void arc_pgu_mode_set(struct arcpgu_drm_private *arcpgu)
>  {
> -	struct drm_display_mode *m =3D &arcpgu->pipe.crtc.state->adjusted_mode;
> +	struct drm_display_mode *m =3D &arcpgu->crtc.state->adjusted_mode;

[Severity: High]
This is a pre-existing issue, but could reading the global crtc->state poin=
ter=20
directly cause hardware state corruption or frame tearing?

Similar to the plane state issue above, if rapid non-blocking atomic commit=
s=20
are generated, arc_pgu_mode_set() might read from the newest global state=20
rather than the specific commit's state object.

>  	u32 val;
> =20
>  	arc_pgu_write(arcpgu, ARCPGU_REG_FMT,
[ ... ]
> @@ -218,35 +218,106 @@ static void arc_pgu_disable(struct drm_simple_disp=
lay_pipe *pipe)
>  			      ~ARCPGU_CTRL_ENABLE_MASK);
>  }
> =20
> -static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
> -			   struct drm_plane_state *state)
> +static void arcpgu_plane_helper_atomic_update(struct drm_plane *plane,
> +					      struct drm_atomic_commit *state)
>  {
>  	struct arcpgu_drm_private *arcpgu;
>  	struct drm_gem_dma_object *gem;
> =20
> -	if (!pipe->plane.state->fb)
> +	if (!plane->state->fb)

[Severity: High]
This is a pre-existing issue, but does arcpgu_plane_helper_atomic_update()=
=20
safely handle non-blocking atomic commits when reading plane->state->fb=20
directly?

Reading the global plane->state pointer instead of extracting the new plane=
=20
state from the drm_atomic_commit parameter could result in the same race=20
condition during asynchronous commit_tail execution.

>  		return;
> =20
> -	arcpgu =3D pipe_to_arcpgu_priv(pipe);
> -	gem =3D drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
> +	arcpgu =3D dev_to_arcpgu(plane->dev);
> +	gem =3D drm_fb_dma_get_gem_obj(plane->state->fb, 0);
>  	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260705-drm-simple=
-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com?part=3D1
