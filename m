Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EB21C606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 18:36:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=OvF4geI6
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E269910F07F;
	Tue, 24 Nov 2026 18:36:53 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2186010F07F;
 Tue, 24 Nov 2026 18:36:47 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 00B7A40755;
 Tue, 24 Nov 2026 18:36:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D7DC1F000C0;
 Tue, 24 Nov 2026 18:36:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795545406;
 bh=5yLBf4o5pgrxgmTnGSPSbYuvg9hdYwf+uiscFG6x/NU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=OvF4geI6HQS7Q7VZ1H/MDMvEuTYdoh39HZ2cMplljZVAOa4J38eGE4O8O4JS8lBpy
 Oodyp34iFd5HCW0CtkCDKb4SpNHpwH5SN5bvbETq+NXeoudff4Y8yhggsDoTDbrFBr
 rn5hHzMz4aQbB1kXT1wGqieREHv4E25nJ02D9fMjUKU3JkbpU3IMJzVdqGZ6ixDLlX
 j/WRIvWFNrw7sjZifpKwHz/i7bNeJuIDg0erh4gOzTw7W9NV5vjX99OWrJEfDkOwLK
 71TzAXBmSLABJwXMLkRNijmfkqYmjcScg6mNXiVEnir2vgy0pZMxbDlZHl3x6ZnMPK
 ZMaDQHkoW2mwA==
Message-ID: <sashiko-outbox-231833@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 10/19] drm/colorop: Factor out common paths from
 colorops helpers
To: "Melissa Wen" <mwen@igalia.com>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261124181652.1333986-11-mwen@igalia.com>
References: <20261124181652.1333986-1-mwen@igalia.com>
 <20261124181652.1333986-11-mwen@igalia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 24 Nov 2026 18:36:45 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [Low] drm/colorop: missing @funcs kernel-doc and deleted curve_1d_init
  kernel-doc
--

commit de778a21ac78648776da670a0d86b55bc392e7de
Author: N=C3=ADcolas F. R. A. Prado <nfraprado@collabora.com>

drm/colorop: Factor out common paths from colorops helpers

This commit factors out common initialization helpers from the plane
colorop helpers so they can be shared with post-blend colorop helpers.

> diff --git a/drivers/gpu/drm/drm_colorop.c b/drivers/gpu/drm/drm_colorop.c
> index 6b15df55c84f3..baef70460da93 100644
> --- a/drivers/gpu/drm/drm_colorop.c
> +++ b/drivers/gpu/drm/drm_colorop.c

[ ... ]

> @@ -220,45 +236,14 @@ void drm_colorop_pipeline_destroy(struct drm_device=
 *dev)
>  }
>  EXPORT_SYMBOL(drm_colorop_pipeline_destroy);
> =20
> -/**
> - * drm_plane_colorop_curve_1d_init - Initialize a DRM_COLOROP_1D_CURVE
> - *
> - * @dev: DRM device
> - * @colorop: The drm_colorop object to initialize
> - * @plane: The associated drm_plane
> - * @funcs: control functions for the new colorop
> - * @supported_tfs: A bitfield of supported drm_plane_colorop_curve_1d_in=
it enum values,
> - *                 created using BIT(curve_type) and combined with the O=
R '|'
> - *                 operator.
> - * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> - * @return zero on success, -E value on failure
> - */
> -int drm_plane_colorop_curve_1d_init(struct drm_device *dev, struct drm_c=
olorop *colorop,
> -				    struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
> -				    u64 supported_tfs, uint32_t flags)
> +static int drm_common_colorop_curve_1d_init(struct drm_device *dev,
> +					    struct drm_colorop *colorop,
> +					    u64 supported_tfs, uint32_t flags)

[ ... ]

> @@ -363,18 +370,44 @@ int drm_plane_colorop_curve_1d_lut_init(struct drm_=
device *dev, struct drm_color
> =20
>  	return 0;
>  }
> -EXPORT_SYMBOL(drm_plane_colorop_curve_1d_lut_init);
> =20
> -int drm_plane_colorop_ctm_3x4_init(struct drm_device *dev, struct drm_co=
lorop *colorop,
> -				   struct drm_plane *plane, const struct drm_colorop_funcs *funcs,
> -				   uint32_t flags)
> +/**
> + * drm_plane_colorop_curve_1d_lut_init - Initialize a DRM_COLOROP_1D_LUT
> + *
> + * @dev: DRM device
> + * @colorop: The drm_colorop object to initialize
> + * @plane: The associated drm_plane
> + * @lut_size: LUT size supported by driver
> + * @lut1d_interpolation: 1D LUT interpolation type
> + * @flags: bitmask of misc, see DRM_COLOROP_FLAG_* defines.
> + * @return zero on success, -E value on failure
> + */
> +int
> +drm_plane_colorop_curve_1d_lut_init(struct drm_device *dev,
> +				    struct drm_colorop *colorop,
> +				    struct drm_plane *plane,
> +				    const struct drm_colorop_funcs *funcs,
> +				    uint32_t lut_size,
> +				    enum drm_colorop_lut1d_interpolation_type lut1d_interpolation,
> +				    uint32_t flags)

[Severity: Low]
The updated kernel-doc comment for drm_plane_colorop_curve_1d_lut_init()
drops @funcs while the function still takes const struct
drm_colorop_funcs *funcs, which triggers a scripts/kernel-doc warning on
W=3D1 and htmldocs builds.  Also, the kernel-doc comment for the exported
drm_plane_colorop_curve_1d_init() function was removed above instead of
being kept on drm_plane_colorop_curve_1d_init().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261124181652.1333=
986-1-mwen@igalia.com?part=3D10
