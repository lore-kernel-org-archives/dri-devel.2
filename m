Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6AB11606A31F
	for <dri-devel@archiver.kernel.org>; Tue, 27 Oct 2026 17:58:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=bootlin.com header.i=@bootlin.com header.a=rsa-sha256 header.s=dkim header.b=RQtAJSM9
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A805110E422;
	Tue, 27 Oct 2026 17:58:20 +0000 (UTC)
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86D9F10E440
 for <dri-devel@lists.freedesktop.org>; Tue, 27 Oct 2026 17:58:13 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 7F94E4E41349;
 Tue, 27 Oct 2026 17:58:11 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 3A55B603BD;
 Tue, 27 Oct 2026 17:58:11 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 60D35103290A5; Tue, 27 Oct 2026 18:57:56 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1793123885; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=nmcAToklyxEjvCkKPBTM3cArhWkSL6YBohAdPydkgY8=;
 b=RQtAJSM98gg0/95T8w+1dbYAuBCYmR0r72XvLsioC4cUM5DkkUnQ/7gn/RAo5zxkgBKKZo
 p3K9Azr0es5HzUrOgTgrDgTjbgAsMS9ZTKW9lK+2iXpG1puMIZOurAJa9iGCgzQG8GzVPD
 FSkUwKOJxE69GOfKSDijB5hFAUcJ3+geUhke7bIHUPyti0oKNoY0P9VhPQ14YZk4Y9QBBJ
 EL0LSupIv/E7bmgxlsj9UuQrnsd5YOf3GI2KhlgP4YuKy97cGIG4PYYRaGMxRGYgrYqB4m
 NlyfFYywG4gXoMRicZ3Xy6rXX6+o0Zg1rz2d1N/3DovuxUePueRRgSquVtebZQ==
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Subject: Re: [PATCH v18 2/2] drm/bridge: Add Lontium LT9611C(EX/UXD) MIPI
 DSI to HDMI driver
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
To: mohit.dsor@oss.qualcomm.com
Cc: Andrzej Hajda <andrzej.hajda@intel.com>, 
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
 Jessica Zhang <jesszhan0024@gmail.com>, Sunyun Yang <syyang@lontium.com>
In-Reply-To: <20261021-lt9611c-v7-v18-2-4978b94896f1@oss.qualcomm.com>
References: <20261021-lt9611c-v7-v18-0-4978b94896f1@oss.qualcomm.com>
 <20261021-lt9611c-v7-v18-2-4978b94896f1@oss.qualcomm.com>
Date: Tue, 27 Oct 2026 18:57:50 +0100
Message-Id: <179312387051.631593.2688359681409940856.b4-review@b4>
X-Mailer: b4 0.16.0
X-Last-TLS-Session-Version: TLSv1.3
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Hello,

> LT9611C(EX/UXD) is an I2C-controlled chip that receives single or dual
> port MIPI DSI and outputs HDMI. Differences in hardware features:
> - LT9611C:   supports 1-port MIPI DSI to HDMI 1.4
> - LT9611EX:  supports 2-port MIPI DSI to HDMI 1.4
> - LT9611UXD: supports 2-port MIPI DSI to HDMI 1.4/2.0
>
> The driver supports:
> - EDID read and mode filtering via custom MCU command protocol
> - HPD detection and interrupt handling
> - HDMI audio output via I2S
> - Firmware upgrade via sysfs
> - Dual DSI bonded mode for LT9611EX and LT9611UXD variants
>
> Signed-off-by: Sunyun Yang <syyang@lontium.com>
> Co-developed-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> Signed-off-by: Mohit Dsor <mohit.dsor@oss.qualcomm.com>
>
> diff --git a/Documentation/ABI/testing/sysfs-lontium-firmware b/Documentation/ABI/testing/sysfs-lontium-firmware
> new file mode 100644
> index 000000000000..8700933ba0f0
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-lontium-firmware
> @@ -0,0 +1,10 @@
> +What:		/sys/bus/i2c/drivers/<driver>/.../firmware
> +Date:		July 2026
> +KernelVersion:	7.3

This should be 7.5 now.

> +Contact:	Mohit Dsor <mohit.dsor@oss.qualcomm.com>
> +Description:
> +		Read: Returns the current firmware version loaded on the
> +		Lontium bridge chip in hex format (e.g. "0x0105").
> +
> +		Write: Triggers a firmware upgrade of the chip using the
> +		firmware file loaded via the firmware loader.

