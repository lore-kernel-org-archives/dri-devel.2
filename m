Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6F89EC53219
	for <dri-devel@archiver.kernel.org>; Tue, 28 Jul 2026 11:01:59 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A479210E539;
	Tue, 28 Jul 2026 11:01:58 +0000 (UTC)
Received: from mx1.white.stw.pengutronix.de (mx1.white.stw.pengutronix.de
 [185.203.200.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 90E3610E539
 for <dri-devel@lists.freedesktop.org>; Tue, 28 Jul 2026 11:01:57 +0000 (UTC)
Received: from drehscheibe.grey.stw.pengutronix.de
 (drehscheibe.grey.stw.pengutronix.de [IPv6:2a0a:edc0:0:c01:1d::a2])
 (Authenticated sender: relay-from-drehscheibe.grey.stw.pengutronix.de)
 by mx1.white.stw.pengutronix.de (Postfix) with ESMTPSA id E41FF202A8B;
 Tue, 28 Jul 2026 13:01:50 +0200 (CEST)
Received: from lupine.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::4e]
 helo=lupine)
 by drehscheibe.grey.stw.pengutronix.de with esmtps (TLS1.3) tls
 TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384 (Exim 4.96)
 (envelope-from <p.zabel@pengutronix.de>) id 1wofZG-001i2l-2i;
 Tue, 28 Jul 2026 13:01:50 +0200
Received: from pza by lupine with local (Exim 4.98.2)
 (envelope-from <p.zabel@pengutronix.de>) id 1wofZG-000000008pp-2yjt;
 Tue, 28 Jul 2026 13:01:50 +0200
Message-ID: <6ff452366cc35b4c97f7d7d4f0fff902095e3d49.camel@pengutronix.de>
Subject: Re: [PATCH v6 2/2] drm/bridge: add support for lontium lt9211c bridge
From: Philipp Zabel <p.zabel@pengutronix.de>
To: vishnu.saini@oss.qualcomm.com, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Laurent Pinchart	 <Laurent.pinchart@ideasonboard.com>, Jonas Karlman
 <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, Luca Ceresoli
 <luca.ceresoli@bootlin.com>, Maarten Lankhorst	
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring	 <robh@kernel.org>, Krzysztof
 Kozlowski <krzk+dt@kernel.org>, Conor Dooley	 <conor+dt@kernel.org>, Marek
 Vasut <marex@denx.de>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Yi Zhang <zhanyi@qti.qualcomm.com>, Nilesh
 Laad	 <nilesh.laad@oss.qualcomm.com>, Gopi Botlagunta	
 <venkata.botlagunta@oss.qualcomm.com>, venkata.valluru@oss.qualcomm.com, 
 Jessica Zhang <jesszhan0024@gmail.com>
Date: Tue, 28 Jul 2026 13:01:50 +0200
In-Reply-To: <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
References: <20260719-add-lt9211c-bridge-v6-0-e56d22152586@oss.qualcomm.com>
 <20260719-add-lt9211c-bridge-v6-2-e56d22152586@oss.qualcomm.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.56.2-0+deb13u1 
MIME-Version: 1.0
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
Errors-To: dri-devel-bounces@lists.freedesktop.org
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>

On So, 2026-07-19 at 21:27 +0530, vishnu.saini@oss.qualcomm.com wrote:
> From: Yi Zhang <zhanyi@qti.qualcomm.com>
>=20
> LT9211C is a Single/Dual-Link DSI/LVDS or Single DPI input to
> Single-Link/Dual-Link DSI/LVDS or Single DPI output bridge chip.
> Extend the existing lontium-lt9211 driver to support DSI-to-LVDS
> bridge configuration by detecting and handling both LT9211 and LT9211C
> variants from a single driver.
>=20
> Chip detection in lt9211_read_chipid() is extended to identify the
> LT9211C by its distinct chip ID registers.
>
> A separate regmap configuration is introduced for LT9211C to cover
> its extended register map. The chip_type field added to struct lt9211
> selects the appropriate regmap and code paths at probe time using
> of_device_is_compatible().

