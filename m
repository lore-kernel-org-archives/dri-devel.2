Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0850BC5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:35:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65B6D10F50A;
	Fri,  7 Aug 2026 14:35:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="CFljkIMF";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E4D7510F50A
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:35:08 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id D717D60051;
 Fri,  7 Aug 2026 14:35:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4C8031F000E9;
 Fri,  7 Aug 2026 14:35:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1786113307;
 bh=fZLBgoYoypg0qwRIagqwJ8J50ZlQ+zL/YXf7k23eHLE=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=CFljkIMFngKqfClnJyLBYQPV+JQeQ0r8RhsItUpkMsbX67WI4Lwfebnp6RdrClUv3
 znYObbottw9OKImILbLVXrlRmAEYlMZ+4xdbl4wxz+rjM0azqbghDgvOl8oh1kaKd7
 W98D3O9K2hq3EdNThPCgbhXBeXzGtrPVwQFDtYr8pHvbXxNoQr7S7Doa3uXYjo+Hp8
 wGrZLz2bREOH5t/v1n8t6mB+N/Qa4kU5l1mBfro1g8IxT0QR31A3SWVOM1760hu8zZ
 2ktruibzJYdxK8l/RNDr5dAVSt11EvZgvt+8ZN/X6/oBLLoziJzgoyT+LXAb1uILl6
 ygnyk47VlZ0Hg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/3] drm/ch1115: add support for Chipwealth CH1115 OLED
 controller
To: =?utf-8?b?Tmljb2zDoXMgQW50aW5vcmk=?= <nico.antinori.7@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org, robh@kernel.org,
 devicetree@vger.kernel.org
In-Reply-To: <1d814b35f543d5aa19ca8cfab923af3b4403fcef.1786110720.git.nico.antinori.7@gmail.com>
References: <cover.1786110720.git.nico.antinori.7@gmail.com>
 <1d814b35f543d5aa19ca8cfab923af3b4403fcef.1786110720.git.nico.antinori.7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 14:35:06 +0000
Message-Id: <20260807143507.4C8031F000E9@smtp.kernel.org>
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

Thank you for your contribution! Sashiko AI review found 9 potential issue(=
s) to consider:
- [High] Atomic display callbacks perform I2C transfers, violating atomic c=
ontext requirements.
- [High] Partial updates cause severe display corruption because damaged re=
ctangles are indexed using absolute full-screen coordinates.
- [High] Out-of-bounds kernel heap read in ch1115_clear_screen() when panel=
 width is less than 128.
- [High] Missing drm_atomic_helper_shutdown() in driver remove causes Use-A=
fter-Free and memory leaks.
- [High] Heap buffer overflow in ch1115_prepare_buffer() when width is not =
a multiple of 8.
- [High] Encoder atomic hooks lack drm_dev_enter(), allowing Use-After-Free=
 of devres-managed regmap.
- [Medium] Custom regmap_bus write callback returns a positive value on suc=
cess, violating the API.
- [Medium] drm_gem_fb_begin_cpu_access() is called in the atomic_update hoo=
k and drops the frame on failure.
- [Medium] Logic error truncates bytes_per_row, causing incorrect coordinat=
e transformation for unaligned widths.
--

--- Patch [2]: [PATCH 2/3] drm/ch1115: add support for Chipwealth CH1115 OL=
ED controller ---
commit d7850b556d1f4d53fa2e329467ad049cae1d80a9
Author: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

drm/ch1115: add support for Chipwealth CH1115 OLED controller

This commit adds DRM support for the Chipwealth CH1115 monochrome dot
matrix OLED controller. It uses the I2C bus to interface with the panel
and regmap for command writing.

> diff --git a/drivers/gpu/drm/chipwealth/ch1115.c b/drivers/gpu/drm/chipwe=
alth/ch1115.c
> new file mode 100644
> index 0000000000000..0ff5d3d9a7cdc
> --- /dev/null
> +++ b/drivers/gpu/drm/chipwealth/ch1115.c

[ ... ]

> @@ -151,19 +151,19 @@ static int ch1115_clear_screen(struct ch1115_device=
 *ch1115)
