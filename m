Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D6F0B606A8BC
	for <dri-devel@archiver.kernel.org>; Wed, 11 Nov 2026 16:51:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1A60110FC4B;
	Wed, 11 Nov 2026 16:51:26 +0000 (UTC)
Received: from aposti.net (aposti.net [185.119.170.32])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B971D10FC4B
 for <dri-devel@lists.freedesktop.org>; Wed, 11 Nov 2026 16:51:23 +0000 (UTC)
Message-ID: <93e271bb46944ea887722fa2296efa26f4ce2c58.camel@crapouillou.net>
Subject: Re: [PATCH v4 5/5] drm/panel: Add the HiBy LG35583
From: Paul Cercueil <paul@crapouillou.net>
To: Olivier Louvignes <olivier@mgcrea.io>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, Neil Armstrong
 <neil.armstrong@linaro.org>
Cc: David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,  Conor Dooley
 <conor+dt@kernel.org>, "H . Nikolaus Schaller" <hns@goldelico.com>, Thomas
 Petazzoni	 <thomas.petazzoni@bootlin.com>, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-kernel@vger.kernel.org
Date: Wed, 11 Nov 2026 17:51:16 +0100
In-Reply-To: <20261109174640.96951-6-olivier@mgcrea.io>
References: <20261109174640.96951-1-olivier@mgcrea.io>
 <20261109174640.96951-6-olivier@mgcrea.io>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
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
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hi Olivier,

