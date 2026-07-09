Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E367DC43458
	for <dri-devel@archiver.kernel.org>; Thu,  9 Jul 2026 12:26:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 301E110F58D;
	Thu,  9 Jul 2026 12:26:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="kTX7iK9S";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 986FB10F58D
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:26:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 6189B41595
 for <dri-devel@lists.freedesktop.org>; Thu,  9 Jul 2026 12:26:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 19DF41F000E9;
 Thu,  9 Jul 2026 12:26:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783599997;
 bh=T7ZkNTz90akb43BXbE/WV+qiNYQE6edgeMAYrmjzwCk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kTX7iK9SlSFKNWZzzauqQztesODvLvVmQLJufEnDd47dpIMUcAb1siPZy2jE12Yve
 PeJXnBGsdjFZMrgFv70Qm67Cx1RdsrPJ8zSZWZoInXbZHaoFJxxA012h8b9kdMW8sR
 s2pXLohD4uxiU7wcoedJu/Xvluxd7gnUSBSrHV58IThTHVJHNTOe4y3TH/uHpMC8l4
 BGGLzauTqNwJQ5TBBNtFM1Pn0QOwbpq1CwwIfr3tQXOGsp4v1PUOyLr3DADgJbHjp8
 DJ08/z8HeDSmLw7mJ1mUvCALGkwVBRw2lTJGm1HUYtfIoz6Qnn5uH+aHrnFnzWV7+J
 d9bCxgHp7Gh8w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 46/60] drm/mediatek: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260709-drm-no-more-plane-reset-v1-46-302d986fe5f0@kernel.org>
References: <20260709-drm-no-more-plane-reset-v1-0-302d986fe5f0@kernel.org>
 <20260709-drm-no-more-plane-reset-v1-46-302d986fe5f0@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 09 Jul 2026 12:26:36 +0000
Message-Id: <20260709122637.19DF41F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [High] Missing NULL check in `mtk_plane_duplicate_state` leads to a kerne=
l panic if state allocation fails during reset.
--

--- Patch [46]: [PATCH 46/60] drm/mediatek: Convert to atomic_create_state =
---
commit 867713cd832a2d719c2c0ff993878555b5315739
Author: Maxime Ripard <mripard@kernel.org>

drm/mediatek: Convert to atomic_create_state

The plane reset implementation creates a custom state subclass, but only
initializes a pristine state without resetting any hardware. This is
equivalent to what atomic_create_state expects. Convert to it.

> diff --git a/drivers/gpu/drm/mediatek/mtk_plane.c b/drivers/gpu/drm/media=
tek/mtk_plane.c
> index 2598c8edb443d..2a40d72d241e0 100644
> --- a/drivers/gpu/drm/mediatek/mtk_plane.c
> +++ b/drivers/gpu/drm/mediatek/mtk_plane.c
> @@ -25,26 +25,20 @@ static const u64 modifiers[] =3D {
>  	DRM_FORMAT_MOD_INVALID,
>  };
> =20
> -static void mtk_plane_reset(struct drm_plane *plane)
> +static struct drm_plane_state *mtk_plane_create_state(struct drm_plane *=
plane)
>  {
>  	struct mtk_plane_state *state;
> +	state =3D kzalloc_obj(*state);
> +	if (!state)
> +		return ERR_PTR(-ENOMEM);

[Severity: High]
This is a pre-existing issue, but if mtk_plane_create_state() fails here
during drm_mode_config_reset(), plane->state is left as NULL.

When userspace later performs an atomic commit, does this lead to a NULL
pointer dereference in mtk_plane_duplicate_state()?

If we look at mtk_plane_duplicate_state() in the same file:

	struct mtk_plane_state *old_state =3D to_mtk_plane_state(plane->state);
	...
	state->pending =3D old_state->pending;

Since old_state is NULL, it looks like this will cause a kernel panic. Shou=
ld
a NULL check be added to mtk_plane_duplicate_state() to handle this case?

> =20
> -	if (plane->state) {
> -		__drm_atomic_helper_plane_destroy_state(plane->state);
> -
> -		state =3D to_mtk_plane_state(plane->state);
> -		memset(state, 0, sizeof(*state));
> -	} else {
> -		state =3D kzalloc_obj(*state);
> -		if (!state)
> -			return;
> -	}
> -
> -	__drm_atomic_helper_plane_reset(plane, &state->base);
> +	__drm_atomic_helper_plane_state_init(&state->base, plane);
> =20
>  	state->base.plane =3D plane;
>  	state->pending.format =3D DRM_FORMAT_RGB565;
>  	state->pending.modifier =3D DRM_FORMAT_MOD_LINEAR;
> +
> +	return &state->base;
>  }

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709-drm-no-mor=
e-plane-reset-v1-0-302d986fe5f0@kernel.org?part=3D46
