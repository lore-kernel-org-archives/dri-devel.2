Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 66EDA606A321
	for <dri-devel@archiver.kernel.org>; Thu, 22 Oct 2026 13:24:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ooeSK5v5
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C81EA11261C;
	Thu, 22 Oct 2026 13:23:57 +0000 (UTC)
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 79AFD11261C
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 13:23:47 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-6b3dd83e779so3219479a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 22 Oct 2026 06:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1792675426; x=1793280226; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=1B+px64c1MKu5KCBHRGWLd8KLh+jyRvqQIQFUlGlXkM=;
 b=ooeSK5v5tr4EmkZBEnPcsB+ljk53qC4Puxqzh3POladaLABD+8C0G0OuJmKn1DhRkp
 ny3W4b5tWrQKMaMEi59iWpc2GDtmYeLfVaorBSspVT7GfQDzuQDjU7MSJ8ObQPnKut1V
 hVnIgB+cd5IyIhvGXBc/GPHeIRFcVhHMW1nA0bDOPaly0TcWg2GX/tCywGawF5h4nxsT
 eeBMABksBGdWWvroIu8sPnSuE51lE6Ft1OLr/tYnxQ7wd9jCDs39IrzqGreA5vAQ91DQ
 LZd3Rzb/lkaNsj86MtMYRjoVdb/iApUKFn89mJgtz7wF+GOyXpzkyc6LitUqlceOeLvM
 yKZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1792675426; x=1793280226;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=1B+px64c1MKu5KCBHRGWLd8KLh+jyRvqQIQFUlGlXkM=;
 b=OEgLocgcGPlTCAXROM1Ad8SF0sxWVUJmAWQtBXbXqOc6n5Tuam+VZAdMsUtcN/rAcS
 Hntz8RsW6muBLLJBDSChV8CRhES7bMzO50sIalsO9DofuLzdipuQFUaZyWKjzu1l3qNu
 csSnX1N8Areh4qolKjrWXbkLMf+ffZg95JC5IMgChQP/iwcWaSFo8cZvBqiNcOkz5loW
 WLh3urzxRct/qQUBkWwyOMK98NeDLM+9t404bijLQM4/7/o8m94McfAUM3FXGdjzFSka
 rptw8HZon910zcyZl+u54mdlvenfav9f3zvEHejQNgODphCAjmlq3Lhc0jUIOI5T48rw
 OmHg==
X-Gm-Message-State: AFq9FYIiDhk1Yxikd1lg+OBsoPMlUsKVoRUbnmXOi8U7OYNO73ZKaReS
 ibl6mcS6bfVO6Q6iN07ykKDO5Kg0TRzG1ShBnOTLD8mDy/Og4TfBG/Zt
X-Gm-Gg: AYBFou16Bv/MXUWsXrYkd68aKi05bWLxi8uJJ/fD5CTnmwlFYK6DB3hP0JGYiLGHpNo
 6nmDScSD8JCTthQkZvJp+iIQFn1Vif/KIhZCl1xnZeXW+mooCagTUjcVt2BxRNnb1g6V1T9CfxC
 usykqiYkDddG+EWtV2VwcSTIr3fL1Hrrh+beRNtHRmt/CKIc75jl4p5EWcAWWUG9bWhB3C4fKWv
 RxpeD2VVf96s3gmdhl0WOlIdWZerXVPEZaD3skbMMmHtXwUle3OBhK/Cr+/ynDgjFuftHpp8ytS
 W5Bp++C+jFkMjN/s4pxWkd7q/pjFZI9+HBJAsnltQenxxyOKQYUBvMgQiNEBIvRhi/KHPXfLnIK
 ox6fk0S4aAKQENKHr9M8QtdoD+A2eXOjPpTbHRy4n8OaTPFuhoa0rXLzPznlywhzq5velxMU36X
 q3wU0ogcg2JhIY0Mkig3e7Db+wPypQVLhTfZ5YonMdC5eS37TCaOFpZeLedIcctiTJzoaRYnGGV
 adeP1x8aQtNiOZzfQbm1LD9VpnEprfW/FxvtWJEc7d4pglFggmMUUb1c/ZI5H9hhC0oPeQLrex7
 pHgVosI=
