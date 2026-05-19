Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EDD7CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:09:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DA5C910EB6F;
	Tue, 19 May 2026 09:09:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="QeXNYocg";
	dkim-atps=neutral
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.153.233])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4B30410EBA3
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:09:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779181769; x=1810717769;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=FGxZyUqCZ0jZxo+9CRdWfsvZXgcZ2nFVcizJ+OoI7P0=;
 b=QeXNYocga3H2SWRFZqKrEirFjWAgjwSmkox3B4N/UueHARvUuMNCJeNZ
 SWGb6NwZZRkh7eScvYBpneHbFCVvUeVUfXr09Fv5BxGd3aQ1pQr7+ETUW
 MKMaYEMMkQBiTQ3fUWTFuWENmfc4n1Zeq4ZHW41z9haT6EBIlyA9FKw5b
 4NbXGmYHdVUPcakecApmMe5dYtVA+WnjEgOtiVYXFQtbCQ4uRu1gM8vKd
 8UbQmYUFczcknZH/PxvBAV7znTkHhU4LADAsPrGtTXbAPLVTYJWdfLaIt
 nj+WnBVkkuSNrf5WvmU84CAY66+q/8KUGItwGJtN9O+VO+6xal3ANWKrB Q==;
X-CSE-ConnectionGUID: h8SKNaLgSjKCVDhFiSGa1A==
X-CSE-MsgGUID: eP4Ycsd8QwuNwr7YuOvjRA==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; d="scan'208";a="66488484"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa1.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 19 May 2026 02:02:23 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.87.151) by
 chn-vm-ex4.mchp-main.com (10.10.87.33) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.2.2562.37; Tue, 19 May 2026 02:02:23 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 19 May 2026 02:02:17 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>
Subject: [PATCH 5/8] drm: atmel-hlcdc: extract clock setup into a dedicated
 helper
Date: Tue, 19 May 2026 14:31:32 +0530
Message-ID: <20260519090135.1188405-6-manikandan.m@microchip.com>
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

Factor clock enable, rate calculation, and divider selection out of
atmel_hlcdc_crtc_mode_set_nofb() into a new
atmel_hlcdc_crtc_setup_clock() helper, preparing for the addition
of LVDS and XLCDC clock bypass support.

Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 66 +++++++++++--------
 1 file changed, 39 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index c7e77bb2941a..6da428361c19 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -66,6 +66,42 @@ drm_crtc_to_atmel_hlcdc_crtc(struct drm_crtc *crtc)
 	return container_of(crtc, struct atmel_hlcdc_crtc, base);
 }
 
+static int atmel_hlcdc_crtc_setup_clock(struct atmel_hlcdc_crtc *crtc,
+					unsigned long mode_rate,
+					unsigned int *cfg,
+					unsigned int *mask)
+{
+	unsigned long prate;
+	int div, ret;
+
+	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+	if (ret)
+		return ret;
+
+	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
+	if (!crtc->dc->desc->fixed_clksrc) {
+		prate *= 2;
+		*cfg |= ATMEL_HLCDC_CLKSEL;
+		*mask |= ATMEL_HLCDC_CLKSEL;
+	}
+
+	div = DIV_ROUND_CLOSEST(prate, mode_rate);
+	if (div < 2) {
+		div = 2;
+	} else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
+		/* The divider ended up too big, try a lower base rate. */
+		if (!crtc->dc->desc->fixed_clksrc) {
+			*cfg &= ~ATMEL_HLCDC_CLKSEL;
+			div = DIV_ROUND_CLOSEST(prate >> 1, mode_rate);
+		}
+		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
+			div = ATMEL_HLCDC_CLKDIV_MAX;
+	}
+
+	*cfg |= ATMEL_HLCDC_CLKDIV(div);
+	return 0;
+}
+
 static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 {
 	struct atmel_hlcdc_crtc *crtc = drm_crtc_to_atmel_hlcdc_crtc(c);
@@ -76,12 +112,10 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 	struct atmel_hlcdc_crtc_state *state;
 	struct drm_device *ddev = c->dev;
 	struct drm_connector_list_iter iter;
-	unsigned long mode_rate;
 	struct videomode vm;
-	unsigned long prate;
 	unsigned int mask = ATMEL_HLCDC_CLKDIV_MASK | ATMEL_HLCDC_CLKPOL;
 	unsigned int cfg = 0;
-	int div, ret;
+	int ret;
 
 	/* get encoder from crtc */
 	drm_for_each_encoder(en_iter, ddev) {
@@ -100,33 +134,11 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 		drm_connector_list_iter_end(&iter);
 	}
 
-	ret = clk_prepare_enable(crtc->dc->hlcdc->sys_clk);
+	ret = atmel_hlcdc_crtc_setup_clock(crtc, adj->crtc_clock * 1000,
+					   &cfg, &mask);
 	if (ret)
 		return;
 
-	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
-	mode_rate = adj->crtc_clock * 1000;
-	if (!crtc->dc->desc->fixed_clksrc) {
-		prate *= 2;
-		cfg |= ATMEL_HLCDC_CLKSEL;
-		mask |= ATMEL_HLCDC_CLKSEL;
-	}
-
-	div = DIV_ROUND_CLOSEST(prate, mode_rate);
-	if (div < 2) {
-		div = 2;
-	} else if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK) {
-		/* The divider ended up too big, try a lower base rate. */
-		if (!crtc->dc->desc->fixed_clksrc) {
-			cfg &= ~ATMEL_HLCDC_CLKSEL;
-			div = DIV_ROUND_CLOSEST(prate >> 1, mode_rate);
-		}
-		if (ATMEL_HLCDC_CLKDIV(div) & ~ATMEL_HLCDC_CLKDIV_MASK)
-			div = ATMEL_HLCDC_CLKDIV_MAX;
-	}
-
-	cfg |= ATMEL_HLCDC_CLKDIV(div);
-
 	if (connector &&
 	    connector->display_info.bus_flags & DRM_BUS_FLAG_PIXDATA_DRIVE_NEGEDGE)
 		cfg |= ATMEL_HLCDC_CLKPOL;
-- 
2.25.1

