Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6DB25C43458
	for <dri-devel@archiver.kernel.org>; Wed,  1 Jul 2026 12:11:17 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C8EFA10ED6D;
	Wed,  1 Jul 2026 12:11:16 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=suse.de header.i=@suse.de header.b="sPs8m+6s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5gIvnfEY";
	dkim=pass (1024-bit key) header.d=suse.de header.i=@suse.de header.b="sPs8m+6s";
	dkim=permerror (0-bit key) header.d=suse.de header.i=@suse.de header.b="5gIvnfEY";
	dkim-atps=neutral
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.223.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8DEF610ED6D
 for <dri-devel@lists.freedesktop.org>; Wed,  1 Jul 2026 12:11:15 +0000 (UTC)
Received: from imap1.dmz-prg2.suse.org (unknown [10.150.64.97])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by smtp-out2.suse.de (Postfix) with ESMTPS id 2E7F97602D;
 Wed,  1 Jul 2026 12:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782907863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1sCjAIYicOWDPdP0q0DgGX3p3HEJRlW7OQTdhtqAoA=;
 b=sPs8m+6sfZBZygvNi9mke92mHzOVGers/uucLvnO5oBJ3Lej+aQpbqyMFpicdKUUiwX2D7
 dLh2mq9Q5ShU+COzlRDgTVTKZ2ZD/DRgoZU6dt4WnA1raxcAXG48XEHGb82tG2lsKInC46
 3evrOk2iqDLejC4ooVNVI9UKlspvyl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782907863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1sCjAIYicOWDPdP0q0DgGX3p3HEJRlW7OQTdhtqAoA=;
 b=5gIvnfEYN9mlsBgVwf2Gvw2UaBL2Ke06LP68BDMaidY1yPPWPEPTFdRI290Gv1c5in4RkU
 ntyBb42+QxfiU8BQ==
Authentication-Results: smtp-out2.suse.de;
	none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.de; s=susede2_rsa;
 t=1782907863; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1sCjAIYicOWDPdP0q0DgGX3p3HEJRlW7OQTdhtqAoA=;
 b=sPs8m+6sfZBZygvNi9mke92mHzOVGers/uucLvnO5oBJ3Lej+aQpbqyMFpicdKUUiwX2D7
 dLh2mq9Q5ShU+COzlRDgTVTKZ2ZD/DRgoZU6dt4WnA1raxcAXG48XEHGb82tG2lsKInC46
 3evrOk2iqDLejC4ooVNVI9UKlspvyl0=
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=suse.de;
 s=susede2_ed25519; t=1782907863;
 h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
 mime-version:mime-version:
 content-transfer-encoding:content-transfer-encoding:
 in-reply-to:in-reply-to:references:references;
 bh=z1sCjAIYicOWDPdP0q0DgGX3p3HEJRlW7OQTdhtqAoA=;
 b=5gIvnfEYN9mlsBgVwf2Gvw2UaBL2Ke06LP68BDMaidY1yPPWPEPTFdRI290Gv1c5in4RkU
 ntyBb42+QxfiU8BQ==
