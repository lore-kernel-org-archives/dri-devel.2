Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 429D9CA9EC7
	for <dri-devel@archiver.kernel.org>; Sun, 11 Oct 2026 15:56:25 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 438EE10E313;
	Sun, 11 Oct 2026 15:56:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CgJfdqUa";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id C33CC10E313
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 15:56:22 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id CC7F760213;
 Sun, 11 Oct 2026 15:56:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A1881F0089C;
 Sun, 11 Oct 2026 15:56:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1791734181;
 bh=a9wavh1WeN1T1yu+T37W8eOS65fvMADlBtPZjWG7qXI=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CgJfdqUagkTOFGmL7a25ENyW8DLxJbTHkHjHfHjtxFPVrCJpqWB4GCcJGijIE+O3i
 LUP+J5AadBtK4XrGtukyqSfkxp2qQvzZz8hRG0xmBWysMkK20O3t5UPu+rH/kYcDTB
 nWaQZ5OTm/hjR7AehpT2cfUXJYoh1dUTiuIBZb8TQPfs05A3fLPFX5MO3s1kvjHC1w
 pzIPIj+eX+ijdjt940CJbJtl51y9rONH3I9XTB6hyWOjPU0PzORioQ7bBYxnR64vco
 PFW5cwFPRqcCUAtEd8BAkRZ+4ZlZllKnDPJHS/GX3L0iPd9nekwrNyXDLAe94JbFqf
 zdJZZqhtCB5NQ==
Message-ID: <sashiko-outbox-167308@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: "Leander Kieweg" <kieweg.leander@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261011154556.155831-3-kieweg.leander@gmail.com>
References: <20261011154556.155831-1-kieweg.leander@gmail.com>
 <20261011154556.155831-3-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 11 Oct 2026 15:56:20 +0000
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
- [High] drm: sleeping in atomic context during plane atomic_update
- [High] drm/glanda: incorrect teardown order in glanda_drm_fini causes IRQ=
 storm
--

commit 282719415a14034814111dcb1dd6288f05170cc2
Author: Leander Kieweg <kieweg.leander@gmail.com>

drm/glanda: Add initial DRM driver for GlandaGPU

Introduce the core DRM/KMS driver for GlandaGPU. This driver
supports basic modesetting, atomic updates via shadow plane helpers,
and optional QEMU PCI probing alongside the platform driver.

> diff --git a/drivers/gpu/drm/tiny/glandagpu.c b/drivers/gpu/drm/tiny/glan=
dagpu.c
> new file mode 100644
> index 0000000000000..d133da93999f8
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
Is it safe to use GFP_KERNEL in this context?

glanda_blit_rect() is called from glanda_plane_atomic_update(), which is
registered as the atomic_update callback for the primary plane.

As per DRM subsystem rules, plane atomic update callbacks execute in atomic
context (e.g., inside drm_atomic_helper_commit_tail with locks held/preempt=
ion
disabled) where sleeping is strictly forbidden.

GFP_KERNEL allows the memory allocator to block and reclaim memory.

Could this allocation be deferred to a sleepable hook like atomic_check?

> +	if (!sbuf)
> +		return;
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
Can this call sleep while executing in an atomic context?

As noted above, glanda_plane_atomic_update() runs in an atomic context where
sleeping is forbidden.

drm_gem_fb_begin_cpu_access() can sleep while acquiring DMA reservation loc=
ks
and waiting on fences. Calling sleepable functions in the atomic display
commit path will cause kernel warnings (scheduling while atomic BUGs),
deadlocks, and system instability.

Should CPU access preparation be deferred to the sleepable prepare_fb hook?

> +	if (ret)
> +		return;
[ ... ]
> +static void glanda_crtc_disable_vblank(struct drm_crtc *crtc)
> +{
> +	struct glanda_device *gdev =3D to_glanda(crtc->dev);
> +	u32 ier;
> +	int idx;
> +
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		return;

[Severity: High]
Will this early return prevent the hardware VSYNC interrupt from being disa=
bled
when the module unloads?

If drm_dev_unplug() is called before drm_atomic_helper_shutdown(),
drm_dev_enter() will return false because the device is already marked as
unplugged.

The early return here would then cause the hardware interrupt disable logic
(clearing INT_VSYNC in REG_IER) to be skipped.

If the driver finishes removal, devres frees the IRQ handler while the hard=
ware
continues to fire interrupts. Because the IRQ is requested with IRQF_SHARED=
, an
unhandled hardware interrupt causes an IRQ storm that will force the kernel=
 to
permanently disable the shared interrupt line, potentially causing a denial=
 of
service for other devices sharing the line.

> +
> +	ier =3D readl(gdev->mmio_base + REG_IER);
> +	writel(ier & ~INT_VSYNC, gdev->mmio_base + REG_IER);
> +
> +	drm_dev_exit(idx);
> +}
[ ... ]
> +/* Shared teardown, mirrors glanda_drm_init() */
> +static void glanda_drm_fini(struct glanda_device *gdev)
> +{
> +	drm_dev_unplug(&gdev->drm);
> +	drm_atomic_helper_shutdown(&gdev->drm);

[Severity: High]
Are these teardown operations ordered correctly to prevent an IRQ storm on
module unload?

Because drm_dev_unplug() marks the device as unplugged (dev->unplugged =3D =
true)
before drm_atomic_helper_shutdown() is called, any drm_dev_enter() calls in=
 the
shutdown path (like in glanda_crtc_disable_vblank() and
glanda_plane_atomic_disable()) will immediately return false.

This short-circuits the hardware disable logic, leaving the VSYNC interrupt
enabled when the module unloads.

Should drm_atomic_helper_shutdown() be called before drm_dev_unplug() to en=
sure
hardware teardown logic executes properly?

> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011154556.1558=
31-1-kieweg.leander@gmail.com?part=3D2
