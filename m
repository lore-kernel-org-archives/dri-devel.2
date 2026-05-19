Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E0A66CD4F57
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:09:42 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 46BA110E382;
	Tue, 19 May 2026 09:09:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="m6Rdkkap";
	dkim-atps=neutral
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D446F10EB9C
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:09:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779181780; x=1810717780;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Tm9q+vgC/TE0/J5bF1BfNmg6fL5/6NXJsdwhZrhCZDU=;
 b=m6RdkkapVVLiCxnaU+wmJ2vH0cKEdnDDlaigwCraYTuhzgpJMqO8TdQ2
 sCxCo2uQUymSA1G4KbhL5TgNFWu3ggfzJre29O/Pu/5U3BPzlCr5SEUdr
 0bvKDS8tw8th/35skQVjWChlGrU8Vxtmo1ImIu2UASZEVNV5XLTU40UxI
 aX3wcFD4qJV4gvVmLoHBfwr9ee4MG7ndthO6JelciAydYcNezOzxpEY+N
 IqJ3qYmJmLt0QZvCmVu+JZuIiiF4VXXcKN4ZZQ/QYKvm5kTo4b2hQWpyB
 Mo4I8RUidImH0pJPh0aDRSpHJ9BIYssxZjjC2KhGv+kaIrMiC1RxWf/IW Q==;
X-CSE-ConnectionGUID: 0bjdnIJPTk6rZW7FT7klOA==
X-CSE-MsgGUID: iDGxftsOQZGzJhzB6fhTbA==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; d="scan'208";a="56939638"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa4.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2026 02:02:33 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 19 May 2026 02:02:33 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 19 May 2026 02:02:28 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 7/8] drm: atmel-hlcdc: add and configure LVDS PLL clock support
Date: Tue, 19 May 2026 14:31:34 +0530
Message-ID: <20260519090135.1188405-8-manikandan.m@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20260519090135.1188405-1-manikandan.m@microchip.com>
References: <20260519090135.1188405-1-manikandan.m@microchip.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
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

Set the LVDS PLL rate to 7x the pixel clock.
set ATMEL_XLCDC_CLKBYP for the LVDS path, leaving clock
lifecycle management to the atomic callbacks and fallback to
sys_clk for non-LVDS displays with proper error handling.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 45 +++++++++++++++++--
 1 file changed, 42 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index f837684654ea..73a8650bc9b7 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -26,6 +26,8 @@
 
 #include "atmel_hlcdc_dc.h"
 
+#define ATMEL_LVDS_PLL_MULT	7
+
 /**
  * struct atmel_hlcdc_crtc_state - Atmel HLCDC CRTC state structure
  *
@@ -66,6 +68,14 @@ drm_crtc_to_atmel_hlcdc_crtc(struct drm_crtc *crtc)
 	return container_of(crtc, struct atmel_hlcdc_crtc, base);
 }
 
+static void atmel_hlcdc_crtc_disable_clock(struct atmel_hlcdc_crtc *crtc)
+{
+	if (crtc->dc->hlcdc->lvds_pll_clk)
+		clk_disable_unprepare(crtc->dc->hlcdc->lvds_pll_clk);
+	else
+		clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+}
+
 static int atmel_hlcdc_crtc_setup_clock(struct atmel_hlcdc_crtc *crtc,
 					unsigned long mode_rate,
 					unsigned int *cfg,
@@ -74,6 +84,12 @@ static int atmel_hlcdc_crtc_setup_clock(struct atmel_hlcdc_crtc *crtc,
 	unsigned long prate;
 	int div, ret;
 
+	if (crtc->dc->hlcdc->lvds_pll_clk) {
+		*cfg |= ATMEL_XLCDC_CLKBYP;
+		*mask |= ATMEL_XLCDC_CLKBYP;
+		return clk_prepare_enable(crtc->dc->hlcdc->lvds_pll_clk);
+	}
+
 	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
 	if (ret)
 		return ret;
@@ -198,7 +214,7 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 			   ATMEL_XLCDC_DPI : ATMEL_HLCDC_MODE_MASK),
 			   cfg);
 
-	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+	atmel_hlcdc_crtc_disable_clock(crtc);
 }
 
 static enum drm_mode_status
@@ -254,7 +270,8 @@ static void atmel_hlcdc_crtc_atomic_disable(struct drm_crtc *c,
 				    10, 1000))
 		drm_warn(dev, "Atmel LCDC status register CLKSTS timeout\n");
 
-	clk_disable_unprepare(crtc->dc->hlcdc->sys_clk);
+	atmel_hlcdc_crtc_disable_clock(crtc);
+
 	pinctrl_pm_select_sleep_state(dev->dev);
 
 	pm_runtime_allow(dev->dev);
@@ -267,15 +284,33 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 {
 	struct drm_device *dev = c->dev;
 	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
+	struct drm_display_mode *adj = &c->state->adjusted_mode;
 	struct regmap *regmap = crtc->dc->hlcdc->regmap;
 	unsigned int status;
+	int ret;
 
 	pm_runtime_get_sync(dev->dev);
 
 	pm_runtime_forbid(dev->dev);
 
 	pinctrl_pm_select_default_state(dev->dev);
-	clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+
+	/*
+	 * Set LVDS PLL clock rate (7x pixel clock) if available
+	 */
+	if (crtc->dc->hlcdc->lvds_pll_clk) {
+		ret = clk_set_rate(crtc->dc->hlcdc->lvds_pll_clk,
+				   adj->clock * 1000 * ATMEL_LVDS_PLL_MULT);
+		if (ret) {
+			drm_err(dev, "Failed to set LVDS PLL clk rate: %d\n", ret);
+			goto err_clk;
+		}
+		ret = clk_prepare_enable(crtc->dc->hlcdc->lvds_pll_clk);
+	} else {
+		ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+	}
+	if (ret)
+		goto err_clk;
 
 	regmap_write(regmap, ATMEL_HLCDC_EN, ATMEL_HLCDC_PIXEL_CLK);
 	if (regmap_read_poll_timeout(regmap, ATMEL_HLCDC_SR, status,
@@ -310,7 +345,11 @@ static void atmel_hlcdc_crtc_atomic_enable(struct drm_crtc *c,
 	}
 
 	pm_runtime_put_sync(dev->dev);
+	return;
 
+err_clk:
+	pm_runtime_allow(dev->dev);
+	pm_runtime_put_sync(dev->dev);
 }
 
 #define ATMEL_HLCDC_RGB444_OUTPUT		BIT(0)
-- 
2.25.1

