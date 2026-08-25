Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2641DC61DBE
	for <dri-devel@archiver.kernel.org>; Tue, 25 Aug 2026 14:09:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 569F810EA6F;
	Tue, 25 Aug 2026 14:09:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="bDI5BfZp";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DCA8010EA62
 for <dri-devel@lists.freedesktop.org>; Tue, 25 Aug 2026 14:09:47 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3C02D4E413AC;
 Tue, 25 Aug 2026 14:09:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 06C2B604C4;
 Tue, 25 Aug 2026 14:09:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EB53311C7A51E; 
 Tue, 25 Aug 2026 16:09:28 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1787666983; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Y9Ay1jCG5V4z/nDKF7jUeRZBXyQ6nU57WodpGtYcotU=;
 b=bDI5BfZpDqSdlgxutBHR2irzP9EIAkrLk83g2edRulOEil+cdXWwquCb8l5+6WyyBloizU
 zQR/366w0uW7ZBZagmIQLjV9nE1UZwcdp33ZZdhONVx3r5r4ggEEnHs7GLtuEsGvdryoRM
 pDH1P5YGYAn25rTffR0y8jxQmJWGXOkope5HhhaDZsbcfXrSjQYSXy7U1dOl/xQtLWIqLD
 hDCQ3Iie7JYqDXmIF6lYcorf41eqByrRoW5OAbUd7fBfuANnIYJpQ696SgHlHXeHW4ljv0
 BI2zZad/3H34eReb+O7jmXO8FerrRBTz8aYhJobQtkfyv9YDLbeUZ7z3AD3KiQ==
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v11 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: mohit.dsor@oss.qualcomm.com
Cc: Sunyun Yang <syyang@lontium.com>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, venkata.valluru@oss.qualcomm.com, 
 Jessica Zhang <jesszhan0024@gmail.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
In-Reply-To: <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
References: <20260824-lt9611c-v7-v11-0-eb4a79cb597c@oss.qualcomm.com>
 <20260824-lt9611c-v7-v11-2-eb4a79cb597c@oss.qualcomm.com>
Date: Tue, 25 Aug 2026 16:09:20 +0200
Message-Id: <178766696083.117435.16339828039068931624.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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

Hello Mohit,

> LT9611C(EX/UXD) is an I2C-controlled chip that Receiver signal/dual port
> mipi dsi and output hdmi, differences in hardware features:
>
> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>

Looks good overall, but I have various small improvements to suggest, see
below.

Additionally, can you have a look at the issues reported by Sashiko and
reply stating whether you think they are relevant (and they should be
fixed) or not relevant (and why)?

> --- a/drivers/gpu/drm/bridge/Kconfig
> +++ b/drivers/gpu/drm/bridge/Kconfig
> @@ -177,6 +177,24 @@ config DRM_LONTIUM_LT9611
>  	  HDMI signals
>  	  Please say Y if you have such hardware.
>
> +config DRM_LONTIUM_LT9611C
> +	tristate "Lontium LT9611C DSI/HDMI bridge"
> +	select SND_SOC_HDMI_CODEC if SND_SOC
> +	depends on OF && I2C
> +	select CRC8
> +	select FW_LOADER
> +	select DRM_PANEL_BRIDGE

I don't think the code in this revision uses the DRM_PANEL_BRIDGE API.

> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> @@ -0,0 +1,1283 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> + * Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries.
                 ^
		 Nit: both 'C' uppercase

> +#include <linux/crc8.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/media-bus-format.h>
> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_graph.h>
> +#include <linux/platform_device.h>

Unused include?

> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <linux/unaligned.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_connector.h>
> +#include <drm/drm_drv.h>

Unused include?

> +#include <drm/drm_edid.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_of.h>

Unused include?

> +#include <drm/drm_print.h>

Unused include?

