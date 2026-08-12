Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CF03AC5B572
	for <dri-devel@archiver.kernel.org>; Wed, 12 Aug 2026 13:04:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3DFF210EFB9;
	Wed, 12 Aug 2026 13:04:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="TvgilNnR";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6BBB710EFB9
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 13:04:53 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-4799b3f7c83so598908f8f.2
 for <dri-devel@lists.freedesktop.org>; Wed, 12 Aug 2026 06:04:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786539892; x=1787144692; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=UqlYfHnG6VZbJsj6k61b+U/kYDqFPJOHiYZPRPAPZQI=;
 b=TvgilNnREW534tBtInXlYpo1lhCU8XBUumgaKZ6QyAuLFpR1m0P0Kkzvlj7EK1YhY0
 k6LCmHCqIwMgL/bcT/VrLBDs7LsLjOcvpF5pB/GDxWCh2IbqMQnb1NXzJAZTYrM2+fki
 VKEhrLtPHjDESQnQIWoCDon0Q1hr7is+vmcU3ilBcweh5hw/dHVqFAcZlfrD69BT7uWa
 GKyo2J+GL3x8hDcvd8QebjcWwSIWvJb8xP64kEtG/xIQ8naoo6FHuwoJv2Xahr7bSz10
 bqiG3xqYd2uL8vFDFjbPWfObYw0b9RJbnGfp0Yi6aJacjVAaO6nr/VLCXx7323H7dTXt
 QVTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786539892; x=1787144692;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=UqlYfHnG6VZbJsj6k61b+U/kYDqFPJOHiYZPRPAPZQI=;
 b=Gfs0quPV7K58FseO57VpHXXqD6IBorZQ2GSMawefTg0YQKRnLdDTfL6nIMuod5JCZH
 c7V2udZTh2mYPgA7P4Zap1LoJsu0u/5VTP9vdNHmrgQ37fk/Q9XMeZOxdqfpynr+bfek
 rGAfDvXC50J2vuBNBXEuqUajjCTLnuhKNqFd38S5JZomqf8ymZn4FrM27eorxsDsJ/Vo
 avQxRDkB7VmBjpLhbdrn5MhNXjW7FI9eWMqavdXcmT3mWOFEPhqyqzeMM35CFnaV6hAA
 ySEdVz0e0YuIc1T1d+hCpDIKMnoPG6uHBf3MOTfunx7oWLPANyv0wiDtCJbll/f9Ydfw
 V2hQ==
X-Forwarded-Encrypted: i=1;
 AHgh+RosQABkPyvYfdAIugZ1xhj8YMUrfHHX0hWPYIsb/Hej/aGuMGfIuSYUVDoud5Ot+oEoYH9vt0AeD60=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw2UH89MKdtHVdFJiaUeAG+MWZgbRLjhrJaVxrAoUrCZySFLeRi
 B7V/sTbNdwnIVI0dVNKq49JHNN9Bp3EB3w97/jcKfeCqXtjAcPBx4srn
X-Gm-Gg: AR+sD113wlO8Ahk251/h6WNeSYBHouIeT/0kQ/qzlixNkjNgq69h665Ji4XHWIX3EJj
 kwNJoqclxC/Oh7MOShiMTRhcceuaSWIM0u+Q/bCecP90OwnZQQt0iew4Cf7XMbcUrxMm7FivnME
 /pYQBv88xhyZyDgYgcL7jNW0jClMwUcOfa813865BhyUoj8CWnY4RIi1TwQaCc+h7ZxO+kOcQhV
 zQddTdHJ6v/1yMLRZLld4cmJg/hftl0rGl3PRxnBfFtY9CffP8B502sch1J5D2VNtnT2PI54wf6
 iPBOidv+/aHJSrwYvW8WwFMK6RFCbQQXlYBXxcjTQur3dnp4HsXZOJjA6b7zg4vm1iTzXApxx7C
 dNSsb0tahIhHswCNDEsHKTUTCNYE7FEoKZ5atZJ1bhuN7lywra+/nw70uo4c1q/+gh6o6klgc/T
 N9U5IE7kkKcFdoguEStYwfcZRseq0yd2mQwYpk0Y7L+ZzHnIF+Ouxd3QX+rUERn7v2dJQMlIsFO
 qB7PPlk3UifF9ShZTjtvU8tfg==
