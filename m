Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4EE0510ED651
	for <dri-devel@archiver.kernel.org>; Fri, 27 Mar 2026 10:22:36 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id ED10A10EC28;
	Fri, 27 Mar 2026 10:22:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="oxaeOqAK";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2B29310E3A3
 for <dri-devel@lists.freedesktop.org>; Fri, 27 Mar 2026 10:22:32 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 2B0752F85;
 Fri, 27 Mar 2026 11:21:11 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774606871;
 bh=qDgOvHrPx5VBCjCyaz4snC9nowUJ1uQTs9EWYBT2EmM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=oxaeOqAKnSjzuZdPtXjnImwUa4GyysR+oRP23w0e+kVgt6UyJMiANttyWe2K9+Nq4
 kcXko+ieuDtOHVzgWRge5cqSSyjtqNtmM4wXc5Ghe9l/SjcXxwaqgRHlB633cUSsQ7
 Z87ijpHODNAn95gpen8Cop7qfGD51/eDlstvYt0c=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Fri, 27 Mar 2026 12:21:56 +0200
Subject: [PATCH v2 08/12] drm/bridge: tc358762: Support VTG
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260327-tc358762-fixes-v2-8-3589d3c45f4a@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3412;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=qDgOvHrPx5VBCjCyaz4snC9nowUJ1uQTs9EWYBT2EmM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxlpcNsqDgH8y2GjIikbc77QNJxyP27/8KWXnl
 +1LSGwqzbWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacZaXAAKCRD6PaqMvJYe
 9RJiEACRz+dMqwftX5IzdnlGnGY7983yUC5ZijLLOpdkd7Gs2DIjX7LUBCNIivalAdWAbdluLTn
 GVW6zh10NilujK2MKeZ+cM1qLS9bgqbsmzqTHV1nW17UKRflmQOmDI4Wjs7WEoXT6m9Tj91EcKK
 bTM9/GyXW+qzkipeTRq4dvDdedeRsIgA6XX3peFxqadzJhSlaDbxFCCLNSZrEGWT62CYJlMIxDc
 Ilmsl1tDYXqAwqHiNCnNZOOKVMhhnE9g4vuZXx4n8lsxMyYcOwAqrEq/r2ljZlMCIH/FCb1/5nm
 0bckoPzDUEWUWoUc4SIUuHIu476EuToWgkXwm9LLR7vi7gIzvbt7PN1NQbegsIzJlbItZXERgKy
 Rd0Eh3d3hdwDdh7uS4b6YQzEePiPWhhBOComNFBhSODqz1z/jgyjORPNaJcwGuVQnTCnCQJjRP4
 h/JJtu4fR0WGO+0VjIjDBmcMEREt/k66ehvLIUdluZ+2qY8J1knU31odi21XRtimWvhFdwlgxNF
 obKhAAjnJmJRs+/uG8yV7EOPi66rD5+LKouwEJWPM6DFFxUxMVNXxYyfnHl+kH2t6XV/sBzgpmx
 Rlcx0im/lUoWEhmhTB31Af7CmzvUOu2igeIEvjH27fBJuXQSdIOJKQyyV2yJyVkfYKrZg7HEkG5
 OObSqkdEICXzfNA==
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

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 33 +++++++++++++++++++++++++++++++++
 1 file changed, 33 insertions(+)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index 9fb921b3fa0d..d3bcdf8af804 100644
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

