Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE218606C90E
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 16:11:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dD1XkAp1
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0208510E4CE;
	Mon, 19 Oct 2026 16:11:42 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1849010ED61;
 Mon, 19 Oct 2026 16:11:35 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 8B84460210;
 Mon, 19 Oct 2026 16:11:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBC0A1F000C4;
 Mon, 19 Oct 2026 16:11:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792426294;
 bh=oQNjJoZ0jTS+KSHbGjg9eb95h9U/EVZVTbkZwJqmV3I=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dD1XkAp183qoxCocuNxU3u77A0yLqiGa9SPUkIInHh3QyVuOs1gUY7A8f6hItDiRf
 q/oK/2MiL6W5FWztrFM3iQV3ziy9643wTzRs82cx82Mu0sFZTF7lfe+A6ybcTtQWU0
 ubVv1y6fPmyC5tjmZ1y9TOCg7gio7yteNrxKWnQUdwpZ2WXcskRYuru+kdIXmpZ8j7
 0CS1+J+gZdJgyzw72X4f0IZOlPJOFHVIYXyA0uR/eG/xXfHK1WvQHe4o6ZfcLMNzoC
 0+NUeIcGy3pZUXsVcFxX1YPtRzjJVjjqp13M3/ui/3QN4IdEnO+5GRzuR097x8JdZY
 JPN1n+/CmL2Mw==
Message-ID: <sashiko-outbox-177831@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] drm/pixel: Link format helpers into
 drm_pixel_helper.ko
To: "Thomas Zimmermann" <tzimmermann@suse.de>
Cc: dri-devel@lists.freedesktop.org, linux-hyperv@vger.kernel.org,
 intel-gfx@lists.freedesktop.org, imx@lists.linux.dev,
 virtualization@lists.linux.dev, Frank.Li@kernel.org,
 wsa+renesas@sang-engineering.com, "Michael
 S. Tsirkin" <mst@redhat.com>, "Eugenio Perez" <eperezma@redhat.com>
In-Reply-To: <20261019154612.777074-3-tzimmermann@suse.de>
References: <20261019154612.777074-1-tzimmermann@suse.de>
 <20261019154612.777074-3-tzimmermann@suse.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 16:11:33 +0000
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
X-Spam-Status: No, score=-11.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,RCVD_IN_DNSWL_BLOCKED,
	RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,RCVD_IN_ZEN_BLOCKED_OPENDNS,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [Low] drm: undefined drm_format_conv_state_*() references in drm_kms_help=
er
- [Low] drm/sitronix: missing DRM_PIXEL_HELPER select in config DRM_ST7920
--

commit 5297070737eb21b200d62be5b5e13861b6e29b57
Author: Thomas Zimmermann <tzimmermann@suse.de>

drm/pixel: Link format helpers into drm_pixel_helper.ko

This commit moves drm_format_helper.o from drm_kms_helper.ko into
drm_pixel_helper.ko and updates drivers using format helpers to select
DRM_PIXEL_HELPER and include <drm/drm_format_helper.h>.

> diff --git a/drivers/gpu/drm/Makefile b/drivers/gpu/drm/Makefile
> index 5f555a2c1a4c8..fbc643747110f 100644
> --- a/drivers/gpu/drm/Makefile
> +++ b/drivers/gpu/drm/Makefile
> @@ -100,6 +100,7 @@ obj-$(CONFIG_DRM_PANEL_ORIENTATION_QUIRKS) +=3D drm_p=
anel_orientation_quirks.o
>  obj-$(CONFIG_DRM_PANEL_BACKLIGHT_QUIRKS) +=3D drm_panel_backlight_quirks=
.o
> =20
>  drm_pixel_helper-y :=3D \
> +	drm_format_helper.o \
>  	drm_pixel_helper_common.o
>  obj-$(CONFIG_DRM_PIXEL_HELPER) +=3D drm_pixel_helper.o
> =20
> @@ -150,7 +151,6 @@ drm_kms_helper-y :=3D \
>  	drm_crtc_helper.o \
>  	drm_damage_helper.o \
>  	drm_flip_work.o \
> -	drm_format_helper.o \
>  	drm_gem_atomic_helper.o \
>  	drm_gem_framebuffer_helper.o \
>  	drm_kms_helper_common.o \

