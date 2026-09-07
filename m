Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 48C31C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 12:43:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B2CFE10E7D7;
	Mon,  7 Sep 2026 12:43:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="JmUXVk+q";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EAA4A10E7D7
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 12:43:31 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 3F6AB60AB5;
 Mon,  7 Sep 2026 12:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A41761F00A3A;
 Mon,  7 Sep 2026 12:43:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1788785011;
 bh=etltHfQIJA+0ZlHjdyymnnLbE3eFKZY4PCZG3K+3MzY=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=JmUXVk+q9sVZVB6yDB9HMUWYJsoraj678cU7tABwDqVoX/HiWMk1iUOV8bEDFsZUA
 giXUB4VJKX/Gs/xQwnB/+X5ZD5kuwt/qRUpPPVvFfZevjDpEGdUxyRLrNnF48Fj3eY
 1h8Dtm5hpuhgFJFl+ge0SG495dfJBt2iEcySfv1DPYQcypnDcKXffJ7uwjgYl2FSEQ
 5Kig3+PMWU1D7fXY0K0MyRTN9KPPseKjoGeBkbIf7gR2hgjgU20ChMK/WPwZnOL82r
 11kyROJKjoV2l6QN5ZFh2xasktmBW8Hidk0G8GsNIGCN1G3xkSmQwPIKJ+LJL4g80f
 v3GqyrVBx+tag==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 2/3] drm/ch1115: add support for Chipwealth CH1115
 OLED controller
To: =?utf-8?b?Tmljb2zDoXMgQW50aW5vcmk=?= <nico.antinori.7@gmail.com>
Cc: robh@kernel.org, dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <98e626a67deffe6573297308d5e7ef9170f7fe41.1788711082.git.nico.antinori.7@gmail.com>
References: <cover.1788711082.git.nico.antinori.7@gmail.com>
 <98e626a67deffe6573297308d5e7ef9170f7fe41.1788711082.git.nico.antinori.7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 12:43:30 +0000
Message-Id: <20260907124330.A41761F00A3A@smtp.kernel.org>
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
- [High] Heap buffer overflow due to undersized `hwbuf` allocation.
- [High] Calling sleeping functions in atomic context.
- [High] Missing required Kconfig dependencies leading to build failures or=
 NULL pointer dereferences.
- [High] Visual corruption due to horizontally unaligned damage rectangles.
--

commit fe052a7a7d4de23b8d160888c9f118bbd31d156e
Author: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

    drm/ch1115: add support for Chipwealth CH1115 OLED controller
   =20
    Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.
   =20
    Add DRM support for this chip using i2c bus.

> diff --git a/drivers/gpu/drm/chipwealth/Kconfig b/drivers/gpu/drm/chipwea=
lth/Kconfig
> new file mode 100644
> index 0000000000000..1cc5adc1e28e0
> --- /dev/null
> +++ b/drivers/gpu/drm/chipwealth/Kconfig
> @@ -0,0 +1,16 @@
> +# SPDX-License-Identifier: GPL-2.0-only
> +config DRM_CH1115_I2C
> +	tristate "DRM support for Ch1115 OLED panels (I2C BUS)"
> +	depends on DRM && I2C

[Severity: High]
Is there a regression here due to missing Kconfig dependencies?

The driver code calls of_get_display_timing(), which requires
CONFIG_OF_VIDEOMODE. If not enabled, it returns -ENOSYS and probe fails
unconditionally.

Additionally, if CONFIG_BACKLIGHT_CLASS_DEVICE is compiled as a module (=3D=
m)
and this driver is built-in (=3Dy), linking will fail due to unresolved sym=
bols.

Should this include "depends on OF" (or OF_VIDEOMODE) and
"select BACKLIGHT_CLASS_DEVICE"?

> +	select DRM_CLIENT_SELECTION
> +	select DRM_GEM_SHMEM_HELPER
> +	select DRM_KMS_HELPER
> +	select REGMAP_I2C
> +	select VIDEOMODE_HELPERS

[ ... ]

