Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3F018108B8F3
	for <dri-devel@archiver.kernel.org>; Fri, 20 Mar 2026 10:47:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9560210EAB8;
	Fri, 20 Mar 2026 10:47:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="I4PzVzb1";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 86FF610EAB8
 for <dri-devel@lists.freedesktop.org>; Fri, 20 Mar 2026 10:47:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 78CC11A2F1B;
 Fri, 20 Mar 2026 10:47:47 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 47D23601A0;
 Fri, 20 Mar 2026 10:47:47 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EBDD110450B97; Fri, 20 Mar 2026 11:47:35 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774003664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=5G7RwZVT0cLv89cnUOQqWhPwxDiqoXXImEAhtCM4UBQ=;
 b=I4PzVzb13TLDpsWD86Xf1LnxDItNfPdLQqcchBZIAbf/l3V5OxBoR77gYCp4V2B4P3FtND
 ZWYxY+XskZIi5SeicAOR/nzFqZfpS/E0X8G95OQ/Ai8EASpKYkvhVi4ssOGVmu0GHolmfI
 D5o1XdhqpReZqi0FkxMpShiuVJaPcRKH12IBrTFKaoVW11FFtlyV7UTOaYYKZUYuiu7RA8
 4+RkgUr/N+vH7pe9HZq0Jir6NnV9dwBifDl001om9VOffC+cZZdFTAh5jgqunzRXeOMjoc
 8hQAkAfHmExObMYsjQja6trmZbIUseirbyfRGzOkHEs+GZ5wo3ZzvfXLqTku/Q==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Fri, 20 Mar 2026 11:46:18 +0100
Subject: [PATCH 7/8] drm/bridge: imx8mp-hdmi-tx: add an hdmi-connector when
 missing using a DT overlay at boot time
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260320-drm-lcdif-dbanc-v1-7-479a04133e70@bootlin.com>
References: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
In-Reply-To: <20260320-drm-lcdif-dbanc-v1-0-479a04133e70@bootlin.com>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frank Li <Frank.Li@nxp.com>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Liu Ying <victor.liu@nxp.com>, Rob Herring <robh@kernel.org>, 
 Saravana Kannan <saravanak@kernel.org>
Cc: "Kory Maincent (TI.com)" <kory.maincent@bootlin.com>, 
 =?utf-8?q?Herv=C3=A9_Codina?= <herve.codina@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, imx@lists.linux.dev, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 devicetree@vger.kernel.org, Adam Ford <aford173@gmail.com>, 
 Alexander Stein <alexander.stein@ew.tq-group.com>, 
 Anson Huang <Anson.Huang@nxp.com>, 
 Christopher Obbard <christopher.obbard@linaro.org>, 
 Daniel Scally <dan.scally@ideasonboard.com>, 
 Emanuele Ghidoli <emanuele.ghidoli@toradex.com>, 
 Fabio Estevam <festevam@denx.de>, 
 Francesco Dolcini <francesco.dolcini@toradex.com>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, 
 Gilles Talis <gilles.talis@gmail.com>, 
 =?utf-8?q?Goran_Ra=C4=91enovi=C4=87?= <goran.radni@gmail.com>, 
 Heiko Schocher <hs@denx.de>, 
 Joao Paulo Goncalves <joao.goncalves@toradex.com>, 
 Josua Mayer <josua@solid-run.com>, 
 =?utf-8?q?Jo=C3=A3o_Paulo_Gon=C3=A7alves?= <joao.goncalves@toradex.com>, 
 Kieran Bingham <kieran.bingham@ideasonboard.com>, 
 Marco Felsch <m.felsch@pengutronix.de>, 
 Martyn Welch <martyn.welch@collabora.com>, 
 Oleksij Rempel <o.rempel@pengutronix.de>, Peng Fan <peng.fan@nxp.com>, 
 Philippe Schenker <philippe.schenker@toradex.com>, 
 Richard Hu <richard.hu@technexion.com>, 
 Shengjiu Wang <shengjiu.wang@nxp.com>, 
 Stefan Eichenberger <stefan.eichenberger@toradex.com>, 
 Vitor Soares <vitor.soares@toradex.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.14.3
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

The imx8mp-hdmi-tx one of many drivers based on dw-hdmi. dw-hdmi in turn
can operate in two different modes, depending on the platform data as set
by the driver:

 A. hdmi->plat_data->output_port = 0:
    the HDMI output (port@1) in device tree is not used [0]

 B. hdmi->plat_data->output_port = 1:
    the HDMI output (port@1) is parsed to find the next bridge

