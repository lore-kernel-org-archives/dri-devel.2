Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 27A4DC79F8C
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 09:38:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1C010F067;
	Wed,  9 Sep 2026 09:38:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="IQvNVeWF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D2C7810F066
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 09:38:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id E6637601FD;
 Wed,  9 Sep 2026 09:38:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E1D71F00A3A;
 Wed,  9 Sep 2026 09:38:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788946684;
 bh=9Bs1Ymleg6+xra7kgbWGJZiEfwtB22XsXiOddke7Wu8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=IQvNVeWFxs1qBGduYaZutZh8jP7qfPpgOmDS9Rr8d8+PGcWWPu3rIpLMo50T5hbCL
 s7xboi4LU9+U9mb0ovC6eybBJJyHzliXcylMPzNZOVo8bvTM/zuUczKgRrBvBW2aVf
 Bz8NQqsOdw06Ax27yes5vROLh28zaZzSmANHHzHw8sPDk/gu6CSXbKCCwqU3RKpwcT
 LSpiR7gNgLgbpyit10zgRPSuLYQOEoNO22XX7NA76c8xOx4PE2D7FhFBgbxnC2xpG/
 fkjNrJqn6ZVTf0PKt5VN2LSW6ZuXAreTzMEKr7kkDg5WD8esbkBH3xlEfTTHLPErDU
 +OCBbBnAuwj7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/tiny: arcpgu: Replace simple display pipe with
 regular atomic helpers
To: "Davide Bonatto" <bonatto.davide@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909092455.131962-1-bonatto.davide@gmail.com>
References: <20260909092455.131962-1-bonatto.davide@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 09:38:04 +0000
Message-Id: <20260909093804.7E1D71F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

New issues:
- [Critical] Hardware DMA scans out freed memory when plane is disabled wit=
hout CRTC disable (Use-After-Free).
- [High] NULL Pointer Dereference during CRTC enable without a primary plan=
e.
- [High] Missing `.prepare_fb` callback breaks implicit synchronization.
- [Medium] Missing plane `.atomic_check` hook bypasses hardware scaling con=
straints.

Pre-existing issues:
- [High] Sleeping functions called from atomic context.
--

commit 776de1d240335d0996c4eca5f0b2980de524e7c7
Author: Davide Bonatto <bonatto.davide@gmail.com>

drm/tiny: arcpgu: Replace simple display pipe with regular atomic helpers

The drm_simple_display_pipe helper is considered legacy/deprecated in
favor of explicitly managing individual plane, CRTC, and encoder objects
using standard atomic helpers.

> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb75..bd24049845350 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
[ ... ]
> @@ -117,8 +123,8 @@ static const u32 arc_pgu_supported_formats[] =3D {
> =20
>  static void arc_pgu_set_pxl_fmt(struct arcpgu_drm_private *arcpgu)
>  {
> -	const struct drm_framebuffer *fb =3D arcpgu->pipe.plane.state->fb;
> -	uint32_t pixel_format =3D fb->format->format;
> +	const struct drm_framebuffer *fb =3D arcpgu->plane.state->fb;
> +	u32 pixel_format =3D fb->format->format;

[Severity: High]
Can this result in a NULL pointer dereference if the CRTC is enabled
without a primary plane?

Because the CRTC .atomic_check hook has been omitted in this patch, the
driver loses the drm_atomic_helper_check_crtc_primary_plane() validation.
Userspace can now submit an atomic commit that enables the CRTC without a
bound primary plane framebuffer. During the commit,=20
arc_pgu_crtc_atomic_enable() calls arc_pgu_mode_set(), which then calls=20
arc_pgu_set_pxl_fmt(). If fb is NULL here, dereferencing fb->format->format=
=20
will cause a kernel panic.

[ ... ]
> -static void arc_pgu_enable(struct drm_simple_display_pipe *pipe,
> -			   struct drm_crtc_state *crtc_state,
> -			   struct drm_plane_state *plane_state)
> +static void arc_pgu_crtc_atomic_enable(struct drm_crtc *crtc,
> +				       struct drm_atomic_commit *state)
>  {
> -	struct arcpgu_drm_private *arcpgu =3D pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu =3D crtc_to_arcpgu_priv(crtc);
> =20
>  	arc_pgu_mode_set(arcpgu);
> =20
>  	clk_prepare_enable(arcpgu->clk);

[Severity: High]
This isn't a bug introduced by this patch, but does calling
clk_prepare_enable() here violate atomic context rules?

The DRM subsystem guidelines specify that CRTC atomic enable callbacks exec=
ute
in atomic context during non-blocking commits, where sleeping is strictly
forbidden. Since clk_prepare_enable() can sleep, it could lead to deadlocks
or system instability.

[ ... ]
> -static void arc_pgu_disable(struct drm_simple_display_pipe *pipe)
> +static void arc_pgu_crtc_atomic_disable(struct drm_crtc *crtc,
> +					struct drm_atomic_commit *state)
>  {
> -	struct arcpgu_drm_private *arcpgu =3D pipe_to_arcpgu_priv(pipe);
> +	struct arcpgu_drm_private *arcpgu =3D crtc_to_arcpgu_priv(crtc);
> =20
>  	clk_disable_unprepare(arcpgu->clk);

[Severity: High]
This is also a pre-existing issue, but similar to the enable path, is it
safe to call clk_disable_unprepare() here? This function can sleep, which=20
is unsafe to call during the atomic_disable callback.

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

[Severity: Critical]
Could this early return cause the hardware DMA to scan out freed memory?

Due to the missing CRTC .atomic_check hook, userspace can submit a commit
that disables the primary plane while keeping the CRTC active. If
new_plane_state->fb is NULL, this function returns early without updating
the hardware. Since the CRTC remains enabled, the hardware DMA will
continue scanning from the previously configured buffer address after the
DRM core frees it, leading to memory corruption or an information leak.

[ ... ]
> +static const struct drm_crtc_helper_funcs arc_pgu_crtc_helper_funcs =3D {
> +	.mode_valid	=3D arc_pgu_crtc_mode_valid,
> +	.atomic_enable	=3D arc_pgu_crtc_atomic_enable,
> +	.atomic_disable =3D arc_pgu_crtc_atomic_disable,
> +};

[Severity: High]
Is the .atomic_check hook intentionally omitted here?

Without it, the driver loses the validation that the simple KMS helper
previously provided to enforce a bound primary plane. This allows an invalid
atomic state to proceed to the commit phase, leading to the NULL pointer
dereference or use-after-free scenarios mentioned above.

[ ... ]
> +static const struct drm_plane_helper_funcs arc_pgu_plane_helper_funcs =
=3D {
> +	.atomic_update =3D arc_pgu_plane_atomic_update,
> +};

[Severity: Medium]
Does this structure need an .atomic_check function to validate hardware
scaling constraints?

The simple KMS helper previously enforced DRM_PLANE_NO_SCALING via
drm_atomic_helper_check_plane_state(). Without this validation, the driver
might incorrectly accept atomic commits with unsupported scaling or
positioning constraints from userspace.

[Severity: High]
Will the omission of the .prepare_fb callback break implicit
synchronization?

In the simple KMS helper, this was handled automatically via
drm_gem_plane_helper_prepare_fb(). Without this callback, the DRM core
cannot extract the implicit dma_fence from the GEM object's DMA-buf
reservation, meaning the atomic commit will immediately scan out the
buffer without waiting for GPU rendering to finish.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909092455.1319=
62-1-bonatto.davide@gmail.com?part=3D1
