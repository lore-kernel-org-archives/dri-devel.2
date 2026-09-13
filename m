Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BD9DAC88E5C
	for <dri-devel@archiver.kernel.org>; Sun, 13 Sep 2026 21:03:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2192D89A72;
	Sun, 13 Sep 2026 21:03:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="jqu7aIFu";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A26E789A72
 for <dri-devel@lists.freedesktop.org>; Sun, 13 Sep 2026 21:03:46 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 639A441244;
 Sun, 13 Sep 2026 21:03:46 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 01E811F000FF;
 Sun, 13 Sep 2026 21:03:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1789333426;
 bh=Ir7rkjOuWgcSse8tdIzu3c3qaH5zji3o2q/UfqRcDj0=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=jqu7aIFu0I3r0cpnPqoUv9mthvux6deHWGy3FlTou7J8cP8zkKwz+zUel0j1aKAxm
 D7iqt4c2Ea2Ue/sVtmBr+qayYp0KVy3862CuBnziuTXxaXeIJr725iiYaWO4dD+dBf
 F8McesQSNHlWE1DTcbd+54l9GZT0Km0nrawZ9wiF7I2G2gZxX0AOS/ExR0M3c5yI30
 zNApcQxipjAECMd14kc1sIGRyTVwMAAoNtXZskOtp2vcXmr6BdwUJfek+Yj8rzVnmw
 W0LRbKyDNViqgGNg72Yj6nbpZD9rq7WD7r2afiqXvYro0IGd+BIdD0CEps1dVtdIfy
 1O4uVp0BSaZ8Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/2] drm/glanda: Add initial DRM driver for GlandaGPU
To: "Leander Kieweg" <kieweg.leander@gmail.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org,
 conor+dt@kernel.org, robh@kernel.org
In-Reply-To: <20260913205007.118552-3-kieweg.leander@gmail.com>
References: <20260913205007.118552-1-kieweg.leander@gmail.com>
 <20260913205007.118552-3-kieweg.leander@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 21:03:45 +0000
Message-Id: <20260913210346.01E811F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:
- [High] Calling a sleeping function in an atomic context (plane atomic upd=
ate callback).
- [High] Missing drm_atomic_helper_shutdown() in driver removal and missing=
 .shutdown hooks.
- [High] Infinite interrupt storm leading to a CPU hard lockup upon PCI dev=
ice removal (missing 0xFFFFFFFF check).
- [High] Kernel panic via unaligned memory access in `glanda_blit_rect` due=
 to unvalidated framebuffer pitch.
--

commit 17ab32ed9422ea6f511ee3ba92be0492625b8e06
Author: Leander Kieweg <kieweg.leander@gmail.com>

    drm/glanda: Add initial DRM driver for GlandaGPU
   =20
    Introduce the core DRM/KMS driver for GlandaGPU. This driver
    supports basic modesetting, atomic updates via shadow plane helpers,
    and optional QEMU PCI probing alongside the platform driver.

> diff --git a/drivers/gpu/drm/tiny/glandagpu.c b/drivers/gpu/drm/tiny/glan=
dagpu.c
> new file mode 100644
> index 0000000000000..bc954eb6d4412
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/glandagpu.c

[ ... ]

