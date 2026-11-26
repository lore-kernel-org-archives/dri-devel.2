Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C709C606A31E
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:45:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Z2isuqjw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33D2A112377;
	Thu, 26 Nov 2026 11:45:32 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8431B10E99D
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:45:23 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 398BC44450;
 Thu, 26 Nov 2026 11:45:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C2461F000CF;
 Thu, 26 Nov 2026 11:45:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693522;
 bh=Wp4+oY/sZ/ye5pFoEADzreQEyWyYoQFg2uu6lc6V9po=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=Z2isuqjwg7eVXLMZ8d2W4XJuJs/XF7s65/+AIg7MtWFOESaohPxals1OQLoMavTHt
 JbSrG96KBorTCKCrYq5chmQzO2YCEvApTFJzfSvCIeygmTDWHmgjQ2+sFDo2NlAN45
 /GlBoljvIGd7IXAb/GZwVEd0tTIR+559sf85oebBGIW+cVKoGDOoZNhBncBGy57X4c
 JYlAIzxQ2FdFmLAAPVjO809jfV6kBh4bSHV2SAaUHXfGsBZazpw5pm3LdzyyYE0bcq
 16MpPQy6xKr6OhmlnZXPEvEYJNdyXgTTZXZPQD1pZeRCai9Z2wJTfzmrB7mGcnauNN
 TDncOxB3CtMzw==
Message-ID: <sashiko-outbox-235413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 24/43] drm/vkms: Introduce configfs for plane color
 range
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-24-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-24-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:45:22 +0000
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

Thank you for your contribution! Sashiko AI review found 3 potential
issues to consider:
- [Medium] drm/vkms: plane_supported_color_ranges_store() rejects 0
  bitmask
- [Medium] drm/vkms: plane_default_color_range_store() rejects hex
  bitmasks via base 10
- [Low] drm/vkms: type mismatch in plane_default_color_range_store()
  kstrtouint() call
--

commit 43491ccf15c9b0119d0720030c6887bb6debdc75
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for plane color range

This commit adds supported_color_ranges and default_color_range configfs
attributes for VKMS planes and documents them.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index c6efc6db64c46..a746fb5e22a37 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -410,6 +417,86 @@ static ssize_t plane_default_rotation_store(struct c=
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
> +	scoped_guard(mutex, &plane->dev->config->lock)
> +		supported_color_ranges =3D vkms_config_plane_get_supported_color_range=
s(plane->config);
> +
> +	return sprintf(page, "%u\n", supported_color_ranges);
> +}
> +
> +static ssize_t plane_supported_color_ranges_store(struct config_item *it=
em,
> +						  const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	int ret;
> +	unsigned int val =3D 0;
> +
> +	ret =3D kstrtouint(page, 0, &val);
> +	if (ret)
> +		return ret;
> +
> +	/* Should be a supported value */
> +	if (val & ~VKMS_SUPPORTED_COLOR_RANGES)
> +		return -EINVAL;
> +	/* Should at least provide one color range */
> +	if ((val & VKMS_SUPPORTED_COLOR_RANGES) =3D=3D 0)
> +		return -EINVAL;

[Severity: Medium]
Should plane_supported_color_ranges_store() allow writing 0 to disable the
COLOR_RANGE property?

vkms_config_create_plane() initializes supported_color_ranges to a non-zero
mask, and vkms_config_is_valid() requires supported_color_encodings and
supported_color_ranges to either both be set or both be 0:

drivers/gpu/drm/vkms/vkms_config.c:vkms_config_is_valid() {
    ...
		if ((vkms_config_plane_get_supported_color_encodings(plane_cfg) =3D=3D 0)=
 !=3D
		    (vkms_config_plane_get_supported_color_ranges(plane_cfg) =3D=3D 0)) {
			drm_info(dev,
				 "Both supported color encodings and color ranges must be set, or none\=
n");
			return false;
		}
    ...
}

While plane_supported_color_encodings_store() allows writing 0, rejecting 0
here prevents userspace from disabling YCbCr color properties on a plane via
configfs, and setting supported_color_encodings to 0 leaves the device
configuration invalid.

[ ... ]
> +static ssize_t plane_default_color_range_store(struct config_item *item,
> +					       const char *page, size_t count)
> +{
> +	struct vkms_configfs_plane *plane =3D plane_item_to_vkms_configfs_plane=
(item);
> +	int ret, val =3D 0;

[Severity: Low]
This isn't a runtime bug because (val & ~VKMS_SUPPORTED_COLOR_RANGES) rejec=
ts
negative values, but val is declared as a signed int while kstrtouint() tak=
es
an unsigned int *, triggering a -Wpointer-sign mismatch.

> +
> +	ret =3D kstrtouint(page, 10, &val);

[Severity: Medium]
Should kstrtouint() use base 0 instead of base 10 here?

Documentation/gpu/vkms.rst states that default_color_range accepts the same
values as supported_color_ranges (documented as 0x1 and 0x2), and the other
bitmask store callbacks such as plane_default_color_encoding_store() use
base 0.  Passing base 10 causes hexadecimal inputs like 0x1 or 0x2 to fail
with -EINVAL.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D24