The imx8mp-hdmi-tx driver falls in case A. This implies next_bridge will
always be NULL, and so dw_hdmi_bridge_attach() [1] will always fail if
called with the DRM_BRIDGE_ATTACH_NO_CONNECTOR flag.

In fact case A assumes that DRM_BRIDGE_ATTACH_NO_CONNECTOR is not set and
in that case it adds the connector programmatically at bridge attach time.

Support for DRM_BRIDGE_ATTACH_NO_CONNECTOR is implemented by dw-hdmi.c in
case B. So, in preparation to support DRM_BRIDGE_ATTACH_NO_CONNECTOR in
imx8mp-hdmi-tx, move to case B by setting hdmi->plat_data->output_port = 1.

However this change requires that port@1 is connected to a "next
bridge" DT node, typically the HDMI connector, because dw-hdmi won't add
the connector when using DRM_BRIDGE_ATTACH_NO_CONNECTOR.

Many dts files for imx8mp-based boards in the kernel have such a connector
described and linked to port@1, so a connector is added by the
display-connector driver along with a bridge wrapping it. Sadly some of
those dts files don't have the connector described. Adding it would solve
the problem easily, but this would break existing devices which do not
update the dtb when upgrading to a newer kernel.

To preserve backward compatibility for such devices, introduce a module
adding the hdmi-connector node to the live device tree at init time. This
allows the dw-hdmi code to find the next bridge (the one wrapping the
hdmi-connector) and let the pipeline work as before.

[0] https://elixir.bootlin.com/linux/v7.0-rc1/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L3310
[1] https://elixir.bootlin.com/linux/v7.0-rc1/source/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c#L2907

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

