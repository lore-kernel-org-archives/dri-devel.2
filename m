Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 23145CA5FCB
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:53:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 73ED610F27C;
	Thu,  1 Oct 2026 14:53:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="XJPZMuNP";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 341BA10F27C
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:53:57 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id E5ECC4382F;
 Thu,  1 Oct 2026 14:53:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 864931F000FF;
 Thu,  1 Oct 2026 14:53:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790866436;
 bh=K+k0KTpImTHjGNQ5pEHvbpyt5gjGcPLpxBcaQl2cc+A=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=XJPZMuNPTnL4pF3OU0/mQyMpw0f1su1RlL20IDqy67WUBAPsHHapDNx7ebqx1PNaL
 VPP+TIlRCq/dqy3sgHHh9kZm1DGCFQtsVvvFFMPzvLw6oKEgzbyLNkctaGmK3TOa6s
 F5psIsCIsMMGpmnCr9ZV9ITDBheuI6DpvuRZ3yPWkCR7/zNFjyrZP8n2q6DRfMH8Gq
 PtXqIAkjCL261eiXJmSSFNo/0KryrGb175B3+lQ3vp9altYaZdPvG+FjKWysOgzY3T
 tkR796iSoR0LVzCIBNKZqsnyWgJkCvOnHWjgWESYEt6/KzyrOjITtt9cJsT0Jr5nCD
 XvG1DaJ6WGeMA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/2] drm/tiny: Add RAiO RA8875 display controller driver
To: "Adam Azuddin" <azuddinadam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <20261001144128.2336301-3-azuddinadam@gmail.com>
References: <20261001144128.2336301-1-azuddinadam@gmail.com>
 <20261001144128.2336301-3-azuddinadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 01 Oct 2026 14:53:56 +0000
Message-Id: <20261001145356.864931F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [High] drm/tiny: ra8875: sleeping functions called in atomic context
- [High] drm/tiny: ra8875: out-of-bounds DMA read due to double len increme=
nt
- [High] drm/tiny: ra8875: heap buffer overflow in ra8875_clear_screen
- [Medium] drm/tiny: ra8875: unsafe DMA from unaligned struct members
- [Low] drm/tiny: ra8875: spurious "Shadow map is null" error on plane disa=
ble
- [Low] drm/tiny: ra8875: missing error check on ra8875_write_pixels
--

commit a60dff365b1d365d54b1d95db3b3bdf06cf4d8be
Author: Adam Azuddin <azuddinadam@gmail.com>

drm/tiny: Add RAiO RA8875 display controller driver

This commit adds a DRM tiny driver for the RAiO RA8875 SPI-connected TFT
display controller. It supports display resolutions up to 800x480 and uses
the GEM shmem helper for buffer management.

> diff --git a/drivers/gpu/drm/tiny/ra8875.c b/drivers/gpu/drm/tiny/ra8875.c
> new file mode 100644
> index 0000000000000..d990d052e9477
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/ra8875.c
> @@ -0,0 +1,713 @@

[ ... ]

> +struct ra8875_device {
> +	struct drm_device drm;
> +	struct spi_device *spi;
> +	struct gpio_desc *rst_gpio;
> +	struct drm_crtc crtc;
> +	struct drm_plane plane;
> +	struct drm_encoder encoder;
> +	struct drm_connector connector;
> +	struct drm_display_mode mode;
> +	u8 cmd_buf[RA8875_CMD_DATA_BUF_SIZE];
> +	u8 data_buf[RA8875_CMD_DATA_BUF_SIZE];

[Severity: Medium]
Is it safe to use these inline arrays for DMA?=20

According to kernel DMA rules, buffers mapped for DMA must not share a
cacheline with other variables. Concurrent CPU accesses to adjacent members
in the structure (such as userspace reading mode properties) during an
ongoing SPI DMA transfer might cause cacheline bouncing and silent data
corruption. Should these arrays have cacheline alignment attributes or be
allocated separately?

> +	u8 *txbuf;
> +};

[ ... ]

