Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5456606A319
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 22:02:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=P8WGJ60y
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F1C410EB52;
	Mon, 19 Oct 2026 22:02:36 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ECC5B10EB52
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 22:02:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id A85CB400E0;
 Mon, 19 Oct 2026 22:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5A7AF1F000C4;
 Mon, 19 Oct 2026 22:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792447349;
 bh=lAcPQ6d/0SsPovOJZ2BJ36ImSXmQDIr23ieq/SRUWis=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=P8WGJ60yIfuSu4h6QHOWwnGRGSzHv9gubGVhsAjM+WrhQZKWh6P1Nv95kdbiUdhTO
 Hcg/dpL1gJoqZJBB0tDHtB8CSasz0gEr8babDj7SIX4WMk5N8vIsSZNKudg8r2Brzm
 xjh4b3rA8AcP4bqPd7t466V0Xr0xhjJzxtI3byml/rtP8XxTi/F02eVrKE6qaMw0YA
 301i8QBgdf4oQb0eqTqfVcPN677bHY/P2T4ZTqzE6ys4MkdA8jygb9H3KmGNNinIok
 frAAGKtKieQuiTRfOjGO7yD2VtrfQEtiduyDwwB3CnSJycj1pz2yTPuKiGyoj/yrgS
 qLEsTcmKyv2aQ==
Message-ID: <sashiko-outbox-178287@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 04/14] drm/solomon: Add DRM driver for Solomon
 SSD16xx e-paper display controllers
To: "Devarsh Thakkar" <devarsht@ti.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261019213726.4145532-5-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-5-devarsht@ti.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 22:02:28 +0000
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
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1
X-Archived-By: <archiver.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:
- [Critical] drm/solomon: heap buffer overflow of tx_buf in ssd16xx_fb_dirt=
y()
- [Medium] drm/solomon: bit-reversed pixels in ssd16xx_convert_fb_to_1bpp()
- [Medium] drm/solomon: ssd16xx_convert_fb_to_3color() ignores orientation
- [Medium] drm/solomon: init_refresh_pending cleared on error in atomic_upd=
ate
- [Medium] drm/solomon: ssd16xx: use-after-free of devm-allocated mode afte=
r unbind
- [Low] drm/solomon: broken portrait check in ssd16xx_connector_get_modes()
--

commit 2fb6265a2051abb85583fcfb0ff873962f7bd4d7
Author: Devarsh Thakkar <devarsht@ti.com>

drm/solomon: Add DRM driver for Solomon SSD16xx e-paper display controllers

This commit adds a DRM driver for the Solomon Systech SSD16xx family of
e-paper display controllers over SPI, starting with support for the
Gooddisplay GDEY042T81 400x300 black/white panel using the SSD1683
controller.

[1] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1683
[2] : https://files.seeedstudio.com/wiki/Other_Display/42-epaper/GDEY042T81=
.pdf
[3] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1673
[4] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1680
[5] : https://www.crystalfontz.com/controllers/SolomonSystech/SSD1681

> diff --git a/drivers/gpu/drm/solomon/ssd16xx.c b/drivers/gpu/drm/solomon/=
ssd16xx.c
> new file mode 100644
> index 0000000000000..ca6550b5dd5bd
> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c
> @@ -0,0 +1,1801 @@

[ ... ]

