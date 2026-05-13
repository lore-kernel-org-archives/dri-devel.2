Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F2913CD4F3E
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:18:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D1FD910EE7F;
	Wed, 13 May 2026 13:18:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="OqNxR4p3";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0E89710EE78
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:18:07 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B0B14227A;
 Wed, 13 May 2026 15:17:56 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778678277;
 bh=/cD+FN8IFiV1Cxcp/yPbJWR8MpBq6AQomdWRb1N4DGA=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=OqNxR4p3maliM/Q7rE09WEzroY4/TSi/IliQAXf9C+Jbl5UHViH5+ZyzXJIVsvoWv
 vGpUEZHWmJBHYja2jKKn5/KIYB2AZPgctH0JDXqGa0vF7VEpjU9Tpq2ndvjzCIAhkS
 tjoD2jgLvd26OqhU6WWEBHulzUrh/pS+vPQ7tvXI=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:17:31 +0300
Subject: [PATCH v2 09/16] drm/tidss: Add external data and sync signal edge
 configuration
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-beagley-ai-display-v2-9-9e9bcefde6bc@ideasonboard.com>
References: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
In-Reply-To: <20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3391;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=/cD+FN8IFiV1Cxcp/yPbJWR8MpBq6AQomdWRb1N4DGA=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHn/vZQea/FHHMo/D1Ic2Lo/MhzRwkSg0VICY
 oon3BJrMOKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR5/wAKCRD6PaqMvJYe
 9YD2EACEfzzuqGF4ggdLbzif9rhSMTRPxbP6XFKJNASUDLTN9DpUQU8pfcpHK0i4KqxsbsRN/Hf
 bWrKg8hyuJx0vhsJaTHKvcvcQ8xXjyJ+XGCyyyc3tPXiDmlGft5b1YUNhIiAXw6uQcT1uTtkGfm
 8JNif0FbIzwdqwuhAUR91h5k3cgYXxw0i4IYtsZG9TxlCXBN2YY0oBiUmVnwhYEq+ixsuNCuJpI
 ddPVoXNcQUaRZOY4/yvfZXh74pGkrieZFeAZExpztMAVyoPXew/5JBYsIyjGgiG64rL61808fsC
 z+GiBNT7lgIdQT8udMDL//H7C4ui9EzA1ElBy1Y+VlDsWdqGpVskKS9Dj01r3B8ybLldWosr9+Q
 qNOqB4dm7nHVrYkPQn8S8gvix7onCdFgL+E1Oygn9lqzf+zmjnFXHV/Q2GCvXoDWYwNwXZugrPw
 RiRwPaPad0YgPTyhWA3sB9auwQ0uHMUC5nPQ4HiAyZauf3Prb7uGXyP07McvHuFTwfTML1Ihos6
 PxJ4RtVstHyXL9zPBHX9LLPe2ujDRP/HDYnv+6lVso14c56ifPaWSe2h3BSfmBGcz9ycph3Tpnj
 vuIoKZSWD+SDCrR+NLW5JoutZMqhzSJt+aDZHMjfjHW604w9UgaDRPnVqIQ4CM7uaaDXWk9Iq91
 wviI6Gu2rXzRQMg==
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

Add the support to get the regmap to the register via syscon, and
configure the bits before enabling the video output.

Original patch from Louis Chauvet <louis.chauvet@bootlin.com>

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/tidss/tidss_dispc.c      | 21 +++++++++++++++++++++
 drivers/gpu/drm/tidss/tidss_dispc_regs.h |  4 ++++
 2 files changed, 25 insertions(+)

diff --git a/drivers/gpu/drm/tidss/tidss_dispc.c b/drivers/gpu/drm/tidss/tidss_dispc.c
index c21ac3f51720..92cba069ed6c 100644
--- a/drivers/gpu/drm/tidss/tidss_dispc.c
+++ b/drivers/gpu/drm/tidss/tidss_dispc.c
@@ -467,6 +467,8 @@ struct dispc_device {
 	const struct dispc_features *feat;
 
 	struct clk *fclk;
+	struct regmap *syscon_dpi_io_ctrl;
+	unsigned int syscon_dpi_io_ctrl_offset;
 
 	bool is_enabled;
 
@@ -1201,6 +1203,13 @@ void dispc_vp_prepare(struct dispc_device *dispc, u32 hw_videoport,
 				  mode->crtc_hdisplay - 1) |
 		       FIELD_PREP(DISPC_VP_SIZE_SCREEN_VDISPLAY_MASK,
 				  mode->crtc_vdisplay - 1));
+
+	if (dispc->vp_data[hw_videoport].dpi_output && dispc->syscon_dpi_io_ctrl) {
+		regmap_write(dispc->syscon_dpi_io_ctrl,
+			     dispc->syscon_dpi_io_ctrl_offset + 0x0,
+			     (!ipc ? DPI0_CLK_CTRL_DATA_CLK_INVDIS : 0) |
+			     (rf ? DPI0_CLK_CTRL_SYNC_CLK_INVDIS : 0));
+	}
 }
 
 void dispc_vp_enable(struct dispc_device *dispc, u32 hw_videoport)
@@ -2989,6 +2998,18 @@ int dispc_init(struct tidss_device *tidss)
 
 	dispc_init_errata(dispc);
 
+	dispc->syscon_dpi_io_ctrl =
+		syscon_regmap_lookup_by_phandle_args(tidss->dev->of_node,
+						     "ti,dpi-io-ctrl", 1,
+						     &dispc->syscon_dpi_io_ctrl_offset);
+
+	if (PTR_ERR(dispc->syscon_dpi_io_ctrl) == -ENODEV)
+		dispc->syscon_dpi_io_ctrl = NULL;
+	else if (IS_ERR(dispc->syscon_dpi_io_ctrl))
+		return dev_err_probe(dispc->dev,
+				     PTR_ERR(dispc->syscon_dpi_io_ctrl),
+				     "DISPC: syscon_regmap_lookup_by_phandle failed.\n");
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

