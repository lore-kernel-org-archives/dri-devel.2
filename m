Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 648C8CD8CB9
	for <dri-devel@archiver.kernel.org>; Wed, 10 Jun 2026 16:55:45 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C12D510EADD;
	Wed, 10 Jun 2026 16:55:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ceFE4p9F";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABA4710EADD
 for <dri-devel@lists.freedesktop.org>; Wed, 10 Jun 2026 16:55:42 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 0700C601E1;
 Wed, 10 Jun 2026 16:55:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71DCA1F00893;
 Wed, 10 Jun 2026 16:55:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1781110541;
 bh=qGRA09PhlJiCpkvykMU4j0woJcna1jelrO4TO4S+LHc=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=ceFE4p9FTaFc+4Zsp0xlQFq28Wukt/wf4kF+8HwF+ORHDnjoBIm0bRLej/tSAjms/
 nR59QSzacamcQgqbAd7ApFGpa3ZtjINjpbHT7nfVLMmJjKOmMC6PGVthROQBNjLQMG
 hPvG523SgLHXOCZlTmyldaJQh3PX8Y7lfOIySoWr0VQKJ6WBIUPM/2MaV0TirMmAAs
 3QaCMBTcnp/KhySmYQh6dRPMv6melVuys4XA1mVlao2FqeFB+FeOJIAQi0OzpiGBwj
 kHq4Z4Ozs/bzm190nbtiBOo3LEZVN8hyYl/szu2jAXGExKmz2TJAgYML0LLYaa//FJ
 myNyyDHuc0JlA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] drm/solomon: Add SSD1351 OLED display driver
To: "Amit Barzilai" <amit.barzilai22@gmail.com>
Cc: devicetree@vger.kernel.org, conor+dt@kernel.org,
 dri-devel@lists.freedesktop.org, robh@kernel.org
In-Reply-To: <20260610164428.180091-3-amit.barzilai22@gmail.com>
References: <20260610164428.180091-3-amit.barzilai22@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 10 Jun 2026 16:55:41 +0000
Message-Id: <20260610165541.71DCA1F00893@smtp.kernel.org>
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
- [High] Calling sleeping functions from within DRM atomic callbacks.
- [High] Passing stack-allocated variables and read-only data (.rodata) to =
`spi_write()`, violating the SPI subsystem's DMA-safe memory requirements.
- [High] The OLED display is not turned off when the driver module is unloa=
ded due to `drm_dev_unplug()` preventing the `atomic_disable` hook from acc=
essing hardware.
- [High] Coordinate space mismatch in the damage handling loop causes incor=
rect pixel extraction when panning.
--

commit 830ebdf4bc79cf5af84541c3dcfa33f751296ed5
Author: Amit Barzilai <amit.barzilai22@gmail.com>

drm/solomon: Add SSD1351 OLED display driver

Add a DRM/KMS driver for the Solomon SSD1351, a 128x128 65k-color RGB
OLED controller driven over a 4-wire SPI bus.

