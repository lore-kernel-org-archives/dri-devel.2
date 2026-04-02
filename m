Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9D156D6AAEC
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:36:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 021E310F28C;
	Thu,  2 Apr 2026 18:36:19 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2197B10F28C
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:36:18 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 663401F8004A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:36:16 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 7ED83B40129; Thu,  2 Apr 2026 18:36:15 +0000 (UTC)
Received: from shepard (unknown [192.168.1.65])
 by laika.paulk.fr (Postfix) with ESMTP id F1C86B40128;
 Thu,  2 Apr 2026 18:33:52 +0000 (UTC)
From: Paul Kocialkowski <paulk@sys-base.io>
To: dri-devel@lists.freedesktop.org, imx@lists.linux.dev,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Cc: Marek Vasut <marex@denx.de>, Stefan Agner <stefan@agner.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Frank Li <Frank.Li@nxp.com>,
 Sascha Hauer <s.hauer@pengutronix.de>,
 Pengutronix Kernel Team <kernel@pengutronix.de>,
 Fabio Estevam <festevam@gmail.com>, Lucas Stach <l.stach@pengutronix.de>,
 =?UTF-8?q?Krzysztof=20Ha=C5=82asa?= <khalasa@piap.pl>,
 Marco Felsch <m.felsch@pengutronix.de>, Liu Ying <victor.liu@nxp.com>,
 Paul Kocialkowski <paulk@sys-base.io>
Subject: [PATCH v2 2/2] drm: lcdif: Wait for vblank before disabling DMA
Date: Thu,  2 Apr 2026 20:33:51 +0200
Message-ID: <20260402183351.3281123-3-paulk@sys-base.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260402183351.3281123-1-paulk@sys-base.io>
References: <20260402183351.3281123-1-paulk@sys-base.io>
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

It is necessary to wait for the full frame to finish streaming
through the DMA engine before we can safely disable it by removing
the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave the
hardware confused and unable to resume streaming for the next frame.

This causes the FIFO underrun and empty status bits to be set and
a single solid color to be shown on the display, coming from one of
the pixels of the previous frame. The issue occurs sporadically when
a new mode is set, which triggers the crtc disable and enable paths.

Setting the shadow load bit and waiting for it to be cleared by the
DMA engine allows waiting for completion.

The NXP BSP driver addresses this issue with a hardcoded 25 ms sleep.

Fixes: 9db35bb349a0 ("drm: lcdif: Add support for i.MX8MP LCDIF variant")
Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
Co-developed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/mxsfb/lcdif_kms.c | 15 ++++++++++++---
 1 file changed, 12 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
index a00c4f6d63f4..0d04a0028671 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -375,14 +375,23 @@ static void lcdif_disable_controller(struct lcdif_drm_private *lcdif)
 	int ret;
 
 	reg = readl(lcdif->base + LCDC_V8_CTRLDESCL0_5);
+	/* Disable the layer for DMA. */
 	reg &= ~CTRLDESCL0_5_EN;
+	/*
+	 * It is necessary to wait for the full frame to finish streaming
+	 * through the DMA engine before we can safely disable it by removing
+	 * the DISP_PARA_DISP_ON bit. Disabling it in-flight can leave the
+	 * hardware confused and unable to resume streaming for the next frame.
+	 */
+	reg |= CTRLDESCL0_5_SHADOW_LOAD_EN;
 	writel(reg, lcdif->base + LCDC_V8_CTRLDESCL0_5);
 
+	/* Wait for the frame to finish or timeout after 50 ms. */
 	ret = readl_poll_timeout(lcdif->base + LCDC_V8_CTRLDESCL0_5,
-				 reg, !(reg & CTRLDESCL0_5_EN),
-				 0, 36000);	/* Wait ~2 frame times max */
+				 reg, !(reg & CTRLDESCL0_5_SHADOW_LOAD_EN),
+				 200, 50000);
 	if (ret)
-		drm_err(lcdif->drm, "Failed to disable controller!\n");
+		drm_err(lcdif->drm, "Timed out waiting for final vblank!\n");
 
 	reg = readl(lcdif->base + LCDC_V8_DISP_PARA);
 	reg &= ~DISP_PARA_DISP_ON;
-- 
2.53.0