X-Received: by 2002:a05:6000:41ef:b0:47f:96e3:5309 with SMTP id
 ffacd0b85a97d-481528bf4eamr6764670f8f.9.1786539891669; 
 Wed, 12 Aug 2026 06:04:51 -0700 (PDT)
Received: from osama.. ([2a02:908:185:7e40:3d2e:78f3:cfb2:413d])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48150d5eb2csm7040804f8f.30.2026.08.12.06.04.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 12 Aug 2026 06:04:51 -0700 (PDT)
From: Osama Abdelkader <osama.abdelkader@gmail.com>
To: luca.ceresoli@bootlin.com, Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Ondrej Jirman <megi@xff.cz>,
 Javier Martinez Canillas <javierm@redhat.com>,
 Michael Trimarchi <michael@amarulasolutions.com>,
 Michael Walle <mwalle@kernel.org>,
 Dario Binacchi <dario.binacchi@amarulasolutions.com>,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: Osama Abdelkader <osama.abdelkader@gmail.com>
Subject: [PATCH v3 4/6] drm/panel: Use devm_mipi_dsi_attach in Himax and
 Ilitek panels
Date: Wed, 12 Aug 2026 15:04:21 +0200
Message-ID: <20260812130429.16850-4-osama.abdelkader@gmail.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20260812130429.16850-1-osama.abdelkader@gmail.com>
References: <20260812130429.16850-1-osama.abdelkader@gmail.com>
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

Use the managed MIPI DSI attach helper in Himax and Ilitek panel drivers
and drop the corresponding manual detach calls from remove paths.

Signed-off-by: Osama Abdelkader <osama.abdelkader@gmail.com>

---
v3:
- Move the changelog after the `---`.

v2:
- break long description lines.
- add Signed-off-by tag

 drivers/gpu/drm/panel/panel-himax-hx83102.c       | 7 +------
 drivers/gpu/drm/panel/panel-himax-hx83112a.c      | 8 +-------
 drivers/gpu/drm/panel/panel-himax-hx83112b.c      | 8 +-------
 drivers/gpu/drm/panel/panel-himax-hx8394.c        | 8 +-------
 drivers/gpu/drm/panel/panel-ilitek-ili9805.c      | 9 +--------
 drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c | 3 +--
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c     | 4 +---
 drivers/gpu/drm/panel/panel-ilitek-ili9882t.c     | 7 +------
 8 files changed, 8 insertions(+), 46 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-himax-hx83102.c b/drivers/gpu/drm/panel/panel-himax-hx83102.c
index 6a0851ccf9bb..4a28541891a6 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83102.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83102.c
@@ -1318,7 +1318,7 @@ static int hx83102_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, ctx);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret)
 		drm_panel_remove(&ctx->base);
 
