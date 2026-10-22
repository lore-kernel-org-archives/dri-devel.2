Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2B35D606A319
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 15:49:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=inYsgLtA
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7C99611277D;
	Thu, 22 Oct 2026 15:49:02 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D93DC1127AD
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 15:48:55 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 414EE6143B;
 Thu, 22 Oct 2026 15:48:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9FDB31F01828;
 Thu, 22 Oct 2026 15:48:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1792684135;
 bh=oBAPyZAEtqnfOm3LYriDzIRHeshvdHMWXppGWKtaKxs=;
 h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
 b=inYsgLtAHzwtluDonVAyGx95UwUt0a07/9V04zddBN3QZnelXmbnq2GRxKETqQ0is
 oAu23JtVwOX4ICY8TsEBnjFT3yW4VeaLOoccRxdFITRfUZppHSNtq1NUoyHpqSf/3Z
 5wfKa6+YbTBSBvziec1EMPsAorGcr4eZ+XHxFR5jO9Yq1OEnGDTPeeyaOGEIxrljR8
 +PdoL4g4hRnIgmeegoM20dfP73vOy0iCm0BBv3wikNae6pRE51MpqZx7hD1itl2iim
 HDuSOEgEoUuwbBQPdsACRrIFtu3g2QdmIzhX7WazwSkHBx9HZ/KrdEQ09S/O1T4x5p
 x+yWevSWWzylw==
Message-ID: <sashiko-outbox-181726@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] dt-bindings: display: sitronix,st75156: add example
 for SPI
To: "Lars Rask" <lars.rask@axis.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 robh@kernel.org, conor+dt@kernel.org
In-Reply-To: <20261022-add_st75156_support-v1-2-582525a39a39@axis.com>
References: <20261022-add_st75156_support-v1-0-582525a39a39@axis.com>
 <20261022-add_st75156_support-v1-2-582525a39a39@axis.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 22 Oct 2026 15:48:54 +0000
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

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:
- [High] drm/sitronix: st7571-spi: missing kmemdup() NULL checks in regmap_=
spi_write()
- [High] drm/sitronix: inverted reset GPIO polarity in st75156_reset()
- [Medium] dt-bindings: display: sitronix,st75156: missing SPI and panel pr=
operties
- [Medium] dt-bindings: display: sitronix,st75156: example timings fail st7=
571_probe()
- [Medium] drm/sitronix: st75156_lcd_init() ignores DT inverted and startli=
ne
- [Medium] drm/sitronix: st7571: missing display power and backlight contro=
l for st75156
- [Low] drm/sitronix: missing BACKLIGHT_CLASS_DEVICE select for DRM_ST7571
--

commit 3557b66cb1cae50421d6b3c371688ed607f5a7dc
Author: Lars Rask <lars.rask@axis.com>

dt-bindings: display: sitronix,st75156: add example for SPI

This series adds support for the Sitronix st75156 display controller to the
st7571 driver and introduces the corresponding device tree binding schema
and spi example.

> diff --git a/Documentation/devicetree/bindings/display/sitronix,st75156.y=
aml b/Documentation/devicetree/bindings/display/sitronix,st75156.yaml
> new file mode 100644
> index 0000000000000..a3897ddc5e386
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/display/sitronix,st75156.yaml
> @@ -0,0 +1,67 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/display/sitronix,st75156.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Sitronix ST75156 Display Controller
> +
> +maintainers:
> +  - Marcus Folkesson <marcus.folkesson@gmail.com>
> +
> +description:
> +  Sitronix ST75156 is a monochrome dot matrix LCD panel used in SPI 4-wi=
re mode.
> +
> +allOf:
> +  - $ref: panel/panel-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: sitronix,st75156
> +
> +  reg:
> +    maxItems: 1
> +
> +  reset-gpios: true
> +  width-mm: true
> +  height-mm: true
> +  panel-timing: true
> +
> +required:
> +  - compatible
> +  - reg
> +  - reset-gpios
> +  - width-mm
> +  - height-mm
> +  - panel-timing
> +
> +additionalProperties: false

[Severity: Medium]
In Documentation/devicetree/bindings/display/sitronix,st75156.yaml, the
schema sets additionalProperties: false and only references
panel/panel-common.yaml#, without referencing
/schemas/spi/spi-peripheral-props.yaml# (with unevaluatedProperties: false)
or listing dc-gpios, backlight, and sitronix,inverted under properties.

In drivers/gpu/drm/sitronix/st7571-spi.c, st7571_spi_probe() requests the
data/command gpio to enable 4-wire spi mode:

	spi_data->dc_gpio =3D devm_gpiod_get(&spi->dev, "dc", GPIOD_OUT_LOW);

