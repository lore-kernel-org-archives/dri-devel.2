Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 75FDBC44501
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:28:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C978210F591;
	Thu,  9 Jul 2026 12:28:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="QW9HZtsG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A296F10F591
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:28:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6355B412E8
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:28:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1AF621F000E9;
 Thu,  9 Jul 2026 12:28:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783600128;
 bh=KJWAfjGkN/qxKXbL/IjU61HSRGuklqrVpz/Mt2gL/Go=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=QW9HZtsGHkAuA+MEXjS8kxTAVuLNiyucHJPJeQ3deaUWZBB6As4WbQCyQLUnYwzR+
 dVR3c04qByEAwrpIIGGxwqO4qaJcOAyil9BzzwZyKVojO2b7SxgsEWTRcYd6NkD8P5
 hCWx3RBnwCf5rtBhESwZs6e/45KiFz2qGGUg5w6ziKOOgiIqlSb3KRELwhruNTcC9G
 qU6JMmkgMpmIVPoP80eIhYpgtSKa7egPMTQYRs8LLcYLAE/YxgkDA4k61k4UgQADUA
 xnXL2EevOTvmIEsFz0Bm3wmeghSd+WVouqMxBar9uF+gGdY6GhcMWPKcqrp0JqDL0O
 4qNwpwJceudYA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 41/60] drm/malidp: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-41-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-41-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:28:47 +0000
Message-Id: <20260709122848.1AF621F000E9@smtp.kernel.org>
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
- [Low] malidp_plane_create_state() improperly retains legacy state destruc=
tion logic and mutates the plane object
--

--- Patch [41]: [PATCH 41/60] drm/malidp: Convert to atomic_create_state ---
commit 22a3f18af7981b36b8b4da5e3e62def563f0192e
Author: Maxime Ripard <mripard@kernel.org>

drm/malidp: Convert to atomic_create_state

This commit converts the plane reset implementation in the malidp driver to
use atomic_create_state. The conversion was primarily done using a Coccinel=
le
semantic patch.

> diff --git a/drivers/gpu/drm/arm/malidp_planes.c b/drivers/gpu/drm/arm/ma=
lidp_planes.c
> index 60b3f2bb153b5..82a75591a4597 100644
> --- a/drivers/gpu/drm/arm/malidp_planes.c
> +++ b/drivers/gpu/drm/arm/malidp_planes.c

[ ... ]

> @@ -73,7 +73,7 @@
>   * allocate a new empty object. We just need enough space to store
>   * a malidp_plane_state instead of a drm_plane_state.
>   */
> -static void malidp_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *malidp_plane_create_state(struct drm_plan=
e *plane)
>  {
>  	struct malidp_plane_state *state =3D to_malidp_plane_state(plane->state=
);
> =20
> @@ -82,8 +82,12 @@ static void malidp_plane_reset(struct drm_plane *plane)
>  	kfree(state);
>  	plane->state =3D NULL;

[Severity: Low]
Should this legacy state destruction logic be removed from
malidp_plane_create_state()?

It appears the Coccinelle script missed this teardown logic because it chec=
ks
the local variable if (state) rather than if (plane->state) when attempting
to drop destruction calls.

The DRM core guarantees plane->state is NULL before calling
.atomic_create_state(), so this destruction logic evaluates as dead code.

Additionally, the assignment to plane->state =3D NULL here technically viol=
ates
the .atomic_create_state API contract, which forbids mutating the plane
object's state pointer.

>  	state =3D kzalloc_obj(*state);
> -	if (state)
> -		__drm_atomic_helper_plane_reset(plane, &state->base);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);
> +
> +	__drm_atomic_helper_plane_state_init(&state->base, plane);
> +
> +	return &state->base;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D41
