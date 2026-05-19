Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BCF55CD4F5B
	for <dri-devel@archiver.kernel.org>; Tue, 19 May 2026 07:13:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 71BDD10EAB6;
	Tue, 19 May 2026 07:13:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="cAKdYFW0";
	dkim-atps=neutral
Received: from mail-pf1-f180.google.com (mail-pf1-f180.google.com
 [209.85.210.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0AC5310EA59
 for <dri-devel@lists.freedesktop.org>; Tue, 19 May 2026 05:52:12 +0000 (UTC)
Received: by mail-pf1-f180.google.com with SMTP id
 d2e1a72fcca58-8379e010b01so1285213b3a.1
 for <dri-devel@lists.freedesktop.org>; Mon, 18 May 2026 22:52:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779169931; x=1779774731; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=VGibKSdQf3IcDSU8T6R8Cil+pcTsme1TCnBNNHxsWpo=;
 b=cAKdYFW0dVyDVOBSzL/2oQkdzutXPEE0RRxSIIV0XvZ/9oJ3Eey8D0IpCINnG9unaB
 UFY3niuJzRxiEUqG0A5K5LiX2R7rWg2DnPoQKPIVq2dkPNsygEjuaJEt/bQ9HeNoldAw
 sWgs5TSCa+Y8MFYFlUvIDoPi3oBO+XtZneAYafo3zGzE2s8ef70bfghaZLQVkRSTnXrL
 onXSFzEyftyTCHI7vbCiViJIqfC+9rm1U6dS5ev3sjoItOF6gELitJ8k9+vZ6o3dmNsl
 t6Gd1m+hP8zbMEGVBwiRMvAVtfIdpyYkRsZZyJoqy42KrGgySQ+moHxqBBC0VESXk5bv
 RTiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779169931; x=1779774731;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=VGibKSdQf3IcDSU8T6R8Cil+pcTsme1TCnBNNHxsWpo=;
 b=q0pZPxnbFXhYQixAAZFf6wdmFiN9RhTWea3S/vMDLM9trfNxdA2ix9fouvcj33yO57
 yxO0W3exoXIBNLP7xSfKSu7CXu/40XBanhSDZ7A80Yx3cXLDRoDY0G37B0AydYbeldT8
 sFYxaop0FQYSx7CFWcg83aN6REvRDGgYdgaeYGP5wRn1SkazuIVEkUZecpuGTgMXRTMC
 layo7hkLjJC8K+mWyZSNurXgGti0icFG4SRAMhrCIpG9ZMADBVUZCdqcTtAXtpZhMkgJ
 r4ZAQxnGT1ukIMNV0c8v70ia+KPnY0Dh+1WYDyQSF9jMRzhyYj0DctexBsD73CSTWobi
 D1Sg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+dNypuZhSusZz5tiED/RfqSRjOXsNHxD15Q+2HQXan+kB7cLjrR153/b1ZZnPVBXxJNjstTHqpudM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxsZXhIC6B+QFHgAKAHwdpPPu5bbgn8rU+X/tthr0bRk9u5p5mg
 w8afJ6ISMjEHmwJkpR/oXrxTUcnTK0HVE7WSumWsonSw6A+nWilLQn6a
X-Gm-Gg: Acq92OGalwVWAxMLf+Vok+I1bQssfCrPxEHQ8el+OgsilDVbfFUG+8itVyvujaps3DL
 4KMymBWLOfK7JIx8vUKO1t11gpDbP/jcBxAZBP9y0wMH0bhMk/r58aigDeH8C6aqa3E3DghwFYO
 N8IXtUqsWA+dmVSVEEvMUpJT8/1DDzukVmlDJhDalu9MI1DyZK/MfdaQ2StqsSIQ2SEtm8E3tHT
 AEncyQ7BPINiM9ag4mho6+Ii9K9lxu1ye1IivBwNUe/nGu4kli67ETuvr3Wy00YvNXBFckA23+l
 q4IUzOgANm5+hRAvGsTE5mBOQelJ0d2P3wKApMrLLtDLXuW0oLeTMW8F5pg/a5cMVZqlH+CCcSy
 ZZ6HeUF66TK8OjWYoVmZS0nlgNMM5Wz6uLcVT+Wd1czk5dkKfYHBONduabntHFV66iHxmSou6H6
 5n9JKy9mxYxRjXjkvLH7JVKBO2CGczFiErGjkWKpTcBnoI5bAgKdHnqZ9X4jzPA4xqNEuUchq2t
 icJBIIU64mA
X-Received: by 2002:a05:6a00:4304:b0:82c:d7c4:4c5c with SMTP id
 d2e1a72fcca58-83f33d0399bmr17632560b3a.20.1779169931435; 
 Mon, 18 May 2026 22:52:11 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d2e1a72fcca58-83f8b9c2ea5sm2641252b3a.13.2026.05.18.22.52.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 18 May 2026 22:52:11 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v2 4/4] drm/verisilicon: add Nuvoton MA35D1 DCU Lite display
 controller support
Date: Tue, 19 May 2026 13:51:09 +0800
Message-ID: <20260519055114.1886525-5-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260519055114.1886525-1-a0987203069@gmail.com>
References: <20260519055114.1886525-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 19 May 2026 07:13:01 +0000
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

The Nuvoton MA35D1 SoC integrates a Verisilicon DCU Lite display
controller.  While its register layout is broadly similar to the DC8200,
several differences require dedicated hardware ops:

1. No CONFIG_EX commit path: framebuffer updates use enable (bit 0) and
   reset (bit 4) bits in FB_CONFIG instead of the DC8200 staging registers
   (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT, FB_BLEND_CONFIG,
   PANEL_CONFIG_EX).

2. No PANEL_START register: panel output starts when
   PANEL_CONFIG.RUNNING is set; no multi-display sync start register
   is used.

3. Different IRQ registers: DCU Lite uses DISP_IRQ_STA (0x147C) /
   DISP_IRQ_EN (0x1480) versus DC8200's TOP_IRQ_ACK (0x0010) /
   TOP_IRQ_EN (0x0014).

4. Per-frame commit cycle: DCU Lite requires the VALID bit in FB_CONFIG
   to be set at the start of each atomic commit (crtc_begin) and cleared
   after (crtc_flush).

5. Simpler clock topology: only "core" (bus gate) and "pix0" (pixel
   divider) clocks; no axi or ahb clocks.  Make axi_clk and ahb_clk
   optional (devm_clk_get_optional_enabled) so DCU Lite nodes without
   those clocks are handled gracefully.

Add vs_dcu_lite.c implementing the vs_dc_funcs vtable for the above
differences.  After chip identity detection, vs_dc_probe() now selects
vs_dcu_lite_funcs when the identified model is VSDC_MODEL_DCU_LITE
(model register reads 0, revision 0x5560, customer_id 0x305).

Extend Kconfig to allow building on ARCH_MA35 platforms.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/Kconfig       |  2 +-
 drivers/gpu/drm/verisilicon/Makefile      |  2 +-
 drivers/gpu/drm/verisilicon/vs_dc.c       |  9 ++-
 drivers/gpu/drm/verisilicon/vs_dc.h       |  1 +
 drivers/gpu/drm/verisilicon/vs_dcu_lite.c | 78 +++++++++++++++++++++++
 5 files changed, 87 insertions(+), 5 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dcu_lite.c

diff --git a/drivers/gpu/drm/verisilicon/Kconfig b/drivers/gpu/drm/verisilicon/Kconfig
index 7cce86ec8603..295d246eb4b4 100644
--- a/drivers/gpu/drm/verisilicon/Kconfig
+++ b/drivers/gpu/drm/verisilicon/Kconfig
@@ -2,7 +2,7 @@
 config DRM_VERISILICON_DC
 	tristate "DRM Support for Verisilicon DC-series display controllers"
 	depends on DRM && COMMON_CLK
-	depends on RISCV || COMPILE_TEST
+	depends on RISCV || ARCH_MA35 || COMPILE_TEST
 	select DRM_BRIDGE_CONNECTOR
 	select DRM_CLIENT_SELECTION
 	select DRM_DISPLAY_HELPER
diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
index f4fbd9f7d6a2..bf88f627e65c 100644
--- a/drivers/gpu/drm/verisilicon/Makefile
+++ b/drivers/gpu/drm/verisilicon/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o vs_drm.o vs_hwdb.o vs_plane.o vs_primary_plane.o
+verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o vs_dcu_lite.o vs_drm.o vs_hwdb.o vs_plane.o vs_primary_plane.o
 
 obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon-dc.o
diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisilicon/vs_dc.c
index c94957024189..77bc63c629f7 100644
--- a/drivers/gpu/drm/verisilicon/vs_dc.c
+++ b/drivers/gpu/drm/verisilicon/vs_dc.c
@@ -90,13 +90,13 @@ static int vs_dc_probe(struct platform_device *pdev)
 		return PTR_ERR(dc->core_clk);
 	}
 
