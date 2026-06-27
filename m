Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 748BBC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:46:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF99410E43B;
	Sat, 27 Jun 2026 03:46:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="YLn7G6U/";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 269C910E43B
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:46:13 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 9DF2D600AA;
 Sat, 27 Jun 2026 03:46:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2B4631F000E9;
 Sat, 27 Jun 2026 03:46:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531972;
 bh=c8AHlhMU3qwN1v68DzoFJW9WPfdpqBGi/A2dKXtz5rU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=YLn7G6U/l4Z4ecLCkz9bUqBee3jV/LKKfxomYEUO5O6uXxLzQ0r1z5/v90YGmcors
 NyQVqwGGxT2H21Z4D2sc9UhuEqDhxxRqRG2bBPGZxWR2CDLoFITa0KIVvuBHl6LijP
 znlmCrA/G+1D4pjCHFRGixu1HISyP8iZR8rHBacYhmBabNWwM22IV7pk7wxaDaSspN
 MmG7T1YYoPMMeLkgzaVmyRx4K3js7KJGXF0IDIfVgcyt1JRDg6SsObdcsm9rq5ShAN
 KuVaijK+0AbUFBK0/+hW4/V5O961m+Qlu9xWIOE0fDTa+OV/qFkPnUgBdY/Mfb6oob
 VQ4T1n2NGt0aQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 22/38] drm/vkms: Introduce config for plane format
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-22-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-22-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:46:11 +0000
Message-Id: <20260627034612.2B4631F000E9@smtp.kernel.org>
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
- [High] Format string vulnerability when initializing planes due to user-c=
ontrolled plane name.
- [Medium] vkms_config_is_valid() does not verify that a plane has at least=
 one supported format.
- [Medium] Leaked plane configuration on configfs directory creation failur=
e causes permanent device validation failure.
--

commit c410d8e3fb25dbafdefe89a122662119e6e4c5a1
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane format

VKMS driver supports all the pixel formats for planes, but for testing it
can be useful to only advertise few of them. This new configuration
interface will allow configuring the pixel format per planes.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index 5538716467617..c7de3e3073674 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -658,6 +712,80 @@ static struct vkms_config_plane *vkms_config_crtc_ge=
t_plane(const struct vkms_co
>  	return NULL;
>  }
> =20
> +int __must_check vkms_config_plane_add_all_formats(struct vkms_config_pl=
ane *plane_cfg)
> +{
[ ... ]
> +void vkms_config_plane_remove_all_formats(struct vkms_config_plane *plan=
e_cfg)
> +{
> +	plane_cfg->supported_formats_count =3D 0;
> +	kfree(plane_cfg->supported_formats);
> +	plane_cfg->supported_formats =3D NULL;
> +}

[Severity: Medium]
Since we can now remove all formats, shouldn't vkms_config_is_valid() verify
that a plane has at least one supported format?=20

If a plane has 0 supported formats, drm_universal_plane_init() will trigger=
 a
WARN_ON and fail the initialization when the device is enabled.

> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index d4ccf418198e8..6e767cdf81942 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
[ ... ]
> @@ -227,7 +191,8 @@ struct vkms_plane *vkms_plane_init(struct vkms_device=
 *vkmsdev,
> =20
>  	plane =3D drmm_universal_plane_alloc(dev, struct vkms_plane, base, 0,
>  					   &vkms_plane_funcs,
> -					   vkms_formats, ARRAY_SIZE(vkms_formats),
> +					   vkms_config_plane_get_supported_formats(plane_cfg),
> +					   vkms_config_plane_get_supported_formats_count(plane_cfg),
>  					   NULL, vkms_config_plane_get_type(plane_cfg),
>  					   vkms_config_plane_get_name(plane_cfg));

[Severity: High]
Does this code introduce a format string vulnerability?

The user-controlled plane name is passed directly as the format string
argument to drmm_universal_plane_alloc() without a "%s" format specifier.
If userspace passes a name containing format specifiers (e.g. "%s%x"),
this could cause an out-of-bounds memory read or kernel crash when
kvasprintf() is called.

While reviewing these changes, I noticed a related issue in make_plane_grou=
p()
in drivers/gpu/drm/vkms/vkms_configfs.c:

drivers/gpu/drm/vkms/vkms_configfs.c:make_plane_group()
[ ... ]
		ret =3D vkms_config_plane_set_name(plane->config, name, strlen(name));
		if (ret) {
			kfree(plane);
			return ERR_PTR(ret);
		}
[ ... ]

[Severity: Medium]
Does this error path leak the plane configuration?

If setting the plane name fails, the configfs object plane is freed but it
fails to call vkms_config_destroy_plane(plane->config). This leaves the
unusable configuration object permanently attached to the device list,
causing vkms_config_is_valid() to unconditionally fail later.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D22
