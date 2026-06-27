Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6BBCAC43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:45:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C586810F771;
	Sat, 27 Jun 2026 03:45:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="RG56GhRV";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82D4B10F771
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:45:44 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0716D600AA;
 Sat, 27 Jun 2026 03:45:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81FB11F000E9;
 Sat, 27 Jun 2026 03:45:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531943;
 bh=f4au30Ws7NnS80HGCE6SGLBbHbRIdjAlmWDaDj8RFOk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=RG56GhRVoqASxH3zIO1gQZvXQjgX44YtTksjEt7qMZl4MrMdlpMH4N4KQIspoCZzj
 Zv/1hyjG0JnL+9oNRU9kq2SZGA6M1Qv+lPaYgE6MP2UgFQKjXjbsUgI8kUxzuVgJKX
 rBUe0dxAL2n/jWhmorNp4ypDetd12LLWsZCATEaHTwp8wacrox59uPywdHyPBCLZT1
 XvikSlK0NXcYaL3CGeOg8BmVSs2Cc/kl8NvzHNbhP+y45g7D75nD6shHp0ZXnGAMy8
 irnFxyGHczdGUgMGQIfo5kbUzpKdJYFqS3ajdIyT0XKkSNx6yLJISzFfYQvAxMovR6
 /swNgNAcTj6UA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 21/38] drm/vkms: Introduce configfs for plane color
 range
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-21-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-21-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:45:43 +0000
Message-Id: <20260627034543.81FB11F000E9@smtp.kernel.org>
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
- [Medium] ConfigFS store callbacks enforce base 10 parsing, which rejects =
documented hexadecimal bitmask inputs.
- [Low] kstrtouint() is called with an 'int *' instead of 'unsigned int *',=
 generating an incompatible pointer type warning.
- [Low] ConfigFS 'show' callbacks omit a trailing newline.
--

commit 75e6ca29907842441c00bd1bce2c7956d8a33c79
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for plane color range
   =20
To allows the userspace to test many hardware configuration, introduce a
new interface to configure the available color ranges per planes. VKMS
supports multiple color ranges, so the userspace can choose any
combination.

> diff --git a/Documentation/ABI/testing/configfs-vkms b/Documentation/ABI/=
testing/configfs-vkms
> index a9ee05fe0c66a..ef0c3da6b3ca1 100644
> --- a/Documentation/ABI/testing/configfs-vkms
> +++ b/Documentation/ABI/testing/configfs-vkms

[ ... ]

> @@ -132,6 +132,21 @@ Description:
>  	Default color encoding presented to userspace, same
>  	values as supported_color_encoding.
> =20
> +What:		/sys/kernel/config/vkms/<device>/planes/<plane>/supported_color_r=
anges
> +Date:		Nov 2025
> +Contact:	dri-devel@lists.freedesktop.org
> +Description:
> +	Available color ranges for the plane, as a bitmask:
> +	0x1 - DRM_COLOR_YCBCR_LIMITED_RANGE,
> +	0x2 - DRM_COLOR_YCBCR_FULL_RANGE.
> +
> +What:		/sys/kernel/config/vkms/<device>/planes/<plane>/default_color_ran=
ge
> +Date:		Nov 2025
> +Contact:	dri-devel@lists.freedesktop.org
> +Description:
> +	Default color range presented to userspace, same
> +	values as supported_color_ranges.
> +

[ ... ]

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index c1d1841b2c5a5..56a0c542a143f 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c

[ ... ]

> @@ -410,6 +417,85 @@ static ssize_t plane_default_rotation_store(struct c=
onfig_item *item,
>  	return count;
>  }
> =20
> +static ssize_t plane_supported_color_ranges_show(struct config_item *ite=
m, char *page)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	unsigned int supported_color_ranges;
> +
> +	scoped_guard(mutex, &plane->dev->lock)
> +		supported_color_ranges =3D vkms_config_plane_get_supported_color_range=
s(plane->config);
> +
> +	return sprintf(page, "%u", supported_color_ranges);

[Severity: Low]
Does this configfs show callback omit a trailing newline? Usually, configfs=
=20
attributes include a newline in their format string for better readability=
=20
with standard userspace tools.

> +}
> +
> +static ssize_t plane_supported_color_ranges_store(struct config_item *it=
em,
> +						  const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	int ret, val =3D 0;
> +
> +	ret =3D kstrtouint(page, 10, &val);

[Severity: Low]
Is this passing an int pointer to kstrtouint() instead of an unsigned int=20
pointer? Will this mismatch generate a compiler warning about incompatible=
=20
pointer types in plane_supported_color_ranges_store()?

[Severity: Medium]
Will this base 10 parsing reject the hexadecimal values documented in the A=
BI?
The documentation above suggests inputs like 0x1 and 0x2, but using base 10=
=20
here will cause kstrtouint() to reject strings prefixed with 0x. Should thi=
s=20
use base 0 instead?

> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~VKMS_SUPPORTED_COLOR_RANGES)
> +		return -EINVAL;
> +	/* Should at least provide one color range */
> +	if ((val & VKMS_SUPPORTED_COLOR_RANGES) =3D=3D 0)
> +		return -EINVAL;
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		if (plane->dev->enabled)
> +			return -EBUSY;
> +
> +		vkms_config_plane_set_supported_color_ranges(plane->config, val);
> +	}
> +
> +	return count;
> +}
> +
> +static ssize_t plane_default_color_range_show(struct config_item *item, =
char *page)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	unsigned int default_color_range;
> +
> +	scoped_guard(mutex, &plane->dev->lock)
> +		default_color_range =3D vkms_config_plane_get_default_color_range(plan=
e->config);
> +
> +	return sprintf(page, "%lu", BIT(default_color_range));

[Severity: Low]
Is it missing a newline character here as well?

> +}
> +
> +static ssize_t plane_default_color_range_store(struct config_item *item,
> +					       const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	int ret, val =3D 0;
> +
> +	ret =3D kstrtouint(page, 10, &val);

[Severity: Low]
Does this code have the same pointer type mismatch issue as above in=20
plane_default_color_range_store(), passing an int pointer to a function=20
expecting an unsigned int pointer?

[Severity: Medium]
Also, does this base 10 parsing conflict with the hexadecimal inputs shown =
in
the ABI documentation?

> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D21
