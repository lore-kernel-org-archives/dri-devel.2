Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 09A7EC5B572
	for <dri-devel@archiver.kernel.org>; Mon, 17 Aug 2026 12:50:02 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 29C2C10E7B0;
	Mon, 17 Aug 2026 12:50:01 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="lvueciUw";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81F5810E7B0
 for <dri-devel@lists.freedesktop.org>; Mon, 17 Aug 2026 12:50:00 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 272FC40AF4;
 Mon, 17 Aug 2026 12:50:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDCF81F000E9;
 Mon, 17 Aug 2026 12:49:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786971000;
 bh=//ikxSj9SzSISfMd9QfdIFtPXxTmC1vIOctbdD73WlI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=lvueciUwKoMwAA0RHLTJT29FyXUwEBN4Cw1gWozdW/rQR57h4PZDno+InkoqVnm/L
 m42dvaPO9EWkUoLmLIvmIspQZy5OITz5872llZR4y0yBvprvMt4yoUSQ3BrHEHgyzv
 5LlJDe5JV8O/nIcB9eX5nEoug3lOhAGq/sIYTIY3YDXazS9732NSx3LcBj2Sb3HOUx
 7ZJ10PNG248sfYifI8S30b0fjubCyhiY8y4Lq2nTMSsnXiugWdqkwI1ga7iKA9CS4Z
 MwTh7Ihi7baTF270ptKaBYQRkVmSbZX2yW1Agrhuq+pUOqutQVF2JGJt9lJvDU4o+m
 F+sqtORyCif2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm: Optimized by adding the TV modes attribute
To: "Edward Adam Davis" <eadavis@qq.com>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <tencent_C6A625E0BAF4BB77334C9E0F1B244B7B1B08@qq.com>
References: <6a829a95.dbb3a75c.20434b.0043.GAE@google.com>
 <tencent_C6A625E0BAF4BB77334C9E0F1B244B7B1B08@qq.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 12:49:59 +0000
Message-Id: <20260817124959.DDCF81F000E9@smtp.kernel.org>
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

New issues:
- [High] Unconditional recreation of DRM TV properties breaks atomic uAPI p=
roperty updates and causes memory leaks of `drm_property` objects.

Pre-existing issues:
- [High] Out-of-bounds read in TV mode name processing via `strlen()` due t=
o missing null-termination guarantees.
--

--- Patch [1]: [PATCH] drm: Optimized by adding the TV modes attribute ---
commit 5de13986f93b84f8b4c689b55a18d298dfc7431d
Author: Edward Adam Davis <eadavis@qq.com>

drm: Optimized by adding the TV modes attribute

When adding gud properties for drm connector within the function
gud_connector_add_properties(), if the TV modes property is not added
first, drm_mode_create_tv_properties_legacy() would fail to add the TV
modes property because the tv_select_subconnector_property has already
been added.

Closes: https://syzkaller.appspot.com/bug?extid=3D1944765c3659f63d3777

> diff --git a/drivers/gpu/drm/drm_connector.c b/drivers/gpu/drm/drm_connec=
tor.c
> index 8b4baed060f3a..7728c2941a701 100644
> --- a/drivers/gpu/drm/drm_connector.c
> +++ b/drivers/gpu/drm/drm_connector.c
> @@ -2201,8 +2201,12 @@ int drm_mode_create_tv_properties_legacy(struct dr=
m_device *dev,
>  	struct drm_property *tv_subconnector;
>  	unsigned int i;
> =20
> -	if (dev->mode_config.tv_select_subconnector_property)
> +	if (dev->mode_config.tv_select_subconnector_property) {
> +		if (num_modes && !dev->mode_config.legacy_tv_mode_property)
> +			goto other;
> +
>  		return 0;
> +	}
> =20
>  	/*
>  	 * Basic connector properties

[ ... ]

> @@ -2225,6 +2229,7 @@ int drm_mode_create_tv_properties_legacy(struct drm=
_device *dev,
>  		goto nomem;
>  	dev->mode_config.tv_subconnector_property =3D tv_subconnector;
> =20
> +other:
>  	/*
>  	 * Other, TV specific properties: margins & TV modes.
>  	 */

[Severity: High]
Does this goto path unconditionally recreate properties like
tv_brightness_property?

If a GUD USB device exposes multiple TV properties, the driver calls
drm_mode_create_tv_properties_legacy() multiple times. For subsequent
properties, the goto other path is hit, but it proceeds to unconditionally
call drm_property_create_range() for brightness, contrast, etc.

Would this overwrite the pointers in dev->mode_config and leak the orphaned
drm_property objects?

Furthermore, during a userspace atomic commit to update the brightness
property on the first connector, wouldn't the pointer mismatch cause the
kernel to reject the valid property update with -EINVAL?

drivers/gpu/drm/drm_atomic_uapi.c:drm_atomic_connector_set_property() {
	...
	} else if (property =3D=3D config->tv_brightness_property) {
		state->tv.brightness =3D val;
	...
}

[Severity: High]
This isn't a bug introduced by this patch, but does the TV mode name
processing in gud_connector_add_tv_mode() have an out-of-bounds read?

Untrusted data is read from the USB device into buf without enforcing
null-termination:

drivers/gpu/drm/gud/gud_connector.c:gud_connector_add_tv_mode() {
	...
	ret =3D gud_usb_get(gdrm, GUD_REQ_GET_CONNECTOR_TV_MODE_VALUES,
			  connector->index, buf, buf_len);
	...
	for (i =3D 0; i < num_modes; i++)
		modes[i] =3D &buf[i * GUD_CONNECTOR_TV_MODE_NAME_LEN];
	...
}

If the USB device payload contains full 16-byte chunks without any null
terminators, would the strlen() in drm_property_add_enum() read past the
end of the kmalloced buffer?

drivers/gpu/drm/drm_property.c:drm_property_add_enum() {
	...
	if (WARN_ON(strlen(name) >=3D DRM_PROP_NAME_LEN))
		return -EINVAL;
	...
}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/tencent_C6A625E0BAF=
4BB77334C9E0F1B244B7B1B08@qq.com?part=3D1
