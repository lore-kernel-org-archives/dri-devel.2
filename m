Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F5D1606A32A
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 12:02:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.a=rsa-sha256 header.s=mimecast20190719 header.b=UZUB/uTa
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5FC1610E138;
	Tue, 10 Nov 2026 12:01:55 +0000 (UTC)
Received: from us-smtp-delivery-124.mimecast.com
 (us-smtp-delivery-124.mimecast.com [170.10.133.124])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3DB2310E92E
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 12:01:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
 s=mimecast20190719; t=1794312108;
 h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=uiVkPzXXhehza/0pEB5oyMtowr2B+LSOPOFND1rZ2/4=;
 b=UZUB/uTaYQ/TcDNenUgChXZv/F/rbPk2l8Mgooc19eVO3WnHT/2TMqPdJyXo5fICrJBtn8
 5hSqzI9d81zUuytSOvorMaQyL6daddEobUpsoosjk9wGCBNLaeaRVQrz9G3GeMuggOKbSm
 wTZi88Rdwhm1H0gh43Y4519NaNbg69E=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-kZkmxTtxNRKpzvvzdtlV_w-1; Tue, 10 Nov 2026 07:01:46 -0500
X-MC-Unique: kZkmxTtxNRKpzvvzdtlV_w-1
X-Mimecast-MFC-AGG-ID: kZkmxTtxNRKpzvvzdtlV_w_1794312105
Received: by mail-wm1-f70.google.com with SMTP id
 5b1f17b1804b1-4ba078f26f4so1285735e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 10 Nov 2026 04:01:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1794312105; x=1794916905;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :references:in-reply-to:subject:cc:to:from:x-gm-gg
 :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
 :content-type;
 bh=y2mCs42PJIUuMEiD6YfY8qAsrfrGeMWTNLTXg/MCmkY=;
 b=vMjcqe9ZwxO5Wxsk1ZNz8xbq8hGxrKnCPG9dipC0uNF9PXkWrgSAcC7oZ/qMJrSZir
 +6ZE7U1I5Psb+sgGxhel+ZqHAdiH1kzx4lWJeesR1U6+na6B35+DQtYYOJ7yXP17lyW8
 9/aa+9Q7jQ3eLLYA+d5KoCC2K3W9PJDpmFj8VQBG9qTxuJy7ajN14Zq8GJ2rZG8B/mNU
 V7D68aHFxbTy1Hmq/4lzGvTl4aBhw9fyrPeKYUl6RGydg1RCF6B0BoMkWhlQIRcyYbdh
 2rCGrHuQ99XSOovf0+ytgnDBZ7P5o7UJ03cfN20kiSE2YkzlhTX88Exda4Tpr/aay5IE
 BQkA==
X-Gm-Message-State: APuU4Z8eMQ3kDpEdt8AeksS0S2u5PCkDbNdClXfEOqGiVSxO9SZ9a6+W
 imebOdFbDD8dbOoS7irLzy+XkwGV73iX0giHveQAIcItEfrY6rjEkEnyKcW/RBqnO79u8rhlaOQ
 dTQE0HS2ByYjjdrmoaoWHqkN5Dh/lPOcbfHTni85dvDbWzGBRKht556Fgo0FNA/Fy3B9nVg==
X-Gm-Gg: AYBFou1E/3r6HREdAdO23IpPhL3VhsVlIpstDonaIpCIIZInxckWcfDeOBLxG1lLzd5
 LZk9l0P2K1nfHw4y4O3flCOIuRs9eqLJ5AQHsmLzwskPm5NRX5wzB1e8EiEOI3zXKv1St97JtgS
 VW31nw19M4VAVS3N27GXtkDdWwSw7pO7rAmw+DqIR4w0c9AGJLU8buHYKmWg4SKMDRL2Um3or/z
 ulMLAAOfLE32Vcwh0YKEdGijy91kYzx6oe+GzxUkaS3VnyR/BDBj6GnAiCxMDReW3ohElPLgXCh
 vglwZ1xJKqbd6mdRFr/wtY7AWrsCXDIxNxNIMizyW+iog9+JTP7WS1Ezror2hzcFSJwtTRa4NS2
 z21/1piVaIG4iubft3ZpZ9stPNVL/aJrH+NjoZACFGhFSEKtZh1XGnJel98Ak/aZ+hiVi/MXe7j
 pp0S0sBPvIdVbe1eSjSL94YA2kDIwHa12kBMEAnBQ=