> +#include <drm/drm_probe_helper.h>
> +#include <drm/display/drm_hdmi_audio_helper.h>
> +#include <drm/display/drm_hdmi_state_helper.h>
> +#include <sound/hdmi-codec.h>
> +
> +#define FW_SIZE (64 * 1024)
> +#define LT_PAGE_SIZE 256
> +#define FW_FILE  "Lontium/lt9611c_fw.bin"
> +#define LT9611C_CRC_POLYNOMIAL 0x31
> +#define LT9611C_PAGE_CONTROL 0xff
> +#define LT9611C_INFOFRAME_MAX_SIZE 32
> +#define LT9611C_CMD_HDR_SIZE 4
> +#define LT9611C_CMD_Y0_SIZE  1  /* Y0 echo byte in ACK response */
> +#define LT9611C_EDID_BUF_SIZE 32
> +
> +struct lt9611c_cmd_hdr {
> +	u8 func;
> +	u8 type;
> +	u8 seq;
> +	u8 sep;
> +};
> +
> +/* lt9611c_cmd_hdr.func values */
> +#define LT9611C_FUNC_WRITE	0x57 /* 'W' */
> +#define LT9611C_FUNC_READ	0x52 /* 'R' */
> +#define LT9611C_FUNC_ACK	0x41 /* 'A' */
> +
> +/* lt9611c_cmd_hdr.type values */
> +#define LT9611C_TYPE_MIPI	0x4d /* 'M' */
> +#define LT9611C_TYPE_LVDS	0x4c /* 'L' */
> +#define LT9611C_TYPE_HDMI	0x48 /* 'H' */
> +#define LT9611C_TYPE_AUDIO	0x41 /* 'A' */
> +#define LT9611C_TYPE_CUSTOM	0x43 /* 'C' */
> +
> +/* lt9611c_cmd_hdr.sep is always ':' */
> +#define LT9611C_CMD_SEP		0x3a /* ':' */
> +
> +struct lt9611c_cmd {
> +	struct lt9611c_cmd_hdr hdr;
> +	const u8 *data;
> +	size_t data_len;
> +};
> +
> +struct lt9611c_rsp {
> +	struct lt9611c_cmd_hdr hdr;
> +	u8 *data;
> +	unsigned int data_len;
> +};
> +
> +enum lt9611_chip_type {
> +	CHIP_LT9611C = 0,
> +	CHIP_LT9611EX,
> +	CHIP_LT9611UXD,
> +};
> +
> +struct lt9611c_chip_data {
> +	enum lt9611_chip_type chip_type;
> +	unsigned long long max_tmds_rate;
> +};
> +
> +static const struct lt9611c_chip_data lt9611c_chip_data[] = {
> +	[CHIP_LT9611C]   = { CHIP_LT9611C,   340000000 },
> +	[CHIP_LT9611EX]  = { CHIP_LT9611EX,  340000000 },
> +	[CHIP_LT9611UXD] = { CHIP_LT9611UXD, 600000000 },
> +};
> +
> +struct lt9611c {
> +	struct device *dev;
> +	struct i2c_client *client;
> +	struct drm_bridge bridge;
> +	struct regmap *regmap;
> +	struct mutex mcu_lock;
> +	struct work_struct work;
> +	struct device_node *dsi0_node;
> +	struct device_node *dsi1_node;

These two device_nodes are unused after probe finishes, so storing them for
the entire device lifetime is unnecessary. You could make
lt9611c_parse_dt() return them to lt9611c_probe(), taking care of putting
them correctly.

While that, consider using

  struct device_node __free(device_node) dsi0_node = ...;

instead of

  struct device_node dsi0_node;
  ...
  dsi0_node = ...;
  ...
  of_node_put(dsi0_node);

when applicable

> +	struct mipi_dsi_device *dsi0;
> +	struct mipi_dsi_device *dsi1;

And these two are never used outside of lt9611c_probe(). Make them
temporary variables in lt9611c_probe().

> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data supplies[2];
> +	int fw_version;
> +	/* Chip variant: C/EX/UXD */
> +	enum lt9611_chip_type chip_type;
> +	unsigned long long max_tmds_rate;

Why storing a copy of these two? You can just store the 'const struct
lt9611c_chip_data *' returned by i2c_get_match_data(), which points to an
entry in the static i2c_get_match_data[], and use it to fetch the
model-specific info. As a bonus this will also be future-proof in case more
fields are added to struct lt9611c_chip_data in the future.

> +static int lt9611c_write_data(struct lt9611c *lt9611c, const struct firmware *fw, size_t addr)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	unsigned int page = 0, num = 0, i = 0;

No need to initialize these variables, they are set before reading.

> +	size_t size, index;
> +	const u8 *data;
> +	u8 value;
> +
> +	data = fw->data;
> +	size = fw->size;
> +	page = DIV_ROUND_UP(size, LT_PAGE_SIZE);

'page' really holds the number of pages, please rename to 'npages' or
'pages'.

> +	if (page * LT_PAGE_SIZE > FW_SIZE) {
> +		dev_err(dev, "firmware size out of range\n");
> +		return -EINVAL;
> +	}
> +
> +	dev_dbg(dev, "%u pages, total size %zu byte\n", page, size);
> +
> +	for (num = 0; num < page; num++) {

Some variables (i, ret, value, maybe others?) are only used inside the
loop, move their declaration inside the loop.

> +		lt9611c_data_to_sram(lt9611c);
> +
> +		for (i = 0; i < LT_PAGE_SIZE; i++) {
> +			index = num * LT_PAGE_SIZE + i;
> +			value = (index < size) ? data[index] : 0xff;
> +
> +			ret = regmap_write(lt9611c->regmap, 0xe059, value);
> +			if (ret < 0) {
> +				dev_err(dev, "write error at page %u, index %u\n", num, i);
> +				return ret;
> +			}
> +		}
> +
> +		lt9611c_wren(lt9611c);
> +		lt9611c_sram_to_flash(lt9611c, addr);
> +
> +		addr += LT_PAGE_SIZE;
> +	}
> +
> +	lt9611c_wrdi(lt9611c);
> +
> +	return 0;
> +}