Received: from imap1.dmz-prg2.suse.org (localhost [127.0.0.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
 (No client certificate requested)
 by imap1.dmz-prg2.suse.org (Postfix) with ESMTPS id ADEB0779AC;
 Wed,  1 Jul 2026 12:11:02 +0000 (UTC)
Received: from dovecot-director2.suse.de ([2a07:de40:b281:106:10:150:64:167])
 by imap1.dmz-prg2.suse.org with ESMTPSA id KOs2KdYDRWozOQAAD6G6ig
 (envelope-from <tzimmermann@suse.de>); Wed, 01 Jul 2026 12:11:02 +0000
From: Thomas Zimmermann <tzimmermann@suse.de>
To: treding@nvidia.com, javierm@redhat.com, neil.armstrong@linaro.org,
 jesszhan0024@gmail.com, dianders@chromium.org, megi@xff.cz,
 igor@reznichenko.net, mwalle@kernel.org,
 dario.binacchi@amarulasolutions.com, jagan@edgeble.ai,
 laurent.pinchart@ideasonboard.com, lujianhua000@gmail.com, agx@sigxcpu.org,
 kernel@puri.sm, mripard@kernel.org, maarten.lankhorst@linux.intel.com,
 airlied@gmail.com, simona@ffwll.ch
Cc: dri-devel@lists.freedesktop.org,
	sashiko-reviews@lists.linux.dev
Subject: [PATCH v4 3/3] drm/panel: Use drm_of_get_panel_orientation()
Date: Wed,  1 Jul 2026 14:03:20 +0200
Message-ID: <20260701121055.192475-4-tzimmermann@suse.de>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260701121055.192475-1-tzimmermann@suse.de>
References: <20260701121055.192475-1-tzimmermann@suse.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spamd-Result: default: False [-2.80 / 50.00]; BAYES_HAM(-3.00)[100.00%];
 MID_CONTAINS_FROM(1.00)[]; NEURAL_HAM_LONG(-1.00)[-1.000];
 R_MISSING_CHARSET(0.50)[]; NEURAL_HAM_SHORT(-0.20)[-0.998];
 MIME_GOOD(-0.10)[text/plain]; TO_MATCH_ENVRCPT_ALL(0.00)[];
 RCVD_VIA_SMTP_AUTH(0.00)[];
 FUZZY_RATELIMITED(0.00)[rspamd.com]; ARC_NA(0.00)[];
 MIME_TRACE(0.00)[0:+]; FROM_HAS_DN(0.00)[]; TO_DN_NONE(0.00)[];
 FREEMAIL_TO(0.00)[nvidia.com,redhat.com,linaro.org,gmail.com,chromium.org,xff.cz,reznichenko.net,kernel.org,amarulasolutions.com,edgeble.ai,ideasonboard.com,sigxcpu.org,puri.sm,linux.intel.com,ffwll.ch];
 RCVD_TLS_ALL(0.00)[]; RCVD_COUNT_TWO(0.00)[2];
 FROM_EQ_ENVFROM(0.00)[];
 DBL_BLOCKED_OPENRESOLVER(0.00)[suse.de:mid,nvidia.com:email,imap1.dmz-prg2.suse.org:helo];
 RCPT_COUNT_TWELVE(0.00)[20];
 DKIM_SIGNED(0.00)[suse.de:s=susede2_rsa,suse.de:s=susede2_ed25519];
 FREEMAIL_ENVRCPT(0.00)[gmail.com]
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

From: Thierry Reding <treding@nvidia.com>

The old of_drm_get_panel_orientation() function was replaced by the
drm_of_get_panel_orientation() in the core DRM OF helpers. Replace all
uses of the old helper and remove it.

Changes in v4:
- also convert anbernic, chipone and ili9488 panels
Changes in v2:
- include drm_of.h in all drivers to make sure the new symbol is defined

Signed-off-by: Thierry Reding <treding@nvidia.com>
---
 drivers/gpu/drm/drm_panel.c                   | 20 -------------------
 drivers/gpu/drm/panel/panel-anbernic-td4310.c |  3 ++-
 .../drm/panel/panel-boe-th101mb31ig002-28a.c  |  3 ++-
 .../gpu/drm/panel/panel-boe-tv101wum-nl6.c    |  3 ++-
 .../gpu/drm/panel/panel-chipone-icna35xx.c    |  3 ++-
 .../gpu/drm/panel/panel-chipwealth-ch13726a.c |  3 ++-
 drivers/gpu/drm/panel/panel-edp.c             |  3 ++-
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  |  3 ++-
 .../gpu/drm/panel/panel-focaltech-ota7290b.c  |  3 ++-
 drivers/gpu/drm/panel/panel-himax-hx83102.c   |  3 ++-
 drivers/gpu/drm/panel/panel-himax-hx8394.c    |  3 ++-
 drivers/gpu/drm/panel/panel-ilitek-ili9488.c  |  3 ++-
 .../gpu/drm/panel/panel-ilitek-ili9806e-dsi.c |  3 ++-
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c |  3 ++-
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c |  3 ++-
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  |  2 +-
 drivers/gpu/drm/panel/panel-lvds.c            |  2 +-
 drivers/gpu/drm/panel/panel-novatek-nt36523.c |  3 ++-
 drivers/gpu/drm/panel/panel-simple.c          |  2 +-
 drivers/gpu/drm/panel/panel-sitronix-st7701.c |  3 ++-
 drivers/gpu/drm/panel/panel-sitronix-st7703.c |  3 ++-
 .../gpu/drm/panel/panel-sitronix-st7789v.c    |  3 ++-
 include/drm/drm_panel.h                       |  8 --------
 23 files changed, 39 insertions(+), 49 deletions(-)

diff --git a/drivers/gpu/drm/drm_panel.c b/drivers/gpu/drm/drm_panel.c
index eddd13a34c03..d7c6f4824b2d 100644
--- a/drivers/gpu/drm/drm_panel.c
+++ b/drivers/gpu/drm/drm_panel.c
@@ -492,26 +492,6 @@ struct drm_panel *of_drm_find_panel(const struct device_node *np)
 	return ERR_PTR(-EPROBE_DEFER);
 }
 EXPORT_SYMBOL(of_drm_find_panel);
-
-/**
- * of_drm_get_panel_orientation - look up the orientation of the panel through
- * the "rotation" binding from a device tree node
- * @np: device tree node of the panel
- * @orientation: orientation enum to be filled in
- *
- * Looks up the rotation of a panel in the device tree. The orientation of the
- * panel is expressed as a property name "rotation" in the device tree. The
- * rotation in the device tree is counter clockwise.
- *
- * Return: 0 when a valid rotation value (0, 90, 180, or 270) is read or the
- * rotation property doesn't exist. Return a negative error code on failure.
- */
-int of_drm_get_panel_orientation(const struct device_node *np,
-				 enum drm_panel_orientation *orientation)
-{
-	return drm_of_get_panel_orientation(np, orientation);
-}
-EXPORT_SYMBOL(of_drm_get_panel_orientation);
 #endif
 
 /* Find panel by fwnode. This should be identical to of_drm_find_panel(). */
diff --git a/drivers/gpu/drm/panel/panel-anbernic-td4310.c b/drivers/gpu/drm/panel/panel-anbernic-td4310.c
index 9a1b4525423c..3b6de1b2fbc6 100644
--- a/drivers/gpu/drm/panel/panel-anbernic-td4310.c
+++ b/drivers/gpu/drm/panel/panel-anbernic-td4310.c
@@ -12,6 +12,7 @@
 #include <linux/regulator/consumer.h>
 
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -165,7 +166,7 @@ static int panel_anbernic_td4310_probe(struct mipi_dsi_device *dsi)
 	if (!ctx->panel_info)
 		return -EINVAL;
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to get panel orientation\n");
 
diff --git a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
index 01b4458e55ad..a70a2e58f88c 100644
--- a/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
+++ b/drivers/gpu/drm/panel/panel-boe-th101mb31ig002-28a.c
@@ -15,6 +15,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -380,7 +381,7 @@ static int boe_th101mb31ig002_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Failed to get reset GPIO\n");
 
-	ret = of_drm_get_panel_orientation(dsi->dev.of_node,
+	ret = drm_of_get_panel_orientation(dsi->dev.of_node,
 					   &ctx->orientation);
 	if (ret)
 		return dev_err_probe(&dsi->dev, ret,
diff --git a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
index 658ce64c71eb..150dff3ab6c3 100644
--- a/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
+++ b/drivers/gpu/drm/panel/panel-boe-tv101wum-nl6.c
@@ -13,6 +13,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -1722,7 +1723,7 @@ static int boe_panel_add(struct boe_panel *boe)
 
 	boe->base.prepare_prev_first = true;
 
-	err = of_drm_get_panel_orientation(dev->of_node, &boe->orientation);
+	err = drm_of_get_panel_orientation(dev->of_node, &boe->orientation);
 	if (err < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
index 86d096455caa..2cc16494a4ce 100644
--- a/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
+++ b/drivers/gpu/drm/panel/panel-chipone-icna35xx.c
@@ -21,6 +21,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -374,7 +375,7 @@ static int icna35xx_probe(struct mipi_dsi_device *dsi)
 	pinfo->dsi = dsi;
 	mipi_dsi_set_drvdata(dsi, pinfo);
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &pinfo->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &pinfo->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
index be76bc825c3f..562dc573528d 100644
--- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
+++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
@@ -13,6 +13,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -268,7 +269,7 @@ static int ch13726a_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset-gpios\n");
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 27e40534e18b..74d29619a7f4 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -40,6 +40,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_device.h>
 #include <drm/drm_edid.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 /**
@@ -865,7 +866,7 @@ static int panel_edp_probe(struct device *dev, const struct panel_desc *desc,
 		return dev_err_probe(dev, PTR_ERR(panel->enable_gpio),
 				     "failed to request GPIO\n");
 
-	err = of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	err = drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
 	if (err) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index 1f177834d629..d23002b5a2d7 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -21,6 +21,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 /* Manufacturer specific Commands send via DSI */
@@ -233,7 +234,7 @@ static int kd35t133_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
index ed02a8daf96f..bbc870b8fda8 100644
--- a/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
+++ b/drivers/gpu/drm/panel/panel-focaltech-ota7290b.c
@@ -17,6 +17,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -181,7 +182,7 @@ static int ota7290b_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->vdd),
 					"Couldn't get our VDD supply\n");
 
-	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret) {
 		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
 			dsi->dev.of_node, ret);
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index d7e5664a5838..6a0851ccf9bb 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -17,6 +17,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -1264,7 +1265,7 @@ static int hx83102_panel_add(struct hx83102 *ctx)
 
 	ctx->base.prepare_prev_first = true;
 
-	err = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	err = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (err < 0)
 		return dev_err_probe(dev, err, "failed to get orientation\n");
 
diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index bf80354567df..b57ccce38cf8 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -22,6 +22,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #define DRV_NAME "panel-himax-hx8394"
@@ -992,7 +993,7 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->reset_gpio),
 				     "Failed to get reset gpio\n");
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9488.c b/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
index 7302766034fc..6ab8ae72abbf 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9488.c
@@ -13,6 +13,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -237,7 +238,7 @@ static int ili9488_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get regulators\n");
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &ili->orientation);
 	if (ret)
 		return dev_err_probe(dev, ret, "failed to get orientation\n");
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
index ecdbed8d4a3a..47b79fac1562 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -10,6 +10,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 #include <drm/drm_probe_helper.h>
 