X-Received: by 2002:a05:600c:8b21:b0:4a1:dfaf:f465 with SMTP id
 5b1f17b1804b1-4ba023064e9mr38263445e9.4.1794312105063; 
 Tue, 10 Nov 2026 04:01:45 -0800 (PST)
X-Received: by 2002:a05:600c:8b21:b0:4a1:dfaf:f465 with SMTP id
 5b1f17b1804b1-4ba023064e9mr38262495e9.4.1794312104242; 
 Tue, 10 Nov 2026 04:01:44 -0800 (PST)
Received: from localhost (62-151-111-63.jazzfree.ya.com. [62.151.111.63])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-4983600bc9asm4366200f8f.29.2026.11.10.04.01.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 10 Nov 2026 04:01:42 -0800 (PST)
From: Javier Martinez Canillas <javierm@redhat.com>
To: Devarsh Thakkar <devarsht@ti.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>,
 Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>, Tero
 Kristo <kristo@kernel.org>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
 devarsht@ti.com, LiangCheng Wang <zaq14760@gmail.com>
Subject: Re: [PATCH v3 04/14] drm/solomon: Add DRM driver for Solomon
 SSD16xx e-paper display controllers
In-Reply-To: <20261019213726.4145532-5-devarsht@ti.com>
References: <20261019213726.4145532-1-devarsht@ti.com>
 <20261019213726.4145532-5-devarsht@ti.com>
Date: Tue, 10 Nov 2026 13:01:41 +0100
Message-ID: <xlv1qzgsevyy.fsf@fmartine-thinkpadx1carbongen12.rmtes.csb>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-MFC-PROC-ID: azoFO-T7sE8id05_RZbZIzWFDwAg7q5H3Sf2zKBrRH0_1794312105
X-Mimecast-Originator: redhat.com
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS autolearn=ham autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1


Hello Devarsh,

Devarsh Thakkar <devarsht@ti.com> writes:

> Add a DRM driver for the Solomon Systech SSD16xx family of e-paper displa=
y
> controllers (SSD1680 [4], SSD1673 [3], SSD1681 [5], SSD1683 [1]) based
> e-paper display panels, starting with support for the Gooddisplay
> GDEY042T81 which is 4.2", 400x300 resolution black/white e-paper display
> using SSD1683 controller.
>

[...]

> new file mode 100644
> index 000000000000..ca6550b5dd5b
> --- /dev/null
> +++ b/drivers/gpu/drm/solomon/ssd16xx.c
> @@ -0,0 +1,1801 @@
> +// SPDX-License-Identifier: GPL-2.0-only
> +/*
> + * DRM driver for e-paper display panels using Solomon SSD16xx family co=
ntrollers
> + *
> + * Copyright (C) 2026 Texas Instruments Incorporated - https://www.ti.co=
m/
> + *
> + * Author: Devarsh Thakkar <devarsht@ti.com>
> + *
> + * References: https://github.com/Lesords/epaper
> + */

What is this reference about? I would just remove it.

[...]

> +#include <drm/drm_fb_helper.h>

