Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA603CDB466
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 10:05:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3731610F216;
	Thu, 25 Jun 2026 10:05:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="MMWvzDeK";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6928710F216
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:05:14 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CCBE7600C3;
 Thu, 25 Jun 2026 10:05:13 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 534941F00A3A;
 Thu, 25 Jun 2026 10:05:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1782381913;
 bh=iuy1MJTlx0mZ9wwmcprgzlvdBTb8tu0gw+YS4KwRWG8=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=MMWvzDeKLJJqj8JKcELVwg8bHLVbHEoMwXJ0splMtMWi47w+gI15XPRgkrctaPP9F
 TI9K3WuHGAuovW6CCrp8hFQuz2f2EU7P68gpt+pJ3PQs+/+CYoZEgvwrs/s9mAN9WV
 gz+edH1qn/BqgVxk65eU0T36QMfmCA+fJHq/SFv1Gff730kLayoqLZa0ohhgwf1F9w
 1NSxceg//vERXextEIQUevGhWz/Db13yLjvHm8zHvVbAuS94U0FTeViUDsGHEiXpf3
 o7LI5E/wangShxqEfn3hXdBjecH0MWe4Wg/P6unBnFruRc5l8sTr9OZJe321ziaj0r
 MTQLd5A/BCyCA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/7] drm/sysfb: simpledrm: Improve framebuffer-size
 validation
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260625094509.157581-2-tzimmermann@suse.de>
References: <20260625094509.157581-1-tzimmermann@suse.de>
 <20260625094509.157581-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 25 Jun 2026 10:05:12 +0000
Message-Id: <20260625100513.534941F00A3A@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Missing validation for device tree provided `stride` against `widt=
h * bpp` allows out-of-bounds memory writes.
--

commit daaa8ad78a371c66bd2324aa7a47d551084fe671
Author: Thomas Zimmermann <tzimmermann@suse.de>
drm/sysfb: simpledrm: Improve framebuffer-size validation

This commit validates the framebuffer dimensions provided by firmware again=
st
the 16-bit limits of struct drm_display_mode, failing the probe on errors.

Fixes: 11e8f5fd223b ("drm: Add simpledrm driver")
Cc: <stable@vger.kernel.org> # v5.14+

[ ... ]
> @@ -144,7 +137,7 @@ simplefb_get_width_of(struct drm_device *dev, struct =
device_node *of_node)
> =20
>  	if (ret)
>  		return ret;
> -	return simplefb_get_validated_int0(dev, "width", width);
> +	return drm_sysfb_get_validated_int0(dev, "width", width, U16_MAX);
>  }
> =20
>  static int
> @@ -155,7 +148,7 @@ simplefb_get_height_of(struct drm_device *dev, struct=
 device_node *of_node)
> =20
>  	if (ret)
>  		return ret;
> -	return simplefb_get_validated_int0(dev, "height", height);
> +	return drm_sysfb_get_validated_int0(dev, "height", height, U16_MAX);
>  }

[Severity: High]
This is a pre-existing issue, but does this code need to ensure a provided
stride is at least large enough for the given width and pixel format?

In simpledrm_device_create(), if the device tree or platform data provides a
non-zero stride, it bypasses the minimum pitch calculation:

	if (!stride) {
		u64 pitch =3D drm_format_info_min_pitch(format, 0, width);
		...
		stride =3D pitch;
	}

The driver then calculates the required size using this stride:

	if (check_mul_overflow(height, stride, &size)) {
		...
		if (size > resource_size(mem)) {

If firmware provides a small but non-zero stride (for example, 1), the size
calculation yields a small value, which easily passes the resource size che=
ck.

However, rendering and clearing operations write width * bpp bytes per line.
For example, in drm_sysfb_plane_helper_atomic_disable():

	for (i =3D 0; i < lines; ++i) {
		memset_io(dst_vmap, 0, linepixels * dst_format->cpp[0]);
		dst_vmap +=3D dst_pitch;
	}

Can this lead to out-of-bounds memory writes if the firmware provides a str=
ide
that is smaller than width * bpp?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260625094509.1575=
81-1-tzimmermann@suse.de?part=3D1
