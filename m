Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 50B63CD98D6
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 07:58:24 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A0CE410E24F;
	Mon, 15 Jun 2026 07:58:23 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J+cnWCKs";
	dkim-atps=neutral
Received: from mail-dy1-f175.google.com (mail-dy1-f175.google.com
 [74.125.82.175])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4134C10E1FB
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 06:50:26 +0000 (UTC)
Received: by mail-dy1-f175.google.com with SMTP id
 5a478bee46e88-304cf518c9dso4665161eec.1
 for <dri-devel@lists.freedesktop.org>; Sun, 14 Jun 2026 23:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781506225; x=1782111025; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RCnGy4eyt7vZGs3J5YesXgpvuGxv5PNGr2RCRubwVqI=;
 b=J+cnWCKshKSRwiXfVCaBq5j8V0jCxoCa+wi0E3F4HixdCAO3nal4f2S4De/l/65YHF
 tVUltO8mTf8yfm1EAX4T1VKHDBuVY+bJFEZBuR/PDdJqG9C7Nd+jZpz4tOFOKtcH1sJq
 T9SyxwnEEU+eCOz7ih7/Q/VDYpd4Z5doT/LWPydsEKICn4NhMQMhLUN+r6mJSXWijh1Z
 7loi1TFkID5lndCJzfXTIyqVhAHfqvNVwuRZc7y4bAiyFQI1y7sXTkUh4tiTjBwYoRvA
 5R+bAgK4V+c6nwzTzdei1oJAj2MFRXh7mpQ+33nnIeK7yUyEmu9Fa/LAfWU2l1CzO6Yh
 ieLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781506225; x=1782111025;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RCnGy4eyt7vZGs3J5YesXgpvuGxv5PNGr2RCRubwVqI=;
 b=MM8VWZe+VIAsOjGJ4xPDrdhtsKr7zrkR0V298p9nIy3RRYci+sRrY8QLbOlvfCTWSY
 GqnN1XLY1QW5FXxaNMfgOzV7rptX8kbo3hndNXY3lsN8KOqkL6N++rxbWAwqoKrCkJnx
 4JAiyHaRFEe3syqE0+XSk830xrB8aL/LmUDg0DGXtQrvOJlA03G33O1NLKeB0HGhllFj
 fmBw6n49ZetxrKQ2phuohCbkFSUcmpjshURMHiFAt+L1o0lXVQh040fJTbOD3qJuIn5q
 bVK5UuQ6QFpGSEcwF2dEbvaVUp7f4l+vXh/7Plc0jk4jz5DwrhTvQ+jZzKm/J13n7n42
 3uwg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/CxHzv8FNWxdF6Joicg3gIsh6diq0JSVpuNC33f8mp/OoJIwaC9YgaYGDDOLplElGyThtqFpCqUxY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwwTXGO9fuAiruDFH9yFDtEJoxrKb+RqETlucsh1Oe7MgRKUm53
 zUyF2bnX56pjDDf70skDlIfSD+2sW6nc6z258+JKnDOH1/gHZ3yvHKgl
X-Gm-Gg: Acq92OE2HHQATB5YoZogbU4Kt8+LTulDcq98SnHU0ZdJKA3+/8PjwMvGXWSknIkZK5M
 Jq9aqmVkQhiHPobs7DJDfsg2fRj0/AhJaZGY97qnCQfmvNrK5D/cxY0JsdTTObP/e3P3/bNYWhf
 pvkL3a/Zpbu5WTLHcfA9c/5LpDPjuJM2+ABF1te5IxavMQW8hL5dWAGG1TCO7tBqj7hOH6455BF
 XOCdC2f0Kcynr/+5JBHEw8xzGTnvuFFfeRbc5nSxVf015wQ5XAtvUv1iIzOzIKnrZLs52U6ERki
 qKyCgiwda6q+Do4UlYQmk42JpLI8XxtipxRIYO9akI2nq++FTAEpmYujiA7TDxnfZwjU2kXqZsl
 qTciJyOOwMQMOYK0WUCb9IHkCwt1A95cj22IaERAb0qW9KzUixXFhDfQdLTPbhb/xleArdGLBOy
 TGW6W3y6P53GIH4poe3xylAVvflw1cWeS5Y7YZpr3TeXsCRJVg7c4rq3lOyJutwxq/PjuETu7+l
 6r/PVRzV5Hr
X-Received: by 2002:a05:7300:542:b0:2ea:e93a:ff9b with SMTP id
 5a478bee46e88-30936a4b1bfmr5180127eec.13.1781506225470; 
 Sun, 14 Jun 2026 23:50:25 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3081eb9a2e7sm13516812eec.30.2026.06.14.23.50.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 14 Jun 2026 23:50:25 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v4 4/6] drm/verisilicon: add DC8000 (DCUltraLite) display
 controller support
Date: Mon, 15 Jun 2026 14:50:01 +0800
Message-ID: <20260615065003.76661-5-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260615065003.76661-1-a0987203069@gmail.com>
References: <20260615065003.76661-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Mon, 15 Jun 2026 07:58:00 +0000
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
   ahb_clk optional (devm_clk_get_optional_enabled) so DC8000 nodes
   without those clocks are handled gracefully.

