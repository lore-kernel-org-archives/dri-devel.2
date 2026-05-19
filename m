Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A95E0CD4851
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 09:09:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 10E2910EBC8;
	Tue, 19 May 2026 09:09:14 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=microchip.com header.i=@microchip.com header.b="dMzI+sEn";
	dkim-atps=neutral
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com
 [68.232.154.123])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2CEE210EBC8
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 09:09:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
 t=1779181753; x=1810717753;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=t4dc/uQKHAV33hkQ7VeDETtoUrrUhDgC2o3bONeq+AU=;
 b=dMzI+sEnBn+JVAcYOavxaWo6dhbJZqs/QdxM3Eg5cBudGlJiR/QliU50
 Y+spCns1KrSRsi3tzDVbn0v1G2xD4JQan5zll5ULDrRhMM1Z4NDPmsfb9
 bZzsjft1RJ+ZlGr2X1kMUODqOWuUAzIvYMwSPXYwz0sC5Ae2/HE3yNJbo
 6CkbJazxMVQfw7b8MArkvUJvCLf8ItLBqOYg+efvsd7KtPK9DmCbDmL+C
 o8Mg5cUiFewwxebUpOBW91SN37VHgR4nM/jGyiPM7XgMmm+k3s3WgmKFa
 xaAql1ZL0nlHQHwUOuBC9/qawC/+AEEZQqgoe/JwDEaSdnlQ26TB/qvsC A==;
X-CSE-ConnectionGUID: mYWIWAQ5SfKk/NCNR6kc+Q==
X-CSE-MsgGUID: VMn+Al8yR2qab3sd17nVOQ==
X-IronPort-AV: E=Sophos;i="6.23,243,1770620400"; d="scan'208";a="224955538"
X-Amp-Result: SKIPPED(no attachment in message)
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
 by esa6.microchip.iphmx.com with ESMTP/TLS/ECDHE-RSA-AES128-GCM-SHA256;
 19 May 2026 02:02:06 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.58; Tue, 19 May 2026 02:02:06 -0700
Received: from che-lt-i67131.microchip.com (10.10.85.11) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.58 via Frontend Transport; Tue, 19 May 2026 02:02:01 -0700
From: Manikandan Muralidharan <manikandan.m@microchip.com>
To: <maarten.lankhorst@linux.intel.com>, <mripard@kernel.org>,
 <tzimmermann@suse.de>, <airlied@gmail.com>, <simona@ffwll.ch>,
 <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
 <claudiu.beznea@tuxon.dev>, <lee@kernel.org>,
 <dri-devel@lists.freedesktop.org>, <linux-arm-kernel@lists.infradead.org>,
 <linux-kernel@vger.kernel.org>
CC: <manikandan.m@microchip.com>, Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH 2/8] drm: atmel-hlcdc: reorder timing register writes after
 clock setup
Date: Tue, 19 May 2026 14:31:29 +0530
Message-ID: <20260519090135.1188405-3-manikandan.m@microchip.com>
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

Write CFG(1-4) timing registers after CFG(0) clock configuration
rather than before, as required by the datasheet procedure.

Signed-off-by: Ryan Wanner <Ryan.Wanner@microchip.com>
Signed-off-by: Manikandan Muralidharan <manikandan.m@microchip.com>
---
 .../gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c    | 43 ++++++++++---------
 1 file changed, 23 insertions(+), 20 deletions(-)

diff --git a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
index 7932d666e9ec..9673fbce42a7 100644
--- a/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
+++ b/drivers/gpu/drm/atmel-hlcdc/atmel_hlcdc_crtc.c
@@ -104,26 +104,6 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 	if (ret)
 		return;
 
-	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
-	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
-	vm.vsync_len = adj->crtc_vsync_end - adj->crtc_vsync_start;
-	vm.hfront_porch = adj->crtc_hsync_start - adj->crtc_hdisplay;
-	vm.hback_porch = adj->crtc_htotal - adj->crtc_hsync_end;
-	vm.hsync_len = adj->crtc_hsync_end - adj->crtc_hsync_start;
-
-	regmap_write(regmap, ATMEL_HLCDC_CFG(1),
-		     (vm.hsync_len - 1) | ((vm.vsync_len - 1) << 16));
-
-	regmap_write(regmap, ATMEL_HLCDC_CFG(2),
-		     (vm.vfront_porch - 1) | ((vm.vback_porch - 1) << 16));
-
-	regmap_write(regmap, ATMEL_HLCDC_CFG(3),
-		     (vm.hfront_porch - 1) | ((vm.hback_porch - 1) << 16));
-
-	regmap_write(regmap, ATMEL_HLCDC_CFG(4),
-		     (adj->crtc_hdisplay - 1) |
-		     ((adj->crtc_vdisplay - 1) << 16));
-
 	prate = clk_get_rate(crtc->dc->hlcdc->sys_clk);
 	mode_rate = adj->crtc_clock * 1000;
 	if (!crtc->dc->desc->fixed_clksrc) {
@@ -164,6 +144,29 @@ static void atmel_hlcdc_crtc_mode_set_nofb(struct drm_crtc *c)
 
 	regmap_update_bits(regmap, ATMEL_HLCDC_CFG(0), mask, cfg);
 
+	vm.vfront_porch = adj->crtc_vsync_start - adj->crtc_vdisplay;
+	vm.vback_porch = adj->crtc_vtotal - adj->crtc_vsync_end;
+	vm.vsync_len = adj->crtc_vsync_end - adj->crtc_vsync_start;
+	vm.hfront_porch = adj->crtc_hsync_start - adj->crtc_hdisplay;
+	vm.hback_porch = adj->crtc_htotal - adj->crtc_hsync_end;
+	vm.hsync_len = adj->crtc_hsync_end - adj->crtc_hsync_start;
+
+	regmap_write(regmap, ATMEL_HLCDC_CFG(1),
+		     (vm.hsync_len - 1) |
+		     ((vm.vsync_len - 1) << 16));
+
+	regmap_write(regmap, ATMEL_HLCDC_CFG(2),
+		     (vm.vfront_porch - 1) |
+		     ((vm.vback_porch - 1) << 16));
+
+	regmap_write(regmap, ATMEL_HLCDC_CFG(3),
+		     (vm.hfront_porch - 1) |
+		     ((vm.hback_porch - 1) << 16));
+
+	regmap_write(regmap, ATMEL_HLCDC_CFG(4),
+		     (adj->crtc_hdisplay - 1) |
+		     ((adj->crtc_vdisplay - 1) << 16));
+
 	state = drm_crtc_state_to_atmel_hlcdc_crtc_state(c->state);
 	cfg = state->output_mode << 8;
 
-- 
2.25.1

