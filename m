Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 942B5C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:42:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E6EFE10F75A;
	Sat, 27 Jun 2026 03:42:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JKdZM/fe";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 490D410F75A
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:42:34 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 285844374A;
 Sat, 27 Jun 2026 03:42:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CFCC51F000E9;
 Sat, 27 Jun 2026 03:42:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531754;
 bh=RoTy5ZjYChXyfYZV9bnGcmz+bmWkX1GNY/GEuzGSEno=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JKdZM/fe3rckYXoP4jnPhaxCW6xjn0ccG6bPLsmcGmbtCFnPGHI8Dti10kn17Q32A
 BHN0dKDL1+KHGj2dLurQJFwh7AbUYN48AxPZL5QkwDczh0rsd98YcApXJxuVonoqjp
 RJ/usDg52WlAo+cK1cnOKzQJs9MxVUzylVhu8pau8ihRbCFH2jhOgz24annyJXZJPy
 k7ww4IjvhszfnRig7iBady1g6DTzRJZKOsD/yJ1VZFNYi9LL6gGdW6OMqDIzP/xaUf
 YDZRVJBjiSGhgAYrmrMWLkQ/L+W+3XkP6JXL9TjZWJkGJNTGgdIKexqakGCy7Llahb
 7BuTygt01qjJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 15/38] drm/vkms: Introduce config for plane rotation
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-15-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-15-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:42:33 +0000
Message-Id: <20260627034233.CFCC51F000E9@smtp.kernel.org>
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
- [Medium] vkms_config_valid_plane_rotation() incorrectly allows multiple b=
ase rotation bits to be set in default_rotation, which will trigger a kerne=
l WARNING.
- [Low] The validation check ensuring that supported_rotations contains at =
least one rotation is mathematically unreachable dead code.
--

commit f25358e4a8dbe82dcc32cb1193229da2bf2b59f3
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane rotation

This commit introduces a new configuration interface that allows customizin=
g=20
the supported rotations for each plane. This is useful for testing specific=
=20
rotation setups without advertising all possible plane rotations.

> diff --git a/drivers/gpu/drm/vkms/tests/vkms_config_test.c b/drivers/gpu/=
drm/vkms/tests/vkms_config_test.c
> index 1e4ea1863420f..c33fe737678ff 100644
> --- a/drivers/gpu/drm/vkms/tests/vkms_config_test.c
> +++ b/drivers/gpu/drm/vkms/tests/vkms_config_test.c
[ ... ]
> @@ -481,6 +488,44 @@ static void vkms_config_test_valid_plane_type(struct=
 kunit *test)
[ ... ]
> +	/* Invalid, supported rotations must contains at least one rotation */
> +	vkms_config_plane_set_supported_rotations(plane_cfg, DRM_MODE_REFLECT_M=
ASK);
> +	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_REFLECT_X | =
DRM_MODE_ROTATE_0);
> +	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane=
_cfg));

[Severity: Low]
Does this test actually verify the intended check?

Since default_rotation is not a subset of supported_rotations here, this te=
st=20
fails the earlier subset check in vkms_config_valid_plane_rotation(),=20
meaning it never actually reaches the supported_rotations validation check.

> +	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
> +
> +	/* Invalid, default rotation must contains at least one rotation */
> +	vkms_config_plane_set_supported_rotations(plane_cfg,
> +						  DRM_MODE_REFLECT_MASK | DRM_MODE_ROTATE_0);
> +	vkms_config_plane_set_default_rotation(plane_cfg, DRM_MODE_REFLECT_X);
> +	KUNIT_EXPECT_FALSE(test, vkms_config_valid_plane_rotation(config, plane=
_cfg));
> +	KUNIT_EXPECT_FALSE(test, vkms_config_is_valid(config));
> +
> +	vkms_config_destroy(config);
> +}
> +
>  static void vkms_config_test_valid_plane_possible_crtcs(struct kunit *te=
st)
>  {
>  	struct vkms_config *config;
> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index 54994f3c8e144..5c86eb24fedf3 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -150,6 +151,33 @@ static bool valid_plane_number(const struct vkms_con=
fig *config)
>  	return true;
>  }
> =20
> +VISIBLE_IF_KUNIT
> +bool vkms_config_valid_plane_rotation(const struct vkms_config *config,
> +				      const struct vkms_config_plane *plane_cfg)
> +{
> +	struct drm_device *dev =3D config->dev ? &config->dev->drm : NULL;
> +
> +	if ((vkms_config_plane_get_default_rotation(plane_cfg) &
> +	     vkms_config_plane_get_supported_rotations(plane_cfg)) !=3D
> +	    vkms_config_plane_get_default_rotation(plane_cfg)) {
> +		drm_info(dev, "Configured default rotation is not supported by the pla=
ne\n");
> +		return false;
> +	}
> +
> +	if ((vkms_config_plane_get_default_rotation(plane_cfg) & DRM_MODE_ROTAT=
E_MASK) =3D=3D 0) {
> +		drm_info(dev, "Configured default rotation must contains at least one =
possible rotation\n");
> +		return false;
> +	}

[Severity: Medium]
Will this allow multiple base rotation bits (e.g., DRM_MODE_ROTATE_0 |=20
DRM_MODE_ROTATE_90) to be set simultaneously?

The API invariant in drm_plane_create_rotation_property() requires exactly =
one=20
base rotation angle and uses is_power_of_2() to check this. If multiple bit=
s=20
pass this validation here, it could trigger a kernel WARNING stack trace la=
ter=20
when creating the property.

Should this check use is_power_of_2() instead?

> +
> +	if ((vkms_config_plane_get_supported_rotations(plane_cfg) & DRM_MODE_RO=
TATE_MASK) =3D=3D 0) {

[Severity: Low]
Is this block mathematically unreachable dead code?

If default_rotation contains at least one rotation bit (from the previous c=
heck)=20
and default_rotation is a bitwise subset of supported_rotations (from the f=
irst=20
check), then supported_rotations is mathematically guaranteed to contain at=
 least=20
one rotation bit.

> +		drm_info(dev, "Configured supported rotations must contains at least o=
ne possible rotation\n");
> +		return false;
> +	}
> +
> +	return true;
> +}
> +EXPORT_SYMBOL_IF_KUNIT(vkms_config_valid_plane_rotation);
> +
[ ... ]
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index f351202031244..8a64ea41734b8 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
> @@ -235,8 +235,9 @@ struct vkms_plane *vkms_plane_init(struct vkms_device=
 *vkmsdev,
> =20
>  	drm_plane_helper_add(&plane->base, &vkms_plane_helper_funcs);
> =20
> -	drm_plane_create_rotation_property(&plane->base, DRM_MODE_ROTATE_0,
> -					   DRM_MODE_ROTATE_MASK | DRM_MODE_REFLECT_MASK);
> +	drm_plane_create_rotation_property(&plane->base,
> +					   vkms_config_plane_get_default_rotation(plane_cfg),
> +					   vkms_config_plane_get_supported_rotations(plane_cfg));

[Severity: Medium]
This is where the invalid configuration could be passed to the DRM core.

If vkms_config_valid_plane_rotation() allows a default_rotation mask with=20
multiple rotation bits, calling drm_plane_create_rotation_property() here w=
ill=20
trigger its WARN_ON() invariant check.

> =20
>  	drm_plane_create_color_properties(&plane->base,
>  					  BIT(DRM_COLOR_YCBCR_BT601) |

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D15
