Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F83C79FB6
	for <dri-devel@archiver.kernel.org>; Wed,  9 Sep 2026 13:22:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1719F10F0FE;
	Wed,  9 Sep 2026 13:22:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="mQT6F4Ly";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2252D10F0FE
 for <dri-devel@lists.freedesktop.org>; Wed,  9 Sep 2026 13:22:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0B943423BD;
 Wed,  9 Sep 2026 13:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51D71F00A3F;
 Wed,  9 Sep 2026 13:22:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788960160;
 bh=YLb055TdipxJuuD1r/jUmd8F4Nj9IDJJ7kcg9iP2un0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=mQT6F4LypXCsI4bFB71hP7nv1BwLVTpvzVwzCG4L4vtc66v+Lodo7Bxa/e5nTpPMs
 VnRfS+UsFA9dMLEFB08zH1JUdOoJ1a3u+903HiYA5oA95TLXX92nxsunHMZ0vwG/rR
 ERbb6rxhqemcMZorhEKCW8ovK5TuuUx7xiOMbVeKVBjdHFzE/hgwD2WJWcICsK91ci
 7HB7BVtBUIhrRaSgoyVw1Y/HNYcZembFfWhbZTNH+2y3lxlJJfrp1c7zRcrpwJNLE9
 ZqxntCeGt1abgXaZm+kt0Ur3Xd9JAdKqVr/Qhlrg/mvm8AELvl6WwBkDMit2YSyNlW
 p7kU3R419Im4g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5] drm/tiny: arcpgu: Replace simple display pipe with
 regular atomic helpers
To: "Davide Bonatto" <bonatto.davide@gmail.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260909125806.174851-1-bonatto.davide@gmail.com>
References: <20260909092455.131962-1-bonatto.davide@gmail.com>
 <20260909125806.174851-1-bonatto.davide@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 09 Sep 2026 13:22:40 +0000
Message-Id: <20260909132240.C51D71F00A3F@smtp.kernel.org>
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
- [High] Missing primary plane visibility check allows CRTC to be enabled w=
ith disabled plane, causing DMA scanout from physical address 0.
--

commit 0780d3c6b6d7797f539151d0b77405608d2d3ea1
Author: Davide Bonatto <bonatto.davide@gmail.com>
Subject: drm/tiny: arcpgu: Replace simple display pipe with regular atomic =
helpers

The drm_simple_display_pipe helper is considered legacy/deprecated in
favor of explicitly managing individual plane, CRTC, and encoder objects
using standard atomic helpers. Migrate arcpgu to explicitly route mode
validation and atomic hooks through standard helper functions.

> diff --git a/drivers/gpu/drm/tiny/arcpgu.c b/drivers/gpu/drm/tiny/arcpgu.c
> index c93d61ac0bb75..c6308fee568db 100644
> --- a/drivers/gpu/drm/tiny/arcpgu.c
> +++ b/drivers/gpu/drm/tiny/arcpgu.c
[ ... ]
> @@ -189,54 +203,127 @@ static void arc_pgu_mode_set(struct arcpgu_drm_pri=
vate *arcpgu)
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
> +
> +	return drm_atomic_helper_check_plane_state(new_plane_state, crtc_state,
> +						   DRM_PLANE_NO_SCALING,
> +						   DRM_PLANE_NO_SCALING,
> +						   false, true);

[Severity: High]
Does this code allow the CRTC to remain enabled without a visible primary
plane, potentially causing the DMA controller to scan from physical address=
 0?

When drm_atomic_helper_check_plane_state() runs, it returns 0 (success)
if the plane is not visible (e.g., when the framebuffer is NULL).

If a userspace application issues an atomic commit that sets the primary
plane's FB_ID to 0 without also disabling the CRTC, the atomic core sets
new_plane_state->fb =3D NULL and new_plane_state->visible =3D false.

Could we add a check here verifying that the primary plane is visible when
the CRTC is enabled (e.g., if (crtc_state->enable && !new_plane_state->visi=
ble)
return -EINVAL;) to prevent scanning from address 0?

> +}
> +
> +static int arc_pgu_crtc_atomic_check(struct drm_crtc *crtc,
> +				     struct drm_atomic_commit *state)
> +{
> +	struct drm_crtc_state *crct_state =3D drm_atomic_get_new_crtc_state(sta=
te, crtc);
> +
> +	if (!crct_state->enable)
> +		return 0;
> +
> +	if (!crct_state->plane_mask)
> +		return -EINVAL;

[Severity: High]
Is this check sufficient to guarantee that the primary plane has a valid
framebuffer?

Setting the primary plane's FB_ID to 0 does not change the plane's crtc
mapping, meaning crct_state->plane_mask remains non-zero. This check will
incorrectly approve the commit, allowing it to proceed.

The commit would then invoke arc_pgu_plane_atomic_disable() which writes 0 =
to
ARCPGU_REG_BUF0_ADDR. Since the CRTC remains enabled, the hardware DMA
controller could begin scanning out pixels from physical address 0, causing=
 bus
errors, IOMMU faults, or memory corruption.

> +
> +	return 0;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260909125806.1748=
51-1-bonatto.davide@gmail.com?part=3D1
