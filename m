Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5FA81F8DFFF
	for <dri-devel@archiver.kernel.org>; Fri, 17 Apr 2026 17:52:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A1E9110E2CC;
	Fri, 17 Apr 2026 17:52:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ddzRz2lO";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 92DB010E0BF
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 17:52:41 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-43d7645adbdso583082f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Apr 2026 10:52:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776448360; x=1777053160; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YhbgLeubF2RN2lH+zStno+/PjqYEJT3v2aCmxtmz9GQ=;
 b=ddzRz2lODc/FVrJzjc2O/PNBWriSMRQZMqTJv15hnV6Kh33v+L/abf0+3OGM/GMFgI
 WxvH+2UdURAUerMwIrOSicS2IjiPKIyoyQNeiOKKPNKDsM7cAR9uYE6vY6HILfJ41vEF
 8DF4bkIOIYEWur4DbX71rDtgaLmhYiZntG883W2a7v6z2Sa2vEuhwTegtHMiteheZpdw
 GUOVIve94T+ChUGwomF4B/+i06W3Q11Ed2kZ7II6+BDs1njolRKXYSXNCk69xve1mThD
 pDO7xMTAfn0ny6dO8EgktJ9DxXspjzl27aDUvrBmtImHLHgUaVvzevFB9d4NfVopTHd/
 KaTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776448360; x=1777053160;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YhbgLeubF2RN2lH+zStno+/PjqYEJT3v2aCmxtmz9GQ=;
 b=oDp4n8taR8ho4MiuIykV1t07Hy7iETbvHgXC9bheykruaw+IwP9ZXawn+89JDMUwXM
 kRhs4GE7Rh/uqgEifc73OgtwW9cDXK0gfMo2AUS0GOhyfz898wqwLLUSpVtCGPyuyCxN
 M+5HxWxjLWyCHjqGBulIqF6t2ACIWZ+RFyEGpEn5KBx3f9OK3hcvt45nQI09Wlz2+tAR
 FzVA+VrnOikYWodKGv4ENDsXn3adyvNziqSK9vwoxJXAOxdTmcgLnM7Uvi05X3GDXKRN
 9NdkbMNa09ZIvSNLS+nJdn+0YQvmzqybssIXaytRQqet/NiEAY5AvVG1zG/fIq3kcUIL
 t0pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/UkvnUsgB8HGRaOb4E5CGiBMZkmHbYQ9gfvj65LYMyoEj0V/8he+AR2WnykK5sV/pDmHLtIjZEeco=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YznITt3XofuWjlHdZhM5Ii1hOo8SoLuJHys1G/LMPMnBVHoJ6mj
 /PNQypRytEY3QAj6L4VeSGqUm5zplgCKZh1+Y+nU3xPhGvBABNHtSnUT
X-Gm-Gg: AeBDieuh4HY6v5iKWvKKi/mM7z9oB6A/tgzc4VaSd0R5L1c9CesKwSAoqVPOXzN1l3e
 MuaeDwYlFW3Yn4h8WYCaMWReqvLFvfY8nA3fJLGECnLSj0H0qkNS75aeLxgtMXE3ra11heCJZOF
 /0lFPrjk6G0BTwqY+k8+EZvqTfWBVXHcEIlvn3JSX1yXVuS5K8Yw8aynqKAFhg8K8d8UT/oSa5Q
 L9rm0afJDWZwhh2RwUFJdwIk9zr38kzLqrWoggX5rq5N97g+uW9f1vQFRMkEMmQE54FouxfwbpF
 gQIKzkQQrIhtgJT2wuYOewgFYE2cwysRx2mSMH3cq1GoOHXZvTaa+Bjb+L3JOKX22hfR8LFUAq7
 AVpLV4YLfqUH0hedn5DFWoM/aDNgqalUCK6wIOPT5GWgCLUtBOfUhLL5bjNw++TGviRaY6ekjcF
 CAooreb6h4oRemEitgFDLMyzvY3jpYSnU/PERpHqVw
X-Received: by 2002:a05:600c:3110:b0:487:243f:dc3e with SMTP id
 5b1f17b1804b1-488fb739cf6mr54402155e9.6.1776448359857; 
 Fri, 17 Apr 2026 10:52:39 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a758:8a01:528c:590:5bef:9bc8])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-488fc1c773fsm56166535e9.12.2026.04.17.10.52.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 17 Apr 2026 10:52:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
 linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Subject: [PATCH 3/3] drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder
Date: Fri, 17 Apr 2026 18:52:30 +0100
Message-ID: <20260417175235.224809-4-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
References: <20260417175235.224809-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
from 25 to 87 MHz. The LVDS module cannot be used at the same time as
MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
module.

Signed-off-by: Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>
Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 333 ++++++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h    |  22 ++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  26 ++
 5 files changed, 395 insertions(+)
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

diff --git a/drivers/gpu/drm/renesas/rz-du/Kconfig b/drivers/gpu/drm/renesas/rz-du/Kconfig
index 7f2ef7137ae5..cbfc7b6bccb8 100644
--- a/drivers/gpu/drm/renesas/rz-du/Kconfig
+++ b/drivers/gpu/drm/renesas/rz-du/Kconfig
@@ -26,3 +26,16 @@ config DRM_RZG2L_MIPI_DSI
 	def_tristate DRM_RZG2L_DU
 	depends on DRM_RZG2L_USE_MIPI_DSI
 	select DRM_MIPI_DSI
+
+config DRM_RZG3L_USE_LVDS
+	bool "RZ/G3L DU LVDS Encoder Support"
+	depends on DRM_BRIDGE && OF
+	default DRM_RZG2L_DU
+	help
+	  Enable support for the RZ/G3L Display Unit embedded LVDS encoders.
+
+config DRM_RZG3L_LVDS
+	def_tristate DRM_RZG2L_DU
+	depends on DRM_RZG3L_USE_LVDS
+	select DRM_KMS_HELPER
+	select DRM_PANEL
diff --git a/drivers/gpu/drm/renesas/rz-du/Makefile b/drivers/gpu/drm/renesas/rz-du/Makefile
index 2987900ea6b6..46decb7ac4f1 100644
--- a/drivers/gpu/drm/renesas/rz-du/Makefile
+++ b/drivers/gpu/drm/renesas/rz-du/Makefile
@@ -8,3 +8,4 @@ rzg2l-du-drm-$(CONFIG_VIDEO_RENESAS_VSP1)	+= rzg2l_du_vsp.o
 obj-$(CONFIG_DRM_RZG2L_DU)		+= rzg2l-du-drm.o
 
 obj-$(CONFIG_DRM_RZG2L_MIPI_DSI)	+= rzg2l_mipi_dsi.o
