Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E15E606A31D
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:48:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UNtKhtWC
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F23E5112763;
	Thu, 22 Oct 2026 15:48:09 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F8B611277E
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:48:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 12C5240BF6;
 Thu, 22 Oct 2026 15:48:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC3C61F01825;
 Thu, 22 Oct 2026 15:48:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792684084;
 bh=kAlMXW/iDu0WcnR6MO51sVVJWdRsAdHL92bT/kLuTEg=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=UNtKhtWCTF/k23Ob28HruvH/BkJHTrU+bKz4hRPymiETYOuZPo69yp7pohDkizww5
 ICOZTDOvpCi93s4NFyjd01M1vj4JGJIRfGC5Z/cOOxeOAXywvkmdbNQdlCJx7i7Ua1
 lZaRFznuzCnUBvjgJOhCEMCGTvfZs51eGWsGkB4o2F5g2NOT28WuwnmLQjvFbYQ2bA
 sG42gmdlXVXNHNDFoNS/v7eyt3liVAu8qPpeAgzLBPgPesqckbjYjlTfD2EwxjPkxO
 SFYRUMDaEymyVqBFTkPSzkaHq85hUkrHCttT5qJNTmOH5/6bOs/Hc9ur9MKw++rLwA
 EkCiODi9I42OA==
Message-ID: <sashiko-outbox-181725@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/2] drm/sitronix/st7571-spi: Add support for ST75156
 controller
To: "Lars Rask" <lars.rask@axis.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261022-add_st75156_support-v1-1-582525a39a39@axis.com>
References: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
 <20261022-add_st75156_support-v1-1-582525a39a39@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:48:03 +0000
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

Thank you for your contribution! Sashiko AI review found 8 potential issue(=
s) to consider:
- [Critical] drm/sitronix: hwbuf OOB read and broken damage in st75156_tran=
sform_xy()
- [High] drm/sitronix: NULL deref and uninit regmap in st7571_spi_probe()
- [High] drm/sitronix: unchecked kmemdup() for databuf in regmap_spi_write()
- [High] drm/sitronix: devm_gpiod_get() swallows errors in st7571_spi_probe=
()
- [High] drm/sitronix: inverted reset GPIO polarity in st75156_reset()
- [Medium] drm/sitronix: missing BACKLIGHT_CLASS_DEVICE dependency for st75=
71
- [Medium] drm/sitronix: broken display and backlight PM for ST75156
- [Medium] drm/sitronix: st75156 ignores parsed DT settings and skips start=
col check
--

commit c09138c5fe8d0e3240997fcbdd65bfabecbad95f
Author: Lars Rask <lars.rask@axis.com>

drm/sitronix/st7571-spi: Add support for ST75156 controller

This commit adds support for the Sitronix ST75156 monochrome display
controller to the st7571 DRM driver, including 4-line SPI D/C GPIO handling=
 in
st7571-spi.c and ST75156 initialization and framebuffer update routines in
st7571.c.

