Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 70758C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 15:03:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BC69010F631;
	Thu, 24 Sep 2026 15:03:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="LSreKgWp";
	dkim-atps=neutral
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2AF5410F631
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 15:03:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id C9BC542ADB;
 Thu, 24 Sep 2026 15:03:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 67C6A1F000FF;
 Thu, 24 Sep 2026 15:03:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790262208;
 bh=k/UlegJri9M8kl6wuLnDNVVTFN6rqxNxuZ0Xv221Hm4=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=LSreKgWpEzUIqqRbEMa+26S9twk4jPDPhUvH6HJUfMmTdSomxCrok8Q56CdiLXnpZ
 i2713h/9X93bFYg89611VYP6QXQt0mhsGGKKz0V6+f2MPrpkWKjx2077+q4I9rnpgU
 OzRXYT8n4lqO8lv1+B5XWu/hpkV9avgPJDbb29PwHQb/g7vjMEBL+PKfUU1mDfFvYE
 f3cYxAutQ1b75bM6og8Eunjg+DKHueu4MFWejhv/1VHqlRgIpTc1TTi02nn0uPQK6/
 ht+iBKkUlz+5dy9mJR+9yMAO9RbyNgxUjmYU8gTttWp8tHPM9/UIiK+jvNkVPvbcu5
 XcVDTLKwrqRyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] drm/tiny: Add RAiO RA8875 display controller driver
To: "Adam Azuddin" <azuddinadam@gmail.com>
Cc: robh@kernel.org, conor+dt@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org
In-Reply-To: <20260924145400.1385815-3-azuddinadam@gmail.com>
References: <20260924145400.1385815-1-azuddinadam@gmail.com>
 <20260924145400.1385815-3-azuddinadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 24 Sep 2026 15:03:27 +0000
Message-Id: <20260924150328.67C6A1F000FF@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm/tiny: atomic context violation by calling sleeping functions
- [High] spi: DMA-unsafe stack buffers passed to spi_sync
- [High] drm: missing reset callback in drm_crtc_funcs leads to null deref
- [High] drm: missing cleanup_fb causes GEM object pin leaks
- [Medium] spi: massive contiguous allocation and unbounded spi transfers
- [Medium] drm: missing atomic_disable hook causes intentional warnings
- [Medium] spi: missing cs_change=3D1 breaks RA8875 spi protocol
--

commit 594ac08dfc437ba3494bf3b5226a6268a7e028be
Author: Adam Azuddin <azuddinadam@gmail.com>

    drm/tiny: Add RAiO RA8875 display controller driver
   =20
    Add a DRM tiny driver for the RAiO RA8875 SPI-connected TFT display
    controller. The driver supports display resolutions up to 800x480
    and uses the GEM shmem helper for buffer management.

> diff --git a/drivers/gpu/drm/tiny/ra8875.c b/drivers/gpu/drm/tiny/ra8875.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/ra8875.c

[ ... ]

> +static int ra8875_read_reg(struct ra8875_device *ra8875, u8 reg, u8 *val)
> +{
> +	ra8875->cmd_buf[0] =3D RA8875_CMDWRITE;
> +	ra8875->cmd_buf[1] =3D reg;
> +	int ret;
> +
> +	u8 tx[2] =3D { 0x40, 0x00 };
> +	u8 rx[2] =3D { 0x00, 0x00 };
> +
> +	struct spi_transfer t_cmd =3D {
> +		.tx_buf =3D ra8875->cmd_buf,
> +		.len =3D 2,
> +		.speed_hz =3D RA8875_REG_SPI_SPEED,
> +		.cs_change =3D 1
> +	};
> +	struct spi_transfer t_read =3D {
> +		.tx_buf =3D tx,
> +		.rx_buf =3D rx,
> +		.len =3D 2,
> +		.speed_hz =3D RA8875_REG_SPI_SPEED,
> +	};
> +	struct spi_message m;
> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t_cmd, &m);
> +	spi_message_add_tail(&t_read, &m);
> +
> +	ret =3D spi_sync(ra8875->spi, &m);

[Severity: High]
Does this code pass stack memory into a DMA-mapped SPI transfer?