>  	int ret;
>  	int y =3D 0;
>  	char *row =3D ch1115->row;
> =20
>  	for (int i =3D ch1115->x_start_offset; i < ch1115->width; i++)
>  		row[i] =3D 0x00;
> =20
>  	do {
>  		ret =3D ch1115_set_position(ch1115, ch1115->x_start_offset, y);
>  		if (ret < 0)
>  			return ret;
> =20
>  		ret =3D ch1115_draw_screen(ch1115, row + ch1115->x_start_offset, ch111=
5->width);

[Severity: High]
Could this cause an out-of-bounds read if the panel width is less than 128?

The row buffer is allocated exactly ch1115->width bytes during probe. If the
panel width is 96, x_start_offset is 32. The code zeroes bytes 32 to 95, th=
en
calls ch1115_draw_screen() instructing I2C to read width (96) bytes starting
at row + 32.

This would read 32 bytes past the end of the allocated buffer and leak
adjacent kernel heap memory to the display.

>  		if (ret < 0)
>  			return ret;

[ ... ]

> @@ -235,13 +235,13 @@ static void ch1115_prepare_buffer(struct ch1115_dev=
ice *ch1115,
>  				  const struct iosys_map *vmap,
>  				  struct drm_framebuffer *fb,
>  				  struct drm_rect *rect,
>  				  struct drm_format_conv_state *fmtcnv_state)
>  {
>  	unsigned int dst_pitch;
>  	struct iosys_map dst;
> =20
>  	dst_pitch =3D DIV_ROUND_UP(drm_rect_width(rect), 8);
>  	iosys_map_set_vaddr(&dst, ch1115->hwbuf);
> =20
>  	drm_fb_xrgb8888_to_mono(&dst, &dst_pitch, vmap, fb, rect, fmtcnv_state);

[Severity: High]
Can this write past the end of the hwbuf allocation if the display width
is not a multiple of 8?

The hwbuf is allocated in ch1115_probe() as ch1115->pages * ch1115->width.
For a width of 125, this allocates 1000 bytes. However,
drm_fb_xrgb8888_to_mono() uses a destination pitch rounded up to the nearest
byte, which would be 16 bytes per line.

Writing 64 lines at 16 bytes per line totals 1024 bytes, resulting in a
24-byte heap buffer overflow.

>  }
> =20
>  static inline u8 ch1115_transform_xy(const char *p, int x, int y, u8 byt=
es_per_row)
>  {
>  	int xrest =3D x % 8;
>  	u8 result =3D 0;

[ ... ]

>  	x =3D x / 8;
>  	y =3D (y / 8) * 8;
> =20
>  	for (int i =3D 0; i < 8; i++) {
>  		int row_idx =3D y + i;
>  		u8 byte =3D p[row_idx * bytes_per_row + x];

[Severity: Medium]
Does the bytes_per_row calculation handle unaligned widths correctly?

In probe, bytes_per_row is calculated using integer division
(ch1115->width / 8). If the width is not a multiple of 8, this truncates
the value. Since drm_fb_xrgb8888_to_mono() writes to hwbuf using a pitch
rounded up to the next byte, using the truncated bytes_per_row here reads
from incorrect offsets and distorts the image.

[Severity: High]
Additionally, can partial updates cause display corruption and out-of-bounds
reads here?

When a partial update occurs, ch1115_prepare_buffer() copies only the
damaged rectangle into the start of hwbuf. But ch1115_transform_xy() uses
absolute screen coordinates (x and y) and the full-screen pitch to index
into the buffer.

This mismatch causes the code to read past the converted damage data into
uninitialized or stale heap memory.

>  		u8 bit =3D (byte >> xrest) & 1;
> =20
>  		result |=3D (bit << i);
>  	}

[ ... ]

> @@ -367,16 +367,16 @@ static void ch1115_primary_plane_helper_atomic_upda=
te(struct drm_plane *plane,
>  						      struct drm_atomic_commit *state)
>  {
>  	struct drm_plane_state *old_plane_state =3D drm_atomic_get_old_plane_st=
ate(state, plane);
>  	struct drm_plane_state *plane_state =3D drm_atomic_get_new_plane_state(=
state, plane);
>  	struct drm_shadow_plane_state *shadow_plane_state =3D to_drm_shadow_pla=
ne_state(plane_state);
>  	struct drm_framebuffer *fb =3D plane_state->fb;
>  	struct drm_atomic_helper_damage_iter iter;
>  	struct drm_device *dev =3D plane->dev;
>  	struct drm_rect damage;
>  	struct ch1115_device *ch1115 =3D drm_to_ch1115(plane->dev);
>  	int ret, idx;
> =20
>  	if (!fb)
>  		return;
> =20
>  	ret =3D drm_gem_fb_begin_cpu_access(fb, DMA_FROM_DEVICE);
>  	if (ret)
>  		return;

[Severity: Medium]
Is it safe to return early from this void function if CPU access fails?

If drm_gem_fb_begin_cpu_access() fails (for example, if interrupted by a
signal while waiting for fences), returning early drops the frame entirely.

Since this happens in the atomic update callback after the point of no
return, userspace is never notified of the error, breaking synchronization
between the software state and the display. Should this preparation step
be moved to the prepare_fb hook instead?

> =20
>  	if (!drm_dev_enter(dev, &idx))
>  		goto out_drm_gem_fb_end_cpu_access;
> =20
>  	drm_atomic_helper_damage_iter_init(&iter, old_plane_state, plane_state);
>  	drm_atomic_for_each_plane_damage(&iter, &damage) {
>  		ch1115_prepare_buffer(ch1115,
>  				      &shadow_plane_state->data[0],
>  				      fb, &damage,
>  				      &shadow_plane_state->fmtcnv_state);
> =20
>  		ch1115_fb_update_rect(fb, &damage);

[Severity: High]
Will this sleep in an atomic context?

The DRM subsystem requires that plane atomic update callbacks execute witho=
ut
sleeping. However, ch1115_fb_update_rect() directly calls
ch1115_set_position() and ch1115_draw_screen(), which perform I2C transfers
using regmap_bulk_write().

These I2C operations acquire mutexes and sleep, which can lead to kernel
splats or deadlocks.

>  	}

[ ... ]

> @@ -500,16 +500,16 @@ static void ch1115_encoder_atomic_enable(struct drm=
_encoder *encoder,
>  					 struct drm_atomic_commit *state)
>  {
>  	struct drm_device *drm =3D encoder->dev;
>  	struct ch1115_device *ch1115 =3D drm_to_ch1115(drm);
> =20
>  	ch1115_oled_init(ch1115);

[Severity: High]
Could this callback cause a sleep in atomic context or a use-after-free?

Like the plane update callback, the encoder atomic enable and disable hooks
must not sleep, but this function calls ch1115_oled_init() and
ch1115_send_command_list(), which perform blocking I2C transfers.

Furthermore, these encoder callbacks access the regmap without the
protection of drm_dev_enter() and drm_dev_exit(). Because drm_dev_unplug()
allows existing file descriptors to remain open, userspace might trigger a
modeset after the device is unbound and devres has freed the regmap,
leading to a use-after-free.

> =20
>  	u8 command =3D CH1115_CMD_ON;
> =20
>  	ch1115_send_command_list(ch1115, &command, 1);
>  }
> =20
>  static void ch1115_encoder_atomic_disable(struct drm_encoder *encoder,
>  					  struct drm_atomic_commit *state)
>  {
>  	struct drm_device *drm =3D encoder->dev;
>  	struct ch1115_device *ch1115 =3D drm_to_ch1115(drm);
> =20
>  	u8 command =3D CH1115_CMD_OFF;
> =20
>  	ch1115_send_command_list(ch1115, &command, 1);

[Severity: High]
Could this disable hook also cause a use-after-free?

Similarly to the enable callback, this hook accesses the devres-managed
regmap without checking drm_dev_enter().

>  }

[ ... ]

> @@ -589,17 +589,17 @@ static int ch1115_regmap_read(void *context, const =
void *reg_buf,
>  			      size_t reg_size, void *val_buf, size_t val_size)
>  {
>  	return -EOPNOTSUPP;
>  }
> =20
>  static int ch1115_regmap_write(void *context, const void *data, size_t c=
ount)
>  {
>  	struct i2c_client *client =3D context;
>  	struct ch1115_device *ch1115 =3D i2c_get_clientdata(client);
>  	int ret;
> =20
>  	struct i2c_msg msg =3D {
>  		.addr =3D ch1115->client->addr,
>  		.len =3D count,
>  		.buf =3D (u8 *)data,
>  	};
> =20
>  	ret =3D i2c_transfer(ch1115->client->adapter, &msg, 1);
> =20
>  	return ret;

[Severity: Medium]
Does this regmap bus write callback return the correct success value?

The regmap_bus API expects a return value of 0 on success. However,
i2c_transfer() returns the number of messages executed, which is 1 on
success. Returning a positive value from this callback violates the API
contract, even if the driver's own callers currently mask the issue by
only checking for negative error codes.

>  }

[ ... ]

> @@ -758,26 +758,26 @@ static int ch1115_probe(struct i2c_client *client)
>  	ret =3D drm_dev_register(&ch1115->dev, 0);
>  	if (ret)
>  		return dev_err_probe(&client->dev, ret,
>  				     "Failed to register DRM device\n");
> =20
>  	drm_client_setup(&ch1115->dev, NULL);
> =20
>  	return 0;
>  }
> =20
>  static void ch1115_remove(struct i2c_client *client)
>  {
>  	struct ch1115_device *ch1115 =3D i2c_get_clientdata(client);
>  	int ret;
> =20
>  	u8 cmd_list[] =3D {
>  		CH1115_CMD_OFF,
> =20
>  		CH1115_CMD_ALL_ON,
> =20
>  		CH1115_CMD_DC_DC,
>  		CH1115_VAL_DC_DC_OFF,
>  	};
> =20
>  	ret =3D ch1115_send_command_list(ch1115, cmd_list, ARRAY_SIZE(cmd_list)=
);
>  	if (ret < 0)
>  		dev_err(&client->dev, "There was an error executing the shutdown comma=
nds");
> =20
>  	usleep_range(10000, 15000);
> =20
>  	drm_dev_unplug(&ch1115->dev);

[Severity: High]
Should this function call drm_atomic_helper_shutdown() before unplugging?

Without shutting down the atomic helpers, CRTCs and planes remain active
and pinned framebuffers are leaked. It also leaves deferred non-blocking
atomic commits running in workqueues.

When the remove function returns, devres cleans up memory like hwbuf, row,
and regmap, which can cause a use-after-free if a background commit
continues executing.

>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1786110720.gi=
t.nico.antinori.7@gmail.com?part=3D2
