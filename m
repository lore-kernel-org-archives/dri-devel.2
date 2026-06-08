Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5B5FCD6E79
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 16:26:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B8C010F6BA;
	Mon,  8 Jun 2026 16:26:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="HJE7WD/5";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 61FE610F6BA
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:26:05 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8CD1260098
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 16:26:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 235211F00893;
 Mon,  8 Jun 2026 16:26:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780935964;
 bh=IPAAYV6jUyqrx9I59jNGlnvHzwRZCH4gSR2OzWb2D4s=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=HJE7WD/5PNUGd5YMdIgFO/apX1ZsUj7sq8VsrM/seemerzI/iz1ik21LjjLHy16A4
 Coo5PdUyVSVKCJh1ADt6xi9m6zINa1VpoKF3EnqwR4fsiYkF0NdVJbzKe9T4Yubu3h
 shvCKwlNVYjU1M3M9/xpm879Igfx8WB0X8lYslLGDM1nkMYZBhCSs/SOPpWh7TKf1F
 PhrfxNa3PX7tzC/gS6Q/xvaKTU1o2h+I6kD7moclgOgIpLS3h9Hgca6XClFpbLL8Bh
 /mvsEjmvJ/W/FKoIX5MU7Ds6/uP2HvCsTTX6DUXJfzG9gkF5yzQH0ALSjHtcEGUlof
 JaK4dmXdHHy/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 30/78] drm/bridge: samsung-dsim: Switch to
 atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-30-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-30-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 16:26:03 +0000
Message-Id: <20260608162604.235211F00893@smtp.kernel.org>
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
- [High] Unchecked return value of drm_atomic_private_obj_init() causes NUL=
L pointer dereference in debugfs state dump.
--

commit 04438d5e8a74302c0e7fbf067a17289c1680b606
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: samsung-dsim: Switch to atomic_create_state

This commit replaces the deprecated atomic_reset callback with
atomic_create_state and its corresponding helper.

> diff --git a/drivers/gpu/drm/bridge/samsung-dsim.c b/drivers/gpu/drm/brid=
ge/samsung-dsim.c
> index 9ee0515074c78..5788066d479e6 100644
> --- a/drivers/gpu/drm/bridge/samsung-dsim.c
> +++ b/drivers/gpu/drm/bridge/samsung-dsim.c
> @@ -1835,7 +1835,7 @@ static int samsung_dsim_attach(struct drm_bridge *b=
ridge,
>  static const struct drm_bridge_funcs samsung_dsim_bridge_funcs =3D {
>  	.atomic_duplicate_state		=3D drm_atomic_helper_bridge_duplicate_state,
>  	.atomic_destroy_state		=3D drm_atomic_helper_bridge_destroy_state,
> -	.atomic_reset			=3D drm_atomic_helper_bridge_reset,
> +	.atomic_create_state			=3D drm_atomic_helper_bridge_create_state,
[Severity: High]
This is a pre-existing issue, but does switching to atomic_create_state exp=
ose
a bug with unchecked return values in drm_bridge_attach()?

In drivers/gpu/drm/drm_bridge.c:drm_bridge_attach(), the return value of
drm_atomic_private_obj_init() is ignored:

	if (drm_bridge_is_atomic(bridge))
		drm_atomic_private_obj_init(bridge->dev, &bridge->base,
					    &drm_bridge_priv_state_funcs);

	return 0;

If memory allocation for the bridge's initial state fails (for instance, in
the newly assigned atomic_create_state callback), drm_bridge_attach()
still returns 0. The bridge probe falsely succeeds but bridge->base.state
remains NULL.

Because drm_atomic_private_obj_init() links the object into
dev->mode_config.privobj_list before attempting the state allocation,
the device's list is left containing a poisoned object with a NULL state.

Any subsequent trigger of the DRM state dump (e.g., via reading
/sys/kernel/debug/dri/*/state or SysRq-d) iterates over privobj_list and
unconditionally calls drm_atomic_private_obj_print_state():

drivers/gpu/drm/drm_atomic.c:drm_atomic_private_obj_print_state()
{
	struct drm_private_obj *obj =3D state->obj;
    ...
}

Since state is NULL, dereferencing state->obj triggers a kernel oops. Is th=
is
something that should be addressed in the DRM bridge core?

>  	.atomic_get_input_bus_fmts	=3D samsung_dsim_atomic_get_input_bus_fmts,
>  	.atomic_check			=3D samsung_dsim_atomic_check,
>  	.atomic_pre_enable		=3D samsung_dsim_atomic_pre_enable,

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D30
