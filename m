Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 07670606A326
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 13:31:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=bIPPi35k
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5AE9C10E93A;
	Tue, 10 Nov 2026 13:31:08 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6005710E93A
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 13:31:02 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 0E7CC42A46;
 Tue, 10 Nov 2026 13:31:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9BE051F008A1;
 Tue, 10 Nov 2026 13:31:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1794317461;
 bh=pewesUty4m8/6Jf4CX95BIWO4NK1BdB+BvjzGPy6b9Q=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=bIPPi35ku6Affa9aD1E09KxOAcxbT8F+4Adl78tcT87zoCLWJQxHi4uUwjSuQ5b2T
 AL7Dz+ObNZp4HmGcLvR45bR0snOcPiwCvNe9FmZZoIATIuzmFbQjImqfEnOx7PqJou
 mtTdkZ0mf0AS9qGB+jbyI2EPMU+LGBknxlW/AkC2ltCs9UROFuAD6+G4AMJsmT/tgp
 oVI8CwK3mj7kd2LIesT13BdZXrDtfx+f8EJfb97R/G2uqOAFinMovRbOdJYRn0MJzo
 9MK3zNy7Cu04nocxHaxAFy0uAskJZA87HbnXKE1GOt6uPxInzFSv8tc0EjT4B5rwOt
 WYKSHuNasNecQ==
Message-ID: <sashiko-outbox-207123@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/2] drm/tiny: Add RAiO RA8875 display controller driver
To: "Adam Azuddin" <azuddinadam@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261110130515.45819-3-azuddinadam@gmail.com>
References: <20261110130515.45819-1-azuddinadam@gmail.com>
 <20261110130515.45819-3-azuddinadam@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 10 Nov 2026 13:31:01 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential
issues to consider:
- [Critical] drm/tiny: ra8875: heap overflow in ra8875_clear_screen()
  via mode width
- [High] drm/tiny: ra8875: plane updates run before CRTC enable and
  screen clear
- [High] drm/tiny: ra8875: miscalculation of HNDR and VNDR in
  ra8875_hw_init()
- [High] drm/tiny: ra8875: missing drm_dev_enter() in
  ra8875_crtc_atomic_enable()
- [Medium] drm/tiny: ra8875: missing vdd-supply regulator enable in
  ra8875_probe()
- [Medium] drm/tiny: ra8875: missing drm_gem_fb_begin_cpu_access() in
  ra8875_fb_dirty()
- [Medium] drm/tiny: ra8875: unaligned u16 destination in
  ra8875_fb_dirty()
- [Low] drm/tiny: ra8875: missing MMU dependency in Kconfig for
  DRM_RA8875
--

commit c87472ee809dcef3cdfa786e0f03db0247928c50
Author: Adam Azuddin <azuddinadam@gmail.com>

drm/tiny: Add RAiO RA8875 display controller driver

This commit adds a DRM tiny driver for the SPI-connected RAiO RA8875 TFT
display controller using the GEM shmem helper.

> diff --git a/drivers/gpu/drm/tiny/Kconfig b/drivers/gpu/drm/tiny/Kconfig
> index f0e72d4b6a470..2f1c49e31dd60 100644
> --- a/drivers/gpu/drm/tiny/Kconfig
> +++ b/drivers/gpu/drm/tiny/Kconfig
> @@ -98,6 +98,19 @@ config DRM_PIXPAPER
> =20
>  	  If M is selected, the module will be built as pixpaper.ko.
> =20
> +config DRM_RA8875
> +	tristate "DRM support for RA8875 display panels"
> +	depends on DRM && SPI && OF
> +	select DRM_CLIENT_SELECTION
> +	select DRM_KMS_HELPER
> +	select DRM_GEM_SHMEM_HELPER
> +	select VIDEOMODE_HELPERS

[Severity: Low]
Should DRM_RA8875 depend on MMU?  DRM_GEM_SHMEM_HELPER depends on MMU, so
selecting it on a !CONFIG_MMU build triggers an unmet direct dependency
warning and fails to link against MMU-only symbols such as vmf_insert_pfn().

[ ... ]

> diff --git a/drivers/gpu/drm/tiny/ra8875.c b/drivers/gpu/drm/tiny/ra8875.c
> new file mode 100644
> index 0000000000000..bf1584c6aa79d
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/ra8875.c

[ ... ]

