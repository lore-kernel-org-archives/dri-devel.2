Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6140CD8C9D
	for <dri-devel@archiver.kernel.org>; Mon,  8 Jun 2026 08:58:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 887D710EFC1;
	Mon,  8 Jun 2026 08:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="d66xZIFw";
	dkim-atps=neutral
Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com
 [209.85.214.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C1C610EC3A
 for <dri-devel@lists.freedesktop.org>; Mon,  8 Jun 2026 02:32:58 +0000 (UTC)
Received: by mail-pl1-f174.google.com with SMTP id
 d9443c01a7336-2c0c2d8b95bso25653135ad.1
 for <dri-devel@lists.freedesktop.org>; Sun, 07 Jun 2026 19:32:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780885978; x=1781490778; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=rCTTyDg8O+LYe31dsdYUzuGSGbt3ApYha6QKkmglNt4=;
 b=d66xZIFwek0LuEHDhL8AW9K+RRxUUO1q7AgF4VAZccIKQU9cVF6kF0RCZ84/H/23Gc
 jDPKJMydjBTcBI/AHVSppOxaU6pjnPqd6JK/o48PmRkcYXlC4ikZKfAm99zdqF/iHv2F
 HrvoCEk+S1Slj5rhI3QVB5tQYaT5TlzdNnoyC2EiAT5jZ9/ZEsPX6X6mM4e7KSRXk1jG
 4DGKsRL2DUuhhIRRgJ0IkALyfa0LUoEaju2D35UDD4L2me+I3auUzQgkjaCSeBicilFZ
 9mw+X03poUzNHpRvU4b8OgjiJeIpqvDUwwxwU81jCqDw1eC8BQb5dqGYwvwQ1YJIVlU0
 sW3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780885978; x=1781490778;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=rCTTyDg8O+LYe31dsdYUzuGSGbt3ApYha6QKkmglNt4=;
 b=hnAQy7xCEof8jbkMi/TqJwQr0orOF3PamydCusyCoGpjKUZQJ78YKpAozVwPBQTfZ7
 rVgZQW9tVWmq3Q78fh0dj3ub2n0fDQAMGqt1jNHQl/zma1M1r1zh4yOSg5sJMqANoqSG
 gpgxqNdD8V0B8CMM/EtrfnkI/KbfgjJjTMawHqDpVsTSDBF8m8GofxFbRRNSKLjnnibA
 vaAPVKPmgHhC7OwP2hwkBbjVITlBDatbGvcKWDycsJMu36BLZblwZBWuEgd+L8rrzlyR
 Hx4CI2goRVPlPY53QxOeOXKhykMKEQs2BoSD7tpZQzwWEfoYNaaVg0Jzi0tn8taKYMnJ
 LvOw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+n9YQgG3zyn0pdA80MxD+OfD+16zQWMgTJXPwd3OOhoPRqPISnoW0bfHlP4dxX0u3AToCbm/npoAU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyk4QEpGE9yNzVlSPHIDZJPc4jd9GNcEBsY/yfZh3NPmSo2NSWS
 J3gUM9sqoZbDTh5gg2y+y7fmEuPPcJcW87srFSF/w7RUXVX/89VfPYuz
X-Gm-Gg: Acq92OFN8EAKYMWd6JaRaeD3LgSgEupFlQtSfJvQomrCFn01gKlEt1kssPNVWYTm56O
 sPNDSF3+fDn9qwZKmatwLhqUBKAnf7mI1WAB8sxC/f4wxbhHiHXIrLyV3gX57BS5K5rdrcMddp2
 jnvdCvDpyuh9ubEtOdlxY2cQbEeQ6uUrzft8iJVl8pu99biADjlk1Q7q71fRSbYQoVfyUnMlX1i
 jlCSabfxvGRdS7cm470fRKtXJB9AGljC3rVDZsGLoMtC+rExdy/vsriwBe15rkNRnVHAswfwZ47
 ETQ8Cp0EnDT+8RkiEVEkGkxxLDPFuQQZeVV3jLkrXwo8+DsC6c8X3xUDhX3vr+mD6RaNrWuHMZf
 eEtz18tsnXuh02TqBQzKiO+PXlaQJ8/jQdZgFBduL3zrUwSqIy9CY2rMhVP9EZztM06ZgPh9ucQ
 QvvwJH60Aj+2+dwH4vcpa4s/3AFcy+mARFfus8/WBwky7uL8gpTXCdNP+y2OvbdclTMAbPwxSFB
 tKxzgiZgSeI4LsFalWHDnc=
X-Received: by 2002:a17:903:3885:b0:2c2:245a:336c with SMTP id
 d9443c01a7336-2c2245a3654mr104856695ad.14.1780885977664; 
 Sun, 07 Jun 2026 19:32:57 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c245dd3b5dsm38143485ad.81.2026.06.07.19.32.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 07 Jun 2026 19:32:57 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v3 4/5] drm/verisilicon: add Nuvoton MA35D1 DCU Lite display
 controller support
