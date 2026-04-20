Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CD1D5F588C6
	for <dri-devel@archiver.kernel.org>; Mon, 20 Apr 2026 12:54:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3874510E5AF;
	Mon, 20 Apr 2026 12:54:58 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="rPUMCUty";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7D25310E5A1
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Apr 2026 12:54:45 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id AA8363836;
 Mon, 20 Apr 2026 14:53:06 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1776689587;
 bh=eECXnZn8vnRWVId75kkhXIP55XTyydw1o/Xi8IowENA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=rPUMCUtyjG5UVWO6zcGn4+JbcJzemkYSikQmCf6EUWZf95KpRmQocmPV5YxM3jVtP
 0bO3d2mcHx75Ptn45m56jqMvFGiAr5BKHW1+uz+f1wFdXCO3K2r/ENbMChEs/KP0pp
 +9Ep6cAcYcplCRBbI8MY42/evIkLRr6leRh4otLc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 20 Apr 2026 15:54:16 +0300
Subject: [PATCH 09/15] drm/tidss: Add external data and sync signal edge
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260420-beagley-ai-display-v1-9-f628543dfd14@ideasonboard.com>
References: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
In-Reply-To: <20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3289;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=eECXnZn8vnRWVId75kkhXIP55XTyydw1o/Xi8IowENA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBp5iIGgWMuo21BHn03Y0oLtgs9TLh/AJ97JqgUH
 Y0YFJGj2BqJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCaeYiBgAKCRD6PaqMvJYe
 9ZMSD/0f6Goa7w7n0Og5IkTlnxiXQEFmCIPd3kXeBkIT6Zo6noFeKY8v5cLeo+iispAQP6Fti89
 wYhEe6l7OxOJL27px9Op1xtn5mX1IfAADJRBj6PlAPQKXwie51RjChtJh/KDLTNmUJVondV5Ftg
 r/oEg7SvV69ySu36r/CzIJiiAoIgCAh2lKiGn4lREqRcvclsez+KVa0teeYOmstkfNGBrQKrbXW
 p6RJq4OK0Vi5vPRRD2ET9Ti8HHT3gPTcGc+6H5JJoF/eQrw9kemXtPpsogs3c+8r33gAT6/hwPD
 pCjPuk9DzvAKa7Dbm87BWdXl4dW1sawsr2J9TWAswvip0zsaL3QMXWh9GLvRtClwBrWyu6SiNIL
 AAK69QzEGQgbBXQfFawD7sSXucUMiSvB1NsJw/9fhII+nDcS3FPrWARTj2Q5qU5jUVtboUyXfl4
 rQwTo6WbkKahSGU6cO4KbgeTNPPDL2QepeDQoD/0SrXaO4lKXFlYwerL1psQVW3DU1R/nkkiP1e
 zGnm5RC180WPe+YIRX3Qf+tFs+qAZcKfxRhPWV96mipcEkblQrJfQFSHOSL6iOHQ4l41kGgCNrY
 YXHZ28u8OhOjL77/6dpFB/taB9Y+y1JNF+/ysVCSrmJiKwhWtscNbrZU36Y6LsMCrJWiHqnrxCK
 8kA//2337ZRlL8g==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

The DPI output pipeline in K3 SoCs contains the display subsystem (DSS)
which produces the in-SoC parallel video signal, and a DPI block which
adjusts the signal to the external MIPI DPI output.

The DSS IP has registers to configure whether the data and sync signals
are driven on rising or falling clock edge, and on some SoCs these are
automatically conveyed to the DPI block which needs that configuration
to properly output the MIPI DPI signal.

However, on some SoCs the DPI block configuration has to be done
manually, using an extra register outside the DSS, DPI0_CLK_CTRL from
MAIN_CTRL_MMR_CFG0 block, which controls the DPI block's behavior.

The register is exposed to DSS via syscon 'ti,dpi-io-ctrl' node.

Add the support to get the regmap to the register, and configure the
bits before enabling the video output.

Original patch from Louis Chauvet <louis.chauvet@bootlin.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c      | 18 ++++++++++++++++++
 drivers/gpu/drm/tidss/tidss_dispc_regs.h |  4 ++++
 2 files changed, 22 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c21ac3f51720..0f68e60b902b 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -467,6 +467,7 @@ struct dispc_device {
 	const struct dispc_features *feat;
 
 	struct clk *fclk;
+	struct regmap *syscon_dpi_io_ctrl;
 
 	bool is_enabled;
 
@@ -1201,6 +1202,12 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 				  mode->crtc_hdisplay - 1) |
 		       FIELD_PREP(DISPC_VP_SIZE_SCREEN_VDISPLAY_MASK,
 				  mode->crtc_vdisplay - 1));
+
+	if (dispc->vp_data[hw_videoport].dpi_output && dispc->syscon_dpi_io_ctrl) {
+		regmap_write(dispc->syscon_dpi_io_ctrl, 0x0,
+			     (!ipc ? DPI0_CLK_CTRL_DATA_CLK_INVDIS : 0) |
+			     (rf ? DPI0_CLK_CTRL_SYNC_CLK_INVDIS : 0));
+	}
 }
 
 void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
@@ -2989,6 +2996,17 @@ int dispc_init(struct tidss_device *tidss)
 
 	dispc_init_errata(dispc);
 
+	dispc->syscon_dpi_io_ctrl = syscon_regmap_lookup_by_compatible("ti,am625-dss-dpi0-clk-ctrl");
+	if (IS_ERR(dispc->syscon_dpi_io_ctrl)) {
+		if (PTR_ERR(dispc->syscon_dpi_io_ctrl) != -ENODEV) {
+			r = dev_err_probe(dispc->dev, PTR_ERR(dispc->syscon_dpi_io_ctrl),
+					  "DISPC: syscon_regmap_lookup_by_phandle failed.\n");
+			return r;
+		}
+
+		dispc->syscon_dpi_io_ctrl = NULL;
+	}
+
 	dispc->fourccs = devm_kcalloc(dev, ARRAY_SIZE(dispc_color_formats),
 				      sizeof(*dispc->fourccs), GFP_KERNEL);
 	if (!dispc->fourccs)
diff --git a/drivers/gpu/drm/tidss/tidss_dispc_regs.h b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
index 382027dddce8..4cdde24d8372 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc_regs.h
+++ b/drivers/gpu/drm/tidss/tidss_dispc_regs.h
@@ -333,4 +333,8 @@ enum oldi_mode_reg_val { SPWG_18 = 0, JEIDA_24 = 1, SPWG_24 = 2 };
 
 #define AM65X_OLDI_PWRDN_TX		BIT(8)
 
+/* Bits in the MAIN_CTRL_MMR_CFG0_DPI0_CLK_CTRL register */
+#define DPI0_CLK_CTRL_DATA_CLK_INVDIS BIT(8)
+#define DPI0_CLK_CTRL_SYNC_CLK_INVDIS BIT(9)
+
 #endif /* __TIDSS_DISPC_REGS_H */

-- 
2.43.0

