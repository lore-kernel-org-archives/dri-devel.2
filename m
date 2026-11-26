Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08A39606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:40:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dGGjPYGh
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73844112368;
	Thu, 26 Nov 2026 11:40:20 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9E076112368
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:40:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BA15C611A8;
 Thu, 26 Nov 2026 11:40:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5EC991F000D0;
 Thu, 26 Nov 2026 11:40:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693213;
 bh=kdOqKyiPgGwpF0zgK4tlfjZS8VUyjFW7AmjmK54DWUY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dGGjPYGhzy7HfY3Zu3pudqLpMH7+kKMFWSfcmWFRxyGVkLugal/RFbZcL/dIgZexb
 GH1ilyM+r8v0tm7mL8xMdKSuTXm5z6SxIwIcECfOVG+qQK7hz4ZQ1d6qL8eCRrHQpd
 UCF45u1r45tv8ipqz7h8QV/FSK0eMeUtSU52rk27DJSGocWpJyTCN/zuaFn57olzJN
 i9aq/Lh0oAygxTXW+bx39HCUOGjEAmuRepHnGlmhnRvt5DmnyicD6DiGJxa6lkTqAG
 pIwrCB49yb5tDzEH2/WHl6/q/2UKk8RFBjCJ8zu0ok+an8LAMb4V5GRrLc85/+kZYp
 HIhxd3E8BuDYQ==
Message-ID: <sashiko-outbox-235397@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 03/43] drm/blend: Get a rotation name from its bitfield
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-3-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-3-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:40:12 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/blend: unneeded extraction of rotation_props[] and
  duplicated rotation names
--

commit 1ed6793c09db95dc37f1bc98ca275a5ad9c3ac91
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/blend: Get a rotation name from its bitfield

This commit adds the DRM_ROTATION_FMT and DRM_ROTATION_FMT_ARGS() helpers
to print human-readable rotation bitmasks and moves the rotation property
enum array to file scope.

> diff --git a/drivers/gpu/drm/drm_blend.c b/drivers/gpu/drm/drm_blend.c
> index d17ae964fb21f..b62f1db9c3114 100644
> --- a/drivers/gpu/drm/drm_blend.c
> +++ b/drivers/gpu/drm/drm_blend.c
> @@ -256,6 +256,15 @@ int drm_plane_create_alpha_property(struct drm_plane=
 *plane)
>  }
>  EXPORT_SYMBOL(drm_plane_create_alpha_property);
> =20
> +static const struct drm_prop_enum_list rotation_props[] =3D {
> +	{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
> +	{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
> +	{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
> +	{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
> +	{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
> +	{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
> +};
> +
>  /**
>   * drm_plane_create_rotation_property - create a new rotation property
>   * @plane: drm plane
> @@ -294,14 +303,6 @@ int drm_plane_create_rotation_property(struct drm_pl=
ane *plane,
>  				       unsigned int rotation,
>  				       unsigned int supported_rotations)
>  {
> -	static const struct drm_prop_enum_list props[] =3D {
> -		{ __builtin_ffs(DRM_MODE_ROTATE_0) - 1,   "rotate-0" },
> -		{ __builtin_ffs(DRM_MODE_ROTATE_90) - 1,  "rotate-90" },
> -		{ __builtin_ffs(DRM_MODE_ROTATE_180) - 1, "rotate-180" },
> -		{ __builtin_ffs(DRM_MODE_ROTATE_270) - 1, "rotate-270" },
> -		{ __builtin_ffs(DRM_MODE_REFLECT_X) - 1,  "reflect-x" },
> -		{ __builtin_ffs(DRM_MODE_REFLECT_Y) - 1,  "reflect-y" },
> -	};
>  	struct drm_property *prop;
> =20
>  	WARN_ON((supported_rotations & DRM_MODE_ROTATE_MASK) =3D=3D 0);
> @@ -309,7 +310,7 @@ int drm_plane_create_rotation_property(struct drm_pla=
ne *plane,
>  	WARN_ON(rotation & ~supported_rotations);
> =20
>  	prop =3D drm_property_create_bitmask(plane->dev, 0, "rotation",
> -					   props, ARRAY_SIZE(props),
> +					   rotation_props, ARRAY_SIZE(rotation_props),
>  					   supported_rotations);
>  	if (!prop)
>  		return -ENOMEM;
> diff --git a/include/drm/drm_blend.h b/include/drm/drm_blend.h
> index bebbb77a8f214..f000b10a16e70 100644
> --- a/include/drm/drm_blend.h
> +++ b/include/drm/drm_blend.h
[ ... ]
> +#define DRM_ROTATION_FMT_ARGS(rot) \
> +	((rot) & DRM_MODE_ROTATE_0)   ? "rotate-0 "   : "", \
> +	((rot) & DRM_MODE_ROTATE_90)  ? "rotate-90 "  : "", \
> +	((rot) & DRM_MODE_ROTATE_180) ? "rotate-180 " : "", \
> +	((rot) & DRM_MODE_ROTATE_270) ? "rotate-270 " : "", \
> +	((rot) & DRM_MODE_REFLECT_X)  ? "reflect-x "  : "", \
> +	((rot) & DRM_MODE_REFLECT_Y)  ? "reflect-y "  : "", \
> +	(rot)

[Severity: Low]
Why move props[] out of drm_plane_create_rotation_property() to file-scope
rotation_props[] when DRM_ROTATION_FMT_ARGS() hardcodes its own copy of
the rotation strings?  rotation_props[] remains static in drm_blend.c with
drm_plane_create_rotation_property() as its only user, so either the array
can stay local to that function (and the commit message updated) or the
string definitions should be shared.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D3