+obj-$(CONFIG_DRM_RZG3L_LVDS)		+= rzg3l_lvds.o
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
new file mode 100644
index 000000000000..bedeedbdfada
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
@@ -0,0 +1,333 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * RZ/G3L LVDS Encoder Driver
+ *
+ * Copyright (C) 2026 Renesas Electronics Corporation
+ */
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/io.h>
+#include <linux/media-bus-format.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/of_graph.h>
+#include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
+#include <linux/regmap.h>
+#include <linux/reset.h>
+
+#include <drm/drm_atomic.h>
+#include <drm/drm_atomic_helper.h>
+#include <drm/drm_bridge.h>
+#include <drm/drm_of.h>
+#include <drm/drm_panel.h>
+#include <drm/drm_probe_helper.h>
+
+#include "rzg3l_lvds.h"
+#include "rzg3l_lvds_regs.h"
+
+enum rzg3l_lvds_mode {
+	RZG3L_LVDS_MODE_JEIDA = 0,
+	RZG3L_LVDS_MODE_JEIDA_MIRROR = 1,
+	RZG3L_LVDS_MODE_MODE2 = 2,
+	RZG3L_LVDS_MODE_MODE2_MIRROR = 3,
+	RZG3L_LVDS_MODE_VESA = 4,
+	RZG3L_LVDS_MODE_VESA_MIRROR = 5,
+	RZG3L_LVDS_MODE_MODE6 = 6,
+	RZG3L_LVDS_MODE_MODE6_MIRROR = 7,
+};
+
+struct rzg3l_lvds {
+	struct device *dev;
+	struct reset_control *prstc;
+	struct reset_control *lvd_rstc;
+	struct regmap *regmap;
+
+	struct drm_bridge bridge;
+	struct drm_bridge *next_bridge;
+};
+
+#define bridge_to_rzg3l_lvds(b) \
+	container_of(b, struct rzg3l_lvds, bridge)
+
+/* -----------------------------------------------------------------------------
+ * Bridge
+ */
+static void rzg3l_lvds_atomic_enable(struct drm_bridge *bridge,
+				     struct drm_atomic_state *state)
+{
+	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
+	const struct drm_bridge_state *bridge_state;
+	int ret;
+	u32 fmt;
+
+	/* Get the LVDS format from the bridge state. */
+	bridge_state = drm_atomic_get_new_bridge_state(state, bridge);
+	if (!bridge_state) {
+		dev_err(lvds->dev, "failed to get bridge state\n");
+		return;
+	}
+
+	switch (bridge_state->output_bus_cfg.format) {
+	case MEDIA_BUS_FMT_RGB888_1X7X4_JEIDA:
+		fmt = RZG3L_LVDS_MODE_JEIDA;
+		break;
+	case MEDIA_BUS_FMT_RGB888_1X7X4_SPWG:
+		fmt = RZG3L_LVDS_MODE_VESA;
+		break;
+	default:
+		fmt = RZG3L_LVDS_MODE_VESA;
+		dev_warn(lvds->dev, "Unsupported bus fmt 0x%04x\n",
+			 bridge_state->output_bus_cfg.format);
+		break;
+	}
+
+	ret = pm_runtime_resume_and_get(lvds->dev);
+	if (ret < 0) {
+		dev_err(lvds->dev, "pm_runtime_resume_and_get error\n");
+		return;
+	}
+
+	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
+			   LVDS_0_PHY_CH_EN_BGR, LVDS_0_PHY_CH_EN_BGR);
+	usleep_range(20, 25);
+
+	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
+			   LVDS_0_PHY_CH_EN_LDO, LVDS_0_PHY_CH_EN_LDO);
+	usleep_range(10, 15);
+
+	regmap_write(lvds->regmap, LVDS_CMN, LVDS_CMN_RST_PHY0_SEL);
+	regmap_update_bits(lvds->regmap, LVDS_0_CTL_OFFSET,
+			   LVDS_0_CTL_FMT_SEL_MSK,
+			   FIELD_PREP(LVDS_0_CTL_FMT_SEL_MSK, fmt));
+	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
+			   LVDS_0_PHY_CH_IO_EN_MSK, LVDS_0_PHY_CH_IO_EN);
+	regmap_write(lvds->regmap, LVDS_CMN,
+		     LVDS_CMN_RST_PHY0_SEL | LVDS_CMN_PHY_RESET);
+	usleep_range(100, 150);
+}
+
+static void rzg3l_lvds_atomic_disable(struct drm_bridge *bridge,
+				      struct drm_atomic_state *state)
+{
+	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
+
+	regmap_update_bits(lvds->regmap, LVDS_CMN, LVDS_CMN_PHY_RESET, 0);
+	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
+			   LVDS_0_PHY_CH_IO_EN_MSK, 0);
+	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
+			   LVDS_0_PHY_CH_EN_LDO, 0);
+	regmap_update_bits(lvds->regmap, LVDS_0_PHY_OFFSET,
+			   LVDS_0_PHY_CH_EN_BGR, 0);
+
+	pm_runtime_put(lvds->dev);
+}
+
+static int rzg3l_lvds_attach(struct drm_bridge *bridge,
+			     struct drm_encoder *encoder,
+			     enum drm_bridge_attach_flags flags)
+{
+	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
+
+	if (!lvds->next_bridge)
+		return 0;
+
+	return drm_bridge_attach(encoder, lvds->next_bridge, bridge, flags);
+}
+
+static enum drm_mode_status
+rzg3l_lvds_bridge_mode_valid(struct drm_bridge *bridge,
+			     const struct drm_display_info *info,
+			     const struct drm_display_mode *mode)
+{
+	if (mode->clock > 87000)
+		return MODE_CLOCK_HIGH;
+
+	if (mode->clock < 25000)
+		return MODE_CLOCK_LOW;
+
+	return MODE_OK;
+}
+
+bool rzg3l_lvds_is_connected(struct drm_bridge *bridge)
+{
+	struct rzg3l_lvds *lvds = bridge_to_rzg3l_lvds(bridge);
+
+	return !!lvds->next_bridge;
+}
+EXPORT_SYMBOL_GPL(rzg3l_lvds_is_connected);
+
+static const struct drm_bridge_funcs rzg3l_lvds_bridge_ops = {
+	.attach = rzg3l_lvds_attach,
+	.atomic_duplicate_state = drm_atomic_helper_bridge_duplicate_state,
+	.atomic_destroy_state = drm_atomic_helper_bridge_destroy_state,
+	.atomic_reset = drm_atomic_helper_bridge_reset,
+	.atomic_enable = rzg3l_lvds_atomic_enable,
+	.atomic_disable = rzg3l_lvds_atomic_disable,
+	.mode_valid = rzg3l_lvds_bridge_mode_valid,
+};
+
+/* -----------------------------------------------------------------------------
+ * Power Management
+ */
+
+static int rzg3l_lvds_pm_runtime_suspend(struct device *dev)
+{
+	struct rzg3l_lvds *lvds = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_assert(lvds->lvd_rstc);
+	if (ret)
+		return ret;
+
+	ret = reset_control_assert(lvds->prstc);
+	if (ret)
+		goto err_deassert_lvd_rstc;
+
+	return 0;
+
+err_deassert_lvd_rstc:
+	reset_control_deassert(lvds->lvd_rstc);
+	return ret;
+}
+
+static int rzg3l_lvds_pm_runtime_resume(struct device *dev)
+{
+	struct rzg3l_lvds *lvds = dev_get_drvdata(dev);
+	int ret;
+
+	ret = reset_control_deassert(lvds->prstc);
+	if (ret)
+		return ret;
+
+	return reset_control_deassert(lvds->lvd_rstc);
+	if (ret)
+		goto err_assert_prstc;
+
+	return 0;
+
+err_assert_prstc:
+	reset_control_assert(lvds->prstc);
+	return ret;
+}
+
+static const struct dev_pm_ops rzg3l_lvds_pm_ops = {
+	RUNTIME_PM_OPS(rzg3l_lvds_pm_runtime_suspend,
+		       rzg3l_lvds_pm_runtime_resume, NULL)
+	SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend, pm_runtime_force_resume)
+};
+
+/* -----------------------------------------------------------------------------
+ * Probe & Remove
+ */
+
+static int rzg3l_lvds_parse_dt(struct rzg3l_lvds *lvds)
+{
+	struct device *dev = lvds->dev;
+	struct drm_panel *panel;
+	int ret;
+
+	ret = drm_of_find_panel_or_bridge(dev->of_node, 1, 0,
+					  &panel, &lvds->next_bridge);
+	if (ret)
+		return ret;
+
+	if (panel) {
+		lvds->next_bridge = devm_drm_panel_bridge_add(dev, panel);
+		if (IS_ERR_OR_NULL(lvds->next_bridge))
+			return -EINVAL;
+	}
+
+	return 0;
+}
+
+static int rzg3l_lvds_probe(struct platform_device *pdev)
+{
+	struct reset_control *rstc, *arstc;
+	struct device *dev = &pdev->dev;
+	struct rzg3l_lvds *lvds;
+	int ret;
+
+	lvds = devm_drm_bridge_alloc(dev, struct rzg3l_lvds, bridge,
+				     &rzg3l_lvds_bridge_ops);
+	if (IS_ERR(lvds))
+		return PTR_ERR(lvds);
+
+	lvds->dev = dev;
+	lvds->bridge.of_node = pdev->dev.of_node;
+
+	lvds->regmap = syscon_node_to_regmap(dev->of_node->parent);
+	if (IS_ERR(lvds->regmap))
+		return PTR_ERR(lvds->regmap);
+
+	rstc = devm_reset_control_get_optional_exclusive(dev, "rst");
+	if (IS_ERR(rstc))
+		return dev_err_probe(dev, PTR_ERR(rstc), "failed to get rst\n");
+
+	arstc = devm_reset_control_get_optional_exclusive(dev, "arst");
+	if (IS_ERR(arstc))
+		return dev_err_probe(dev, PTR_ERR(arstc),
+				     "failed to get arst\n");
+
+	lvds->prstc = devm_reset_control_get_shared(dev, "prst");
+	if (IS_ERR(lvds->prstc))
+		return dev_err_probe(dev, PTR_ERR(lvds->prstc),
+				     "failed to get prst\n");
+
+	lvds->lvd_rstc = devm_reset_control_get_shared(dev, "lvdrst");
+	if (IS_ERR(lvds->lvd_rstc))
+		return dev_err_probe(dev, PTR_ERR(lvds->lvd_rstc),
+				     "failed to get core reset\n");
+
+	platform_set_drvdata(pdev, lvds);
+
+	ret = devm_pm_runtime_enable(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to enable Runtime PM\n");
+
+	ret = rzg3l_lvds_parse_dt(lvds);
+	if (ret < 0)
+		return ret;
+
+	ret = reset_control_assert(rstc);
+	if (ret < 0)
+		return ret;
+
+	ret = reset_control_assert(arstc);
+	if (ret < 0)
+		return ret;
+
+	ret = devm_drm_bridge_add(dev, &lvds->bridge);
+	if (ret)
+		return dev_err_probe(dev, ret,
+				     "Failed to register drm bridge\n");
+
+	return ret;
+}
+
+static const struct of_device_id rzg3l_lvds_of_table[] = {
+	{ .compatible = "renesas,r9a08g046-lvds" },
+	{ /* sentinel */ }
+};
+
+MODULE_DEVICE_TABLE(of, rzg3l_lvds_of_table);
+
+static struct platform_driver rzg3l_lvds_platform_driver = {
+	.probe		= rzg3l_lvds_probe,
+	.driver		= {
+		.name	= "rzg3l-lvds",
+		.pm	= pm_ptr(&rzg3l_lvds_pm_ops),
+		.of_match_table = rzg3l_lvds_of_table,
+	},
+};
+
+module_platform_driver(rzg3l_lvds_platform_driver);
+
+MODULE_AUTHOR("Biju Das <biju.das.jz@bp.renesas.com>");
+MODULE_AUTHOR("Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>");
+MODULE_DESCRIPTION("Renesas RZ/G3L LVDS Encoder Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h
new file mode 100644
index 000000000000..2ea3cf4e1cae
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RZ/G3L LVDS Encoder
+ *
+ * Copyright (C) 2026 Renesas Electronics Corporation
+ *
+ */
+
+#ifndef __RZG3L_LVDS_H__
+#define __RZG3L_LVDS_H__
+
+struct drm_bridge;
+
+#if IS_ENABLED(CONFIG_DRM_RZG3L_LVDS)
+bool rzg3l_lvds_is_connected(struct drm_bridge *bridge);
+#else
+static inline bool rzg3l_lvds_is_connected(struct drm_bridge *bridge)
+{
+	return false;
+}
+#endif /* CONFIG_DRM_RZG3L_LVDS */
+#endif /* __RZG3L_LVDS_H__ */
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
new file mode 100644
index 000000000000..281b7648f168
--- /dev/null
+++ b/drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h
@@ -0,0 +1,26 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * RZ/G3L LVDS Interface Registers Definitions
+ *
+ * Copyright (C) 2026 Renesas Electronics Corporation
+ *
+ */
+
+#ifndef __RZG3L_LVDS_REGS_H__
+#define __RZG3L_LVDS_REGS_H__
+
+#define LVDS_CMN			0x00
+#define LVDS_CMN_RST_PHY0_SEL		(1 << 24)
+#define LVDS_CMN_RST_PHY0_SEL_CH0	(1 << 24)
+#define LVDS_CMN_PHY_RESET		(1 << 0)
+
+#define LVDS_0_PHY_OFFSET		0x10
+#define LVDS_0_PHY_CH_IO_EN_MSK		(0x1f)
+#define LVDS_0_PHY_CH_IO_EN		(LVDS_0_PHY_CH_IO_EN_MSK << 0)
+#define LVDS_0_PHY_CH_EN_BGR		BIT(8)
+#define LVDS_0_PHY_CH_EN_LDO		BIT(9)
+
+#define LVDS_0_CTL_OFFSET		0x14
+#define LVDS_0_CTL_FMT_SEL_MSK		GENMASK(23, 20)
+
+#endif /* __RZG3L_LVDS_REGS_H__ */
-- 
2.43.0

