Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9211FC43327
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:45:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F1BC610F76E;
	Sat, 27 Jun 2026 03:45:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="G3+/s20N";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6693C10F76E
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:45:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4755D41319;
 Sat, 27 Jun 2026 03:45:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB191F000E9;
 Sat, 27 Jun 2026 03:45:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782531907;
 bh=ActzxCDTuUvG4wJNeoKp/L1c7EyJ06guswSDGoF4XFI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=G3+/s20NO8U6XN2Dla9ZM+tL2qgWY+mdSXaTH7RIlhrg/YNvNzjQtiwNMMpmn0BVy
 32BfI4J3DrUFyl7CkwEPygX8Zg4HTuK4wbhxXmq6N6i/d+Uwp3J1NSc0qQRamc9S9U
 ro5FSQn7ocZOSFEO0z8fIGxpusncWAjC3NGkmtUhNHuXsJK/xaNDRSglOG2dy5ujhm
 P9mNXXLzSd+lclq+/YZnBVRRHG0agVnUp03yIl0Sl4msXekm/+H05Mgs23FZ72CByW
 Lq9mRcJ1LRPbeqCLzSJfQNAfD7CvzWjP9ucMHJWRkEp6RNxf0h3zcEYAV8s+EPVNEq
 Q0qYXGi4DcXjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 23/38] drm/vkms: Introduce configfs for plane format
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-23-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-23-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:45:06 +0000
Message-Id: <20260627034506.ECB191F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Strict length validation in `plane_supported_formats_store` reject=
s valid shell inputs containing trailing newlines.
- [High] Type punning between a `char` array and `int *` causes unaligned m=
emory accesses and produces corrupted FourCC codes on big-endian architectu=
res.
- [High] Missing `plane->dev->enabled` check in `plane_supported_formats_st=
ore` allows userspace to modify formats while the device is active, causing=
 a Use-After-Free.
- [Medium] Incorrect pointer arithmetic in `vkms_configfs_parse_next_format=
` results in a negative length, defeating bounds checking for `strnchr`.
- [Low] `vkms_configfs_parse_next_format` is completely unused in the opera=
tional driver and causes a build failure when KUnit is disabled.
--

commit a7abf4a30e4c9317197078c2d2f5f96c79800929
Author: Louis Chauvet <louis.chauvet@bootlin.com>
Subject: drm/vkms: Introduce configfs for plane format

This commit introduces a configfs interface to configure the available
formats per planes in VKMS. It adds parsing logic and test cases to
allow userspace to test multiple hardware configurations.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c

[ ... ]

> +static ssize_t plane_supported_formats_show(struct config_item *item, ch=
ar *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +
> +	plane =3D plane_item_to_vkms_configfs_plane(item);
> +
> +	page[0] =3D '\0';
> +
> +	scoped_guard(mutex, &plane->dev->lock) {
> +		u32 *formats =3D vkms_config_plane_get_supported_formats(plane->config=
);
> +
> +		for (int i =3D 0;
> +		     i < vkms_config_plane_get_supported_formats_count(plane->config);
> +		     i++) {
> +			char tmp[6] =3D { 0 };
> +			const ssize_t ret =3D snprintf(tmp, ARRAY_SIZE(tmp), "%.*s\n",
> +					       (int)sizeof(*formats),
> +					       (char *)&formats[i]);

[Severity: High]
Does this cast to a char pointer cause endianness issues on big-endian
architectures?

Since DRM FourCC codes are strictly little-endian, interpreting the integer
directly as a character array might reverse the format string on big-endian
machines.

> +			if (ret < 0)
> +				return ret;

[ ... ]

> +VISIBLE_IF_KUNIT
> +int vkms_configfs_parse_next_format(const char *page, const char *page_e=
nd, char **out)

[Severity: Low]
Since this function isn't called anywhere in the operational driver paths, =
does
it cause a -Wunused-function build failure when CONFIG_KUNIT is disabled and
VISIBLE_IF_KUNIT evaluates to static?

> +{
> +	int count =3D page - page_end;

[Severity: Medium]
Since page comes before page_end in memory, won't this calculation result i=
n a
negative count?

When passed to strnchr() which takes a size_t, won't this negative value
become a massive positive integer and bypass the bounds check?

> +	char *tmp_plus =3D strnchr(page, count, '+');
> +	char *tmp_minus =3D strnchr(page, count, '-');

[ ... ]

> +static ssize_t plane_supported_formats_store(struct config_item *item,
> +					     const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane;
> +
> +	plane =3D plane_item_to_vkms_configfs_plane(item);
> +	int ret =3D 0;
> +
> +	if (count < 2 || count > 5)
> +		return -EINVAL;
> +
> +	if (page[0] !=3D '+' && page[0] !=3D '-')
> +		return -EINVAL;
> +
> +	if (page[1] =3D=3D '*' && count !=3D 2)
> +		return -EINVAL;

[Severity: High]
Does this rigid length validation reject standard shell inputs?

When users configure the format using standard commands like
echo "+AR24" > supported_formats, the shell appends a trailing newline,
making the count 6 instead of 5. For echo "+*", the count becomes 3 instead
of 2.

Will this prevent userspace from using the interface as documented?

> +
> +	scoped_guard(mutex, &plane->dev->lock) {

[Severity: High]
Should there be a check here to ensure the device is not enabled, similar to
other configfs store functions like plane_zpos_enabled_store()?

If userspace modifies or clears the supported formats while the virtual DRM
device is active, vkms_config_plane_remove_all_formats() frees the formats
array. Could this lead to a use-after-free if the rendering pipeline is
concurrently accessing it?

For example, shouldn't we have:
	if (plane->dev->enabled)
		return -EBUSY;

> +		char fmt[4] =3D {' ', ' ', ' ', ' '};
> +
> +		memcpy(fmt, &page[1], min(count - 1, 4));
> +
> +		if (page[0] =3D=3D '+' && page[1] =3D=3D '*')
> +			ret =3D vkms_config_plane_add_all_formats(plane->config);
> +		else if (page[0] =3D=3D '-' && page[1] =3D=3D '*')
> +			vkms_config_plane_remove_all_formats(plane->config);
> +		else if (page[0] =3D=3D '+')
> +			ret =3D vkms_config_plane_add_format(plane->config, *(int *)fmt);

[Severity: High]
Does casting this 4-byte character array to an int pointer risk alignment
faults?

If the character array on the stack is not 4-byte aligned, won't this cause
a panic on architectures that enforce strict alignment?

Additionally, similar to the show() function, does this type punning create
endianness issues on big-endian systems?

> +		else if (page[0] =3D=3D '-')
> +			vkms_config_plane_remove_format(plane->config, *(int *)fmt);
> +
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return count;
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D23
