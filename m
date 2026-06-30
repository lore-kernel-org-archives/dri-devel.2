Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B969FC43458
	for <dri-devel@archiver.kernel.org>; Tue, 30 Jun 2026 08:57:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0C8BB10E1CD;
	Tue, 30 Jun 2026 08:57:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="Fonf/Jof";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB7A310E1CD
 for <dri-devel@lists.freedesktop.org>; Tue, 30 Jun 2026 08:57:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A9A03404D9;
 Tue, 30 Jun 2026 08:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6CC6B1F000E9;
 Tue, 30 Jun 2026 08:57:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782809835;
 bh=xs8kwXy+FYDN0o/rWDx7YWfWekc8TbHLF40vzVXaaRg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Fonf/JofNTemM90+tR0IPydGSGrQXcP0PVkSH72wVCLBO7wrae7Y3RlY8WJXppnqL
 3ID4ZcnyS/ETFvg0k0mLZQgNCLlyziAWgjiFLt5YB8TYDsOZ/hlhc1DLXd5cLKHX9b
 2idT1FPSgQjGfe8WTN0YCPTYB8WZAze/kkrfIUejwmoG7Fui/4qs1eNp8Aiw1Pq8w8
 B6l1N2XVDHl849Puxky434Ous6gNFGiSRXEAkcWG/dHoSwiujxYOybx5WYct5oKGTQ
 fg9SM6qZLfdxeo6M3nxkhZaICA4nUXd8sxKL3yxilYEy2HKeO580Ij0XuyQ++yUToA
 VPotvXCK/dlNQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/4] drm/vkms: Add DRIVER_PLANE_COLOR_PIPELINE driver
 feature
To: "Robert Mader" <robert.mader@collabora.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260630084229.529682-5-robert.mader@collabora.com>
References: <20260630084229.529682-1-robert.mader@collabora.com>
 <20260630084229.529682-5-robert.mader@collabora.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 30 Jun 2026 08:57:14 +0000
Message-Id: <20260630085715.6CC6B1F000E9@smtp.kernel.org>
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
- [High] Enabling the global plane color pipeline feature breaks color mana=
gement on configfs planes.
- [High] Implicit BT601 YUV-to-RGB conversion is unconditionally applied be=
fore the color pipeline, breaking BT709/BT2020 support.
--

commit 131af6dd345d5805b19305ccac226f92ac37e694
Author: Robert Mader <robert.mader@collabora.com>

drm/vkms: Add DRIVER_PLANE_COLOR_PIPELINE driver feature

Which is now required for DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE. Only
enable it if the enable_plane_pipeline option is enabled so otherwise
the legacy flags COLOR_ENCODING and COLOR_RANGE continue to be
supported.

> diff --git a/drivers/gpu/drm/vkms/vkms_drv.c b/drivers/gpu/drm/vkms/vkms_=
drv.c
> index 434c295f44ba6..33caf3c0c671a 100644
> --- a/drivers/gpu/drm/vkms/vkms_drv.c
> +++ b/drivers/gpu/drm/vkms/vkms_drv.c
> @@ -91,7 +91,8 @@ static void vkms_atomic_commit_tail(struct drm_atomic_s=
tate *old_state)
>  }
> =20
>  static const struct drm_driver vkms_driver =3D {
> -	.driver_features	=3D DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM,
> +	.driver_features	=3D DRIVER_MODESET | DRIVER_ATOMIC | DRIVER_GEM |
> +				  DRIVER_PLANE_COLOR_PIPELINE,

[Severity: High]
When DRIVER_PLANE_COLOR_PIPELINE is enabled, does it cause an implicit
BT601 YUV-to-RGB conversion that breaks BT709/BT2020 support?

Enabling DRM_CLIENT_CAP_PLANE_COLOR_PIPELINE locks color_encoding to BT601.
This causes vkms_plane_atomic_update() to unconditionally populate the
conversion matrix with BT601:

drivers/gpu/drm/vkms/vkms_plane.c:vkms_plane_atomic_update() {
    ...
    get_conversion_matrix_to_argb_u16(fmt, new_state->color_encoding,
                                      new_state->color_range,
                                      &vkms_plane_state->conversion_matrix);
    ...
}

Then in blend_line(), the YUV-to-RGB conversion and clamping occurs before
the color pipeline is executed:

drivers/gpu/drm/vkms/vkms_composer.c:blend_line() {
    ...
    current_plane->pixel_read_line(current_plane, src_x_start, src_y_start,
                                   direction, pixel_count,
                                   &stage_buffer->pixels[dst_x_start]);
    pre_blend_color_transform(current_plane, stage_buffer);
    ...
}

Will this unconditionally convert and clamp YUV buffers to RGB using the
BT601 matrix before the pipeline can process them, making it impossible
to correctly handle BT709 or BT2020 content?

>  	.fops			=3D &vkms_driver_fops,
>  	DRM_GEM_SHMEM_DRIVER_OPS,
>  	DRM_FBDEV_SHMEM_DRIVER_OPS,

[ ... ]

> @@ -184,6 +185,9 @@ int vkms_create(struct vkms_config *config)
>  	vkms_device->config =3D config;
>  	config->dev =3D vkms_device;
> =20
> +	if (!enable_plane_pipeline)
> +		vkms_device->drm.driver_features &=3D ~DRIVER_PLANE_COLOR_PIPELINE;
> +

[Severity: High]
Does enabling this global driver feature break color management for configfs
planes?

When the pipeline feature is enabled, DRM core hides legacy COLOR_ENCODING
and COLOR_RANGE. However, in vkms_config_create_plane(), the pipeline is
hardcoded to false for dynamically created planes:

drivers/gpu/drm/vkms/vkms_config.c:vkms_config_create_plane() {
    ...
    plane_cfg->default_pipeline =3D false;
    ...
}

Will this cause configfs-created planes to completely lack any color
management properties since they do not get COLOR_PIPELINE initialized?

>  	ret =3D dma_coerce_mask_and_coherent(vkms_device->drm.dev,
>  					   DMA_BIT_MASK(64));

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260630084229.5296=
82-1-robert.mader@collabora.com?part=3D4