@@ -1328,11 +1328,6 @@ static int hx83102_probe(struct mipi_dsi_device *dsi)
 static void hx83102_remove(struct mipi_dsi_device *dsi)
 {
 	struct hx83102 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 
 	if (ctx->base.dev)
 		drm_panel_remove(&ctx->base);
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83112a.c b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
index 142cb1cc067a..bcd665b7ff88 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83112a.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83112a.c
@@ -305,7 +305,7 @@ static int hx83112a_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
 		drm_panel_remove(&ctx->panel);
@@ -318,12 +318,6 @@ static int hx83112a_probe(struct mipi_dsi_device *dsi)
 static void hx83112a_remove(struct mipi_dsi_device *dsi)
 {
 	struct hx83112a_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-himax-hx83112b.c b/drivers/gpu/drm/panel/panel-himax-hx83112b.c
index 41f21f8c1373..1ea5a9dc3ac5 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx83112b.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx83112b.c
@@ -388,7 +388,7 @@ static int hx83112b_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		drm_panel_remove(&ctx->panel);
 		return dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
@@ -400,12 +400,6 @@ static int hx83112b_probe(struct mipi_dsi_device *dsi)
 static void hx83112b_remove(struct mipi_dsi_device *dsi)
 {
 	struct hx83112b_panel *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-himax-hx8394.c b/drivers/gpu/drm/panel/panel-himax-hx8394.c
index 09124610fdc8..7fc7063862c0 100644
--- a/drivers/gpu/drm/panel/panel-himax-hx8394.c
+++ b/drivers/gpu/drm/panel/panel-himax-hx8394.c
@@ -1025,7 +1025,7 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "mipi_dsi_attach failed\n");
 		drm_panel_remove(&ctx->panel);
@@ -1043,12 +1043,6 @@ static int hx8394_probe(struct mipi_dsi_device *dsi)
 static void hx8394_remove(struct mipi_dsi_device *dsi)
 {
 	struct hx8394 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "Failed to detach from DSI host: %d\n", ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
index 5610a225f77b..aadb13eb41e0 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9805.c
@@ -307,7 +307,7 @@ static int ili9805_dsi_probe(struct mipi_dsi_device *dsi)
 
 	drm_panel_add(&ctx->panel);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err(&dsi->dev, "mipi_dsi_attach failed: %d\n", ret);
 		drm_panel_remove(&ctx->panel);
@@ -320,13 +320,6 @@ static int ili9805_dsi_probe(struct mipi_dsi_device *dsi)
 static void ili9805_dsi_remove(struct mipi_dsi_device *dsi)
 {
 	struct ili9805 *ctx = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n",
-			ret);
-
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
index 0fb06c425545..a03a1b4411ad 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9806e-dsi.c
@@ -141,7 +141,7 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 	if (ret)
 		return ret;
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret < 0) {
 		dev_err_probe(dev, ret, "Failed to attach to DSI host\n");
 		ili9806e_remove(dev);
@@ -153,7 +153,6 @@ static int ili9806e_dsi_probe(struct mipi_dsi_device *dsi)
 
 static void ili9806e_dsi_remove(struct mipi_dsi_device *dsi)
 {
-	mipi_dsi_detach(dsi);
 	ili9806e_remove(&dsi->dev);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index 3abdd0870e83..ca7037a4242c 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -2597,14 +2597,12 @@ static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
 	dsi->format = MIPI_DSI_FMT_RGB888;
 	dsi->lanes = ctx->desc->lanes;
 
-	return mipi_dsi_attach(dsi);
+	return devm_mipi_dsi_attach(&dsi->dev, dsi);
 }
 
 static void ili9881c_dsi_remove(struct mipi_dsi_device *dsi)
 {
 	struct ili9881c *ctx = mipi_dsi_get_drvdata(dsi);
-
-	mipi_dsi_detach(dsi);
 	drm_panel_remove(&ctx->panel);
 }
 
diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
index 6d07fe901357..896de9460aa8 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9882t.c
@@ -844,7 +844,7 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
 
 	mipi_dsi_set_drvdata(dsi, ili);
 
-	ret = mipi_dsi_attach(dsi);
+	ret = devm_mipi_dsi_attach(&dsi->dev, dsi);
 	if (ret)
 		drm_panel_remove(&ili->base);
 
@@ -854,11 +854,6 @@ static int ili9882t_probe(struct mipi_dsi_device *dsi)
 static void ili9882t_remove(struct mipi_dsi_device *dsi)
 {
 	struct ili9882t *ili = mipi_dsi_get_drvdata(dsi);
-	int ret;
-
-	ret = mipi_dsi_detach(dsi);
-	if (ret < 0)
-		dev_err(&dsi->dev, "failed to detach from DSI host: %d\n", ret);
 
 	if (ili->base.dev)
 		drm_panel_remove(&ili->base);
-- 
2.43.0

