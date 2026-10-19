Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 100C9CCF2D6
	for <dri-devel@archiver.kernel.org>; Mon, 19 Oct 2026 09:57:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A873B10E951;
	Mon, 19 Oct 2026 09:57:43 +0000 (UTC)
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6AABA10E92F
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 09:57:34 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-48dfaa3fa12so1872149f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 19 Oct 2026 02:57:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792403853; x=1793008653; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=6FSYoheTDmA4DpRaSb6YIPC1UctKcu1GqLxb7xH0SzE=;
 b=poj6KCbDozOoDTm0jaaYMauoxQ1bmrmZ8PR3pU9VdKb3bh5VIR37FYexNw6vC8Ux59
 oTLj1NlszkZgbH31jekEm9gBy8qt59cgH398yoR34cKHvurpR0mFldCxw/B4XKAfpRnZ
 2lTAy7ReJ1TMvevLaNgyg2kRgKGuJ+N7DxY2ob1bcC2lc3x4MJJfwoqk/nPslKTME6cR
 c3VOY2rLiovEghE90vnOmMnSAl/8riP9KdzV0hh3ajOmo5lvuXq7MzVtBuQ7fEEIsXet
 7hJTcqsX1IIP15wxnKIexxulvwvBq3dc6BsLrFDTe/X43dpAbd3cvKFn2gq3mewXl8tV
 M6Gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792403853; x=1793008653;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=6FSYoheTDmA4DpRaSb6YIPC1UctKcu1GqLxb7xH0SzE=;
 b=naq2nHJWN5xT5jVmd3Gt26HqrfO5msP2TBlfIY+5i14KJVoXg4Vdhc3z3WtYdLZJnS
 SbOejcOp06RE3X6nn4r3DjFmXBwc8RGzJyXgvIpay0gyo09I69bMurOBVHipQ0ZwQffg
 iFFlmS95FnLjziQzcQKP7SQXCLCP+cHJjTJObmWlCtxkWWmE4+2ikvfby77hlb2dyN0e
 46sGJSuuxCpF5ro5+6xK8fBR2IJo7nBD1QPlgrnj6WEO49TKTdoQkHuwtX86Ni8KS8qj
 7PVpT2vsughPebITiyqyZUHYs6IRBef06PKq+HdS9uQzw5rgb4ZF6he+j0r4Iakujy9V
 Q2iA==
X-Gm-Message-State: AFq9FYK1r5LRgWQCR4zGy173lOBOcTb4PwFUCa98TKkv/Agh4HG/0hve
 23vUjXOuKbL+V89tGKZaV3OgmfUOS5AO8cFNiNlR0AyY+a4mLg6AtZ4Q
X-Gm-Gg: AYBFou1i4C3SnygmKUX4pNDiOILWTWz/ynCtWGZMk4k//6ARO3vFBZC7WFi5USVDwZX
 HWmoaRZaT+31sE/dR0IAtr6nHSn+nyqGOFEJvpaShZr8jo3k+ic8QN4K2AcLFu8e8QBWNUK+m//
 T9S/vP2xxeYuwumPmM5iZxlbSexU6aUMC+2jX0GHLlpNqlTeca2fcdZrzhsusXDAovt+qW2SqPI
 FB7wEi7zoOHLKFh/vwY1Ao9RAmSA+c3Pnv1ywj8jUWOPC/50wvS0OVY0yuFFkWh9QvYUte1cjX0
 L3Qe9iYYpDcZorWWD9BvsjiHAk1fgBPyi1Jo/X3bj+KhGDeV2xwMdt8wCHDxXHv3FUAhYsM0Vm3
 dqVfnhHX2Zm0Tpxwm0yFzVFBICdCk6YCdw0j7g9BOLwzAfWHF4ISkXeECBoRjZ18X/4o8ZEnkRD
 3QEDvbJ28J09PUX3G4k25oCa3CpZZpu4vWPT5qo90lu689BAimbqx+G4Cwt3UH5wui5qHUY0rkc
 QSsHz/nT6kT3ej1CbQ=