> +static int ssd16xx_hw_init(struct ssd16xx_device *device)
> +{

[ ... ]

> +	switch (device->orientation) {
> +	case 90:
> +	case 180:
> +		data_entry_mode =3D SSD16XX_DATA_ENTRY_XDEC_YDEC;
> +		break;
> +	default: /* 0=C2=B0/270=C2=B0 */
> +		data_entry_mode =3D SSD16XX_DATA_ENTRY_XINC_YINC;
> +		break;
> +	}

[ ... ]

> +static void ssd16xx_convert_fb_to_3color(u8 *bw_dst, u8 *red_dst,
> +					 struct iosys_map *src,
> +					 struct drm_framebuffer *fb,
> +					 struct drm_rect *rect)
> +{
> +	unsigned int x, y;
> +	u8 bw_byte =3D 0, red_byte =3D 0;
> +	unsigned int bit_pos =3D 0;
> +	unsigned int dst_idx =3D 0;
> +
> +	if (fb->format->format =3D=3D DRM_FORMAT_R1) {
> +		unsigned int src_pitch =3D fb->pitches[0];
> +		unsigned int width_bytes =3D drm_rect_width(rect) / 8;
> +		unsigned int data_size =3D width_bytes * drm_rect_height(rect);
> +
> +		/* White background =E2=80=94 no black pixels, only red ink shows */
> +		memset(bw_dst, 0xFF, data_size);
> +		/* RED RAM: copy R1 data directly (1=3Dred ink, 0=3Dno red) */
> +		for (y =3D rect->y1; y < rect->y2; y++) {
> +			u8 *line =3D src->vaddr + y * src_pitch + (rect->x1 / 8);
> +
> +			memcpy(red_dst + dst_idx, line, width_bytes);
> +			dst_idx +=3D width_bytes;
> +		}
> +		return;
> +	}
> +
> +	/* XRGB8888 */
> +	for (y =3D rect->y1; y < rect->y2; y++) {
> +		for (x =3D rect->x1; x < rect->x2; x++) {
> +			bool is_red =3D ssd16xx_pixel_is_red(src, fb, x, y);
> +
> +			if (is_red)
> +				red_byte |=3D (1 << (7 - bit_pos));
> +			else if (ssd16xx_pixel_is_white(src, fb, x, y))
> +				bw_byte |=3D (1 << (7 - bit_pos));
> +			if (++bit_pos =3D=3D 8) {
> +				bw_dst[dst_idx] =3D bw_byte;
> +				red_dst[dst_idx] =3D red_byte;
> +				dst_idx++;
> +				bw_byte =3D 0;
> +				red_byte =3D 0;
> +				bit_pos =3D 0;
> +			}
> +		}
> +		if (bit_pos > 0) {
> +			bw_dst[dst_idx] =3D bw_byte;
> +			red_dst[dst_idx] =3D red_byte;
> +			dst_idx++;
> +			bw_byte =3D 0;
> +			red_byte =3D 0;
> +			bit_pos =3D 0;
> +		}
> +	}
> +}

[Severity: Medium]
Should ssd16xx_convert_fb_to_3color() also handle device->orientation like
ssd16xx_convert_fb_to_1bpp() does?

When ssd16xx_fb_dirty() runs with device->color_mode =3D=3D
SSD16XX_COLOR_MODE_3COLOR and FULL or FAST refresh, it calls
ssd16xx_convert_fb_to_3color() without passing device->orientation.

Because ssd16xx_convert_fb_to_3color() always packs in 0-degree landscape
row-major order, 90, 180, and 270 degree rotations are ignored. In portrait
orientations (90 or 270 degrees) where fb->width is 300 and fb->height is
400, the XRGB8888 path packs 38 bytes per row across 400 rows (15,200 bytes
in row-major order instead of 300 column-major rows of 50 bytes, while
ssd16xx_fb_dirty() only sends data_size =3D 15,000 bytes), and the
DRM_FORMAT_R1 path computes width_bytes =3D 300 / 8 =3D 37 bytes per row
(14,800 bytes), truncating 4 pixels per row without transposing for
portrait orientation.

> +
> +/*
> + * Convert framebuffer to 1-bit monochrome for e-paper display.
> + *
> + * Supports XRGB8888 (thresholded via ITU-R BT.601 luma at 127) and R1
> + * (native 1bpp, zero-copy fast path for aligned landscape frames).
> + *
> + * Output layout:
> + *   0=C2=B0/180=C2=B0  landscape: row-major, left-to-right, top-to-bott=
om
> + *   90=C2=B0/270=C2=B0 CW portrait: column-major, rightmost column first
> + */
> +static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
> +				       struct drm_framebuffer *fb,
> +				       struct drm_rect *rect,
> +				       unsigned int orientation)
> +{

[ ... ]

> +	switch (orientation) {
> +	case 90:
> +	case 270:
> +		/*
> +		 * Portrait (90=C2=B0 or 270=C2=B0): column-major packing.
> +		 * Each portrait source column becomes one physical RAM row.
> +		 * The data entry mode and cursor position control scan direction.
> +		 */
> +		for (x =3D rect->x2 - 1; x >=3D (int)rect->x1; x--) {
> +			for (y =3D rect->y1; y < rect->y2; y++) {
> +				if (ssd16xx_pixel_is_white(src, fb, x, y))
> +					byte |=3D (1 << (7 - bit_pos));
> +				if (++bit_pos =3D=3D 8) {
> +					dst[dst_idx++] =3D byte;
> +					byte =3D 0;
> +					bit_pos =3D 0;
> +				}
> +			}
> +			if (bit_pos > 0) {
> +				dst[dst_idx++] =3D byte;
> +				byte =3D 0;
> +				bit_pos =3D 0;
> +			}
> +		}
> +		break;
> +
> +	case 0:
> +	case 180:
> +	default:
> +		/*
> +		 * Landscape (0=C2=B0 or 180=C2=B0): row-major packing.
> +		 * Each landscape source row becomes one physical RAM row.
> +		 * The data entry mode and cursor position control scan direction.
> +		 */
> +		for (y =3D rect->y1; y < rect->y2; y++) {
> +			for (x =3D rect->x1; x < rect->x2; x++) {
> +				if (ssd16xx_pixel_is_white(src, fb, x, y))
> +					byte |=3D (1 << (7 - bit_pos));
> +				if (++bit_pos =3D=3D 8) {
> +					dst[dst_idx++] =3D byte;
> +					byte =3D 0;
> +					bit_pos =3D 0;
> +				}
> +			}
> +			if (bit_pos > 0) {
> +				dst[dst_idx++] =3D byte;
> +				byte =3D 0;
> +				bit_pos =3D 0;
> +			}
> +		}
> +		break;
> +	}
> +}