Other then debugging, what is the use case for triggering a firmware
upgrade? It seems to creates lots of complications in the code and exposes
and race conditions (see sashiko-reported issues). Maybe starting with a
simpler driver which loads only at probe time would help reviewing.

In case that was discussed previously: sorry, I didn't find the discussion
after a quick look at the (many!) previous iterations, can you point me to
the exact thread?

> +++ b/drivers/gpu/drm/bridge/lontium-lt9611c.c
> @@ -0,0 +1,1361 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (C) 2026 Lontium Semiconductor, Inc.
> + * Copyright (C) Qualcomm Technologies, Inc. and/or its subsidiaries.
> + */
> +
> +#include <linux/crc8.h>
> +#include <linux/firmware.h>
> +#include <linux/gpio/consumer.h>
> +#include <linux/i2c.h>
> +#include <linux/interrupt.h>
> +#include <linux/media-bus-format.h>

Unused?

> +#include <linux/module.h>
> +#include <linux/mutex.h>
> +#include <linux/of_graph.h>
> +#include <linux/regmap.h>
> +#include <linux/regulator/consumer.h>
> +#include <drm/drm_atomic_helper.h>
> +#include <drm/drm_bridge.h>
> +#include <drm/drm_connector.h>

Not sure this is used.

> +#include <drm/drm_edid.h>
> +#include <drm/drm_mipi_dsi.h>
> +#include <drm/drm_modes.h>
> +#include <drm/drm_probe_helper.h>

Unused?

> +#include <drm/display/drm_hdmi_audio_helper.h>

Unused?

> +#include <drm/display/drm_hdmi_state_helper.h>
> +#include <sound/hdmi-codec.h>

> +struct lt9611c {
> +	struct device *dev;
> +	struct i2c_client *client;
> +	struct drm_bridge bridge;
> +	struct regmap *regmap;
> +	struct mutex mcu_lock;
> +	struct work_struct work;
> +	struct gpio_desc *reset_gpio;
> +	struct regulator_bulk_data supplies[2];
> +	int fw_version;
> +	const struct lt9611c_chip_data *cdata;
> +	bool hdmi_connected;
> +	bool dual_dsi;
> +};

 | sashiko-bot@kernel.org <sashiko-bot@kernel.org>:
 |
 | [Severity: Low]
 | In drivers/gpu/drm/bridge/lontium-lt9611c.c, is MODULE_DEVICE_TABLE(i2c,
 | lt9611c_id) missing after lt9611c_id?
 |
 | Without MODULE_DEVICE_TABLE(i2c, lt9611c_id), building the driver as a module
 | (CONFIG_DRM_LONTIUM_LT9611C=m) omits the i2c:lt9611c, i2c:lt9611ex, and
 | i2c:lt9611uxd modalias entries from modules.alias, preventing automatic module
 | loading when devices are instantiated via I2C device IDs.

Not sure why it's mentiond here, but it's right.

Also, please reply to sashiko remarks either saying you will fix them, or
saying why you won't (e.g. invalid).

