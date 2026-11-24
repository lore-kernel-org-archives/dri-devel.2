Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 87E04606A321
	for <dri-devel@archiver.kernel.org>; Tue, 24 Nov 2026 10:09:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=wjauX5jN
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CAECF10F423;
	Tue, 24 Nov 2026 10:09:03 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E5F6810F423
 for <dri-devel@lists.freedesktop.org>; Tue, 24 Nov 2026 10:08:37 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 650422104;
 Tue, 24 Nov 2026 11:06:03 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1795514764;
 bh=hBx6WXM/YMTmYmTmaDT9y0QG2n3H5HwZ0Dyi48P74GM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=wjauX5jNcI95TufnMPfSilv3tuOrVcSlNmRSGmrsMM+3eWja0hDj/htmcEuNhJzbx
 hWvFvSFwcY2GIfCdTOzC3O9FDQIk+EfjAVCxYv78Oo+r1zuI2cHoHyN2awugTVHiYW
 g3E98D1c0hNOCBv9vczC8vZvh8os5HqNyC6XyP7Y=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Tue, 24 Nov 2026 12:07:59 +0200
Subject: [PATCH v6 08/13] drm/bridge: tc358762: Support VTG
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20261124-tc358762-fixes-v6-8-bd38fed6460f@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3465;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=hBx6WXM/YMTmYmTmaDT9y0QG2n3H5HwZ0Dyi48P74GM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBrBWIZtjg3QZAL0/30bg9kq8+plo7f2dzzuXXtk
 hyfgUU2IZCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCawViGQAKCRD6PaqMvJYe
 9bS7D/99pvK2vBEv8PdlNWWzzFKn5Y4JPgykeA04speRXr/sc247YzIyazr4qKPhnq+nsrCBDOJ
 G8J7R66sxrSlf4QoloX+vxlqyUN1NP0YgFyvZPZe946C154892NRp5Gd9AKutMaQgkLmy/de0fR
 UYACQaEreofpepGbNFAXm2/vrOaSH/30m3A074yrNjkkOcSwLm02YMJRlXMxZbQRQuXx6ewSWv3
 owHwlTG/MHxQn6AQI9BsAOa5FhMmq+BDiGWnkUyf5orLkl+GBbaVsKz8fzfoiz9kQWSoBRDl0Tu
 m00xF9tW1Ly+V3KMJ1viqoYNAl7Y9NlUgWa66xRxvr1z4ObY0AVQ6amji989I0HQ38JMNG723Yj
 GrSy824AWeEquAZ9ZF7EVQaseXUdz4IsI9TXqRDsu/eBEaDgg8toK8A/1uHbdkh5U3DbZBjy9Df
 bAWfIgiGy+FPm6ceu/PABW1IK5eTWM6iO94AomMXFyPgClK7imO7L4bs9VbhH1WeSBXhNS+lK69
 0zSviPOwl9/NgskNLZyeT92PNLs8hJp5q45kQJJS8XyDnErnrGU4gnnMTu5OnpoBSd1hxWee5ma
 9rnpLRRTP7GgbnPxK7cJRr+A5RIH3JaldoWEaR9RGULr60e5e3/QBdYuiMOcq8rFZ+GW7gpGb3O
 MHMyJ9y19rqCj6w==
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
index 59323f26b2d2..3ccb5aa40446 100644
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
@@ -309,6 +339,9 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
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

