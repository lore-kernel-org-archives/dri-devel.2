Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1F84EC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:20:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 67DBD10F582;
	Thu,  9 Jul 2026 12:20:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QMKAahv+";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF9710F582
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:20:41 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 7FB446001A
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:20:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE1E1F000E9;
 Thu,  9 Jul 2026 12:20:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599640;
 bh=tf9tQZXrhVdFgqHxMfq35fRrEDgIb3v69p1+Hhdpqco=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QMKAahv+DuHllXeHvgSblwjLgV8o6Uu1YwH5LjP6cMLwQIOaTuNr6BRzv89KY98BL
 q5WJc8YFRi2q+SLGmELzbhy1ZeSLidjxdVF3eVbpW0/V3aufxge2zx6mwzDAiivhjs
 2J903SnQW45owJYhfUTNRerqP2r37zbdSeKiuoI8mi+P7fGtJXMtehgoSF43vx9fzm
 gUc0MiuIe+2tlp2QzNV8T89bMyVwCTfdllz/IYtGcoA8UxpUzOqEuMPTdRae526jGU
 J1Ij/vwQ3WTzeDbW8lfFgPZCHWh+FCoyUZ4/9zkh6vCU+BXBKX17GScGtLJHBBlyJ3
 phTttAG8rWMAA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 38/60] drm/atomic-state-helper: Remove
 drm_atomic_helper_plane_reset()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-38-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-38-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:20:39 +0000
Message-Id: <20260709122040.0AE1E1F000E9@smtp.kernel.org>
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
- [Low] Removing `drm_atomic_helper_plane_reset()` breaks the build for the=
 VeriSilicon DRM driver due to a missed caller.
- [Low] The kernel-doc for `drm_plane_funcs.reset` still instructs drivers =
to use the removed `drm_atomic_helper_plane_reset()` function.
--

--- Patch [38]: [PATCH 38/60] drm/atomic-state-helper: Remove drm_atomic_he=
lper_plane_reset() ---
commit 28fd99488064ec3128455fb576e0e475cfe40a1f
Author: Maxime Ripard <mripard@kernel.org>

drm/atomic-state-helper: Remove drm_atomic_helper_plane_reset()

This commit removes drm_atomic_helper_plane_reset() from the atomic state
helper. The commit message states that all callers now go through
drm_atomic_helper_plane_create_state().

> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/=
drm_atomic_state_helper.c
> index d90d1d7c9cf9f..f184ce76e090d 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c
> @@ -346,25 +346,6 @@ void __drm_atomic_helper_plane_reset(struct drm_plan=
e *plane,
>  }
>  EXPORT_SYMBOL(__drm_atomic_helper_plane_reset);
> =20
> -/**
> - * drm_atomic_helper_plane_reset - default &drm_plane_funcs.reset hook f=
or planes
> - * @plane: drm plane
> - *
> - * Resets the atomic state for @plane by freeing the state pointer (whic=
h might
> - * be NULL, e.g. at driver load time) and allocating a new empty state o=
bject.
> - */
> -void drm_atomic_helper_plane_reset(struct drm_plane *plane)

[Severity: Low]
Are there still remaining callers of this function? It appears
vs_cursor_plane_funcs in drivers/gpu/drm/verisilicon/vs_cursor_plane.c
still references it for the .reset hook, which could break the build
when the VeriSilicon DRM driver is enabled:

drivers/gpu/drm/verisilicon/vs_cursor_plane.c:vs_cursor_plane_funcs:
	.reset		=3D drm_atomic_helper_plane_reset,

[Severity: Low]
Should the documentation in include/drm/drm_plane.h be updated as well?
The kernel-doc for struct drm_plane_funcs still instructs drivers to use
this removed function:

include/drm/drm_plane.h:
	 * Atomic drivers can use drm_atomic_helper_plane_reset() to reset
	 * atomic state using this hook.

> -{
> -	if (plane->state)
> -		__drm_atomic_helper_plane_destroy_state(plane->state);
> -
> -	kfree(plane->state);
> -	plane->state =3D kzalloc_obj(*plane->state);
> -	if (plane->state)
> -		__drm_atomic_helper_plane_reset(plane, plane->state);
> -}
> -EXPORT_SYMBOL(drm_atomic_helper_plane_reset);
> -

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D38