> diff --git a/drivers/gpu/drm/sitronix/st7571-spi.c b/drivers/gpu/drm/sitr=
onix/st7571-spi.c
> index 0206e9162f1cd..724c0eb5e7dab 100644
> --- a/drivers/gpu/drm/sitronix/st7571-spi.c
> +++ b/drivers/gpu/drm/sitronix/st7571-spi.c
> @@ -17,23 +17,133 @@ static const struct regmap_config st7571_spi_regmap_=
config =3D {

[ ... ]

> +static int regmap_spi_write(void *context, const void *data, size_t coun=
t)
> +{
> +	struct spi_device_data *spi_data =3D context;
> +	const u8 *buf =3D data;
> +	u8 mode;
> +	size_t num_data_bytes;
> +	const u8 *data_bytes;
> +	int write_result;
> +	const u8 *cmdbuf;
> +	const u8 *databuf;

[ ... ]

> +	if (mode =3D=3D ST7571_COMMAND_MODE) {
> +		gpiod_set_value_cansleep(spi_data->dc_gpio, 0);
> +
> +		cmdbuf =3D kmemdup(&buf[1], 1, GFP_KERNEL);
> +		if (!cmdbuf)
> +			return -ENOMEM;
> +
> +		write_result =3D spi_write(spi_data->spi, cmdbuf, 1);
> +		kfree(cmdbuf);
> +
> +		if (write_result !=3D 0)
> +			return write_result;
> +
> +		num_data_bytes =3D count - 2;
> +
> +		if (num_data_bytes > 0) {
> +			gpiod_set_value_cansleep(spi_data->dc_gpio, 1);
> +			data_bytes =3D &buf[2];
> +			databuf =3D kmemdup(data_bytes, num_data_bytes, GFP_KERNEL);
> +
> +			write_result =3D spi_write(spi_data->spi, databuf, num_data_bytes);
> +			kfree(databuf);
> +
> +			if (write_result !=3D 0)
> +				return write_result;
> +		}
> +	} else if (mode =3D=3D ST7571_DATA_MODE) {
> +		num_data_bytes =3D count - 1;
> +
> +		if (num_data_bytes > 0) {
> +			gpiod_set_value_cansleep(spi_data->dc_gpio, 1);
> +			data_bytes =3D &buf[1];
> +			databuf =3D kmemdup(data_bytes, num_data_bytes, GFP_KERNEL);
> +			write_result =3D spi_write(spi_data->spi, databuf, num_data_bytes);
> +			kfree(databuf);
> +
> +			if (write_result !=3D 0)
> +				return write_result;
> +		}

[Severity: High]
What happens in regmap_spi_write() in drivers/gpu/drm/sitronix/st7571-spi.c=
 if
kmemdup() returns NULL when allocating databuf?

In both the ST7571_COMMAND_MODE branch (when num_data_bytes > 0) and the
ST7571_DATA_MODE branch (when num_data_bytes > 0), databuf is passed direct=
ly
to spi_write(spi_data->spi, databuf, num_data_bytes) without a NULL check,
unlike cmdbuf above. If kmemdup() fails under memory pressure during a
multi-byte command write or framebuffer update over 4-line SPI, spi_write()
receives a NULL tx_buf with a non-zero length, which can cause a NULL point=
er
dereference in the SPI controller driver or transmit dummy bytes instead of
returning -ENOMEM.

Should both databuf allocations check for !databuf and return -ENOMEM before
calling spi_write()?

> +
> +	} else {
> +		/* Unsupported mode */
> +		return -EINVAL;
> +	}
> +
> +	return 0;
> +}

[ ... ]

>  static int st7571_spi_probe(struct spi_device *spi)
>  {
>  	struct st7571_device *st7571;
>  	struct regmap *regmap;
> +	struct spi_device_data *spi_data;
> +
> +	spi_data =3D devm_kzalloc(&spi->dev, sizeof(*spi_data), GFP_KERNEL);
> +	if (IS_ERR(spi_data))
> +		return dev_err_probe(&spi->dev, PTR_ERR(regmap),
> +				     "Failed to initialize spi data\n");
> =20
> -	regmap =3D devm_regmap_init_spi(spi, &st7571_spi_regmap_config);
> -	if (IS_ERR(regmap)) {
> +	spi_data->spi =3D spi;

[Severity: High]
In st7571_spi_probe() in drivers/gpu/drm/sitronix/st7571-spi.c, devm_kzallo=
c()
returns NULL on allocation failure rather than an error pointer, and regmap=
 is
uninitialized at this point.

When devm_kzalloc() fails, IS_ERR(spi_data) evaluates to false and execution
continues to spi_data->spi =3D spi, causing a NULL pointer dereference. In
addition, passing PTR_ERR(regmap) to dev_err_probe() reads the uninitialized
regmap variable.

Should this check for !spi_data and return -ENOMEM instead?

> +	spi_data->dc_gpio =3D devm_gpiod_get(&spi->dev, "dc", GPIOD_OUT_LOW);
> +
> +	if (IS_ERR(spi_data->dc_gpio))
> +		/* init regmap for 3 line SPI */
> +		regmap =3D devm_regmap_init_spi(spi, &st7571_spi_regmap_config);
> +	else
> +		/* init regmap for 4 line SPI */
> +		regmap =3D devm_regmap_init(&spi->dev, &regmap_spi_dc_bus,
> +					  spi_data, &st7571_spi_regmap_config);

[Severity: High]
Could checking IS_ERR(spi_data->dc_gpio) after devm_gpiod_get() in
st7571_spi_probe() in drivers/gpu/drm/sitronix/st7571-spi.c break probe
deferral for 4-line SPI panels?

If a 4-line SPI panel specifies dc-gpios in Device Tree and the GPIO provid=
er
is not ready yet, devm_gpiod_get() returns ERR_PTR(-EPROBE_DEFER). Because =
any
IS_ERR(spi_data->dc_gpio) result falls back to devm_regmap_init_spi(), the
driver silently ignores -EPROBE_DEFER (and any other GPIO error) and
configures the 4-line SPI panel as a 3-line SPI device without driving its =
D/C
pin.

Would it be better to use devm_gpiod_get_optional(&spi->dev, "dc",
GPIOD_OUT_LOW), propagate IS_ERR(spi_data->dc_gpio) via dev_err_probe(), and
select 3-line vs 4-line SPI based on whether spi_data->dc_gpio is NULL?

[ ... ]

> diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix=
/st7571.c
> index 20954c33eca93..2dd52f2214d28 100644
> --- a/drivers/gpu/drm/sitronix/st7571.c
> +++ b/drivers/gpu/drm/sitronix/st7571.c

[ ... ]

> +static inline u8 st75156_transform_xy(struct st7571_device *st75156, int=
 x, int y)
> +{
> +	int xrest =3D x % 8;
> +	u8 result =3D 0;
> +	u8 row_len =3D (st75156->ncols / 8) * st75156->bpp;
> +	int i;
> +	const char *p =3D st75156->hwbuf;
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
> +	x =3D x / 8;
> +	y =3D (y / 8) * 8;
> +
> +	for (i =3D 0; i < 8; i++) {
> +		int row_idx =3D y + i;
> +		u8 byte =3D p[row_idx * row_len + x];
> +		/* LSB in input is left most pixel */
> +		u8 bit =3D (byte >> xrest) & 1;
> +		/* LSB in output is 7th row */
> +		result |=3D (bit << (7 - i));
> +	}
> +
> +	return result;
> +}
> +
>  static int st7571_set_position(struct st7571_device *st7571, int x, int =
y)
>  {
>  	u8 cmd_list[] =3D {
> @@ -138,6 +290,23 @@ static int st7571_set_position(struct st7571_device =
*st7571, int x, int y)
>  	return st7571_send_command_list(st7571, cmd_list, ARRAY_SIZE(cmd_list));
>  }
> =20
> +static int st75156_set_position(struct st7571_device *st75156, int x, in=
t y)
> +{
> +	u8 xs_param =3D st75156->startcol + x;
> +	u8 xe_param =3D st75156->startcol + st75156->ncols - 1;
> +	u8 ys_param =3D y / ST7571_PAGE_HEIGHT;
> +	u8 ye_param =3D ys_param;
> +
> +	u8 cmd_list[] =3D {
> +		ST75156_EXTENSION_COMMAND_1, 0x00,
> +		ST75156_COLUMN_ADDRESS_SETTING, 0x02, xs_param, xe_param,
> +		ST75156_PAGE_ADDRESS_SETTING, 0x02, ys_param, ye_param,
> +		ST75156_ENTER_WRITE_DDRAM_MODE, 0x00,
> +	};
> +
> +	return st75156_send_command_list(st75156, cmd_list, ARRAY_SIZE(cmd_list=
));
> +}

[ ... ]

> @@ -284,6 +468,37 @@ static int st7571_fb_update_rect_grayscale(struct dr=
m_framebuffer *fb, struct dr
>  	return 0;
>  }
> =20
> +static int st75156_fb_update_rect_monochrome(struct drm_framebuffer *fb,=
 struct drm_rect *rect)
> +{
> +	struct st7571_device *st75156 =3D drm_to_st7571(fb->dev);
> +	struct device *dev =3D st75156->dev;
> +
> +	char *row =3D st75156->row;
> +	int x;
> +	int y;
> +	int num_bytes;
> +	int ret;
> +
> +	/* Align y to display page boundaries */
> +	rect->y1 =3D round_down(rect->y1, ST7571_PAGE_HEIGHT);
> +	rect->y2 =3D min_t(unsigned int, round_up(rect->y2, ST7571_PAGE_HEIGHT)=
, st75156->nlines);
> +
> +	for (y =3D rect->y1; y < rect->y2; y +=3D ST7571_PAGE_HEIGHT) {
> +		for (x =3D rect->x1; x < rect->x2; x++)
> +			row[x] =3D st75156_transform_xy(st75156, x, y);
> +
> +		st75156_set_position(st75156, rect->x1, y);
> +
> +		num_bytes =3D (rect->x2) - (rect->x1);
> +		ret =3D regmap_bulk_write(st75156->regmap, ST7571_DATA_MODE,
> +					row + rect->x1, num_bytes);
> +		if (ret < 0)
> +			dev_err(dev, "Failed to write data to display (error code: %i", ret);
> +	}
> +
> +	return 0;
> +}

[Severity: Critical]
Can st75156_transform_xy() in drivers/gpu/drm/sitronix/st7571.c read past t=
he
end of st75156->hwbuf and read from the wrong offsets on partial damage
updates?

First, st75156_config allows nlines between 1 and 64, and st7571_probe()
allocates hwbuf for exactly nlines rows:

	st7571->hwbuf =3D devm_kzalloc(st7571->dev,
				     (st7571->nlines * st7571->ncols * st7571->bpp) / 8,
				     GFP_KERNEL);

In st75156_fb_update_rect_monochrome(), y advances by ST7571_PAGE_HEIGHT (8)
up to rect->y2 (clamped to st75156->nlines), and st75156_transform_xy()
unconditionally reads 8 rows at p[row_idx * row_len + x] for i =3D 0..7. Wh=
en
st75156->nlines is not a multiple of 8, the final page iteration reads rows
st75156->nlines through round_up(st75156->nlines, 8) - 1, which is an
out-of-bounds heap read past st75156->hwbuf.

Second, in st7571_primary_plane_helper_atomic_update():

	drm_atomic_for_each_plane_damage(&iter, &damage) {
		st7571->pformat->prepare_buffer(st7571,
						&shadow_plane_state->data[0],
						fb, &damage,
						&shadow_plane_state->fmtcnv_state);

		st7571->pformat->update_rect(fb, &damage);
	}

st7571_prepare_buffer_monochrome() writes only the unaligned damage clip to
the beginning of st7571->hwbuf using dst_pitch =3D
DIV_ROUND_UP(drm_rect_width(rect), 8) before st75156_fb_update_rect_monochr=
ome()
rounds rect->y1 and rect->y2 to multiples of 8. Then st75156_transform_xy()
indexes st75156->hwbuf using the full-screen stride row_len =3D
(st75156->ncols / 8) * st75156->bpp and absolute coordinates (x, y), reading
stale or uninitialized bytes from hwbuf whenever the damage clip is smaller
than the full screen or not aligned to page boundaries.

[ ... ]

> @@ -444,6 +670,13 @@ static void st7571_encoder_atomic_enable(struct drm_=
encoder *encoder,
>  	u8 command =3D ST7571_DISPLAY_ON;
>  	int ret;
> =20
> +	/* ST75156 needs init function to be run earlier than ST7571
> +	 * so we need to call it in the probe function instead of
> +	 * the encoder_atomic_enable function.
> +	 */
> +	if (st7571->device_type =3D=3D DEVICE_TYPE_ST75156)
> +		return;
> +
>  	ret =3D st7571->pdata->init(st7571);
>  	if (ret)
>  		return;
> @@ -458,6 +691,9 @@ static void st7571_encoder_atomic_disable(struct drm_=
encoder *encoder,
>  	struct st7571_device *st7571 =3D drm_to_st7571(drm);
>  	u8 command =3D ST7571_DISPLAY_OFF;
> =20
> +	if (st7571->device_type =3D=3D DEVICE_TYPE_ST75156)
> +		return;
> +
>  	st7571_send_command_list(st7571, &command, 1);
>  }

[Severity: Medium]
Why do st7571_encoder_atomic_enable() and st7571_encoder_atomic_disable() in
drivers/gpu/drm/sitronix/st7571.c return early for DEVICE_TYPE_ST75156 while
st7571_probe() runs st7571->pdata->init(st7571) before drm_dev_register()?

In st75156_lcd_init(), the driver sends ST75156_DISPLAY_ON and calls
backlight_enable(st75156->backlight) during st7571_probe(). Because both
atomic encoder callbacks bail out for DEVICE_TYPE_ST75156 and
backlight_disable() is never called anywhere in the driver:

1. The panel and backlight are turned on before drm_dev_register() and rema=
in
   enabled if drm_dev_register() fails or when the driver is unbound.
2. Blanking, DPMS off, or disabling the CRTC/encoder never sends
   ST75156_DISPLAY_OFF or disables the backlight, and subsequent atomic
   enables cannot turn the display and backlight back on.

Could the panel power and backlight state be managed in the atomic enable a=
nd
disable callbacks instead?

[ ... ]

> @@ -710,6 +948,52 @@ static int st7571_parse_dt(struct st7571_device *st7=
571)
>  		return dev_err_probe(dev, PTR_ERR(st7571->reset),
>  				     "Failed to get reset gpio\n");
> =20
> +	st7571->device_type =3D DEVICE_TYPE_ST7571;
> +
> +	return 0;
> +}
> +
> +static int st75156_parse_dt(struct st7571_device *st75156)
> +{

[ ... ]

> +	st75156->device_type =3D DEVICE_TYPE_ST75156;
> +
> +	st75156->backlight =3D devm_of_find_backlight(dev);
> +	if (IS_ERR(st75156->backlight))
> +		return dev_err_probe(dev, PTR_ERR(st75156->backlight),
> +			"Failed to get backlight from DT\n");
> +
>  	return 0;
>  }

[Severity: Medium]
Does DRM_ST7571 in drivers/gpu/drm/sitronix/Kconfig need to select
BACKLIGHT_CLASS_DEVICE now that st75156_parse_dt() and st75156_lcd_init() in
drivers/gpu/drm/sitronix/st7571.c call devm_of_find_backlight() and
backlight_enable()?

In include/linux/backlight.h, devm_of_find_backlight() is declared when
IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE) is true. If CONFIG_DRM_ST7571=3Dy=
 and
CONFIG_BACKLIGHT_CLASS_DEVICE=3Dm, linking the built-in st7571 driver will =
fail
with an undefined reference to devm_of_find_backlight.

> =20
> @@ -720,6 +1004,14 @@ static void st7571_reset(struct st7571_device *st75=
71)
>  	gpiod_set_value_cansleep(st7571->reset, 0);
>  }
> =20
> +static void st75156_reset(struct st7571_device *st7571)
> +{
> +	gpiod_set_value_cansleep(st7571->reset, 0);
> +	usleep_range(20, 10000);
> +	gpiod_set_value_cansleep(st7571->reset, 1);
> +	msleep(120);
> +}

[Severity: High]
Is the reset GPIO polarity inverted in st75156_reset() in
drivers/gpu/drm/sitronix/st7571.c?

st75156_parse_dt() requests the reset line with devm_gpiod_get(dev, "reset",
GPIOD_OUT_HIGH), and gpiod_set_value_cansleep() operates on logical line st=
ate
(1 =3D asserted/active, 0 =3D deasserted/inactive). Unlike st7571_reset() r=
ight
above, which sets 1 and then 0, st75156_reset() sets 0 and then leaves the
reset GPIO at logical 1. When reset-gpios is configured as GPIO_ACTIVE_LOW =
in
Device Tree, ending with gpiod_set_value_cansleep(st7571->reset, 1) drives =
the
physical pin low and leaves the ST75156 controller held in hardware reset.

Should st75156_reset() assert reset with 1 and deassert it with 0?

[ ... ]

> +static int st75156_lcd_init(struct st7571_device *st75156)
> +{
> +	int ret;

[ ... ]

> +	u8 commands[] =3D {
> +		ST75156_EXTENSION_COMMAND_2, 0x00,
> +		ST75156_SET_AUTO_READ_INSTRUCTION, 0x01, ST75156_DISABLE_AUTO_READ,
> +		ST75156_OTP_WR_RD_CONTROL, 0x01, 0x10,
> +		ST75156_SLEEP_MS, 0x01, 0x0a,
> +		ST75156_OTP_UPLOAD, 0x00,
> +		ST75156_SLEEP_MS, 0x01, 0x14,
> +		ST75156_OTP_CONTROL_OUT, 0x00,
> +		ST75156_EXTENSION_COMMAND_1, 0x00,
> +		ST75156_SLEEP_OUT, 0x00,
> +		ST75156_DISPLAY_OFF, 0x00,
> +		ST75156_SLEEP_MS, 0x01, 0x32,
> +		ST75156_POWER_CONTROL, 0x01, 0x0b,
> +		ST75156_SLEEP_MS, 0x01, 0x64,
> +		ST75156_SET_VOP, 0x02, 0x06, 0x03,
> +		ST75156_EXTENSION_COMMAND_2, 0x00,
> +		ST75156_ANALOG_CIRCUIT_SET, 0x03, 0x00, 0x01, 0x05,
> +		ST75156_BOOSTER_LEVEL_X10, 0x01, 0xfb,
> +		ST75156_EXTENSION_COMMAND_1, 0x00,
> +		ST75156_DISPLAY_MODE, 0x01, 0x10,
> +		ST75156_DISPLAY_CONTROL, 0x03, 0x00, 0x3f, 0x00,
> +		ST75156_DATA_SCAN_DIRECTION, 0x01, 0x02,
> +		ST75156_NORMAL_DISPLAY, 0x00,
> +		ST75156_EXTENSION_COMMAND_2, 0x00,
> +		ST75156_INTERAL_POWER_SUPPLY, 0x00,
> +		ST75156_EXTENSION_COMMAND_1, 0x00,
> +		ST75156_COLUMN_ADDRESS_SETTING, 0x02, 0x00, 0xef,
> +		ST75156_PAGE_ADDRESS_SETTING, 0x02, 0x00, 0x07,
> +		ST75156_DISPLAY_ON, 0x00,
> +	};

[Severity: Medium]
In drivers/gpu/drm/sitronix/st7571.c, st75156_parse_dt() parses
st75156->inverted, st75156->startline (from dt.vback_porch.typ),
st75156->startcol (from dt.hback_porch.typ), and st75156->nlines (from
dt.vactive.typ), but are these parameters wired up and validated for ST7515=
6?

1. st75156_lcd_init() hardcodes ST75156_NORMAL_DISPLAY (0xa6),
   ST75156_DISPLAY_CONTROL (0x00, 0x3f, 0x00), ST75156_COLUMN_ADDRESS_SETTI=
NG
   (0x00, 0xef), and ST75156_PAGE_ADDRESS_SETTING (0x00, 0x07), ignoring
   st75156->inverted, st75156->startline, and st75156->nlines, and
   st75156->startline is never used in st75156_set_position() either.
2. st75156_set_position() computes:

	u8 xs_param =3D st75156->startcol + x;
	u8 xe_param =3D st75156->startcol + st75156->ncols - 1;

   However, st7571_validate_parameters() only checks startline + nlines >
   constraints->max_nlines and never checks startcol + ncols >
   constraints->max_ncols. Since st75156_config sets both min_ncols and
   max_ncols to 240, any non-zero startcol will exceed the 240-column
   controller limit (0xef) and overflow u8 when startcol >=3D 17.

Should st75156_lcd_init() and st75156_set_position() honor the parsed
Device Tree settings, and should st7571_validate_parameters() validate
startcol + ncols against constraints->max_ncols?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add_st7515=
6_support-v1-0-582525a39a39@axis.com?part=3D1
