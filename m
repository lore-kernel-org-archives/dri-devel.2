Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8E3A5C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:28:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AF8CF10E78C;
	Mon,  7 Sep 2026 11:28:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="whr/abnM";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2516810E78C
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:28:32 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B11CC157F;
 Mon,  7 Sep 2026 13:26:55 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788780416;
 bh=1Uecn7x6YA7Ongo44LRbcp26WhmtFnehgnKpHJpp28Y=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=whr/abnMdORYLQaXMiX2K18JB25/YnaIX1qM5+4k/ic8gcJCAFJQxhOk4wy1+PvDV
 TpGNQvwp5u2Lwug21mjFZal2aUBfSfv6TltCq9vcB9GApwo+/I8Zc2BKG6KQyUz4Xm
 LRQxaoJcJFaPuP8SoTtUvka1fkfM4wG211xosnZk=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 07 Sep 2026 14:28:03 +0300
Subject: [PATCH v4 08/13] drm/bridge: tc358762: Support VTG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tc358762-fixes-v4-8-e3fc3ab5cd83@ideasonboard.com>
References: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
In-Reply-To: <20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com>
To: Marek Vasut <marex@denx.de>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=1Uecn7x6YA7Ongo44LRbcp26WhmtFnehgnKpHJpp28Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnp/UFyupikbOyZA07F+YrKzgr4yoQoLR/R+f5
 8PdpCyneayJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6f1AAKCRD6PaqMvJYe
 9aVAD/0ftAubH68Fyjusg1gMLmkT1c0Oj8dUGbYSeeRoA/tzqhuAo3PGBvI8glIpQwyL5kbRDY8
 oOf1/bss/vwATKsWki0WhNb5trbubUBhEvmwNlLkNjqnE8fNVZMI4I2djOGd1EuAcNOLPZ6Y/+A
 PE+nHdfXHBtLU0zfgWUbvxncBfk5/GFx7LDiD/x4dWQZ3P9aGjLgXhOCn152DHjymwcoJ5Kb7e4
 mBT8u/QqQzWRXJIMgvoPBLfyH3zF9uMd7PmNAWZa9DgywfqynSMIWS5KHaivjxn9ZjgWRggtz9r
 9TSkPxkx8DAHGXZw4g5LJLeLQb67HN8lXoBL9foWzJQ3iFt6t/ZmRETTriTtur6KXJOcZkBhJqb
 1bsVhsRkjZ1xoRcwK8nLnpcquLwTaPrNeZmGyHERBUAUcvDP7WxAdXDhDoiNjQsYvzUkiAMCIL7
 HL8QZxFN/BuKgqFr0ns/niiU9i0xVpRbfgFo26i5ktjItGJiCZqcItYHNweVtNKuH5gRjnXZYcv
 xc+5/yXb/hWpa8q2LiwJ3mvQIh1cBNxn/37d6scK6cEKErX+LYb8JCHKFnHyUISoB+5JLn6HI/k
 kzcW5kn/CEAfiwHiGUy72XF+taBe1vn5qEL2vSULyDo9VIaUYLZEf27r2Wy9TE4iF2KLTUsXMLy
 yZeeC4QzUsj/pMA==
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

We are currently using VTG off in the driver.

I observe that the hsync signal, on my HW setup, is not 100% stable with
VTG off, and it seems to lengthen by a single clock every now and then.
However, it then stabilizes later. To me the DSI input looks solid, but
that is more challenging to measure exactly. So I have not found the
root cause for this.

Turning VTG on removes that instability. As I dont' see any downsides
with enabling VTG (and it would allow extending the driver to use
event/burst mode in the future), let's always enable the VTG.

Reviewed-by: Andreas Kemnade <andreas@kemnade.info>
Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 34f2bfd9977c..797866265b41 100644
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
@@ -305,6 +335,9 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	ctx->dev = dev;
 	ctx->pre_enabled = false;
 
+	/* Always use VTG */
+	ctx->use_vtg = true;
+
 	/*
 	 * When using DSI clk for pixel clock (only mode supported in the driver),
 	 * the pclk is derived directly from the DSI byteclk via simple divider,

-- 
2.43.0

