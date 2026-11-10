Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C0378606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:18:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UyctobeQ
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2C50B10F647;
	Tue, 10 Nov 2026 12:18:43 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8843910F63B
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:18:37 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 718FA41984;
 Tue, 10 Nov 2026 12:18:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 28DB81F0089F;
 Tue, 10 Nov 2026 12:18:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794313117;
 bh=l510YMPua9hQF3rHGQbO08Rvn89yLiLIgQBdXMzOQlU=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UyctobeQt1oDFAWzbnAt8buLFwinOzq8T7Mqmk3P/TURhpU2zOFVGn6CRta9INugD
 ONa/tiLvNStRbZ3RmZmmVnrhkXDJCdgXj7rRCHkFnQnCiNNqCFvVuuTKRPs/0qf7lS
 Y8C79ce7+sLMw32znqnTi5qos/e2y5tOcSmlkoL7zMHhfthSVX3LYCAibpIlAUJTXg
 WaqozZu61IF4XnCll+O66atIxNfLkUYxwPhg3jiSeVs4SYAMVoK5FUgIWtzwDOwmWv
 z2KR1R+3dBHUK6NEFIQM5x0SCBK4ZN8OqG99fLRuDDrqnIJhxil30RRtCpqvJCHowS
 v8P/eKzXAiU9g==
Message-ID: <sashiko-outbox-206999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 4/5] drm/radeon: Inline drm_crtc_init()
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org
In-Reply-To: <20261110120326.538252-5-tzimmermann@suse.de>
References: <20261110120326.538252-1-tzimmermann@suse.de>
 <20261110120326.538252-5-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 12:18:36 +0000
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

Thank you for your contribution! Sashiko AI review found 1 potential
issue to consider:
- [High] drm/radeon: radeon_crtc_init() breaks non-XRGB8888/ARGB8888
  modesets
--

commit 084c2fdd462a7f679496ecdf20e1829b6180f22d
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/radeon: Inline drm_crtc_init()

This commit inlines drm_crtc_init() into radeon_crtc_init() by allocating
a primary plane with __drm_universal_plane_alloc() and initializing the
CRTC via drm_crtc_init_with_planes().

> diff --git a/drivers/gpu/drm/radeon/radeon_display.c b/drivers/gpu/drm/ra=
deon/radeon_display.c
> index aac6733ddd82c..4b784df4679f9 100644
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
> @@ -47,6 +48,17 @@
>  #include "radeon.h"
>  #include "radeon_kms.h"
> =20
> +static const u32 radeon_primary_plane_formats[] =3D {
> +	DRM_FORMAT_XRGB8888,
> +	DRM_FORMAT_ARGB8888,
> +};
> +
> +static const struct drm_plane_funcs radeon_primary_plane_funcs =3D {
> +	.update_plane =3D drm_plane_helper_update_primary,
> +	.disable_plane =3D drm_plane_helper_disable_primary,
> +	.destroy =3D drm_plane_helper_destroy,
> +};
> +
>  static void avivo_crtc_load_lut(struct drm_crtc *crtc)
>  {
>  	struct radeon_crtc *radeon_crtc =3D to_radeon_crtc(crtc);
> @@ -680,20 +692,31 @@ static const struct drm_crtc_funcs radeon_crtc_func=
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
Does restricting radeon_primary_plane_formats[] to only two 32-bit formats
cause drm_mode_setcrtc() to reject other pixel formats supported by radeon?

Previously, drm_crtc_init() set primary->format_default =3D true, which made
drm_mode_setcrtc() skip the drm_plane_has_format() check and leave format
validation to the CRTC callbacks:

drivers/gpu/drm/drm_crtc.c:drm_mode_setcrtc() {
    ...
		if (!plane->format_default) {
			if (!drm_plane_has_format(plane, fb->format->format, fb->modifier)) {
				drm_dbg_kms(dev, "Invalid pixel format %p4cc, modifier 0x%llx\n",
					    &fb->format->format, fb->modifier);
				ret =3D -EINVAL;
				goto out;
			}
		}
    ...
}

Allocating the primary plane via __drm_universal_plane_alloc() leaves
primary->format_default as false (and follow-up commit "drm: Remove
drm_crtc_init()" removes format_default altogether). As a result,
drm_mode_setcrtc() now fails with -EINVAL for 8bpp, 15bpp, 16bpp, and 30bpp
framebuffers (such as C8, RGB565, XRGB1555, and XRGB2101010) that
dce4_crtc_do_set_base(), avivo_crtc_do_set_base(), and
radeon_crtc_do_set_base() handle.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110120326.5382=
52-1-tzimmermann@suse.de?part=3D4
