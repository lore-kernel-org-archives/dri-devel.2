Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A48CBCD3423
	for <dri-devel@archiver.kernel.org>; Mon,  4 May 2026 07:58:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0987010E3CE;
	Mon,  4 May 2026 07:58:31 +0000 (UTC)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4A7E10E3CE
 for <dri-devel@lists.freedesktop.org>; Mon,  4 May 2026 07:58:29 +0000 (UTC)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
 by tor.source.kernel.org (Postfix) with ESMTP id 1BF2E600C3;
 Mon,  4 May 2026 07:58:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9DCADC2BCB8;
 Mon,  4 May 2026 07:58:26 +0000 (UTC)
From: Geert Uytterhoeven <geert+renesas@glider.be>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>,
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>,
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>
Cc: dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
 Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/rcar-du: Drop superfluous spaces after assignments
Date: Mon,  4 May 2026 09:58:23 +0200
Message-ID: <80e30578b6dd86664112320616c460c48dbd79f6.1777881435.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.43.0
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

There is no need for a double space after an assignment.

Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
This started with two instances, and got copied each time support for
a new SoC was added...
---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c | 20 +++++++++----------
 1 file changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
index 031d07f4508e9762..d9926c24984eb3db 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_drv.c
@@ -137,7 +137,7 @@ static const struct rcar_du_device_info rcar_du_r8a774a1_info = {
 	},
 	.num_lvds = 1,
 	.num_rpf = 5,
-	.dpll_mask =  BIT(1),
+	.dpll_mask = BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a774b1_info = {
@@ -168,7 +168,7 @@ static const struct rcar_du_device_info rcar_du_r8a774b1_info = {
 	},
 	.num_lvds = 1,
 	.num_rpf = 5,
-	.dpll_mask =  BIT(1),
+	.dpll_mask = BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a774c0_info = {
@@ -196,7 +196,7 @@ static const struct rcar_du_device_info rcar_du_r8a774c0_info = {
 	},
 	.num_lvds = 2,
 	.num_rpf = 4,
-	.lvds_clk_mask =  BIT(1) | BIT(0),
+	.lvds_clk_mask = BIT(1) | BIT(0),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a774e1_info = {
@@ -227,7 +227,7 @@ static const struct rcar_du_device_info rcar_du_r8a774e1_info = {
 	},
 	.num_lvds = 1,
 	.num_rpf = 5,
-	.dpll_mask =  BIT(1),
+	.dpll_mask = BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a7779_info = {
@@ -385,7 +385,7 @@ static const struct rcar_du_device_info rcar_du_r8a7795_info = {
 	},
 	.num_lvds = 1,
 	.num_rpf = 5,
-	.dpll_mask =  BIT(2) | BIT(1),
+	.dpll_mask = BIT(2) | BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a7796_info = {
@@ -416,7 +416,7 @@ static const struct rcar_du_device_info rcar_du_r8a7796_info = {
 	},
 	.num_lvds = 1,
 	.num_rpf = 5,
-	.dpll_mask =  BIT(1),
+	.dpll_mask = BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a77965_info = {
@@ -447,7 +447,7 @@ static const struct rcar_du_device_info rcar_du_r8a77965_info = {
 	},
 	.num_lvds = 1,
 	.num_rpf = 5,
-	.dpll_mask =  BIT(1),
+	.dpll_mask = BIT(1),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a77970_info = {
@@ -502,7 +502,7 @@ static const struct rcar_du_device_info rcar_du_r8a7799x_info = {
 	},
 	.num_lvds = 2,
 	.num_rpf = 5,
-	.lvds_clk_mask =  BIT(1) | BIT(0),
+	.lvds_clk_mask = BIT(1) | BIT(0),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a779a0_info = {
@@ -523,7 +523,7 @@ static const struct rcar_du_device_info rcar_du_r8a779a0_info = {
 		},
 	},
 	.num_rpf = 5,
-	.dsi_clk_mask =  BIT(1) | BIT(0),
+	.dsi_clk_mask = BIT(1) | BIT(0),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a779g0_info = {
@@ -544,7 +544,7 @@ static const struct rcar_du_device_info rcar_du_r8a779g0_info = {
 		},
 	},
 	.num_rpf = 5,
-	.dsi_clk_mask =  BIT(1) | BIT(0),
+	.dsi_clk_mask = BIT(1) | BIT(0),
 };
 
 static const struct rcar_du_device_info rcar_du_r8a779h0_info = {
-- 
2.43.0