[Severity: Medium]
Are pixels within each byte bit-reversed when orientation is 90 or 180
degrees?

When device->orientation is 90 or 180, ssd16xx_hw_init() configures Data
Entry Mode (command 0x11) to SSD16XX_DATA_ENTRY_XDEC_YDEC (0x00), and
ssd16xx_fb_dirty() sets the RAM X address counter to ram_x_end (49) so that
it decrements down to 0 across each scanline.

In SSD16xx byte-addressed RAM, each byte represents 8 horizontal pixels
along the physical X axis where bit 7 (MSB) drives source line 8 * X_addr +
0 and bit 0 (LSB) drives source line 8 * X_addr + 7. Decrementing the X
byte counter reverses the byte order across a scanline (49, 48, ..., 0),
but does not reverse the bit order within each byte.

Because ssd16xx_convert_fb_to_1bpp() uses the same MSB-first packing
expression:

    byte |=3D (1 << (7 - bit_pos));

for 90 and 180 degrees as it does for 270 and 0 degrees, pixel 0 is placed
at physical pixel 392 and pixel 7 at physical pixel 399 in X_addr =3D 49,
followed by pixel 8 at physical pixel 384 and pixel 15 at physical pixel
391 in X_addr =3D 48, mirroring each 8-pixel group horizontally.

