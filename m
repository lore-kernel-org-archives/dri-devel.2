Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D128606A31C
	for <dri-devel@archiver.kernel.org>; Mon, 16 Nov 2026 09:23:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QzUCvcZG
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C444E10EE0E;
	Mon, 16 Nov 2026 09:23:53 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D0F2F10E3C6;
 Mon, 16 Nov 2026 09:23:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CBB2661169;
 Mon, 16 Nov 2026 09:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2C6571F000C5;
 Mon, 16 Nov 2026 09:23:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794821025;
 bh=H0jozQ+jMVhP9EQ25TbSqzBbba9YkkiI8kP5Djl5nAw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QzUCvcZGXcgNztqba5I4OWRnmuqZCm8PaNR9FNT3Q5pmHNFCSlcqhPAS2/Ww3H38P
 eauVrMloT5gm3e7V1kgA7SHwScdVVP1prygQC9KvzNZLuDDW0sbtbO0n4kJ98ib+Tz
 wB6pXXSJWOM+qtAWrQTl4vg07iVPlMjWFyUWksDX40eL/J+A9DMv4ci+xGhZpjysrX
 OYqbap0Dz/HYs/rxsIq5JCFy2zhv/JnMbk1T+jNvq9ir9P0n0QDGC7D3b12DUaBfWk
 lIbeYB4xMOMbEKrjbRkO5YO/r764V0X92yZrlzyYTJXL1VEREj5BNaWML18a0Kh8CZ
 ZU05xLzcXB2EQ==
Message-ID: <sashiko-outbox-216608@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/12] drm/atomic: s/async/bypass/
To: "Ville Syrjala" <ville.syrjala@linux.intel.com>,
 dri-devel@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
 amd-gfx@lists.freedesktop.org
In-Reply-To: <20261116091130.13950-3-ville.syrjala@linux.intel.com>
References: <20261116091130.13950-1-ville.syrjala@linux.intel.com>
 <20261116091130.13950-3-ville.syrjala@linux.intel.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 09:23:44 +0000
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Reply-To: sashiko-reviews@lists.linux.dev
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-10.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found no new issues
in this patch, but noticed 2 related pre-existing issues it does not
introduce:
- [High] drm/loongson: live state mutation in
  lsdc_cursor_plane_atomic_async_check() [1]
- [Medium] drm/loongson: incomplete state copy in
  lsdc_cursor_plane_atomic_async_update() [2]
--

commit 7aa4a6090dacda1cd98d23702b18772083dad3be
Author: Ville Syrj=C3=A4l=C3=A4 <ville.syrjala@linux.intel.com>

drm/atomic: s/async/bypass/

This commit renames the atomic plane async update helpers, hooks, and
state flags to "bypass" across the DRM core and display drivers.

[ ... ]

> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loon=
gson/lsdc_plane.c
> index c425288ba4909..59f85072273a6 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
> @@ -172,9 +172,9 @@ static const struct drm_plane_helper_funcs lsdc_prima=
ry_helper_funcs =3D {
>  	.atomic_disable =3D lsdc_primary_atomic_disable,
>  };
> =20
> -static int lsdc_cursor_plane_atomic_async_check(struct drm_plane *plane,
> -						struct drm_atomic_commit *state,
> -						bool flip)
> +static int lsdc_cursor_plane_atomic_bypass_check(struct drm_plane *plane,
> +						 struct drm_atomic_commit *state,
> +						 bool flip)
>  {
>  	struct drm_plane_state *new_state;
>  	struct drm_crtc_state *crtc_state;

[Severity: High]
This problem wasn't introduced by this patch, but should
lsdc_cursor_plane_atomic_bypass_check() pass new_state instead of
plane->state to drm_atomic_helper_check_plane_state() [1]?

drivers/gpu/drm/loongson/lsdc_plane.c:lsdc_cursor_plane_atomic_bypass_check=
() {
	...
	return drm_atomic_helper_check_plane_state(plane->state,
						   crtc_state,
						   DRM_PLANE_NO_SCALING,
						   DRM_PLANE_NO_SCALING,
						   true, true);
}

drm_atomic_helper_check_plane_state() updates src, dst, and visible on the
passed-in state, so passing plane->state mutates the live committed state
during the check phase, racing with concurrent readers and corrupting
active state if the check fails or runs as TEST_ONLY.

> @@ -219,8 +219,8 @@ static int lsdc_cursor_plane_atomic_async_check(struc=
t drm_plane *plane,
>  						   true, true);
>  }
> =20
> -static void lsdc_cursor_plane_atomic_async_update(struct drm_plane *plan=
e,
> -						  struct drm_atomic_commit *state)
> +static void lsdc_cursor_plane_atomic_bypass_update(struct drm_plane *pla=
ne,
> +						   struct drm_atomic_commit *state)
>  {
>  	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
>  	const struct lsdc_cursor_plane_ops *ops =3D cursor->ops;

[Severity: Medium]
This problem wasn't introduced by this patch, but does
lsdc_cursor_plane_atomic_bypass_update() leave plane->state with stale
clipping rectangles and visibility [2]?

drivers/gpu/drm/loongson/lsdc_plane.c:lsdc_cursor_plane_atomic_bypass_updat=
e() {
	...
	plane->state->src_x =3D new_state->src_x;
	plane->state->src_y =3D new_state->src_y;
	plane->state->src_h =3D new_state->src_h;
	plane->state->src_w =3D new_state->src_w;
	swap(plane->state->fb, new_state->fb);
	...
}

The in-place state update copies the integer coordinates and swaps fb, but
never copies src, dst, or visible from new_state into plane->state, leaving
them out of sync with the updated coordinates once the check phase stops
mutating plane->state directly.

[1] https://sashiko.dev/#/bug/linux-6b50e65f-5d91-4154-8ead-a7e41b3bb981
[2] https://sashiko.dev/#/bug/linux-39745fec-ddf4-4f7a-a3b2-188ca2cfda2a

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116091130.1395=
0-1-ville.syrjala@linux.intel.com?part=3D2
