Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A8C6410A62CB
	for <dri-devel@archiver.kernel.org>; Thu, 26 Mar 2026 13:12:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F2B3110E930;
	Thu, 26 Mar 2026 13:12:42 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="bZeC6dvS";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046B410E213
 for <dri-devel@lists.freedesktop.org>; Thu, 26 Mar 2026 13:12:41 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id B84D2185B;
 Thu, 26 Mar 2026 14:11:20 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1774530681;
 bh=eaeDuhTwVtvOUYbWOU6Pi8XJP6K+PPcBl3PTwjkGBnM=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=bZeC6dvSpBf7WYfA0U2JNVKccRUMwd7qlToQgCu6IM7FIELNCdPiKSW1bB+xqTBUh
 ErQCXIV9+dh2CjgLzSnawF+ZZfUptDCjwlrUQDLLV5uRgEAIwYHvdSUlknx4vrUr3E
 ORAM3MdPOOA1A3QzXa91pBNTUInjmgqJ5IG9Vmno=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Thu, 26 Mar 2026 15:12:17 +0200
Subject: [PATCH 7/8] drm/bridge: tc358762: Update comment about the number
 of lanes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260326-tc358762-fixes-v1-7-65f479227af5@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=eaeDuhTwVtvOUYbWOU6Pi8XJP6K+PPcBl3PTwjkGBnM=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBpxTC/a5+FpltJDJIFQ/mz47j7GGXzPvheOeBjr
 BzZTwkNURWJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCacUwvwAKCRD6PaqMvJYe
 9Xg2D/9INuMguMaxsYOmY8c4Q1FHDT8g/2FxDHQjQm5SjhfT0e89sbsOlr3TvyBLwB5wVo3jtGZ
 oQIGDqxTKCM1NRTscNKHgLlV3OW+EktwRgQAjZ/l7DTWThh8iJvxIP0HqkhMxhFPc7X/cmXZKEU
 HS+94+19Fnw9KQVX1aCqosAxd5+KLlrXQaKtqO3lvIK82hH0nwZ3hM/NbQBzeq4Mxv/CTKZa8Wa
 dxheopBr1/avKAlCfDf9WLMdsy9/rV5ItgcsyA4eHEGE2EEh1NMfr0hGWOrX9TvDYG4ADJMR4e1
 GmsTRmySTb7aGUCBpMtnmD2915MfxjxFna5z176PpTzsGBijBhi2lR0JmMZW3FveVOaJu1ZPIfe
 EfjL5O5StwoW4s19U00RYKb6jrsZhsQxdWnqIHR0J2NoTHJuOIOZvKdfeKcoTEn8Qt2EJgHcqqv
 v5VFl+GLGCgGgtP+ngcWZyVWHUs9vNbO3jhho9uCgWGy+3UQkUr9Fx0jX/oUnQMYzgGlnZ9eNlG
 5Y+DtTyKV5j9ettI7eB7///L7Zi85fHpU8T+gXnmg/48/MEbrvYsLqzjBZIiEq01ELkLsYt3pHt
 z/23VxOsULSPG0Lbc/jMLcCm68vuonx/JzqdFmK6w8Yf4HjFfIfVj7tiB5GUnTtzJepfxzned4f
 3+X/5Hzll/P/MIg==
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

Update comment about the number of lanes.

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
 drivers/gpu/drm/bridge/tc358762.c | 9 ++++++++-
 1 file changed, 8 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/bridge/tc358762.c b/drivers/gpu/drm/bridge/tc358762.c
index cc1c5ff42cbd..9fb921b3fa0d 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -305,7 +305,14 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
 	ctx->dev = dev;
 	ctx->pre_enabled = false;
 
-	/* TODO: Find out how to get dual-lane mode working */
+	/*
+	 * When using DSI clk for pixel clock (only mode supported in the driver),
+	 * the pclk is derived directly from the DSI byteclk via simple divider,
+	 * which is either 2 or 3.
+	 * The required divider can be calculated with bitspp / 8 / nlanes. Thus,
+	 * for RGB888, only nlanes = 1 works as nlanes = 2 would require divider
+	 * of 1.5.
+	 */
 	dsi->lanes = 1;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_SYNC_PULSE |

-- 
2.43.0

