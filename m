Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D96CA606A32C
	for <dri-devel@archiver.kernel.org>; Wed,  4 Nov 2026 02:49:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nOVN2bFz
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 026EA10F970;
	Wed,  4 Nov 2026 02:49:25 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AF1A10F970
 for <dri-devel@lists.freedesktop.org>; Wed,  4 Nov 2026 02:49:18 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1DCCA601F6;
 Wed,  4 Nov 2026 02:49:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81AF81F000C1;
 Wed,  4 Nov 2026 02:49:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793760556;
 bh=VI/zweAfAJVfcRh7FL3BS6NHi7RSSwwioEmxfJYdNNg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=nOVN2bFzKVwNHTXdGazYDvduHvJ4yY3hsUHJJNEQL2CBDNCycBqno1PyjbHy6u3/I
 9dWz6jPFsL1oLXsWaYe2VGtLq6itj3+Vrf2itQFyJdk6ju17tb0XuqewY8oe0gFL4M
 /pqj48Kx5B5MuljkKj9Uuqv/01MrwP9OD+Jif+Ws4aU5V6m7l2AtQ5TQX1ce+x7oie
 xKuiBmcokyN0tHm8vKaHsCIRn1dE+r1924FRu/WK9e06o337GYWL2DJQv4j4ADq81l
 6uFZm+6XFtpXZA8u8ppilzHT+ZfeaYoV/ytdxj9EiaWyrsGNRujHWUcMuts9v3Y6k2
 wTZxK8wqYSVww==
Message-ID: <sashiko-outbox-196523@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: simple-framebuffer: Document
 mono format
To: "Sebastian Raase" <linux@sraa.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <258a1228601ab9b5dbb8f077dacf61121b641f15.1793758480.git.linux@sraa.de>
References: <cover.1793758480.git.linux@sraa.de>
 <258a1228601ab9b5dbb8f077dacf61121b641f15.1793758480.git.linux@sraa.de>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 04 Nov 2026 02:49:16 +0000
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
- [High] drm/sysfb: missing DRM_FORMAT_R1 blit and clip support for mono fo=
rmat
- [Medium] dt-bindings: display: simple-framebuffer: underspecified mono bi=
t order
--

commit 20af76c182c22fb42d62d508852f5a56db4c14ee
Author: Sebastian Raase <linux@sraa.de>

dt-bindings: display: simple-framebuffer: Document mono format

This commit documents the mono format in the simple-framebuffer Device Tree
binding as a 1-bit packed pixel monochrome format with 8 pixels per byte.

> diff --git a/Documentation/devicetree/bindings/display/simple-framebuffer=
.yaml b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> index 45ffdebc9d86b..c627ec088434e 100644
> --- a/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> +++ b/Documentation/devicetree/bindings/display/simple-framebuffer.yaml
> @@ -94,6 +94,7 @@ properties:
>    format:
>      description: >
>        Format of the framebuffer:
> +        * `mono` - 1-bit packed pixels, 8 pixels/byte

[Severity: Medium]
Should the binding description specify both the pixel polarity and the
intra-byte bit ordering for mono, similar to how the other formats define
their bit-to-channel mappings?

In include/linux/platform_data/simplefb.h, SIMPLEFB_FORMATS maps mono to
DRM_FORMAT_R1:

