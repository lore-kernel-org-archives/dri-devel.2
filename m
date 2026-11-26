Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80CD1606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 11:49:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=kgnfJY6+
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E2577112382;
	Thu, 26 Nov 2026 11:49:27 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D742D112382
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Nov 2026 11:49:20 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A988E439F3;
 Thu, 26 Nov 2026 11:49:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0755D1F000CF;
 Thu, 26 Nov 2026 11:49:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1795693760;
 bh=KVEJMsRkH40qNLPw+7zICsx1VaomR+ia0F2lXBVVTUE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=kgnfJY6+j5GIyVX3ut2AOFPlM/fZhmALhqZ/6b93jh+00/6S8Ta62+CpZjW8V7qao
 zx7LIyeTwOFI1hHR/lcmX9IpJ8HRmCXZZaEI4f+setrPKf0yUQekh7vFy1KFxMDbke
 jgyHZTNhkaSoW+8Rp8RIdCVrfg8UXvwFS6Tk49VTKmUDeUnO4xdQaIv5q9aw3BfzA1
 5d6OHxhHEbDqA3zWRDqXKnx7qL35MsAdRLipZylPEFOjFXcb7BPzbc4H9RwtbHPoVX
 6c+FmICdqcPmKXFRSDRDF8vPPLpSmzmbEeAQ0b/pNRlveC/9768OkmC5yi40CQq306
 8g6YNgL+ceyMg==
Message-ID: <sashiko-outbox-235425@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 26/43] drm/vkms: Introduce configfs for plane format
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261126-vkms-all-config-v7-26-21194cda2468@bootlin.com>
References: <20261126-vkms-all-config-v7-0-21194cda2468@bootlin.com>
 <20261126-vkms-all-config-v7-26-21194cda2468@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 26 Nov 2026 11:49:19 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [Medium] drm/vkms: endianness bug in plane_supported_formats_show()
  and _store()
- [Medium] drm/vkms: UAF on supported_formats in
  plane_supported_formats_store()
--

commit fdd01181d213d1bc98312c36d05a5fcad23b5664
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for plane format

This commit adds a configfs attribute to configure the supported pixel
formats for each VKMS plane.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index a746fb5e22a37..9f24e9e6ed6d0 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
[ ... ]
> @@ -576,6 +577,88 @@ static ssize_t plane_default_color_encoding_store(st=
ruct config_item *item,
>  	return count;
>  }
> =20
> +static ssize_t plane_supported_formats_show(struct config_item *item, ch=
ar *page)
> +{
> +	struct vkms_configfs_plane *plane;
> +
> +	plane =3D plane_item_to_vkms_configfs_plane(item);
> +
> +	page[0] =3D '\0';
> +
> +	scoped_guard(mutex, &plane->dev->config->lock) {
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
[ ... ]
> +static ssize_t plane_supported_formats_store(struct config_item *item,
> +					     const char *page, size_t count)
> +{
[ ... ]
> +	scoped_guard(mutex, &plane->dev->config->lock) {
> +		if (plane->dev->enabled)
> +			return -EBUSY;
> +
> +		char fmt[4] =3D {' ', ' ', ' ', ' '};
> +		u32 fourcc;
> +
> +		memcpy(fmt, &page[1], min(count - 1, 4));
> +
> +		if (page[0] =3D=3D '+' && page[1] =3D=3D '*')
> +			ret =3D vkms_config_plane_add_all_formats(plane->config);
> +		else if (page[0] =3D=3D '-' && page[1] =3D=3D '*')
> +			vkms_config_plane_remove_all_formats(plane->config);
> +		else if (page[0] =3D=3D '+') {
> +			memcpy(&fourcc, fmt, sizeof(fourcc));
> +			ret =3D vkms_config_plane_add_format(plane->config, fourcc);
> +		} else if (page[0] =3D=3D '-') {
> +			memcpy(&fourcc, fmt, sizeof(fourcc));
> +			vkms_config_plane_remove_format(plane->config, fourcc);
> +		}

[Severity: Medium]
Are formats[i] and fourcc byte-reversed on big-endian architectures?

fourcc_code(a, b, c, d) defines DRM format constants as host-endian u32
values with 'a' in the least significant byte.  On big-endian machines,
casting &formats[i] to char * in plane_supported_formats_show() prints the
four characters in reverse order (for example, "42RA" instead of "AR24"),
and copying fmt into fourcc with memcpy() in
plane_supported_formats_store() produces a byte-swapped value that never
matches vkms_supported_plane_formats[], causing additions to fail with
-EINVAL and removals to be ignored.

Building the format code with fourcc_code(fmt[0], fmt[1], fmt[2], fmt[3])
in _store() and unpacking each byte in _show() would make this independent
of host endianness.

[Severity: Medium]
Can plane_supported_formats_store() cause a use-after-free or NULL pointer
dereference in vkms_config_show()?

vkms_config_show() reads plane_cfg->supported_formats and
plane_cfg->supported_formats_count under RCU without holding config->lock.
When device_enabled_store() disables a device, it clears dev->enabled and
drops dev->config->lock before calling vkms_destroy(), while the
vkms_config debugfs file is still registered:

CPU0                                CPU1
device_enabled_store()
  lock(&dev->config->lock)
  dev->enabled =3D false
  unlock(&dev->config->lock)
                                    vkms_config_show()
                                      rcu_read_lock()
                                      show_formats(m,
                                        plane_cfg->supported_formats,
                                        plane_cfg->supported_formats_count)
                                    plane_supported_formats_store()
                                      lock(&dev->config->lock)
                                      /* sees !plane->dev->enabled */
                                      vkms_config_plane_add_format()
                                        krealloc_array(supported_formats, .=
..)
                                      unlock(&dev->config->lock)
                                        ...
                                        seq_printf(m, ..., &formats[i])
                                          <-- use-after-free
  vkms_destroy(dev->config)

Similarly, if plane_supported_formats_store() calls
vkms_config_plane_remove_all_formats(), kfree(plane_cfg->supported_formats)
runs immediately without waiting for an RCU grace period, and a concurrent
vkms_config_show() can pass either a freed pointer or NULL with a non-zero
count to show_formats().

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261126-vkms-all-c=
onfig-v7-0-21194cda2468@bootlin.com?part=3D26