Date: Mon,  8 Jun 2026 10:32:36 +0800
Message-ID: <20260608023237.305036-5-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260608023237.305036-1-a0987203069@gmail.com>
References: <20260608023237.305036-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 08 Jun 2026 08:58:33 +0000
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

The Nuvoton MA35D1 SoC integrates a Verisilicon DCUltraLite display
controller whose register layout differs from the DC8200 in several
important ways:

1. No CONFIG_EX commit path: framebuffer updates use the enable (bit 0)
   and reset (bit 4) bits in FB_CONFIG instead of the DC8200 staging
   registers (FB_CONFIG_EX, FB_TOP_LEFT, FB_BOTTOM_RIGHT,
   FB_BLEND_CONFIG, PANEL_CONFIG_EX).

2. No PANEL_START register: panel output starts when
   PANEL_CONFIG.RUNNING is set; there is no multi-display sync start
   register.

3. Different IRQ registers: DCUltraLite uses DISP_IRQ_STA (0x147C) /
   DISP_IRQ_EN (0x1480) versus DC8200's TOP_IRQ_ACK (0x0010) /
   TOP_IRQ_EN (0x0014).

4. Per-frame commit cycle: DCUltraLite requires the VALID bit in
   FB_CONFIG to be set at the start of each atomic commit (crtc_begin)
   and cleared after (crtc_flush).

5. Simpler clock topology: only 'core' (bus gate) and 'pix0' (pixel
   divider) clocks; no axi or ahb clocks required.  Make axi_clk and
   ahb_clk optional (devm_clk_get_optional_enabled) so DCUltraLite
   nodes without those clocks are handled gracefully.

Add vs_dcu_lite.c implementing the vs_dc_funcs vtable for the above
differences.  The probe now selects vs_dcu_lite_funcs when the
identified generation is VSDC_GEN_DC8000 (DCUltraLite reads model 0x0,
revision 0x5560, customer_id 0x305).

Extend Kconfig to allow building on ARCH_MA35 platforms.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/Kconfig       |  2 +-
 drivers/gpu/drm/verisilicon/Makefile      |  2 +-
 drivers/gpu/drm/verisilicon/vs_dc.c       |  9 ++-
 drivers/gpu/drm/verisilicon/vs_dcu_lite.c | 78 +++++++++++++++++++++++
 4 files changed, 86 insertions(+), 5 deletions(-)
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
index 9d4cd16452fa..960af0861dfa 100644
--- a/drivers/gpu/drm/verisilicon/Makefile
+++ b/drivers/gpu/drm/verisilicon/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o vs_drm.o vs_hwdb.o \
+verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o vs_dcu_lite.o vs_drm.o vs_hwdb.o \
 	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
 
 obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon-dc.o
diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisilicon/vs_dc.c
index c94957024189..81a8d9bf85bd 100644
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
+	if (dc->identity.generation == VSDC_GEN_DC8200)
+		dc->funcs = &vs_dc8200_funcs;
+	else
+		dc->funcs = &vs_dcu_lite_funcs;
 
 	if (port_count > dc->identity.display_count) {
 		dev_err(dev, "too many downstream ports than HW capability\n");
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