X-Received: by 2002:a05:600c:4f88:b0:4a1:9c71:9f17 with SMTP id
 5b1f17b1804b1-4a1d75fe190mr145198735e9.9.1792403852594; 
 Mon, 19 Oct 2026 02:57:32 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48dfd500e75sm21740089f8f.42.2026.10.19.02.57.30
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 19 Oct 2026 02:57:31 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v3 4/7] drm/tegra: Add support for 8-bit CPU interface
Date: Mon, 19 Oct 2026 12:57:02 +0300
Message-ID: <20261019095705.91062-5-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261019095705.91062-1-clamor95@gmail.com>
References: <20261019095705.91062-1-clamor95@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
that closely resembles the MIPI DBI Type B protocol and is referred to as
'8-bit CPU'. Each display controller provides two such interfaces, which
can be used to send MIPI DCS commands to initialize and control the panel
while image data is transmitted via 16/18/24-line RGB.

The '8-bit CPU', although being the DC interface, is modeled using a
bridge framework for flexibility and convenience. This implementation does
not change the existing codebase besides registering a fragment and can be
enabled/disabled without losing other Tegra DRM functionality.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/Kconfig  |   7 +
 drivers/gpu/drm/tegra/Makefile |   3 +
 drivers/gpu/drm/tegra/dbi.c    | 415 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c     |  29 +++
 drivers/gpu/drm/tegra/dc.h     |   1 +
 drivers/gpu/drm/tegra/trace.c  |   3 +
 6 files changed, 458 insertions(+)
 create mode 100644 drivers/gpu/drm/tegra/dbi.c

diff --git a/drivers/gpu/drm/tegra/Kconfig b/drivers/gpu/drm/tegra/Kconfig
index 8a3b16aac5d68..ce3a424398713 100644
--- a/drivers/gpu/drm/tegra/Kconfig
+++ b/drivers/gpu/drm/tegra/Kconfig
@@ -30,6 +30,13 @@ config DRM_TEGRA
 
 if DRM_TEGRA
 
+config DRM_TEGRA_DBI
+	tristate "Enable MIPI DBI type B communication protocol for Tegra 20/30"
+	help
+	  Tegra20 and Tegra30 feature 8 bit CPU driver panel control
+	  protocol (similar to MIPI DBI Type B). This option allows use
+	  it to set up and control compatible panel.
+
 config DRM_TEGRA_DEBUG
 	bool "NVIDIA Tegra DRM debug support"
 	help
diff --git a/drivers/gpu/drm/tegra/Makefile b/drivers/gpu/drm/tegra/Makefile
index e399b40d64a1d..d67e53248a082 100644
--- a/drivers/gpu/drm/tegra/Makefile
+++ b/drivers/gpu/drm/tegra/Makefile
@@ -33,3 +33,6 @@ tegra-drm-y += trace.o
 tegra-drm-$(CONFIG_DRM_FBDEV_EMULATION) += fbdev.o
 
 obj-$(CONFIG_DRM_TEGRA) += tegra-drm.o
