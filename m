Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 13579C88E75
	for <dri-devel@archiver.kernel.org>; Tue, 15 Sep 2026 15:00:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F19F10FBEA;
	Tue, 15 Sep 2026 15:00:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W8MBHlan";
	dkim-atps=neutral
Received: from mail-wr2-f12.google.com (mail-wr2-f12.google.com
 [74.125.225.76])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5808310FBEA
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 15:00:05 +0000 (UTC)
Received: by mail-wr2-f12.google.com with SMTP id
 ffacd0b85a97d-485933b2522so2731659f8f.0
 for <dri-devel@lists.freedesktop.org>; Tue, 15 Sep 2026 08:00:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1789484404; x=1790089204; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=XB6ikU+gImLwLa5yXnRI1U7B1rVuYpGJ0FNt9R5cuBY=;
 b=W8MBHlan2imv56QLIYuwz9YP2XSkJRgcnkNaRKd5XfwF0vd2e7Uvh2Uzn/2UhAL+3n
 fTZ4EEXuVYpdXmuhx8pQdcE9dVPKpyIvOQjt+TEVj6xXqO3uato9/mh0Mtw0NQGj/ys0
 B0ytfDwNm63DjPloJQvDJZZFrh8JlS+cClhyn92B38a5RVjR8LcUts+pFQARm84f02j6
 /uvuVilRZUOJAoanfxho0pi9Vsz7DmzyP/z1eLba3zpuWjegYPN2kvPqEoyYoahzZggp
 /tLjyDD0eJs0696KKBWp6aLXxbfmQJeb8Rd8sVPIuE7sIPDCLC0rf7LCw94eZy9IXyiG
 k+Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1789484404; x=1790089204;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=XB6ikU+gImLwLa5yXnRI1U7B1rVuYpGJ0FNt9R5cuBY=;
 b=MNvphIIa4kpo8SzfdZB86P+N7WZTIvsc5Hl+lyrlcZtabn2GB84xJ9BiPfGyqLyqT7
 SMekjnC/P7+YUTNuLk1ptRrFf2gx/QIi8o6lFFtzRjEeQyZxYlHGBg4IS8g1r40Zgpv5
 FQHmDgXOax0GE6jw8oOgRqy8uyyL6VKn+SGAK2rjgRRqJpf4cD5x+xJNlrqCFsYGaSdk
 mN5M30bLglOLBcXsGhx8POahRVQMHi6lgBScJVM19TBD/jIva7aHC04jzBvmS/uMgVVs
 VFotsOwQSLP9tiRWPr1Xy47AYmrG5A8X9WlTm6oT8BkTrQzG5WIQYrgY1Iqm8D6x3AOF
 QhBg==
X-Forwarded-Encrypted: i=1;
 AKwUvBweCivCK+fGYNE6RsvQbQbq95G7AcLnDCIIB9KvLF2vEjTOqIOlILNQxHl9h5CsipEQNIkHuHQZxBY=@lists.freedesktop.org
X-Gm-Message-State: AFuF++l6ceWd0Dp3XBa22Ezzs176/R/LjwrtSn4ygwSoK9Y/399G24Dg
 5CF9NDokwmRUQ2qFIwvl/rFOnA6W7E0McxqyNcvmhCR7RzAVgxWyJEcJ
X-Gm-Gg: AYBFou2XzLkIOlZWUIf603E37cm7V4cv0fu9VMTtgVRGX2n9+dTbr9PlToiodMZUHvy
 2P3UlOIWgMFRpbWjRa+51/k1U7VjLSGD7llQVa8BmEBYHomOa3NV/z5YL4hmV99R5/aAjhnGT+L
 vS+LZVw45tyi0laTamGmqWhaWGvlyUJ85yhcC3YsDZKxP1jY9cD/xiA3No/yv5jQs4osCyv5W3m
 903tRlMQQopSLKhwbiDB2RIQYt3EpNnRvtrF2zImZmVHVTQmHGjQftyVwEare1IEAcU2ackGyCB
 YDiaYhE4Ehh4SM7t8wVP5UGSuRjjNQDHzW2aOElFJNvlGIaVHjlLxVeGMIqoBXn3qERWH/3S/6G
 hBYsmawpbihM03FA/PDTamZAZNyLKrNiF3kw9cevBddOAwkkjzxegh+Qy2t1mX7jFjaX/AVtqvp
 fdKNvdNNbI7xPeNC90psiwQkMq/F1mumpe+paj3ZMIig7T0NmWMQz+mjJxqKETz0PyLa6+e6ipZ
 mxEEn/hDD4KMdE4aIqQh5xjmZtB1nSQuQ==
X-Received: by 2002:a05:6000:4a17:b0:486:fba1:6f74 with SMTP id
 ffacd0b85a97d-48702aace76mr18477367f8f.3.1789484403176; 
 Tue, 15 Sep 2026 08:00:03 -0700 (PDT)
Received: from osama.. ([156.223.70.89]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48707e00133sm5081128f8f.11.2026.09.15.08.00.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 15 Sep 2026 08:00:02 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Joel Selvaraj <jo@jsfamily.in>,
 Icenowy Zheng <icenowy@aosc.io>, Jagan Teki <jagan@amarulasolutions.com>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 Casey Connolly <casey.connolly@linaro.org>,
 Michael Tretter <m.tretter@pengutronix.de>,
 =?UTF-8?q?Guido=20G=C3=BCnther?= <agx@sigxcpu.org>,
 Purism Kernel Team <kernel@puri.sm>, Ondrej Jirman <megi@xff.cz>,
 Sasha Finkelstein <k@chaosmail.tech>, Janne Grunau <j@jannau.net>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 asahi@lists.linux.dev
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v5 3/4] drm/panel: Use managed helpers in assorted panels
Date: Tue, 15 Sep 2026 16:59:30 +0200
Message-ID: <20260915145935.60397-4-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260915145935.60397-1-osama.abdelkader@gmail.com>
References: <20260915145935.60397-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach and panel add helpers in assorted
panel drivers and drop the corresponding manual detach and panel remove
calls from remove paths.