And in drivers/gpu/drm/sitronix/st7571.c, st75156_parse_dt() parses
sitronix,inverted and backlight from the device tree node:

	st75156->inverted =3D of_property_read_bool(np, "sitronix,inverted");
	...
	st75156->backlight =3D devm_of_find_backlight(dev);

Won't dtbs_check fail validation on any st75156 spi node that specifies
dc-gpios, spi-max-frequency, backlight, or sitronix,inverted, and won't a
device tree based on the example below (without dc-gpios) fall back to
3-wire spi mode in st7571_spi_probe() instead of 4-wire spi mode?

> +
> +examples:
> +  - |
> +    #include <dt-bindings/gpio/gpio.h>
> +
> +    spi {
> +      #address-cells =3D <1>;
> +      #size-cells =3D <0>;
> +
> +      display@0 {
> +        compatible =3D "sitronix,st75156";
> +        reg =3D <0>;
> +        reset-gpios =3D <&gpio0 3 GPIO_ACTIVE_LOW>;
> +        width-mm =3D <37>;
> +        height-mm =3D <27>;
> +
> +        panel-timing {
> +          hactive =3D <128>;
> +          vactive =3D <96>;

[Severity: Medium]
When a device tree node uses the panel-timing values from the examples block
in Documentation/devicetree/bindings/display/sitronix,st75156.yaml,
st7571_probe() -> st75156_parse_dt() sets st75156->ncols to 128 and
st75156->nlines to 96.

Then st7571_probe() -> st7571_validate_parameters() checks those dimensions
against st75156_config in drivers/gpu/drm/sitronix/st7571.c:

	const struct st7571_panel_data st75156_config =3D {
		.init =3D st75156_lcd_init,
		.parse_dt =3D st75156_parse_dt,
		.fb_clear_screen =3D st75156_fb_clear_screen,
		.constraints =3D {
			.min_nlines =3D 1,
			.max_nlines =3D 64,
			.min_ncols =3D 240,
			.max_ncols =3D 240,
			.support_grayscale =3D false,
		},
	};

Since hactive =3D <128> and vactive =3D <96> are outside the allowed 240 co=
lumns
and 1..64 lines, won't st7571_probe() reject the example timings with
-EINVAL?

[ ... ]

> diff --git a/drivers/gpu/drm/sitronix/st7571-spi.c b/drivers/gpu/drm/sitr=
onix/st7571-spi.c
> index 0206e9162f1cd..724c0eb5e7dab 100644
> --- a/drivers/gpu/drm/sitronix/st7571-spi.c
> +++ b/drivers/gpu/drm/sitronix/st7571-spi.c
> @@ -17,23 +17,133 @@ static const struct regmap_config st7571_spi_regmap_=
config =3D {

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

[Severity: High]
In drivers/gpu/drm/sitronix/st7571-spi.c, when regmap_spi_write() is called
from st75156_lcd_init() -> st75156_send_command_list() -> regmap_bulk_write=
()
or from st75156_fb_update_rect_monochrome() / st75156_fb_clear_screen() ->
regmap_bulk_write(), databuf is allocated with kmemdup() in both the
command-parameter branch and the data-mode branch when num_data_bytes > 0.

Unlike cmdbuf above, neither databuf allocation is checked for null before
passing databuf to spi_write(spi_data->spi, databuf, num_data_bytes).

If kmemdup() fails under memory pressure, spi_write() submits an
spi_transfer with tx_buf =3D NULL, rx_buf =3D NULL, and len =3D num_data_by=
tes > 0.
Can this silently drop command parameters or display data (when
spi_transfer_one_message() rejects the bufferless transfer and returns 0),
or cause a null pointer dereference in spi controller drivers whose
transfer_one_message() callback dereferences tx_buf when len > 0?

[ ... ]

> diff --git a/drivers/gpu/drm/sitronix/st7571.c b/drivers/gpu/drm/sitronix=
/st7571.c
> index 20954c33eca93..2dd52f2214d28 100644
> --- a/drivers/gpu/drm/sitronix/st7571.c
> +++ b/drivers/gpu/drm/sitronix/st7571.c

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
In drivers/gpu/drm/sitronix/st7571.c, st7571_probe() calls
st75156_lcd_init(), which turns on the display and enables the backlight via
backlight_enable(st75156->backlight).

However, both st7571_encoder_atomic_enable() and
st7571_encoder_atomic_disable() return early when st7571->device_type is
DEVICE_TYPE_ST75156, without sending ST75156_DISPLAY_ON or
ST75156_DISPLAY_OFF or toggling st7571->backlight. Likewise, st7571_remove()
only calls drm_dev_unplug(&st7571->drm) without disabling st7571->backlight:

	void st7571_remove(struct st7571_device *st7571)
	{
		drm_dev_unplug(&st7571->drm);
	}

How are display power and backlight state managed for st75156 during atomic
disable/enable cycles or when the driver is removed?

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
> +	struct device *dev =3D st75156->dev;
> +	struct device_node *np =3D dev->of_node;
> +	struct display_timing dt;
> +	int ret;
> +
> +	ret =3D of_get_display_timing(np, "panel-timing", &dt);
> +
> +	if (ret) {
> +		dev_err(dev, "Failed to get display timing from DT\n");
> +		return ret;
> +	}
> +
> +	of_property_read_u32(np, "width-mm", &st75156->width_mm);
> +	of_property_read_u32(np, "height-mm", &st75156->height_mm);
> +	st75156->inverted =3D of_property_read_bool(np, "sitronix,inverted");
> +
> +	st75156->pformat =3D &st75156_monochrome;
> +	st75156->bpp =3D 1;
> +
> +	st75156->startline =3D dt.vback_porch.typ;
> +	st75156->startcol =3D dt.hback_porch.typ;
> +
> +	st75156->nlines =3D dt.vactive.typ;
> +	st75156->ncols =3D dt.hactive.typ;
> +
> +	st75156->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +
> +	if (IS_ERR(st75156->reset)) {
> +		return dev_err_probe(dev, PTR_ERR(st75156->reset),
> +				     "Failed to get reset gpio from DT\n");
> +	}
> +
> +	st75156->device_type =3D DEVICE_TYPE_ST75156;
> +
> +	st75156->backlight =3D devm_of_find_backlight(dev);
> +	if (IS_ERR(st75156->backlight))
> +		return dev_err_probe(dev, PTR_ERR(st75156->backlight),
> +			"Failed to get backlight from DT\n");
> +
>  	return 0;
>  }

[Severity: Low]
In drivers/gpu/drm/sitronix/st7571.c, st75156_parse_dt() calls
devm_of_find_backlight(dev). In include/linux/backlight.h,
devm_of_find_backlight() is declared as an external function under
#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE):

	#if IS_ENABLED(CONFIG_BACKLIGHT_CLASS_DEVICE)
	struct backlight_device *devm_of_find_backlight(struct device *dev);
	#else
	static inline struct backlight_device *
	devm_of_find_backlight(struct device *dev)
	{
		return NULL;
	}
	#endif

Because config DRM_ST7571 in drivers/gpu/drm/sitronix/Kconfig does not
select BACKLIGHT_CLASS_DEVICE:

	config DRM_ST7571
		tristate "DRM support for Sitronix ST7567/ST7571 display panels"
		depends on DRM && MMU
		select DRM_CLIENT_SELECTION
		select DRM_GEM_SHMEM_HELPER
		select DRM_KMS_HELPER
		select VIDEOMODE_HELPERS

won't building with CONFIG_DRM_ST7571=3Dy and CONFIG_BACKLIGHT_CLASS_DEVICE=
=3Dm
fail to link vmlinux with an undefined reference to
devm_of_find_backlight()?

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
When reset-gpios is configured as active-low in the device tree (as shown in
Documentation/devicetree/bindings/display/sitronix,st75156.yaml with
reset-gpios =3D <&gpio0 3 GPIO_ACTIVE_LOW>;), gpiod_set_value_cansleep() us=
es
logical values where 1 asserts reset (physical low) and 0 deasserts reset
(physical high).

During st7571_spi_probe() -> st7571_probe() -> st75156_lcd_init() ->
st75156_reset() in drivers/gpu/drm/sitronix/st7571.c, st75156_reset() sets
st7571->reset to 0 and then leaves it at 1, which is the inverse of
st7571_reset() above it.

Won't this leave the st75156 controller held in reset after
st75156_reset() completes?

> @@ -799,8 +1091,86 @@ static int st7571_lcd_init(struct st7571_device *st=
7571)
>  	return st7571_send_command_list(st7571, commands, ARRAY_SIZE(commands));
>  }
> =20
> -struct st7571_device *st7571_probe(struct device *dev,
> -				   struct regmap *regmap)
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
st75156->inverted from the sitronix,inverted property and st75156->startline
from dt.vback_porch.typ.

However, unlike st7567_lcd_init() and st7571_lcd_init(), st75156_lcd_init()
hardcodes ST75156_DISPLAY_CONTROL and ST75156_NORMAL_DISPLAY in commands[],
and st75156_set_position() only applies st75156->startcol without using
st75156->startline:

	u8 xs_param =3D st75156->startcol + x;
	u8 xe_param =3D st75156->startcol + st75156->ncols - 1;
	u8 ys_param =3D y / ST7571_PAGE_HEIGHT;
	u8 ye_param =3D ys_param;

Should st75156_lcd_init() (or st75156_set_position()) apply
st75156->inverted and st75156->startline so that device tree nodes setting
sitronix,inverted or a non-zero vback-porch take effect?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261022-add_st7515=
6_support-v1-0-582525a39a39@axis.com?part=3D2
