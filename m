Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75047C79FAD
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 11:03:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7A47310E168;
	Wed,  9 Sep 2026 11:03:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="d4lSBXSK";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B475110E168
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 11:03:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 5496142A18;
 Wed,  9 Sep 2026 11:03:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 17B8C1F00AC4;
 Wed,  9 Sep 2026 11:03:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788951784;
 bh=KIqMB94uhz09erUIFUyd/ef5yF4+RpQFnA5Oi+1QLlo=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=d4lSBXSKP9FnensKQyo0+nr3ZxT6TdMgjmVSlk/iX1Cl28iHhguOS+AhI8EJKJ10J
 FEqa5U5O1DKwV7UP09ZTHaMwjjm+0PgmgBOLM/TdDSBxIvWZ8QZ099wVb4F4q8CSz4
 1y9kyyGyWToEAqme8FbDLX9Nsgp5jc0hGoN4sjYoQwq/hoTAgVSwEILN4EWgbKO6/m
 s8MkwuDQpK/V7ENMhr+jR4vERRFjtbi64uGNLLo7XylVEk2YiYXndubrargHUuvaGJ
 Sj3kZLMsuyiAzRRZYT3usV04PQOwIGIt6NdQFUGlOU0uyMn34PRTWNL32M9n1xo2OT
 ZzKzPDUwx55Zw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3] drm/tiny: arcpgu: Replace simple display pipe with
 regular atomic helpers
To: "Davide Bonatto" <bonatto.davide@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909104332.160612-1-bonatto.davide@gmail.com>
References: <20260909092455.131962-1-bonatto.davide@gmail.com>
 <20260909104332.160612-1-bonatto.davide@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 11:03:03 +0000
Message-Id: <20260909110304.17B8C1F00AC4@smtp.kernel.org>
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
- [High] Incorrect usage of `drm_atomic_get_new_*_state` causes valid parti=
al atomic commits to be rejected with `-EINVAL` and leads to potential hard=
ware misconfiguration.

Pre-existing issues:
- [High] Sleeping clock functions are called from CRTC atomic enable/disabl=
e paths, violating atomic context constraints.
- [High] Hardware DMA use-after-free on page flip due to lack of hardware V=
BLANK synchronization.
--

commit 56c718e0d1deb02575937fad72869dc5fbfabbaa
Author: Davide Bonatto <bonatto.davide@gmail.com>

drm/tiny: arcpgu: Replace simple display pipe with regular atomic helpers

The driver is being migrated from the deprecated drm_simple_display_pipe
helper to explicitly managed plane, CRTC, and encoder objects using standard
atomic helpers.

> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb75..b66b9562df10d 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
[ ... ]
> -static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
> -			   struct drm_crtc_state *crtc_state,
> -			   struct drm_plane_state *plane_state)
> +static void arc_pgu_crtc_atomic_enable(struct drm_crtc *crtc,
> +				       struct drm_atomic_commit *state)
>  {
> -	struct arcpgu_drm_private *arcpgu =3D pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu =3D crtc_to_arcpgu_priv(crtc);
> +	struct drm_plane_state *plane_state =3D
> +		drm_atomic_get_new_plane_state(state, &arcpgu->plane);
> +	const struct drm_framebuffer *fb =3D plane_state ? plane_state->fb : NU=
LL;

[Severity: High]
Does this skip essential pixel format programming during a CRTC enable if t=
he
plane isn't part of the commit state?

If a userspace compositor requests a CRTC-only DPMS state change,
drm_atomic_get_new_plane_state() will return NULL for the plane state, lead=
ing
to a NULL fb and skipping the pixel format programming entirely.

> -	arc_pgu_mode_set(arcpgu);
> +	arc_pgu_mode_set(arcpgu, fb);
> =20
>  	clk_prepare_enable(arcpgu->clk);

[Severity: High]
This is a pre-existing issue, but does this execute a sleeping clock framew=
ork
function inside an atomic context?

According to DRM subsystem guidelines, CRTC atomic enable callbacks execute=
 in
an atomic context where sleeping functions are forbidden. Calling
clk_prepare_enable() here can cause kernel warnings and potential deadlocks.

>  	arc_pgu_write(arcpgu, ARCPGU_REG_CTRL,
>  		      arc_pgu_read(arcpgu, ARCPGU_REG_CTRL) |
> -		      ARCPGU_CTRL_ENABLE_MASK);
> +		ARCPGU_CTRL_ENABLE_MASK);
>  }
> =20
> -static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
> +static void arc_pgu_crtc_atomic_disable(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *state)
>  {
> -	struct arcpgu_drm_private *arcpgu =3D pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu =3D crtc_to_arcpgu_priv(crtc);
> =20
>  	clk_disable_unprepare(arcpgu->clk);

[Severity: High]
This is a pre-existing issue, but does this execute a sleeping clock framew=
ork
function inside an atomic context?

Similar to the enable path, arc_pgu_crtc_atomic_disable() executes in an
atomic context. Calling clk_disable_unprepare() here acquires a mutex and
sleeps, which is not permitted.

[ ... ]
> -static void arc_pgu_update(struct drm_simple_display_pipe *pipe,
> -			   struct drm_plane_state *state)
> +static void arc_pgu_plane_atomic_update(struct drm_plane *plane,
> +					struct drm_atomic_commit *state)
>  {
> -	struct arcpgu_drm_private *arcpgu;
> +	struct arcpgu_drm_private *arcpgu =3D plane_to_arcpgu(plane);
> +	struct drm_plane_state *new_plane_state =3D drm_atomic_get_new_plane_st=
ate(state, plane);
>  	struct drm_gem_dma_object *gem;
> =20
> -	if (!pipe->plane.state->fb)
> +	if (!new_plane_state->fb)
>  		return;
> =20
> -	arcpgu =3D pipe_to_arcpgu_priv(pipe);
> -	gem =3D drm_fb_dma_get_gem_obj(pipe->plane.state->fb, 0);
> +	gem =3D drm_fb_dma_get_gem_obj(new_plane_state->fb, 0);
>  	arc_pgu_write(arcpgu, ARCPGU_REG_BUF0_ADDR, gem->dma_addr);

[Severity: High]
This is a pre-existing issue inherited from the simple display pipe setup,
but can this lead to a hardware DMA use-after-free on page flip?

Because the driver lacks VBLANK interrupts, the new DMA address is committed
to hardware here without a mechanism to delay freeing the previous buffer. =
The
DRM core simulates a VBLANK and immediately unpins/frees the old memory, but
the physical hardware won't latch this new address until its next real VBLA=
NK.
The hardware could continue scanning from the now-freed memory buffer.

[ ... ]
> +static int arc_pgu_plane_atomic_check(struct drm_plane *plane,
> +				      struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *new_plane_state =3D drm_atomic_get_new_plane_st=
ate(state, plane);
> +	struct drm_crtc_state *crtc_state;
> +
> +	if (!new_plane_state->crtc)
> +		return 0;
> +
> +	crtc_state =3D drm_atomic_get_new_crtc_state(state, new_plane_state->cr=
tc);
> +	if (!crtc_state)
> +		return -EINVAL;

[Severity: High]
Does this incorrectly reject valid plane-only updates?

If a userspace compositor requests a non-modesetting atomic update (such as
only updating the plane's FB), the CRTC state is not natively included in t=
he
atomic commit state. drm_atomic_get_new_crtc_state() will return NULL, caus=
ing
this function to fail with -EINVAL and breaking userspace display servers.

[ ... ]
> +static int arc_pgu_crtc_atomic_check(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crct_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +	struct arcpgu_drm_private *arcpgu =3D crtc_to_arcpgu_priv(crtc);
> +	struct drm_plane_state *plane_state;
> +
> +	if (!crct_state->enable)
> +		return 0;
> +
> +	plane_state =3D drm_atomic_get_new_plane_state(state, &arcpgu->plane);
> +	if (!plane_state || !plane_state->fb)
> +		return -EINVAL;

[Severity: High]
Will this fail valid CRTC-only updates?

Similar to the plane check, if a userspace compositor requests an update to
a CRTC property (e.g., active state) without including the plane in the
commit request, plane_state will evaluate to NULL and cause the driver to
incorrectly reject the partial atomic commit.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909104332.1606=
12-1-bonatto.davide@gmail.com?part=3D1
