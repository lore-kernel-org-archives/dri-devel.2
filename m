Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 282B510ED65A
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 77F3210ED20;
	Fri, 27 Mar 2026 10:22:35 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Qh5RP1NG";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 50AC310E3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:27 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 50A3A201C;
 Fri, 27 Mar 2026 11:21:06 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606867;
 bh=NuaGyo7S8VZSSZ/guEUo9cbKkXUB0xNZ7DHe3gckBAc=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=Qh5RP1NGPt9/hPI+Q1Sb9OZPS921Nw9rh/4ybE4Y+SB1795fCZuGyGzzBn8Pc9xUu
 pH1SYQh4UX62hl5uTCFhPeWweii4+l5Oqq3lq3FjJRf9+w2gG4NKQfy0Vbv+H/tuDv
 Xx+zI2QZhj9II8ieljGvEYCI1/uLW8oMHVWItTrc=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:51 +0200
Subject: [PATCH v2 03/12] drm/bridge: tc358762: Improve LCDCTRL defines
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-3-3589d3c45f4a@ideasonboard.com>
References: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
In-Reply-To: <20260327-tc358762-fixes-v2-0-3589d3c45f4a@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=3005;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=NuaGyo7S8VZSSZ/guEUo9cbKkXUB0xNZ7DHe3gckBAc=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpaqEG2AEDHQCs6ZzihIgLoWocExJ+ySZsqY
 LtNRI+7y3uJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaWgAKCRD6PaqMvJYe
 9S7iD/9duMg80Wt5V3hKIigUEmAxAOiZ1mQhlUQW9gpaB7Mx4ad/Q77z/rOcz7PVebgct43Lutz
 DWILjV7IxfNQq8WdZHaAn15JRjnRV2iViwqjjPlv8HKOB7qbhBi8lBOhkq+aysRgagcQRja4iVE
 mQ4cExx5ZR5drtKuHXH2TLZum2U+yNyzGP9zXDACMFAbATFI+Mx4GXFcmO6qRCniDV1pCsn+ZNy
 K9mpaxbmJV29nxgr5F8ydP97cS3kX0zKIEDbIv0hjV62jM3Z6KxIPIYhJVR7Ry3jzvBYyHK45MW
 I5KA5wbynCzrsbg1qk3yAYXmkNddlMqurByYvKIv/gK9faFeMLjbwfxRp8zPAyMq6MAChOw5ul8
 GkVPuMyHeWIQ0dgcDCKSNR4XEZIMRNU5Y6DdxnZhjnL9TyXnM8jjW1OrV+SfwWiHax56HPYPyN2
 yzw+XstOdldz+WzU1J6CZ7z77RF9k46H/DydLm5PbOuUwEpdAXNJv7hbtLJYLK2Cfbr4Giq1Ddv
 eq0bPSb4Zh4TIcuUFDqGD/tRnInDnNCdH1V91HN3oDT/P//e7ECOLDws63Fhs5tuK3ZmqQWhKSz
 gcxmxLhEXYnqwxMuLVz6fQyTjybq9y3rb1YGUl6U5K3cUfTIEmafA7gmGUTaEOZx/GSre5OFr+W
 y9ZPz3eMmpkxOrA==
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

LCDCTRL fields are quite wrong in the driver. Fix the field defines.

A few notes about the wrong fields:

LCDCTRL_VSDELAY(1) actually sets LCDCTRL_DCLK_POL
LCDCTRL_UNK6 | LCDCTRL_VTGEN actually set LCDCTRL_PXLFORM_RGB888
LCDCTRL_RGB888 actually sets LCDCTRL_DPI_EN

The total still resulted in a working display even if the defines were
quite wrong.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 33 ++++++++++++++++++++-------------
 1 file changed, 20 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 9a0b1f0c18f0..cbedffb7a705 100644
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