+
+obj-$(CONFIG_DRM_TEGRA_DBI) += tegra-dbi.o
+tegra-dbi-y := dbi.o
diff --git a/drivers/gpu/drm/tegra/dbi.c b/drivers/gpu/drm/tegra/dbi.c
new file mode 100644
index 0000000000000..4b3966dea0438
--- /dev/null
+++ b/drivers/gpu/drm/tegra/dbi.c
@@ -0,0 +1,415 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/gpio/consumer.h>
+#include <linux/kernel.h>
+#include <linux/media-bus-format.h>
+#include <linux/module.h>
+#include <linux/of_platform.h>
+#include <linux/property.h>
+#include <linux/platform_device.h>
+
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_drv.h>
+#include <drm/drm_mipi_dbi.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+
+#include <video/mipi_display.h>
+
+#include "dc.h"
+
+#define TEGRA_DBI_COMMAND			0
+#define TEGRA_DBI_DATA				1
+#define TEGRA_DBI_DATA_PINS_MAX			8
+
+struct tegra_dbi_output {
+	struct drm_panel *panel;
+	struct drm_bridge *bridge;
+};
+
+struct tegra_dbi_priv {
+	struct mipi_dbi dbi;		/* must be first */
+	struct device *dev;
+	struct tegra_dc *dc;
+
+	struct gpio_desc *dc_gpio;
+	struct gpio_desc *rw_gpio;
+	struct gpio_desc *cs_gpio;
+	struct gpio_descs *data_gpios;
+
+	struct drm_bridge bridge;
+	struct tegra_dbi_output output;
+
+	u32 spi_init_seq[4];
+	u32 bus_width;
+	bool prepared;
+};
+
+static inline struct tegra_dbi_priv *mipi_dbi_to_tegra_dbi(struct mipi_dbi *dbi)
+{
+	return container_of(dbi, struct tegra_dbi_priv, dbi);
+}
+
+static inline struct tegra_dbi_priv *bridge_to_tegra_dbi(struct drm_bridge *bridge)
+{
+	return container_of(bridge, struct tegra_dbi_priv, bridge);
+}
+
+static void tegra_dbi_write(struct tegra_dbi_priv *priv, u8 type, u8 value)
+{
+	DECLARE_BITMAP(value_bitmap, 8);
+
+	value_bitmap[0] = value;
+
+	gpiod_set_value(priv->dc_gpio, type);
+
+	gpiod_set_value(priv->cs_gpio, 0);
+	gpiod_set_value(priv->rw_gpio, 0);
+
+	gpiod_set_array_value(priv->data_gpios->ndescs, priv->data_gpios->desc,
+			      priv->data_gpios->info, value_bitmap);
+
+	gpiod_set_value(priv->cs_gpio, 1);
+	gpiod_set_value(priv->rw_gpio, 1);
+
+	udelay(10);
+}
+
+static int tegra_dbi_dbi_command(struct mipi_dbi *dbi, u8 *cmd, u8 *param, size_t num)
+{
+	struct tegra_dbi_priv *priv = mipi_dbi_to_tegra_dbi(dbi);
+	u8 command = *cmd;
+
+	if (!priv->data_gpios)
+		return 0;
+
+	tegra_dbi_write(priv, TEGRA_DBI_COMMAND, command);
+
+	for (int i = 0; i < num; i++)
+		tegra_dbi_write(priv, TEGRA_DBI_DATA, param[i]);
+
+	return 0;
+}
+
+static int tegra_dbi_prepare_gpios(struct tegra_dbi_priv *priv)
+{
+	struct device *dev = priv->dev;
+	int ret;
+
+	if (priv->prepared)
+		return 0;
+
+	/*
+	 * Control and data GPIOs are shared between SPI and DPI. The bridge
+	 * driver must get and put the required GPIOs each time DCS commands
+	 * are transmitted.
+	 */
+
+	priv->cs_gpio = gpiod_get(dev, "cs", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->cs_gpio)) {
+		dev_err(dev, "Failed to get CS GPIO: %ld\n", PTR_ERR(priv->cs_gpio));
+		return PTR_ERR(priv->cs_gpio);
+	}
+
+	priv->rw_gpio = gpiod_get(dev, "rw", GPIOD_OUT_HIGH);
+	if (IS_ERR(priv->rw_gpio)) {
+		ret = PTR_ERR(priv->rw_gpio);
+		dev_err(dev, "Failed to get RW GPIO: %d\n", ret);
+		goto free_cs;
+	}
+
+	priv->dc_gpio = gpiod_get(dev, "dc", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->dc_gpio)) {
+		ret = PTR_ERR(priv->dc_gpio);
+		dev_err(dev, "Failed to get DC GPIO: %d\n", ret);
+		goto free_rw;
+	}
+
+	priv->data_gpios = gpiod_get_array(dev, "data", GPIOD_OUT_LOW);
+	if (IS_ERR(priv->data_gpios)) {
+		ret = PTR_ERR(priv->data_gpios);
+		dev_err(dev, "Failed to get data gpios %d\n", ret);
+		goto free_dc;
+	}
+
+	if (priv->data_gpios && priv->data_gpios->ndescs > TEGRA_DBI_DATA_PINS_MAX) {
+		ret = -EINVAL;
+		dev_err(dev, "Too many data gpios\n");
+		goto free_data;
+	}
+
+	priv->prepared = true;
+
+	return 0;
+
+free_data:
+	gpiod_put_array(priv->data_gpios);
+free_dc:
+	gpiod_put(priv->dc_gpio);
+free_rw:
+	gpiod_put(priv->rw_gpio);
+free_cs:
+	gpiod_put(priv->cs_gpio);
+
+	return ret;
+}
+
+static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
+				    struct drm_atomic_commit *state)
+{
+	struct tegra_dbi_priv *priv = bridge_to_tegra_dbi(bridge);
+	struct tegra_dc *dc = priv->dc;
+	u32 value;
+	int ret;
+
+	value = tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
+	value &= ~DISP_CTRL_MODE_MASK;
+	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
+
+	/* Disable all options except cursor if enabled */
+	value = tegra_dc_readl(dc, DC_DISP_DISP_WIN_OPTIONS);
+	value &= CURSOR_ENABLE;
+	tegra_dc_writel(dc, value, DC_DISP_DISP_WIN_OPTIONS);
+
+	tegra_dc_commit(dc);
+
+	tegra_dc_writel(dc, V_PULSE1_ENABLE, DC_DISP_DISP_SIGNAL_OPTIONS0);
+	tegra_dc_writel(dc, PULSE_POLARITY_LOW, DC_DISP_V_PULSE1_CONTROL);
+
+	tegra_dc_writel(dc, PULSE_END(1), DC_DISP_V_PULSE0_POSITION_A);
+	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE0_POSITION_B);
+	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE0_POSITION_C);
+
+	value = 1 << FRAME_INIT_SEQ_CYCLES_SHIFT |
+		DC_SIGNAL_VPULSE1 << INIT_SEQ_DC_SIGNAL_SHIFT |
+		INIT_SEQUENCE_MODE_PLCD | SEND_INIT_SEQUENCE;
+	tegra_dc_writel(dc, value, DC_DISP_INIT_SEQ_CONTROL);
+
+	tegra_dc_writel(dc, priv->spi_init_seq[0], DC_DISP_SPI_INIT_SEQ_DATA_A);
+	tegra_dc_writel(dc, priv->spi_init_seq[1], DC_DISP_SPI_INIT_SEQ_DATA_B);
+	tegra_dc_writel(dc, priv->spi_init_seq[2], DC_DISP_SPI_INIT_SEQ_DATA_C);
+	tegra_dc_writel(dc, priv->spi_init_seq[3], DC_DISP_SPI_INIT_SEQ_DATA_D);
+
+	value = tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
+	value &= ~DISP_CTRL_MODE_MASK;
+	value |= DISP_CTRL_MODE_C_DISPLAY;
+	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
+
+	/* set LDC pin to V Pulse 1 */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
+	value |= LDC_OUTPUT_SELECT_V_PULSE1;
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
+
+	value = SC1_H_QUALIFIER(SC_H_QUALIFIER_NONE) |
+		SC0_V_QUALIFIER(SC_V_QUALIFIER_VACTIVE) |
+		SC0_H_QUALIFIER(SC_H_QUALIFIER_HACTIVE);
+	tegra_dc_writel(dc, value, DC_DISP_SHIFT_CLOCK_OPTIONS);
+
+	value = tegra_dc_readl(dc, DC_DISP_DISP_COLOR_CONTROL);
+	value &= ~BASE_COLOR_SIZE_MASK;
+
+	switch (priv->bus_width) {
+	case 16:
+		value |= BASE_COLOR_SIZE_565;
+		break;
+	case 18:
+		value |= BASE_COLOR_SIZE_666;
+		break;
+	case 24:
+	default:
+		value |= BASE_COLOR_SIZE_888;
+		break;
+	}
+
+	tegra_dc_writel(dc, value, DC_DISP_DISP_COLOR_CONTROL);
+
+	ret = tegra_dbi_prepare_gpios(priv);
+	if (ret)
+		return;
+
+	if (priv->output.panel)
+		drm_panel_enable(priv->output.panel);
+
+	gpiod_set_value(priv->cs_gpio, 0);
+
+	gpiod_put(priv->dc_gpio);
+	gpiod_put(priv->rw_gpio);
+	gpiod_put(priv->cs_gpio);
+
+	gpiod_put_array(priv->data_gpios);
+	priv->prepared = false;
+}
+
+static void tegra_dbi_atomic_disable(struct drm_bridge *bridge,
+				     struct drm_atomic_commit *state)
+{
+	struct tegra_dbi_priv *priv = bridge_to_tegra_dbi(bridge);
+	int ret;
+
+	ret = tegra_dbi_prepare_gpios(priv);
+	if (ret)
+		return;
+
+	if (priv->output.panel)
+		drm_panel_disable(priv->output.panel);
+
+	gpiod_set_value(priv->cs_gpio, 0);
+
+	gpiod_put(priv->dc_gpio);
+	gpiod_put(priv->rw_gpio);
+	gpiod_put(priv->cs_gpio);
+
+	gpiod_put_array(priv->data_gpios);
+	priv->prepared = false;
+}
+
+static int tegra_dbi_atomic_check(struct drm_bridge *bridge,
+				  struct drm_bridge_state *bridge_state,
+				  struct drm_crtc_state *crtc_state,
+				  struct drm_connector_state *conn_state)
+{
+	struct drm_display_mode *adjusted_mode = &crtc_state->adjusted_mode;
+
+	/* Set safe default bus flags if panel does not specify them */
+	if (!bridge_state->input_bus_cfg.flags)
+		bridge_state->input_bus_cfg.flags = bridge->timings->input_bus_flags;
+
+	/* Default to positive sync */
+	if (!(adjusted_mode->flags &
+	      (DRM_MODE_FLAG_PHSYNC | DRM_MODE_FLAG_NHSYNC)))
+		adjusted_mode->flags |= DRM_MODE_FLAG_PHSYNC;
+
+	if (!(adjusted_mode->flags &
+	      (DRM_MODE_FLAG_PVSYNC | DRM_MODE_FLAG_NVSYNC)))
+		adjusted_mode->flags |= DRM_MODE_FLAG_PVSYNC;
+
+	return 0;
+}
+
+static int tegra_dbi_attach(struct drm_bridge *bridge,
+			    struct drm_encoder *encoder,
+			    enum drm_bridge_attach_flags flags)
+{
+	struct tegra_dbi_priv *priv = bridge_to_tegra_dbi(bridge);
+	struct device *dev = priv->dev;
+
+	priv->dc = dev_get_drvdata(dev->parent);
+	if (!priv->dc)
+		return -ENODEV;
+
+	return drm_bridge_attach(bridge->encoder, priv->output.bridge, bridge,
+				 flags);
+}
+
+static enum drm_mode_status tegra_dbi_mode_valid(struct drm_bridge *bridge,
+						 const struct drm_display_info *info,
+						 const struct drm_display_mode *mode)
+{
+	if (mode->hdisplay > 800)
+		return MODE_H_ILLEGAL;
+
+	if (mode->vdisplay > 800)
+		return MODE_V_ILLEGAL;
+
+	return MODE_OK;
+}
+
+static const struct drm_bridge_funcs tegra_dbi_funcs = {
+	.attach = tegra_dbi_attach,
+	.mode_valid = tegra_dbi_mode_valid,
+
+	.atomic_enable = tegra_dbi_atomic_enable,
+	.atomic_disable = tegra_dbi_atomic_disable,
+	.atomic_check = tegra_dbi_atomic_check,
+
+	.atomic_create_state = drm_atomic_helper_bridge_create_state,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+};
+
+static const struct drm_bridge_timings default_tegra_dbi_timings = {
+	.input_bus_flags = DRM_BUS_FLAG_PIXDATA_SAMPLE_POSEDGE |
+			   DRM_BUS_FLAG_SYNC_SAMPLE_NEGEDGE |
+			   DRM_BUS_FLAG_DE_HIGH,
+};
+
+static int tegra_dbi_probe(struct platform_device *pdev)
+{
+	struct tegra_dbi_priv *priv;
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	struct drm_bridge *bridge;
+	struct drm_panel *panel;
+	struct device_node *ep;
+	int ret;
+
+	priv = devm_drm_bridge_alloc(dev, struct tegra_dbi_priv, bridge,
+				     &tegra_dbi_funcs);
+	if (IS_ERR(priv))
+		return PTR_ERR(priv);
+
+	priv->dev = dev;
+
+	ret = device_property_read_u32_array(dev, "nvidia,init-sequence",
+					     priv->spi_init_seq, 4);
+	if (ret < 0)
+		return dev_err_probe(dev, ret, "Failed to get init sequence\n");
+
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to probe children\n");
+
+	/* Initialize MIPI DBI interface */
+	mutex_init(&priv->dbi.cmdlock);
+	priv->dbi.command = tegra_dbi_dbi_command;
+
+	ret = drm_of_find_panel_or_bridge(np, 1, 0, &panel, &bridge);
+	if (ret)
+		return ret;
+
+	if (panel) {
+		bridge = devm_drm_panel_bridge_add_typed(dev, panel,
+							 DRM_MODE_CONNECTOR_DPI);
+		if (IS_ERR(bridge))
+			return PTR_ERR(bridge);
+	}
+
+	priv->output.bridge = bridge;
+	priv->output.panel = panel;
+
+	/* get input ep (port0/endpoint0) */
+	ret = -EINVAL;
+	ep = of_graph_get_endpoint_by_regs(np, 0, 0);
+	if (ep) {
+		ret = of_property_read_u32(ep, "bus-width", &priv->bus_width);
+		of_node_put(ep);
+	}
+
+	if (ret)
+		priv->bus_width = 24;
+
+	priv->bridge.of_node = np;
+	priv->bridge.timings = &default_tegra_dbi_timings;
+
+	ret = devm_drm_bridge_add(dev, &priv->bridge);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to add bridge\n");
+
+	platform_set_drvdata(pdev, priv);
+
+	return 0;
+}
+
+static struct platform_driver tegra_dbi_driver = {
+	.driver.name = "tegra-dbi",
+	.probe = tegra_dbi_probe,
+};
+module_platform_driver(tegra_dbi_driver);
+
+MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
+MODULE_DESCRIPTION("Nvidia Tegra20/30 MIPI-DBI Type B driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/tegra/dc.c b/drivers/gpu/drm/tegra/dc.c
index 5c67928bcabfa..8f12d30cd2d8b 100644
--- a/drivers/gpu/drm/tegra/dc.c
+++ b/drivers/gpu/drm/tegra/dc.c
@@ -223,6 +223,7 @@ void tegra_dc_commit(struct tegra_dc *dc)
 	tegra_dc_writel(dc, GENERAL_ACT_REQ << 8, DC_CMD_STATE_CONTROL);
 	tegra_dc_writel(dc, GENERAL_ACT_REQ, DC_CMD_STATE_CONTROL);
 }
