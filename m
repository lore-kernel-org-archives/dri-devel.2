Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C97A6C44520
	for <dri-devel@archiver.kernel.org>; Fri, 17 Jul 2026 12:19:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 26C2C10F534;
	Fri, 17 Jul 2026 12:19:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=dolcini.it header.i=@dolcini.it header.b="sm61I0gx";
	dkim-atps=neutral
Received: from mail11.truemail.it (mail11.truemail.it [217.194.8.81])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5B4A010F535
 for <dri-devel@lists.freedesktop.org>; Fri, 17 Jul 2026 12:19:01 +0000 (UTC)
Received: from francesco-nb.. (unknown [178.82.120.96])
 by mail11.truemail.it (Postfix) with ESMTPA id 58EC9228C8;
 Fri, 17 Jul 2026 14:18:59 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=dolcini.it;
 s=default; t=1784290740;
 bh=PazjzQ9/RAMBhl8ZObuStg+aPYI7SBm0oUOl0yW6hLs=; h=From:To:Subject;
 b=sm61I0gxuOE+Ck67P8NErrRE02PHdi7FDQo8FiyUzhiCDIbot3migWkACx8gMhy8P
 DV/wfx1yAJp/waYlAOJEvqkeX9vD7E5/ghbiPuOah8BNFCJISrVevO/c2ew/gJyS/n
 78PCwcQaQy0Gx4pXCk7MAzQJBRfrxg2Buiw7CclfJRjI5KVjRn5Tmxgv9F55TMs+Tt
 BxfxgqSK3rieJ3dtY5rMYaabs4GKFDCTEAyJXCZg7Oy7ONlVuvD/NlsA6q5eozF0l9
 Lo0o76Omnq95LmKSR8tonwHkvhgX+0Zw/z/mDbv6whJOsbAYqv9PqYdyzOepYJS/pu
 C4VwK0SW0db6A==
From: Francesco Dolcini <francesco@dolcini.it>
To: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>
Cc: Francesco Dolcini <francesco.dolcini@toradex.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org
Subject: [PATCH v1 2/4] drm: mxsfb: Allow optional LCDIF interface format
 override
Date: Fri, 17 Jul 2026 14:18:44 +0200
Message-ID: <20260717121847.488148-3-francesco@dolcini.it>
X-Mailer: git-send-email 2.47.3
In-Reply-To: <20260717121847.488148-1-francesco@dolcini.it>
References: <20260717121847.488148-1-francesco@dolcini.it>
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

Read the optional interface-pix-fmt property from the LCDIF node and use
it to select the media bus format used to configure LCDIF. This allows
the LCDIF bus mode to describe the physical interface independently of
the downstream display format.

When the optional property is absent, continue using the format reported
by the downstream display device, preserving the existing behavior.

This follows the same approach already implemented in
drivers/gpu/drm/imx/ipuv3/parallel-display.c.

Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
---
 drivers/gpu/drm/mxsfb/mxsfb_drv.c | 16 ++++++++++++++++
 drivers/gpu/drm/mxsfb/mxsfb_drv.h |  2 ++
 drivers/gpu/drm/mxsfb/mxsfb_kms.c |  8 ++++++++
 3 files changed, 26 insertions(+)

diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.c b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
index 9b8fbda85d28..edf347968fd2 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.c
@@ -12,7 +12,9 @@
 #include <linux/clk.h>
 #include <linux/dma-mapping.h>
 #include <linux/io.h>
+#include <linux/media-bus-format.h>
 #include <linux/module.h>
+#include <linux/of.h>
 #include <linux/platform_device.h>
 #include <linux/property.h>
 #include <linux/pm_runtime.h>
@@ -209,7 +211,10 @@ static int mxsfb_load(struct drm_device *drm,
 		      const struct mxsfb_devdata *devdata)
 {
 	struct platform_device *pdev = to_platform_device(drm->dev);
+	struct device_node *np = pdev->dev.of_node;
 	struct mxsfb_drm_private *mxsfb;
+	u32 bus_format = 0;
+	const char *fmt;
 	int ret;
 
 	mxsfb = devm_kzalloc(&pdev->dev, sizeof(*mxsfb), GFP_KERNEL);
@@ -236,6 +241,17 @@ static int mxsfb_load(struct drm_device *drm,
 	if (IS_ERR(mxsfb->clk_disp_axi))
 		mxsfb->clk_disp_axi = NULL;
 
+	ret = of_property_read_string(np, "interface-pix-fmt", &fmt);
+	if (!ret) {
+		if (!strcmp(fmt, "rgb24"))
+			bus_format = MEDIA_BUS_FMT_RGB888_1X24;
+		else if (!strcmp(fmt, "rgb565"))
+			bus_format = MEDIA_BUS_FMT_RGB565_1X16;
+		else if (!strcmp(fmt, "rgb666"))
+			bus_format = MEDIA_BUS_FMT_RGB666_1X18;
+	}
+	mxsfb->bus_format = bus_format;
+
 	ret = dma_set_mask_and_coherent(drm->dev, DMA_BIT_MASK(32));
 	if (ret)
 		return ret;
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_drv.h b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
index d160d921b25f..f64800f06a69 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_drv.h
+++ b/drivers/gpu/drm/mxsfb/mxsfb_drv.h
@@ -46,6 +46,8 @@ struct mxsfb_drm_private {
 	struct drm_connector		*connector;
 	struct drm_bridge		*bridge;
 
+	u32 bus_format;
+
 	bool				crc_active;
 };
 
diff --git a/drivers/gpu/drm/mxsfb/mxsfb_kms.c b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
index d8ebebc5314b..8b482727aed5 100644
--- a/drivers/gpu/drm/mxsfb/mxsfb_kms.c
+++ b/drivers/gpu/drm/mxsfb/mxsfb_kms.c
@@ -386,6 +386,14 @@ static void mxsfb_crtc_atomic_enable(struct drm_crtc *crtc,
 	if (!bus_format)
 		bus_format = MEDIA_BUS_FMT_RGB888_1X24;
 
+	/*
+	 * Prefer bus format set via optional "interface-pix-fmt" DT property,
+	 * over panel or next bridge bus format. This is necessary to support
+	 * 24bit DPI panels connected to a 18bit interface, for example.
+	 */
+	if (mxsfb->bus_format)
+		bus_format = mxsfb->bus_format;
+
 	mxsfb_crtc_mode_set_nofb(mxsfb, bridge_state, bus_format);
 
 	/* Write cur_buf as well to avoid an initial corrupt frame */
-- 
2.47.3