> +static int ra8875_write_pixels(struct ra8875_device *ra8875, size_t len)
> +{
> +	int ret;
> +
> +	ra8875->cmd_buf[0] =3D RA8875_CMDWRITE;
> +	ra8875->cmd_buf[1] =3D RA8875_MRWC;
> +	ret =3D spi_write(ra8875->spi, ra8875->cmd_buf, 2);
> +	if (ret)
> +		return ret;
> +
> +	return spi_write(ra8875->spi, ra8875->txbuf, 1 + len);

[Severity: High]
Does this length calculation cause an out-of-bounds DMA read?=20

The callers (ra8875_clear_screen() and ra8875_fb_dirty()) already account
for the 1-byte command header when calculating the len argument. For exampl=
e,
they pass '1 + rows * width * 2'. This double-addition appears to cause the
requested SPI transfer size to be 1 byte larger than intended, which can
exceed the fixed heap allocation of txbuf.

> +}
> +
> +static int ra8875_hw_init(struct ra8875_device *ra8875,
> +			  struct drm_display_mode *mode)
> +{
> +	u8 hdwr, hndr, hstr, hpwr, vpwr;
> +	u16 vdhr, vndr, vstr;
> +	int ret;
> +
> +	if (ra8875->rst_gpio) {
> +		gpiod_set_value_cansleep(ra8875->rst_gpio, 1);
> +		usleep_range(1000, 1200);
> +		gpiod_set_value_cansleep(ra8875->rst_gpio, 0);
> +		msleep(RA8875_RESET_WAIT_MS);
> +	}

[Severity: High]
Can these sleeping functions be called safely here?=20

This hardware initialization routine is invoked by ra8875_crtc_atomic_enabl=
e(),
which runs in atomic context. Calling msleep(), usleep_range(), or=20
gpiod_set_value_cansleep() in an atomic context causes kernel warnings and
potential deadlocks. Note that synchronous spi_write() is also used through=
out
these atomic callbacks, which similarly sleeps.

[ ... ]

> +static int ra8875_clear_screen(struct ra8875_device *ra8875,
> +			       struct drm_display_mode *mode)
> +{
> +	int width =3D mode->hdisplay;
> +	int height =3D mode->vdisplay;
> +	int y, rows, ret;
> +	u8 *txbuf =3D ra8875->txbuf;
> +	int rows_per_chunk =3D RA8875_TXBUF_ROWS;

[ ... ]

> +	ret =3D ra8875_write_reg(ra8875, RA8875_CURV1, 0);
> +	if (ret)
> +		return ret;
> +
> +	memset(txbuf, 0, 1 + rows_per_chunk * width * 2);

[Severity: High]
Does this risk a heap buffer overflow?=20

The width parameter is derived from mode->hdisplay. Since ra8875_mode_valid=
()
does not restrict the maximum width, a maliciously large hdisplay (e.g., 16=
00)
could cause this memset to exceed the fixed txbuf allocation bounds and cor=
rupt
kernel memory.

> +	txbuf[0] =3D RA8875_DATAWRITE;
> +
> +	for (y =3D 0; y < height; y +=3D rows) {
> +		rows =3D min(rows_per_chunk, height - y);
> +		ra8875_write_pixels(ra8875, 1 + rows * width * 2);
> +	}
> +
> +	return 0;
> +}

[ ... ]

> +static void ra8875_fb_dirty(struct ra8875_device *ra8875, struct iosys_m=
ap *src,
> +			    struct drm_framebuffer *fb, struct drm_rect *rect)
> +{

[ ... ]

> +	for (int y =3D rect->y1; y < rect->y2; y +=3D rows) {
> +		struct drm_rect chunk;
> +
> +		rows =3D min(RA8875_TXBUF_ROWS, rect->y2 - y);
> +		chunk =3D DRM_RECT_INIT(rect->x1, y, width, rows);
> +
> +		iosys_map_set_vaddr(&dst, ra8875->txbuf + 1);
> +		drm_fb_swab(&dst, NULL, src, fb, &chunk, false, &fmtcnv_state);
> +
> +		ra8875_write_pixels(ra8875, 1 + rows * width * 2);

[Severity: Low]
Is it intentional that the integer return value of ra8875_write_pixels()
is ignored here?=20

If an SPI bus error occurs, the driver will blindly continue to iterate and
attempt to write subsequent chunks, hiding the failure from the kernel log.

> +	}
> +
> +	drm_format_conv_state_release(&fmtcnv_state);
> +	return;

[ ... ]

> +static void ra8875_plane_atomic_update(struct drm_plane *plane, struct d=
rm_atomic_commit *state)
> +{
> +	struct ra8875_device *ra8875 =3D container_of(plane->dev, struct ra8875=
_device, drm);
> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(plane_state);
> +	struct drm_framebuffer *fb =3D plane_state->fb;
> +	struct drm_rect rect;
> +	struct iosys_map *map =3D &shadow_plane_state->data[0];
> +	int idx;
> +
> +	if (!drm_dev_enter(&ra8875->drm, &idx))
> +		return;
> +
> +	if (iosys_map_is_null(map)) {
> +		drm_err(&ra8875->drm, "Shadow map is null\n");

[Severity: Low]
Will this unconditionally log a spurious error for standard plane disable
operations?=20

Since the driver does not implement the atomic_disable hook, the core falls
back to calling atomic_update() with a NULL framebuffer when disabling the
plane.=20

> +		goto exit;
> +	}
> +	if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect=
))
> +		ra8875_fb_dirty(ra8875, map, fb, &rect);
> +exit:
> +	drm_dev_exit(idx);
> +}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261001144128.2336=
301-1-azuddinadam@gmail.com?part=3D2