@@ -132,7 +133,7 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = ctx->desc->format;
 	dsi->lanes = ctx->desc->lanes;
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &ctx->orientation);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get orientation\n");
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 0652cdb57d11..3abdd0870e83 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -16,6 +16,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -2571,7 +2572,7 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(ctx->reset),
 				     "Couldn't get our reset GPIO\n");
 
-	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret) {
 		dev_err(&dsi->dev, "%pOF: failed to get orientation: %d\n",
 			dsi->dev.of_node, ret);
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 5f4e0d82ee67..6d07fe901357 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -13,6 +13,7 @@
 #include <drm/drm_connector.h>
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <video/mipi_display.h>
@@ -795,7 +796,7 @@ static int ili9882t_add(struct ili9882t *ili)
 
 	gpiod_set_value_cansleep(ili->enable_gpio, 0);
 
-	err = of_drm_get_panel_orientation(dev->of_node, &ili->orientation);
+	err = drm_of_get_panel_orientation(dev->of_node, &ili->orientation);
 	if (err < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return err;
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index f6b04de1182e..67ef9e0fea03 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -2992,7 +2992,7 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(&dsi->dev, PTR_ERR(jadard->vccio),
 				"failed to get vccio regulator\n");
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &jadard->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &jadard->orientation);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "failed to get orientation\n");
 