> +static int lt9611c_read_write_flow(struct lt9611c *lt9611c,
> +				   const struct lt9611c_cmd *cmd,
> +				   struct lt9611c_rsp *rsp)
> +{
> +	int ret;
> +	unsigned int i;
> +	unsigned int temp;
> +	unsigned int max_params = 0xe0dd - 0xe0b0 + 1;
> +
> +	regmap_write(lt9611c->regmap, 0xe0de, 0x01);

Can't registers have a #define with a meaningful name? This is valid for th
entire driver.

> +static void lt9611c_lock(struct lt9611c *lt9611c)
> +{
> +	mutex_lock(&lt9611c->mcu_lock);
> +	regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> +}

I'm not sure I get why in some cases you just take mcu_lock and other times
you need this function, which additionally writes a register. Can you
elaborate on that?

> +static void lt9611c_hpd_work(struct work_struct *work)
> +{
> +	struct lt9611c *lt9611c = container_of(work, struct lt9611c, work);
> +	struct device *dev = lt9611c->dev;
> +	static const u8 hpd_data[] = { 0x00 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
> +		.data = hpd_data,
> +		.data_len = 1,
> +	};
> +	u8 hpd_status;
> +	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
> +	bool connected;
> +	int ret;
> +
> +	/*
> +	 * Wait for the MCU to debounce and latch the HPD state after the
> +	 * interrupt fires. The MCU needs time to update its internal HPD
> +	 * register; reading immediately after the interrupt returns stale
> +	 * state. 200 ms is empirically sufficient.
> +	 */
> +	msleep(200);
> +
> +	mutex_lock(&lt9611c->mcu_lock);
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret)
> +		dev_err(dev, "failed to read HPD status\n");
> +	else
> +		lt9611c->hdmi_connected = (hpd_status == 0x02);
> +
> +	connected = lt9611c->hdmi_connected;
> +	mutex_unlock(&lt9611c->mcu_lock);
> +
> +	drm_bridge_hpd_notify(&lt9611c->bridge,
> +			      connected ? connector_status_connected :
> +			      connector_status_disconnected);
> +}
> +
> +static int lt9611c_regulator_init(struct lt9611c *lt9611c)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +
> +	lt9611c->supplies[0].supply = "vcc";
> +	lt9611c->supplies[1].supply = "vdd";
> +
> +	ret = devm_regulator_bulk_get(dev, ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +	if (ret)
> +		return ret;
> +
> +	return regulator_bulk_enable(ARRAY_SIZE(lt9611c->supplies), lt9611c->supplies);
> +}
> +
> +static struct mipi_dsi_device *lt9611c_attach_dsi(struct lt9611c *lt9611c,
> +						  struct device_node *dsi_node)
> +{
> +	const struct mipi_dsi_device_info info = { "lt9611c", 0, NULL };
> +	struct mipi_dsi_device *dsi;
> +	struct mipi_dsi_host *host;
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +
> +	host = of_find_mipi_dsi_host_by_node(dsi_node);
> +	if (!host)
> +		return ERR_PTR(dev_err_probe(dev, -EPROBE_DEFER, "failed to find dsi host\n"));
> +
> +	dsi = devm_mipi_dsi_device_register_full(dev, host, &info);
> +	if (IS_ERR(dsi))
> +		return ERR_PTR(dev_err_probe(dev, PTR_ERR(dsi), "failed to create dsi device\n"));
> +
> +	dsi->lanes = 4;
> +	dsi->format = MIPI_DSI_FMT_RGB888;
> +	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |
> +			 MIPI_DSI_MODE_VIDEO_HSE;
> +
> +	ret = devm_mipi_dsi_attach(dev, dsi);
> +	if (ret < 0)
> +		return ERR_PTR(dev_err_probe(dev, ret, "failed to attach dsi to host\n"));
> +
> +	return dsi;
> +}

lt9611c_regulator_init() and lt9611c_attach_dsi() are referenced only by
probe. So please move them just before the probe function, to make it clear
they are part of the probe sequence and they can legitimately use devm.

> +static int lt9611c_bridge_attach(struct drm_bridge *bridge,
> +				 struct drm_encoder *encoder,
> +				 enum drm_bridge_attach_flags flags)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +
> +	if (!(flags & DRM_BRIDGE_ATTACH_NO_CONNECTOR))
> +		return -EINVAL;

Good!