This header does not exist anymore, check commit 6ccc5b5fc1d3 ("drm/fbdev:
Move fbdev helpers into client library"). But I think you can just drop it
no symbols from clients/drm_fbdev_helper.h are used as far as I can tell.

Also, please make sure to use the drm-misc/drm-misc-next branch as a base.

[...]

> +struct ssd16xx_device {
> +=09struct drm_device drm;
> +
> +=09struct drm_plane primary_plane;
> +=09struct drm_crtc crtc;
> +=09struct drm_encoder encoder;
> +=09struct drm_connector connector;
> +
> +=09struct spi_device *spi;
> +=09struct gpio_desc *reset;
> +=09struct gpio_desc *busy;
> +=09struct gpio_desc *dc;
> +
> +=09enum ssd16xx_model model;
> +=09enum ssd16xx_controller controller;
> +=09const struct ssd16xx_controller_config *controller_cfg;
> +=09const struct ssd16xx_device_config *device_cfg;
> +=09struct drm_display_mode *mode;
> +=09u32 width;
> +=09u32 height;
> +
> +=09bool initialized;
> +=09bool init_refresh_pending; /* First frame after refresh_mode_init ena=
ble */
> +
> +=09int orientation; /* Display orientation in degrees: 0/90/180/270 */
> +=09enum ssd16xx_refresh_mode refresh_mode; /* Active refresh mode */
> +=09enum ssd16xx_color_mode color_mode;     /* Active color mode (BW or 3=
-color) */
> +=09bool fast_lut_pending; /* LUT pre-load needed before next fast refres=
h */
> +
> +=09/* Border waveform (as enum indices) */
> +=09int border_waveform_init_idx;   /* Border waveform during clear/init =
*/
> +=09int border_waveform_update_idx; /* Border waveform during display upd=
ates */
> +=09bool border_refresh_on_every_update; /* Re-send border cmd each displ=
ay update */
> +=09bool border_waveform_pending;   /* One-shot: send border cmd on next =
update */
> +
> +=09/* Display control */
> +=09int refresh_mode_init; /* -1=3Ddisabled, else use this mode for the f=
irst frame */
> +
> +=09u8  *tx_buf;     /* 1bpp frame buffer (mono + white) */
> +=09u8  *tx_red_buf; /* 1bpp red-channel buffer (3-color panels only) */
> +=09u16 *tx_buf9;    /* 9-bit SPI expansion buffer (3-wire mode only) */
> +=09u8  spi_buf[64] ____cacheline_aligned; /* DMA-safe buffer for SPI tra=
nsfers */

Another option would be to dynamically allocate them using kzalloc(),
which already provides naturally cache-line-aligned buffers.

[...]

> +static void ssd16xx_send_cmd(struct ssd16xx_device *device, u8 cmd,
> +=09=09=09     int *err)
> +{
> +=09struct spi_transfer xfer =3D {};
> +=09struct spi_message msg;
> +
> +=09if (*err)
> +=09=09return;
> +
> +=09spi_message_init(&msg);
> +=09spi_message_add_tail(&xfer, &msg);
> +
> +=09if (device->dc) {
> +=09=09/* 4-wire SPI: D/C# GPIO low selects command mode */
> +=09=09device->spi_buf[0] =3D cmd;
> +=09=09xfer.tx_buf =3D device->spi_buf;
> +=09=09xfer.len =3D 1;
> +=09=09gpiod_set_value_cansleep(device->dc, 0);
> +=09} else {
> +=09=09/*
> +=09=09 * 3-wire SPI (9-bit): bit 8 is the D/C# bit.
> +=09=09 * D/C# =3D 0 means the following 8 bits are a command.
> +=09=09 */
> +=09=09u16 *word =3D (u16 *)device->spi_buf;
> +
> +=09=09*word =3D cmd; /* bit 8 =3D 0 for command */
> +=09=09xfer.tx_buf =3D device->spi_buf;
> +=09=09xfer.len =3D sizeof(u16);
> +=09=09xfer.bits_per_word =3D 9;
> +=09}
> +
> +=09ssd16xx_spi_sync(device->spi, &msg, err);
> +}
> +
> +static void ssd16xx_send_data(struct ssd16xx_device *device, u8 data,
> +=09=09=09      int *err)
> +{
> +=09struct spi_transfer xfer =3D {};
> +=09struct spi_message msg;
> +
> +=09if (*err)
> +=09=09return;
> +
> +=09spi_message_init(&msg);
> +=09spi_message_add_tail(&xfer, &msg);
> +
> +=09if (device->dc) {
> +=09=09/* 4-wire SPI: D/C# GPIO high selects data mode */
> +=09=09device->spi_buf[0] =3D data;
> +=09=09xfer.tx_buf =3D device->spi_buf;
> +=09=09xfer.len =3D 1;
> +=09=09gpiod_set_value_cansleep(device->dc, 1);
> +=09} else {
> +=09=09/*
> +=09=09 * 3-wire SPI (9-bit): bit 8 is the D/C# bit.
> +=09=09 * D/C# =3D 1 means the following 8 bits are data.
> +=09=09 */
> +=09=09u16 *word =3D (u16 *)device->spi_buf;
> +
> +=09=09*word =3D 0x100 | data;
> +=09=09xfer.tx_buf =3D device->spi_buf;
> +=09=09xfer.len =3D sizeof(u16);
> +=09=09xfer.bits_per_word =3D 9;
> +=09}
> +
> +=09ssd16xx_spi_sync(device->spi, &msg, err);
> +}
> +

As mentioned in a previous version, this logic is already partially
covered by the ssd130x_spi_write() function (for 4-wire SPI mode),
but that helper lacks the 3-wire SPI mode.

Once your driver lands, it would be great to have a single transfer
helper that could be shared by both drivers. And maybe even other
KMS drivers could benefit from it.

> +static void ssd16xx_send_x_param(struct ssd16xx_device *device, u16 x,
> +=09=09=09=09 int *err)
> +{
> +=09if (*err)
> +=09=09return;
> +
> +=09if (device->controller_cfg->ram_x_address_bits =3D=3D 8) {
> +=09=09ssd16xx_send_data(device, (u8)x, err);
> +=09} else {
> +=09=09ssd16xx_send_data(device, x & 0xFF, err);
> +=09=09ssd16xx_send_data(device, (x >> 8) & 0xFF, err);
> +=09}
> +}
> +
> +static void ssd16xx_send_y_param(struct ssd16xx_device *device, u16 y,
> +=09=09=09=09 int *err)
> +{
> +=09if (*err)
> +=09=09return;
> +
> +=09if (device->controller_cfg->ram_y_address_bits =3D=3D 8) {
> +=09=09ssd16xx_send_data(device, (u8)y, err);
> +=09} else {
> +=09=09ssd16xx_send_data(device, y & 0xFF, err);
> +=09=09ssd16xx_send_data(device, (y >> 8) & 0xFF, err);
> +=09}
> +}
> +

Maybe these two helpers can be consolidated in one? Callers can just
pass the ram_{x,y}_address_bits as another parameter.

> +static void ssd16xx_send_data_bulk(struct ssd16xx_device *device,
> +=09=09=09=09   const u8 *data, size_t len,
> +=09=09=09=09   int *err)
> +{
> +=09struct spi_transfer xfer =3D {};
> +=09struct spi_message msg;
> +
> +=09if (*err)
> +=09=09return;
> +
> +=09if (!data || !len)
> +=09=09return;
> +
> +=09spi_message_init(&msg);
> +=09spi_message_add_tail(&xfer, &msg);
> +
> +=09if (device->dc) {
> +=09=09/* 4-wire SPI: D/C# GPIO high selects data mode */
> +=09=09if (len <=3D sizeof(device->spi_buf)) {
> +=09=09=09memcpy(device->spi_buf, data, len);
> +=09=09=09xfer.tx_buf =3D device->spi_buf;
> +=09=09} else {
> +=09=09=09xfer.tx_buf =3D data;
> +=09=09}
> +=09=09xfer.len =3D len;
> +=09=09gpiod_set_value_cansleep(device->dc, 1);
> +=09=09ssd16xx_spi_sync(device->spi, &msg, err);
> +=09} else {
> +=09=09/* 3-wire (9-bit): expand u8 =E2=86=92 u16 with D/C#=3D1 in bit 8.=
 */
> +=09=09size_t i;
> +=09=09u16 *buf =3D device->tx_buf9;
> +
> +=09=09for (i =3D 0; i < len; i++)
> +=09=09=09buf[i] =3D 0x100 | data[i];
> +
> +=09=09xfer.tx_buf =3D buf;
> +=09=09xfer.len =3D len * sizeof(u16);
> +=09=09xfer.bits_per_word =3D 9;
> +=09=09ssd16xx_spi_sync(device->spi, &msg, err);
> +=09}
> +}
> +

Is the ssd16xx_send_data() helper needed or could just this be used with
len =3D=3D 1 ? In general I feel there is a lot of code duplication on thes=
e
transfer helpers, and maybe you could simplify it a little bit.


> +static void ssd16xx_hw_reset(struct ssd16xx_device *device)
> +{
> +=09gpiod_set_value_cansleep(device->reset, 1);
> +=09usleep_range(10000, 11000);
> +=09gpiod_set_value_cansleep(device->reset, 0);
> +=09usleep_range(10000, 11000);
> +}
> +

This again is quite similar to ssd130x_reset(), not for now but these are
the kind of things that I wonder if could be moved to a solomon-common.c
library or something like that.

[...]

> +/*
> + * Convert framebuffer to 1-bit monochrome for e-paper display.
> + *
> + * Supports XRGB8888 (thresholded via ITU-R BT.601 luma at 127) and R1
> + * (native 1bpp, zero-copy fast path for aligned landscape frames).
> + *
> + * Output layout:
> + *   0=C2=B0/180=C2=B0  landscape: row-major, left-to-right, top-to-bott=
om
> + *   90=C2=B0/270=C2=B0 CW portrait: column-major, rightmost column firs=
t
> + */
> +static void ssd16xx_convert_fb_to_1bpp(u8 *dst, struct iosys_map *src,
> +=09=09=09=09       struct drm_framebuffer *fb,
> +=09=09=09=09       struct drm_rect *rect,
> +=09=09=09=09       unsigned int orientation)
> +{

Maybe you can split this function in two, one that does the XRGB8888 -> R1
and another one that does the transposition. There is already a helper to
do drm_fb_xrgb8888_to_mono(), but that assumes LSB while you want MSB. So
an option is to add a bit-order parameter to that helper.

[...]

> +/* ---------------------------------------------------------------------=
--------
> + * Plane Functions
> + */
> +
> +static void ssd16xx_plane_destroy(struct drm_plane *plane)
> +{
> +=09drm_plane_cleanup(plane);
> +}
> +
> +static const struct drm_plane_funcs ssd16xx_plane_funcs =3D {
> +=09.update_plane =3D drm_atomic_helper_update_plane,
> +=09.disable_plane =3D drm_atomic_helper_disable_plane,
> +=09.destroy =3D ssd16xx_plane_destroy,

why the level of indirection? You can just set to drm_plane_cleanup()
and delete ssd16xx_plane_destroy().

> +static void ssd16xx_plane_atomic_update(struct drm_plane *plane,
> +=09=09=09=09=09struct drm_atomic_commit *state)
> +{
> +=09struct drm_plane_state *old_state =3D drm_atomic_get_old_plane_state(=
state, plane);
> +=09struct drm_plane_state *new_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +=09struct drm_shadow_plane_state *shadow_state =3D to_drm_shadow_plane_s=
tate(new_state);
> +=09struct ssd16xx_device *device =3D plane_to_ssd16xx_device(plane);
> +=09enum ssd16xx_refresh_mode saved_mode;
> +=09u8 saved_border_waveform_idx;
> +=09struct drm_framebuffer *fb =3D new_state->fb;
> +=09struct drm_rect rect;
> +=09int ret, idx;
> +
> +=09if (!drm_dev_enter(&device->drm, &idx))
> +=09=09return;
> +
> +=09drm_dbg(&device->drm, "plane_atomic_update: fb=3D%p\n", fb);
> +
> +=09if (!fb || !device->initialized)
> +=09=09goto out_exit;
> +
> +=09if (!drm_atomic_helper_damage_merged(old_state, new_state, &rect))
> +=09=09goto out_exit;
> +

Do you think that creating a big merged damage rectangle is better than
iterating over the damaged areas and calling drm_rect_intersect() for each?

The optimal approach varies per device and maybe merging a big rectangle is
the correct thing to do for e-paper displays, but I thought that was worth
to mention that other drivers do it differently.

> +=09drm_dbg(&device->drm, "plane_atomic_update: calling fb_dirty rect=3D(=
%d,%d)-(%d,%d)\n",
> +=09=09rect.x1, rect.y1, rect.x2, rect.y2);
> +=09/*
> +=09 * When refresh_mode_init was set, use the specified mode for this fi=
rst
> +=09 * frame only, then restore the user-configured refresh_mode so
> +=09 * subsequent updates continue with the configured mode.
> +=09 */
> +=09saved_mode =3D device->refresh_mode;
> +=09saved_border_waveform_idx =3D device->border_waveform_update_idx;
> +=09if (device->init_refresh_pending) {
> +=09=09device->refresh_mode =3D device->refresh_mode_init;
> +=09=09device->border_waveform_update_idx =3D device->border_waveform_ini=
t_idx;
> +=09}
> +
> +=09/*
> +=09 * Fast refresh (0xC7) omits LOAD_LUT on every update cycle and relie=
s
> +=09 * on the LUT being pre-loaded upfront.  The property setter arms
> +=09 * fast_lut_pending whenever the user switches into fast mode.  Consu=
me
> +=09 * the flag here (once) before the first fast-refresh frame so the
> +=09 * controller's LUT is in the correct state.
> +=09 */
> +=09if (device->fast_lut_pending) {
> +=09=09ret =3D ssd16xx_preload_fast_lut(device);
> +=09=09if (ret) {
> +=09=09=09drm_err(&device->drm,
> +=09=09=09=09"plane_atomic_update: fast LUT preload failed: %d\n", ret);
> +=09=09}
> +
> +=09=09device->fast_lut_pending =3D false;
> +=09}
> +
> +=09ret =3D drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);

I *think* that you need to do this earlier, before the damage checks.

[...]

> +static const struct drm_connector_funcs ssd16xx_connector_funcs =3D {
> +=09.reset =3D drm_atomic_helper_connector_reset,

This hook has been removed since commit ("27cae3ef0574 drm/connector:
Remove reset"), instead you need to do the following:

        .atomic_create_state =3D drm_atomic_helper_connector_create_state,

--=20
Best regards,

Javier Martinez Canillas
Core Platforms
Red Hat