Add vs_dc8000.c implementing the vs_dc_funcs vtable for the above
differences.  The probe now selects vs_dc8000_funcs when the identified
generation is VSDC_GEN_DC8000 (DCUltraLite reads model 0x0,
revision 0x5560, customer_id 0x305).

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/Makefile    |  2 +-
 drivers/gpu/drm/verisilicon/vs_dc.c     |  9 ++-
 drivers/gpu/drm/verisilicon/vs_dc.h     |  1 +
 drivers/gpu/drm/verisilicon/vs_dc8000.c | 78 +++++++++++++++++++++++++
 4 files changed, 86 insertions(+), 4 deletions(-)
 create mode 100644 drivers/gpu/drm/verisilicon/vs_dc8000.c

diff --git a/drivers/gpu/drm/verisilicon/Makefile b/drivers/gpu/drm/verisilicon/Makefile
index 9d4cd16452fa..d2fd8e4dff24 100644
--- a/drivers/gpu/drm/verisilicon/Makefile
+++ b/drivers/gpu/drm/verisilicon/Makefile
@@ -1,6 +1,6 @@
 # SPDX-License-Identifier: GPL-2.0-only
 
-verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o vs_drm.o vs_hwdb.o \
+verisilicon-dc-objs := vs_bridge.o vs_crtc.o vs_dc.o vs_dc8200.o vs_dc8000.o vs_drm.o vs_hwdb.o \
 	vs_plane.o vs_primary_plane.o vs_cursor_plane.o
 
 obj-$(CONFIG_DRM_VERISILICON_DC) += verisilicon-dc.o
diff --git a/drivers/gpu/drm/verisilicon/vs_dc.c b/drivers/gpu/drm/verisilicon/vs_dc.c
index 9729b693d360..9499fffbca58 100644
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
+		dc->funcs = &vs_dc8000_funcs;
 
 	if (port_count > dc->identity.display_count) {
 		dev_err(dev, "too many downstream ports than HW capability\n");
diff --git a/drivers/gpu/drm/verisilicon/vs_dc.h b/drivers/gpu/drm/verisilicon/vs_dc.h
index 544e1a37065b..5218e8cf63e2 100644
--- a/drivers/gpu/drm/verisilicon/vs_dc.h
+++ b/drivers/gpu/drm/verisilicon/vs_dc.h
@@ -66,5 +66,6 @@ struct vs_dc {
 };
 
 extern const struct vs_dc_funcs vs_dc8200_funcs;
+extern const struct vs_dc_funcs vs_dc8000_funcs;
 
 #endif /* _VS_DC_H_ */
diff --git a/drivers/gpu/drm/verisilicon/vs_dc8000.c b/drivers/gpu/drm/verisilicon/vs_dc8000.c
new file mode 100644
index 000000000000..be0c0d7baf52
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_dc8000.c
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
+static void vs_dc8000_panel_enable_ex(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
+			VSDC_FB_CONFIG_RESET);
+}
+
+static void vs_dc8000_panel_disable_ex(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
+			  VSDC_FB_CONFIG_RESET);
+}
+
+static void vs_dc8000_crtc_begin(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
+			VSDC_FB_CONFIG_VALID);
+}
+
+static void vs_dc8000_crtc_flush(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
+			  VSDC_FB_CONFIG_VALID);
+}
+
+static void vs_dc8000_crtc_enable(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
+			VSDC_FB_CONFIG_ENABLE);
+}
+
+static void vs_dc8000_crtc_disable(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_FB_CONFIG(output),
+			  VSDC_FB_CONFIG_ENABLE);
+}
+
+static void vs_dc8000_enable_vblank(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_DISP_IRQ_EN,
+			VSDC_DISP_IRQ_VSYNC(output));
+}
+
+static void vs_dc8000_disable_vblank(struct vs_dc *dc, unsigned int output)
+{
+	regmap_clear_bits(dc->regs, VSDC_DISP_IRQ_EN,
+			  VSDC_DISP_IRQ_VSYNC(output));
+}
+
+static u32 vs_dc8000_irq_ack(struct vs_dc *dc)
+{
+	u32 irqs;
+
+	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &irqs);
+	return irqs;
+}
+
+const struct vs_dc_funcs vs_dc8000_funcs = {
+	.panel_enable_ex	= vs_dc8000_panel_enable_ex,
+	.panel_disable_ex	= vs_dc8000_panel_disable_ex,
+	.crtc_begin		= vs_dc8000_crtc_begin,
+	.crtc_flush		= vs_dc8000_crtc_flush,
+	.crtc_enable		= vs_dc8000_crtc_enable,
+	.crtc_disable		= vs_dc8000_crtc_disable,
+	.enable_vblank		= vs_dc8000_enable_vblank,
+	.disable_vblank		= vs_dc8000_disable_vblank,
+	.irq_ack		= vs_dc8000_irq_ack,
+};
-- 
2.43.0

