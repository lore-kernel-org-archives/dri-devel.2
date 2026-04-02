Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 609EFD6AAEC
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 18:35:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C969B10F289;
	Thu,  2 Apr 2026 18:35:22 +0000 (UTC)
Received: from leonov.paulk.fr (leonov.paulk.fr [185.233.101.22])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F9B510F289
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:35:21 +0000 (UTC)
Received: from laika.paulk.fr (12.234.24.109.rev.sfr.net [109.24.234.12])
 by leonov.paulk.fr (Postfix) with ESMTPS id 9A2481F8004A
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 18:35:19 +0000 (UTC)
Received: by laika.paulk.fr (Postfix, from userid 65534)
 id 2CFC8B40126; Thu,  2 Apr 2026 18:35:19 +0000 (UTC)
Received: from shepard (unknown [192.168.1.65])
 by laika.paulk.fr (Postfix) with ESMTP id 869C1B40127;
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
Subject: [PATCH v2 1/2] drm: lcdif: Set undocumented bit to clear FIFO at vsync
Date: Thu,  2 Apr 2026 20:33:50 +0200
Message-ID: <20260402183351.3281123-2-paulk@sys-base.io>
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

There is an undocumented bit used in the NXP BSP to clear the FIFO
systematically at vsync. In normal operation, the FIFO should already
be empty but it doesn't hurt to add it as an extra safety measure.

Signed-off-by: Paul Kocialkowski <paulk@sys-base.io>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/gpu/drm/mxsfb/lcdif_kms.c  | 3 ++-
 drivers/gpu/drm/mxsfb/lcdif_regs.h | 1 +
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/mxsfb/lcdif_kms.c b/drivers/gpu/drm/mxsfb/lcdif_kms.c
index ef3250a5c54f..a00c4f6d63f4 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_kms.c
+++ b/drivers/gpu/drm/mxsfb/lcdif_kms.c
@@ -338,7 +338,8 @@ static void lcdif_set_mode(struct lcdif_drm_private *lcdif, u32 bus_flags)
 	 * Downstream set it to 256B burst size to improve the memory
 	 * efficiency so set it here too.
 	 */
-	ctrl = CTRLDESCL0_3_P_SIZE(2) | CTRLDESCL0_3_T_SIZE(2) |
+	ctrl = CTRLDESCL0_3_STATE_CLEAR_VSYNC |
+	       CTRLDESCL0_3_P_SIZE(2) | CTRLDESCL0_3_T_SIZE(2) |
 	       CTRLDESCL0_3_PITCH(lcdif->crtc.primary->state->fb->pitches[0]);
 	writel(ctrl, lcdif->base + LCDC_V8_CTRLDESCL0_3);
 }
diff --git a/drivers/gpu/drm/mxsfb/lcdif_regs.h b/drivers/gpu/drm/mxsfb/lcdif_regs.h
index c55dfb236c1d..17882c593d27 100644
--- a/drivers/gpu/drm/mxsfb/lcdif_regs.h
+++ b/drivers/gpu/drm/mxsfb/lcdif_regs.h
@@ -190,6 +190,7 @@
 #define CTRLDESCL0_1_WIDTH(n)		((n) & 0xffff)
 #define CTRLDESCL0_1_WIDTH_MASK		GENMASK(15, 0)
 
+#define CTRLDESCL0_3_STATE_CLEAR_VSYNC	BIT(23)
 #define CTRLDESCL0_3_P_SIZE(n)		(((n) << 20) & CTRLDESCL0_3_P_SIZE_MASK)
 #define CTRLDESCL0_3_P_SIZE_MASK	GENMASK(22, 20)
 #define CTRLDESCL0_3_T_SIZE(n)		(((n) << 16) & CTRLDESCL0_3_T_SIZE_MASK)
-- 
2.53.0

