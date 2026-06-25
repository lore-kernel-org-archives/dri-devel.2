Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92F81CDE012
	for <dri-devel@archiver.kernel.org>; Fri, 26 Jun 2026 07:54:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 52E4810F496;
	Fri, 26 Jun 2026 07:53:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="imld+v6S";
	dkim-atps=neutral
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com
 [209.85.214.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8018310F1FF
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 09:45:15 +0000 (UTC)
Received: by mail-pl1-f181.google.com with SMTP id
 d9443c01a7336-2c7f123b1acso12729665ad.0
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 02:45:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782380715; x=1782985515; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=o0dxj0A552w7ubsF/6UDVTgs5P4hm62XQTlAEP8tTXI=;
 b=imld+v6SUPdFiKmbZzH+BCtN31SmnA5bqxwQgAvAiAtxTETvp+f41L7sb5P+Sxedyx
 md863ClmQKqHcHrYhlSyf3k7mGK1vj/SXor4ZT75bDUz6sRv/1QaKEF0nv0EJG5h0eYu
 vE2ksKvMcQSzwwhtt916NbD9hXAkgg5c1CRae+jluO+ZwhIUHBKVklf+i3ns6IMxEmge
 9yUCtAfINmT2q+0eDQFZjE3KbeXlNYR25leXrG8NlOwyQx+Oe3heFqPx/I43UlUfwi0v
 LnXbQqhEVi1V7Yvk/MAdqSV4hdMDlVTKZu7oxLqJsSUTKhAQWhKflZ4fTNZDEQ5MQQ56
 nqTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782380715; x=1782985515;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=o0dxj0A552w7ubsF/6UDVTgs5P4hm62XQTlAEP8tTXI=;
 b=ACD8rO9rM/xGubSPaCgdCgH/uXoIj/bxh38P4gCzCuSxDiRlEEBhibb9A+PFE6yUqk
 p5/4Jl7QTXpdTkLI6yyAVDOEU53xddXMyxt/32NGdkZuMv9txQpOSosnhFrCxcVGyeyi
 vPg/bRgYKewZhtPYUp+5OdDi68/HFEOxq/8LPynPopgPBiF5qCMuYNyvJ7FGYspbtb7D
 B/MaUFHR9fW1G9SOYd6O4m3dpD8jwmfzVGPqPF5z8idnU6bPkxBaWY4UlpaEmNmuq6n7
 8LPZxSmnPHOzABnPZz7twqnlnXf29D/tgnIW6OGAY3yJLAlk3PYGfMhenHJwwrdAbuZj
 FXBA==
X-Forwarded-Encrypted: i=1;
 AHgh+RpHc8uttQRuzZycYHiUH+b7bTtqZ5zN8Zl1T01aHHOjnZ8WKE8A7pY/cjIpgIUadPDIYUCRY7NCH0s=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyYJUuC8JqeixZL0dL0tz1nKEJ+fEhGwkFEk3riGLeiE0pCfH2e
 RTS18z35YqjN2XDIBpMLUGbP5GvsSMryW/1/K8BcxtQzpSom/rdzbfyi
X-Gm-Gg: AfdE7ckBtMOYT0z6W50AxqJX/JpUlNLWMI0TNiI8eBLTBok2u+cel2f2vCAdBsF656Y
 GZd/zlnQ3u7Q+xnBVLaLIdrNWyMbLJwO/wT5chTCz18t7cIk+4m15ui9iSNjkOCOdPPCAvCbXx7
 iHQDLE5y+MQs2xZi7gIXfil3PG8BDIgfMwI1Osr2r9vBocDf1ecNVTCicr7oxayu2uKFlLObVDg
 KnFH0XSxOWd+BS8DqYikJlKD93SEC+MAwWv0PQW8c8uWZrtkluNWQv4A/bOFXq3HVmLoRJ3tGUl
 zNK5/+/fnOVgDPTnkVWwIM03C+zpDmUOwnUb8qOo/hxZDH8pgMkbHFH8ysHxAkdzyaN4U9LeOYv
 jXUDi1/DeBwqoZuiZqbXT+O/QIXbZH0GQwC2PbrPyUrpJ4mNy1E9mK3CQwzrdvDAOOGvbFjQRI1
 TxXgTCXbDS8tPUuyklJEHeLpPiA8UGJ6CQjC8FOs5aZ046vNo0tDxhgmR8uFkDwsB7Uc4ORU29y
 A==
X-Received: by 2002:a17:903:37c6:b0:2c0:ab92:584c with SMTP id
 d9443c01a7336-2c7fc727984mr18002025ad.25.1782380714969; 
 Thu, 25 Jun 2026 02:45:14 -0700 (PDT)
Received: from localhost.localdomain (60-250-196-139.hinet-ip.hinet.net.
 [60.250.196.139]) by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2c7f5ac8c26sm16614995ad.1.2026.06.25.02.45.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 02:45:14 -0700 (PDT)
From: Joey Lu <a0987203069@gmail.com>
To: zhengxingda@iscas.ac.cn, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org
Cc: ychuang3@nuvoton.com, schung@nuvoton.com, yclu4@nuvoton.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 Joey Lu <a0987203069@gmail.com>
Subject: [PATCH v5 5/7] drm/verisilicon: add DC8000 (DCUltraLite) display
 controller support
Date: Thu, 25 Jun 2026 17:44:47 +0800
Message-ID: <20260625094449.708386-6-a0987203069@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260625094449.708386-1-a0987203069@gmail.com>
References: <20260625094449.708386-1-a0987203069@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Fri, 26 Jun 2026 07:53:42 +0000
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
controller (DC8000 generation) whose register layout differs from
the DC8200 in several important ways:

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

4. Simpler clock topology: only 'core' (bus gate) and 'pix0' (pixel
   divider) clocks; no axi or ahb clocks required.

Signed-off-by: Joey Lu <a0987203069@gmail.com>
---
 drivers/gpu/drm/verisilicon/Makefile    |  2 +-
 drivers/gpu/drm/verisilicon/vs_dc.c     |  5 +-
 drivers/gpu/drm/verisilicon/vs_dc.h     |  1 +
 drivers/gpu/drm/verisilicon/vs_dc8000.c | 86 +++++++++++++++++++++++++
 4 files changed, 92 insertions(+), 2 deletions(-)
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
index fd1f5fe67a68..9499fffbca58 100644
--- a/drivers/gpu/drm/verisilicon/vs_dc.c
+++ b/drivers/gpu/drm/verisilicon/vs_dc.c
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
index 825f5dd6bf17..ac96ad701199 100644
--- a/drivers/gpu/drm/verisilicon/vs_dc.h
+++ b/drivers/gpu/drm/verisilicon/vs_dc.h
@@ -66,5 +66,6 @@ struct vs_dc {
 };
 
 extern const struct vs_dc_funcs vs_dc8200_funcs;
+extern const struct vs_dc_funcs vs_dc8000_funcs;
 
 #endif /* _VS_DC_H_ */
diff --git a/drivers/gpu/drm/verisilicon/vs_dc8000.c b/drivers/gpu/drm/verisilicon/vs_dc8000.c
new file mode 100644
index 000000000000..fbe0fa516cac
--- /dev/null
+++ b/drivers/gpu/drm/verisilicon/vs_dc8000.c
@@ -0,0 +1,86 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (C) 2026 Joey Lu <yclu4@nuvoton.com>
+ */
+
+#include <linux/regmap.h>
+
+#include "vs_crtc_regs.h"
+#include "vs_dc.h"
+#include "vs_drm.h"
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
+static void vs_dc8000_crtc_enable_ex(struct vs_dc *dc, unsigned int output)
+{
+	regmap_set_bits(dc->regs, VSDC_FB_CONFIG(output),
+			VSDC_FB_CONFIG_ENABLE);
+}
+
+static void vs_dc8000_crtc_disable_ex(struct vs_dc *dc, unsigned int output)
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
+	u32 hw_irqs, unified = 0;
+	unsigned int i;
+
+	regmap_read(dc->regs, VSDC_DISP_IRQ_STA, &hw_irqs);
+
+	for (i = 0; i < VSDC_MAX_OUTPUTS; i++) {
+		if (hw_irqs & VSDC_DISP_IRQ_VSYNC(i))
+			unified |= VSDC_IRQ_VSYNC(i);
+	}
+
+	return unified;
+}
+
+const struct vs_dc_funcs vs_dc8000_funcs = {
+	.panel_enable_ex	= vs_dc8000_panel_enable_ex,
+	.panel_disable_ex	= vs_dc8000_panel_disable_ex,
+	.crtc_begin		= vs_dc8000_crtc_begin,
+	.crtc_flush		= vs_dc8000_crtc_flush,
+	.crtc_enable_ex		= vs_dc8000_crtc_enable_ex,
+	.crtc_disable_ex	= vs_dc8000_crtc_disable_ex,
+	.enable_vblank		= vs_dc8000_enable_vblank,
+	.disable_vblank		= vs_dc8000_disable_vblank,
+	.irq_ack		= vs_dc8000_irq_ack,
+};
-- 
2.43.0