diff --git a/drivers/gpu/drm/panel/panel-lvds.c b/drivers/gpu/drm/panel/panel-lvds.c
index 46b07f38559f..37f7498449ec 100644
--- a/drivers/gpu/drm/panel/panel-lvds.c
+++ b/drivers/gpu/drm/panel/panel-lvds.c
@@ -126,7 +126,7 @@ static int panel_lvds_parse_dt(struct panel_lvds *lvds)
 	struct device_node *np = lvds->dev->of_node;
 	int ret;
 
-	ret = of_drm_get_panel_orientation(np, &lvds->orientation);
+	ret = drm_of_get_panel_orientation(np, &lvds->orientation);
 	if (ret < 0) {
 		dev_err(lvds->dev, "%pOF: failed to get orientation %d\n", np, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36523.c b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
index 226d91daf8c7..34b9123d3fd7 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36523.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36523.c
@@ -19,6 +19,7 @@
 #include <drm/drm_crtc.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #define DSI_NUM_MIN 1
@@ -1206,7 +1207,7 @@ static int nt36523_probe(struct mipi_dsi_device *dsi)
 	pinfo->dsi[0] = dsi;
 	mipi_dsi_set_drvdata(dsi, pinfo);
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &pinfo->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &pinfo->orientation);
 	if (ret < 0) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, ret);
 		return ret;
diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index c09bf3db5e78..5c169fdf265c 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -693,7 +693,7 @@ static struct panel_simple *panel_simple_probe(struct device *dev)
 		return dev_err_cast_probe(dev, panel->enable_gpio,
 					  "failed to request GPIO\n");
 
-	err = of_drm_get_panel_orientation(dev->of_node, &panel->orientation);
+	err = drm_of_get_panel_orientation(dev->of_node, &panel->orientation);
 	if (err) {
 		dev_err(dev, "%pOF: failed to get orientation %d\n", dev->of_node, err);
 		return ERR_PTR(err);
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index 2f79ec4a2063..f16e0de1ea60 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -7,6 +7,7 @@
 #include <drm/drm_mipi_dbi.h>
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #include <linux/bitfield.h>
@@ -1296,7 +1297,7 @@ static int st7701_probe(struct device *dev, int connector_type)
 		return PTR_ERR(st7701->reset);
 	}
 
-	ret = of_drm_get_panel_orientation(dev->of_node, &st7701->orientation);
+	ret = drm_of_get_panel_orientation(dev->of_node, &st7701->orientation);
 	if (ret < 0)
 		return dev_err_probe(dev, ret, "Failed to get orientation\n");
 
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 6c348fe28955..9916036630b7 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -21,6 +21,7 @@
 
 #include <drm/drm_mipi_dsi.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #define DRV_NAME "panel-sitronix-st7703"
@@ -874,7 +875,7 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->iovcc),
 				     "Failed to request iovcc regulator\n");
 
-	ret = of_drm_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(dsi->dev.of_node, &ctx->orientation);
 	if (ret < 0)
 		return dev_err_probe(&dsi->dev, ret, "Failed to get orientation\n");
 
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
index d5f821d6b23c..da6ed31d151e 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7789v.c
@@ -14,6 +14,7 @@
 
 #include <drm/drm_device.h>
 #include <drm/drm_modes.h>
+#include <drm/drm_of.h>
 #include <drm/drm_panel.h>
 
 #define ST7789V_RAMCTRL_CMD		0xb0
@@ -646,7 +647,7 @@ static int st7789v_probe(struct spi_device *spi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	ret = of_drm_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
+	ret = drm_of_get_panel_orientation(spi->dev.of_node, &ctx->orientation);
 	if (ret)
 		return dev_err_probe(&spi->dev, ret, "Failed to get orientation\n");
 
diff --git a/include/drm/drm_panel.h b/include/drm/drm_panel.h
index 86b3f9c65c92..b87323443f49 100644
--- a/include/drm/drm_panel.h
+++ b/include/drm/drm_panel.h
@@ -337,19 +337,11 @@ int drm_panel_get_modes(struct drm_panel *panel, struct drm_connector *connector
 
 #if defined(CONFIG_OF) && defined(CONFIG_DRM_PANEL)
 struct drm_panel *of_drm_find_panel(const struct device_node *np);
-int of_drm_get_panel_orientation(const struct device_node *np,
-				 enum drm_panel_orientation *orientation);
 #else
 static inline struct drm_panel *of_drm_find_panel(const struct device_node *np)
 {
 	return ERR_PTR(-ENODEV);
 }
-
-static inline int of_drm_get_panel_orientation(const struct device_node *np,
-					       enum drm_panel_orientation *orientation)
-{
-	return -ENODEV;
-}
 #endif
 
 #if defined(CONFIG_DRM_PANEL)
-- 
2.54.0