> +	/* Horizontal timing */
> +	hdwr =3D (mode->hdisplay / 8) - 1;
> +	hndr =3D ((mode->htotal - mode->hdisplay) / 8) - 1;
> +	hstr =3D ((mode->hsync_start - mode->hdisplay) / 8) - 1;
> +	hpwr =3D ((mode->hsync_end - mode->hsync_start) / 8) - 1;
> +
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HDWR, hdwr);
> +	if (ret)
> +		return ret;
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HNDFTR, RA8875_HNDFTR_HNDFT(0));
> +	if (ret)
> +		return ret;
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HNDR, hndr);
> +	if (ret)
> +		return ret;
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HSTR, hstr);
> +	if (ret)
> +		return ret;
> +	ret =3D ra8875_write_reg(ra8875, RA8875_HPWR, hpwr);
> +	if (ret)
> +		return ret;
> +
> +	/* Vertical timing */
> +	vdhr =3D mode->vdisplay - 1;
> +	vndr =3D mode->vtotal - mode->vdisplay - 1;
> +	vstr =3D mode->vsync_start - mode->vdisplay - 1;
> +	vpwr =3D mode->vsync_end - mode->vsync_start - 1;

[Severity: High]
Are hndr and vndr calculated from the total blanking interval instead of
the back porch?

In drm_display_mode_from_videomode(), htotal - hdisplay is the sum of the
front porch, sync pulse, and back porch.  Because HSTR/VSTR and HPWR/VPWR
already program the front porch and sync pulse width, RA8875_HNDR and
RA8875_VNDR0/1 expect only the back porch (mode->htotal - mode->hsync_end
and mode->vtotal - mode->vsync_end), so this double-counts the front porch
and sync pulse into the scanout timings.  Also, neither ra8875_probe() nor
ra8875_mode_valid() checks that each porch and sync pulse is non-zero before
subtracting 1, which can underflow these registers.

[ ... ]

> +	memset(txbuf, 0, 1 + rows_per_chunk * width * 2);
> +	txbuf[0] =3D RA8875_DATAWRITE;
> +
> +	for (y =3D 0; y < height; y +=3D rows) {
> +		rows =3D min(rows_per_chunk, height - y);
> +		ret =3D ra8875_write_pixels(ra8875, 1 + rows * width * 2);
> +		if (ret)
> +			return ret;
> +	}
> +
> +	return 0;
> +}

[Severity: Critical]
Can userspace overflow ra8875->txbuf in ra8875_clear_screen()?

ra8875_probe() allocates ra8875->txbuf for a fixed width of
RA8875_MAX_WIDTH (800), or 25,601 bytes.  However, ra8875_mode_valid() only
checks that horizontal timings are multiples of 8 and does not reject modes
larger than RA8875_MAX_WIDTH or call drm_crtc_helper_mode_valid_fixed().
If DRM master commits a custom mode with mode->hdisplay > 800 and the
primary plane disabled, ra8875_clear_screen() writes 1 + 16 * width * 2
bytes into txbuf, overflowing the heap buffer.

> +
> +static void ra8875_crtc_atomic_enable(struct drm_crtc *crtc, struct drm_=
atomic_commit *state)
> +{
> +	struct ra8875_device *ra8875 =3D
> +		container_of(crtc->dev, struct ra8875_device, drm);
> +	struct drm_crtc_state *crtc_state =3D
> +		drm_atomic_get_new_crtc_state(state, crtc);
> +	struct drm_display_mode *mode =3D &crtc_state->mode;
> +	int ret;
> +
> +	ret =3D ra8875_hw_init(ra8875, mode);
> +	if (ret) {
> +		drm_err(&ra8875->drm, "Failed to initialize hardware\n");
> +		return;
> +	}
> +
> +	ret =3D ra8875_clear_screen(ra8875, mode);
> +	if (ret) {
> +		drm_err(&ra8875->drm, "Failed to clear screen\n");
> +		return;
> +	}
> +}

[Severity: High]
Does ra8875_crtc_atomic_enable() wipe out the initial plane update on every
modeset?

Because drm->mode_config.helper_private is not set to use
drm_atomic_helper_commit_tail_rpm(), the default
drm_atomic_helper_commit_tail() runs drm_atomic_helper_commit_planes()
before drm_atomic_helper_commit_modeset_enables().  On initial modeset,
ra8875_plane_atomic_update() writes the framebuffer while the controller is
still held in reset, and then ra8875_crtc_atomic_enable() resets the chip
and zeroes display RAM in ra8875_clear_screen(), leaving the panel blank.