Suggested-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>
---
v5:
- panel-simple.c is now its own patch (4/4), given its wide reach across
  many boards. (Luca)
- dsi-cm: keep mipi_dsi_attach()/mipi_dsi_detach() manual instead of
  devm_mipi_dsi_attach(), since dsicm_remove() also tears down sysfs and
  an external backlight device; deferring the detach to devm would run
  it after that cleanup instead of before it, changing the teardown
  order. Same class of issue Luca pointed out for nt35510 and
  panel-simple.
v4:
- use devm_drm_panel_add instead of drm_panel_add.

 .../drm/panel/panel-asus-z00t-tm5p5-n35596.c  | 20 +++--------
 .../gpu/drm/panel/panel-chipwealth-ch13726a.c | 20 +++--------
 drivers/gpu/drm/panel/panel-dsi-cm.c          | 16 +++++----
 drivers/gpu/drm/panel/panel-ebbg-ft8719.c     | 20 +++--------
 drivers/gpu/drm/panel/panel-elida-kd35t133.c  | 20 +++--------
 .../gpu/drm/panel/panel-feixin-k101-im2ba02.c | 19 +++--------
 .../drm/panel/panel-feiyang-fy07024di26a30d.c | 19 +++--------
 drivers/gpu/drm/panel/panel-hydis-hv101hd1.c  | 24 +++-----------
 drivers/gpu/drm/panel/panel-innolux-p079zca.c | 33 +++----------------
 .../gpu/drm/panel/panel-jadard-jd9365da-h3.c  | 19 +++--------
 drivers/gpu/drm/panel/panel-khadas-ts050.c    | 23 +++----------
 .../drm/panel/panel-kingdisplay-kd097d04.c    | 30 ++---------------
 drivers/gpu/drm/panel/panel-lg-sw43408.c      | 22 ++++---------
 .../gpu/drm/panel/panel-lincolntech-lcd197.c  | 20 ++---------
 drivers/gpu/drm/panel/panel-lxd-m9189a.c      | 24 +++-----------
 .../gpu/drm/panel/panel-mantix-mlaf057we51.c  | 16 +++------
 .../gpu/drm/panel/panel-newvision-nv3051d.c   | 22 +++----------
 .../gpu/drm/panel/panel-orisetech-otm8009a.c  | 16 +++------
 .../drm/panel/panel-osd-osd101t2587-53ts.c    | 23 +++----------
 .../drm/panel/panel-panasonic-vvx10f034n00.c  | 31 ++---------------
 drivers/gpu/drm/panel/panel-ronbo-rb070d30.c  | 19 +++--------
 drivers/gpu/drm/panel/panel-sitronix-st7701.c | 13 +++-----
 drivers/gpu/drm/panel/panel-sitronix-st7703.c | 14 +++-----
 .../drm/panel/panel-startek-kd070fhfid015.c   | 24 +++-----------
 drivers/gpu/drm/panel/panel-summit.c          | 15 +++------
 .../gpu/drm/panel/panel-synaptics-r63353.c    | 25 ++------------
 drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c  | 19 +++--------
 .../gpu/drm/panel/panel-xinpeng-xpp055c272.c  | 20 +++--------
 28 files changed, 118 insertions(+), 468 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
index db006576d704..0f98ea096f5f 100644
--- a/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
+++ b/drivers/gpu/drm/panel/panel-asus-z00t-tm5p5-n35596.c
@@ -262,9 +262,11 @@ static int tm5p5_nt35596_probe(struct mipi_dsi_device *dsi)
 		return ret;
 	}
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
 		return ret;