> diff --git a/drivers/gpu/drm/solomon/ssd1351.c b/drivers/gpu/drm/solomon/=
ssd1351.c
> new file mode 100644
> index 0000000000000..7c4a5c461afb8
> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd1351.c
[ ... ]
> +static int ssd1351_write_cmd(struct ssd1351_device *ssd1351, u8 cmd,
> +			     const u8 *params, size_t num)
> +{
> +	int ret;
> +
> +	gpiod_set_value_cansleep(ssd1351->dc, 0);
> +	ret =3D spi_write(ssd1351->spi, &cmd, 1);

[Severity: High]
Does this code pass a stack-allocated variable to spi_write()?

The SPI subsystem requires that buffers passed to spi_write() be DMA-safe.
Since cmd is a local variable on the stack, it may not be DMA-coherent
(especially if CONFIG_VMAP_STACK is enabled). Could this trigger cache
coherency failures or memory corruption when the SPI core attempts to map i=
t?

> +	if (ret)
> +		return ret;
[ ... ]
> +/* Send a command followed by a fixed list of single-byte parameters. */
> +#define ssd1351_command(ssd1351, cmd, ...)                   \
> +	({                                                   \
> +		static const u8 _params[] =3D { __VA_ARGS__ }; \
> +		ssd1351_write_cmd((ssd1351), (cmd), _params, \
> +				  ARRAY_SIZE(_params));      \
> +	})

[Severity: High]
Does this macro pass read-only data (.rodata) to spi_write() via the
_params array?

Memory placed in .rodata is not DMA-safe. If the SPI subsystem attempts to =
map
this buffer for a DMA transfer, could this lead to kernel panics or undefin=
ed
behavior?

[ ... ]
> +static void ssd1351_reset(struct ssd1351_device *ssd1351)
> +{
> +	if (!ssd1351->reset)
> +		return;
> +
> +	/*
> +	 * Work in logical levels: 1 asserts reset, 0 releases it. The DT's
> +	 * GPIO_ACTIVE_LOW flag handles the physical inversion, so this pulse is
> +	 * correct regardless of how the board wires the RES# line.
> +	 */
> +	gpiod_set_value_cansleep(ssd1351->reset, 1);
> +	usleep_range(20, 1000);
> +	gpiod_set_value_cansleep(ssd1351->reset, 0);
> +	msleep(120);
> +}

[Severity: High]
Are we safely calling these sleeping functions?

This function is invoked via ssd1351_init_display() from the
ssd1351_crtc_atomic_enable() callback. According to DRM subsystem guideline=
s,
CRTC atomic callbacks execute in an atomic context where sleeping is strict=
ly
forbidden. Calling msleep() and usleep_range() here could result in system
instability or deadlocks.

[ ... ]
> +static void ssd1351_fb_blit_rect(struct ssd1351_device *ssd1351,
> +				 struct drm_framebuffer *fb,
> +				 const struct iosys_map *vmap,
> +				 struct drm_rect *rect,
> +				 struct drm_format_conv_state *fmtcnv_state)
> +{
> +	unsigned int width =3D drm_rect_width(rect);
> +	unsigned int height =3D drm_rect_height(rect);
> +	unsigned int dst_pitch =3D width * sizeof(u16);
> +	struct iosys_map dst;
> +	u8 range[2];
> +
> +	iosys_map_set_vaddr(&dst, ssd1351->tx_buf);
> +
> +	/*
> +	 * The panel expects RGB565 most-significant byte first; the big-endian
> +	 * conversion produces exactly that byte stream for the 8-bit SPI words.
> +	 */
> +	drm_fb_xrgb8888_to_rgb565be(&dst, &dst_pitch, vmap, fb, rect,
> +				    fmtcnv_state);
> +
> +	range[0] =3D rect->x1;
> +	range[1] =3D rect->x2 - 1;
> +	if (ssd1351_write_cmd(ssd1351, SSD1351_SET_COL_ADDRESS, range,
> +			      sizeof(range)))

[Severity: High]
Similar to the issue in ssd1351_write_cmd(), does this pass the
stack-allocated range array down to spi_write()? This memory may not be
DMA-coherent.

[ ... ]
> +static void ssd1351_plane_atomic_update(struct drm_plane *plane,
> +					struct drm_atomic_state *state)
> +{
[ ... ]
> +	if (!drm_dev_enter(&ssd1351->drm, &idx))
> +		return;
> +
> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
> +		goto out_drm_dev_exit;
> +
> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
> +		dst_clip =3D plane_state->dst;
> +
> +		if (!drm_rect_intersect(&dst_clip, &damage))
> +			continue;
> +
> +		ssd1351_fb_blit_rect(ssd1351, fb, &shadow_plane_state->data[0],
> +				     &dst_clip,
> +				     &shadow_plane_state->fmtcnv_state);
> +	}

[Severity: High]
Does this code call sleeping functions from within an atomic context?

According to DRM subsystem guidelines, plane atomic update callbacks execute
in an atomic context during non-blocking commits, where sleeping is strictly
forbidden. However, drm_gem_fb_begin_cpu_access() can block on dma-buf fenc=
es,
and ssd1351_fb_blit_rect() performs blocking SPI writes. The standard DRM
pattern for SPI displays is to defer hardware updates to a worker thread.

[Severity: High]
Does this loop also pass destination coordinates to a function expecting so=
urce
coordinates?

The helper drm_atomic_for_each_plane_damage() yields damage clips in CRTC
destination coordinates. The driver intersects these with dst_clip and pass=
es
the result to ssd1351_fb_blit_rect(), which then passes it to
drm_fb_xrgb8888_to_rgb565be().

However, drm_fb_xrgb8888_to_rgb565be() expects the clipping rectangle to be
in framebuffer (source) coordinates to accurately extract pixels. If the
framebuffer is panned (i.e., src_x or src_y are non-zero), using destination
coordinates could extract pixels from the wrong location.

[ ... ]
> +static void ssd1351_crtc_atomic_disable(struct drm_crtc *crtc,
> +					struct drm_atomic_state *state)
> +{
> +	struct ssd1351_device *ssd1351 =3D drm_to_ssd1351(crtc->dev);
> +	int idx;
> +
> +	if (!drm_dev_enter(crtc->dev, &idx))
> +		return;
> +
> +	ssd1351_command(ssd1351, SSD1351_SET_DISPLAY_OFF);
> +
> +	drm_dev_exit(idx);
> +}
[ ... ]
> +static void ssd1351_remove(struct spi_device *spi)
> +{
> +	struct drm_device *drm =3D spi_get_drvdata(spi);
> +
> +	drm_dev_unplug(drm);
> +	drm_atomic_helper_shutdown(drm);
> +}

[Severity: High]
Could the OLED display remain powered on when the driver module is unloaded?

In ssd1351_remove(), drm_dev_unplug() is called before
drm_atomic_helper_shutdown(). The drm_dev_unplug() call immediately sets the
DRM device's unplugged flag.

When drm_atomic_helper_shutdown() subsequently triggers the
ssd1351_crtc_atomic_disable() callback, the drm_dev_enter() check in that
callback will fail because the device is already marked as unplugged. As a
result, the display-off command will never be sent to the hardware.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260610164428.1800=
91-1-amit.barzilai22@gmail.com?part=3D2