> diff --git a/drivers/gpu/drm/chipwealth/ch1115-i2c.c b/drivers/gpu/drm/ch=
ipwealth/ch1115-i2c.c
> new file mode 100644
> index 0000000000000..ddcf25d19b5e0
> --- /dev/null
> +++ b/drivers/gpu/drm/chipwealth/ch1115-i2c.c
[ ... ]
> +static void ch1115_prepare_buffer(struct ch1115_device *ch1115,
> +				  const struct iosys_map *vmap,
> +				  struct drm_framebuffer *fb,
> +				  struct drm_rect *rect,
> +				  struct drm_format_conv_state *fmtcnv_state)
> +{
> +	unsigned int dst_pitch;
> +	struct iosys_map dst;
> +
> +	dst_pitch =3D DIV_ROUND_UP(ch1115->width, 8);
> +	rect->y1 =3D round_down(rect->y1, CH1115_PAGE_HEIGHT);
> +	rect->y2 =3D min_t(unsigned int, round_up(rect->y2, CH1115_PAGE_HEIGHT)=
, ch1115->height);
> +
> +	iosys_map_set_vaddr(&dst, ch1115->hwbuf + rect->y1 * dst_pitch + rect->=
x1 / 8);
> +	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);

[Severity: High]
Does this code introduce a regression causing visual corruption by passing
horizontally unaligned rectangles to the conversion helper?

This rounds the damage rectangle vertically, but neglects to round it
horizontally (rect->x1, rect->x2). If rect->x1 is not a multiple of 8,
drm_fb_xrgb8888_to_mono() starts reading from the unaligned rect->x1 and
packs those pixels starting at the 0th bit of the given destination address.

This will overwrite unrelated pixels and scramble the image in that byte.
When ch1115_transform_xy() later reads these bytes assuming correct alignme=
nt,
the display will output corrupted artifacts. Should rect->x1 and rect->x2 be
rounded to multiples of 8?

Additionally, drm_fb_xrgb8888_to_mono() writes full rows based on the round=
ed
up pitch, which can lead to an out-of-bounds write if the buffer is undersi=
zed.