The Linux SPI subsystem uses the DMA API to map transfer buffers if the SPI
controller supports it. Stack memory allocated for tx and rx might not be
physically contiguous, leading to memory corruption or cache coherency
failures.

> +	if (ret)
> +		return ret;

[ ... ]

> +static int ra8875_hw_init(struct ra8875_device *ra8875,
> +			  struct drm_display_mode *mode)
> +{
> +	u8 hdwr, hndr, hstr, hpwr, vpwr;
> +	u16 vdhr, vndr, vstr;
> +	u8 readback;
> +	int ret;
> +
> +	if (ra8875->rst_gpio) {
> +		gpiod_set_value_cansleep(ra8875->rst_gpio, 1);
> +		usleep_range(1000, 1200);
> +		gpiod_set_value_cansleep(ra8875->rst_gpio, 0);
> +		msleep(RA8875_RESET_WAIT_MS);
> +	}

[Severity: High]
Does this execute sleeping functions in an atomic context?

The global review guidelines dictate that CRTC and plane atomic update
callbacks execute in an atomic context during non-blocking commits, where
hardware sequence paths must not sleep.

Since ra8875_hw_init() is called by ra8875_crtc_atomic_enable(), executing
msleep(), usleep_range(), and gpiod_set_value_cansleep() here can lead to
system instability, lockups, and kernel warnings for scheduling while atomi=
c.

> +
> +	/* Soft Reset Sequence */
> +	ret =3D ra8875_write_reg(ra8875, RA8875_PWRR, RA8875_PWRR_SOFTRST);

[ ... ]

> +static int ra8875_clear_screen(struct ra8875_device *ra8875,
> +			       struct drm_display_mode *mode)
> +{

[ ... ]

> +	for (y =3D 0; y < height;) {
> +		rows =3D min(rows_per_chunk, height - y);
> +
> +		u8 cmd[2] =3D { RA8875_CMDWRITE, RA8875_MRWC };
> +		struct spi_transfer t_cmd =3D {
> +			.tx_buf =3D cmd,
> +			.len =3D 2,
> +			.speed_hz =3D RA8875_REG_SPI_SPEED,
> +		};

[Severity: Medium]
Will the missing cs_change =3D 1 break the RA8875 SPI protocol here?

Unlike ra8875_write_reg() which sets cs_change =3D 1 for command transfers
to de-assert the chip select before sending the data payload, this transfer
omits it. Without toggling the CS pin between the command and data phases,
the hardware might misinterpret the incoming data.

[Severity: High]
Does this code use stack memory for an SPI transfer buffer?

Passing the local stack array cmd into spi_sync() is unsafe because the SPI
subsystem may use DMA to map the buffer, which is explicitly prohibited for
stack variables.

> +		struct spi_transfer t_data =3D {
> +			.tx_buf =3D txbuf,
> +			.len =3D 1 + rows * width * 2,
> +			.speed_hz =3D RA8875_MAX_SPI_SPEED,
> +		};
> +		struct spi_message m;

[ ... ]

> +static void ra8875_fb_dirty(struct ra8875_device *ra8875, struct iosys_m=
ap *src,
> +			    struct drm_framebuffer *fb, struct drm_rect *rect)
> +{

[ ... ]

> +	memset(&t_data, 0, sizeof(t_data));
> +	t_data.tx_buf =3D ra8875->txbuf;
> +	t_data.len =3D 1 + height * width * 2;
> +	t_data.speed_hz =3D ra8875->spi->max_speed_hz;

[Severity: Medium]
Will this result in unbounded SPI transfers that exceed the host controller=
's
limits?

The driver attempts to send up to the entire 768 KB buffer (for an 800x480
resolution) in a single spi_transfer depending on the damage rect size.
Many SPI controllers impose maximum transfer limits, such as 65535 bytes,
and will reject oversized transfers.

> +
> +	spi_message_init(&m);
> +	spi_message_add_tail(&t_data, &m);
> +	if (spi_sync(ra8875->spi, &m))

[Severity: High]
Does this call a sleeping function from the plane's atomic update callback?

spi_sync() sleeps while waiting for hardware I/O to complete.
Because ra8875_fb_dirty() is invoked from ra8875_plane_atomic_update(),
this executes sleeping routines in an atomic context, leading to kernel
warnings and system lockups.

> +		goto err;
> +
> +	drm_format_conv_state_release(&fmtcnv_state);

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
> +	if (drm_WARN_ON_ONCE(&ra8875->drm, !fb))
> +		return;

[Severity: Medium]
Is this code triggering intentional warnings during plane disables?

Because the driver does not provide an atomic_disable callback in
ra8875_plane_helper_funcs, the DRM atomic helpers fall back to calling
atomic_update with a NULL fb. This warning will immediately fire on valid
plane disable requests, generating a stack trace that could crash the system
if panic_on_warn is enabled.

> +
> +	if (!drm_dev_enter(&ra8875->drm, &idx))

[ ... ]

> +static const struct drm_crtc_funcs ra8875_crtc_funcs =3D {
> +	.atomic_create_state =3D drm_atomic_helper_crtc_create_state,

[Severity: High]
Does this structure omit the required .reset callback and mistakenly assign
to .atomic_create_state instead of .atomic_duplicate_state (or similar)?

There is no .atomic_create_state member in drm_crtc_funcs, causing a build
failure. Furthermore, omitting the required .reset callback (typically
drm_atomic_helper_crtc_reset) leaves crtc->state as NULL, leading to a
kernel panic upon the first atomic check or commit.

> +	.destroy =3D drm_crtc_cleanup,
> +	.set_config =3D drm_atomic_helper_set_config,
> +	.page_flip =3D drm_atomic_helper_page_flip,
> +	.atomic_duplicate_state =3D drm_atomic_helper_crtc_duplicate_state,
> +	.atomic_destroy_state =3D drm_atomic_helper_crtc_destroy_state,
> +};
> +
> +static const struct drm_crtc_helper_funcs ra8875_crtc_helper_funcs =3D {
> +	.mode_valid =3D ra8875_mode_valid,
> +	.atomic_enable =3D ra8875_crtc_atomic_enable,
> +	.atomic_disable =3D ra8875_crtc_atomic_disable,
> +};
> +
> +static const struct drm_plane_funcs ra8875_plane_funcs =3D {
> +	.update_plane =3D drm_atomic_helper_update_plane,
> +	.disable_plane =3D drm_atomic_helper_disable_plane,
> +	.destroy =3D drm_plane_cleanup,
> +	DRM_GEM_SHADOW_PLANE_FUNCS,
> +};
> +
> +static const struct drm_plane_helper_funcs ra8875_plane_helper_funcs =3D=
 {
> +	.prepare_fb =3D drm_gem_plane_helper_prepare_fb,
> +	.begin_fb_access =3D drm_gem_begin_shadow_fb_access,
> +	.end_fb_access =3D drm_gem_end_shadow_fb_access,
> +	.atomic_check =3D ra8875_plane_atomic_check,
> +	.atomic_update =3D ra8875_plane_atomic_update,
> +};

[Severity: High]
Does this code leak GEM object pins by missing a cleanup_fb hook?

The driver specifies .prepare_fb =3D drm_gem_plane_helper_prepare_fb, which
pins the framebuffer during a page flip or mode set. Without providing a
matching .cleanup_fb hook (such as drm_gem_plane_helper_cleanup_fb), the
framebuffer is never unpinned. The GEM object reference count will perpetua=
lly
increase, and the memory cannot be freed.

> +
> +static const struct drm_driver ra8875_driver =3D {

[ ... ]

> +static int ra8875_probe(struct spi_device *spi)
> +{

[ ... ]

> +	ret =3D spi_setup(spi);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Failed to setup SPI:\n");
> +
> +	buf_size =3D 1 + RA8875_MAX_HEIGHT * RA8875_MAX_WIDTH * 2;
> +	ra8875->txbuf =3D devm_kzalloc(&spi->dev, buf_size, GFP_KERNEL);

[Severity: Medium]
Will this fail to allocate memory on fragmented systems?

The driver allocates ~768 KB of memory for a maximum 800x480 resolution usi=
ng
devm_kzalloc. Because this requires an order-8 contiguous physical allocati=
on,
it is highly likely to fail on systems with memory fragmentation.

> +	if (!ra8875->txbuf)
> +		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260924145400.1385=
815-1-azuddinadam@gmail.com?part=3D2