This patch is inspired by commit 0ff223d99147 ("drm/tilcdc: Convert legacy
panel binding via DT overlay at boot time")
---
 drivers/gpu/drm/bridge/imx/Kconfig                 | 17 ++++++
 drivers/gpu/drm/bridge/imx/Makefile                |  2 +
 .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.c    | 60 ++++++++++++++++++++++
 .../bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso | 38 ++++++++++++++
 drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c        |  1 +
 5 files changed, 118 insertions(+)

diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
index b9028a5e5a06..b9ce140a93dc 100644
--- a/drivers/gpu/drm/bridge/imx/Kconfig
+++ b/drivers/gpu/drm/bridge/imx/Kconfig
@@ -25,6 +25,23 @@ config DRM_IMX8MP_DW_HDMI_BRIDGE
 	  Choose this to enable support for the internal HDMI encoder found
 	  on the i.MX8MP SoC.
 
+config DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP
+	bool "Support device tree blobs without an hdmi-connector node"
+	default y
+	depends on DRM_IMX8MP_DW_HDMI_BRIDGE
+	depends on OF
+	select OF_OVERLAY
+	select DRM_DISPLAY_CONNECTOR
+	help
+	  Modifies at early boot the live device tree of boards using the
+	  i.MX8MP fsl,imx8mp-hdmi-tx adding a hdmi-connector node linked to
+	  the htmi-tx. This is needed to support bridge-connector usage in
+	  the i.MX8MP LCDIF driver.
+
+	  You need this if you use the i.MX8MP HDMI output and your board
+	  device tree file does not have an hdmi-connector node connected
+	  to it.
+
 config DRM_IMX8MP_HDMI_PAI
 	tristate "Freescale i.MX8MP HDMI PAI bridge support"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/imx/Makefile b/drivers/gpu/drm/bridge/imx/Makefile
index 8d01fda25451..84499fe2e444 100644
--- a/drivers/gpu/drm/bridge/imx/Makefile
+++ b/drivers/gpu/drm/bridge/imx/Makefile
@@ -1,6 +1,8 @@
 obj-$(CONFIG_DRM_IMX_LDB_HELPER) += imx-ldb-helper.o
 obj-$(CONFIG_DRM_IMX_LEGACY_BRIDGE) += imx-legacy-bridge.o
 obj-$(CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE) += imx8mp-hdmi-tx.o
+obj-$(CONFIG_DRM_IMX8MP_DW_HDMI_BRIDGE_CONNECTOR_FIXUP) += imx8mp-hdmi-tx-connector-fixup.o \
+							   imx8mp-hdmi-tx-connector-fixup.dtbo.o
 obj-$(CONFIG_DRM_IMX8MP_HDMI_PAI) += imx8mp-hdmi-pai.o
 obj-$(CONFIG_DRM_IMX8MP_HDMI_PVI) += imx8mp-hdmi-pvi.o
 obj-$(CONFIG_DRM_IMX8QM_LDB) += imx8qm-ldb.o
diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
new file mode 100644
index 000000000000..8c423b9bfa50
--- /dev/null
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.c
@@ -0,0 +1,60 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Add an hdmi-connector node to boards using the imx8mp hdmi_tx which
+ * don't have one. This is needed for the i.MX LCDIF to work with
+ * DRM_BRIDGE_ATTACH_NO_CONNECTOR.
+ *
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
+ */
+
+#include <linux/kernel.h>
+#include <linux/of.h>
+#include <linux/of_fdt.h>
+#include <linux/slab.h>
+
+/* Embedded dtbo symbols created by cmd_wrap_S_dtb in scripts/Makefile.dtbs */
+extern char __dtbo_imx8mp_hdmi_tx_connector_fixup_begin[];
+extern char __dtbo_imx8mp_hdmi_tx_connector_fixup_end[];
+
+static int __init imx8mp_hdmi_tx_connector_fixup_init(void)
+{
+	struct device_node *hdmi_tx __free(device_node) = NULL;
+	struct device_node *endpoint __free(device_node) = NULL;
+	struct device_node *hdmi_conn __free(device_node) = NULL;
+	void *dtbo_start;
+	u32 dtbo_size;
+	int ovcs_id;
+	int err;
+
+	hdmi_tx = of_find_node_by_path("/soc@0/bus@32c00000/hdmi@32fd8000");
+	if (!of_device_is_available(hdmi_tx))
+		return 0;
+
+	/* If endpoint exists, assume an hdmi-connector exists already */
+	endpoint = of_find_node_by_path("/soc@0/bus@32c00000/hdmi@32fd8000/ports/port@1/endpoint");
+	if (endpoint)
+		return 0;
+
+	dtbo_start = __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
+	dtbo_size = __dtbo_imx8mp_hdmi_tx_connector_fixup_end -
+		    __dtbo_imx8mp_hdmi_tx_connector_fixup_begin;
+
+	err = of_overlay_fdt_apply(dtbo_start, dtbo_size, &ovcs_id, NULL);
+	if (err)
+		return err;
+
+	hdmi_conn = of_find_node_by_name(NULL, "fixup-hdmi-connector");
+	if (!hdmi_conn) {
+		err = -ENODEV;
+		goto overlay_remove;
+	}
+
+	return 0;
+
+overlay_remove:
+	of_overlay_remove(&ovcs_id);
+	return err;
+}
+
+subsys_initcall(imx8mp_hdmi_tx_connector_fixup_init);
diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
new file mode 100644
index 000000000000..ee718ca1b11b
--- /dev/null
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx-connector-fixup.dtso
@@ -0,0 +1,38 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * DTS overlay adding an hdmi-connector node to boards using the imx8mp hdmi_tx
+ *
+ * Copyright (C) 2026 GE HealthCare
+ * Author: Luca Ceresoli <luca.ceresoli@bootlin.com>
+ */
+
+/dts-v1/;
+/plugin/;
+
+&{/} {
+	fixup-hdmi-connector {
+		compatible = "hdmi-connector";
+		label = "HDMI";
+		type = "a";
+
+		port {
+			fixup_hdmi_connector_in: endpoint {
+				remote-endpoint = <&hdmi_tx_out>;
+			};
+		};
+	};
+
+	soc@0 {
+		bus@32c00000 {
+			hdmi@32fd8000 {
+				ports {
+					port@1 {
+						hdmi_tx_out: endpoint {
+							remote-endpoint = <&fixup_hdmi_connector_in>;
+						};
+					};
+				};
+			};
+		};
+	};
+};
diff --git a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
index 32fd3554e267..8e8cfd66f23b 100644
--- a/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
+++ b/drivers/gpu/drm/bridge/imx/imx8mp-hdmi-tx.c
@@ -138,6 +138,7 @@ static int imx8mp_dw_hdmi_probe(struct platform_device *pdev)
 	plat_data->phy_name = "SAMSUNG HDMI TX PHY";
 	plat_data->priv_data = hdmi;
 	plat_data->phy_force_vendor = true;
+	plat_data->output_port = 1;
 
 	platform_set_drvdata(pdev, hdmi);
 

-- 
2.53.0

