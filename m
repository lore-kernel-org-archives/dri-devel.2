Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 04FC2CD37A7
	for <dri-devel@archiver.kernel.org>; Fri,  8 May 2026 11:18:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9F7A10F454;
	Fri,  8 May 2026 11:17:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aq2Ge6/Z";
	dkim-atps=neutral
Received: from mail-wr1-f45.google.com (mail-wr1-f45.google.com
 [209.85.221.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id ABB0310F450
 for <dri-devel@lists.freedesktop.org>; Fri,  8 May 2026 11:17:54 +0000 (UTC)
Received: by mail-wr1-f45.google.com with SMTP id
 ffacd0b85a97d-43fe3e22e33so1180250f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 08 May 2026 04:17:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778239073; x=1778843873; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=h4xhery0lAk3gv+PVUgTZeq25ctOn5hBwj4+jcbkRck=;
 b=aq2Ge6/Z57+3nli1qaUvsFbrRzCF+tjd7yREglKJWfkS2aBoHjs7G9G5QbL+WVIWka
 7mPxBuWuevt+QWNY1mHZJ73/XsVv+LC2gOBIZMBNBH1H01oPZ0QB4kpgvnDueMaeGVeS
 LbozzgIk63WQYFUoaxKEPVqaP8C1JR+HgA3R+fqxxyPcIh5TdT7YL/HF8+QliD/5MLXn
 cTgtr8gwdL5E9dAuIirhK2EnpveZO6LPIfj78+rsYPMuS1DBor1p1SkLXr9W9vM2BBr/
 kDvTl6ulbeKMDctLOqKA2m/d8bN9WfwcnLv6EhikVW+bDd6zCFbWnEHBE1L/QySVE8VQ
 qpPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778239073; x=1778843873;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=h4xhery0lAk3gv+PVUgTZeq25ctOn5hBwj4+jcbkRck=;
 b=T1xJoImfomNUeqx/R3+KTctA8VLiXmR7WKlZidZsfDXv4xGNCfPeaEVgA3hTyd5mAf
 0voRh34GDVVQISHRfysiNADehhabzmZDoPSV1NttWQZj4xsO/GUrjnx6Bg2egge8wZsR
 fc6Ht1G8JZhK432EDwQcGFt/H4Jn02yWWBEpOtaU5WGs/EfBvZXSD0XLZr9jywhuBL1n
 dyZDCFy9+k8iBR1bvGOXuKYkuKYvsmu6xN8VssIPfxYpTKiMegn9BQDlTPF4QV+8lQhP
 uWWQnuiqqx3UNdoIsBy/r6eI7dSQYYBtjnWMlk8JU1np2XZgoVyyqhOudNG6+7CNiv0r
 uanA==
X-Gm-Message-State: AOJu0Yy8uzZ6XiO1sr6zT1NlwGs1muRoFh0X07QThrAmtO6ILwTEGGOz
 tq7lCtzZdRgoT4B9K5/0mZFd5pND82kjOCLnmiVadDmW4qGXTJVPEUNY
X-Gm-Gg: Acq92OFVTSeLH4L/xxUdIR/hZdM0l3+BOWmbYpQwMgfkKecntLWREbNb1M3KPdnkyLp
 HOdCozglzjKDQihm9SLqVqTUBqyzFGYMP/H1OhvXE0o7fV0GrkAG2nKAOb4X9J6oOwa7fF8TNBz
 qi1muE87949oNio0Slr2K87ZSACCbQFSLcHtNRfGRvIBUJknWEuFGz69cIJ58lqXUx74ufWJRcm
 xUTWhjnIjzw3GisImU3Sg0x3s1ZG2pp7ex/uHjYtlN4k+tQpFlC9CYudxSn8y1l9Ei80IfXHecl
 NqzoRMjMc5MUjW9eKDttXI0PhIHmT49Qhb5fUTqZYa3c6MicIqsxY/mmZTJ/SGqJ3hUYzS4NBiz
 2GfHe6DyiRCatqgEad1CBy9m2y0eN7XvUF7n3RROsMwwrbbGBppCNgBOP+eKD3uRzKNaaGh1fnF
 pmtKXftrQXRHDE7DGVaLCiT4FLejYRSqJM4WVJGmqQq+K9UV+LPjf1wI8E6NbBEG7gSNtz97qXf
 8l60hp6tqxyRfaadPDMbAzQvmz0mW3z2XuhpoZI/GpEw+1l
X-Received: by 2002:a05:6000:4010:b0:44b:aca1:f480 with SMTP id
 ffacd0b85a97d-4515a6c3361mr18785764f8f.8.1778239072877; 
 Fri, 08 May 2026 04:17:52 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:74ae:919a:e57c:bd9c])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-454916df968sm3535563f8f.25.2026.05.08.04.17.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 08 May 2026 04:17:52 -0700 (PDT)
