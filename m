Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7FE5FF8D74B
	for <dri-devel@archiver.kernel.org>; Thu, 16 Apr 2026 14:00:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DFDA410E8BF;
	Thu, 16 Apr 2026 14:00:11 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="Kwryl1gl";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 60CC010E8CA
 for <dri-devel@lists.freedesktop.org>; Thu, 16 Apr 2026 14:00:10 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id AEC8F1A32FF;
 Thu, 16 Apr 2026 14:00:08 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 8452260495;
 Thu, 16 Apr 2026 14:00:08 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 09551104608A1; 
 Thu, 16 Apr 2026 16:00:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1776348007; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding:in-reply-to:references;
 bh=Qtj7KJgMQ3pCG2NniTimE9jRyWQEw4bmxyikGHd7CTo=;
 b=Kwryl1glF6oFpmKVZK02dQ5mYl0qiNc9pzcKe5wYi4g6j5KPbLzYkmIG029SqWDsBJBNRS
 8bSJcQiYN7TuZjC4mQqYI2OwE/UQiEcCail6kEgVgM+qifrxoF4U6z5Ly4Z/6eNGa1FeNi
 aOY92O3Oz9yY1sUsKASYygGHMtsfe0VjbXl246jS8OSabxCZd75HXS3YnB9wVq1PVmt0g9
 2Ai0KMGf/I/UGMGxmRyIXgSc+bUdOPUyN/xU5PADAKSiMA87D9NpG1dcR922gC2Ye4Su3w
 TKNmwsQOH4/JwMzGBu7KlNYJj0uWwpmwSgdEDiKgtX7OoxMrZM7x/FrmVVNP7A==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Date: Thu, 16 Apr 2026 15:59:55 +0200
Subject: [PATCH v3] drm/bridge: ti-sn65dsi83: add test pattern generation
 support
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-1-143886aebc6b@bootlin.com>
References: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
In-Reply-To: <20260416-ti-sn65dsi83-dual-lvds-fixes-and-test-pattern-v3-0-143886aebc6b@bootlin.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Frieder Schrempf <frieder.schrempf@kontron.de>, Marek Vasut <marex@denx.de>, 
 Linus Walleij <linusw@kernel.org>
Cc: Louis Chauvet <louis.chauvet@bootlin.com>, 
 Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.2
X-Last-TLS-Session-Version: TLSv1.3
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

Generation of a test pattern output is a useful tool for panel bringup and
debugging, and very simple to support with this chip.

The value of REG_VID_CHA_ACTIVE_LINE_LENGTH_LOW needs to be divided by two
for the test pattern to work in dual LVDS mode. While not clearly stated in
the datasheet, this is needed according to the DSI Tuner [0] output. And
some dual-LVDS panels refuse to show any picture without this division by
two.

[0] https://www.ti.com/tool/DSI-TUNER

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>

---

Changes in v3:
 - fixed incorrect halving of hdisplay in single-link mode

Changes in v2:
 - added local variable to avoid potential race condition leading to
   inconsistent settings
---
 drivers/gpu/drm/bridge/ti-sn65dsi83.c | 14 ++++++++++++--
 1 file changed, 12 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/bridge/ti-sn65dsi83.c b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
index 17a885244e1e..2b6f6a54edb7 100644
--- a/drivers/gpu/drm/bridge/ti-sn65dsi83.c
+++ b/drivers/gpu/drm/bridge/ti-sn65dsi83.c
@@ -114,6 +114,7 @@
 #define REG_VID_CHA_HORIZONTAL_FRONT_PORCH	0x38
 #define REG_VID_CHA_VERTICAL_FRONT_PORCH	0x3a
 #define REG_VID_CHA_TEST_PATTERN		0x3c
+#define  REG_VID_CHA_TEST_PATTERN_EN		BIT(4)
 /* IRQ registers */
 #define REG_IRQ_GLOBAL				0xe0
 #define  REG_IRQ_GLOBAL_IRQ_EN			BIT(0)
@@ -134,6 +135,9 @@
 #define  REG_IRQ_STAT_CHA_SOT_BIT_ERR		BIT(2)
 #define  REG_IRQ_STAT_CHA_PLL_UNLOCK		BIT(0)
 
+static bool sn65dsi83_test_pattern;
+module_param_named(test_pattern, sn65dsi83_test_pattern, bool, 0644);
+
 enum sn65dsi83_channel {
 	CHANNEL_A,
 	CHANNEL_B
@@ -523,6 +527,7 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 	const struct drm_display_mode *mode;
 	struct drm_connector *connector;
 	struct drm_crtc *crtc;
+	bool test_pattern = sn65dsi83_test_pattern;
 	bool lvds_format_24bpp;
 	bool lvds_format_jeida;
 	unsigned int pval;
@@ -645,7 +650,11 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 			  REG_LVDS_LANE_CHB_LVDS_TERM : 0));
 	regmap_write(ctx->regmap, REG_LVDS_CM, 0x00);
 
-	le16val = cpu_to_le16(mode->hdisplay);
+	/*
+	 * Active line length needs to be halved for test pattern
+	 * generation in dual LVDS output.
+	 */
+	le16val = cpu_to_le16(mode->hdisplay / (test_pattern ? dual_factor : 1));
 	regmap_bulk_write(ctx->regmap, REG_VID_CHA_ACTIVE_LINE_LENGTH_LOW,
 			  &le16val, 2);
 	le16val = cpu_to_le16(mode->vdisplay);
@@ -668,7 +677,8 @@ static void sn65dsi83_atomic_pre_enable(struct drm_bridge *bridge,
 		     (mode->hsync_start - mode->hdisplay) / dual_factor);
 	regmap_write(ctx->regmap, REG_VID_CHA_VERTICAL_FRONT_PORCH,
 		     mode->vsync_start - mode->vdisplay);
-	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN, 0x00);
+	regmap_write(ctx->regmap, REG_VID_CHA_TEST_PATTERN,
+		     test_pattern ? REG_VID_CHA_TEST_PATTERN_EN : 0);
 
 	/* Enable PLL */
 	regmap_write(ctx->regmap, REG_RC_PLL_EN, REG_RC_PLL_EN_PLL_EN);

-- 
2.53.0

