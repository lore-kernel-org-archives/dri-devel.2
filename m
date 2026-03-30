Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A2FB61061B18
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 22:48:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F36ED10E7CB;
	Mon, 30 Mar 2026 22:48:41 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 72B2D10E7CB
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 22:48:41 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id E243C1F8004A
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 22:48:39 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 782ECB2EBCB; Mon, 30 Mar 2026 22:48:39 +0000 (UTC)
Received: from shepard (unknown [192.168.1.65])
 by laika.paulk.fr (Postfix) with ESMTP id E60CAB2EBC4;
 Mon, 30 Mar 2026 22:46:31 +0000 (UTC)
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
Subject: [PATCH 2/3] drm: lcdif: Use dedicated set/clr registers for
 polarity/edge
Date: Tue, 31 Mar 2026 00:46:18 +0200
Message-ID: <20260330224619.2620782-3-paulk@sys-base.io>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260330224619.2620782-1-paulk@sys-base.io>
References: <20260330224619.2620782-1-paulk@sys-base.io>
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

The lcdif v3 hardware comes with dedicated registers to set and clear
polarity bits in the CTRL register. It is unclear if there is a
difference with writing to the CTRL register directly.

Follow the NXP BSP reference by using these registers, in case there is
a subtle difference caused by using them.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
---
 drivers/gpu/drm/mxsfb/lcdif_kms.c | 23 ++++++++++++++++-------
 1 file changed, 16 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
index a00c4f6d63f4..1aac354041c7 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -296,18 +296,27 @@ static void lcdif_set_formats(struct lcdif_drm_private *lcdif,
 static void lcdif_set_mode(struct lcdif_drm_private *lcdif, u32 bus_flags)
 {
 	struct drm_display_mode *m = &lcdif->crtc.state->adjusted_mode;
-	u32 ctrl = 0;
+	u32 ctrl;
 
 	if (m->flags & DRM_MODE_FLAG_NHSYNC)
-		ctrl |= CTRL_INV_HS;
+		writel(CTRL_INV_HS, lcdif->base + LCDC_V8_CTRL + REG_SET);
+	else
+		writel(CTRL_INV_HS, lcdif->base + LCDC_V8_CTRL + REG_CLR);
+
 	if (m->flags & DRM_MODE_FLAG_NVSYNC)
-		ctrl |= CTRL_INV_VS;
+		writel(CTRL_INV_VS, lcdif->base + LCDC_V8_CTRL + REG_SET);
+	else
+		writel(CTRL_INV_VS, lcdif->base + LCDC_V8_CTRL + REG_CLR);
+
 	if (bus_flags & DRM_BUS_FLAG_DE_LOW)
-		ctrl |= CTRL_INV_DE;
-	if (bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
-		ctrl |= CTRL_INV_PXCK;
+		writel(CTRL_INV_DE, lcdif->base + LCDC_V8_CTRL + REG_SET);
+	else
+		writel(CTRL_INV_DE, lcdif->base + LCDC_V8_CTRL + REG_CLR);
 
-	writel(ctrl, lcdif->base + LCDC_V8_CTRL);
+	if (bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
+		writel(CTRL_INV_PXCK, lcdif->base + LCDC_V8_CTRL + REG_SET);
+	else
+		writel(CTRL_INV_PXCK, lcdif->base + LCDC_V8_CTRL + REG_CLR);
 
 	writel(DISP_SIZE_DELTA_Y(m->vdisplay) |
 	       DISP_SIZE_DELTA_X(m->hdisplay),
-- 
2.53.0

