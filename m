Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 42FABC982D8
	for <dri-devel@archiver.kernel.org>; Sun, 20 Sep 2026 19:48:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6E20310E0F7;
	Sun, 20 Sep 2026 19:48:02 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="GxWnamcZ";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 238A110E28C
 for <dri-devel@lists.freedesktop.org>; Sun, 20 Sep 2026 19:48:01 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C477943F93;
 Sun, 20 Sep 2026 19:48:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6413B1F00904;
 Sun, 20 Sep 2026 19:48:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789933680;
 bh=R2YB4fsE0h6lm0CizC3Y5cR3+eH2124fhxidNfYGVOg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=GxWnamcZGvOy8TmY3PGUqexvORaRyEMrYUnOTqhfUNTINd0sPnEUO7iHajkjmrrOi
 2YSvw9ZvoYrZpVm9iAnloFUWdXmwvn3KR53HTS7ozbnjb8iHKUEkwzdDNzPWEc5aR1
 H2kUhDPia4EPMgyY1SGK4W+gCqKHHDifIpp2sghUf/sCu5XG98uRH1mBrBFGb1BqQ4
 rXivRczOrURJtm4FPTEbw5/43UbqlK8tc3LLLI+gsP7qRZ2nqNHvpMTZC92xZdcFpr
 pbEZg9B1Qv1Ythf+1Etx+Z5hf03pjDfFZgGqg712SXcInLM7ij1DaD3E+y85lmsYgu
 lH/2c2XBQeSDA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: "Leander Kieweg" <kieweg.leander@gmail.com>
Cc: devicetree@vger.kernel.org, robh@kernel.org,
 dri-devel@lists.freedesktop.org, conor+dt@kernel.org
In-Reply-To: <20260920193944.110983-3-kieweg.leander@gmail.com>
References: <20260920193944.110983-1-kieweg.leander@gmail.com>
 <20260920193944.110983-3-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 20 Sep 2026 19:47:59 +0000
Message-Id: <20260920194800.6413B1F00904@smtp.kernel.org>
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
- [High] drm: sleeping in atomic context during plane atomic update
- [High] drm: VBLANK IRQ storm due to unhandled interrupt on driver unbind
--

commit 32feffcdec94761d97377d2756a8face5aaf6281
Author: Leander Kieweg <kieweg.leander@gmail.com>

drm/glanda: Add initial DRM driver for GlandaGPU

Introduce the core DRM/KMS driver for GlandaGPU. This driver
supports basic modesetting, atomic updates via shadow plane helpers,
and optional QEMU PCI probing alongside the platform driver.

> diff --git a/drivers/gpu/drm/tiny/glandagpu.c b/drivers/gpu/drm/tiny/glan=
dagpu.c
> new file mode 100644
> index 0000000000000..38fa5809f31e0
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/glandagpu.c

[ ... ]

> +static void glanda_blit_rect(struct glanda_device *gdev,
> +			     const struct drm_rect *dst_clip,
> +			     const struct iosys_map *src,
> +			     struct drm_framebuffer *fb,
> +			     int dst_off_x, int dst_off_y,
> +				 struct drm_format_conv_state *fmtcnv_state)
> +{
> +	unsigned int src_pitch =3D fb->pitches[0];
> +	unsigned int width =3D drm_rect_width(dst_clip);
> +	unsigned int height =3D drm_rect_height(dst_clip);
> +	unsigned int x, y;
> +	size_t len =3D width * sizeof(u32);
> +	u32 *sbuf;
> +
> +	sbuf =3D drm_format_conv_state_reserve(fmtcnv_state, len, GFP_KERNEL);

[Severity: High]
Does this code sleep in atomic context? The glanda_blit_rect() function is=
=20
called from the glanda_plane_atomic_update() callback, which runs in atomic=
=20
context where sleeping is forbidden. Using GFP_KERNEL here can cause kernel=
=20
panics or deadlocks.

[ ... ]

> +static void glanda_plane_atomic_update(struct drm_plane *plane,
> +				       struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_state(st=
ate, plane);
> +	struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_state(st=
ate, plane);
> +	struct drm_shadow_plane_state *shadow_state =3D to_drm_shadow_plane_sta=
te(new_state);
> +	struct drm_rect vram_clip =3D DRM_RECT_INIT(0, 0, GLANDA_WIDTH, GLANDA_=
HEIGHT);
> +	struct glanda_device *gdev =3D to_glanda(plane->dev);
> +	struct drm_framebuffer *fb =3D new_state->fb;
> +	struct drm_atomic_helper_damage_iter iter;
> +	struct drm_rect damage;
> +	int dst_off_x, dst_off_y;
> +	int ret, idx;
> +
> +	ret =3D drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);

[Severity: High]
Can this sleep while waiting for hardware fences? Since=20
glanda_plane_atomic_update() is executed in atomic context, calling=20
drm_gem_fb_begin_cpu_access() (and the corresponding end_cpu_access) is=20
unsafe here.

[ ... ]

> +static void glanda_drm_fini(struct glanda_device *gdev)
> +{
> +	drm_dev_unplug(&gdev->drm);
> +	drm_atomic_helper_shutdown(&gdev->drm);
> +}

[Severity: High]
Does this teardown order cause an unhandled IRQ storm on unbind?

If drm_dev_unplug() is called before drm_atomic_helper_shutdown(), the=20
device is marked as unplugged. When the shutdown helper tries to disable=20
the CRTC, it calls glanda_crtc_disable_vblank():

static void glanda_crtc_disable_vblank(struct drm_crtc *crtc)
{
	...
	if (!drm_dev_enter(crtc->dev, &idx))
		return;
	...
}

The drm_dev_enter() check will fail because the device is already unplugged=
,=20
causing the hardware write to disable the VBLANK interrupt to be skipped.=20
The interrupt would remain active in hardware while the driver frees the=20
IRQ handler.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260920193944.1109=
83-1-kieweg.leander@gmail.com?part=3D2