From: Prabhakar <prabhakar.csengg@gmail.com>
X-Google-Original-From: Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Prabhakar <prabhakar.csengg@gmail.com>,
 Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
 Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Subject: [PATCH v2 4/4] drm: renesas: rz-du: Add support for RZ/T2H SoC
Date: Fri,  8 May 2026 12:17:44 +0100
Message-ID: <20260508111744.771659-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260508111744.771659-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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

From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>

The RZ/T2H (R9A09G077) SoC includes a DU with a DPI interface,
supporting resolutions up to WXGA with two RPFs for layer blending.
Unlike earlier RZ/G2L SoCs, RZ/T2H requires explicit assertion of a
DPI output-enable signal (DU_MCR0_DPI_EN) during CRTC startup.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
---
v1->v2:
- Added Reviewed-by tag from Laurent Pinchart.
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c |  7 ++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 14 ++++++++++++++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  | 10 ++++++++++
 3 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
index 48065f4952a3..d0f01aa642a7 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_crtc.c
@@ -28,6 +28,7 @@
 #include "rzg2l_du_vsp.h"
 
 #define DU_MCR0			0x00
+#define DU_MCR0_DPI_EN		BIT(0)
 #define DU_MCR0_DI_EN		BIT(8)
 
 #define DU_DITR0		0x10
@@ -217,8 +218,12 @@ static void rzg2l_du_crtc_put(struct rzg2l_du_crtc *rcrtc)
 static void rzg2l_du_start_stop(struct rzg2l_du_crtc *rcrtc, bool start)
 {
 	struct rzg2l_du_device *rcdu = rcrtc->dev;
+	u32 val = DU_MCR0_DI_EN;
 
-	writel(start ? DU_MCR0_DI_EN : 0, rcdu->mmio + DU_MCR0);
+	if (start && rzg2l_du_has(rcdu, RZG2L_DU_FEATURE_DPIO_OE))
+		val |= DU_MCR0_DPI_EN;
+
+	writel(start ? val : 0, rcdu->mmio + DU_MCR0);
 }
 
 static void rzg2l_du_crtc_start(struct rzg2l_du_crtc *rcrtc)
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 3b7162c6e1f4..fc55dfffebaf 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -63,10 +63,24 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
 	},
 };
 
+static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
+	.channels_mask = BIT(0),
+	.routes = {
+		[RZG2L_DU_OUTPUT_DPAD0] = {
+			.possible_outputs = BIT(0),
+			.port = 0,
+		},
+	},
+	.features = RZG2L_DU_FEATURE_DPIO_OE,
+	.mode_clock_min = 5000,
+	.mode_clock_max = 100000,
+};
+
 static const struct of_device_id rzg2l_du_of_table[] = {
 	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
 	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
 	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
+	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
 	{ /* sentinel */ }
 };
 
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index 885558eb9547..baf076d69cda 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -20,6 +20,8 @@
 struct device;
 struct drm_property;
 
+#define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable control */
+
 enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
 	RZG2L_DU_OUTPUT_DPAD0,
@@ -46,12 +48,14 @@ struct rzg2l_du_output_routing {
  * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
  * @mode_clock_min: minimum pixel clock in kHz
  * @mode_clock_max: maximum pixel clock in kHz
+ * @features: device features (RZG2L_DU_FEATURE_*)
  */
 struct rzg2l_du_device_info {
 	unsigned int channels_mask;
 	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
 	u32 mode_clock_min;
 	u32 mode_clock_max;
+	unsigned int features;
 };
 
 #define RZG2L_DU_MAX_CRTCS		1
@@ -77,6 +81,12 @@ static inline struct rzg2l_du_device *to_rzg2l_du_device(struct drm_device *dev)
 	return container_of(dev, struct rzg2l_du_device, ddev);
 }
 
+static inline bool rzg2l_du_has(struct rzg2l_du_device *rcdu,
+				unsigned int feature)
+{
+	return rcdu->info->features & feature;
+}
+
 const char *rzg2l_du_output_name(enum rzg2l_du_output output);
 
 #endif /* __RZG2L_DU_DRV_H__ */
-- 
2.54.0

