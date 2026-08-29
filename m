Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5B490C61DD7
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:51:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A07C410E0AA;
	Sat, 29 Aug 2026 06:51:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="hx5t73se";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4E6E810E0AA
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 06:51:12 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 4336460055;
 Sat, 29 Aug 2026 06:51:11 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FFA01F000E9;
 Sat, 29 Aug 2026 06:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1787986270;
 bh=EmdCz56q4QYYBLo0BgJlPbAZRTrA1zY982nZkh34L7k=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=hx5t73seKu37zZmqWH5tvQuJo81hxwKAWKq7Yxlur7v73CJX9fQ6rK/sQtDGfUnL9
 RroGlGR6W00KoaM94DA+J+eqEfwZxgmL9Oi/SwfTtCniHEwW8puAAF/Idug5H8fHKL
 qGf/ZJPEvwaFs+zGHoLGIWfE1PQABlu6Ysc/e2/FEScMvaKrbLDYrxmSvecsbCVppe
 Zow6vXvpfOIPDVE52egB6LOGfTizTh8cUHAIUiFzte21+JoYkQgpQTQGZLjinFSK8c
 vhQvU9joVc9CxjJGquAq1Xn4TaaCtk2Aa4dg8Gn/Arnj7jPe6S/kae2C3A1sYA7csi
 FoFL0ptP7oZPA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 2/3] drm/ch1115: add support for Chipwealth CH1115
 OLED controller
To: =?utf-8?b?Tmljb2zDoXMgQW50aW5vcmk=?= <nico.antinori.7@gmail.com>
Cc: dri-devel@lists.freedesktop.org, robh@kernel.org,
 devicetree@vger.kernel.org, conor+dt@kernel.org
In-Reply-To: <cb767f9b1db18f981c363222f96a46061e77e4c7.1787973729.git.nico.antinori.7@gmail.com>
References: <cover.1787973729.git.nico.antinori.7@gmail.com>
 <cb767f9b1db18f981c363222f96a46061e77e4c7.1787973729.git.nico.antinori.7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 29 Aug 2026 06:51:10 +0000
Message-Id: <20260829065110.7FFA01F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:
- [High] Sleeping functions are called from DRM atomic context callbacks
- [High] Heap buffer overflow due to under-allocated unpadded shadow buffer
- [High] Heap buffer overflow in `row` and `hwbuf` due to Framebuffer vs. P=
anel coordinate mismatch
- [Medium] Display corruption due to unaligned damage rect X coordinates
- [Medium] Hardware misconfiguration due to out-of-range display offset cal=
culation
--

commit cf38fdd0d34bcb3a6b00f5ba5e5408b34feba7a9
Author: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

drm/ch1115: add support for Chipwealth CH1115 OLED controller

Chipwealth CH1115 is a controller for monochrome dot matrix OLED panels.
Add DRM support for this chip using i2c bus.