Le lundi 09 novembre 2026 =C3=A0 18:46 +0100, Olivier Louvignes a =C3=A9cri=
t=C2=A0:
> The 480x800 parallel RGB panel of the HiBy R1. It is set up over a 3-wire
> SPI bus with 16-bit words, each carrying a register address byte or a
> data byte, which no existing panel driver speaks. The set-up sequence is
> the vendor kernel's; prepare sends it up to sleep-out, and enable and
> disable switch the display on and off. It asks for BGR666: in RGB order t=
he
> R1 shows red and blue swapped.
>=20
> Signed-off-by: Olivier Louvignes <olivier@mgcrea.io>
> ---
> =C2=A0MAINTAINERS=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=
=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/panel/Kconfig=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0 10 +
> =C2=A0drivers/gpu/drm/panel/Makefile=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=
=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0=C2=A0 |=C2=A0=C2=A0 1 +
> =C2=A0drivers/gpu/drm/panel/panel-hiby-lg35583.c | 342 ++++++++++++++++++=
+++
> =C2=A04 files changed, 354 insertions(+)
> =C2=A0create mode 100644 drivers/gpu/drm/panel/panel-hiby-lg35583.c
>=20
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ddc559cac674..062270232344 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -8350,6 +8350,7 @@ DRM DRIVER FOR HIBY LG35583 PANEL
> =C2=A0M:	Olivier Louvignes <olivier@mgcrea.io>
> =C2=A0S:	Maintained
> =C2=A0F:	Documentation/devicetree/bindings/display/panel/hiby,lg35583.yam=
l
> +F:	drivers/gpu/drm/panel/panel-hiby-lg35583.c
> =C2=A0
> =C2=A0DRM DRIVER FOR HIMAX HX8394 MIPI-DSI LCD panels
> =C2=A0M:	Ondrej Jirman <megi@xff.cz>
> diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfi=
g
> index 26ffa2378f55..79528ff0100a 100644
> --- a/drivers/gpu/drm/panel/Kconfig
> +++ b/drivers/gpu/drm/panel/Kconfig
> @@ -209,6 +209,16 @@ config DRM_PANEL_LVDS
> =C2=A0	=C2=A0 handling of power supplies or control signals. It implement=
s
> automatic
> =C2=A0	=C2=A0 backlight handling if the panel is attached to a backlight
> controller.
> =C2=A0
> +config DRM_PANEL_HIBY_LG35583
> +	tristate "HiBy LG35583 RGB/SPI panel"
> +	depends on OF && SPI
> +	help
> +	=C2=A0 Say Y here if you want to enable support for the LG35583, the
> +	=C2=A0 480x800 parallel RGB panel of the HiBy R1 digital audio player,
> +	=C2=A0 which is set up over a 3-wire SPI bus.
> +
> +	=C2=A0 To compile this driver as a module, choose M here.
> +
> =C2=A0config DRM_PANEL_HIMAX_HX8279
> =C2=A0	tristate "Himax HX8279-based panels"
> =C2=A0	depends on OF
> diff --git a/drivers/gpu/drm/panel/Makefile b/drivers/gpu/drm/panel/Makef=
ile
> index 365f2e73f6b4..9f5cacfaba29 100644
> --- a/drivers/gpu/drm/panel/Makefile
> +++ b/drivers/gpu/drm/panel/Makefile
> @@ -21,6 +21,7 @@ obj-$(CONFIG_DRM_PANEL_ELIDA_KD35T133) +=3D panel-elida=
-
> kd35t133.o
> =C2=A0obj-$(CONFIG_DRM_PANEL_FEIXIN_K101_IM2BA02) +=3D panel-feixin-k101-=
im2ba02.o
> =C2=A0obj-$(CONFIG_DRM_PANEL_FEIYANG_FY07024DI26A30D) +=3D panel-feiyang-
> fy07024di26a30d.o
> =C2=A0obj-$(CONFIG_DRM_PANEL_FOCALTECH_OTA7290B) +=3D panel-focaltech-ota=
7290b.o
> +obj-$(CONFIG_DRM_PANEL_HIBY_LG35583) +=3D panel-hiby-lg35583.o
> =C2=A0obj-$(CONFIG_DRM_PANEL_HIMAX_HX8279) +=3D panel-himax-hx8279.o
> =C2=A0obj-$(CONFIG_DRM_PANEL_HIMAX_HX83102) +=3D panel-himax-hx83102.o
> =C2=A0obj-$(CONFIG_DRM_PANEL_HIMAX_HX83112A) +=3D panel-himax-hx83112a.o
> diff --git a/drivers/gpu/drm/panel/panel-hiby-lg35583.c
> b/drivers/gpu/drm/panel/panel-hiby-lg35583.c
> new file mode 100644
> index 000000000000..9189c7c19665
> --- /dev/null
> +++ b/drivers/gpu/drm/panel/panel-hiby-lg35583.c
> @@ -0,0 +1,342 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * The LG35583 panel of the HiBy R1
> + *
> + * Copyright (c) 2026 Olivier Louvignes <olivier@mgcrea.io>
> + *
> + * A 480x800 parallel RGB panel, set up over a 3-wire SPI bus with 16-bi=
t
> + * words: 0x20 and a register's high byte, 0x00 and its low byte, then 0=
x40
> + * and each data byte. HiBy calls it the LG35583; its controller is not
> + * identified. The set-up sequence is the one the vendor kernel sends.
> + */
> +
> +#include <linux/delay.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/spi/spi.h>
> +
> +#include <drm/drm_modes.h>
> +#include <drm/drm_panel.h>
> +
> +#define LG35583_ADDR_HI		0x2000
> +#define LG35583_ADDR_LO		0x0000
> +#define LG35583_DATA		0x4000
> +
> +#define LG35583_SLPIN		0x1000
> +#define LG35583_SLPOUT		0x1100
> +#define LG35583_DISPOFF		0x2800
> +#define LG35583_DISPON		0x2900
> +#define LG35583_RAMWR		0x2c00
> +
> +struct lg35583_write {
> +	u16 reg;	/* 0: wait val milliseconds */
> +	s16 val;	/* -1: no data */
> +};
> +
> +#define REG(r, v)	{ (r), (v) }
> +#define CMD(r)		{ (r), -1 }
> +#define DELAY(ms)	{ 0, (ms) }
> +
> +static const struct lg35583_write lg35583_init[] =3D {
> +	REG(0xb100, 0x06), REG(0xb101, 0x01), REG(0xb102, 0x54),
> +	REG(0xb104, 0x07), REG(0xb105, 0x06), REG(0xb106, 0x06),
> +	REG(0xb107, 0x4a), REG(0xb108, 0x21), REG(0xb109, 0x08),
> +	REG(0xf101, 0xc0), REG(0xf103, 0x01),
> +	DELAY(5),
> +	REG(0xb400, 0x01), REG(0xb600, 0x10),
> +	REG(0x3a00, 0x77), REG(0x3b00, 0x03), REG(0x5e04, 0x02),
> +	REG(0x3600, 0x08),
> +	DELAY(5),
> +	/* Gamma */
> +	REG(0xe000, 0x00), REG(0xe001, 0x2f), REG(0xe002, 0x3f),
> +	REG(0xe003, 0x1f), REG(0xe004, 0x21), REG(0xe005, 0x2c),
> +	REG(0xe006, 0x2c), REG(0xe007, 0x61), REG(0xe008, 0x1c),
> +	REG(0xe009, 0x18), REG(0xe00a, 0xbc), REG(0xe00b, 0x27),
> +	REG(0xe00c, 0x59), REG(0xe00d, 0x6a), REG(0xe00e, 0xbb),
> +	REG(0xe00f, 0xbe), REG(0xe010, 0x3e), REG(0xe011, 0x48),
> +	REG(0xe100, 0x00), REG(0xe101, 0x32), REG(0xe102, 0x45),
> +	REG(0xe103, 0x26), REG(0xe104, 0x21), REG(0xe105, 0x2c),
> +	REG(0xe106, 0x5c), REG(0xe107, 0x63), REG(0xe108, 0x1c),
> +	REG(0xe109, 0x19), REG(0xe10a, 0xd3), REG(0xe10b, 0x28),
> +	REG(0xe10c, 0x59), REG(0xe10d, 0x6b), REG(0xe10e, 0xdb),
> +	REG(0xe10f, 0xde), REG(0xe110, 0x5f), REG(0xe111, 0x6b),
> +	REG(0xe200, 0x7f), REG(0xe201, 0x7d), REG(0xe202, 0x86),
> +	REG(0xe203, 0x89), REG(0xe204, 0x10), REG(0xe205, 0x1e),
> +	REG(0xe206, 0x41), REG(0xe207, 0x77), REG(0xe208, 0x0d),
> +	REG(0xe209, 0x1d), REG(0xe20a, 0xc8), REG(0xe20b, 0x30),
> +	REG(0xe20c, 0x5f), REG(0xe20d, 0x71), REG(0xe20e, 0xc3),
> +	REG(0xe20f, 0xbe), REG(0xe210, 0x3e), REG(0xe211, 0x48),
> +	REG(0xe300, 0x7f), REG(0xe301, 0x7f), REG(0xe302, 0x86),
> +	REG(0xe303, 0x93), REG(0xe304, 0x10), REG(0xe305, 0x1e),
> +	REG(0xe306, 0x41), REG(0xe307, 0x89), REG(0xe308, 0x0d),
> +	REG(0xe309, 0x1d), REG(0xe30a, 0xe0), REG(0xe30b, 0x30),
> +	REG(0xe30c, 0x5f), REG(0xe30d, 0x70), REG(0xe30e, 0xe4),
> +	REG(0xe30f, 0xdf), REG(0xe310, 0x5f), REG(0xe311, 0x6b),
> +	REG(0xe400, 0x00), REG(0xe401, 0x43), REG(0xe402, 0x6f),
> +	REG(0xe403, 0x60), REG(0xe404, 0x21), REG(0xe405, 0x2c),
> +	REG(0xe406, 0x5a), REG(0xe407, 0x6d), REG(0xe408, 0x1c),
> +	REG(0xe409, 0x18), REG(0xe40a, 0xc6), REG(0xe40b, 0x27),
> +	REG(0xe40c, 0x59), REG(0xe40d, 0x6a), REG(0xe40e, 0xbb),
> +	REG(0xe40f, 0xbe), REG(0xe410, 0x3e), REG(0xe411, 0x48),
> +	REG(0xe500, 0x00), REG(0xe501, 0x46), REG(0xe502, 0x75),
> +	REG(0xe503, 0x67), REG(0xe504, 0x21), REG(0xe505, 0x2c),
> +	REG(0xe506, 0x5a), REG(0xe507, 0x7e), REG(0xe508, 0x1c),
> +	REG(0xe509, 0x19), REG(0xe50a, 0xdd), REG(0xe50b, 0x28),
> +	REG(0xe50c, 0x59), REG(0xe50d, 0x6b), REG(0xe50e, 0xdb),
> +	REG(0xe50f, 0xde), REG(0xe510, 0x5f), REG(0xe511, 0x6b),
> +	DELAY(5),
> +	REG(0xc200, 0x70), REG(0xc202, 0x70), REG(0xc203, 0x44),
> +	DELAY(20),
> +	REG(0xc200, 0x51), REG(0xc201, 0x06), REG(0xc202, 0x51),
> +	REG(0xc203, 0x66),
> +	DELAY(20),
> +	REG(0xc100, 0x45),
> +	DELAY(5),
> +	REG(0xc700, 0x46), REG(0xc000, 0xa3), REG(0xc002, 0x8a),
> +	DELAY(5),
> +	CMD(LG35583_SLPOUT),
> +	DELAY(130),
> +};
> +
> +struct lg35583 {
> +	struct drm_panel panel;
> +	struct spi_device *spi;
> +	struct gpio_desc *reset;
> +	struct regulator *vcc;
> +	struct regulator *vccio;
> +};
> +
> +static const struct drm_display_mode lg35583_mode =3D {
> +	.clock =3D 28000,
> +	.hdisplay =3D 480,
> +	.hsync_start =3D 480 + 24,
> +	.hsync_end =3D 480 + 24 + 24,
> +	.htotal =3D 480 + 24 + 24 + 24,
> +	.vdisplay =3D 800,
> +	.vsync_start =3D 800 + 14,
> +	.vsync_end =3D 800 + 14 + 5,
> +	.vtotal =3D 800 + 14 + 5 + 8,
> +	.flags =3D DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_PVSYNC,
> +	.type =3D DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,

FYI:
28 MHz / ((480+24+24+24)*(800+14+5+8)) that's ~61.34 Hz, if your input cloc=
k is
a perfect 28 MHz you could have (.htotal =3D .hsync_end + 14) and (.vtotal =
=3D
.vsync_end =3D .vsync_end + 42) and get 60.001 Hz.

Cheers,
-Paul

> +};
> +
> +static struct lg35583 *to_lg35583(struct drm_panel *panel)
> +{
> +	return container_of(panel, struct lg35583, panel);
> +}
> +
> +static int lg35583_word(struct lg35583 *ctx, u16 word)
> +{
> +	/* Copied to a DMA-safe buffer. */
> +	return spi_write_then_read(ctx->spi, &word, sizeof(word), NULL, 0);
> +}
> +
> +static int lg35583_cmd(struct lg35583 *ctx, u16 reg)
> +{
> +	int ret;
> +
> +	ret =3D lg35583_word(ctx, LG35583_ADDR_HI | (reg >> 8));
> +	if (ret)
> +		return ret;
> +	return lg35583_word(ctx, LG35583_ADDR_LO | (reg & 0xff));
> +}
> +
> +static int lg35583_write(struct lg35583 *ctx, const struct lg35583_write=
 *w)