...

> +static int lt9611c_firmware_upgrade(struct lt9611c *lt9611c)
> +{
> +	struct device *dev = lt9611c->dev;
> +	const struct firmware *fw;
> +	u8 *buffer;
> +	size_t total_size = FW_SIZE - 1;
> +	u8 fw_crc;
> +	int ret;
> +
> +	/* load firmware — must happen outside the mcu_lock */

Ain't this obvious? I'd remove this comment line.

> +static irqreturn_t lt9611c_irq_thread_handler(int irq, void *dev_id)
> +{
> +	struct lt9611c *lt9611c = dev_id;
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	unsigned int irq_status;
> +
> +	guard(mutex)(&lt9611c->mcu_lock);
> +
> +	ret = regmap_read(lt9611c->regmap, 0xe084, &irq_status);
> +	if (ret) {
> +		dev_err(dev, "failed to read irq status: %d\n", ret);
> +		return IRQ_HANDLED;
> +	}
> +
> +	if (!(irq_status & BIT(0)))
> +		return IRQ_NONE;
> +
> +	/*Clear interrupt: hardware requires two writes with delay*/

Nit: space after '/*' and before '*/'.

Same in other places in this patch.

> +static int lt9611c_regulator_init(struct lt9611c *lt9611c)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +
> +	lt9611c->supplies[0].supply = "vcc";
> +	lt9611c->supplies[1].supply = "vdd";
> +
> +	ret = devm_regulator_bulk_get(dev, 2, lt9611c->supplies);
> +
> +	return ret;

Just:

   return devm_regulator_bulk_get(dev, 2, lt9611c->supplies);

and remove the 'ret' variable.

> +static int lt9611c_bridge_attach(struct drm_bridge *bridge,
> +				 struct drm_encoder *encoder,
> +				 enum drm_bridge_attach_flags flags)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);

I think it would be nice to ban the deprecated connector creation by adding
here:

    if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
	return -EINVAL;

and maybe log an error too. Look at other drivers which do this.

> +
> +	return drm_bridge_attach(encoder, lt9611c->bridge.next_bridge, bridge, flags);
> +}
> +
> +static enum drm_mode_status
> +lt9611c_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
                     ^^^^
