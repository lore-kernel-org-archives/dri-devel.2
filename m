Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0B40C43458
	for <dri-devel@archiver.kernel.org>; Sat, 27 Jun 2026 03:46:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 11AD710F774;
	Sat, 27 Jun 2026 03:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="WEmVgleF";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D844910F774
 for <dri-devel@lists.freedesktop.org>; Sat, 27 Jun 2026 03:46:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id B5CCD40C1B;
 Sat, 27 Jun 2026 03:46:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7146B1F000E9;
 Sat, 27 Jun 2026 03:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782532015;
 bh=jb6Q9spMh979ZOZn7/z1fqEmJCu7yaMT+mM4cExOOKQ=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=WEmVgleF+ImfOhNRUAy0SOVJy11VSDjyfroLoRE82ozHk7BSaCwS9nQrwv1etswJ5
 UlaZPkLzSRlipGnMwsedN01eWHOvRLHh48syuIlLF6PT0wdMj7aPRfQAzLhCxhbV0V
 u3rMMCwx3NEbo4uHSLbvZR7qg8B8XH8OPSVcFaj2vG+36H8rn9ouckE+Rw1iSTjh3D
 eI3xWrR6NDkZOaz9ojPtW9E739/6vC5Fr8Ij/UuJWlSKTwyi6VVExzofi+G7XYteJO
 +ggr3hmt8JiDDSQ8zcTAjsMRQfIhKrKcvfDEOEAmEiW1i0zkpcmXe3wL+BNmz3RuR5
 a6DWpsgWF3fxA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 26/38] drm/vkms: Introduce configfs for plane zpos
 property
To: "Louis Chauvet" <louis.chauvet@bootlin.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260627-vkms-all-config-v5-26-854aa0840926@bootlin.com>
References: <20260627-vkms-all-config-v5-0-854aa0840926@bootlin.com>
 <20260627-vkms-all-config-v5-26-854aa0840926@bootlin.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 27 Jun 2026 03:46:55 +0000
Message-Id: <20260627034655.7146B1F000E9@smtp.kernel.org>
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

Pre-existing issues:
- [Critical] Heap buffer overflow in `vkms_crtc_atomic_check` due to array =
indexing with `normalized_zpos` exceeding allocated size based on visible p=
lanes.
- [High] Memory leak and ghost object creation in `make_plane_group` if `vk=
ms_config_plane_set_name` fails.
- [High] Unaligned memory access when parsing fourcc formats in `plane_supp=
orted_formats_store`.
--

commit 05c48fc3bf3ce414a2c90cff7116e67058f16eb1
Author: Louis Chauvet <louis.chauvet@bootlin.com>

drm/vkms: Introduce configfs for plane zpos property

This commit introduces configfs attributes for managing the zpos property
of VKMS planes. It adds attributes to configure whether zpos is enabled,
mutable, its initial value, and its min/max boundaries.

> diff --git a/drivers/gpu/drm/vkms/vkms_configfs.c b/drivers/gpu/drm/vkms/=
vkms_configfs.c
> index e6cb245b8582d..95f4594fb683d 100644
> --- a/drivers/gpu/drm/vkms/vkms_configfs.c
> +++ b/drivers/gpu/drm/vkms/vkms_configfs.c
> @@ -687,6 +687,176 @@ static ssize_t plane_supported_formats_store(struct=
 config_item *item,
>  	return count;
>  }
> =20

[Severity: High]
This isn't a bug introduced by this patch, but can this unaligned memory
access in plane_supported_formats_store() cause a kernel panic on strict
alignment architectures?

When userspace writes a new format string, the input is copied into a
4-byte char array on the stack, which is then cast to an int pointer and
dereferenced:

drivers/gpu/drm/vkms/vkms_configfs.c:plane_supported_formats_store() {
	...
	scoped_guard(mutex, &plane->dev->lock) {
		char fmt[4] =3D {' ', ' ', ' ', ' '};

		memcpy(fmt, &page[1], min(count - 1, 4));
		...
		else if (page[0] =3D=3D '+')
			ret =3D vkms_config_plane_add_format(plane->config, *(int *)fmt);
		...
}

Since a char array only guarantees 1-byte alignment, the 32-bit dereference
can trigger an unaligned access exception.

[Severity: Critical]
This is a pre-existing issue, but does this array indexing overflow the
active_planes array in vkms_crtc_atomic_check()?

The active_planes array is allocated with a size equal to the number of
strictly visible planes:

drivers/gpu/drm/vkms/vkms_crtc.c:vkms_crtc_atomic_check() {
	...
	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
		plane_state =3D drm_atomic_get_new_plane_state(crtc_state->state, plane);
		WARN_ON(!plane_state);

		if (!plane_state->visible)
			continue;
		i++;
	}

	vkms_state->active_planes =3D kzalloc_objs(*vkms_state->active_planes, i);
	...

However, the array is populated using normalized_zpos as the index:

	...
	drm_for_each_plane_mask(plane, crtc->dev, crtc_state->plane_mask) {
		plane_state =3D drm_atomic_get_new_plane_state(crtc_state->state, plane);

		if (!plane_state->visible)
			continue;

		// Order planes according to their normalized_zpos
		// After drm_atomic_normalize_zpos, the possible values are 0..n_planes-1
		// so store them using this index
		vkms_state->active_planes[plane_state->normalized_zpos] =3D
			to_vkms_plane_state(plane_state);
	}
	...
}

If a user configures some planes as invisible but gives a visible plane a
higher zpos than the invisible ones, drm_atomic_normalize_zpos() will assign
the visible plane a normalized_zpos value greater than or equal to the total
number of strictly visible planes, resulting in an out-of-bounds write.

[Severity: High]
This is a pre-existing issue, but does make_plane_group() leak the
internal vkms_config_plane object and create a ghost plane if setting
the name fails?

drivers/gpu/drm/vkms/vkms_configfs.c:make_plane_group() {
	...
		plane->config =3D vkms_config_create_plane(dev->config);
		if (IS_ERR(plane->config)) {
			ret =3D PTR_ERR(plane->config);
			kfree(plane);
			return ERR_PTR(ret);
		}

		ret =3D vkms_config_plane_set_name(plane->config, name, strlen(name));
		if (ret) {
			kfree(plane);
			return ERR_PTR(ret);
		}
	...
}

If vkms_config_plane_set_name() returns an error, the configfs wrapper
is freed, but vkms_config_destroy_plane(plane->config) is not called.

The internal object remains in dev->config->planes. Because it will never
have a CRTC attached, vkms_config_is_valid() will always fail, permanently
preventing the device from being enabled.

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260627-vkms-all-c=
onfig-v5-0-854aa0840926@bootlin.com?part=3D26
