Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11FE0C61DD3
	for <dri-devel@archiver.kernel.org>; Tue,  1 Sep 2026 10:16:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D39210EC4C;
	Tue,  1 Sep 2026 10:16:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="dUwcEXDi";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7E49310EC4C
 for <dri-devel@lists.freedesktop.org>; Tue,  1 Sep 2026 10:16:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 1CE864017D;
 Tue,  1 Sep 2026 10:16:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8D151F000E9;
 Tue,  1 Sep 2026 10:16:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788257772;
 bh=oVOAAoXdJ+A2IwjgepvSRAu5e/TOMHfyFcmyBZ5kXsk=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dUwcEXDi5v+ubMQY5TFsZbrbvmj1X+xie5F1Q/eTkbOyCvO4Lg+pRCMtAHJWWxbgf
 gOmSRp4Etz9H/mwwOf06LWy/HSTvzkQofV2ZhXxJdN2rWLIv0V9wbJL8+ghSD51Sc+
 YlBe1KpmlPggHAOER7ye4OMHQRmCadvLbX/B8CFeSt2INjjccujopvGPLjsybzuZm7
 FlHNqq9zNMBXLRto6vEstx0bIhazyQU/nOoYOZYXWOvxhwD1XxRX51PIwNP59aKvmx
 jSvtf8sfKipq+FiilsmugkzBNCFWvPp7tk3m4yT9wJZ6KKtkp4nI22kgTl0tJbEwan
 Do0BLGV5UydHw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] drm/loongson: Create blend mode property for cursor plane
To: "Huacai Chen" <chenhuacai@loongson.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260901095924.2839059-1-chenhuacai@loongson.cn>
References: <20260901095924.2839059-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 10:16:11 +0000
Message-Id: <20260901101611.C8D151F000E9@smtp.kernel.org>
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
- [Medium] Exposing DRM_MODE_BLEND_PIXEL_NONE exclusively for an ARGB8888 c=
ursor plane breaks userspace expectations and contradicts hardware behavior.
--

commit 4827dcdf2907d6dd03961937ab097337202514ed
Author: Huacai Chen <chenhuacai@kernel.org>
Subject: drm/loongson: Create blend mode property for cursor plane

This commit adds a blend mode property to the cursor planes in the loongson
DRM driver to silence a kernel warning during boot. It configures the plane
to exclusively expose DRM_MODE_BLEND_PIXEL_NONE since the hardware lacks a
configurable blend mode register.

> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loon=
gson/lsdc_plane.c
> index bea42215796d4..efef25eaa6592 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
[ ... ]
> @@ -747,8 +748,9 @@ int ls7a1000_cursor_plane_init(struct drm_device *dde=
v,
>  			       struct drm_plane *plane,
>  			       unsigned int index)
>  {
> -	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
>  	int ret;
> +	unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE);

[Severity: Medium]
Will this break userspace compositors? Exposing DRM_MODE_BLEND_PIXEL_NONE
exclusively for an ARGB8888 cursor plane contradicts hardware behavior and
breaks userspace expectations.

In DRM KMS semantics (as documented in drm_blend.c),
DRM_MODE_BLEND_PIXEL_NONE explicitly means 'the alpha channel is ignored for
blending'. However, the driver exposes DRM_FORMAT_ARGB8888 for the cursor
plane (via lsdc_cursor_formats), and hardware cursors inherently perform
fixed-function alpha blending (typically PREMULTI or COVERAGE) to render
properly with transparent edges.

When a display server queries the supported blend modes for the cursor plane
in ls7a1000_cursor_plane_init(), it will receive only
DRM_MODE_BLEND_PIXEL_NONE despite the format being DRM_FORMAT_ARGB8888.
Userspace compositors (e.g., Wayland, Mutter, Weston) that strictly validate
alpha blending capabilities will reject the hardware cursor plane because it
claims to not support alpha blending, forcing a fallback to software cursor
composition.

By claiming the plane only supports PIXEL_NONE, the driver seems to be
incorrectly documenting its hardcoded blend equation to silence a kernel
warning. If the hardware truly ignored the alpha channel, it should expose
DRM_FORMAT_XRGB8888 instead.

> +	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> =20
>  	ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
[ ... ]
> @@ -765,15 +767,16 @@ int ls7a1000_cursor_plane_init(struct drm_device *d=
dev,
[ ... ]
>  int ls7a2000_cursor_plane_init(struct drm_device *ddev,
>  			       struct drm_plane *plane,
>  			       unsigned int index)
>  {
> -	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
>  	int ret;
> +	unsigned int blend_caps =3D BIT(DRM_MODE_BLEND_PIXEL_NONE);

[Severity: Medium]
Does this face the same userspace rejection issue? As with
ls7a1000_cursor_plane_init(), exposing DRM_MODE_BLEND_PIXEL_NONE exclusively
for an ARGB8888 cursor plane will cause userspace compositors to reject the
hardware cursor plane in ls7a2000_cursor_plane_init() as well.

> +	struct lsdc_cursor *cursor =3D to_lsdc_cursor(plane);
> =20
>  	ret =3D drm_universal_plane_init(ddev, plane, 1 << index,
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901095924.2839=
059-1-chenhuacai@loongson.cn?part=3D1
