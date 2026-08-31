Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04025C61DFD
	for <dri-devel@archiver.kernel.org>; Mon, 31 Aug 2026 20:02:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C45710E331;
	Mon, 31 Aug 2026 20:02:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="glVuNcqW";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A571710E379
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:02:24 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id B3E65601DE
 for <dri-devel@lists.freedesktop.org>; Mon, 31 Aug 2026 20:02:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4CC511F000E9;
 Mon, 31 Aug 2026 20:02:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788206543;
 bh=2wZ10qNBSma8cXYCiBz1QJb1ZosXSby94aj/KhCersw=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=glVuNcqW5Li08/PRxxE1zN4ZTTAMUJ4pa7bkHRTfVnR4yeqe61JgnvQim9JP+jqy3
 fYbhJgeFasTJhGl/04ltj8M4i2lXPJTyXqUWAU9vZSamGBJKOgeKZ0G6kNKsF9QXoy
 1f3inDXhj/eBu3p329tqBvEprc3ce0RZy8wPYKeftAvTVMKIBA4Ob6mrqVKY4bg6n1
 PDriktv6JckBqLwLZ9RW2LuJUwcIy/+VCNuMPd/AVND30pUOpG4g72xv5fPaVvVykq
 sVywBpbm6ovT94kjPpet3cvPpsbHpCltD3A/962zOLxzhp+HmnMM9nplfz565iQaBq
 rLeiHkozIkbZQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/13] drm/amdgpu: dm: Convert to atomic_create_state
To: "Maxime Ripard" <mripard@kernel.org>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260831-drm-no-more-crtc-reset-v2-7-4500d49a337f@kernel.org>
References: <20260831-drm-no-more-crtc-reset-v2-0-4500d49a337f@kernel.org>
 <20260831-drm-no-more-crtc-reset-v2-7-4500d49a337f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 20:02:22 +0000
Message-Id: <20260831200223.4CC511F000E9@smtp.kernel.org>
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
- [High] Use-after-free and list corruption in `amdgpu_dm_crtc_init()` erro=
r path.
--

commit 0347668ca054c8ea5682a0562b13ea3c763f5fc2
Author: Maxime Ripard <mripard@kernel.org>

drm/amdgpu: dm: Convert to atomic_create_state

This commit converts the AMDGPU DM CRTC implementation to use the
atomic_create_state hook rather than a custom reset hook. It initializes
the state with __drm_atomic_helper_crtc_state_init() and handles the
newly created state during CRTC initialization.

[ ... ]
> diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c b/dri=
vers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> index 62eac6e65334b..cfe1fbfbab8ea 100644
> --- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> +++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_crtc.c
> @@ -781,9 +780,18 @@ int amdgpu_dm_crtc_init(struct amdgpu_display_manage=
r *dm,
> =20
>  	drm_crtc_helper_add(&acrtc->base, &amdgpu_dm_crtc_helper_funcs);
> =20
> -	/* Create (reset) the plane state */
> -	if (acrtc->base.funcs->reset)
> -		acrtc->base.funcs->reset(&acrtc->base);
> +	/* Create the plane state */
> +	if (acrtc->base.funcs->atomic_create_state) {
> +		struct drm_crtc_state *crtc_state;
> +
> +		crtc_state =3D acrtc->base.funcs->atomic_create_state(&acrtc->base);
> +		if (IS_ERR(crtc_state)) {
> +			res =3D PTR_ERR(crtc_state);
> +			goto fail;

[Severity: High]
Does this error path leave dangling pointers in the DRM core lists?

This patch introduces a new failure point that jumps to the fail block after
the CRTC and plane have already been successfully initialized and linked via
drm_crtc_init_with_planes() earlier in amdgpu_dm_crtc_init().

Looking at the fail block in amdgpu_dm_crtc_init():

fail:
        kfree(acrtc);
        kfree(cursor_plane);
        return res;

Freeing acrtc and cursor_plane directly without unregistering them via
drm_crtc_cleanup() and drm_plane_cleanup() leaves freed memory linked in the
DRM mode configuration lists. Subsequent traversals of these lists will
dereference the freed memory, which can cause a kernel panic.=20

While the plane cleanup omission existed previously, the CRTC list corrupti=
on
was newly introduced in this patch.

> +		}
> +
> +		acrtc->base.state =3D crtc_state;
> +	}
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831-drm-no-mor=
e-crtc-reset-v2-0-4500d49a337f@kernel.org?part=3D7
