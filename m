Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 805EB606A32E
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:08:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=PcAlb0O2
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0645010F41F;
	Tue, 24 Nov 2026 10:08:42 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1DB6C10ECE4
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:33 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2E1D6177A;
 Tue, 24 Nov 2026 11:05:58 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514759;
 bh=HjY1Jit5MOe1m04ersiQVCkKniAXMUZXAH64XmY7Abs=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=PcAlb0O27tqRbmRPZ56+Ejp/C7oM07zV2us53LC1Wus9Zx1y7D0hxBFQUUsActNUX
 IgvDxEAI47dDvSxJnEKTb1rBhO5ykbkpMATJ2E0X36fgsOJw7TvxNOd2B3oTHweRxl
 GleeH74QOv/qbL7Qdt8ZhkXep/a9Tuyz2+o5Bm4E=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 24 Nov 2026 12:07:54 +0200
Subject: [PATCH v6 03/13] drm/bridge: tc358762: Improve LCDCTRL defines
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc358762-fixes-v6-3-bd38fed6460f@ideasonboard.com>
References: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
In-Reply-To: <20261124-tc358762-fixes-v6-0-bd38fed6460f@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Andreas Kemnade <andreas@kemnade.info>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3058;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=HjY1Jit5MOe1m04ersiQVCkKniAXMUZXAH64XmY7Abs=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWIXJP/a+DGGPNC5HD3A+JkmK2F7VIYzGMgh1
 UfQw/ESwvWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViFwAKCRD6PaqMvJYe
 9UjyD/4tkN99svkaSNZZAT4p/kmaAP513Cm9I7xtGrDCubVhmUgX6Y5NVSPzfIVr2+iq25/gKpV
 TJLv5RzroZjhram5VgeCU/012Lx6d9ULsCu6Do5mwUXTsJTzSTTt/zkV2qF6e2d5UE9XbLAs+/d
 9KRnIsbpAz9R0ck8G1SyUtPBgmGRdNIOTRfKD/wzvzSjN3OPDqB+LWG1hOhk1AXJKIrfMO6UwgE
 UcQPN6NH1pxxCzIkLpjWgfZHYOUM2wDvHQ4dRBLYZ+0REQCJBokHnlhEhD9vI73f7M/aJsZwx4w
 vgUnOMtNF+RoQITD+FUN6iWLp9p853No/1/aRYi3Q6oedJRZfB57tBaNCGyuymaGS/7qVvPfK1i
 /8ITJmCS4386kr6ONecUFu+Ee9cGO2cgzxg6ac1HIcafNrbcVBAL3Nqfx1hw5VFQOlSQwszAqeO
 7K2sZHKcB04eotsdfsgZVgalJFkbZbGbUmnOOphZFprx3VIiTJJ7ijzsUqKc0Z3P2Hxn0KZq2Gc
 RwuJbk8soD4F2ZsNk6hWEC5HNVeD3go6O2ezFNvpkY4iIwJOOeB6/YFxAfhvkFUubZH8/0C7WE1
 M53vNtBA5d9fILVxOl90sjQCz8p4t/M040qh0B47xwnKc0563npTonEkduSDJrhWn4se4pSh3uo
 0zj53jTf3sZ8jUA==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

LCDCTRL fields are quite wrong in the driver. Fix the field defines.

A few notes about the wrong fields:

LCDCTRL_VSDELAY(1) actually sets LCDCTRL_DCLK_POL
LCDCTRL_UNK6 | LCDCTRL_VTGEN actually set LCDCTRL_PXLFORM_RGB888
LCDCTRL_RGB888 actually sets LCDCTRL_DPI_EN

The total still resulted in a working display even if the defines were
quite wrong.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 59c68432f8e1..26671dc66874 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -46,17 +46,22 @@
 #define DSI_LANEENABLE_L0EN	BIT(1)
 #define DSI_LANEENABLE_L1EN	BIT(2)
 
-/* LCDC/DPI Host Registers, based on guesswork that this matches TC358764 */
+/* LCDC/DPI Registers */
 #define LCDCTRL			0x0420 /* Video Path Control */
 #define LCDCTRL_MSF		BIT(0) /* Magic square in RGB666 */
-#define LCDCTRL_VTGEN		BIT(4)/* Use chip clock for timing */
-#define LCDCTRL_UNK6		BIT(6) /* Unknown */
-#define LCDCTRL_EVTMODE		BIT(5) /* Event mode */
-#define LCDCTRL_RGB888		BIT(8) /* RGB888 mode */
-#define LCDCTRL_HSPOL		BIT(17) /* Polarity of HSYNC signal */
-#define LCDCTRL_DEPOL		BIT(18) /* Polarity of DE signal */
-#define LCDCTRL_VSPOL		BIT(19) /* Polarity of VSYNC signal */
-#define LCDCTRL_VSDELAY(v)	(((v) & 0xfff) << 20) /* VSYNC delay */
+#define LCDCTRL_VTGEN		BIT(1) /* Use chip clock for timing */
+#define LCDCTRL_PXLFORM		GENMASK_U32(6, 4)
+#define LCDCTRL_PXLFORM_RGB666		0	/* x:R:G:B 6:8:8:8 */
+#define LCDCTRL_PXLFORM_RGB666_24	1	/* x:R:x:G:x:B 2:6:2:6:2:6 */
+#define LCDCTRL_PXLFORM_RGB565		2	/* x:R:G:B 8:5:6:5 */
+#define LCDCTRL_PXLFORM_RGB565_1	3	/* x:R:x:G:x:B 3:5:2:6:3:5 */
+#define LCDCTRL_PXLFORM_RGB565_2	4	/* x:R:x:G:x:B:x 2:5:3:6:2:5:1 */
+#define LCDCTRL_PXLFORM_RGB888		5	/* R:G:B 8:8:8 */
+#define LCDCTRL_DPI_EN		BIT(8)
+#define LCDCTRL_HSYNC_POL	BIT(17) /* Polarity of HSYNC signal */
+#define LCDCTRL_DE_POL		BIT(18) /* Polarity of DE signal */
+#define LCDCTRL_VSYNC_POL	BIT(19) /* Polarity of VSYNC signal */
+#define LCDCTRL_DCLK_POL	BIT(20) /* Polarity of pixel clock */
 
 /* SPI Master Registers */
 #define SPICMR			0x0450
@@ -139,14 +144,16 @@ static int tc358762_init(struct tc358762 *ctx)
 
 	tc358762_write(ctx, SPICMR, 0x00);
 
-	lcdctrl = LCDCTRL_VSDELAY(1) | LCDCTRL_RGB888 |
-		  LCDCTRL_UNK6 | LCDCTRL_VTGEN;
+	lcdctrl = FIELD_PREP(LCDCTRL_PXLFORM, LCDCTRL_PXLFORM_RGB888) |
+		  LCDCTRL_DPI_EN;
+
+	lcdctrl |= LCDCTRL_DCLK_POL;
 
 	if (ctx->mode.flags & DRM_MODE_FLAG_NHSYNC)
-		lcdctrl |= LCDCTRL_HSPOL;
+		lcdctrl |= LCDCTRL_HSYNC_POL;
 
 	if (ctx->mode.flags & DRM_MODE_FLAG_NVSYNC)
-		lcdctrl |= LCDCTRL_VSPOL;
+		lcdctrl |= LCDCTRL_VSYNC_POL;
 
 	tc358762_write(ctx, LCDCTRL, lcdctrl);
 

-- 
2.43.0

