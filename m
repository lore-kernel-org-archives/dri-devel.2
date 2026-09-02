Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8563C624D3
	for <dri-devel@archiver.kernel.org>; Wed,  2 Sep 2026 13:32:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CC05110E02E;
	Wed,  2 Sep 2026 13:32:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="R6YecjZG";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 437B010E02E
 for <dri-devel@lists.freedesktop.org>; Wed,  2 Sep 2026 13:32:48 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0F7624006C;
 Wed,  2 Sep 2026 13:32:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C51541F000E9;
 Wed,  2 Sep 2026 13:32:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788355967;
 bh=KJzEjoXI+sdF+CPxGVulEgC1dTldA4sJFjuNGx7S9Ko=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=R6YecjZGgyXBcCBF4U7H5vadEu4RXfWW1synmgUWn0WTXtvkSUcibklvBFnvx8Ls1
 AOVyI3YZwjd7C+xhwJY3RwrU7dVzH14jkcf7w9Q2DnWNrKz9iycX/uFjGQKGGah+VV
 xrApw4RWecXK1pKCM74pCKIIhfEfWyI/Q4msFqRVLdIkbJoy+5xXPfC0rzYPOVMNPS
 6Z1tTqhTOAUotiMS0aGB2jSFLDO2dhThQhaqPkxfSVWcEHc4h4Jr96ATMtM/JvZ8wE
 nwa4fsXm9t8gpUw03XyVAAv17mR/vz1cUMbYt0SiG6lsjBBVaOQZdlS2aiV6Dh+fG2
 OXdEyiPJoC3PQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH V2] drm/loongson: Create blend mode property for cursor
 plane
To: "Huacai Chen" <chenhuacai@loongson.cn>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20260902132152.3170934-1-chenhuacai@loongson.cn>
References: <20260902132152.3170934-1-chenhuacai@loongson.cn>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 02 Sep 2026 13:32:47 +0000
Message-Id: <20260902133247.C51541F000E9@smtp.kernel.org>
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
- [Medium] The cursor plane's blend mode property advertises support for DR=
M_MODE_BLEND_PIXEL_NONE, but the driver never reads or implements this mode=
, causing it to incorrectly behave as DRM_MODE_BLEND_COVERAGE.
--

commit 0fb989e37bfbacfc53639e07453dacd08e37bac4
Author: Huacai Chen <chenhuacai@kernel.org>

drm/loongson: Create blend mode property for cursor plane

This commit fixes boot warnings by exposing a blend mode property for cursor
planes that use pixel formats with alpha. It configures the planes to expose
support for both DRM_MODE_BLEND_PIXEL_NONE and DRM_MODE_BLEND_COVERAGE.

> diff --git a/drivers/gpu/drm/loongson/lsdc_plane.c b/drivers/gpu/drm/loon=
gson/lsdc_plane.c
> index bea42215796d4..969b2aaa4fd09 100644
> --- a/drivers/gpu/drm/loongson/lsdc_plane.c
> +++ b/drivers/gpu/drm/loongson/lsdc_plane.c
[ ... ]
> @@ -765,15 +767,16 @@ int ls7a1000_cursor_plane_init(struct drm_device *d=
dev,
> =20
>  	drm_plane_helper_add(plane, &ls7a1000_cursor_plane_helper_funcs);
> =20
> -	return 0;
> +	return drm_plane_create_blend_mode_property(plane, blend_caps);
>  }

[Severity: Medium]
Does this driver actually support DRM_MODE_BLEND_PIXEL_NONE?

The blend caps advertise DRM_MODE_BLEND_PIXEL_NONE, allowing userspace to
request disabling alpha blending on the cursor plane. However, looking at
the atomic update path for this hardware:

ls7a1000_cursor_plane_atomic_update() {
        ...
        ops->update_cfg(cursor, CURSOR_SIZE_32X32, CURSOR_FORMAT_ARGB8888);
        ...
}

And similarly for the ls7a2000 hardware:

ls7a2000_cursor_plane_atomic_update() {
        ...
        ops->update_cfg(cursor, cursor_size, CURSOR_FORMAT_ARGB8888);
        ...
}

It appears the hardware is unconditionally programmed to use alpha blending
(CURSOR_FORMAT_ARGB8888) regardless of the plane_state->pixel_blend_mode
value.

If userspace sets the pixel blend mode to None, won't it silently continue
using alpha coverage instead of rendering an opaque cursor?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902132152.3170=
934-1-chenhuacai@loongson.cn?part=3D1
