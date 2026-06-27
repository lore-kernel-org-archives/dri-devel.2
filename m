Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1565C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:41:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2111F10F758;
	Sat, 27 Jun 2026 03:41:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="V9Be/Y6K";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AD48710F758
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:41:40 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 83266435E7;
 Sat, 27 Jun 2026 03:41:40 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 513991F000E9;
 Sat, 27 Jun 2026 03:41:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531700;
 bh=sWfaON/BakPWgSJOs7qggtsiZS6vB0PT2FFW1ElEmjs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=V9Be/Y6KUfZNvm7y0J1m5XhpnHcIdMFFWHPi/nAzkx4WPvPUHhVK7NJlqbzBjmbGg
 GtZ2y/n7jK18VJ6Zt+e9RZVvcn5S3ViUhoaPHign2EeSSFOmnQYH86D24amWvtxVKP
 HJcF1N0mbBYVY7dFhjDhyDF3aFlLkzSQf5UsSNSaLIm5LpLms5DhA5qGO6M1WIQCbq
 Fv6Di4uh2GUzhijeXO8bwFftnroX0+aLWQ0QmUtekEzJpkyf2Enk13Uh+ndKGlb4dE
 x3B1eKFOLXWl7bHON0pvq6a526IVNK2GOogHcafxAtpD4jmEel0jrLq/uUlLgSL0ks
 wExdvmjADNIOA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 25/38] drm/vkms: Introduce config for plane zpos
 property
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-25-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-25-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:41:39 +0000
Message-Id: <20260627034140.513991F000E9@smtp.kernel.org>
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
- [Medium] The return values of `drm_plane_create_zpos_property()` and `drm=
_plane_create_zpos_immutable_property()` are ignored.
- [Low] Missing newline character `\n` at the end of the `drm_info` format =
string.
- [Low] Using signed format specifiers (`%d`) for unsigned integer variable=
s in debugfs output.
--

commit 332270a595e6e9b34ad7075f21dc26e1c7579078
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce config for plane zpos property

VKMS can render plane in any order. Introduce the appropriate
configuration.

> diff --git a/drivers/gpu/drm/vkms/vkms_config.c b/drivers/gpu/drm/vkms/vk=
ms_config.c
> index c7de3e3073674..5bc8248f99353 100644
> --- a/drivers/gpu/drm/vkms/vkms_config.c
> +++ b/drivers/gpu/drm/vkms/vkms_config.c
[ ... ]
> @@ -429,6 +462,19 @@ bool vkms_config_is_valid(const struct vkms_config *=
config)
>  				 "Both supported color encodings and color ranges must be set, or no=
ne\n");
>  			return false;
>  		}
> +
> +		if (!vkms_config_valid_plane_zpos(config, plane_cfg))
> +			return false;
> +
> +		if (vkms_config_plane_get_zpos_enabled(plane_cfg))
> +			has_zpos_enabled =3D true;
> +		else
> +			has_zpos_disabled =3D true;
> +	}
> +
> +	if (has_zpos_enabled && has_zpos_disabled) {
> +		drm_info(dev, "In the same device, all planes must have zpos enabled o=
r none of them");

[Severity: Low]
Is this missing a newline character? Log messages without a trailing \n
can cause formatting issues by buffering and attaching to the next message.

> +		return false;
>  	}
> =20
>  	if (!valid_plane_number(config))
[ ... ]
> @@ -527,6 +573,16 @@ static int vkms_config_show(struct seq_file *m, void=
 *data)
>  		show_formats(m, vkms_config_plane_get_supported_formats(plane_cfg),
>  			     vkms_config_plane_get_supported_formats_count(plane_cfg));
>  		seq_puts(m, "\n");
> +		seq_printf(m, "\tzpos_enabled=3D%s\n",
> +			   str_true_false(vkms_config_plane_get_zpos_enabled(plane_cfg)));
> +		seq_printf(m, "\tzpos_mutable=3D%s\n",
> +			   str_true_false(vkms_config_plane_get_zpos_mutable(plane_cfg)));
> +		seq_printf(m, "\tzpos_min=3D%d\n",
> +			   vkms_config_plane_get_zpos_min(plane_cfg));
> +		seq_printf(m, "\tzpos_initial=3D%d\n",
> +			   vkms_config_plane_get_zpos_initial(plane_cfg));
> +		seq_printf(m, "\tzpos_max=3D%d\n",
> +			   vkms_config_plane_get_zpos_max(plane_cfg));

[Severity: Low]
Should these use the %u format specifier instead of %d? The getter=20
functions (like vkms_config_plane_get_zpos_min) return unsigned int,=20
so %d might display large values as negative numbers.

>  	}
> =20
>  	vkms_config_for_each_crtc(vkmsdev->config, crtc_cfg) {
[ ... ]
> diff --git a/drivers/gpu/drm/vkms/vkms_plane.c b/drivers/gpu/drm/vkms/vkm=
s_plane.c
> index 6e767cdf81942..d600a6167042b 100644
> --- a/drivers/gpu/drm/vkms/vkms_plane.c
> +++ b/drivers/gpu/drm/vkms/vkms_plane.c
[ ... ]
> @@ -214,6 +214,17 @@ struct vkms_plane *vkms_plane_init(struct vkms_devic=
e *vkmsdev,
> =20
>  	if (vkms_config_plane_get_default_pipeline(plane_cfg))
>  		vkms_initialize_colorops(&plane->base);
> +	if (vkms_config_plane_get_zpos_enabled(plane_cfg)) {
> +		if (vkms_config_plane_get_zpos_mutable(plane_cfg)) {
> +			drm_plane_create_zpos_property(&plane->base,
> +						       vkms_config_plane_get_zpos_initial(plane_cfg),
> +						       vkms_config_plane_get_zpos_min(plane_cfg),
> +						       vkms_config_plane_get_zpos_max(plane_cfg));
> +		} else {
> +			drm_plane_create_zpos_immutable_property(&plane->base,
> +								 vkms_config_plane_get_zpos_initial(plane_cfg));
> +		}
> +	}

[Severity: Medium]
Is it safe to ignore the return values of drm_plane_create_zpos_property()
and drm_plane_create_zpos_immutable_property() here?=20

These functions can return -ENOMEM on allocation failure. If that happens,=
=20
the plane is partially initialized without the expected zpos property,=20
which might confuse userspace applications. Should we propagate the error=20
up through vkms_plane_init()?

> =20
>  	return plane;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D25