-	dc->axi_clk = devm_clk_get_enabled(dev, "axi");
+	dc->axi_clk = devm_clk_get_optional_enabled(dev, "axi");
 	if (IS_ERR(dc->axi_clk)) {
 		dev_err(dev, "can't get axi clock\n");
 		return PTR_ERR(dc->axi_clk);
 	}
 
-	dc->ahb_clk = devm_clk_get_enabled(dev, "ahb");
+	dc->ahb_clk = devm_clk_get_optional_enabled(dev, "ahb");
 	if (IS_ERR(dc->ahb_clk)) {
 		dev_err(dev, "can't get ahb clock\n");
 		return PTR_ERR(dc->ahb_clk);
@@ -134,7 +134,10 @@ static int vs_dc_probe(struct platform_device *pdev)
 	dev_info(dev, "Found DC%x rev %x customer %x\n", dc->identity.model,
 		 dc->identity.revision, dc->identity.customer_id);
 
-	dc->funcs = &vs_dc8200_funcs;
+	if (dc->identity.model == VSDC_MODEL_DC8200)
+		dc->funcs = &vs_dc8200_funcs;
+	else
+		dc->funcs = &vs_dcu_lite_funcs;
 
 	if (port_count > dc->identity.display_count) {
 		dev_err(dev, "too many downstream ports than HW capability\n");
diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h b/drivers/gpu/drm/verisilicon/vs_dc.h
index 45172c1a525c..d77d4a1babdf 100644
--- a/drivers/gpu/drm/verisilicon/vs_dc.h
+++ b/drivers/gpu/drm/verisilicon/vs_dc.h
@@ -66,5 +66,6 @@ struct vs_dc {
 };
 
 extern const struct vs_dc_funcs vs_dc8200_funcs;
+extern const struct vs_dc_funcs vs_dcu_lite_funcs;
 
 #endif /* _VS_DC_H_ */
diff --git a/drivers/gpu/drm/verisilicon/vs_dcu_lite.c b/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
new file mode 100644
index 000000000000..11ef57d5ebaa
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_dcu_lite.c
@@ -0,0 +1,78 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Joey Lu <yclu4@nuvoton.com>
+ */
+
+#include <linux/regmap.h>
+
+#include "vs_crtc_regs.h"
+#include "vs_dc.h"
+#include "vs_primary_plane_regs.h"
+
+static void vs_dcu_lite_bridge_enable(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
+			VSDC_FB_CONFIG_RESET);
+}
+
+static void vs_dcu_lite_bridge_disable(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
+			  VSDC_FB_CONFIG_RESET);
+}
+
+static void vs_dcu_lite_crtc_begin(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
+			VSDC_FB_CONFIG_VALID);
+}
+
+static void vs_dcu_lite_crtc_flush(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
+			  VSDC_FB_CONFIG_VALID);
+}
+
+static void vs_dcu_lite_crtc_enable(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
+			VSDC_FB_CONFIG_ENABLE);
+}
+
+static void vs_dcu_lite_crtc_disable(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
+			  VSDC_FB_CONFIG_ENABLE);
+}
+
+static void vs_dcu_lite_enable_vblank(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_DISP_IRQ_EN,
+			VSDC_DISP_IRQ_VSYNC(output));
+}
+
+static void vs_dcu_lite_disable_vblank(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_DISP_IRQ_EN,
+			  VSDC_DISP_IRQ_VSYNC(output));
+}
+
+static u32 vs_dcu_lite_irq_handler(struct vs_dc *dc)
+{
+	u32 irqs;
+
+	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
+	return irqs;
+}
+
+const struct vs_dc_funcs vs_dcu_lite_funcs = {
+	.bridge_enable		= vs_dcu_lite_bridge_enable,
+	.bridge_disable		= vs_dcu_lite_bridge_disable,
+	.crtc_begin		= vs_dcu_lite_crtc_begin,
+	.crtc_flush		= vs_dcu_lite_crtc_flush,
+	.crtc_enable		= vs_dcu_lite_crtc_enable,
+	.crtc_disable		= vs_dcu_lite_crtc_disable,
+	.enable_vblank		= vs_dcu_lite_enable_vblank,
+	.disable_vblank		= vs_dcu_lite_disable_vblank,
+	.irq_handler		= vs_dcu_lite_irq_handler,
+};
-- 
2.43.0

