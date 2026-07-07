Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2466C43458
	for <dri-devel@archiver.kernel.org>; Tue,  7 Jul 2026 15:29:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0B38689208;
	Tue,  7 Jul 2026 15:29:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="E3dc6iOa";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9193289208
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:29:26 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 510B542A5A
 for <dri-devel@lists.freedesktop.org>; Tue,  7 Jul 2026 15:29:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 011211F000E9;
 Tue,  7 Jul 2026 15:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1783438166;
 bh=hg41nOIwMpGy7CJJ7V+fxh+vrITqorRMAThq3gik2WA=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=E3dc6iOaOF1lyA9SpRNj+weHlwa9uRaDjqmnbs3NNtjTaT6CIQUCJo1REEZ+CkzMv
 piYrBviAyC8hupxDNX4yOYc8Nvp7BCR2fON9vIxRdy8FUUuVbrw5PFSn77fwn9bBtb
 Se+PWZGmyqJVIYn71CpwkBmFWS2pd6/oc13rvIRYyHEw8yLzciO16K4dfyvMXv5mLS
 p+14l3D9RhXg6/8qzu8l0+KOYDZqjbpHmA9s5z8mC6w62OfWgrJENSK1lTFe1U/vVW
 vG3z4gIgvvGbjFj2HTqwcHooMkTuYpVyobNAI7ybeI03FCaZaTFYkUQL4pKw4C8EB8
 F0qoPpEh2tevQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/37] drm/bridge: cros-ec-anx7688: Add atomic bridge
 state handlers
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260707-drm-all-atomic-bridges-v2-7-21d03cbca446@kernel.org>
References: <20260707-drm-all-atomic-bridges-v2-0-21d03cbca446@kernel.org>
 <20260707-drm-all-atomic-bridges-v2-7-21d03cbca446@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 07 Jul 2026 15:29:24 +0000
Message-Id: <20260707152926.011211F000E9@smtp.kernel.org>
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
- [High] NULL pointer dereference in `drm_state_dump` if the initial atomic=
 bridge state allocation fails.
--

--- Patch [7]: [PATCH v2 07/37] drm/bridge: cros-ec-anx7688: Add atomic bri=
dge state handlers ---
commit 45bb4ccee956e78effd5cb908d42d26a9cefaebb
Author: Maxime Ripard <mripard@kernel.org>

drm/bridge: cros-ec-anx7688: Add atomic bridge state handlers

This commit adds atomic state handlers to the cros-ec-anx7688 bridge. This =
is
done to remove the legacy bridge callback support from the DRM bridge core.

> diff --git a/drivers/gpu/drm/bridge/cros-ec-anx7688.c b/drivers/gpu/drm/b=
ridge/cros-ec-anx7688.c
> --- a/drivers/gpu/drm/bridge/cros-ec-anx7688.c
> +++ b/drivers/gpu/drm/bridge/cros-ec-anx7688.c

[ ... ]

> @@ -92,6 +93,9 @@ static bool cros_ec_anx7688_bridge_mode_fixup(struct dr=
m_bridge *bridge,
>  }
> =20
>  static const struct drm_bridge_funcs cros_ec_anx7688_bridge_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_bridge_create_state,

[Severity: High]
This isn't a bug introduced by this patch, but adding atomic state handlers
causes drm_bridge_is_atomic() to return true, which exposes a pre-existing
NULL pointer dereference in the DRM core.

When drm_bridge_attach() calls drm_atomic_private_obj_init(), the object
is added to privobj_list before the state is successfully allocated:

drivers/gpu/drm/drm_atomic.c:drm_atomic_private_obj_init() {
	list_add_tail(&obj->head, &dev->mode_config.privobj_list);

	state =3D obj->funcs->atomic_create_state(obj);
	if (IS_ERR(state))
		return PTR_ERR(state);

	obj->state =3D state;
}

If atomic_create_state() fails, drm_bridge_attach() ignores the error:

drivers/gpu/drm/drm_bridge.c:drm_bridge_attach() {
	if (drm_bridge_is_atomic(bridge))
		drm_atomic_private_obj_init(bridge->dev, &bridge->base,
					    &drm_bridge_priv_state_funcs);

	return 0;
}

This leaves the object on privobj_list with a NULL obj->state.

If drm_state_dump() is later triggered, it will crash when it unconditional=
ly
dereferences the NULL state:

drivers/gpu/drm/drm_atomic.c:drm_atomic_private_obj_print_state() {
	struct drm_private_obj *obj =3D state->obj;
}

Could drm_bridge_attach() be updated to check the return value of
drm_atomic_private_obj_init(), or should drm_atomic_private_obj_init()
remove the object from the list on failure?

> +	.atomic_destroy_state =3D drm_atomic_helper_bridge_destroy_state,
> +	.atomic_duplicate_state =3D drm_atomic_helper_bridge_duplicate_state,
>  	.mode_fixup =3D cros_ec_anx7688_bridge_mode_fixup,
>  };

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260707-drm-all-at=
omic-bridges-v2-0-21d03cbca446@kernel.org?part=3D7