> @@ -107,17 +107,17 @@ static void glanda_blit_rect(struct glanda_device *=
gdev,
> +		u32 __iomem *dst =3D (u32 __iomem *)gdev->vram_base +
> +				   (size_t)dst_y * GLANDA_WIDTH + dst_clip->x1;
> +		size_t src_off =3D (size_t)src_y * src_pitch +
> +				 (size_t)(dst_clip->x1 - dst_off_x) * sizeof(u32);
> +
> +		for (x =3D 0; x < width; x++) {
> +			u32 pixel =3D iosys_map_rd(src, src_off + x * sizeof(u32), u32);

[Severity: High]
Does this code risk an unaligned memory access and a kernel panic?

Userspace can specify an arbitrary framebuffer pitch via the
DRM_IOCTL_MODE_ADDFB2 ioctl, and the DRM core does not enforce byte alignme=
nt
on fb->pitches[0].

If src_pitch is not a multiple of 4, src_off could be an unaligned byte
offset. Because the iosys_map_rd() macro casts directly to a 32-bit pointer
and dereferences it, this could cause an Alignment Fault and kernel panic on
architectures with strict alignment requirements.

[ ... ]

> @@ -136,10 +136,10 @@ static void glanda_plane_atomic_update(struct drm_p=
lane *plane,
> +	struct drm_atomic_helper_damage_iter iter;
> +	struct drm_rect damage;
> +	int dst_off_x, dst_off_y;
> +	int ret, idx;
> +
> +	ret =3D drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
> +	if (ret)
> +		return;

[Severity: High]
Could this result in calling a sleeping function from an atomic context?

The glanda_plane_atomic_update() function executes in an atomic context
during non-blocking commits where sleeping is strictly forbidden.

Because drm_gem_fb_begin_cpu_access() waits on DMA fences and acquires
mutexes, it can sleep. This could lead to might_sleep() warnings, system
instability, or deadlocks. Should CPU access be prepared beforehand in
a begin_fb_access or prepare_fb hook instead?

[ ... ]

> @@ -162,6 +162,6 @@ static void glanda_plane_atomic_update(struct drm_pla=
ne *plane,
> +
> +	drm_dev_exit(idx);
> +out_drm_gem_fb_end_cpu_access:
> +	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +}

[Severity: High]
Can this end_cpu_access call also sleep in the atomic update callback?

[ ... ]

> @@ -282,10 +282,10 @@ static const struct drm_connector_funcs glanda_conn=
ector_funcs =3D {
> +	.atomic_duplicate_state =3D drm_atomic_helper_connector_duplicate_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_connector_destroy_state,
> +};
> +
> +static const struct drm_mode_config_funcs glanda_mode_config_funcs =3D {
> +	.fb_create =3D drm_gem_fb_create_with_dirty,
> +	.atomic_check =3D drm_atomic_helper_check,
> +	.atomic_commit =3D drm_atomic_helper_commit,
> +};

[Severity: High]
Does the lack of a custom validation wrapper here allow the unaligned pitch
issue in glanda_blit_rect() to occur?

Hooking fb_create directly to drm_gem_fb_create_with_dirty() without a
custom wrapper means the driver does not enforce pitch alignment during
framebuffer creation.

[ ... ]

> @@ -306,10 +306,10 @@ static irqreturn_t glanda_irq_handler(int irq, void=
 *dev_id)
> +	struct glanda_device *gdev =3D dev_id;
> +	u32 isr, ier;
> +
> +	if (!gdev || !gdev->mmio_base)
> +		return IRQ_NONE;
> +
> +	isr =3D readl(gdev->mmio_base + REG_ISR);
> +	ier =3D readl(gdev->mmio_base + REG_IER);
> +
> +	if (!(isr & ier))
> +		return IRQ_NONE;

[Severity: High]
Could this cause an infinite interrupt storm and a CPU hard lockup if the P=
CI
device is removed?

When a PCI device is removed (e.g. hot-unplug), MMIO reads return all 1s
(0xFFFFFFFF). Since !(0xFFFFFFFF & 0xFFFFFFFF) evaluates to false, this
handler would not return IRQ_NONE.

Instead, it would process a fake VSYNC, write 0xFFFFFFFF back, and return
IRQ_HANDLED. If the IRQ line is shared and asserted by another device, the
kernel's spurious interrupt detector will not disable the broken line,
potentially causing a hard lockup.

[ ... ]

> @@ -522,10 +522,10 @@ static int glanda_drm_init(struct glanda_device *gd=
ev, int irq)
> +	return 0;
> +}
> +
> +/* Shared teardown, mirrors glanda_drm_init() */
> +static void glanda_drm_fini(struct glanda_device *gdev)
> +{
> +	drm_dev_unplug(&gdev->drm);
> +}

[Severity: High]
Is a call to drm_atomic_helper_shutdown() missing here?

Unregistering the DRM device without shutting down the atomic helpers means
the display pipeline is not turned off. The active drm_crtc_state and
drm_plane_state would not transition to a disabled state, leaving
framebuffers pinned and resulting in memory leaks.

[ ... ]

> @@ -575,10 +575,10 @@ static const struct of_device_id glanda_of_match[] =
=3D {
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(of, glanda_of_match);
> +
> +static struct platform_driver glandagpu_driver =3D {
> +	.driver =3D {
> +		.name =3D "glandagpu",
> +		.of_match_table =3D glanda_of_match,
> +	},
> +	.probe =3D glandagpu_probe,
> +	.remove =3D glandagpu_remove,
> +};

[Severity: High]
Does this platform driver need a .shutdown callback?

Without a .shutdown callback, the display hardware remains active during
system halt or reboot, which can cause the device to continue scanning out
VRAM inappropriately across reboots or kexecs.

[ ... ]

> @@ -613,10 +613,10 @@ static const struct pci_device_id glanda_pci_ids[] =
=3D {
> +	{ PCI_DEVICE(PCI_VENDOR_ID_REDHAT_QUMRANET, PCI_DEVICE_ID_GLANDA_GPU) },
> +	{ }
> +};
> +
> +MODULE_DEVICE_TABLE(pci, glanda_pci_ids);
> +
> +static struct pci_driver glandagpu_pci_driver =3D {
> +	.name =3D "glandagpu-pci",
> +	.id_table =3D glanda_pci_ids,
> +	.probe =3D glandagpu_pci_probe,
> +	.remove =3D glandagpu_pci_remove,
> +};

[Severity: High]
Is the .shutdown callback also missing from the PCI driver?

Similar to the platform driver, omitting this callback prevents the display
from being gracefully disabled on shutdown.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260913205007.1185=
52-1-kieweg.leander@gmail.com?part=3D2