Out of curiosity, what does "char" means here?

> +static void lt9611c_video_setup(struct lt9611c *lt9611c,
> +				const struct drm_display_mode *mode)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	u32 h_total, hactive, hsync_len, hfront_porch, hback_porch;
> +	u32 v_total, vactive, vsync_len, vfront_porch, vback_porch;
> +	u8 timing_data[22];
> +	struct lt9611c_rsp rsp = {};
> +	u8 framerate;
> +	u8 vic = 0x00;
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x33, LT9611C_CMD_SEP },
> +		.data = timing_data,
> +		.data_len = ARRAY_SIZE(timing_data),

Nit: sizeof(timing_data) would be more correct. It is equivalent here
because it's a u8 array, but as a general rule it's better to ensure you
catch the entire buffer size, not the amount of elements which in other
cases might be larger than 1 byte.

> +	};
> +
> +	guard(mutex)(&lt9611c->mcu_lock);
> +	h_total = mode->htotal;
> +	hactive = mode->hdisplay;
> +	hsync_len = mode->hsync_end - mode->hsync_start;
> +	hfront_porch = mode->hsync_start - mode->hdisplay;
> +	hback_porch = mode->htotal - mode->hsync_end;
> +
> +	v_total = mode->vtotal;
> +	vactive = mode->vdisplay;
> +	vsync_len = mode->vsync_end - mode->vsync_start;
> +	vfront_porch = mode->vsync_start - mode->vdisplay;
> +	vback_porch = mode->vtotal - mode->vsync_end;
> +	framerate = drm_mode_vrefresh(mode);
> +	vic = drm_match_cea_mode(mode);
> +
> +	dev_dbg(dev, "hactive=%d, vactive=%d\n", hactive, vactive);
> +	dev_dbg(dev, "framerate=%d\n", framerate);
> +	dev_dbg(dev, "vic = 0x%02x\n", vic);
> +
> +	put_unaligned_be16(h_total,       &timing_data[0]);
> +	put_unaligned_be16(hactive,       &timing_data[2]);
> +	put_unaligned_be16(hfront_porch,  &timing_data[4]);
> +	put_unaligned_be16(hsync_len,     &timing_data[6]);
> +	put_unaligned_be16(hback_porch,   &timing_data[8]);
> +	put_unaligned_be16(v_total,       &timing_data[10]);
> +	put_unaligned_be16(vactive,       &timing_data[12]);
> +	put_unaligned_be16(vfront_porch,  &timing_data[14]);
> +	put_unaligned_be16(vsync_len,     &timing_data[16]);
> +	put_unaligned_be16(vback_porch,   &timing_data[18]);
> +	timing_data[20] = framerate;
> +	timing_data[21] = vic;

You are kind us (ab)using an array as a manually-maintained
struct. Wouldn't it be a lot cleaner and readable if you declare a struct?
E.g.:

    struct {
      __be16 htotal;
      __be16 hactive;
      ...
      u8 framerate;
      u8 vic;
    } timing_data;

    ...

    timing_data.htotal    = cpu_to_be16(htotal);
    timing_data.hactive   = cpu_to_be16(hactive);
    ...
    timing_data.framerate = framerate;
    timing_data.vic       = vic;

With that you can stop including unaligned.h too.

