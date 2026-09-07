Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 72250C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 11:28:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CA26F10E7A7;
	Mon,  7 Sep 2026 11:28:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="L9AoVcDj";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2BD2910E4AB
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 11:28:31 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id BA118153F;
 Mon,  7 Sep 2026 13:26:54 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788780415;
 bh=ghKBuVKjv8XfNhFOzxwGtXKqZd5n7UMCAy87A0RUjWk=;
 h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
 b=L9AoVcDjkm+guO+3YqLswhaTsFtQ6gR/vnG/9DuWIwFoxorA2nuNQkOzS25V1h4kP
 0IIxPBm7HCV9ne4ic6vnHelsMDhk1Zkq5OO5WuWO06oq64ghSqc43F/lXviGXejvst
 WTkg1FnOpRCsAG7hQuRhWZrXKCBYD4f2XpoNxc+4=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Date: Mon, 07 Sep 2026 14:28:02 +0300
Subject: [PATCH v4 07/13] drm/bridge: tc358762: Update comment about the
 number of lanes
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260907-tc358762-fixes-v4-7-e3fc3ab5cd83@ideasonboard.com>
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
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1121;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ghKBuVKjv8XfNhFOzxwGtXKqZd5n7UMCAy87A0RUjWk=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnp/Trwjm9PJw2in8vzivJeTm6tFMRM4bm0q0I
 LQ9vNvXUfeJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6f0wAKCRD6PaqMvJYe
 9WXZEACiS69bcpXIRCNv3oebq2YokwcoR+16a5zuWgy0TnkLCY+JTb77tZnO50uHV6rk3EKvs2Y
 QMD49zdiJUJlmzTm7RHX60yD2FcxRG7/QskX+ot4UAXCE9ONxoJ1TmC+TpCz0OOQAzYGXdYlcX8
 pt6mLOTY+IPcburEgkCSHcz3/3E0Xd+BTnJf4srEQcjt9NgTeVcVP+xHf0MT5ODYXSdmIRaBWhK
 6Qspmu1AYT37kNT+dfwTyYO6+s4PrvZC3JDC1LhpbZoBDKSiDh9Jng/rVaxnxMc2eK4VYI+t3Q2
 SYIWs0LzGcjCLe5uiXajT5JOJW80aayecFgvJZ+9RWB0Uf3HQlaNNAudz6e8JHoSw6707QvLAWP
 1xJHsFCecA+5ak6uaYvhsIRiUCPjmXuiOIj+zesSyZ5wMTiQd3zdvxXcsxm4SGPwEh7aDhVQoJv
 kFUlURWTc3xKDtqPKPpRuoV3Ctu/FmIcrLDv//WunkI+C+1PRH4sEe78z+50vryJmHdUrOdqIWm
 8p/6xDff+z9DMZkGDd1By9MFwKEznnxL8l/iCWeaAgdisJ3YLHlbDL/EQUtzFDvDIuQb5SCZXFY
 2E5e3+ijcsNQkX/gSC4v7uwVvIYJTIka4S3QhJcg9B2HnLJLl+YKVWRfB/B2waQSr7jJJzVk/sV
 e75wEhQSSN/rQ+A==
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
index 7654d4039a9d..34f2bfd9977c 100644
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