> +	return drm_bridge_attach(encoder, lt9611c->bridge.next_bridge, bridge, flags);
> +}
> +
> +static enum drm_mode_status
> +lt9611c_hdmi_tmds_char_rate_valid(const struct drm_bridge *bridge,
> +				  const struct drm_display_mode *mode,
> +				  unsigned long long tmds_rate)
> +{
> +	const struct lt9611c *lt9611c = bridge_to_lt9611c_const(bridge);
> +
> +	if (tmds_rate > lt9611c->cdata->max_tmds_rate)
> +		return MODE_CLOCK_HIGH;
> +
> +	if (tmds_rate < 25000000)

Please #define this number with an informative name,
e.g. LT9611C_MIX_TMDS_RATE (not sure it's correct).

> +		return MODE_CLOCK_LOW;
> +
> +	return MODE_OK;
> +}
> +
> +static void lt9611c_video_setup(struct lt9611c *lt9611c,
> +				const struct drm_display_mode *mode)
> +{
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	struct {
> +		__be16 htotal;
> +		__be16 hactive;
> +		__be16 hfront_porch;
> +		__be16 hsync_len;
> +		__be16 hback_porch;
> +		__be16 vtotal;
> +		__be16 vactive;
> +		__be16 vfront_porch;
> +		__be16 vsync_len;
> +		__be16 vback_porch;
> +		u8 framerate;
> +		u8 vic;
> +	} timing_data;
> +	struct lt9611c_rsp rsp = {};
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x33, LT9611C_CMD_SEP },
> +		.data = (u8 *)&timing_data,
> +		.data_len = sizeof(timing_data),
> +	};
> +
> +	timing_data.htotal      = cpu_to_be16(mode->htotal);
> +	timing_data.hactive     = cpu_to_be16(mode->hdisplay);
> +	timing_data.hfront_porch = cpu_to_be16(mode->hsync_start - mode->hdisplay);
> +	timing_data.hsync_len   = cpu_to_be16(mode->hsync_end - mode->hsync_start);
> +	timing_data.hback_porch = cpu_to_be16(mode->htotal - mode->hsync_end);
> +	timing_data.vtotal      = cpu_to_be16(mode->vtotal);
> +	timing_data.vactive     = cpu_to_be16(mode->vdisplay);
> +	timing_data.vfront_porch = cpu_to_be16(mode->vsync_start - mode->vdisplay);
> +	timing_data.vsync_len   = cpu_to_be16(mode->vsync_end - mode->vsync_start);
> +	timing_data.vback_porch = cpu_to_be16(mode->vtotal - mode->vsync_end);
> +	timing_data.framerate   = drm_mode_vrefresh(mode);
> +	timing_data.vic         = drm_match_cea_mode(mode);
> +
> +	dev_dbg(dev, "hactive=%d, vactive=%d\n", mode->hdisplay, mode->vdisplay);
> +	dev_dbg(dev, "framerate=%d\n", timing_data.framerate);
> +	dev_dbg(dev, "vic = 0x%02x\n", timing_data.vic);
> +
> +	guard(mutex)(&lt9611c->mcu_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret)
> +		dev_err(dev, "video set failed\n");
> +}
> +
> +/*
> + * Enables dual DSI port input on the LT9611UXD/EX. Must be called
> + * after video_setup when two DSI hosts are connected.
> + */
> +static int lt9611c_dual_port_enable(struct lt9611c *lt9611c)
> +{
> +	static const u8 dual_port_data[] = { 0x02, 0x70 };
> +	struct device *dev = lt9611c->dev;
> +	u8 ack = 0;
> +	int ret;
> +	struct lt9611c_rsp rsp = { .data = &ack, .data_len = 1 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_WRITE, LT9611C_TYPE_MIPI, 0x31, LT9611C_CMD_SEP },
> +		.data = dual_port_data,
> +		.data_len = ARRAY_SIZE(dual_port_data),
> +	};
> +
> +	guard(mutex)(&lt9611c->mcu_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret || !ack) {
> +		dev_err(dev, "failed to enable dual DSI port (err=%d)\n", ret);
> +		return ret ? ret : -EIO;
> +	}
> +
> +	return 0;
> +}
> +
> +static void lt9611c_bridge_atomic_enable(struct drm_bridge *bridge,
> +					 struct drm_atomic_commit *state)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	struct drm_connector *connector;
> +	struct drm_connector_state *conn_state;
> +	struct drm_crtc_state *crtc_state;
> +	struct drm_display_mode *mode;
> +	int ret;
> +
> +	connector = drm_atomic_get_new_connector_for_encoder(state, bridge->encoder);
> +	if (WARN_ON(!connector))
> +		return;
> +
> +	conn_state = drm_atomic_get_new_connector_state(state, connector);
> +	if (WARN_ON(!conn_state))
> +		return;
> +
> +	crtc_state = drm_atomic_get_new_crtc_state(state, conn_state->crtc);
> +	if (WARN_ON(!crtc_state))
> +		return;
> +
> +	mode = &crtc_state->adjusted_mode;
> +
> +	lt9611c_video_setup(lt9611c, mode);
> +
> +	if (lt9611c->dual_dsi) {
> +		ret = lt9611c_dual_port_enable(lt9611c);
> +		if (ret)
> +			dev_err(lt9611c->dev, "failed to enable dual DSI port (err=%d)\n", ret);
> +	}

lt9611c_video_setup() takes and releases mcu_lock, and
lt9611c_dual_port_enable() take it again, so there is a possible race
window. I'm not sure it can cause problems, but these two functions are
never called separately, so whay not folding lt9611c_dual_port_enable()
into lt9611c_video_setup()? Or at least calling lt9611c_dual_port_enable()
from lt9611c_video_setup(), so callers (or, well, the unique caller) don't
have to take care about dual DSI?

