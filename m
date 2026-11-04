Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C8E94606A31B
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=dE1Fkd1b
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CBE8D10F97D;
	Wed,  4 Nov 2026 02:56:22 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8C3C510F97D
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:56:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 4A0E440672;
 Wed,  4 Nov 2026 02:56:16 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DCFEE1F000C1;
 Wed,  4 Nov 2026 02:56:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793760976;
 bh=IYtoB6g6XmX0Tiw5T5gjrs462UduyJvVBxRyDLPBJuI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=dE1Fkd1bVFk/dJqCIRZBr5+tdglSM2424wSsp0gXDp5fC+J+f2lkareoVaEtncnvt
 4wuwdsp1twzQ0vMtQw7np6f1mSSHl2/P2GvgTy8dru0rmaEaWvOmJP7ytSUjYEQq8g
 6/Thq723xNiMBlCZ1mzDKldEzTcBnfatt6jWTBL2L4kWZ662hoCDJfeyNHPfTOxArG
 ySM9QkkejT6ngp6eQPcu8lgrzOFjWr6wVGZ7tVV6XmSCCQ7duGI+w1IoD4IHi4nY6K
 F33RQI9CLT3lBdnKrQsNA2CHj6tCa12DN/JjFdmiqwKQTeZF/n454e8NrFC27t0Yr8
 QvjgDiNDsawWw==
Message-ID: <sashiko-outbox-196548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] fbdev: simplefb: Add mono framebuffer format
To: "Sebastian Raase" <linux@sraa.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <6c207278c23d11f2c17cee383d422c3295cc7d97.1793758480.git.linux@sraa.de>
References: <cover.1793758480.git.linux@sraa.de>
 <6c207278c23d11f2c17cee383d422c3295cc7d97.1793758480.git.linux@sraa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:56:15 +0000
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

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] fbdev: simplefb: adding DRM_FORMAT_R1 to SIMPLEFB_FORMATS breaks s=
impledrm
- [Medium] fbdev: simplefb: mono bit order in cfb helpers mismatches DRM_FO=
RMAT_R1
--

commit 89b64a8b00831d236b9621c5f7f6d3729ed70512
Author: Sebastian Raase <linux@sraa.de>

fbdev: simplefb: Add mono framebuffer format

This commit adds a 1 bit-per-pixel monochrome ("mono") format entry mapped
to DRM_FORMAT_R1 in SIMPLEFB_FORMATS and configures simplefb to use the
FB_VISUAL_MONO10 visual when probing 1-bpp framebuffers.

> diff --git a/drivers/video/fbdev/simplefb.c b/drivers/video/fbdev/simplef=
b.c
> index 60e5dcec201ff..4662101885ec5 100644
> --- a/drivers/video/fbdev/simplefb.c
> +++ b/drivers/video/fbdev/simplefb.c
> @@ -583,6 +583,8 @@ static int simplefb_probe(struct platform_device *pde=
v)
>  	info->fix.smem_start =3D mem->start;
>  	info->fix.smem_len =3D resource_size(mem);
>  	info->fix.line_length =3D params.stride;
> +	if (params.format->bits_per_pixel =3D=3D 1)
> +		info->fix.visual =3D FB_VISUAL_MONO10;

[Severity: Medium]
Does the bit ordering used by the cfb drawing helpers match DRM_FORMAT_R1 on
little-endian systems?

In include/uapi/drm/drm_fourcc.h, DRM_FORMAT_R1 is defined with MSB-first
pixel ordering ([7:0] R0:R1:R2:R3:R4:R5:R6:R7, where the leftmost pixel R0 =
is
in bit 7).

However, in drivers/video/fbdev/core/fb_draw.h, fb_reverse_init() and the
cfb drawing helpers (cfb_imageblit(), cfb_fillrect(), cfb_copyarea()) place
pixel 0 in the LSB on little-endian architectures and in the MSB on
big-endian architectures unless CONFIG_FB_CFB_REV_PIXELS_IN_BYTE is enabled
and FB_NONSTD_REV_PIX_IN_B is set in info->var.nonstd:

drivers/video/fbdev/core/fb_draw.h:fb_reverse_init() {
	struct fb_reverse reverse;
#ifdef __LITTLE_ENDIAN
	reverse.byte =3D fb_be_math(info) !=3D 0;
#else
	reverse.byte =3D fb_be_math(info) =3D=3D 0;
#endif
#ifdef FB_REV_PIXELS_IN_BYTE
	reverse.pixel =3D info->var.bits_per_pixel < BITS_PER_BYTE
		&& (info->var.nonstd & FB_NONSTD_REV_PIX_IN_B);
#else
	reverse.pixel =3D false;
#endif
	return reverse;
}

