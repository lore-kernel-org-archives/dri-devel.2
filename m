Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C38FC606A331
	for <dri-devel@archiver.kernel.org>; Thu, 12 Nov 2026 13:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JEGx/I0u
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D87D411211D;
	Thu, 12 Nov 2026 13:21:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0B5B10E849;
 Thu, 12 Nov 2026 13:21:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 70A2A43879;
 Thu, 12 Nov 2026 13:21:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33B801F00A05;
 Thu, 12 Nov 2026 13:21:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794489675;
 bh=BEGvSbz1Vo8YKRgli4Dcrnoesq6QMELiVHHXuy3CrdM=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JEGx/I0uyLmLrMVeDi/OVeJnqRrPq21QScSbv/rhK6qMb4e2BMHvyVMk6m4fgA5A0
 b+8Alg+15JoVyFmQ6AFsqOFwfwOHwjuxpD7TkkbHVDw9dRpZxMNWVvQ8E1rFKiRYCR
 CDNRfuGYqUdk0Yzyt6DPwdavLegXZMOtzN5n7K3ydmks5vuLbRwGfsNqxntlzi0Vc4
 mimpgFu4J2qIpa7OhvnPV3DrMj1WOiVfyWb+A5cUgKoVfWxHuoh50UhRC3BktWi/M+
 iV5xrDhJNBvSbtOf6DfFew91J1NDesDvMc6B6lS1aYJRum++G3+BDdoSShwbePqJEE
 mtlOt5WbAFsHA==
Message-ID: <sashiko-outbox-211164@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] drm/radeon: Inline drm_crtc_init()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org
In-Reply-To: <20261112125039.66082-2-tzimmermann@suse.de>
References: <20261112125039.66082-1-tzimmermann@suse.de>
 <20261112125039.66082-2-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 13:21:14 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential
issues to consider:
- [High] drm/radeon: radeon_crtc_init() registers DCE4 plane formats on
  all ASICs
- [Low] drm/radeon: commit message inaccurately claims drm_crtc_init()
  formats are used
--

commit 7f6e83326a814c1dd5b8538076f37ab12152984e
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/radeon: Inline drm_crtc_init()

This commit inlines drm_crtc_init() into radeon_crtc_init(), allocating
a primary plane with an explicit format list and initializing the CRTC via
drm_crtc_init_with_planes().

> As in drm_crtc_init(), create a primary plane for the CRTC. Use the same
> formats as with drm_crtc_init().

[Severity: Low]
Is the commit message still accurate here after v2?  drm_crtc_init() uses
safe_modeset_formats, which only contains DRM_FORMAT_XRGB8888 and
DRM_FORMAT_ARGB8888, whereas v2 expanded radeon_primary_plane_formats[]
to 16 formats.

> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/ra=
deon/radeon_display.c
> index aac6733ddd82c..1a03c641d72fe 100644
> --- a/drivers/gpu/drm/radeon/radeon_display.c
> +++ b/drivers/gpu/drm/radeon/radeon_display.c
> @@ -38,6 +38,7 @@
>  #include <drm/drm_framebuffer.h>
>  #include <drm/drm_gem_framebuffer_helper.h>
>  #include <drm/drm_modeset_helper.h>
> +#include <drm/drm_plane_helper.h>
>  #include <drm/drm_probe_helper.h>
>  #include <drm/drm_vblank.h>
>  #include <drm/radeon_drm.h>
> @@ -47,6 +48,31 @@
>  #include "radeon.h"
>  #include "radeon_kms.h"
> =20
> +static const u32 radeon_primary_plane_formats[] =3D {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +	DRM_FORMAT_XBGR8888,
> +	DRM_FORMAT_ABGR8888,
> +	DRM_FORMAT_XRGB2101010,
> +	DRM_FORMAT_ARGB2101010,
> +	DRM_FORMAT_BGRX1010102,
> +	DRM_FORMAT_BGRA1010102,
> +	DRM_FORMAT_RGB565,
> +	DRM_FORMAT_XRGB1555,
> +	DRM_FORMAT_ARGB1555,
> +	DRM_FORMAT_BGRX5551,
> +	DRM_FORMAT_BGRA5551,
> +	DRM_FORMAT_XRGB4444,
> +	DRM_FORMAT_ARGB4444,
> +	DRM_FORMAT_C8,
> +};

[ ... ]

> @@ -680,20 +706,31 @@ static const struct drm_crtc_funcs radeon_crtc_func=
s =3D {
>  static void radeon_crtc_init(struct drm_device *dev, int index)
>  {
>  	struct radeon_device *rdev =3D dev->dev_private;
> +	struct drm_plane *primary;
>  	struct radeon_crtc *radeon_crtc;
> +	int ret;
> =20
> -	radeon_crtc =3D kzalloc_obj(*radeon_crtc);
> -	if (radeon_crtc =3D=3D NULL)
> +	primary =3D __drm_universal_plane_alloc(dev, sizeof(*primary), 0, 0,
> +					      &radeon_primary_plane_funcs,
> +					      radeon_primary_plane_formats,
> +					      ARRAY_SIZE(radeon_primary_plane_formats),
> +					      NULL, DRM_PLANE_TYPE_PRIMARY, NULL);

[Severity: High]
Does registering radeon_primary_plane_formats unconditionally on all
ASICs cause regressions on AVIVO (DCE1-DCE3) and pre-AVIVO hardware?

radeon_primary_plane_formats[] matches dce4_crtc_do_set_base(), whereas
drm_crtc_init() previously advertised only XRGB8888 and ARGB8888 on the
plane and set primary->format_default =3D true.

On AVIVO hardware (!ASIC_IS_DCE4(rdev)), avivo_crtc_do_set_base() does
not support DRM_FORMAT_ARGB1555, DRM_FORMAT_BGRX5551,
DRM_FORMAT_BGRA5551, DRM_FORMAT_BGRX1010102, or DRM_FORMAT_BGRA1010102.
When userspace selects one of these newly advertised formats,
avivo_crtc_do_set_base() pins target_fb's BO in VRAM before rejecting the
format and returning -EINVAL without unpinning rbo or old_fb:

drivers/gpu/drm/radeon/atombios_crtc.c:avivo_crtc_do_set_base() {
    ...
	r =3D radeon_bo_pin(rbo, RADEON_GEM_DOMAIN_VRAM, &fb_location);
	if (unlikely(r !=3D 0)) {
		radeon_bo_unreserve(rbo);
		return -EINVAL;
	}
	radeon_bo_get_tiling_flags(rbo, &tiling_flags, NULL);
	radeon_bo_unreserve(rbo);

	switch (target_fb->format->format) {
    ...
	default:
		DRM_ERROR("Unsupported screen format %p4cc\n",
			  &target_fb->format->format);
		return -EINVAL;
	}
}

This permanently leaks the VRAM pin reference (and leaves scanout
unprogrammed during full modesets because atombios_crtc_mode_set()
ignores the return value of atombios_crtc_set_base()).

On pre-AVIVO hardware (!ASIC_IS_AVIVO(rdev)), radeon_crtc_do_set_base()
only switches on target_fb->format->cpp[0] * 8.  Advertising the 10-bpc,
BGR, 4444, and 5551 formats causes them to be misprogrammed as RGB565 or
XRGB8888, while omitting DRM_FORMAT_RGB888 (24-bpp) causes
drm_mode_setcrtc() to reject a format that pre-AVIVO CRTCs support now
that primary->format_default is false.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112125039.6608=
2-1-tzimmermann@suse.de?part=3D1