X-Received: by 2002:a05:6402:4020:b0:6aa:7ff:4ebf with SMTP id
 4fb4d7f45d1cf-6b408e9d75fmr4917726a12.15.1792675425583; 
 Thu, 22 Oct 2026 06:23:45 -0700 (PDT)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 4fb4d7f45d1cf-6b40313074esm1818061a12.27.2026.10.22.06.23.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 22 Oct 2026 06:23:44 -0700 (PDT)
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
Subject: [PATCH v4 7/7] drm/tegra: Add support for 8-bit CPU interface
Date: Thu, 22 Oct 2026 16:22:59 +0300
Message-ID: <20261022132259.240717-8-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261022132259.240717-1-clamor95@gmail.com>
References: <20261022132259.240717-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNWANTED_LANGUAGE_BODY,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

The display controller in Tegra20/30 SoCs features an 8-bit SPI interface
that closely resembles the MIPI DBI Type B protocol and is referred to as
'8-bit CPU'. Each display controller provides two such interfaces, which
can be used to send MIPI DCS commands to initialize and control the panel
while image data is transmitted via 16/18/24-line RGB.

The '8-bit CPU', although being the DC interface, is modeled using a
bridge framework for flexibility and convenience. This implementation does
not change the existing codebase besides registering an interface and can
be enabled/disabled without losing other Tegra DRM functionality.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/tegra/Kconfig  |   7 +
 drivers/gpu/drm/tegra/Makefile |   3 +
 drivers/gpu/drm/tegra/dbi.c    | 536 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/dc.c     |  29 ++
 drivers/gpu/drm/tegra/dc.h     |   1 +
 drivers/gpu/drm/tegra/trace.c  |   3 +
 6 files changed, 579 insertions(+)
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
index 0000000000000..7bd90d32053f2
--- /dev/null
+++ b/drivers/gpu/drm/tegra/dbi.c
@@ -0,0 +1,536 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/delay.h>
+#include <linux/device.h>
+#include <linux/err.h>
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
+#define TEGRA_DBI_INTERFACE_MAX			2
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
+	struct drm_bridge bridge;
+	struct tegra_dbi_output output;
+
+	const struct tegra_dbi_interface *index;
+
+	u32 bus_width;
+	u32 idx;
+	bool active;
+};
+
+struct reg_entry {
+	u32 offset;
+	u32 value;
+};
+
+/*
+ * This is used to backup and restore COM pin state during
+ * tegra_dbi_atomic_enable/disable.
+ */
+static struct reg_entry com_pin_output[] = {
+	{ DC_COM_PIN_OUTPUT_ENABLE(0),   0 },
+	{ DC_COM_PIN_OUTPUT_ENABLE(1),   0 },
+	{ DC_COM_PIN_OUTPUT_ENABLE(2),   0 },
+	{ DC_COM_PIN_OUTPUT_ENABLE(3),   0 },
+	{ DC_COM_PIN_OUTPUT_POLARITY(0), 0 },
+	{ DC_COM_PIN_OUTPUT_POLARITY(1), 0 },
+	{ DC_COM_PIN_OUTPUT_POLARITY(2), 0 },
+	{ DC_COM_PIN_OUTPUT_POLARITY(3), 0 },
+	{ DC_COM_PIN_OUTPUT_DATA(0),     0 },
+	{ DC_COM_PIN_OUTPUT_DATA(1),     0 },
+	{ DC_COM_PIN_OUTPUT_DATA(2),     0 },
+	{ DC_COM_PIN_OUTPUT_DATA(3),     0 },
+	{ DC_COM_PIN_OUTPUT_SELECT(0),   0 },
+	{ DC_COM_PIN_OUTPUT_SELECT(1),   0 },
+	{ DC_COM_PIN_OUTPUT_SELECT(2),   0 },
+	{ DC_COM_PIN_OUTPUT_SELECT(3),   0 },
+	{ DC_COM_PIN_OUTPUT_SELECT(4),   0 },
+	{ DC_COM_PIN_OUTPUT_SELECT(5),   0 },
+	{ DC_COM_PIN_OUTPUT_SELECT(6),   0 },
+};
+
+struct pin {
+	u32 reg;
+	u32 pos;
+};
+
+struct tegra_dbi_interface {
+	struct pin dc;
+	struct pin rw;
+	struct pin cs;
+	struct pin data[TEGRA_DBI_DATA_PINS_MAX];
+};
+
+static const struct tegra_dbi_interface tegra_dbi_idx[TEGRA_DBI_INTERFACE_MAX] = {
+	/*
+	 * Nvidia Primary 8-bit CPU interface configuration:
+	 * DC = LCD_DC0/LDC; RW = LCD_PCLK/LSC0; CS = LCD_CS0_N/LCSN
+	 *	DATA = LD0 - LD7
+	 */
+	{
+		.dc = { DC_COM_PIN_OUTPUT_DATA(3), 6 },
+		.rw = { DC_COM_PIN_OUTPUT_DATA(1), 24 },
+		.cs = { DC_COM_PIN_OUTPUT_DATA(3), 4 },
+		.data = {
+			{ DC_COM_PIN_OUTPUT_DATA(0), 0 },
+			{ DC_COM_PIN_OUTPUT_DATA(0), 2 },
+			{ DC_COM_PIN_OUTPUT_DATA(0), 4 },
+			{ DC_COM_PIN_OUTPUT_DATA(0), 6 },
+			{ DC_COM_PIN_OUTPUT_DATA(0), 8 },
+			{ DC_COM_PIN_OUTPUT_DATA(0), 10 },
+			{ DC_COM_PIN_OUTPUT_DATA(0), 12 },
+			{ DC_COM_PIN_OUTPUT_DATA(0), 14 },
+		},
+	},
+	/*
+	 * Nvidia Secondary 8-bit CPU interface configuration:
+	 * DC = LCD_DC1/LVP0; RW = LCD_WR_N/LSC1; CS = LCD_CS1_N/LM0
+	 *	DATA0 = LCD_D18/LHP1	DATA4 = LCD_PWR0/LPW0
+	 *	DATA1 = LCD_M1/LM1	DATA5 = LCD_PWR2/LPW2
+	 *	DATA2 = LCD_D22/LDI	DATA6 = LCD_D20/LVP1
+	 *	DATA3 = LCD_D23/LPP	DATA7 = LCD_D21/LHP0
+	 */
+	{
+		.dc = { DC_COM_PIN_OUTPUT_DATA(2), 8 },
+		.rw = { DC_COM_PIN_OUTPUT_DATA(1), 26 },
+		.cs = { DC_COM_PIN_OUTPUT_DATA(3), 16 },
+		.data = {
+			{ DC_COM_PIN_OUTPUT_DATA(2), 2 },
+			{ DC_COM_PIN_OUTPUT_DATA(2), 18 },
+			{ DC_COM_PIN_OUTPUT_DATA(2), 20 },
+			{ DC_COM_PIN_OUTPUT_DATA(2), 22 },
+			{ DC_COM_PIN_OUTPUT_DATA(1), 16 },
+			{ DC_COM_PIN_OUTPUT_DATA(1), 20 },
+			{ DC_COM_PIN_OUTPUT_DATA(2), 10 },
+			{ DC_COM_PIN_OUTPUT_DATA(2), 0 },
+		},
+	},
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
+static void tegra_dbi_pin_set(struct tegra_dc *dc, const struct pin *pin, int value)
+{
+	u32 val;
+
+	val = tegra_dc_readl(dc, pin->reg);
+	val |= BIT(pin->pos + 1); /* unmask is 1 bit above position */
+	if (value)
+		val |= BIT(pin->pos);
+	else
+		val &= ~BIT(pin->pos);
+	tegra_dc_writel(dc, val, pin->reg);
+}
+
+static void tegra_dbi_write(struct tegra_dbi_priv *priv, u8 type, u8 value)
+{
+	struct tegra_dc *dc = priv->dc;
+	const struct tegra_dbi_interface *idx = priv->index;
+
+	tegra_dbi_pin_set(dc, &idx->dc, type);
+
+	tegra_dbi_pin_set(dc, &idx->cs, 0);
+	tegra_dbi_pin_set(dc, &idx->rw, 0);
+
+	for (int i = 0; i < TEGRA_DBI_DATA_PINS_MAX; i++)
+		tegra_dbi_pin_set(dc, &idx->data[i], BIT(i) & value);
+
+	tegra_dbi_pin_set(dc, &idx->cs, 1);
+	tegra_dbi_pin_set(dc, &idx->rw, 1);
+
+	udelay(10);
+}
+
+static int tegra_dbi_dbi_command(struct mipi_dbi *dbi, u8 *cmd, u8 *param, size_t num)
+{
+	struct tegra_dbi_priv *priv = mipi_dbi_to_tegra_dbi(dbi);
+	u8 command = *cmd;
+
+	/* Blocks all commands when interface is not active */
+	if (!priv->active)
+		return -ENODEV;
+
+	tegra_dbi_write(priv, TEGRA_DBI_COMMAND, command);
+
+	for (int i = 0; i < num; i++)
+		tegra_dbi_write(priv, TEGRA_DBI_DATA, param[i]);
+
+	return 0;
+}
+
+static void tegra_dbi_init_primary_interface(struct tegra_dbi_priv *priv)
+{
+	struct tegra_dc *dc = priv->dc;
+	u32 value;
+
+	/* Set LCSN and LDC to output enable */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_ENABLE(3));
+	value &= ~(BIT(4) | BIT(6));
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_ENABLE(3));
+
+	/* Set LSC0/LCSN/LDC output polarity HIGH */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_POLARITY(1));
+	value &= ~BIT(24);
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_POLARITY(1));
+
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_POLARITY(3));
+	value &= ~(BIT(4) | BIT(6));
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_POLARITY(3));
+
+	/* Select output for pins LD0 - LD7 */
+	tegra_dc_writel(dc, 0x11111111, DC_COM_PIN_OUTPUT_SELECT(0));
+
+	/* Select output for pins LSC0/LCSN/LDC */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(3));
+	value &= ~0x70000;
+	value |= BIT(16);
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(3));
+
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
+	value &= ~0x7700;
+	value |= BIT(12) | BIT(8);
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
+}
+
+static void tegra_dbi_init_secondary_interface(struct tegra_dbi_priv *priv)
+{
+	struct tegra_dc *dc = priv->dc;
+	u32 value;
+
+	/* Set LPP/LDI to output enable */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_ENABLE(2));
+	value &= ~(BIT(20) | BIT(22));
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_ENABLE(2));
+
+	/* Select output for pins LSC1/LPW2/LPW0 */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(3));
+	value &= ~0x700707;
+	value |= BIT(20) | BIT(8) | BIT(0);
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(3));
+
+	/* Select output for pins LVP1/LVP0/LHP1/LHP0 */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(4));
+	value &= ~0x770077;
+	value |= BIT(20) | BIT(16) | BIT(4) | BIT(0);
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(4));
+
+	/* Select output for pins LPP/LDI/LM1/LM0 */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(5));
+	value &= ~0x7777;
+	value |= BIT(12) | BIT(8) | BIT(4) | BIT(0);
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(5));
+}
+
+static void tegra_dbi_atomic_enable(struct drm_bridge *bridge,
+				    struct drm_atomic_commit *state)
+{
+	struct tegra_dbi_priv *priv = bridge_to_tegra_dbi(bridge);
+	struct tegra_dc *dc = priv->dc;
+	u32 value;
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
+	tegra_dc_writel(dc, PULSE_END(1), DC_DISP_V_PULSE1_POSITION_A);
+	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_B);
+	tegra_dc_writel(dc, 0, DC_DISP_V_PULSE1_POSITION_C);
+
+	value = 1 << FRAME_INIT_SEQ_CYCLES_SHIFT |
+		DC_SIGNAL_VPULSE1 << INIT_SEQ_DC_SIGNAL_SHIFT |
+		INIT_SEQUENCE_MODE_PLCD | SEND_INIT_SEQUENCE;
+	tegra_dc_writel(dc, value, DC_DISP_INIT_SEQ_CONTROL);
+
+	/* Generic sequence for DBI command panels */
+	tegra_dc_writel(dc, 0x2c, DC_DISP_SPI_INIT_SEQ_DATA_A);
+	tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_B);
+	tegra_dc_writel(dc, 0x0, DC_DISP_SPI_INIT_SEQ_DATA_C);
+	tegra_dc_writel(dc, 0x5000, DC_DISP_SPI_INIT_SEQ_DATA_D);
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
+	/*
+	 * Backup registers before unshadowing since actual register values
+	 * may differ and their state backed up now is the correct one.
+	 */
+	for (int i = 0; i < ARRAY_SIZE(com_pin_output); i++)
+		com_pin_output[i].value = tegra_dc_readl(dc, com_pin_output[i].offset);
+
+	/* Unshadow to set up command and data pins */
+	tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);
+
+	if (priv->idx)
+		tegra_dbi_init_secondary_interface(priv);
+	else
+		tegra_dbi_init_primary_interface(priv);
+
+	priv->active = true;
+
+	if (priv->output.panel)
+		drm_panel_enable(priv->output.panel);
+
+	tegra_dbi_pin_set(dc, &priv->index->cs, 0);
+
+	priv->active = false;
+
+	for (int i = 0; i <  ARRAY_SIZE(com_pin_output); i++)
+		tegra_dc_writel(dc, com_pin_output[i].value, com_pin_output[i].offset);
+
+	/* Set LDC pin to V Pulse 1 */
+	value = tegra_dc_readl(dc, DC_COM_PIN_OUTPUT_SELECT(6));
+	value |= LDC_OUTPUT_SELECT_V_PULSE1;
+	tegra_dc_writel(dc, value, DC_COM_PIN_OUTPUT_SELECT(6));
+
+	value = tegra_dc_readl(dc, DC_CMD_DISPLAY_COMMAND);
+	value &= ~DISP_CTRL_MODE_MASK;
+	value |= DISP_CTRL_MODE_C_DISPLAY;
+	tegra_dc_writel(dc, value, DC_CMD_DISPLAY_COMMAND);
+
+	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
+}
+
+static void tegra_dbi_atomic_disable(struct drm_bridge *bridge,
+				     struct drm_atomic_commit *state)
+{
+	struct tegra_dbi_priv *priv = bridge_to_tegra_dbi(bridge);
+	struct tegra_dc *dc = priv->dc;
+
+	for (int i = 0; i < ARRAY_SIZE(com_pin_output); i++)
+		com_pin_output[i].value = tegra_dc_readl(dc, com_pin_output[i].offset);
+
+	tegra_dc_writel(dc, WRITE_MUX, DC_CMD_STATE_ACCESS);
+
+	if (priv->idx)
+		tegra_dbi_init_secondary_interface(priv);
+	else
+		tegra_dbi_init_primary_interface(priv);
+
+	priv->active = true;
+
+	if (priv->output.panel)
+		drm_panel_disable(priv->output.panel);
+
+	priv->active = false;
+
+	for (int i = 0; i <  ARRAY_SIZE(com_pin_output); i++)
+		tegra_dc_writel(dc, com_pin_output[i].value, com_pin_output[i].offset);
+
+	tegra_dc_writel(dc, 0, DC_CMD_STATE_ACCESS);
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
+	/* Default to primaty */
+	device_property_read_u32(dev, "nvidia,index", &priv->idx);
+	if (priv->idx)
+		priv->index = &tegra_dbi_idx[1];
+	else
+		priv->index = &tegra_dbi_idx[0];
+
+	/* Initialize MIPI DBI interface */
+	mutex_init(&priv->dbi.cmdlock);
+	priv->dbi.command = tegra_dbi_dbi_command;
+
+	ret = devm_of_platform_populate(dev);
+	if (ret)
+		return dev_err_probe(dev, ret, "Failed to probe children\n");
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
+MODULE_ALIAS("platform:tegra-dbi");
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

