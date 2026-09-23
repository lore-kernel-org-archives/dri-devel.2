Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 25EF7C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:57:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AEFD10F231;
	Wed, 23 Sep 2026 22:57:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="EVZjkp8d";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B554710F231
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:57:07 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 1E55060008;
 Wed, 23 Sep 2026 22:57:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85F951F000FF;
 Wed, 23 Sep 2026 22:57:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1790204226;
 bh=ZQFBBP8jq8IEP5LpJ0LJAL83WTCxBJhGybFWhbO116Y=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=EVZjkp8dm4kMd+Q46ELgyqtTPUkfxjgSJfXmn9WD3VlQV+yMxUU1F8Lnsf/ifSyF1
 hTQUXlNGFBdFPnQ8uMLHZpzcgnGFk13BSwKABD2cYhzrxrK6WHDV/4OpfwQ+jucb69
 INewHCVAGVHiSM5dXytni7SVJjSwSJ7w/17NZUUC8S4Bj/3QsN9ggRAroGll1DOBNP
 7HTrL+ylclIMvM9F/z/AsM64ScqPd8lzGWwN42YIDznmNfGNgnqdNQf4baf8Cct2vN
 G1cLxw24L9Mr7TW8fnn5IryA10Ul0B1YIme6Qrg6FfHdk1GjdtOoaVKxkZ1wA6vH4n
 WU/jQgtsYh9aA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/3] drm/ch1115: add support for Chipwealth CH1115
 OLED controller
To: =?utf-8?b?Tmljb2zDoXMgQW50aW5vcmk=?= <nico.antinori.7@gmail.com>
Cc: dri-devel@lists.freedesktop.org, conor+dt@kernel.org,
 devicetree@vger.kernel.org, robh@kernel.org
In-Reply-To: <29b7f9786f08989c8f941ab85a76c62d1f5ee43b.1790200427.git.nico.antinori.7@gmail.com>
References: <cover.1790200427.git.nico.antinori.7@gmail.com>
 <29b7f9786f08989c8f941ab85a76c62d1f5ee43b.1790200427.git.nico.antinori.7@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 23 Sep 2026 22:57:06 +0000
Message-Id: <20260923225706.85F951F000FF@smtp.kernel.org>
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
- [High] core: uninitialized variable `bl` used in IS_ERR check
- [High] drm: out-of-bounds heap read in ch1115_transform_xy()
- [High] drm: sleeping in atomic context during plane and encoder callbacks
- [Medium] sysfs: unprotected state modification on registered I2C device
--

commit 63d6db1725e38b56da7d2687e33c28c0f46a0455
Author: Nicol=C3=A1s Antinori <nico.antinori.7@gmail.com>

drm/ch1115: add support for Chipwealth CH1115 OLED controller
   =20
This commit adds DRM support for the Chipwealth CH1115 monochrome dot matrix
OLED controller connected via an I2C bus.

> diff --git a/drivers/gpu/drm/tiny/ch1115-i2c.c b/drivers/gpu/drm/tiny/ch1=
115-i2c.c
> new file mode 100644
> --- /dev/null
> +++ b/drivers/gpu/drm/tiny/ch1115-i2c.c
[ ... ]
> +static inline u8 ch1115_transform_xy(const char *p, int x, int y, u8 byt=
es_per_row)
> +{
> +	int xrest =3D x % 8;
> +	u8 result =3D 0;
> +
> +	/*
> +	 * Transforms an (x, y) pixel coordinate into a vertical 8-bit
> +	 * column from the framebuffer. It calculates the corresponding byte in=
 the
> +	 * framebuffer, extracts the bit at the given x position across 8 conse=
cutive
> +	 * rows, and packs those bits into a single byte.
> +	 *
> +	 * Return an 8-bit value representing a vertical column of pixels.
> +	 */
> +
> +	x =3D x / 8;
> +	y =3D (y / 8) * 8;
> +
> +	for (int i =3D 0; i < 8; i++) {
> +		int row_idx =3D y + i;
> +		u8 byte =3D p[row_idx * bytes_per_row + x];

[Severity: High]
Can this result in an out-of-bounds memory read?

In ch1115_probe(), the hardware buffer ch1115->hwbuf is allocated with a si=
ze of
bytes_per_row * ch1115->height.=20

Here, the loop unconditionally iterates 8 times to pack 8 vertical pixels. =
If
ch1115->height is not a multiple of 8, the final loop iterations will calcu=
late
a row_idx that exceeds the allocated height, causing a heap out-of-bounds r=
ead.

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

[Severity: High]
Does this execute sleepable functions in atomic context?

Plane atomic_update callbacks run in atomic context during non-blocking com=
mits,
so sleeping is forbidden. Here, drm_gem_fb_begin_cpu_access() is called, wh=
ich
waits for fences and can sleep.

Additionally, this path calls ch1115_fb_update_rect() -> ch1115_draw_screen=
() ->
regmap_raw_write(), which executes a sleepable i2c_transfer(). This will ca=
use
kernel warnings and potential deadlocks.

> +
> +	if (!drm_dev_enter(dev, &idx))
> +		goto out_drm_gem_fb_end_cpu_access;
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
Does this callback also sleep in atomic context?

Encoder atomic_enable callbacks also execute in atomic context. Calling
backlight_enable() attempts to acquire a mutex, and ch1115_oled_init() perf=
orms
sleepable I2C transfers. These operations are unsafe here.

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
> +
> +	dev_set_name(dev, "ch1115-i2c");

[Severity: Medium]
Is it safe to alter the kobject name of an actively registered device here?

The driver modifies the kobject name of the already-registered I2C client d=
evice
(dev =3D &client->dev) without using device_rename().

Modifying the name while the device is exposed in sysfs frees the existing =
name
string, creating a race condition that can lead to sysfs corruption and
use-after-free bugs if concurrently read.

> +
> +	i2c_set_clientdata(client, ch1115);
[ ... ]
> +	ch1115->hwbuf =3D devm_kzalloc(dev,
> +				     DIV_ROUND_UP(ch1115->width, 8) * ch1115->height,
> +				     GFP_KERNEL);
> +
> +	if (!ch1115->hwbuf)
> +		return -ENOMEM;
> +
> +	ch1115->row =3D devm_kzalloc(dev, ch1115->width, GFP_KERNEL);
> +	if (!ch1115->row)
> +		return -ENOMEM;
> +
> +	// Backlight
> +	const struct backlight_properties bl_props =3D {
> +		.type =3D BACKLIGHT_RAW,
> +		.brightness =3D ch1115->contrast,
> +		.max_brightness =3D CH1115_MAX_CONTRAST,
> +	};
> +
> +	ch1115->bl_dev =3D devm_backlight_device_register(dev, dev_name(dev), d=
ev, ch1115,
> +							&ch1115_bl_ops, &bl_props);
> +	if (IS_ERR(bl))

[Severity: High]
Is the uninitialized variable bl being evaluated here instead of ch1115->bl=
_dev?

The result of devm_backlight_device_register() is stored in ch1115->bl_dev,=
 but
the error check uses the uninitialized stack variable bl. This will evaluate
stack garbage, either causing spurious probe failures by returning garbage,=
 or
bypassing the error check entirely if registration fails, guaranteeing a pa=
nic
when the ERR_PTR is dereferenced later.

> +		return dev_err_probe(dev, PTR_ERR(bl),
> +				     "Unable to register backlight device\n");
> +
> +	// DRM

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1790200427.gi=
t.nico.antinori.7@gmail.com?part=3D2
