Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 66A70CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 15:06:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B7A8810F57A;
	Mon,  8 Jun 2026 15:06:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="AC2TuXo0";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BF3D410F57A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:06:51 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2D4FA601D8
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 15:06:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B86671F00893;
 Mon,  8 Jun 2026 15:06:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780931210;
 bh=aHn+NzWhClCVUfylc5ESFov0BKx5f45R5jnbfJuhIo4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=AC2TuXo0zwyJjuhDbweaH17s7p6KzSXLzmtbfpsuidhw5xhfn9kcQuZAltWgdyXPE
 pRnQKv+i+yh+MuqtkJpM7xu9H2efAXUE59lo2mLpAAHSsNsZx04WH9sQCrlmQ1Oid1
 NJ0hY1b75Sfor2grqbWSS2e0eqa3Ad7NAzxb6tmvj1Zd2w9ICDuSA9tUd5uecIajaD
 bZN020xYZHDWIKqWl8Rcyz2GNwrasRHESdHK3nqyubKlLmvYd+QujD5tw1Y7aE7tY2
 nhsF90jEYLgTR4GECwaI0GQEyHFrz84darx5oMT/W+v+muGT8wwiUVoewgZOidWNdA
 F09FVS+X0eaBQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/78] drm/atomic-state-helper: Rename
 __drm_atomic_helper_bridge_reset()
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260608-drm-no-more-bridge-reset-v2-3-0a91018bf886@kernel.org>
References: <20260608-drm-no-more-bridge-reset-v2-3-0a91018bf886@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 08 Jun 2026 15:06:50 +0000
Message-Id: <20260608150650.B86671F00893@smtp.kernel.org>
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

Pre-existing issues:
- [High] drm_bridge_attach() ignores the return value of drm_atomic_private=
_obj_init(), hiding allocation failures.
- [High] cdns_mhdp_bridge_atomic_duplicate_state() triggers a fatal NULL po=
inter dereference if bridge state is NULL.
- [High] cdns_mhdp_bridge_atomic_destroy_state() crashes when passed a NULL=
 state during teardown.
--

commit e02bc473e33cd57fec3ea4025b707696ba1bef80
Author: Maxime Ripard <mripard@kernel.org>
Date:   Mon Jun 8 14:35:45 2026 +0000

    drm/atomic-state-helper: Rename __drm_atomic_helper_bridge_reset()
   =20
    __drm_atomic_helper_bridge_reset() is used to initialize a
    newly allocated drm_bridge_state, and is being typically called by the
    drm_bridge_funcs.atomic_reset implementation.
   =20
    Since we want to consolidate DRM objects state allocation around the
    atomic_create_state callback that will only allocate and initialize a
    new drm_bridge_state instance, we will need to call
    __drm_atomic_helper_bridge_reset() from both the atomic_reset and
    atomic_create_state hooks.
   =20
    To avoid any confusion, we can thus rename
    __drm_atomic_helper_bridge_reset() to
    __drm_atomic_helper_bridge_state_init().

> diff --git a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c b/driver=
s/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> index 46779b49545bd..2e74dc33e0859 100644
> --- a/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> +++ b/drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c
> @@ -1929,7 +1929,7 @@ cdns_mhdp_bridge_atomic_reset(struct drm_bridge *br=
idge)
>  	if (!cdns_mhdp_state)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	__drm_atomic_helper_bridge_reset(bridge, &cdns_mhdp_state->base);
> +	__drm_atomic_helper_bridge_state_init(bridge, &cdns_mhdp_state->base);

[Severity: High]
This isn't a bug introduced by this patch, but since we are consolidating=20
state allocations, what happens if the state is NULL?

In drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:cdns_mhdp_bridge_ato=
mic_duplicate_state(),
the function calls into the core duplicate helper without validating that t=
he=20
source state is non-NULL:

    state =3D kzalloc_obj(*state);
    if (!state)
            return NULL;

    __drm_atomic_helper_bridge_duplicate_state(bridge, &state->base);

If bridge->base.state is NULL, does this cause a crash during memcpy in=20
__drm_atomic_helper_private_obj_duplicate_state()?

[Severity: High]
This is also a pre-existing issue, but a similar problem seems to exist in =
the=20
teardown path.

In drivers/gpu/drm/bridge/cadence/cdns-mhdp8546-core.c:cdns_mhdp_bridge_ato=
mic_destroy_state(),
the function dereferences the state parameter without verifying it is non-N=
ULL:

    struct cdns_mhdp_bridge_state *cdns_mhdp_state;

    cdns_mhdp_state =3D to_cdns_mhdp_bridge_state(state);

    if (cdns_mhdp_state->current_mode) {

Could this cause a NULL pointer dereference if atomic_destroy_state() is ca=
lled=20
after a failed initialization?

>  	return &cdns_mhdp_state->base;
>  }

[ ... ]

> diff --git a/drivers/gpu/drm/drm_atomic_state_helper.c b/drivers/gpu/drm/=
drm_atomic_state_helper.c
> index cc70508d4fdba..f79d259fe5506 100644
> --- a/drivers/gpu/drm/drm_atomic_state_helper.c
> +++ b/drivers/gpu/drm/drm_atomic_state_helper.c

[ ... ]

> @@ -848,7 +848,7 @@ drm_atomic_helper_bridge_reset(struct drm_bridge *bri=
dge)
>  	if (!bridge_state)
>  		return ERR_PTR(-ENOMEM);
> =20
> -	__drm_atomic_helper_bridge_reset(bridge, bridge_state);
> +	__drm_atomic_helper_bridge_state_init(bridge, bridge_state);
>  	return bridge_state;
>  }

[Severity: High]
This isn't a bug introduced by this patch, but I noticed an error propagati=
on=20
issue when reviewing the atomic state allocation lifecycle.

In drivers/gpu/drm/drm_bridge.c:drm_bridge_attach(), the return value of
drm_atomic_private_obj_init() is ignored:

    if (drm_bridge_is_atomic(bridge))
            drm_atomic_private_obj_init(bridge->dev, &bridge->base,
                                        &drm_bridge_priv_state_funcs);

    return 0;

If the initial atomic state allocation fails, drm_atomic_private_obj_init()=
=20
returns -ENOMEM, but drm_bridge_attach() continues and returns 0.

Does this leave the bridge successfully attached to the pipeline but with a=
=20
NULL atomic state (bridge->base.state =3D=3D NULL)? Could this set up the N=
ULL=20
pointer dereferences mentioned earlier, and should drm_bridge_attach() be=20
updated to handle this error?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260608-drm-no-mor=
e-bridge-reset-v2-0-0a91018bf886@kernel.org?part=3D3
