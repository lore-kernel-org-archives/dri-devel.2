Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 40228CD4F24
	for <dri-devel@archiver.kernel.org>; Tue, 12 May 2026 14:41:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9059710EAF6;
	Tue, 12 May 2026 14:41:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q99K0OOL";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9007A10EAF6
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 14:41:50 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-43d76dd4ee8so5201123f8f.2
 for <dri-devel@lists.freedesktop.org>; Tue, 12 May 2026 07:41:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1778596909; x=1779201709; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=hXd9Im5JkcfNXeD9xdaj2wvZlrhVhMEcCS8MB51Wmes=;
 b=q99K0OOLn3vTuV8yFTvf8zVpM2bW2lyhcmkKGg8P2dcasrxwW1XIUEf7EGFdIEPR3i
 melzpKhLzog0BKGrEYK/iOynmQRRDkDM4UJnm2EflVlk/4kpbv0ojajhkaQ/BLPAwMGk
 F7uvEr7BDrgswdi/G0trzHM01nHlAGlkMKzowS1F65lt3g7MzIlfTkR1GXANPUZVuEOg
 qjHemXb/7R/k1DT7tgHaZEcFeNUYPeFbt82RLD5fODvAwnCl+IX9LjjMf6w3FnVuWgp6
 BbJ4IsLvkpMzTXFeKNmWAKxUlaEykEnMHmWfbPaD30hNNyahpxYu619QNwHbVyXPKOJi
 b78A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1778596909; x=1779201709;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=hXd9Im5JkcfNXeD9xdaj2wvZlrhVhMEcCS8MB51Wmes=;
 b=PJgfWVmIxvPcviCpffJfeNpZyJsI5ylzFKUSr/H/EefS1HdKGX2+gagndWQmHir7Mc
 wOkk5zTRCywXEtVYZnHrLzWgd7dWnfU56swKv5ml9ExFC0cE2baJQbBOZpQq9jVDQc1Q
 ithnrt+bPySmmyPCCqJkNIPwyQy1oVlUe/MgqHMLIfXcuwl73FTL0wNqvpNdw+trQRRY
 XgjA8VLiPo4bU9BDc7BHwvfs8EgEawFF/25cezfiPpNPBBgR/eOKNJ9vnhUVERKigcYj
 W4RNuPtdiTwult1nHL3EFcxZ8M21VcXXkvI6zXS7ljXpgGyJ6wMCt9OsaQ9G4Wmqt0Wb
 IgHA==
X-Gm-Message-State: AOJu0YxD3MafUOs4DVqzyJnvNcqF/oNjYvzUDAyP6EE6caeYD4FmruQA
 N1e4KJ9aobqNOWqhaFGT9VfP/i6eDKUeVhV3q7/peS26xy3Te4np0bFs
X-Gm-Gg: Acq92OFZ2SsAhUFYKj1YPh1wdlqZnq3sHSCrwQaQWLGja1t6GqUUC/4wf7zFqoQZ070
 lARAczIrkE1gyQaNz5kmqJcTTa9TC10cASUrJLMZ8yDYB3sw673RFAnzleYNxUdgVMoVp0Ys3aT
 HcJx076bA8/oBNGV5TCNlFBX1OBdPqlF3WcWizdSsF0qzoophcDBtT/qU+N/OfJwNNozmj/j+fV
 +eIB3n+YpZ8kKKh4NKhnRMOcJe0EXVmxYcXwC+Fa+dZQ4QxPNOJ1O1HS6UwTjbr9Hbl44uRDoQb
 aV45kHaachIvNkwd3V0hAwFALgZ9OuprvM9VztUQpMIpWjWWFg63PIDlznspIf5NvgZEhZy5/k6
 XuddLhJugsRDbSeZf/BApzOdwUyhKJK9VCBTelJ+wp+UWvqFpWaFvtyx0+dCOxT52fIPUzZzh3c
 5+V8ndCyvAxfC0A2VIOGqAy46NRfRQ3/JuqbyINY4lJ7IS/5WeC9F9LL/EENcA8O/euf+b0WUNP
 Rg4kDiEH4JO/u7885tALGhjsZ3OYMOGU2E=
X-Received: by 2002:a05:6000:40de:b0:43b:3b80:6776 with SMTP id
 ffacd0b85a97d-456a44fc269mr20806748f8f.30.1778596903537; 
 Tue, 12 May 2026 07:41:43 -0700 (PDT)
Received: from iku.Home ([2a06:5906:61b:2d00:77f5:545a:798:321])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45491cab9c2sm34978713f8f.31.2026.05.12.07.41.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 12 May 2026 07:41:42 -0700 (PDT)
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
Subject: [PATCH v3 5/5] drm: renesas: rz-du: Add support for RZ/T2H SoC
Date: Tue, 12 May 2026 15:41:04 +0100
Message-ID: <20260512144104.761531-6-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20260512144104.761531-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
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
v2->v3:
- Moved clock limits from device_info to output_routing to allow
  per-output constraints.

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
index d1bc205eb5f8..0d4021429577 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -65,10 +65,24 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
 	},
 };
 
+static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
+	.channels_mask = BIT(0),
+	.routes = {
+		[RZG2L_DU_OUTPUT_DPAD0] = {
+			.possible_outputs = BIT(0),
+			.port = 0,
+			.mode_clock_min = 5000,
+			.mode_clock_max = 100000,
+		},
+	},
+	.features = RZG2L_DU_FEATURE_DPIO_OE,
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
index 307ae70dd382..2cb2d1895979 100644
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
@@ -48,10 +50,12 @@ struct rzg2l_du_output_routing {
  * struct rzg2l_du_device_info - DU model-specific information
  * @channels_mask: bit mask of available DU channels
  * @routes: array of CRTC to output routes, indexed by output (RZG2L_DU_OUTPUT_*)
+ * @features: device features (RZG2L_DU_FEATURE_*)
  */
 struct rzg2l_du_device_info {
 	unsigned int channels_mask;
 	struct rzg2l_du_output_routing routes[RZG2L_DU_OUTPUT_MAX];
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