In addition, ra8875_plane_atomic_check() passes can_update_disabled =3D true
and plane commits do not pass DRM_PLANE_COMMIT_ACTIVE_ONLY, so plane updates
while the CRTC is disabled will also write to the powered-down controller.

> +
> +static void ra8875_crtc_atomic_disable(struct drm_crtc *crtc, struct drm=
_atomic_commit *state)
> +{
> +	struct ra8875_device *ra8875 =3D
> +		container_of(crtc->dev, struct ra8875_device, drm);
> +
> +	ra8875_write_reg(ra8875, RA8875_P1CR, RA8875_P1CR_DISABLE);
> +	ra8875_write_reg(ra8875, RA8875_P1DCR, RA8875_P1DCR_MIN);
> +
> +	ra8875_write_reg(ra8875, RA8875_PWRR, RA8875_PWRR_DISPOFF);
> +}

[Severity: High]
Can ra8875_crtc_atomic_enable() and ra8875_crtc_atomic_disable() race with
ra8875_remove() and cause a use-after-free?

CPU0                              CPU1
ra8875_crtc_atomic_enable()
  ra8875_hw_init()
    msleep(RA8875_RESET_WAIT_MS)
                                  ra8875_remove()
                                    drm_dev_unplug(drm)
                                    ...
                                  devres_release_all(&spi->dev)
                                    /* frees txbuf and rst_gpio */
  ra8875_clear_screen()
    memset(txbuf, 0, ...)         <-- use-after-free

Unlike ra8875_plane_atomic_update(), neither CRTC callback guards its
hardware and buffer accesses with drm_dev_enter() and drm_dev_exit().
Because ra8875->txbuf and ra8875->rst_gpio are managed by devres on
&spi->dev while struct ra8875_device lives until the last drm_device
reference drops, drm_dev_unplug() does not wait for in-flight CRTC enable
or disable callbacks before devres frees txbuf and rst_gpio.

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
> +		if (ra8875_write_pixels(ra8875, 1 + rows * width * 2))
> +			goto err;
> +	}

[Severity: Medium]
Does passing ra8875->txbuf + 1 to drm_fb_swab() perform unaligned 16-bit
writes on every pixel?

ra8875->txbuf is kmalloc-aligned to an even address, so ra8875->txbuf + 1
is at an odd byte address.  For DRM_FORMAT_RGB565 in system memory,
drm_fb_swab() calls drm_fb_swab16_line(), which casts the destination
pointer directly to u16 * and dereferences it without put_unaligned(),
triggering alignment faults on strict-alignment architectures and UBSAN
warnings.

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
> +	if (!fb)
> +		return;
> +
> +	if (!drm_dev_enter(&ra8875->drm, &idx))
> +		return;
> +
> +	if (iosys_map_is_null(map)) {
> +		drm_err(&ra8875->drm, "Shadow map is null\n");
> +		goto exit;
> +	}
> +	if (drm_atomic_helper_damage_merged(old_plane_state, plane_state, &rect=
))
> +		ra8875_fb_dirty(ra8875, map, fb, &rect);
> +exit:
> +	drm_dev_exit(idx);
> +}

[Severity: Medium]
Should the framebuffer CPU read here be bracketed with
drm_gem_fb_begin_cpu_access() and drm_gem_fb_end_cpu_access()?

drm_gem_begin_shadow_fb_access() only vmaps the buffer and does not
synchronize caches for imported DMA-BUFs, so reading src in drm_fb_swab()
can observe stale data on non-coherent platforms.  Also, ra8875_fb_dirty()
could pass &shadow_plane_state->fmtcnv_state instead of allocating and
freeing a local drm_format_conv_state on every update.

[ ... ]

> +	drm =3D &ra8875->drm;
> +	connector =3D &ra8875->connector;
> +
> +	ra8875->rst_gpio =3D devm_gpiod_get_optional(dev, "reset", GPIOD_OUT_HI=
GH);
> +	if (IS_ERR(ra8875->rst_gpio))
> +		return dev_err_probe(dev, PTR_ERR(ra8875->rst_gpio),
> +			     "failed to get reset GPIO\n");

[Severity: Medium]
Does ra8875_probe() need to enable the vdd-supply regulator?

The raio,ra8875 DT binding requires vdd-supply, but the driver never
requests or enables it (for example with devm_regulator_get_enable(dev,
"vdd")), leaving the controller unpowered on boards where vdd-supply is a
switchable regulator.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110130515.4581=
9-1-azuddinadam@gmail.com?part=3D2