include/linux/platform_data/simplefb.h:
    #define SIMPLEFB_FORMATS \
    { \
        { "mono", 1, {0, 1}, {0, 1}, {0, 1}, {0, 0}, DRM_FORMAT_R1 }, \

In include/uapi/drm/drm_fourcc.h, DRM_FORMAT_R1 is defined with the leftmost
pixel in bit 7 (MSB) and the rightmost pixel in bit 0 (LSB).

However, in drivers/video/fbdev/simplefb.c, simplefb_probe() sets
info->fix.visual =3D FB_VISUAL_MONO10 and uses FB_DEFAULT_IOMEM_OPS without
setting FBINFO_BE_MATH or FB_NONSTD_REV_PIX_IN_B:

drivers/video/fbdev/simplefb.c:simplefb_probe() {
    ...
	if (params.format->bits_per_pixel =3D=3D 1)
		info->fix.visual =3D FB_VISUAL_MONO10;
	else
		info->fix.visual =3D FB_VISUAL_TRUECOLOR;
    ...
}

Because fb_reverse_init() in drivers/video/fbdev/core/fb_draw.h places the
leftmost pixel at bit 0 (LSB) on little-endian CPUs and at bit 7 (MSB) on
big-endian CPUs unless reversed, does simplefb end up using a CPU-endian
dependent pixel bit order that is reversed relative to DRM_FORMAT_R1 on
little-endian systems?

>          * `a1r5g5b5` - 16-bit pixels, d[15]=3Da, d[14:10]=3Dr, d[9:5]=3D=
g, d[4:0]=3Db
>          * `a2r10g10b10` - 32-bit pixels, d[31:30]=3Da, d[29:20]=3Dr, d[1=
9:10]=3Dg, d[9:0]=3Db
>          * `a8b8g8r8` - 32-bit pixels, d[31:24]=3Da, d[23:16]=3Db, d[15:8=
]=3Dg, d[7:0]=3Dr
> @@ -106,6 +107,7 @@ properties:
>          * `x8r8g8b8` - 32-bit pixels, d[23:16]=3Dr, d[15:8]=3Dg, d[7:0]=
=3Db
>          * `x8b8g8r8` - 32-bit pixels, d[23:16]=3Db, d[15:8]=3Dg, d[7:0]=
=3Dr
>      enum:
> +      - mono

[Severity: High]
How does simpledrm handle a simple-framebuffer Device Tree node with
format =3D "mono" when CONFIG_DRM_SIMPLEDRM is enabled?

Both simplefb and simpledrm bind to simple-framebuffer nodes and validate t=
he
format property against SIMPLEFB_FORMATS:

drivers/gpu/drm/sysfb/simpledrm.c:
    simpledrm_probe() ->
        simpledrm_device_create() ->
            simplefb_get_validated_format()

When simplefb_get_validated_format() accepts mono as DRM_FORMAT_R1,
simpledrm claims the framebuffer aperture and registers a DRM device whose
primary plane advertises DRM_FORMAT_R1 and emulated DRM_FORMAT_XRGB8888 via
drm_sysfb_build_fourcc_list().

During drm_client_setup(), drm_fbdev_client_setup() requests color_mode =3D=
 1,
which maps via drm_mode_legacy_fb_format(1, 1) to DRM_FORMAT_C1 rather than
DRM_FORMAT_R1, so __drm_fb_helper_find_sizes() falls back to
DRM_FORMAT_XRGB8888.

When the fbdev client or an XRGB8888 userspace compositor commits a
framebuffer, drm_sysfb_plane_helper_begin_fb_access() calls
drm_sysfb_get_blit_func(DRM_FORMAT_R1, DRM_FORMAT_XRGB8888):

drivers/gpu/drm/sysfb/drm_sysfb_modeset.c:drm_sysfb_get_blit_func() {
	if (src_format =3D=3D dst_format) {
		return drm_sysfb_memcpy;
	} else if (src_format =3D=3D DRM_FORMAT_XRGB8888) {
		switch (dst_format) {
		case DRM_FORMAT_RGB565:
		...
		}
	}
	return NULL;
}

Since drm_sysfb_get_blit_func() has no case for DRM_FORMAT_R1, won't
drm_sysfb_plane_helper_begin_fb_access() warn and fail every XRGB8888 atomic
commit with -EINVAL?

Additionally, if a client commits a native DRM_FORMAT_R1 framebuffer with a
partial damage clip where x1 > 0, drm_sysfb_plane_helper_atomic_update()
calculates the destination offset using drm_fb_clip_offset():

drivers/gpu/drm/sysfb/drm_sysfb_modeset.c:drm_sysfb_plane_helper_atomic_upd=
ate() {
    ...
		iosys_map_incr(&dst, drm_fb_clip_offset(dst_pitch, dst_format, &dst_clip)=
);
		blit_to_crtc(&dst, &dst_pitch, shadow_plane_state->data, fb, &damage,
			     &shadow_plane_state->fmtcnv_state);
    ...
}

Because dst_format->cpp[0] is 0 for DRM_FORMAT_R1 while drm_fb_memcpy() uses
DIV_ROUND_UP(bpp, 8) =3D 1 byte per pixel for the source clip offset, would=
n't
partial damage updates also miscalculate horizontal offsets?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1793758480.gi=
t.linux@sraa.de?part=3D2