> +{
> +	int ret;
> +
> +	if (!w->reg) {
> +		msleep(w->val);
> +		return 0;
> +	}
> +
> +	ret =3D lg35583_cmd(ctx, w->reg);
> +	if (ret || w->val < 0)
> +		return ret;
> +	return lg35583_word(ctx, LG35583_DATA | w->val);
> +}
> +
> +static int lg35583_prepare(struct drm_panel *panel)
> +{
> +	struct lg35583 *ctx =3D to_lg35583(panel);
> +	unsigned int i;
> +	int ret;
> +
> +	ret =3D regulator_enable(ctx->vccio);
> +	if (ret)
> +		return ret;
> +	usleep_range(5000, 6000);
> +
> +	ret =3D regulator_enable(ctx->vcc);
> +	if (ret)
> +		goto err_vccio;
> +	usleep_range(5000, 6000);
> +
> +	gpiod_set_value_cansleep(ctx->reset, 0);
> +	usleep_range(5000, 6000);
> +	gpiod_set_value_cansleep(ctx->reset, 1);
> +	msleep(50);
> +	gpiod_set_value_cansleep(ctx->reset, 0);
> +	msleep(30);
> +
> +	for (i =3D 0; i < ARRAY_SIZE(lg35583_init); i++) {
> +		ret =3D lg35583_write(ctx, &lg35583_init[i]);
> +		if (ret) {
> +			dev_err(panel->dev, "Unable to set up the panel:
> %d\n", ret);
> +			goto err_vcc;
> +		}
> +	}
> +
> +	return 0;
> +
> +err_vcc:
> +	gpiod_set_value_cansleep(ctx->reset, 1);
> +	regulator_disable(ctx->vcc);
> +err_vccio:
> +	regulator_disable(ctx->vccio);
> +	return ret;
> +}
> +
> +static int lg35583_enable(struct drm_panel *panel)
> +{
> +	struct lg35583 *ctx =3D to_lg35583(panel);
> +	int ret;
> +
> +	ret =3D lg35583_cmd(ctx, LG35583_DISPON);
> +	if (ret)
> +		return ret;
> +
> +	return lg35583_cmd(ctx, LG35583_RAMWR);
> +}
> +
> +static int lg35583_disable(struct drm_panel *panel)
> +{
> +	struct lg35583 *ctx =3D to_lg35583(panel);
> +	int ret;
> +
> +	ret =3D lg35583_cmd(ctx, LG35583_DISPOFF);
> +	usleep_range(5000, 6000);
> +	return ret;
> +}
> +
> +static int lg35583_unprepare(struct drm_panel *panel)
> +{
> +	struct lg35583 *ctx =3D to_lg35583(panel);
> +
> +	lg35583_cmd(ctx, LG35583_SLPIN);
> +	usleep_range(5000, 6000);
> +
> +	gpiod_set_value_cansleep(ctx->reset, 1);
> +	regulator_disable(ctx->vcc);
> +	regulator_disable(ctx->vccio);
> +	return 0;
> +}
> +
> +static int lg35583_get_modes(struct drm_panel *panel, struct drm_connect=
or
> *connector)
> +{
> +	/* Red and blue are swapped on the R1 without it. */
> +	static const u32 bus_format =3D MEDIA_BUS_FMT_BGR666_1X18;
> +	struct drm_display_mode *mode;
> +
> +	mode =3D drm_mode_duplicate(connector->dev, &lg35583_mode);
> +	if (!mode)
> +		return -ENOMEM;
> +
> +	drm_mode_set_name(mode);
> +	drm_mode_probed_add(connector, mode);
> +
> +	connector->display_info.bpc =3D 6;
> +	connector->display_info.bus_flags =3D DRM_BUS_FLAG_DE_HIGH |
> +					=C2=A0=C2=A0=C2=A0
> DRM_BUS_FLAG_PIXDATA_DRIVE_POSEDGE;
> +	drm_display_info_set_bus_formats(&connector->display_info,
> &bus_format, 1);
> +
> +	return 1;
> +}
> +
> +static const struct drm_panel_funcs lg35583_funcs =3D {
> +	.prepare =3D lg35583_prepare,
> +	.enable =3D lg35583_enable,
> +	.disable =3D lg35583_disable,
> +	.unprepare =3D lg35583_unprepare,
> +	.get_modes =3D lg35583_get_modes,
> +};
> +
> +static int lg35583_probe(struct spi_device *spi)
> +{
> +	struct device *dev =3D &spi->dev;
> +	struct lg35583 *ctx;
> +	int ret;
> +
> +	ctx =3D devm_drm_panel_alloc(dev, struct lg35583, panel,
> &lg35583_funcs,
> +				=C2=A0=C2=A0 DRM_MODE_CONNECTOR_DPI);
> +	if (IS_ERR(ctx))
> +		return PTR_ERR(ctx);
> +
> +	ctx->spi =3D spi;
> +	spi_set_drvdata(spi, ctx);
> +
> +	spi->bits_per_word =3D 16;
> +	ret =3D spi_setup(spi);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "Unable to set up SPI\n");
> +
> +	ctx->vcc =3D devm_regulator_get(dev, "vcc");
> +	if (IS_ERR(ctx->vcc))
> +		return dev_err_probe(dev, PTR_ERR(ctx->vcc), "Unable to get
> vcc\n");
> +
> +	ctx->vccio =3D devm_regulator_get(dev, "vccio");
> +	if (IS_ERR(ctx->vccio))
> +		return dev_err_probe(dev, PTR_ERR(ctx->vccio), "Unable to get
> vccio\n");
> +
> +	/*
> +	 * Deasserted, which keeps a panel the boot loader left on as it is,
> but
> +	 * as an output: after a reset the pin is an input, and prepare's
> reset
> +	 * pulse would never reach the panel.
> +	 */
> +	ctx->reset =3D devm_gpiod_get(dev, "reset", GPIOD_OUT_LOW);
> +	if (IS_ERR(ctx->reset))
> +		return dev_err_probe(dev, PTR_ERR(ctx->reset), "Unable to get
> reset\n");
> +
> +	ret =3D drm_panel_of_backlight(&ctx->panel);
> +	if (ret)
> +		return ret;
> +
> +	drm_panel_add(&ctx->panel);
> +	return 0;
> +}
> +
> +static void lg35583_remove(struct spi_device *spi)
> +{
> +	struct lg35583 *ctx =3D spi_get_drvdata(spi);
> +
> +	drm_panel_remove(&ctx->panel);
> +}
> +
> +static const struct of_device_id lg35583_of_match[] =3D {
> +	{ .compatible =3D "hiby,lg35583" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(of, lg35583_of_match);
> +
> +static const struct spi_device_id lg35583_ids[] =3D {
> +	{ "lg35583" },
> +	{ }
> +};
> +MODULE_DEVICE_TABLE(spi, lg35583_ids);
> +
> +static struct spi_driver lg35583_driver =3D {
> +	.probe =3D lg35583_probe,
> +	.remove =3D lg35583_remove,
> +	.id_table =3D lg35583_ids,
> +	.driver =3D {
> +		.name =3D "panel-hiby-lg35583",
> +		.of_match_table =3D lg35583_of_match,
> +	},
> +};
> +module_spi_driver(lg35583_driver);
> +
> +MODULE_AUTHOR("Olivier Louvignes <olivier@mgcrea.io>");
> +MODULE_DESCRIPTION("HiBy R1 LG35583 panel driver");
> +MODULE_LICENSE("GPL");