> +
> +	drm_atomic_helper_connector_hdmi_update_infoframes(connector, state);
> +}
> +
> +static enum drm_connector_status
> +lt9611c_bridge_detect(struct drm_bridge *bridge, struct drm_connector *connector)
> +{
> +	struct lt9611c *lt9611c = bridge_to_lt9611c(bridge);
> +	struct device *dev = lt9611c->dev;
> +	int ret;
> +	bool connected = false;
> +	static const u8 hpd_data[] = { 0x00 };
> +	struct lt9611c_cmd cmd = {
> +		.hdr = { LT9611C_FUNC_READ, LT9611C_TYPE_HDMI, 0x31, LT9611C_CMD_SEP },
> +		.data = hpd_data,
> +		.data_len = 1,
> +	};
> +	u8 hpd_status;
> +	struct lt9611c_rsp rsp = { .data = &hpd_status, .data_len = 1 };
> +
> +	guard(mutex)(&lt9611c->mcu_lock);
> +
> +	ret = lt9611c_read_write_flow(lt9611c, &cmd, &rsp);
> +	if (ret)
> +		dev_err(dev, "failed to read HPD status (err=%d)\n", ret);
> +	else
> +		connected = (hpd_status == 0x02);
> +
> +	lt9611c->hdmi_connected = connected;
> +
> +	return connected ? connector_status_connected :
> +				connector_status_disconnected;
> +}

This code is very similar to lt9611c_hpd_work(), can the common code be
moved to an internal function? It might take the msleep timeout as a
parameter, as it seems to be the only real difference.

BTW is the timeout really never necessary here? Even if
lt9611c_bridge_detect() is called by chance just after an interrupt?

> +static int lt9611c_parse_dt(struct device *dev,
> +			    struct lt9611c *lt9611c,
> +			    struct device_node **dsi0_node,
> +			    struct device_node **dsi1_node)
> +{
> +	int ret;
> +
> +	*dsi0_node = of_graph_get_remote_node(dev->of_node, 0, -1);
> +	if (!*dsi0_node)
> +		return dev_err_probe(dev, -ENODEV, "failed to get remote node for primary dsi\n");
> +
> +	*dsi1_node = of_graph_get_remote_node(dev->of_node, 1, -1);
> +
> +	if (*dsi1_node && lt9611c->cdata->chip_type == CHIP_LT9611C) {
> +		ret = dev_err_probe(dev, -EINVAL,
> +				    "LT9611C does not support dual DSI\n");
> +		goto err_put_dsi1;
> +	}
> +
> +	if (*dsi1_node)
> +		lt9611c->dual_dsi = true;
> +
> +	lt9611c->bridge.next_bridge = of_drm_get_bridge_by_endpoint(dev->of_node, 2, -1);
> +	if (IS_ERR(lt9611c->bridge.next_bridge)) {
> +		ret = PTR_ERR(lt9611c->bridge.next_bridge);
> +		goto err_put_dsi1;
> +	}
> +
> +	return 0;
> +
> +err_put_dsi1:
> +	of_node_put(*dsi1_node);
> +	of_node_put(*dsi0_node);
> +	return ret;
> +}
> +
> +static int lt9611c_read_version(struct lt9611c *lt9611c)

Maybe rename to lt9611c_read_fw_version() for clarity?

> +{
> +	u8 buf[2];
> +	int ret;
> +
> +	ret = regmap_write(lt9611c->regmap, 0xe0ee, 0x01);
> +	if (ret)
> +		return ret;
> +
> +	ret = regmap_bulk_read(lt9611c->regmap, 0xe080, buf, ARRAY_SIZE(buf));
> +	if (ret)
> +		return ret;
> +
> +	return (buf[0] << 8) | buf[1];
> +}