> diff --git a/drivers/gpu/drm/chipwealth/ch1115-i2c.c b/drivers/gpu/drm/ch=
ipwealth/ch1115-i2c.c
> new file mode 100644
> index 0000000000000..2ceb5e948e82f
> --- /dev/null
> +++ b/drivers/gpu/drm/chipwealth/ch1115-i2c.c
[ ... ]
> +static int ch1115_oled_init(struct ch1115_device *ch1115)
> +{
> +	u8 commands[] =3D {
> +		CH1115_CMD_OFF,
> +
> +		CH1115_CMD_CLOCK_DIVIDE_RATIO,
> +		CH1115_VAL_CLOCK_DIVIDE_RATIO(CH1115_VAL_CLOCK_OSC_FREQ,
> +					      CH1115_VAL_CLOCK_DIV_RATIO),
> +
> +		CH1115_CMD_MUX_RATIO,
> +		ch1115->height - 1,
> +
> +		CH1115_CMD_OFFSET,
> +		ch1115->flip_vertical
> +			? ch1115->y_start_offset
> +			: CH1115_MAX_HEIGHT - ch1115->y_start_offset,
                  ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: Medium]
Is this offset calculation correct when y_start_offset is 0?

In ch1115_oled_init(), CH1115_MAX_HEIGHT - ch1115->y_start_offset evaluates
to 64 when y_start_offset is 0. However, the CH1115 offset register only
accepts values up to 63 (0x3F). Could sending an out-of-bounds value of 64
cause the hardware to misbehave or ignore the command?

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
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^

[Severity: High]
Can this pointer arithmetic point out of bounds if the framebuffer viewport
is panned?

The damage iterator yields coordinates in absolute framebuffer (FB)
coordinates. If userspace configures a framebuffer larger than the panel
and pans the source viewport (e.g., src.x1 =3D 64), rect->x1 and rect->y1
will exceed the bounds of the panel-sized hwbuf. Does the driver need to
translate FB coordinates to panel-relative coordinates by subtracting
src.x1 and src.y1?

[Severity: Medium]
Could an unaligned rect->x1 cause screen corruption?

The damage rectangle Y coordinates are rounded to 8-pixel boundaries above,
but X coordinates are not. Passing an unaligned rect->x1 to
drm_fb_xrgb8888_to_mono() will shift the damaged pixels horizontally within
the target byte, clobbering adjacent unaffected pixels in the process.

> +	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^

[Severity: High]
Will this cause a heap buffer overflow for unaligned display dimensions?

The shadow framebuffer hwbuf is allocated in ch1115_probe() as exactly
(width * height) / 8 bytes. If width or height isn't a multiple of 8
(e.g., 127x64), integer division truncates the allocation size. However,
dst_pitch is padded to DIV_ROUND_UP(width, 8). Calling
drm_fb_xrgb8888_to_mono() will write full padded rows, overflowing the
unpadded heap allocation.

[Severity: High]
Is it safe to trigger a GFP_KERNEL allocation here?

This is called from ch1115_primary_plane_helper_atomic_update(). According
to DRM subsystem guidelines, plane atomic_update callbacks run in atomic
context during non-blocking commits, where sleeping is forbidden. However,
drm_fb_xrgb8888_to_mono() can trigger memory allocations with GFP_KERNEL
inside the format conversion helper.

> +}
[ ... ]
> +static int ch1115_fb_update_rect(struct drm_framebuffer *fb, struct drm_=
rect *rect)
> +{
> +	struct ch1115_device *ch1115 =3D drm_to_ch1115(fb->dev);
> +	char *row =3D ch1115->row;
> +	int ret;
> +
> +	rect->y1 =3D round_down(rect->y1, CH1115_PAGE_HEIGHT);
> +	rect->y2 =3D min_t(unsigned int, round_up(rect->y2, CH1115_PAGE_HEIGHT)=
, ch1115->height);
> +
> +	for (int y =3D rect->y1; y < rect->y2; y +=3D CH1115_PAGE_HEIGHT) {
> +		for (int x =3D rect->x1; x < rect->x2; x++)
> +			row[x] =3D ch1115_transform_xy(ch1115->hwbuf, x, y, ch1115->bytes_per=
_row);
                        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this array access write out of bounds when the CRTC is panned?

Since row is allocated to exactly ch1115->width bytes, an absolute
framebuffer coordinate like rect->x1 exceeding the panel width will cause
row[x] to corrupt kernel heap memory. Should the loop index be translated
to panel-relative coordinates?

> +
> +		ret =3D ch1115_set_position(ch1115, ch1115->x_start_offset + rect->x1,=
 y);
> +		if (ret < 0)
> +			return ret;
> +
> +		ret =3D ch1115_draw_screen(ch1115, row + rect->x1, rect->x2 - rect->x1=
);
> +		if (ret < 0)
> +			return ret;
> +	}
> +
> +	return 0;
> +}
[ ... ]
> +static void ch1115_primary_plane_helper_atomic_update(struct drm_plane *=
plane,
> +						      struct drm_atomic_commit *state)
> +{
> +	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
> +	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
> +	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(plane_state);
> +	struct drm_framebuffer *fb =3D plane_state->fb;
> +	struct drm_atomic_helper_damage_iter iter;
> +	struct drm_device *dev =3D plane->dev;
> +	struct drm_rect damage;
> +	struct ch1115_device *ch1115 =3D drm_to_ch1115(plane->dev);
> +	int idx;
> +
> +	if (!fb)
> +		return;
> +
> +	if (drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE))
> +		return;
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Does this callback sleep in atomic context?

drm_gem_fb_begin_cpu_access() can block to wait on DMA fences. Since
ch1115_primary_plane_helper_atomic_update() runs in atomic context during
non-blocking commits, this can cause might_sleep() warnings and system
deadlocks.

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
                ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Will this initiate blocking I2C transfers from atomic context?

ch1115_fb_update_rect() calls ch1115_set_position() and ch1115_draw_screen(=
),
which perform regmap writes over I2C. I2C transfers lock the bus mutex and
can sleep, which is forbidden in atomic update paths.

> +	}
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
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^

[Severity: High]
Is it safe to acquire the backlight mutex here?

ch1115_encoder_atomic_enable() runs in atomic context. Calling
backlight_enable() acquires the backlight update_lock mutex, which
will sleep and violate the atomic context constraints.

> +}
[ ... ]
> +static int ch1115_probe(struct i2c_client *client)
> +{
> +	struct ch1115_device *ch1115;
> +	struct device *dev;
> +	struct backlight_device *bl;
> +	int ret;
> +
> +	dev =3D &client->dev;
> +	ch1115 =3D devm_drm_dev_alloc(&client->dev, &ch1115_driver,
> +				    struct ch1115_device, dev);
> +	if (IS_ERR(ch1115))
> +		return PTR_ERR(ch1115);
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
        ^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^^=
^^^^

[Severity: High]
Could this allocation be undersized for unaligned display dimensions?

When width or height is not a multiple of 8, integer division truncates
the size, leaving hwbuf too small to hold the padded rows written by
ch1115_prepare_buffer().

> +	if (!ch1115->hwbuf)
> +		return -ENOMEM;
> +
> +	ch1115->row =3D devm_kzalloc(dev, ch1115->width, GFP_KERNEL);
> +	if (!ch1115->row)
> +		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1787973729.gi=
t.nico.antinori.7@gmail.com?part=3D2