> +}
> +
> +static inline u8 ch1115_transform_xy(const char *p, int x, int y, u8 byt=
es_per_row)
> +{
> +	int xrest =3D x % 8;
> +	u8 result =3D 0;
[ ... ]
> +	x =3D x / 8;
> +	y =3D (y / 8) * 8;
> +
> +	for (int i =3D 0; i < 8; i++) {
> +		int row_idx =3D y + i;
> +		u8 byte =3D p[row_idx * bytes_per_row + x];

[Severity: High]
Can this loop introduce a regression by performing out-of-bounds reads when
iterating through the vertical page blocks?

If width or height are not multiples of 8, the allocated hwbuf size may be
too small because it stores data with a pitch of DIV_ROUND_UP(width, 8) and
up to round_up(height, 8) rows. This could cause this loop to read past the
end of the buffer.

> +		u8 bit =3D (byte >> xrest) & 1;
> +
> +		result |=3D (bit << i);
> +	}
> +
> +	return result;
> +}
[ ... ]
> +static void ch1115_primary_plane_helper_atomic_update(struct drm_plane *=
plane,
> +						      struct drm_atomic_commit *state)
> +{
[ ... ]
> +	if (!fb)
> +		return;
> +
> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
> +		return;
> +
> +	if (!drm_dev_enter(dev, &idx))
> +		goto out_drm_gem_fb_end_cpu_access;
> +
> +	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
> +	drm_atomic_for_each_plane_damage(&iter, &damage) {
> +		ch1115_prepare_buffer(ch1115,
> +				      &shadow_plane_state->data[0],
> +				      fb, &damage,
> +				      &shadow_plane_state->fmtcnv_state);
> +
> +		ch1115_fb_update_rect(fb, &damage);

[Severity: High]
Does this code introduce a regression by calling sleeping functions in an
atomic context?

Plane atomic update callbacks execute in atomic context during non-blocking
commits and must not sleep.

Here, drm_gem_fb_begin_cpu_access() is called, which can sleep. Additionall=
y,
ch1115_fb_update_rect() triggers I2C transfers via regmap, which is also a
sleeping function.

Executing I2C transfers, mutex locks, and CPU syncs in atomic context can
cause scheduling while atomic panics and potential deadlocks.

> +	}
> +
> +	drm_dev_exit(idx);
> +
> +out_drm_gem_fb_end_cpu_access:
> +	drm_gem_fb_end_cpu_access(fb, DMA_FROM_DEVICE);
> +}
[ ... ]
> +static void ch1115_encoder_atomic_enable(struct drm_encoder *encoder,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct drm_device *drm =3D encoder->dev;
> +	struct ch1115_device *ch1115 =3D drm_to_ch1115(drm);
> +
> +	ch1115_oled_init(ch1115);
> +
> +	u8 command =3D CH1115_CMD_ON;
> +
> +	ch1115_send_command_list(ch1115, &command, 1);
> +
> +	backlight_enable(ch1115->bl_dev);

[Severity: High]
Does this cause a regression by calling a sleeping backlight API inside an
atomic encoder callback?

Encoder atomic enable and disable callbacks run in atomic context during
non-blocking commits.=20

backlight_enable() acquires a mutex internally, and both this and the I2C
transfers above will sleep, which violates the atomic context requirements.

> +}
[ ... ]
> +static int ch1115_probe(struct i2c_client *client)
> +{
[ ... ]
> +	ch1115->pages =3D DIV_ROUND_UP(ch1115->height, CH1115_PAGE_HEIGHT);
> +	ch1115->bytes_per_row =3D DIV_ROUND_UP(ch1115->width, 8);
> +	ch1115->x_start_offset =3D ch1115->flip_horizontal
> +		? CH1115_MAX_WIDTH - ch1115->width
> +		: 0;
> +	ch1115->mode =3D ch1115_mode(ch1115);
> +
> +	ch1115->hwbuf =3D devm_kzalloc(dev, (ch1115->width * ch1115->height) / =
8,
> +				     GFP_KERNEL);

[Severity: High]
Does this buffer allocation introduce a regression by failing to account for
row pitch padding and page alignment?

The hwbuf is allocated as (width * height) / 8 bytes. If width or height
are not multiples of 8, this size is too small.=20

The buffer stores data with a pitch of DIV_ROUND_UP(width, 8) and up to
round_up(height, 8) rows. For example, if width=3D12 and height=3D12, the
allocated size is 18 bytes.=20

Later, drm_fb_xrgb8888_to_mono() writes 12 rows with a pitch of 2
(24 bytes), causing an out-of-bounds write of 6 bytes. This memory
corruption can lead to system instability.

> +	if (!ch1115->hwbuf)
> +		return -ENOMEM;
> +
> +	ch1115->row =3D devm_kzalloc(dev, ch1115->width, GFP_KERNEL);
> +	if (!ch1115->row)
> +		return -ENOMEM;
> +
> +	// Backlight
> +	bl =3D devm_backlight_device_register(dev, dev_name(dev), dev, ch1115,
> +					    &ch1115_bl_ops, NULL);
> +	if (IS_ERR(bl))
> +		return dev_err_probe(dev, PTR_ERR(bl),
> +				     "Unable to register backlight device\n");
> +
> +	bl->props.brightness =3D ch1115->contrast;

[Severity: High]
Can this introduce a regression where bl is NULL, causing a NULL pointer
dereference?

If CONFIG_BACKLIGHT_CLASS_DEVICE is disabled, the fallback stub for
devm_backlight_device_register() returns NULL.=20

Since IS_ERR(bl) does not check for NULL, the next line will dereference
a NULL pointer.

> +	bl->props.max_brightness =3D CH1115_MAX_CONTRAST;
> +	ch1115->bl_dev =3D bl;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1788711082.gi=
t.nico.antinori.7@gmail.com?part=3D2
