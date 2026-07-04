Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5069CC43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0682910E066;
	Sat,  4 Jul 2026 09:34:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="J4Pg/Za+";
	dkim-atps=neutral
Received: from mail-wm1-f52.google.com (mail-wm1-f52.google.com
 [209.85.128.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF2B710E066
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:41 +0000 (UTC)
Received: by mail-wm1-f52.google.com with SMTP id
 5b1f17b1804b1-493ce08a75bso4902495e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157680; x=1783762480; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=lk8KeGaS2vzt489ufFaIFCKPfsezxcRXdkgdO6L6HpI=;
 b=J4Pg/Za+SgtSsxVbcV4hXZ5KzQXqJz4HmYukh6TbMHLN3zLkvPit2sCDqZsM+793Kq
 DUnubMBF9DbqU2kPMCDRFMJ2FjWfjkRMeKcq3SjgBCmSm4hdNcHwMB4IGslxN0HvryLj
 2dZFIsxku+iJulWXZ/8y+mQ5sB8VQeCKAC04o42wtTck+MjtYhwKiQ3sTDbl5UyeljK8
 AKR9lN3yWK8bPn/V647SZCkdqNWuHPngLiUCL9V6GVpdKfIeRlsbmzGAdfDuc6aWM4Zi
 kpGni0y8nbD2WxAlvJyd6fdZAJAotZUoNR3hfIyrV7V1OG6jTr0U0j9byKaDGqDomxCr
 2sgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157680; x=1783762480;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=lk8KeGaS2vzt489ufFaIFCKPfsezxcRXdkgdO6L6HpI=;
 b=glHMlbmLAcCdp3xDShAEXh6fZtllanAgHBU7GHnEWt170JW9Z4CfRG2LhZxeIxfCUz
 zDXlVZlaL/6rof317Mmx3iw8JCTwwvtGYgrFJRNHexxqZTrp1TM4FRVzCv+sQzIeiIFJ
 krdVOIydOZHeglkZC5xOj6mUwqGDrme3yd42lpLlQNvWE7nlTymlyxJoT4z6uU+BfEOo
 uEW5nxbUmK9E7MhqLJjXbkihmUrdDzYkIeCpgKvRFBNOpeIDWwI1en1azrpAPvI3vHoc
 OHrcpSelYEDsoYzz5Y0UeblE4zlvwFe21DjV0rVBD3TiFP6gpLWrp56SrqCv81yxkYp3
 iI5Q==
X-Gm-Message-State: AOJu0YyeBTx59IciAZ59ie5gO31KThqtrjxsToq5DKRcXAgZteMKJPiK
 KBmKpHwNmZKTjPudxa7AVjm9t/gQOpFuEFWHhTqaihBKPFlCVXQoS2RXJDpSCBYS
X-Gm-Gg: AfdE7cnFLJSJECkFf1hlx/FuosQIcDRHq8O57YdfPHKYz8CXjp8a2r8S0uWSlboeTG7
 ES8/8CCHpie/wXwRfupMmwVEpfIb791D1nin+MmGwzQA/Tubj4VascMZZ9V+Xc1vsiIvTkv8P4p
 BEmU7bBStpAUpoTQGJ079zVjuUgXVwoAceAJMWGlWBepQKAkteyBwPCIYhwD5MCK6Vs5lDOv+Y+
 4fU7wsbQXi4edrc2bfm9ygQ9hjgq5/JQCnfy7mLXkZ8duKQktm+wyumFGylfIBe7W3tTex3xrq1
 iILzdpmto4xyv5WXSPyXyClOcAE81ueyG2NQB0WkS0RXgaIAmPXOFS1kfsw2KBU5THiIem0v8S7
 JDUKLzfqSFYvHS0n3/0xn5v/5/5z8+ykcAoB18toDwa6Gc3IgyWd3ZaQPYKwyZijZ2UEd5gbz6N
 CDe/Iqd36CbOBdjUzuTnRf
X-Received: by 2002:a05:600c:6098:b0:493:ba69:4d67 with SMTP id
 5b1f17b1804b1-493d11d6759mr30325455e9.12.1783157680272; 
 Sat, 04 Jul 2026 02:34:40 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:34:39 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Biju Das <biju.das.jz@bp.renesas.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 linux-kernel@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH 08/16] drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU support
Date: Sat,  4 Jul 2026 10:34:18 +0100
Message-ID: <20260704093433.273672-9-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
References: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Add Display Unit support for the Renesas RZ/G3L SoC (R9A08G046). It is
similar to the one found on RZ/G2L, but has LVDS support.

Signed-off-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  | 22 ++++++++++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |  4 ++++
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  4 ++++
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |  1 +
 4 files changed, 30 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
index 3d13f61d3c97..a8d841421a0b 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c
@@ -55,6 +55,24 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a07g044_info = {
 	.mode_clock_max = 83500,
 };
 
+static const struct rzg2l_du_device_info rzg2l_du_r9a08g046_info = {
+	.channels_mask = BIT(0),
+	.routes = {
+		[RZG2L_DU_OUTPUT_DSI0] = {
+			.possible_outputs = BIT(0),
+			.port = 0,
+		},
+		[RZG2L_DU_OUTPUT_DPAD0] = {
+			.possible_outputs = BIT(0),
+			.port = 1,
+		},
+		[RZG2L_DU_OUTPUT_LVDS0] = {
+			.possible_outputs = BIT(0),
+			.port = 2,
+		},
+	},
+};
+
 static const struct rzg2l_du_device_info rzg2l_du_r9a09g057_info = {
 	.channels_mask = BIT(0),
 	.routes = {
@@ -81,6 +99,7 @@ static const struct rzg2l_du_device_info rzg2l_du_r9a09g077_info = {
 static const struct of_device_id rzg2l_du_of_table[] = {
 	{ .compatible = "renesas,r9a07g043u-du", .data = &rzg2l_du_r9a07g043u_info },
 	{ .compatible = "renesas,r9a07g044-du", .data = &rzg2l_du_r9a07g044_info },
+	{ .compatible = "renesas,r9a08g046-du", .data = &rzg2l_du_r9a08g046_info },
 	{ .compatible = "renesas,r9a09g057-du", .data = &rzg2l_du_r9a09g057_info },
 	{ .compatible = "renesas,r9a09g077-du", .data = &rzg2l_du_r9a09g077_info },
 	{ /* sentinel */ }
@@ -92,7 +111,8 @@ const char *rzg2l_du_output_name(enum rzg2l_du_output output)
 {
 	static const char * const names[] = {
 		[RZG2L_DU_OUTPUT_DSI0] = "DSI0",
-		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0"
+		[RZG2L_DU_OUTPUT_DPAD0] = "DPAD0",
+		[RZG2L_DU_OUTPUT_LVDS0] = "LVDS0"
 	};
 
 	if (output >= ARRAY_SIZE(names))
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
index baf076d69cda..0b86c5a01210 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h
@@ -21,10 +21,12 @@ struct device;
 struct drm_property;
 
 #define RZG2L_DU_FEATURE_DPIO_OE	BIT(0)	/* Has DPIO output enable control */
+#define RZG2L_DU_FEATURE_SMUX2_DSI_CLK	BIT(1)	/* Per output mux */
 
 enum rzg2l_du_output {
 	RZG2L_DU_OUTPUT_DSI0,
 	RZG2L_DU_OUTPUT_DPAD0,
+	RZG2L_DU_OUTPUT_LVDS0,
 	RZG2L_DU_OUTPUT_MAX,
 };
 
@@ -61,6 +63,7 @@ struct rzg2l_du_device_info {
 #define RZG2L_DU_MAX_CRTCS		1
 #define RZG2L_DU_MAX_VSPS		1
 #define RZG2L_DU_MAX_DSI		1
+#define RZG2L_DU_MAX_LVDS		1
 
 struct rzg2l_du_device {
 	struct device *dev;
@@ -74,6 +77,7 @@ struct rzg2l_du_device {
 	unsigned int num_crtcs;
 
 	struct rzg2l_du_vsp vsps[RZG2L_DU_MAX_VSPS];
+	struct drm_bridge *lvds[RZG2L_DU_MAX_LVDS];
 };
 
 static inline struct rzg2l_du_device *to_rzg2l_du_device(struct drm_device *dev)
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
index f50d166b764f..7315d437c2ea 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c
@@ -105,6 +105,9 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 			return -EPROBE_DEFER;
 	}
 
+	if (output == RZG2L_DU_OUTPUT_LVDS0)
+		rcdu->lvds[output - RZG2L_DU_OUTPUT_LVDS0] = bridge;
+
 	dev_dbg(rcdu->dev, "initializing encoder %pOF for output %s\n",
 		enc_node, rzg2l_du_output_name(output));
 
@@ -115,6 +118,7 @@ int rzg2l_du_encoder_init(struct rzg2l_du_device  *rcdu,
 		return PTR_ERR(renc);
 
 	renc->output = output;
+	renc->rcdu = rcdu;
 	drm_encoder_helper_add(&renc->base, &rzg2l_du_encoder_helper_funcs);
 
 	/* Attach the bridge to the encoder. */
diff --git a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
index 3e430c1f6132..8b048ca508be 100644
--- a/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
+++ b/drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.h
@@ -17,6 +17,7 @@ struct rzg2l_du_device;
 
 struct rzg2l_du_encoder {
 	struct drm_encoder base;
+	struct rzg2l_du_device *rcdu;
 	enum rzg2l_du_output output;
 };
 
-- 
2.43.0