> +
> +static int ssd16xx_fb_dirty(struct drm_framebuffer *fb, struct drm_rect =
*rect,
> +			    struct ssd16xx_device *device,
> +			    const struct iosys_map *src_map)
> +{
> +	const u8 *ctrl2_tbl =3D device->controller_cfg->ctrl2_refresh;
> +	struct iosys_map map =3D *src_map;
> +	int err =3D 0;
> +	unsigned int data_size =3D (device->width * device->height) / 8;
> +	u8 *mono_buffer =3D NULL;
> +	u8 *red_buffer =3D NULL;
> +	u16 ram_x_start, ram_x_end, ram_y_start, ram_y_end;
> +
> +	/*
> +	 * Process full display area.  The rect for convert_fb_to_1bpp uses
> +	 * the framebuffer (logical) dimensions - the pixel iteration walks
> +	 * the source fb coordinate space. RAM window registers below use
> +	 * the physical panel dimensions (device->width/height).
> +	 */
> +	rect->x1 =3D 0;
> +	rect->y1 =3D 0;
> +	rect->x2 =3D fb->width;
> +	rect->y2 =3D fb->height;

[Severity: Critical]
Can setting rect->x2 =3D fb->width and rect->y2 =3D fb->height here overflow
device->tx_buf and device->tx_red_buf?

In ssd16xx_probe(), drm->mode_config is configured with:

    drm->mode_config.min_width =3D min(device->width, device->height);
    drm->mode_config.max_width =3D max(device->width, device->height);
    drm->mode_config.min_height =3D min(device->width, device->height);
    drm->mode_config.max_height =3D max(device->width, device->height);

This allows userspace via DRM_IOCTL_MODE_ADDFB2 to create a 400x400
framebuffer and attach it to the primary plane with a 400x300 or 300x400
source rectangle matching the CRTC mode, which passes both
drm_atomic_plane_check() and ssd16xx_plane_atomic_check().

However, ssd16xx_alloc_tx_bufs() allocates device->tx_buf and
device->tx_red_buf with:

    size_t frame_size =3D max(DIV_ROUND_UP(device->width, 8) * device->heig=
ht,
                            DIV_ROUND_UP(device->height, 8) * device->width=
);

which is 15,200 bytes for a 400x300 panel. Because ssd16xx_fb_dirty()
overwrites rect with fb->width and fb->height (400x400) rather than the
active mode/clipped plane dimensions, ssd16xx_convert_fb_to_1bpp() and
ssd16xx_convert_fb_to_3color() will write (400 / 8) * 400 =3D 20,000 bytes
into the 15,200-byte heap buffer.

In addition, ssd16xx_crtc_mode_valid() accepts both 400x300 and 300x400
modes regardless of the static device->orientation configured in
ssd16xx_probe():

    if ((mode->hdisplay =3D=3D device->mode->hdisplay &&
         mode->vdisplay =3D=3D device->mode->vdisplay) ||
        (mode->hdisplay =3D=3D device->mode->vdisplay &&
         mode->vdisplay =3D=3D device->mode->hdisplay))
        return MODE_OK;

If userspace commits a 300x400 mode when device->orientation is 0 or 180
(or 400x300 when orientation is 90 or 270), ssd16xx_convert_fb_to_1bpp()
packs 38-byte padded rows across 400 rows (15,200 bytes, or 37-byte rows
totaling 14,800 bytes on the DRM_FORMAT_R1 fast path), while
ssd16xx_fb_dirty() only zeroes and transmits data_size =3D 15,000 bytes to a
hardware RAM window programmed for 50-byte rows.

[ ... ]

> +static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
> +					struct drm_atomic_commit *state)
> +{

[ ... ]

> +	ret =3D drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
> +	if (ret) {
> +		drm_err(&device->drm, "plane_atomic_update: begin_cpu_access failed: %=
d\n", ret);
> +		goto out_restore;
> +	}
> +
> +	ret =3D ssd16xx_fb_dirty(fb, &rect, device, &shadow_state->data[0]);
> +	if (ret)
> +		drm_err(&device->drm, "plane_atomic_update: display update failed: %d\=
n", ret);
> +
> +	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +
> +out_restore:
> +	device->refresh_mode =3D saved_mode;
> +	device->border_waveform_update_idx =3D saved_border_waveform_idx;
> +
> +	/*
> +	 * If this was the init frame (which used border_waveform_init_idx
> +	 * inside fb_dirty), arm border_waveform_pending so the normal
> +	 * (non-init) border value is sent at the start of the next update.
> +	 */
> +	if (device->init_refresh_pending) {
> +		device->init_refresh_pending =3D false;
> +		device->border_waveform_pending =3D true;
> +	}

[Severity: Medium]
If drm_gem_fb_begin_cpu_access() or ssd16xx_fb_dirty() fails during the
initial frame, should device->init_refresh_pending remain set instead of
being cleared at out_restore?

Clearing device->init_refresh_pending on the error path causes subsequent
frames to skip the initial full refresh and perform partial refreshes
without a valid RED RAM baseline.

[ ... ]

> +static int ssd16xx_connector_get_modes(struct drm_connector *connector)
> +{
> +	struct ssd16xx_device *device =3D to_ssd16xx_device(connector->dev);
> +	bool mode_is_portrait =3D (device->mode->hdisplay < device->mode->vdisp=
lay);
> +	bool orient_is_portrait =3D (device->orientation =3D=3D 90 || device->o=
rientation =3D=3D 270);
> +
> +	drm_dbg(&device->drm,
> +		"connector_get_modes: orientation=3D%u=C2=B0 mode=3D%ux%u mode_portrai=
t=3D%d orient_portrait=3D%d\n",
> +		device->orientation, device->mode->hdisplay, device->mode->vdisplay,
> +		mode_is_portrait, orient_is_portrait);
> +
> +	/* For portrait, swap dimensions so clients see logical size. */
> +	if (mode_is_portrait !=3D orient_is_portrait) {
> +		struct drm_display_mode *mode;
> +
> +		mode =3D drm_mode_duplicate(&device->drm, device->mode);
> +		if (!mode)
> +			return 0;
> +		swap(mode->hdisplay, mode->vdisplay);
> +		swap(mode->hsync_start, mode->vsync_start);
> +		swap(mode->hsync_end, mode->vsync_end);
> +		swap(mode->htotal, mode->vtotal);
> +		swap(mode->width_mm, mode->height_mm);
> +		mode->type |=3D DRM_MODE_TYPE_PREFERRED;
> +		drm_mode_set_name(mode);
> +		drm_mode_probed_add(connector, mode);
> +		return 1;
> +	}
> +
> +	return drm_connector_helper_get_modes_fixed(connector, device->mode);
> +}

[Severity: Low]
Since ssd16xx_probe() already swaps device->mode in-place when
device->orientation is 90 or 270, is the swap check in
ssd16xx_connector_get_modes() redundant?

For natively landscape panels like GDEY042T81, device->mode->hdisplay <
device->mode->vdisplay is already true when orient_is_portrait is true, so
mode_is_portrait !=3D orient_is_portrait is never taken. Conversely, for any
natively portrait panel, mode_is_portrait !=3D orient_is_portrait would be
true in all orientations and undo the swap performed in ssd16xx_probe()
(while also skipping the connector->display_info.width_mm and height_mm
assignments done by drm_connector_helper_get_modes_fixed()).

[ ... ]

> +static int ssd16xx_probe(struct spi_device *spi)
> +{

[ ... ]

> +	mode =3D devm_kmemdup(dev, device->device_cfg->mode,
> +			    sizeof(*device->device_cfg->mode), GFP_KERNEL);
> +	if (!mode)
> +		return -ENOMEM;

[Severity: Medium]
Can allocating device->mode with devm_kmemdup() lead to a use-after-free
after the SPI device is unbound?

While struct ssd16xx_device is allocated via devm_drm_dev_alloc() and stays
alive until the last open DRM file descriptor is closed, devm_kmemdup()
ties device->mode to the SPI struct device devres list, which is freed as
soon as ssd16xx_remove() returns.

If an in-flight KMS ioctl (such as DRM_IOCTL_MODE_GETCONNECTOR or
DRM_IOCTL_MODE_SETCRTC) passes the initial unplug check in
drm_ioctl_kernel() and waits on modeset locks while ssd16xx_remove() runs,
it can subsequently invoke ssd16xx_connector_get_modes() or
ssd16xx_crtc_mode_valid() (neither of which is guarded by drm_dev_enter())
and dereference device->mode after devres_release_all() has freed it.
Would embedding struct drm_display_mode directly in struct ssd16xx_device
(or using drmm_kmemdup()) avoid this lifetime mismatch?

> +
> +	device->refresh_mode =3D device->device_cfg->default_refresh_mode;

[ ... ]

> +	/* Swap mode dimensions for portrait so clients see logical size. */
> +	if (device->orientation =3D=3D 90 || device->orientation =3D=3D 270) {
> +		swap(mode->hdisplay, mode->vdisplay);
> +		swap(mode->hsync_start, mode->vsync_start);
> +		swap(mode->hsync_end, mode->vsync_end);
> +		swap(mode->htotal, mode->vtotal);
> +		swap(mode->width_mm, mode->height_mm);
> +		drm_dbg(drm, "Mode dimensions swapped for portrait: %ux%u\n",
> +			mode->hdisplay, mode->vdisplay);
> +	} else {
> +		drm_dbg(drm, "Mode dimensions unchanged: %ux%u\n",
> +			mode->hdisplay, mode->vdisplay);
> +	}
> +	device->mode =3D mode;

[ ... ]

> +static void ssd16xx_remove(struct spi_device *spi)
> +{
> +	struct ssd16xx_device *device =3D spi_get_drvdata(spi);
> +
> +	drm_dev_unplug(&device->drm);
> +	drm_atomic_helper_shutdown(&device->drm);
> +}

[ ... ]

> +

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019213726.4145=
532-1-devarsht@ti.com?part=3D4