@@ -273,19 +275,6 @@ static int tm5p5_nt35596_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void tm5p5_nt35596_remove(struct mipi_dsi_device *dsi)
-{
-	struct tm5p5_nt35596 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev,
-			"Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id tm5p5_nt35596_of_match[] = {
 	{ .compatible = "asus,z00t-tm5p5-n35596" },
 	{ /* sentinel */ }
@@ -294,7 +283,6 @@ MODULE_DEVICE_TABLE(of, tm5p5_nt35596_of_match);
 
 static struct mipi_dsi_driver tm5p5_nt35596_driver = {
 	.probe = tm5p5_nt35596_probe,
-	.remove = tm5p5_nt35596_remove,
 	.driver = {
 		.name = "panel-tm5p5-nt35596",
 		.of_match_table = tm5p5_nt35596_of_match,
diff --git a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
index 562dc573528d..e72636919d5a 100644
--- a/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
+++ b/drivers/gpu/drm/panel/panel-chipwealth-ch13726a.c
@@ -290,30 +290,19 @@ static int ch13726a_probe(struct mipi_dsi_device *dsi)
 		return dev_err_probe(dev, PTR_ERR(ctx->panel.backlight),
 				     "Failed to create backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void ch13726a_remove(struct mipi_dsi_device *dsi)
-{
-	struct ch13726a_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id ch13726a_of_match[] = {
 	{ .compatible = "ayntec,thor-panel-bottom", .data = &thor_bottom_desc },
 	{ /* sentinel */ }
@@ -322,7 +311,6 @@ MODULE_DEVICE_TABLE(of, ch13726a_of_match);
 
 static struct mipi_dsi_driver ch13726a_driver = {
 	.probe = ch13726a_probe,
-	.remove = ch13726a_remove,
 	.driver = {
 		.name = "panel-ch13726a-amoled",
 		.of_match_table = ch13726a_of_match,
diff --git a/drivers/gpu/drm/panel/panel-dsi-cm.c b/drivers/gpu/drm/panel/panel-dsi-cm.c
index ae6e9ffc46cb..0a0741804fd3 100644
--- a/drivers/gpu/drm/panel/panel-dsi-cm.c
+++ b/drivers/gpu/drm/panel/panel-dsi-cm.c
@@ -559,16 +559,17 @@ static int dsicm_probe(struct mipi_dsi_device *dsi)
 	dsi->hs_rate = ddata->panel_data->max_hs_rate;
 	dsi->lp_rate = ddata->panel_data->max_lp_rate;
 
-	drm_panel_add(&ddata->panel);
+	r = devm_drm_panel_add(dev, &ddata->panel);
+	if (r)
+		goto err_sysfs;
 
 	r = mipi_dsi_attach(dsi);
 	if (r < 0)
-		goto err_dsi_attach;
+		goto err_sysfs;
 
 	return 0;
 
-err_dsi_attach:
-	drm_panel_remove(&ddata->panel);
+err_sysfs:
 	sysfs_remove_group(&dsi->dev.kobj, &dsicm_attr_group);
 err_bl:
 	if (ddata->extbldev)
@@ -580,12 +581,13 @@ static int dsicm_probe(struct mipi_dsi_device *dsi)
 static void dsicm_remove(struct mipi_dsi_device *dsi)
 {
 	struct panel_drv_data *ddata = mipi_dsi_get_drvdata(dsi);
+	int ret;
 
 	dev_dbg(&dsi->dev, "remove\n");
 
-	mipi_dsi_detach(dsi);
-
-	drm_panel_remove(&ddata->panel);
+	ret = mipi_dsi_detach(dsi);
+	if (ret < 0)
+		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 
 	sysfs_remove_group(&dsi->dev.kobj, &dsicm_attr_group);
 
diff --git a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
index fb9f9f42be4f..508ea77f007b 100644
--- a/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
+++ b/drivers/gpu/drm/panel/panel-ebbg-ft8719.c
@@ -202,30 +202,19 @@ static int ebbg_ft8719_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "Failed to attach to DSI host: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void ebbg_ft8719_remove(struct mipi_dsi_device *dsi)
-{
-	struct ebbg_ft8719 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id ebbg_ft8719_of_match[] = {
 	{ .compatible = "ebbg,ft8719" },
 	{ /* sentinel */ }
@@ -234,7 +223,6 @@ MODULE_DEVICE_TABLE(of, ebbg_ft8719_of_match);
 
 static struct mipi_dsi_driver ebbg_ft8719_driver = {
 	.probe = ebbg_ft8719_probe,
-	.remove = ebbg_ft8719_remove,
 	.driver = {
 		.name = "panel-ebbg-ft8719",
 		.of_match_table = ebbg_ft8719_of_match,
diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index d23002b5a2d7..cc09ef9ac91c 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -254,30 +254,19 @@ static int kd35t133_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void kd35t133_remove(struct mipi_dsi_device *dsi)
-{
-	struct kd35t133 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id kd35t133_of_match[] = {
 	{ .compatible = "elida,kd35t133" },
 	{ /* sentinel */ }
@@ -290,7 +279,6 @@ static struct mipi_dsi_driver kd35t133_driver = {
 		.of_match_table = kd35t133_of_match,
 	},
 	.probe	= kd35t133_probe,
-	.remove = kd35t133_remove,
 };
 module_mipi_dsi_driver(kd35t133_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
index 8c3a231c147d..c58d8fe0c384 100644
--- a/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
+++ b/drivers/gpu/drm/panel/panel-feixin-k101-im2ba02.c
@@ -468,29 +468,21 @@ static int k101_im2ba02_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return ret;
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = 4;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&ctx->panel);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
 
-static void k101_im2ba02_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	struct k101_im2ba02 *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id k101_im2ba02_of_match[] = {
 	{ .compatible = "feixin,k101-im2ba02", },
 	{ /* sentinel */ }
@@ -499,7 +491,6 @@ MODULE_DEVICE_TABLE(of, k101_im2ba02_of_match);
 
 static struct mipi_dsi_driver k101_im2ba02_driver = {
 	.probe = k101_im2ba02_dsi_probe,
-	.remove = k101_im2ba02_dsi_remove,
 	.driver = {
 		.name = "feixin-k101-im2ba02",
 		.of_match_table = k101_im2ba02_of_match,
diff --git a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
index c1d8ca5ca6e1..2116b3f50402 100644
--- a/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
+++ b/drivers/gpu/drm/panel/panel-feiyang-fy07024di26a30d.c
@@ -213,29 +213,21 @@ static int feiyang_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return ret;
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO_BURST;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = 4;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&ctx->panel);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
 
-static void feiyang_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	struct feiyang *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id feiyang_of_match[] = {
 	{ .compatible = "feiyang,fy07024di26a30d", },
 	{ /* sentinel */ }
@@ -244,7 +236,6 @@ MODULE_DEVICE_TABLE(of, feiyang_of_match);
 
 static struct mipi_dsi_driver feiyang_driver = {
 	.probe = feiyang_dsi_probe,
-	.remove = feiyang_dsi_remove,
 	.driver = {
 		.name = "feiyang-fy07024di26a30d",
 		.of_match_table = feiyang_of_match,
diff --git a/drivers/gpu/drm/panel/panel-hydis-hv101hd1.c b/drivers/gpu/drm/panel/panel-hydis-hv101hd1.c
index 0a96eb0fae1e..4cddc6052514 100644
--- a/drivers/gpu/drm/panel/panel-hydis-hv101hd1.c
+++ b/drivers/gpu/drm/panel/panel-hydis-hv101hd1.c
@@ -142,30 +142,17 @@ static int hv101hd1_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&hv->panel);
+	ret = devm_drm_panel_add(dev, &hv->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret) {
-		drm_panel_remove(&hv->panel);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
+	if (ret)
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-	}
 
 	return 0;
 }
 
-static void hv101hd1_remove(struct mipi_dsi_device *dsi)
-{
-	struct hv101hd1 *hv = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev,
-			"Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&hv->panel);
-}
-
 static const struct of_device_id hv101hd1_of_match[] = {
 	{ .compatible = "hydis,hv101hd1" },
 	{ /* sentinel */ }
@@ -178,7 +165,6 @@ static struct mipi_dsi_driver hv101hd1_driver = {
 		.of_match_table = hv101hd1_of_match,
 	},
 	.probe = hv101hd1_probe,
-	.remove = hv101hd1_remove,
 };
 module_mipi_dsi_driver(hv101hd1_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-innolux-p079zca.c b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
index 80afeeab9475..a9576511dd7f 100644
--- a/drivers/gpu/drm/panel/panel-innolux-p079zca.c
+++ b/drivers/gpu/drm/panel/panel-innolux-p079zca.c
@@ -416,7 +416,9 @@ static int innolux_panel_add(struct mipi_dsi_device *dsi,
 	if (err)
 		return err;
 
-	drm_panel_add(&innolux->base);
+	err = devm_drm_panel_add(dev, &innolux->base);
+	if (err)
+		return err;
 
 	mipi_dsi_set_drvdata(dsi, innolux);
 	innolux->link = dsi;
@@ -424,15 +426,9 @@ static int innolux_panel_add(struct mipi_dsi_device *dsi,
 	return 0;
 }
 
-static void innolux_panel_del(struct innolux_panel *innolux)
-{
-	drm_panel_remove(&innolux->base);
-}
-
 static int innolux_panel_probe(struct mipi_dsi_device *dsi)
 {
 	const struct panel_desc *desc;
-	struct innolux_panel *innolux;
 	int err;
 
 	desc = of_device_get_match_data(&dsi->dev);
@@ -444,27 +440,7 @@ static int innolux_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	err = mipi_dsi_attach(dsi);
-	if (err < 0) {
-		innolux = mipi_dsi_get_drvdata(dsi);
-		innolux_panel_del(innolux);
-		return err;
-	}
-
-	return 0;
-}
-
-static void innolux_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct innolux_panel *innolux = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
-
-	innolux_panel_del(innolux);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver innolux_panel_driver = {
@@ -473,7 +449,6 @@ static struct mipi_dsi_driver innolux_panel_driver = {
 		.of_match_table = innolux_of_match,
 	},
 	.probe = innolux_panel_probe,
-	.remove = innolux_panel_remove,
 };
 module_mipi_dsi_driver(innolux_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
index 5202c1ffc6e1..b6fadab7cfec 100644
--- a/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
+++ b/drivers/gpu/drm/panel/panel-jadard-jd9365da-h3.c
@@ -3245,25 +3245,15 @@ static int jadard_dsi_probe(struct mipi_dsi_device *dsi)
 
 	jadard->panel.prepare_prev_first = true;
 
-	drm_panel_add(&jadard->panel);
+	ret = devm_drm_panel_add(dev, &jadard->panel);
+	if (ret)
+		return ret;
 
 	mipi_dsi_set_drvdata(dsi, jadard);
 	jadard->dsi = dsi;
 	jadard->desc = desc;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0)
-		drm_panel_remove(&jadard->panel);
-
-	return ret;
-}
-
-static void jadard_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	struct jadard *jadard = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&jadard->panel);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static const struct of_device_id jadard_of_match[] = {
@@ -3333,7 +3323,6 @@ MODULE_DEVICE_TABLE(of, jadard_of_match);
 
 static struct mipi_dsi_driver jadard_driver = {
 	.probe = jadard_dsi_probe,
-	.remove = jadard_dsi_remove,
 	.driver = {
 		.name = "jadard-jd9365da",
 		.of_match_table = jadard_of_match,
diff --git a/drivers/gpu/drm/panel/panel-khadas-ts050.c b/drivers/gpu/drm/panel/panel-khadas-ts050.c
index 67ca055f06f3..e63f382d53be 100644
--- a/drivers/gpu/drm/panel/panel-khadas-ts050.c
+++ b/drivers/gpu/drm/panel/panel-khadas-ts050.c
@@ -825,7 +825,9 @@ static int khadas_ts050_panel_add(struct khadas_ts050_panel *khadas_ts050)
 	if (err)
 		return err;
 
-	drm_panel_add(&khadas_ts050->base);
+	ret = devm_drm_panel_add(dev, &khadas_ts050->base);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -862,23 +864,7 @@ static int khadas_ts050_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	err = mipi_dsi_attach(dsi);
-	if (err)
-		drm_panel_remove(&khadas_ts050->base);
-
-	return err;
-}
-
-static void khadas_ts050_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct khadas_ts050_panel *khadas_ts050 = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
-
-	drm_panel_remove(&khadas_ts050->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver khadas_ts050_panel_driver = {
@@ -887,7 +873,6 @@ static struct mipi_dsi_driver khadas_ts050_panel_driver = {
 		.of_match_table = khadas_ts050_of_match,
 	},
 	.probe = khadas_ts050_panel_probe,
-	.remove = khadas_ts050_panel_remove,
 };
 module_mipi_dsi_driver(khadas_ts050_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
index 893af9b16756..bcdc95538f0c 100644
--- a/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
+++ b/drivers/gpu/drm/panel/panel-kingdisplay-kd097d04.c
@@ -341,14 +341,7 @@ static int kingdisplay_panel_add(struct kingdisplay_panel *kingdisplay)
 	if (err)
 		return err;
 
-	drm_panel_add(&kingdisplay->base);
-
-	return 0;
-}
-
-static void kingdisplay_panel_del(struct kingdisplay_panel *kingdisplay)
-{
-	drm_panel_remove(&kingdisplay->base);
+	return devm_drm_panel_add(dev, &kingdisplay->base);
 }
 
 static int kingdisplay_panel_probe(struct mipi_dsi_device *dsi)
@@ -375,25 +368,7 @@ static int kingdisplay_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	err = mipi_dsi_attach(dsi);
-	if (err < 0) {
-		kingdisplay_panel_del(kingdisplay);
-		return err;
-	}
-
-	return 0;
-}
-
-static void kingdisplay_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct kingdisplay_panel *kingdisplay = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
-
-	kingdisplay_panel_del(kingdisplay);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver kingdisplay_panel_driver = {
@@ -402,7 +377,6 @@ static struct mipi_dsi_driver kingdisplay_panel_driver = {
 		.of_match_table = kingdisplay_of_match,
 	},
 	.probe = kingdisplay_panel_probe,
-	.remove = kingdisplay_panel_remove,
 };
 module_mipi_dsi_driver(kingdisplay_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-lg-sw43408.c b/drivers/gpu/drm/panel/panel-lg-sw43408.c
index 293826c5006b..822318f546ef 100644
--- a/drivers/gpu/drm/panel/panel-lg-sw43408.c
+++ b/drivers/gpu/drm/panel/panel-lg-sw43408.c
@@ -254,8 +254,11 @@ static int sw43408_add(struct sw43408_panel *ctx)
 
 	ctx->base.prepare_prev_first = true;
 
-	drm_panel_add(&ctx->base);
-	return ret;
+	ret = devm_drm_panel_add(dev, &ctx->base);
+	if (ret)
+		return ret;
+
+	return 0;
 }
 
 static int sw43408_probe(struct mipi_dsi_device *dsi)
@@ -294,19 +297,7 @@ static int sw43408_probe(struct mipi_dsi_device *dsi)
 
 	dsi->dsc = &ctx->dsc;
 
-	return mipi_dsi_attach(dsi);
-}
-
-static void sw43408_remove(struct mipi_dsi_device *dsi)
-{
-	struct sw43408_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver sw43408_driver = {
@@ -315,7 +306,6 @@ static struct mipi_dsi_driver sw43408_driver = {
 		.of_match_table = sw43408_of_match,
 	},
 	.probe = sw43408_probe,
-	.remove = sw43408_remove,
 };
 module_mipi_dsi_driver(sw43408_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c b/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
index 24b34443ace0..677e86fe9d9d 100644
--- a/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
+++ b/drivers/gpu/drm/panel/panel-lincolntech-lcd197.c
@@ -220,24 +220,11 @@ static int lincoln_lcd197_panel_probe(struct mipi_dsi_device *dsi)
 	if (err)
 		return err;
 
-	drm_panel_add(&lcd->panel);
-	err = mipi_dsi_attach(dsi);
+	err = devm_drm_panel_add(dev, &lcd->panel);
 	if (err)
-		drm_panel_remove(&lcd->panel);
-
-	return err;
-}
-
-static void lincoln_lcd197_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct lincoln_lcd197_panel *lcd = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
+		return err;
 
-	drm_panel_remove(&lcd->panel);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static const struct of_device_id lincoln_lcd197_of_match[] = {
@@ -252,7 +239,6 @@ static struct mipi_dsi_driver lincoln_lcd197_panel_driver = {
 		.of_match_table = lincoln_lcd197_of_match,
 	},
 	.probe = lincoln_lcd197_panel_probe,
-	.remove = lincoln_lcd197_panel_remove,
 };
 module_mipi_dsi_driver(lincoln_lcd197_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-lxd-m9189a.c b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
index baaf170779e0..a6174f895c99 100644
--- a/drivers/gpu/drm/panel/panel-lxd-m9189a.c
+++ b/drivers/gpu/drm/panel/panel-lxd-m9189a.c
@@ -200,28 +200,15 @@ static int lxd_m9189_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
 
-	drm_panel_add(&m9189->panel);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
-		drm_panel_remove(&m9189->panel);
+	ret = devm_drm_panel_add(dev, &m9189->panel);
+	if (ret)
 		return ret;
-	}
 
-	return 0;
-}
-
-static void lxd_m9189_remove(struct mipi_dsi_device *dsi)
-{
-	struct m9189_panel *m9189 = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
+		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
 
-	drm_panel_remove(&m9189->panel);
+	return 0;
 }
 
 static const struct of_device_id lxd_m9189_of_match[] = {
@@ -232,7 +219,6 @@ MODULE_DEVICE_TABLE(of, lxd_m9189_of_match);
 
 static struct mipi_dsi_driver lxd_m9189_driver = {
 	.probe = lxd_m9189_probe,
-	.remove = lxd_m9189_remove,
 	.driver = {
 		.name = "panel-lxd-m9189a",
 		.of_match_table = lxd_m9189_of_match,
diff --git a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
index 27e188bb2d7f..dd768eeaba73 100644
--- a/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
+++ b/drivers/gpu/drm/panel/panel-mantix-mlaf057we51.c
@@ -278,12 +278,13 @@ static int mantix_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed (%d). Is host ready?\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
@@ -295,14 +296,6 @@ static int mantix_probe(struct mipi_dsi_device *dsi)
 	return 0;
 }
 
-static void mantix_remove(struct mipi_dsi_device *dsi)
-{
-	struct mantix *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id mantix_of_match[] = {
 	{ .compatible = "mantix,mlaf057we51-x", .data = &default_mode_mantix },
 	{ .compatible = "ys,ys57pss36bh5gq", .data = &default_mode_ys },
@@ -312,7 +305,6 @@ MODULE_DEVICE_TABLE(of, mantix_of_match);
 
 static struct mipi_dsi_driver mantix_driver = {
 	.probe	= mantix_probe,
-	.remove = mantix_remove,
 	.driver = {
 		.name = DRV_NAME,
 		.of_match_table = mantix_of_match,
diff --git a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
index 22560384e48e..fdc8d2273b87 100644
--- a/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
+++ b/drivers/gpu/drm/panel/panel-newvision-nv3051d.c
@@ -397,12 +397,13 @@ static int panel_nv3051d_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
@@ -418,20 +419,6 @@ static void panel_nv3051d_shutdown(struct mipi_dsi_device *dsi)
 	drm_panel_disable(&ctx->panel);
 }
 
-static void panel_nv3051d_remove(struct mipi_dsi_device *dsi)
-{
-	struct panel_nv3051d *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	panel_nv3051d_shutdown(dsi);
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct drm_display_mode nv3051d_rgxx3_modes[] = {
 	{ /* 120hz */
 		.hdisplay	= 640,
@@ -531,7 +518,6 @@ static struct mipi_dsi_driver newvision_nv3051d_driver = {
 		.of_match_table = newvision_nv3051d_of_match,
 	},
 	.probe	= panel_nv3051d_probe,
-	.remove = panel_nv3051d_remove,
 	.shutdown = panel_nv3051d_shutdown,
 };
 module_mipi_dsi_driver(newvision_nv3051d_driver);
diff --git a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
index 130520558a81..871259c4e873 100644
--- a/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
+++ b/drivers/gpu/drm/panel/panel-orisetech-otm8009a.c
@@ -432,26 +432,19 @@ static int otm8009a_probe(struct mipi_dsi_device *dsi)
 	ctx->bl_dev->props.power = BACKLIGHT_POWER_OFF;
 	ctx->bl_dev->props.type = BACKLIGHT_RAW;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed. Is host ready?\n");
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void otm8009a_remove(struct mipi_dsi_device *dsi)
-{
-	struct otm8009a *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id orisetech_otm8009a_of_match[] = {
 	{ .compatible = "orisetech,otm8009a" },
 	{ }
@@ -460,7 +453,6 @@ MODULE_DEVICE_TABLE(of, orisetech_otm8009a_of_match);
 
 static struct mipi_dsi_driver orisetech_otm8009a_driver = {
 	.probe  = otm8009a_probe,
-	.remove = otm8009a_remove,
 	.driver = {
 		.name = "panel-orisetech-otm8009a",
 		.of_match_table = orisetech_otm8009a_of_match,
diff --git a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
index 63ae9dc5712f..ae6b3ae5a120 100644
--- a/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
+++ b/drivers/gpu/drm/panel/panel-osd-osd101t2587-53ts.c
@@ -134,7 +134,9 @@ static int osd101t2587_panel_add(struct osd101t2587_panel *osd101t2587)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&osd101t2587->base);
+	ret = devm_drm_panel_add(dev, &osd101t2587->base);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -172,23 +174,7 @@ static int osd101t2587_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret)
-		drm_panel_remove(&osd101t2587->base);
-
-	return ret;
-}
-
-static void osd101t2587_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct osd101t2587_panel *osd101t2587 = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	drm_panel_remove(&osd101t2587->base);
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver osd101t2587_panel_driver = {
@@ -197,7 +183,6 @@ static struct mipi_dsi_driver osd101t2587_panel_driver = {
 		.of_match_table = osd101t2587_of_match,
 	},
 	.probe = osd101t2587_panel_probe,
-	.remove = osd101t2587_panel_remove,
 };
 module_mipi_dsi_driver(osd101t2587_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
index d21d93a0700e..c00b1c44611a 100644
--- a/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
+++ b/drivers/gpu/drm/panel/panel-panasonic-vvx10f034n00.c
@@ -172,15 +172,7 @@ static int wuxga_nt_panel_add(struct wuxga_nt_panel *wuxga_nt)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&wuxga_nt->base);
-
-	return 0;
-}
-
-static void wuxga_nt_panel_del(struct wuxga_nt_panel *wuxga_nt)
-{
-	if (wuxga_nt->base.dev)
-		drm_panel_remove(&wuxga_nt->base);
+	return devm_drm_panel_add(dev, &wuxga_nt->base);
 }
 
 static int wuxga_nt_panel_probe(struct mipi_dsi_device *dsi)
@@ -210,25 +202,7 @@ static int wuxga_nt_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		wuxga_nt_panel_del(wuxga_nt);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void wuxga_nt_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct wuxga_nt_panel *wuxga_nt = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
-
-	wuxga_nt_panel_del(wuxga_nt);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver wuxga_nt_panel_driver = {
@@ -237,7 +211,6 @@ static struct mipi_dsi_driver wuxga_nt_panel_driver = {
 		.of_match_table = wuxga_nt_of_match,
 	},
 	.probe = wuxga_nt_panel_probe,
-	.remove = wuxga_nt_panel_remove,
 };
 module_mipi_dsi_driver(wuxga_nt_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
index c3fbc459c7e0..28236d4b60ec 100644
--- a/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
+++ b/drivers/gpu/drm/panel/panel-ronbo-rb070d30.c
@@ -192,29 +192,21 @@ static int rb070d30_panel_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(&dsi->dev, &ctx->panel);
+	if (ret)
+		return ret;
 
 	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST | MIPI_DSI_MODE_LPM;
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = 4;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		drm_panel_remove(&ctx->panel);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
+	if (ret < 0)
 		return ret;
-	}
 
 	return 0;
 }
 
-static void rb070d30_panel_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	struct rb070d30_panel *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id rb070d30_panel_of_match[] = {
 	{ .compatible = "ronbo,rb070d30" },
 	{ /* sentinel */ },
@@ -223,7 +215,6 @@ MODULE_DEVICE_TABLE(of, rb070d30_panel_of_match);
 
 static struct mipi_dsi_driver rb070d30_panel_driver = {
 	.probe = rb070d30_panel_dsi_probe,
-	.remove = rb070d30_panel_dsi_remove,
 	.driver = {
 		.name = "panel-ronbo-rb070d30",
 		.of_match_table	= rb070d30_panel_of_match,
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7701.c b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
index f16e0de1ea60..31c56eadda12 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7701.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7701.c
@@ -1263,7 +1263,6 @@ static void st7701_cleanup(void *data)
 {
 	struct st7701 *st7701 = (struct st7701 *)data;
 
-	drm_panel_remove(&st7701->panel);
 	drm_panel_disable(&st7701->panel);
 	drm_panel_unprepare(&st7701->panel);
 }
@@ -1318,7 +1317,9 @@ static int st7701_probe(struct device *dev, int connector_type)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&st7701->panel);
+	ret = devm_drm_panel_add(dev, &st7701->panel);
+	if (ret)
+		return ret;
 
 	dev_set_drvdata(dev, st7701);
 	st7701->desc = desc;
@@ -1347,7 +1348,7 @@ static int st7701_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = st7701->desc->format;
 	dsi->lanes = st7701->desc->lanes;
 
-	err = mipi_dsi_attach(dsi);
+	err = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (err)
 		return dev_err_probe(&dsi->dev, err, "Failed to init MIPI DSI\n");
 
@@ -1379,11 +1380,6 @@ static int st7701_spi_probe(struct spi_device *spi)
 	return 0;
 }
 
-static void st7701_dsi_remove(struct mipi_dsi_device *dsi)
-{
-	mipi_dsi_detach(dsi);
-}
-
 static const struct of_device_id st7701_dsi_of_match[] = {
 	{ .compatible = "anbernic,rg-arc-panel", .data = &rg_arc_desc },
 	{ .compatible = "densitron,dmt028vghmcmi-1a", .data = &dmt028vghmcmi_1a_desc },
@@ -1408,7 +1404,6 @@ MODULE_DEVICE_TABLE(spi, st7701_spi_ids);
 
 static struct mipi_dsi_driver st7701_dsi_driver = {
 	.probe		= st7701_dsi_probe,
-	.remove		= st7701_dsi_remove,
 	.driver = {
 		.name		= "st7701",
 		.of_match_table	= st7701_dsi_of_match,
diff --git a/drivers/gpu/drm/panel/panel-sitronix-st7703.c b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
index 70f7282471e6..7ed1a51fff68 100644
--- a/drivers/gpu/drm/panel/panel-sitronix-st7703.c
+++ b/drivers/gpu/drm/panel/panel-sitronix-st7703.c
@@ -977,12 +977,13 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed (%d). Is host ready?\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
@@ -998,13 +999,6 @@ static int st7703_probe(struct mipi_dsi_device *dsi)
 static void st7703_remove(struct mipi_dsi_device *dsi)
 {
 	struct st7703 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
 
 	st7703_debugfs_remove(ctx);
 }
diff --git a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
index 7f04b7b404e7..fe42bee14134 100644
--- a/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
+++ b/drivers/gpu/drm/panel/panel-startek-kd070fhfid015.c
@@ -286,7 +286,9 @@ static int stk_panel_add(struct stk_panel *stk)
 		return ret;
 	}
 
-	drm_panel_add(&stk->base);
+	ret = devm_drm_panel_add(dev, &stk->base);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -315,24 +317,7 @@ static int stk_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret < 0)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0)
-		drm_panel_remove(&stk->base);
-
-	return 0;
-}
-
-static void stk_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct stk_panel *stk = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
-			err);
-
-	drm_panel_remove(&stk->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver stk_panel_driver = {
@@ -341,7 +326,6 @@ static struct mipi_dsi_driver stk_panel_driver = {
 		.of_match_table = stk_of_match,
 	},
 	.probe = stk_panel_probe,
-	.remove = stk_panel_remove,
 };
 module_mipi_dsi_driver(stk_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-summit.c b/drivers/gpu/drm/panel/panel-summit.c
index 84435be52424..8c5523d9793d 100644
--- a/drivers/gpu/drm/panel/panel-summit.c
+++ b/drivers/gpu/drm/panel/panel-summit.c
@@ -88,17 +88,11 @@ static int summit_probe(struct mipi_dsi_device *dsi)
 	if (IS_ERR(s_data->bl))
 		return PTR_ERR(s_data->bl);
 
-	drm_panel_add(&s_data->panel);
-
-	return mipi_dsi_attach(dsi);
-}
-
-static void summit_remove(struct mipi_dsi_device *dsi)
-{
-	struct summit_data *s_data = mipi_dsi_get_drvdata(dsi);
+	ret = devm_drm_panel_add(dev, &s_data->panel);
+	if (ret)
+		return ret;
 
-	mipi_dsi_detach(dsi);
-	drm_panel_remove(&s_data->panel);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static int summit_suspend(struct device *dev)
@@ -120,7 +114,6 @@ MODULE_DEVICE_TABLE(of, summit_of_match);
 
 static struct mipi_dsi_driver summit_driver = {
 	.probe = summit_probe,
-	.remove = summit_remove,
 	.driver = {
 		.name = "panel-summit",
 		.of_match_table = summit_of_match,
diff --git a/drivers/gpu/drm/panel/panel-synaptics-r63353.c b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
index 3a74d48753d9..73447d7b15d3 100644
--- a/drivers/gpu/drm/panel/panel-synaptics-r63353.c
+++ b/drivers/gpu/drm/panel/panel-synaptics-r63353.c
@@ -265,29 +265,11 @@ static int r63353_panel_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&panel->base);
-
-	ret = mipi_dsi_attach(dsi);
-	if (ret < 0) {
-		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
-		drm_panel_remove(&panel->base);
+	ret = devm_drm_panel_add(dev, &panel->base);
+	if (ret)
 		return ret;
-	}
-
-	return ret;
-}
-
-static void r63353_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct r63353_panel *rpanel = mipi_dsi_get_drvdata(dsi);
-	struct device *dev = &dsi->dev;
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(dev, "Failed to detach from host (%d)\n", ret);
 
-	drm_panel_remove(&rpanel->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static void r63353_panel_shutdown(struct mipi_dsi_device *dsi)
@@ -319,7 +301,6 @@ static struct mipi_dsi_driver r63353_panel_driver = {
 		   .of_match_table = r63353_of_match,
 	},
 	.probe = r63353_panel_probe,
-	.remove = r63353_panel_remove,
 	.shutdown = r63353_panel_shutdown,
 };
 
diff --git a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
index 13cfe252a838..5d458c3b6ebb 100644
--- a/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
+++ b/drivers/gpu/drm/panel/panel-tdo-tl070wsh30.c
@@ -166,7 +166,9 @@ static int tdo_tl070wsh30_panel_add(struct tdo_tl070wsh30_panel *tdo_tl070wsh30)
 	if (err)
 		return err;
 
-	drm_panel_add(&tdo_tl070wsh30->base);
+	ret = devm_drm_panel_add(dev, &tdo_tl070wsh30->base);
+	if (ret)
+		return ret;
 
 	return 0;
 }
@@ -195,19 +197,7 @@ static int tdo_tl070wsh30_panel_probe(struct mipi_dsi_device *dsi)
 	if (err < 0)
 		return err;
 
-	return mipi_dsi_attach(dsi);
-}
-
-static void tdo_tl070wsh30_panel_remove(struct mipi_dsi_device *dsi)
-{
-	struct tdo_tl070wsh30_panel *tdo_tl070wsh30 = mipi_dsi_get_drvdata(dsi);
-	int err;
-
-	err = mipi_dsi_detach(dsi);
-	if (err < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", err);
-
-	drm_panel_remove(&tdo_tl070wsh30->base);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
@@ -216,7 +206,6 @@ static struct mipi_dsi_driver tdo_tl070wsh30_panel_driver = {
 		.of_match_table = tdo_tl070wsh30_of_match,
 	},
 	.probe = tdo_tl070wsh30_panel_probe,
-	.remove = tdo_tl070wsh30_panel_remove,
 };
 module_mipi_dsi_driver(tdo_tl070wsh30_panel_driver);
 
diff --git a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
index fc6516373b5d..652c4d71a613 100644
--- a/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
+++ b/drivers/gpu/drm/panel/panel-xinpeng-xpp055c272.c
@@ -274,30 +274,19 @@ static int xpp055c272_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	drm_panel_add(&ctx->panel);
+	ret = devm_drm_panel_add(dev, &ctx->panel);
+	if (ret)
+		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(dev, "mipi_dsi_attach failed: %d\n", ret);
-		drm_panel_remove(&ctx->panel);
 		return ret;
 	}
 
 	return 0;
 }
 
-static void xpp055c272_remove(struct mipi_dsi_device *dsi)
-{
-	struct xpp055c272 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
-	drm_panel_remove(&ctx->panel);
-}
-
 static const struct of_device_id xpp055c272_of_match[] = {
 	{ .compatible = "xinpeng,xpp055c272" },
 	{ /* sentinel */ }
@@ -310,7 +299,6 @@ static struct mipi_dsi_driver xpp055c272_driver = {
 		.of_match_table = xpp055c272_of_match,
 	},
 	.probe	= xpp055c272_probe,
-	.remove = xpp055c272_remove,
 };
 module_mipi_dsi_driver(xpp055c272_driver);
 
-- 
2.43.0

