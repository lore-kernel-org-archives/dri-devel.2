Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2581910A62CA
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:13:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 84B6510E954;
	Thu, 26 Mar 2026 13:12:59 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Y3r4+MDD";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E153910E2B3
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:41 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BD7E1A4A;
 Thu, 26 Mar 2026 14:11:21 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774530682;
 bh=CEhiQIL8VfHlSJLkWU0JS+13Zp7vGR3INiXFC9yCxII=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Y3r4+MDDYcU7nDEQ3AAVXZwgLQdnXzxfEjTmMIMm3yoZl8L9m4V6yb4Ux5iMNdSlx
 MTLR6cBUY6ziEflYRwWxFTVj9qu26M6hWnpKr179hTx13k7rhab2U34ii+dnuTWQHz
 6MI4Udf9I/iGONH6cCPjjdNUT6h4NXyBqMB2bVQg=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 26 Mar 2026 15:12:18 +0200
Subject: [PATCH 8/8] drm/bridge: tc358762: Support VTG (but don't enable
 it)
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tc358762-fixes-v1-8-65f479227af5@ideasonboard.com>
References: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
In-Reply-To: <20260326-tc358762-fixes-v1-0-65f479227af5@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=2771;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=CEhiQIL8VfHlSJLkWU0JS+13Zp7vGR3INiXFC9yCxII=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxTDAp/5V3TOo8dVEuTSGITzETWuHx74kruOya
 DeSicWHTqmJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacUwwAAKCRD6PaqMvJYe
 9epeD/99OGuOfWgoUK9+KOv4nY9oiH8Q4+KVIdVDXd2g2GJil0U+Ed58xQFefGS5ypXZszQHAb0
 4rTOHMT9WTbQ+Gq0F6yXdgUWanfCpDtGwagDQKl7oLaP5tCWyntMp9CFpkMM/ozlx/0I5yuYIi5
 sq/Vhxh1WHUeD64OyrFU/0D/w9aLLnMAAu0zbkGRDPdWHSJfGxLXsciWf5mU8cWId8QJXAj0jL2
 PZczo8hL//O9z9ODM5T75QYyz8i/UfFg/6W9hTEXAhQMotkMVjKcxXxRJHJTACN3E9ZUOLpOg+4
 PBeg9bjzILCbRv8V/f31AeLgouL9hAqH6FNApaSSsPBV1s8QjbtXoy5FazC02Z21AK37UuvUaPB
 zXJD06ZG7/FUqVtczVgDasmfAEOr8ijOUUBCWcw8Br/ykJkuyOwEIYQBdwAeyjDrU1T5utxeSsu
 Ez6RxKUcTruGgMqzSxvKCK3SKsuHXovLsRdN3096XAT0b3I3b1BzbkKh7qs1/CEaVoTdEvQg7dr
 F6h4H585pCItkoDsPNfZbUUohpzqeFvMnAlURXfzSH3NkeL8ikSC0ULYCsCWs6PAc7qBGSh0QXK
 uf1K8+2S86d5pMSTRIhWP3g2wWVmgtaKq0/RTtrNVuW2twuIVdatSWjGHu76fybrX5+F8cfKXin
 jxb/HgBC1tLb4Ag==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

TC358762 can generate the DPI output's timings in two ways, either Video
Timings Generator (VTG) on or off:
- VTG off: Duplicate the timings coming from the DSI. This requires DSI
  pulse mode.
- VTG on: Sync frame on DSI VSync Start, but the exact output timings
  are defined in TC358762 registers. This can be used with DSI
  event/burst mode.

We are currently using VTG off in the driver. Add the scaffolding for
VTG mode, by adding "use_vtg" field, and configuring the timings if that
is set. For now "use_vtg" is always off, so this is mostly for
testing/debugging purposes, or basis for future work.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 30 ++++++++++++++++++++++++++++++
 1 file changed, 30 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 9fb921b3fa0d..ab1dd36468f4 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -18,6 +18,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <video/mipi_display.h>
+#include <video/videomode.h>
 
 #include <drm/drm_atomic_helper.h>
 #include <drm/drm_bridge.h>
@@ -63,6 +64,12 @@
 #define LCDCTRL_VSYNC_POL	BIT(19) /* Polarity of VSYNC signal */
 #define LCDCTRL_DCLK_POL	BIT(20) /* Polarity of pixel clock */
 
+#define LCDC_HSR_HBPR		0x0424
+#define LCDC_HDISPR_HFPR	0x0428
+#define LCDC_VSR_VBPR		0x042C
+#define LCDC_VDISPR_VFPR	0x0430
+#define LCDC_VFUEN		0x0434
+
 /* SPI Master Registers */
 #define SPICMR			0x0450
 #define SPITCR			0x0454
@@ -94,6 +101,7 @@ struct tc358762 {
 	struct drm_display_mode mode;
 	bool pre_enabled;
 	int error;
+	bool use_vtg;
 };
 
 static int tc358762_clear_error(struct tc358762 *ctx)
@@ -155,9 +163,31 @@ static int tc358762_init(struct tc358762 *ctx)
 	tc358762_write(ctx, PPI_D1S_ATMR, 0);
 	tc358762_write(ctx, PPI_LPTXTIMECNT, LPX_PERIOD);
 
+	if (ctx->use_vtg) {
+		struct videomode vm = { 0 };
+
+		drm_display_mode_to_videomode(&ctx->mode, &vm);
+
+		tc358762_write(ctx, LCDC_HSR_HBPR,
+			       vm.hsync_len | (vm.hback_porch << 16));
+		tc358762_write(ctx, LCDC_HDISPR_HFPR,
+			       vm.hactive | (vm.hfront_porch << 16));
+
+		tc358762_write(ctx, LCDC_VSR_VBPR,
+			       vm.vsync_len | (vm.vback_porch << 16));
+		tc358762_write(ctx, LCDC_VDISPR_VFPR,
+			       vm.vactive | (vm.vfront_porch << 16));
+
+		/* Upload VTG timings */
+		tc358762_write(ctx, LCDC_VFUEN, BIT(0));
+	}
+
 	lcdctrl = FIELD_PREP(LCDCTRL_PXLFORM, LCDCTRL_PXLFORM_RGB888) |
 		  LCDCTRL_DPI_EN;
 
+	if (ctx->use_vtg)
+		lcdctrl |= LCDCTRL_VTGEN;
+
 	lcdctrl |= LCDCTRL_DCLK_POL;
 
 	if (ctx->mode.flags & DRM_MODE_FLAG_NHSYNC)

-- 
2.43.0