Since simplefb leaves info->var.nonstd at 0 and does not select
FB_CFB_REV_PIXELS_IN_BYTE, won't the 8 horizontal pixels within each byte be
bit-reversed relative to DRM_FORMAT_R1 (and relative to big-endian simplefb)
on little-endian machines?

> =20
>  	info->var =3D simplefb_var;
>  	info->var.xres =3D params.width;
> diff --git a/include/linux/platform_data/simplefb.h b/include/linux/platf=
orm_data/simplefb.h
> index 4f94d52ac99fc..9b6d822145c9e 100644
> --- a/include/linux/platform_data/simplefb.h
> +++ b/include/linux/platform_data/simplefb.h
> @@ -15,6 +15,7 @@
>  /* format array, use it to initialize a "struct simplefb_format" array */
>  #define SIMPLEFB_FORMATS \
>  { \
> +	{ "mono", 1, {0, 1}, {0, 1}, {0, 1}, {0, 0}, DRM_FORMAT_R1 }, \

[Severity: High]
Can adding "mono" with DRM_FORMAT_R1 to SIMPLEFB_FORMATS break display outp=
ut
when simpledrm is enabled?

SIMPLEFB_FORMATS is shared with drivers/gpu/drm/sysfb/simpledrm.c, where
simplefb_get_validated_format() matches fmt->name and looks up fmt->fourcc:

drivers/gpu/drm/sysfb/simpledrm.c:simplefb_get_validated_format() {
	...
		if (!strcmp(format_name, fmt->name)) {
			info =3D drm_format_info(fmt->fourcc);
			if (!info)
				return ERR_PTR(-EINVAL);
			return info;
		}
	...
}

With this entry added, simpledrm binds to "mono" simple-framebuffer devices,
acquires the aperture (evicting or blocking simplefb), and registers a
primary plane advertising DRM_FORMAT_R1 and emulated DRM_FORMAT_XRGB8888.

When in-kernel clients (such as fbdev emulation via drm_client_setup() ->
drm_fbdev_client_setup()) or userspace compositors commit an XRGB8888
framebuffer, drm_sysfb_plane_helper_begin_fb_access() calls
drm_sysfb_get_blit_func(DRM_FORMAT_R1, DRM_FORMAT_XRGB8888):

drivers/gpu/drm/sysfb/drm_sysfb_modeset.c:drm_sysfb_get_blit_func() {
	if (src_format =3D=3D dst_format) {
		return drm_sysfb_memcpy;
	} else if (src_format =3D=3D DRM_FORMAT_XRGB8888) {
		switch (dst_format) {
		case DRM_FORMAT_RGB565:
			return drm_fb_xrgb8888_to_rgb565;
		...
		}
	}
	return NULL;
}

Because drm_sysfb_get_blit_func() has no conversion helper for DRM_FORMAT_R=
1,
it returns NULL, triggering a warning and failing every XRGB8888 atomic
commit with -EINVAL.

Additionally, if a userspace client commits a native DRM_FORMAT_R1
framebuffer with a non-zero horizontal damage clip offset (clip->x1 > 0),
drm_sysfb_memcpy() calls drm_fb_memcpy():

drivers/gpu/drm/drm_format_helper.c:drm_fb_memcpy() {
	...
		unsigned int bpp_i =3D drm_format_info_bpp(format, i);
		unsigned int cpp_i =3D DIV_ROUND_UP(bpp_i, 8);
		size_t len_i =3D DIV_ROUND_UP(drm_rect_width(clip) * bpp_i, 8);

		src_i +=3D clip_offset(clip, src->pitches[i], cpp_i);
	...
}

For 1-bpp DRM_FORMAT_R1, cpp_i evaluates to 1 byte per pixel, so clip_offse=
t()
advances src_i by clip->x1 bytes instead of bits (8 times the horizontal
byte offset) while drm_sysfb_plane_helper_atomic_update() offsets dst using
dst_format->cpp[0] =3D=3D 0. Won't that read past the end of the source buf=
fer on
partial horizontal updates?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793758480.gi=
t.linux@sraa.de?part=3D1
