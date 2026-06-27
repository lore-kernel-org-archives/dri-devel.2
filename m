Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 02116C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:49:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 32B0510F77B;
	Sat, 27 Jun 2026 03:49:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WNEfTqyA";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B0BFF10F77B
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:49:03 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 34F53600AA;
 Sat, 27 Jun 2026 03:49:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCE041F000E9;
 Sat, 27 Jun 2026 03:49:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532142;
 bh=3NDovQkvmxXDpUMdJ8miaPf7LEZiD9dzqzY/VrKfXto=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WNEfTqyAjt6CoDCWldeTYyI9nKctcyjj/cVxQgGx6aEAj5UHkkEpfeCmI98eOti+M
 wrGd6KmGdulERJb/lj6Vx4Hq/ttOa/xozPrWGEeS+I+mSDn3jCreDRsYq4TmYO2HD6
 j9W1dvN/wUJfqJP76zZBueIkvjEZQ8jnVQHD8CnUttbpvohauLZtK8YGUUzqzPnDCx
 CJCe2xjqlh2YfyKDrwfI6EaXxl56sMnmCzyeX+V3OhY2BuuIo+YUFqw+CZD/XBpXo9
 X/6CJS9ZvkATPU1BWYzU7Pj5CCSDwn9qXCr+z5o9L0smtdUhdHm4v5ntVT1rMvO4Ld
 n+5f6Bi8iU8WA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 19/38] drm/vkms: Introduce configfs for plane color
 encoding
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-19-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-19-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:49:02 +0000
Message-Id: <20260627034902.CCE041F000E9@smtp.kernel.org>
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
- [Medium] Rejecting a value of 0 prevents testing planes without color enc=
odings.
- [Low] Passing an `int *` to a function expecting `unsigned int *` causes =
an incompatible-pointer-types compiler warning.
- [Low] Double assignment typo in variable declaration.
--

commit 14a18de4798714722e237eb41b51bd75e7c7cd56
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for plane color encoding
   =20
This patch introduces a configfs interface to configure the supported and
default color encodings for VKMS planes. It allows userspace to test differ=
ent
hardware configurations regarding color encoding bitmasks.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index 47b3a4aeee8dd..c1d1841b2c5a5 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c

[ ... ]

> @@ -402,14 +410,98 @@ static ssize_t plane_default_rotation_store(struct =
config_item *item,
>  	return count;
>  }
> =20
> +static ssize_t plane_supported_color_encodings_show(struct config_item *=
item, char *page)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	unsigned int supported_color_encodings;
> +
> +	scoped_guard(mutex, &plane->dev->lock)
> +		supported_color_encodings =3D vkms_config_plane_get_supported_color_en=
codings(plane->config);
> +
> +	return sprintf(page, "%u", supported_color_encodings);
> +}
> +
> +static ssize_t plane_supported_color_encodings_store(struct config_item =
*item,
> +						     const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	int ret, val =3D 0;
> +
> +	ret =3D kstrtouint(page, 10, &val);

[Severity: Low]
Does this pass an int pointer to kstrtouint() instead of an unsigned int
pointer? This might trigger an incompatible-pointer-types compiler warning.

> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~(VKMS_SUPPORTED_COLOR_ENCODINGS))
> +		return -EINVAL;
> +	/* Should at least provide one color encoding */
> +	if ((val & (VKMS_SUPPORTED_COLOR_ENCODINGS)) =3D=3D 0)
> +		return -EINVAL;

[Severity: Medium]
Does rejecting 0 here prevent userspace from configuring a VKMS plane witho=
ut
color encodings?

It looks like the VKMS configuration API and kunit tests support a value of=
 0 to
emulate an RGB-only plane. Blocking 0 here might unnecessarily limit the ha=
rdware
configurations that can be tested.

> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		if (plane->dev->enabled)
> +			return -EBUSY;
> +
> +		vkms_config_plane_set_supported_color_encodings(plane->config, val);
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t plane_default_color_encoding_show(struct config_item *ite=
m, char *page)
> +{
> +	struct vkms_configfs_plane *plane =3D plane =3D plane_item_to_vkms_conf=
igfs_plane(item);

[Severity: Low]
This isn't a bug, but there is an accidental double assignment to the plane
variable here.

> +	unsigned int default_color_encoding;
> +
> +	scoped_guard(mutex, &plane->dev->lock)
> +		default_color_encoding =3D BIT(vkms_config_plane_get_default_color_enc=
oding(plane->config));
> +
> +	return sprintf(page, "%u", default_color_encoding);
> +}
> +
> +static ssize_t plane_default_color_encoding_store(struct config_item *it=
em,
> +						  const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	int ret, val =3D 0;
> +
> +	ret =3D kstrtouint(page, 10, &val);

[Severity: Low]
Similar to plane_supported_color_encodings_store(), does this pass an int
pointer to kstrtouint() instead of an unsigned int pointer?

> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~VKMS_SUPPORTED_COLOR_ENCODINGS)
> +		return -EINVAL;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D19