[Severity: Low]
Will moving drm_format_helper.o to drm_pixel_helper-y while leaving
drm_gem_atomic_helper.o in drm_kms_helper-y cause undefined symbol referenc=
es
when CONFIG_DRM_KMS_HELPER is enabled without CONFIG_DRM_PIXEL_HELPER (or w=
hen
CONFIG_DRM_KMS_HELPER=3Dy and CONFIG_DRM_PIXEL_HELPER=3Dm)?

In drivers/gpu/drm/drm_gem_atomic_helper.c, the shadow plane helpers call
functions defined in drivers/gpu/drm/drm_format_helper.c:

drivers/gpu/drm/drm_gem_atomic_helper.c:
__drm_gem_shadow_plane_state_init()
	__drm_atomic_helper_plane_state_init(&shadow_plane_state->base, plane);
	drm_format_conv_state_init(&shadow_plane_state->fmtcnv_state);

__drm_gem_duplicate_shadow_plane_state()
	drm_format_conv_state_copy(&new_shadow_plane_state->fmtcnv_state,
				   &shadow_plane_state->fmtcnv_state);

__drm_gem_destroy_shadow_plane_state()
	drm_format_conv_state_release(&shadow_plane_state->fmtcnv_state);
	__drm_atomic_helper_plane_destroy_state(&shadow_plane_state->base);

Because config DRM_KMS_HELPER in drivers/gpu/drm/Kconfig does not select
DRM_PIXEL_HELPER, linking drm_kms_helper fails with undefined references to
drm_format_conv_state_init(), drm_format_conv_state_copy(), and
drm_format_conv_state_release().

[ ... ]

> diff --git a/drivers/gpu/drm/sitronix/Kconfig b/drivers/gpu/drm/sitronix/=
Kconfig
> index 41a428ef8295e..c4b54f4f4f69a 100644
> --- a/drivers/gpu/drm/sitronix/Kconfig
> +++ b/drivers/gpu/drm/sitronix/Kconfig
> @@ -4,6 +4,7 @@ config DRM_ST7571
>  	select DRM_CLIENT_SELECTION
>  	select DRM_GEM_SHMEM_HELPER
>  	select DRM_KMS_HELPER
> +	select DRM_PIXEL_HELPER
>  	select VIDEOMODE_HELPERS
>  	help
>  	  Sitronix ST7571 is a driver and controller for 4-level gray
> @@ -46,6 +47,7 @@ config DRM_ST7586
>  	select DRM_KMS_HELPER
>  	select DRM_GEM_DMA_HELPER
>  	select DRM_MIPI_DBI
> +	select DRM_PIXEL_HELPER
>  	help
>  	  DRM driver for the following Sitronix ST7586 panels:
>  	  * LEGO MINDSTORMS EV3

[Severity: Low]
Should config DRM_ST7920 in drivers/gpu/drm/sitronix/Kconfig also select
DRM_PIXEL_HELPER (and include <drm/drm_format_helper.h> in
drivers/gpu/drm/sitronix/st7920.c)?

In drivers/gpu/drm/sitronix/st7920.c, the driver calls format helpers
directly:

st7920_fb_blit_rect()
	iosys_map_set_vaddr(&dst, buf);
	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);

st7920_primary_plane_atomic_check()
	/* format conversion necessary; reserve buffer */
	buf =3D drm_format_conv_state_reserve(&shadow_plane_state->fmtcnv_state,
					    pitch, GFP_KERNEL);

Without selecting DRM_PIXEL_HELPER in DRM_ST7920, building st7920 when
CONFIG_DRM_PIXEL_HELPER is disabled (or when CONFIG_DRM_ST7920=3Dy and
CONFIG_DRM_PIXEL_HELPER=3Dm) fails with undefined references to
drm_fb_xrgb8888_to_mono() and drm_format_conv_state_reserve().

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019154612.7770=
74-1-tzimmermann@suse.de?part=3D2