> +static int lt9611c_probe(struct i2c_client *client)
> +{
> +	struct lt9611c *lt9611c;
> +	struct device *dev = &client->dev;
> +	bool fw_updated = false;
> +	int ret;
> +
> +	crc8_populate_msb(lt9611c_crc8_table, LT9611C_CRC_POLYNOMIAL);
> +
> +	if (!i2c_check_functionality(client->adapter, I2C_FUNC_I2C))
> +		return dev_err_probe(dev, -ENODEV, "device doesn't support I2C\n");
> +
> +	lt9611c = devm_drm_bridge_alloc(dev, struct lt9611c, bridge, &lt9611c_bridge_funcs);
> +	if (IS_ERR(lt9611c))
> +		return dev_err_probe(dev, PTR_ERR(lt9611c), "drm bridge alloc failed.\n");
> +
> +	lt9611c->dev = dev;
> +	lt9611c->client = client;
> +
> +	const struct lt9611c_chip_data *cdata = i2c_get_match_data(client);
> +
> +	if (!cdata)
> +		return dev_err_probe(dev, -EINVAL, "no match data for device\n");

Nit: no empty line between a function call and its error checking if().

> +
> +	lt9611c->chip_type = cdata->chip_type;
> +	lt9611c->max_tmds_rate = cdata->max_tmds_rate;
> +
> +	ret = devm_mutex_init(dev, &lt9611c->mcu_lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init mutex\n");
> +
> +	lt9611c->regmap = devm_regmap_init_i2c(client, &lt9611c_regmap_config);
> +	if (IS_ERR(lt9611c->regmap))
> +		return dev_err_probe(dev, PTR_ERR(lt9611c->regmap), "regmap i2c init failed\n");
> +
> +	ret = lt9611c_parse_dt(dev, lt9611c);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> +
> +	lt9611c->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(lt9611c->reset_gpio)) {
> +		ret = PTR_ERR(lt9611c->reset_gpio);
> +		goto err_of_put;
> +	}
> +
> +	ret = lt9611c_regulator_init(lt9611c);
> +	if (ret < 0)
> +		goto err_of_put;
> +
> +	ret = regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +	if (ret)
> +		goto err_of_put;

Why not moving this inside lt9611c_regulator_init()?

Also, I _think_ lt9611c_regulator_init() could just
devm_regulator_bulk_get_enable() to do both things at once, but I'm not
sure that would be compatible with PM. If it's safe it would simplify the
code quite a lot, and also allow using devm_drm_bridge_add() below, making
the remove function almost empty.

> +
> +	lt9611c_reset(lt9611c);
> +
> +	lt9611c_lock(lt9611c);
> +
> +	ret = lt9611c_read_chipid(lt9611c);
> +	if (ret < 0) {
> +		dev_err(dev, "failed to read chip id.\n");
> +		lt9611c_unlock(lt9611c);
> +		goto err_disable_regulators;
> +	}
> +
> +retry:
> +	lt9611c->fw_version = lt9611c_read_version(lt9611c);
> +	if (lt9611c->fw_version < 0) {
> +		dev_err(dev, "failed to read fw version\n");
> +		ret = -EOPNOTSUPP;
> +		lt9611c_unlock(lt9611c);
> +		goto err_disable_regulators;
> +

Nit: no empty line.

> +	} else if (lt9611c->fw_version == 0) {
> +		if (!fw_updated) {
> +			fw_updated = true;
> +			lt9611c_unlock(lt9611c);
> +			ret = lt9611c_firmware_upgrade(lt9611c);
> +			if (ret < 0)
> +				goto err_disable_regulators;
> +			lt9611c_lock(lt9611c);
> +			goto retry;
> +
> +		} else {
> +			dev_err(dev, "fw version 0x%04x, update failed\n", lt9611c->fw_version);
> +			ret = -EOPNOTSUPP;
> +			lt9611c_unlock(lt9611c);
> +			goto err_disable_regulators;
> +		}
> +	}
> +
> +	lt9611c_unlock(lt9611c);
> +	dev_dbg(dev, "current version:0x%04x", lt9611c->fw_version);
> +
> +	INIT_WORK(&lt9611c->work, lt9611c_hpd_work);
> +
> +	ret = devm_request_threaded_irq(&client->dev, client->irq, NULL,
> +					lt9611c_irq_thread_handler,
> +					IRQF_TRIGGER_FALLING |
> +					IRQF_ONESHOT |
> +					IRQF_NO_AUTOEN,
> +					"lt9611c", lt9611c);
> +	if (ret) {
> +		dev_err(dev, "failed to request irq\n");
> +		goto err_disable_regulators;
> +	}
> +
> +	lt9611c->bridge.of_node = client->dev.of_node;
> +	lt9611c->bridge.ops = DRM_BRIDGE_OP_DETECT |
> +			DRM_BRIDGE_OP_EDID |
> +			DRM_BRIDGE_OP_HPD |
> +			DRM_BRIDGE_OP_HDMI |
> +			DRM_BRIDGE_OP_HDMI_AUDIO;
> +	lt9611c->bridge.type = DRM_MODE_CONNECTOR_HDMIA;
> +
> +	lt9611c->bridge.vendor = "Lontium";
> +	lt9611c->bridge.product = "LT9611C";
> +
> +	lt9611c->bridge.hdmi_audio_dev = dev;
> +	lt9611c->bridge.hdmi_audio_max_i2s_playback_channels = 8;
> +	lt9611c->bridge.hdmi_audio_dai_port = 2;
> +
> +	drm_bridge_add(&lt9611c->bridge);
> +
> +	/* Attach primary DSI */
> +	lt9611c->dsi0 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi0_node);
> +	if (IS_ERR(lt9611c->dsi0)) {
> +		ret = PTR_ERR(lt9611c->dsi0);
> +		goto err_remove_bridge;
> +	}
> +
> +	/* Attach secondary DSI, if specified */
> +	if (lt9611c->dsi1_node) {
> +		lt9611c->dsi1 = lt9611c_attach_dsi(lt9611c, lt9611c->dsi1_node);
> +		if (IS_ERR(lt9611c->dsi1)) {
> +			ret = PTR_ERR(lt9611c->dsi1);
> +			goto err_remove_bridge;
> +		}
> +	}
> +
> +	lt9611c->hdmi_connected = false;
> +	i2c_set_clientdata(client, lt9611c);
> +	enable_irq(client->irq);
> +
> +	return 0;
> +
> +err_remove_bridge:
> +	drm_bridge_remove(&lt9611c->bridge);
> +	cancel_work_sync(&lt9611c->work);
> +
> +err_disable_regulators:
> +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +
> +err_of_put:
> +	of_node_put(lt9611c->dsi1_node);
> +	of_node_put(lt9611c->dsi0_node);
> +
> +	return ret;
> +}
> +
> +static void lt9611c_remove(struct i2c_client *client)
> +{
> +	struct lt9611c *lt9611c = i2c_get_clientdata(client);
> +
> +	disable_irq(client->irq);
> +	cancel_work_sync(&lt9611c->work);
> +	drm_bridge_remove(&lt9611c->bridge);
> +	regulator_bulk_disable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +	of_node_put(lt9611c->dsi1_node);
> +	of_node_put(lt9611c->dsi0_node);
> +}

> +static struct i2c_device_id lt9611c_id[] = {
> +	{ "lontium,lt9611c",   (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611C]   },
> +	{ "lontium,lt9611ex",  (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611EX]  },
> +	{ "lontium,lt9611uxd", (kernel_ulong_t)&lt9611c_chip_data[CHIP_LT9611UXD] },

AFAIK there should be no vendor prefix for the i2c_device_id. Have a look
at the docs and other drivers for the best practice.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