This could be done via device match data instead.


[...]
> The LT9211C requires DSI clocks to be running before the bridge can
> be initialised,

Is this different from LT9211?

> so lt9211_atomic_enable() queues
> a delayed workqueue item for LT9211C rather than initialising
> synchronously as LT9211 does.

How does this follow? Isn't the DSI clock already enabled before
atomic_enable is called?

If the initialization is deferred to a delayed work item, we can't
correctly enable downstream LVDS panels that require a few frames of
valid LVDS signal before enabling the panel or backlight. This must be
synchronous to work correctly.

> LT9211C uses VIDEO|LPM DSI mode flags, which differ from the
> sync-pulse mode used by LT9211.
>=20
> Signed-off-by: Yi Zhang <zhanyi@qti.qualcomm.com>
> Signed-off-by: Nilesh Laad <nilesh.laad@oss.qualcomm.com>
> Signed-off-by: Gopi Botlagunta <venkata.botlagunta@oss.qualcomm.com>
> Signed-off-by: Vishnu Saini <vishnu.saini@oss.qualcomm.com>
> ---
>  drivers/gpu/drm/bridge/lontium-lt9211.c | 796 ++++++++++++++++++++++++++=
+++++-
>  1 file changed, 779 insertions(+), 17 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/bridge/lontium-lt9211.c b/drivers/gpu/drm/br=
idge/lontium-lt9211.c
> index f39d83a5ae37..36c004df34fc 100644
> --- a/drivers/gpu/drm/bridge/lontium-lt9211.c
> +++ b/drivers/gpu/drm/bridge/lontium-lt9211.c
> @@ -19,6 +19,7 @@
>  #include <linux/of_graph.h>
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
> +#include <linux/workqueue.h>
> =20
>  #include <drm/drm_atomic_helper.h>
>  #include <drm/drm_bridge.h>
> @@ -36,10 +37,21 @@
>  #define REG_CHIPID2				0x8102
>  #define REG_CHIPID2_VALUE			0xe3
> =20
> +/* LT9211C chip ID values */
> +#define REG_CHIPID0_LT9211C_VALUE		0x21
> +#define REG_CHIPID1_LT9211C_VALUE		0x03
> +#define REG_CHIPID2_LT9211C_VALUE		0xe1
> +
>  #define REG_DSI_LANE				0xd000
>  /* DSI lane count - 0 means 4 lanes ; 1, 2, 3 means 1, 2, 3 lanes. */
>  #define REG_DSI_LANE_COUNT(n)			((n) & 3)
> =20
> +/* Chip type enum */
> +enum lt9211_chip_type {
> +	LT9211,
> +	LT9211C,
> +};
> +
>  struct lt9211 {
>  	struct drm_bridge		bridge;
>  	struct device			*dev;
> @@ -50,6 +62,14 @@ struct lt9211 {
>  	struct regulator		*vccio;
>  	bool				lvds_dual_link;
>  	bool				lvds_dual_link_even_odd_swap;
> +	/* LT9211C specific fields */

This isn't LT9211C specific:

> +	enum lt9211_chip_type		chip_type;

These won't be needed if the delayed work is dropped:

> +	struct workqueue_struct		*wq;
> +	struct delayed_work		lt9211_dw;
> +	struct drm_display_mode		mode;
> +	bool				bpp24;
> +	bool				jeida;
> +	bool				de;
>  };
> =20
>  static const struct regmap_range lt9211_rw_ranges[] =3D {
> @@ -93,6 +113,49 @@ static const struct regmap_config lt9211_regmap_confi=
g =3D {
>  	.max_register =3D 0xda00,
>  };
> =20
> +static const struct regmap_range lt9211c_rw_ranges[] =3D {
> +	regmap_reg_range(0xff, 0xff),
> +	regmap_reg_range(0x8100, 0x8182),
> +	regmap_reg_range(0x8200, 0x82aa),
> +	regmap_reg_range(0x8500, 0x85ff),
> +	regmap_reg_range(0x8600, 0x86a0),
> +	regmap_reg_range(0x8700, 0x8746),
> +	regmap_reg_range(0xd000, 0xd0a7),
> +	regmap_reg_range(0xd400, 0xd42c),
> +	regmap_reg_range(0xd800, 0xd838),
> +	regmap_reg_range(0xd9c0, 0xd9d5),
> +};
> +
> +static const struct regmap_access_table lt9211c_rw_table =3D {
> +	.yes_ranges =3D lt9211c_rw_ranges,
> +	.n_yes_ranges =3D ARRAY_SIZE(lt9211c_rw_ranges),
> +};
> +
> +static const struct regmap_range_cfg lt9211c_range =3D {
> +	.name =3D "lt9211c",
> +	.range_min =3D 0x0000,
> +	.range_max =3D 0xda00,
> +	.selector_reg =3D REG_PAGE_CONTROL,
> +	.selector_mask =3D 0xff,
> +	.selector_shift =3D 0,
> +	.window_start =3D 0,
> +	.window_len =3D 0x100,
> +};
> +
> +static const struct regmap_config lt9211c_regmap_config =3D {
> +	.reg_bits =3D 8,
> +	.val_bits =3D 8,
> +	.rd_table =3D &lt9211c_rw_table,
> +	.wr_table =3D &lt9211c_rw_table,
> +	.volatile_table =3D &lt9211c_rw_table,
> +	.ranges =3D &lt9211c_range,
> +	.num_ranges =3D 1,
> +	.cache_type =3D REGCACHE_RBTREE,

Don't use REGCACHE_RBTREE without a good reason, current default is
REGCACHE_MAPLE. But... if all RW registers are also marked volatile,
the cache is useless. So, REGCACHE_NONE?
Do you know anything about which registers may or may not be volatile?

[...]
> @@ -454,6 +526,651 @@ static int lt9211_configure_tx(struct lt9211 *ctx, =
bool jeida,
>  	return 0;
>  }
> =20
> +static int lt9211c_configure_rx(struct lt9211 *ctx)
> +{
> +	unsigned int pval;
>=20
[...]
> +	ret =3D regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_seq,
> +				     ARRAY_SIZE(lt9211c_rx_phy_seq));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_multi_reg_write(ctx->regmap, lt9211c_rx_phy_reset_seq,
> +				     ARRAY_SIZE(lt9211c_rx_phy_reset_seq));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_multi_reg_write(ctx->regmap, lt9211c_rx_clk_sel_seq,
> +				     ARRAY_SIZE(lt9211c_rx_clk_sel_seq));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read(ctx->regmap, 0x8180, &pval);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(ctx->regmap, 0x8180, ((pval & 0xfc) | 0x03));
> +	if (ret)
> +		return ret;

These two are

	ret =3D regmap_write_bits(ctx->regmap, 0x8180, 0x3, 0x3);

or even

	ret =3D regmap_set_bits(ctx->regmap, 0x8180, 0x3);

[...]
> +	ret =3D regmap_read(ctx->regmap, 0x8530, &pval);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(ctx->regmap, 0x8530, ((pval & 0xf8) | 0x11));
> +	if (ret)
> +		return ret;

Not masking out bit 0x10 and then setting it is unusual. Was ((pval &
0xe8) | 0x11) meant here?

This corresponds to:

	ret =3D regmap_write_bits(ctx->regmap, 0x8530, 0x17, 0x11);

> +
> +	ret =3D regmap_multi_reg_write(ctx->regmap, lt9211c_rx_input_sel_seq,
> +				     ARRAY_SIZE(lt9211c_rx_input_sel_seq));
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_multi_reg_write(ctx->regmap, lt9211c_rx_dig_seq,
> +				     ARRAY_SIZE(lt9211c_rx_dig_seq));
> +	if (ret)
> +		return ret;
> +
> +	/* Give the chip time to lock onto RX stream. */
> +	msleep(100);

Is there any status register that could be polled to see if the lock
happened earlier?

> +
> +	return 0;
> +}
> +
> +static int lt9211c_autodetect_rx(struct lt9211 *ctx,
> +				 const struct drm_display_mode *mode)
> +{
> +	u16 width, height;
> +	u8 buf[5];
> +	u8 format;
> +	u8 sot[8];
> +	int ret;
> +
> +	/* Read the SOT from the chip. */
> +	ret =3D regmap_bulk_read(ctx->regmap, 0xd088, sot, sizeof(sot));
> +	if (ret)
> +		return ret;
> +
> +	dev_dbg(ctx->dev, "Sot Num =3D 0x%02x, 0x%02x, 0x%02x, 0x%02x\n", sot[0=
],
> +		sot[2], sot[4], sot[6]);
> +
> +	dev_dbg(ctx->dev, "Sot Data =3D 0x%02x, 0x%02x, 0x%02x, 0x%02x\n", sot[=
1],
> +		sot[3], sot[5], sot[7]);
> +	/* HS Settle Set */
> +	if (sot[0] > 0x10 && sot[0] < 0x50)
> +		regmap_write(ctx->regmap, 0xd002, sot[0] - 5);
> +	else
> +		regmap_write(ctx->regmap, 0xd002, 0x08);

You could prepare the value then call regmap_write() once.

[...]
> +static int lt9211c_configure_timing(struct lt9211 *ctx,
> +				    const struct drm_display_mode *mode)
> +{
> +	const struct reg_sequence lt9211c_timing[] =3D {
> +		{ 0xd00d, (mode->vtotal >> 8) & 0xff },
> +		{ 0xd00e, mode->vtotal & 0xff },
> +		{ 0xd00f, (mode->vdisplay >> 8) & 0xff },
> +		{ 0xd010, mode->vdisplay & 0xff },
> +		{ 0xd011, (mode->htotal >> 8) & 0xff },
> +		{ 0xd012, mode->htotal & 0xff },
> +		{ 0xd013, (mode->hdisplay >> 8) & 0xff },
> +		{ 0xd014, mode->hdisplay & 0xff },
> +		{ 0xd015, (mode->vsync_end - mode->vsync_start) & 0xff },
> +		{ 0xd04c, ((mode->hsync_end - mode->hsync_start) >> 8) & 0xff },

Apart from 16-bit hsync_len this is identical to
lt9211_configure_timing, maybe that could be reused.

> +		{ 0xd016, (mode->hsync_end - mode->hsync_start) & 0xff },
> +		{ 0xd017, ((mode->vsync_start - mode->vdisplay) >> 8) & 0xff },
> +		{ 0xd018, (mode->vsync_start - mode->vdisplay) & 0xff },
> +		{ 0xd019, ((mode->hsync_start - mode->hdisplay) >> 8) & 0xff },
> +		{ 0xd01a, (mode->hsync_start - mode->hdisplay) & 0xff },
> +	};
> +
> +	return regmap_multi_reg_write(ctx->regmap, lt9211c_timing,
> +				      ARRAY_SIZE(lt9211c_timing));
> +}
> +
> +static int lt9211c_configure_plls(struct lt9211 *ctx,
> +				  const struct drm_display_mode *mode)
> +{
[...]
> +	if (mode->clock < 22000) {
> +		ret =3D regmap_write(ctx->regmap, 0x822f, 0x07);
> +		ret |=3D regmap_write(ctx->regmap, 0x822c, 0x01);

0x822c is never cleared in the other branches. Would it be possible to
enable with a mode clock < 22000 and then disable and enable with a
mode clock >=3D 22000 but < 44000, ending up with 0x822c still containing
0x01 ?

> +		div =3D 16;
> +	} else if (mode->clock < 44000) {
> +		ret =3D regmap_write(ctx->regmap, 0x822f, 0x07);
> +		div =3D 16;
> +	} else if (mode->clock < 88000) {
> +		ret =3D regmap_write(ctx->regmap, 0x822f, 0x06);
> +		div =3D 8;
> +	} else if (mode->clock < 176000) {
> +		ret =3D regmap_write(ctx->regmap, 0x822f, 0x05);
> +		div =3D 4;
> +	} else {
> +		ret =3D regmap_write(ctx->regmap, 0x822f, 0x04);
> +		div =3D 2;
> +	}
> +
> +	if (ret)
> +		return ret;
> +
> +	pcr_m =3D (mode->clock * div) / 25;
> +	pcr_k =3D pcr_m % 1000;
> +	pcr_m /=3D 1000;
> +
> +	pcr_up =3D pcr_m + 1;
> +	pcr_down =3D pcr_m - 1;
> +
> +	pcr_k <<=3D 14;
> +
> +	ret =3D regmap_write(ctx->regmap, 0xd008, 0x00);
> +	if (ret < 0)
> +		return ret;
> +
> +	/* 0xd026: pcr_m */
> +	ret =3D regmap_write(ctx->regmap, 0xd026, (0x80 | (u8)pcr_m) & 0x7f);

Why set bit 0x80 only to clear it right away?

> +	if (ret < 0)
> +		return ret;
> +
> +	/* 0xd027 0xd028 0xd029: pcr_k */
> +	ret =3D regmap_write(ctx->regmap, 0xd027, (pcr_k >> 16) & 0xff);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_write(ctx->regmap, 0xd028, (pcr_k >> 8) & 0xff);
> +	if (ret < 0)
> +		return ret;
> +
> +	ret =3D regmap_write(ctx->regmap, 0xd029, pcr_k & 0xff);

This always writes 0 because of the pcr_k <<=3D 14 above.

[...]
> +	if (mode->clock < 44000) {
> +		ret =3D regmap_write(ctx->regmap, 0xd00c, 0x60);
> +		ret |=3D regmap_write(ctx->regmap, 0xd01b, 0x00);
> +		ret |=3D regmap_write(ctx->regmap, 0xd01c, 0x60);

The sashiko bot correctly complained about this. Please fix the error
handling.

> +	} else {
> +		ret =3D regmap_write(ctx->regmap, 0xd00c, 0x40);
> +		ret |=3D regmap_write(ctx->regmap, 0xd01b, 0x00);
> +		ret |=3D regmap_write(ctx->regmap, 0xd01c, 0x40);

Same as above, you could prepare the 0x60 / 0x40 value in a variable
and only call one set of regmap_write()s.

> +	}
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_multi_reg_write(ctx->regmap, lt9211c_pcr_reset_seq,
> +				     ARRAY_SIZE(lt9211c_pcr_reset_seq));
> +	if (ret)
> +		return ret;
> +
> +	/* PCR stability test takes seconds. */
> +	ret =3D regmap_read_poll_timeout(ctx->regmap, 0xd087, pval,
> +				       ((pval & 0x18) =3D=3D 0x18), 20000, 3000000);
> +	if (ret)
> +		dev_err(ctx->dev, "PCR unstable, ret=3D%i\n", ret);
> +
> +	ret =3D regmap_write(ctx->regmap, 0x8180, 0x51);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(ctx->regmap, 0x863f, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(ctx->regmap, 0x863f, 0x01);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_read_poll_timeout(ctx->regmap, 0x8640, pval,
> +				       ((pval & 0x01) =3D=3D 0x01), 50000, 250000);
> +	if (ret)
> +		dev_err(ctx->dev, "Video check not stable, ret=3D%i\n", ret);
> +
> +	return ret;
> +}
> +
> +static int lt9211c_configure_tx(struct lt9211 *ctx,
> +				const struct drm_display_mode *mode)
> +{
[...]
> +	ret =3D regmap_read(ctx->regmap, 0x8530, &pval);
> +	if (ret)
> +		return ret;
> +
> +	ret =3D regmap_write(ctx->regmap, 0x8530, ((pval & 0x3f) | 0x40));
> +	if (ret)
> +		return ret;

	ret =3D regmap_write_bits(ctx->regmap, 0x8530, 0xc0, 0x40);

> +
> +	/* [7]0:txpll normal work; txpll ref clk sel pix clk */
> +	ret =3D regmap_write(ctx->regmap, 0x8230, 0x00);
> +	if (ret)
> +		return ret;
> +
> +	if (ctx->lvds_dual_link)
> +		phy_clk =3D (u32)(mode->clock * 7 / 2);
> +	else
> +		phy_clk =3D (u32)(mode->clock * 7);
> +
> +	/* 0x8231: prediv sel */
> +	if (mode->clock < 20000) {
> +		val =3D 0x28;
> +		pre_div =3D 1;

Is this case the same as ...

> +	} else if (mode->clock < 40000) {
> +		val =3D 0x28;
> +		pre_div =3D 1;

.. this case on purpose? If so, why not merge the branches.

> +	} else if (mode->clock < 80000) {
> +		val =3D 0x29;
> +		pre_div =3D 2;
> +	} else if (mode->clock < 160000) {
> +		val =3D 0x2a;
> +		pre_div =3D 4;
> +	} else if (mode->clock < 320000) {
> +		val =3D 0x2b;
> +		pre_div =3D 8;
> +	} else {
> +		val =3D 0x2f;
> +		pre_div =3D 16;
> +	}
> +	ret =3D regmap_write(ctx->regmap, 0x8231, val);
> +	if (ret < 0)
> +		return ret;
> +
[...]
> +
> +	return 0;
> +}
> +
> +static void lt9211_delayed_work_func(struct work_struct *work)
> +{
> +	struct delayed_work *dw =3D to_delayed_work(work);
> +	struct lt9211 *ctx =3D container_of(dw, struct lt9211, lt9211_dw);
> +	const struct drm_display_mode *mode =3D &ctx->mode;
> +	int ret;
> +
> +	if (ctx->chip_type !=3D LT9211C) {
> +		dev_err(ctx->dev, "LT9211: Delayed work called for non-LT9211C chip\n"=
);
> +		return;
> +	}
> +
> +	ret =3D lt9211c_configure_rx(ctx);
> +	if (ret)
> +		return;
> +
> +	ret =3D lt9211c_autodetect_rx(ctx, mode);
> +	if (ret)
> +		return;
> +
> +	ret =3D lt9211c_configure_timing(ctx, mode);
> +	if (ret)
> +		return;
> +
> +	ret =3D lt9211c_configure_plls(ctx, mode);
> +	if (ret)
> +		return;
> +
> +	ret =3D lt9211c_configure_tx(ctx, mode);
> +	if (ret)
> +		return;
> +}
> +
>  static void lt9211_atomic_enable(struct drm_bridge *bridge,
>  				 struct drm_atomic_commit *state)
>  {
> @@ -523,6 +1240,15 @@ static void lt9211_atomic_enable(struct drm_bridge =
*bridge,
>  	if (ret)
>  		return;
> =20
> +	if (ctx->chip_type =3D=3D LT9211C && ctx->wq) {
> +		drm_mode_copy(&ctx->mode, mode);
> +		/* LT9211C must enable after mipi clock enable */
> +		queue_delayed_work(ctx->wq, &ctx->lt9211_dw,
> +				   msecs_to_jiffies(100));

Why is this deferred to a delayed work item?
Can't we just wait here and run all the initialization synchronously?

As the sashiko bot points out, this calls the delayed work function
without initializing ctx->jeida, ctx->bpp24 and ctx->de, and both
atomic_disable and driver remove are missing some kind of
cancel_delayed_work_sync().
Further, with the delayed initialization it is impossible to correctly
enable downstream bridges or panels that require an active LVDS signal
before (post)enabling.
All of this wouldn't be a problem if the initialization was done
synchronously.

> +		dev_dbg(ctx->dev, "LT9211C enabled.\n");
> +		return;
> +	}
> +
>  	ret =3D lt9211_system_init(ctx);
>  	if (ret)
>  		return;
> @@ -671,11 +1397,6 @@ static int lt9211_parse_dt(struct lt9211 *ctx)
> =20
>  static int lt9211_host_attach(struct lt9211 *ctx)
>  {
> -	const struct mipi_dsi_device_info info =3D {
> -		.type =3D "lt9211",
> -		.channel =3D 0,
> -		.node =3D NULL,
> -	};
>  	struct device *dev =3D ctx->dev;
>  	struct device_node *host_node;
>  	struct device_node *endpoint;
> @@ -697,7 +1418,22 @@ static int lt9211_host_attach(struct lt9211 *ctx)
>  	if (dsi_lanes < 0)
>  		return dsi_lanes;
> =20
> -	dsi =3D devm_mipi_dsi_device_register_full(dev, host, &info);
> +	if (ctx->chip_type =3D=3D LT9211C) {
> +		const struct mipi_dsi_device_info info =3D {
> +			.type =3D "lt9211c",
> +			.channel =3D 0,
> +			.node =3D NULL,
> +		};

Moving mipi_dsi_device_info into device match data would allow to get
rid of the branching here.

> +		dsi =3D devm_mipi_dsi_device_register_full(dev, host, &info);
> +	} else {
> +		const struct mipi_dsi_device_info info =3D {
> +			.type =3D "lt9211",
> +			.channel =3D 0,
> +			.node =3D NULL,
> +		};
> +		dsi =3D devm_mipi_dsi_device_register_full(dev, host, &info);
> +	}
> +
>  	if (IS_ERR(dsi))
>  		return dev_err_probe(dev, PTR_ERR(dsi),
>  				     "failed to create dsi device\n");
> @@ -706,10 +1442,16 @@ static int lt9211_host_attach(struct lt9211 *ctx)
> =20
>  	dsi->lanes =3D dsi_lanes;
>  	dsi->format =3D MIPI_DSI_FMT_RGB888;
> -	dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULS=
E |
> -			  MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
> -			  MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> -			  MIPI_DSI_MODE_NO_EOT_PACKET;
> +
> +	if (ctx->chip_type =3D=3D LT9211C) {
> +		dsi->mode_flags =3D MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_LPM;

This could also be stored in device match data.

> +	} else {
> +		dsi->mode_flags =3D
> +			MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +			MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_MODE_VIDEO_NO_HSA |
> +			MIPI_DSI_MODE_VIDEO_NO_HFP | MIPI_DSI_MODE_VIDEO_NO_HBP |
> +			MIPI_DSI_MODE_NO_EOT_PACKET;
> +	}
> =20
>  	ret =3D devm_mipi_dsi_attach(dev, dsi);
>  	if (ret < 0) {
> @@ -747,10 +1489,25 @@ static int lt9211_probe(struct i2c_client *client)
>  	if (ret)
>  		return ret;
> =20
> -	ctx->regmap =3D devm_regmap_init_i2c(client, &lt9211_regmap_config);
> +	if (of_device_is_compatible(dev->of_node, "lontium,lt9211c")) {
> +		ctx->chip_type =3D LT9211C;
> +		ctx->regmap =3D
> +			devm_regmap_init_i2c(client, &lt9211c_regmap_config);

The branching here could be avoided by getting regmap config from
device match data (e.g. via i2c_get_match_data from lt9211_id or
lt9211_match_table).

> +	} else {
> +		ctx->chip_type =3D LT9211;
> +		ctx->regmap =3D
> +			devm_regmap_init_i2c(client, &lt9211_regmap_config);
> +	}
>  	if (IS_ERR(ctx->regmap))
>  		return PTR_ERR(ctx->regmap);
> =20
> +	if (ctx->chip_type =3D=3D LT9211C) {
> +		ctx->wq =3D create_workqueue("lt9211_work");
> +		if (!ctx->wq)
> +			return -ENOMEM;
> +		INIT_DELAYED_WORK(&ctx->lt9211_dw, lt9211_delayed_work_func);
> +	}

I think this should be dropped.

> +
>  	dev_set_drvdata(dev, ctx);
>  	i2c_set_clientdata(client, ctx);

Not your addition, but these two calls to the same thing.
This could be dropped with the lt9211_remove function by
switching to devm_drm_bridge_add().


regards
Philipp
