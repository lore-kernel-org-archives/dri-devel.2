Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E69ACC43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:43:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 343DE10F767;
	Sat, 27 Jun 2026 03:43:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="aaRO9boO";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AF8110F764
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:43:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 484F040DD9;
 Sat, 27 Jun 2026 03:43:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 02C151F000E9;
 Sat, 27 Jun 2026 03:43:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531822;
 bh=egPXmliUZEnuIPEYXDkI6fQJXWJkokF5wiRYzXPwa8g=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=aaRO9boOYil5dVWn+Z4OP4UYrK21k7ioG274z6z/ha2l6ehxEI4FfpPiFMvlpD7sM
 plLWpnLXDq8mi5CTPlHTtaHOcBF/Esb6ujun/ZZjYjP22+CnG+Z6wxpBQZeDQ2GgnO
 5NCQynehL4fjlzS0lAy1IB7Z5cfC/tRs9RgM2dnvt+7QP2jUSR/RLErVrNtmP+EwDF
 Siy6NxGYDOfWT9ew+EuoBSja7rEfzadI+gLRVriIe1ecxCUFSJkdgBdNf91jzDOxqM
 epREV/20zUrSegkIhS8qBV8JOkQeZNVs0Vhwj8yHq7OdjdcRAp13FGosqIcqgnD72p
 ABaF/+HnrKSlg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 14/38] drm/vkms: Use plane folder name as plane name
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-14-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-14-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:43:41 +0000
Message-Id: <20260627034342.02C151F000E9@smtp.kernel.org>
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
- [High] User-provided plane name from configfs is used directly as a forma=
t string in `drmm_universal_plane_alloc()`.
- [Medium] Missing cleanup of `plane->config` on the `vkms_config_plane_set=
_name()` error path in `make_plane_group()`.
- [Medium] `drm_get_rotation_name` incorrectly uses a rotation mask as an a=
rray index, contrary to its documentation.
--

commit 71fdf3bbf310c477150a383e21a3c104a2d6795c
Author: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: drm/vkms: Use plane folder name as plane name

The plane name is now directly derived from the configfs folder name. When a
plane directory is created under /config/vkms/<device>/planes/, the folder
name is used as the plane name via vkms_config_plane_set_name.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index 97f87a53d202a..0744ac40814d8 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -377,6 +377,12 @@ static struct config_group *make_plane_group(struct =
config_group *group,
>  			return ERR_PTR(ret);
>  		}
> =20
> +		ret =3D vkms_config_plane_set_name(plane->config, name, strlen(name));

[Severity: High]
Could this introduce a format string regression?

Since this user-provided configfs folder name is stored as the plane name,
it appears it gets passed directly as the format string parameter to
drmm_universal_plane_alloc() later during initialization:

drivers/gpu/drm/vkms/vkms_plane.c:vkms_plane_init()
    plane =3D drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
        &vkms_plane_funcs,
        vkms_config_plane_get_supported_formats(plane_cfg),
        vkms_config_plane_get_supported_formats_count(plane_cfg),
        NULL, vkms_config_plane_get_type(plane_cfg),
        vkms_config_plane_get_name(plane_cfg));

If a user creates a configfs directory with a name containing printf-style
format specifiers (e.g., "%s%n"), can it lead to a kernel crash or memory
corruption?

> +		if (ret) {
> +			kfree(plane);

[Severity: Medium]
Is there a regression in this error path where it leaves a dangling plane
configuration?

If vkms_config_plane_set_name() fails (e.g., due to memory allocation
failure), this calls kfree(plane). However, it seems plane->config was
already appended to dev->config->planes prior to this, but we don't call
vkms_config_destroy_plane(plane->config) here.

Can this leave a ghost plane in the device configuration that lacks a
corresponding configfs directory?

> +			return ERR_PTR(ret);
> +		}
> +
>  		config_group_init_type_name(&plane->group, name, &plane_item_type);
> =20
>  		config_group_init_type_name(&plane->possible_crtcs_group,

[Severity: Medium]
Will the following logic in drm_get_rotation_name() cause a regression by
incorrectly using a rotation mask as an array index?

In drivers/gpu/drm/drm_blend.c:drm_get_rotation_name():

    const char *drm_get_rotation_name(unsigned int rotation)
    {
        if (rotation < ARRAY_SIZE(rotation_props))
            return rotation_props[rotation].name;

        return "(unknown)";
    }

The documentation for this function explicitly states the rotation parameter
expects a rotation mask (DRM_MODE_ROTATE_* | DRM_MODE_REFLECT_*). However,
the implementation expects an array index (0-5) and incorrectly uses the
mask as an index.

For example, passing the mask DRM_MODE_ROTATE_90 (which is 2) returns
"rotate-180" (the value at index 2).

Can this cause incorrect strings to be returned to new drivers or core code
using this exported function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D14
