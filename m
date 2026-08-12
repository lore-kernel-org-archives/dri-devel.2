Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5365DC5B56A
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:30:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 65DAE10EFD5;
	Wed, 12 Aug 2026 13:30:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="EmBwwfFn";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 81EE810EFD2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:30:05 +0000 (UTC)
Received: from francesco-nb.. (93-33-22-216.ip42.fastwebnet.it [93.33.22.216])
 by mail11.truemail.it (Postfix) with ESMTPA id DD6A41FDCE;
 Wed, 12 Aug 2026 15:30:02 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1786541404;
 bh=Cy/5AnutR73xOx206RLh/f1PGGtvSU7v30Bw9Dyy0bg=; h=From:To:Subject;
 b=EmBwwfFnYl41rr7PBG+17uYGTfeEkOYqhZiQ73jDGBrTXyebNgDWWS4G0y31L+DAe
 YXa6S9MYPjE7jarbP2zCizY7FkZtAWnUBpbskoEMV6qqR7FiZsk7dh5BaP3GiYZfrD
 9g7ScxtYqAbvY5L3MGduU4eJudEbpykPb3y/4qulm8zXG5gJ9wdPHdCUoWFm2D5F05
 tQoVUOk5iClZcX8uWXbT6V3zLeAq64tpxAp0tPYcyNH7l8CQcq/XwWSekM1873FOXD
 6QtT7ybWGV80nR8BlZyrm6NKWj5KzH5QIlMCrSpU6OwTt/HfHxSQ/fgJFEQA8Jam2I
 v7HtnC8FFEyIQ==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>,
 Alexander Stein <alexander.stein@ew.tq-group.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v3 2/4] drm: mxsfb: Add optional DPI output bus-width
 configuration
Date: Wed, 12 Aug 2026 15:29:50 +0200
Message-ID: <20260812132954.148571-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260812132954.148571-1-francesco@dolcini.it>
References: <20260812132954.148571-1-francesco@dolcini.it>
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

From: Francesco Dolcini <francesco.dolcini@toradex.com>

LCDIF programs LCD_DATABUS_WIDTH from the selected media bus format. The
format reported by the downstream panel or bridge describes the display
input, but it does not describe how the LCDIF data pins are physically
wired on the board.

These can differ. For example, a 16-bit LCDIF bus can be connected to a
24-bit display by wiring the available color bits to the corresponding
display inputs. In that case, using the display's 24-bit format to
configure LCDIF selects the wrong data-bus mode and changes the assignment
of color bits on the LCD_DATA pins.

Read the optional bus-width endpoint property from the LCDIF output port
and use it to select the media bus format used to configure LCDIF. This
allows the LCDIF bus mode to describe the physical interface
independently of the downstream display format.

When the optional property is absent, or it has an invalid value, continue
using the format reported by the downstream display device, preserving
the existing behavior. The code is not validating the DT for
correctness and just fall back to the previous behavior in case of
errors.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
v3: improve commit message and make it clear that the code assumes that
    the DT is correct, when the DT contains an invalid property value,
    the code safely fall-back to the previous behavior
v2: use the common bus-width property instead of the legacy interface-pix-fmt
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 24 ++++++++++++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
 drivers/gpu/drm/mxsfb/mxsfb_kms.c | 12 ++++++++++++
 3 files changed, 38 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 8b4a500347fb..f8ecc8bbd63c 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -12,7 +12,10 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/media-bus-format.h>
 #include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_graph.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/pm_runtime.h>
@@ -211,7 +214,10 @@ static int mxsfb_load(struct drm_device *drm,
 		      const struct mxsfb_devdata *devdata)
 {
 	struct platform_device *pdev = to_platform_device(drm->dev);
+	struct device_node *np = pdev->dev.of_node;
 	struct mxsfb_drm_private *mxsfb;
+	struct device_node *ep;
+	u32 bus_width = 0;
 	int ret;
 
 	mxsfb = devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);
@@ -238,6 +244,24 @@ static int mxsfb_load(struct drm_device *drm,
 	if (IS_ERR(mxsfb->clk_disp_axi))
 		mxsfb->clk_disp_axi = NULL;
 
+	ep = of_graph_get_next_endpoint(np, NULL);
+	if (ep) {
+		of_property_read_u32(ep, "bus-width", &bus_width);
+		of_node_put(ep);
+	}
+
+	switch (bus_width) {
+	case 16:
+		mxsfb->bus_format = MEDIA_BUS_FMT_RGB565_1X16;
+		break;
+	case 18:
+		mxsfb->bus_format = MEDIA_BUS_FMT_RGB666_1X18;
+		break;
+	case 24:
+		mxsfb->bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+		break;
+	}
+
 	ret = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index d160d921b25f..bdc47ce5be79 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -46,6 +46,8 @@ struct mxsfb_drm_private {
 	struct drm_connector		*connector;
 	struct drm_bridge		*bridge;
 
+	u32				bus_format;
+
 	bool				crc_active;
 };
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index d8ebebc5314b..1d78c486d147 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -386,6 +386,18 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (!bus_format)
 		bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
+	/*
+	 * Prefer the bus format derived from the OF graph endpoint "bus-width"
+	 * property when available. Otherwise, use the bus format reported by
+	 * the downstream bridge or panel.
+	 *
+	 * This supports mismatched display and interface bus widths, such as
+	 * a 24-bit panel connected through an 18-bit interface or an 18-bit
+	 * panel connected through a 24-bit interface.
+	 */
+	if (mxsfb->bus_format)
+		bus_format = mxsfb->bus_format;
+
 	mxsfb_crtc_mode_set_nofb(mxsfb, bridge_state, bus_format);
 
 	/* Write cur_buf as well to avoid an initial corrupt frame */
-- 
2.47.3

