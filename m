Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7A7A9CD4F3E
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 13:10:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A9C8A10EE5D;
	Wed, 13 May 2026 13:10:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="MYL7M+Av";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B80E710EE58
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 13:10:48 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 8966C266F;
 Wed, 13 May 2026 15:10:38 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778677839;
 bh=JR1XaCynAqkLEsI0fyomn5txwykOGGzcMsQKm/y2zys=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=MYL7M+AvEt5RMit16C0Ua3VY5YSoTluk+6GDXFAAq90T9wW2TrYWrK2o2YRPUoGEm
 4O+maRrbxy+w4QWMtr9hv6zbiJza0Fabk6iyUFl3bgQrJU0TJ3QdD2dLitlMko8/Vd
 9uYBadzZntDlVQ2HbUh/5WykzL2kqX+7DeZ7t30g=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Wed, 13 May 2026 16:10:16 +0300
Subject: [PATCH v3 07/13] drm/bridge: tc358762: Update comment about the
 number of lanes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260513-tc358762-fixes-v3-7-6698b55008b9@ideasonboard.com>
References: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
In-Reply-To: <20260513-tc358762-fixes-v3-0-6698b55008b9@ideasonboard.com>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=JR1XaCynAqkLEsI0fyomn5txwykOGGzcMsQKm/y2zys=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBHhMEz+LoP63lR/6OSzHGt0ddSh6P874/4XGF
 RwELM9trFKJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagR4TAAKCRD6PaqMvJYe
 9epsD/439EkhD9+3YZGy9F2AL83IXY4QQ1paEqec2sGfhftvvQvl62N2PRoaWcHTuw6W5WMPmDW
 k5KMFszGFmthmMNGA+wGm0lmpcLMyofhJk1K256MlxmGy8DQRbhWpgLNX+wsLi6JRrspgjJV7ny
 1ZXH8srTogNVLpcrVoVNjNF/IVRP83bwBFQffJe6NsLSxGPKvM38DpxV/XDGhGU7kkrNzm+eSxg
 odW/FQJTWxmB/hf94IeFvgIozj8jP/mfW+cT20oJqgq+iDqFyeXQt3fWomwhtcX7eX+p+Dm7KJ+
 wLsW9Y/cWOaOoCRhImXeryfRml0WyhRlpLuHKT2NWM2rIuwZHL1rxUO8QYF27ZVx66G79celJOU
 tpSrVVnjbRj0QZJUS/AAP68RXd0NwWy6RZGovSzdmMOXe3TTZ+X2loJPGhzd32iRiFgIl0SHTW6
 8wYEHXSeBHx4Jjmrt8OxVV+m5tcZppwk2R/WmJtfPEnBJleMfMzuoJ263FN9KwOM6agtsKvBEj1
 M4aMUXae09+3ts9HLJwjFwilU6YaTtVkJb+7WHuzTlKx3oxeB5jeRacfR2MNHOj34tCQZ8+2swm
 FL0NkGOtpK/DWzC1qYrR6r3AILkeqeuB23qVhBd+VssTMpkQt9dZDSqNxWx1OGNL8chX0gDNvqs
 B3R7RRMQ/3zhrWg==
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
index 7840ab3454f6..c5734c4df440 100644
--- a/drivers/gpu/drm/bridge/tc358762.c
+++ b/drivers/gpu/drm/bridge/tc358762.c
@@ -306,7 +306,14 @@ static int tc358762_probe(struct mipi_dsi_device *dsi)
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