> +static ssize_t firmware_store(struct device *dev, struct device_attribute *attr,
> +				      const char *buf, size_t len)
> +{
> +	struct lt9611c *lt9611c = dev_get_drvdata(dev);
> +	int ret;
> +
> +	if (!lt9611c)
> +		return -ENODEV;
> +
> +	dev_warn(dev, "starting firmware upgrade — display will be disrupted\n");
> +
> +	ret = lt9611c_firmware_upgrade(lt9611c);
> +	if (ret < 0) {
> +		dev_err(dev, "upgrade failure\n");
> +		return ret;
> +	}
> +
> +	lt9611c_lock(lt9611c);
> +	WRITE_ONCE(lt9611c->fw_version, lt9611c_read_version(lt9611c));
> +	lt9611c_unlock(lt9611c);
> +
> +	if (READ_ONCE(lt9611c->fw_version) < 0)
> +		dev_warn(dev, "upgrade succeeded but failed to read new fw version\n");

Logging the errno (lt9611c->fw_version) could be useful here.

> +static int lt9611c_probe(struct i2c_client *client)
> +{
> +	struct lt9611c *lt9611c;
> +	struct device *dev = &client->dev;
> +	struct device_node *dsi0_node = NULL;
> +	struct device_node *dsi1_node = NULL;

Small improvement: using a cleanup action would simplify a bit the error
management, removing the err_put_nodes label here and the err_put_dsi1
label in lt9611c_parse_dt():

  struct device_node *dsi0_node __free(device_node) = NULL;

> +	struct mipi_dsi_device *dsi;
> +	bool fw_updated = false;
> +	int ret;
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
> +	i2c_set_clientdata(client, lt9611c);
> +
> +	const struct lt9611c_chip_data *cdata = i2c_get_match_data(client);
> +
> +	if (!cdata)
> +		return dev_err_probe(dev, -EINVAL, "no match data for device\n");

Minor nit: no newline between variable assignment and error checking.

> +
> +	lt9611c->cdata = cdata;
> +
> +	ret = devm_mutex_init(dev, &lt9611c->mcu_lock);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to init mutex\n");
> +
> +	lt9611c->regmap = devm_regmap_init_i2c(client, &lt9611c_regmap_config);
> +	if (IS_ERR(lt9611c->regmap))
> +		return dev_err_probe(dev, PTR_ERR(lt9611c->regmap), "regmap i2c init failed\n");
> +
> +	ret = lt9611c_parse_dt(dev, lt9611c, &dsi0_node, &dsi1_node);
> +	if (ret)
> +		return dev_err_probe(dev, ret, "failed to parse device tree\n");
> +
> +	lt9611c->reset_gpio = devm_gpiod_get(dev, "reset", GPIOD_OUT_HIGH);
> +	if (IS_ERR(lt9611c->reset_gpio)) {
> +		ret = PTR_ERR(lt9611c->reset_gpio);
> +		goto err_put_nodes;
> +	}
> +
> +	ret = lt9611c_regulator_init(lt9611c);
> +	if (ret < 0)
> +		goto err_put_nodes;
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

lt9611c_read_version() returns an error code from regmap functions. Why are
you ignoring it and forcing -EOPNOTSUPP?

Also, dev_err_probe would be better here:

	if (lt9611c->fw_version < 0) {
		ret = lt9611c->fw_version
		dev_err_probe(dev, ret, "failed to read fw version\n");
		lt9611c_unlock(lt9611c);
		goto err_disable_regulators;
	} else ...

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

Ugh, a goto-based loop in the middle of a very long function is not helping
readability. The FW loading logic would be better moved to its own
function.

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
> +	dsi = lt9611c_attach_dsi(lt9611c, dsi0_node);
> +	if (IS_ERR(dsi)) {
> +		ret = PTR_ERR(dsi);
> +		goto err_remove_bridge;
> +	}
> +
> +	/* Attach secondary DSI, if specified */
> +	if (dsi1_node) {
> +		dsi = lt9611c_attach_dsi(lt9611c, dsi1_node);
> +		if (IS_ERR(dsi)) {
> +			ret = PTR_ERR(dsi);
> +			goto err_remove_bridge;
> +		}
> +	}
> +
> +	lt9611c->hdmi_connected = false;
> +	enable_irq(client->irq);


> +
> +	of_node_put(dsi1_node);
> +	of_node_put(dsi0_node);
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
> +err_put_nodes:
> +	of_node_put(dsi1_node);
> +	of_node_put(dsi0_node);
> +
> +	return ret;
> +}

> +static struct i2c_driver lt9611c_driver = {
> +	.driver = {
> +		.name = "lt9611c",
> +		.of_match_table = lt9611c_match_table,
> +		.pm = &lt9611c_bridge_pm_ops,

As suggested by sashiko, please use the new DEFINE_SIMPLE_DEV_PM_OPS()
macro or similar to avoid "defined but unused" warnings. Also test your
driver in all combinations of DRM_LONTIUM_LT9611C=y/m and PM_SLEEP=y/n.

Luca

-- 
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