+EXPORT_SYMBOL_GPL(tegra_dc_commit);
 
 static inline u32 compute_dda_inc(unsigned int in, unsigned int out, bool v,
 				  unsigned int bpp)
@@ -3279,9 +3280,15 @@ static int tegra_dc_init_opp_table(struct tegra_dc *dc)
 	return 0;
 }
 
+static void tegra_dc_release_dbi_pdev(void *pdev)
+{
+	platform_device_unregister(pdev);
+}
+
 static int tegra_dc_probe(struct platform_device *pdev)
 {
 	u64 dma_mask = dma_get_mask(pdev->dev.parent);
+	struct device_node *dbi_np;
 	struct tegra_dc *dc;
 	int err;
 
@@ -3382,6 +3389,28 @@ static int tegra_dc_probe(struct platform_device *pdev)
 		}
 	}
 
+	dbi_np = of_get_available_child_by_name(pdev->dev.of_node, "dbi");
+	if (dbi_np) {
+		struct platform_device_info dbi_info = {
+			.parent = &pdev->dev,
+			.name = "tegra-dbi",
+			.id = PLATFORM_DEVID_AUTO,
+			.fwnode = of_fwnode_handle(dbi_np),
+			.of_node_reused = true,
+		};
+
+		dc->dbi = platform_device_register_full(&dbi_info);
+		of_node_put(dbi_np);
+		if (IS_ERR(dc->dbi))
+			return dev_err_probe(&pdev->dev, PTR_ERR(dc->dbi),
+					     "Failed to create DBI device\n");
+
+		err = devm_add_action_or_reset(&pdev->dev, tegra_dc_release_dbi_pdev,
+					       dc->dbi);
+		if (err)
+			return err;
+	}
+
 	err = tegra_dc_rgb_probe(dc);
 	if (err < 0 && err != -ENODEV)
 		return dev_err_probe(&pdev->dev, err,
diff --git a/drivers/gpu/drm/tegra/dc.h b/drivers/gpu/drm/tegra/dc.h
index 7005df32f485f..27dbee57f8f72 100644
--- a/drivers/gpu/drm/tegra/dc.h
+++ b/drivers/gpu/drm/tegra/dc.h
@@ -95,6 +95,7 @@ struct tegra_dc {
 
 	struct tegra_output *rgb;
 	struct tegra_pmc *pmc;
+	struct platform_device *dbi;
 
 	struct tegra_dc_stats stats;
 	struct list_head list;
diff --git a/drivers/gpu/drm/tegra/trace.c b/drivers/gpu/drm/tegra/trace.c
index 006f65c72a344..3aeb3825e2100 100644
--- a/drivers/gpu/drm/tegra/trace.c
+++ b/drivers/gpu/drm/tegra/trace.c
@@ -1,2 +1,5 @@
 #define CREATE_TRACE_POINTS
 #include "trace.h"
+
+EXPORT_TRACEPOINT_SYMBOL_GPL(dc_readl);
+EXPORT_TRACEPOINT_SYMBOL_GPL(dc_writel);
-- 
2.53.0

