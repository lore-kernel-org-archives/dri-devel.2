Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B131C606D828
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 14:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20260707 header.b=HEL9c+nH
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86EEA10F3D2;
	Thu,  5 Nov 2026 14:06:02 +0000 (UTC)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com
 [209.85.221.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4735E10EB89
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 14:05:54 +0000 (UTC)
Received: by mail-wr1-f41.google.com with SMTP id
 ffacd0b85a97d-48dfdd0678dso1550811f8f.0
 for <dri-devel@lists.freedesktop.org>; Thu, 05 Nov 2026 06:05:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20260707; t=1793887553; x=1794492353; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=xGkKWgS0NbCDY+LYXrxAJx4PERN2uXgRauM87oEmlok=;
 b=HEL9c+nHmzjpDWm0SQF9xbiPY6PdkBN9qEzTr8deKHKpUcO6VKKePkKsAonx54ATem
 vWzzcy0QkqzF8T+hVWJXenuRzyLD7ZJVSufFqaQm+W/GdDR/ekxKcSG1lbGNoWUQnoBV
 LM0iWNi33znH+w1lE8FhgkhaCPMlxUpxypn6npZTRlYazl+L7Vkkn6SstSvgCRy4HSAF
 Th1MCZZb8jabNZaNmXdgHVHZbgdHCGsOVpzLRfslOUgI9DDxmF006K2P3lP2YRqArKVW
 eIDytBKFiVLP3B5Enk7iZdWv+iMocB5grc59dS757jb4FygZJ5Y/CW0W6unYqsy+Sbbq
 Y5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1793887553; x=1794492353;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=xGkKWgS0NbCDY+LYXrxAJx4PERN2uXgRauM87oEmlok=;
 b=qViy6XnyHdiE2ohmuaLsMtGVtAhf5IzI0PWuAR3sKi1Sgv7ffD1MKWbBzTjPwVwKFi
 ZCHGQ3C35bXwBKe+lT78j7nTQJ7+BC8IxTAui121spJNFZGtCQRkQO5tq51Oq7DUN2OK
 IzzXitg4jguho0ZNsSHcM5bItp0vO469RmTTu0Ijj85WaaRUBoYIc3gptNb/EASriAJH
 Rba2v63fshgwg6bT5PHM58LfWXr1tqjJawAL7gV3U/qkJgdCCderTzbWWT9lY0q3MMvK
 ycu/ZhmTko/aW/Pj62mF3CSSs5/qD4BFiP33dnyIyASyNYk5NiMxa+Y9kFUkhaVq5wZg
 FrAg==
X-Gm-Message-State: APuU4Z8/eNhJ2Hey6uzItf0FOg0rGWvLNuo3zh80EDl4pM2on4u3yd/e
 mFCcoZKLVzkFQn9iraUWH72csdEgW1o4RaWuEJjk6p2FDaOxK46gXM5i
X-Gm-Gg: AYBFou1Feif7swljo8CLBTJwH5Et1hmqZc+AGeJY6gn145cx9AJpYKhOD0Ahj3rou6D
 H2iFlsMq+DuLkMqkzdJQJcsMDoURqvbFGQsSeFEfb0FNAiitYYTFLwn/0+B1VRrMXcECQq7qs1g
 j+L4WbF2ICQ8B55ByvQar/YLq8EbB9A0YJc974SDsXLdhNRNBjyiqvVaetSzAJlSHZomttAkhzZ
 fLyccOlgKI40rg7oM0ti4IrlRyDkn8nLxI7DLveH7lMa3XciKJJd7Le16RnGDZklWWxZhxbFljg
 LcR8Hw2jxwT6LO9jpher+/96tTLukhSPmDqeF+4VBrGXynfCy5CdubjifzhPkT/vc6iDRMZ3IbN
 dvYR4DmSfByp5BQQu83dZoQJuk0+BCk22iWCA2rHNgy7dlbp4+6AeQpRZlWPQvooiqKKTWtXM2/
 o+8LKc8C8TT9L2mq7p25rtHumMtu8cCXw8DIUuDULkZK19qba3iuwjBmaanmfD16LUWUHOkuatR
 FeLIApt581lT70myQd3sOCk2rEK1vcph4onlOHmxUlcLLmw3viMc3N2AgbxpNGEU4wlpJwV52Ze
 XHUC+1AURCnP+p4F777r4TlHoOCQPqTlNMSpFEQ9s7ez1mQJ/A==
X-Received: by 2002:a05:6000:250a:b0:48e:c84:5be6 with SMTP id
 ffacd0b85a97d-48e6e303c68mr44365081f8f.14.1793887552507; 
 Thu, 05 Nov 2026 06:05:52 -0800 (PST)
Received: from xeon ([188.163.112.62]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48fed92a753sm11454111f8f.45.2026.11.05.06.05.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 05 Nov 2026 06:05:51 -0800 (PST)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Thierry Reding <thierry.reding@kernel.org>,
 Jonathan Hunter <jonathanh@nvidia.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Jessica Zhang <jesszhan0024@gmail.com>,
 Mikko Perttunen <mperttunen@nvidia.com>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-tegra@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 03/10] drm/panel: Convert LG LH400WV3-SD04 to use MIPI DBI
 bus
Date: Thu,  5 Nov 2026 16:05:03 +0200
Message-ID: <20261105140510.165165-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261105140510.165165-1-clamor95@gmail.com>
References: <20261105140510.165165-1-clamor95@gmail.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

Switch from a generic platform driver to a dedicated MIPI DBI driver.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/gpu/drm/panel/panel-lg-lh400wv3.c | 103 ++++++++++------------
 1 file changed, 46 insertions(+), 57 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
index 557bcb6f2ca70..ed099f671471e 100644
--- a/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
+++ b/drivers/gpu/drm/panel/panel-lg-lh400wv3.c
@@ -14,6 +14,7 @@
 #include <video/mipi_display.h>
 
 #include <drm/drm_mipi_dbi.h>
+#include <drm/drm_mipi_dbi_bus.h>
 #include <drm/drm_modes.h>
 #include <drm/drm_of.h>
 #include <drm/drm_panel.h>
@@ -25,7 +26,7 @@ static const struct regulator_bulk_data lg_lh400wv3_supplies[] = {
 
 struct lg_lh400wv3 {
 	struct drm_panel panel;
-	struct mipi_dbi *dbi;
+	struct mipi_dbi_device *dbi;
 
 	struct regulator_bulk_data *supplies;
 	struct gpio_desc *reset_gpio;
@@ -36,13 +37,12 @@ static inline struct lg_lh400wv3 *to_lg_lh400wv3(struct drm_panel *panel)
 	return container_of(panel, struct lg_lh400wv3, panel);
 }
 
-#define panel_dbi_command(priv, cmd, seq...) \
+#define panel_dbi_command(dbidev, cmd, seq...) \
 ({ \
 	const u8 d[] = { seq }; \
-	struct drm_panel *panel = &(priv)->panel; \
-	struct device *dev = panel->dev; \
+	struct device *dev = &(dbidev)->dev; \
 	int ret; \
-	ret = mipi_dbi_command_stackbuf((priv)->dbi, cmd, d, ARRAY_SIZE(d)); \
+	ret = mipi_dbi_command_stackbuf((dbidev)->dbi, cmd, d, ARRAY_SIZE(d)); \
 	if (ret) \
 		dev_err_ratelimited(dev, "error %d when sending command %#02x\n", ret, cmd); \
 	ret; \
@@ -54,10 +54,6 @@ static int lg_lh400wv3_prepare(struct drm_panel *panel)
 	struct device *dev = panel->dev;
 	int ret;
 
-	priv->dbi = dev_get_drvdata(dev->parent);
-	if (!priv->dbi)
-		return -ENODEV;
-
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 
 	ret = regulator_bulk_enable(ARRAY_SIZE(lg_lh400wv3_supplies), priv->supplies);
@@ -79,62 +75,55 @@ static int lg_lh400wv3_enable(struct drm_panel *panel)
 {
 	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
 
-	panel_dbi_command(priv, MIPI_DCS_EXIT_INVERT_MODE);
-	panel_dbi_command(priv, MIPI_DCS_SET_TEAR_ON);
+	panel_dbi_command(priv->dbi, MIPI_DCS_EXIT_INVERT_MODE);
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_TEAR_ON);
 
-	panel_dbi_command(priv, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT |
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_PIXEL_FORMAT, MIPI_DCS_PIXEL_FMT_24BIT |
 			  MIPI_DCS_PIXEL_FMT_24BIT << 4);
 
-	panel_dbi_command(priv, 0xb2, 0x00, 0xc8);
-	panel_dbi_command(priv, 0xb3, 0x00);
-	panel_dbi_command(priv, 0xb4, 0x04);
-	panel_dbi_command(priv, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
-	panel_dbi_command(priv, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
-	panel_dbi_command(priv, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
-
-	panel_dbi_command(priv, 0xc0, 0x01, 0x11);
-	panel_dbi_command(priv, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
-	panel_dbi_command(priv, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
-	panel_dbi_command(priv, 0xc5, 0x65);
-	panel_dbi_command(priv, 0xc6, 0x41, 0x63);
-
-	panel_dbi_command(priv, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
-	panel_dbi_command(priv, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
-
-	panel_dbi_command(priv, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
-	panel_dbi_command(priv, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
-
-	panel_dbi_command(priv, MIPI_DCS_EXIT_SLEEP_MODE);
+	panel_dbi_command(priv->dbi, 0xb2, 0x00, 0xc8);
+	panel_dbi_command(priv->dbi, 0xb3, 0x00);
+	panel_dbi_command(priv->dbi, 0xb4, 0x04);
+	panel_dbi_command(priv->dbi, 0xb5, 0x42, 0x10, 0x10, 0x00, 0x20);
+	panel_dbi_command(priv->dbi, 0xb6, 0x0b, 0x0f, 0x3c, 0x13, 0x13, 0xe8);
+	panel_dbi_command(priv->dbi, 0xb7, 0x4c, 0x06, 0x0c, 0x00, 0x00);
+
+	panel_dbi_command(priv->dbi, 0xc0, 0x01, 0x11);
+	panel_dbi_command(priv->dbi, 0xc3, 0x07, 0x03, 0x04, 0x04, 0x04);
+	panel_dbi_command(priv->dbi, 0xc4, 0x12, 0x24, 0x18, 0x18, 0x02, 0x49);
+	panel_dbi_command(priv->dbi, 0xc5, 0x65);
+	panel_dbi_command(priv->dbi, 0xc6, 0x41, 0x63);
+
+	panel_dbi_command(priv->dbi, 0xd0, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv->dbi, 0xd1, 0x00, 0x46, 0x74, 0x32, 0x1d, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv->dbi, 0xd2, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv->dbi, 0xd3, 0x00, 0x46, 0x74, 0x32, 0x1f, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv->dbi, 0xd4, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+	panel_dbi_command(priv->dbi, 0xd5, 0x01, 0x46, 0x74, 0x25, 0x00, 0x03, 0x51, 0x15, 0x04);
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_COLUMN_ADDRESS, 0x00, 0x00, 0x01, 0xdf);
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_PAGE_ADDRESS, 0x00, 0x00, 0x03, 0x1f);
+
+	panel_dbi_command(priv->dbi, MIPI_DCS_EXIT_SLEEP_MODE);
 	msleep(120);
 
-	panel_dbi_command(priv, MIPI_DCS_WRITE_MEMORY_START);
-	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_ON);
+	panel_dbi_command(priv->dbi, MIPI_DCS_WRITE_MEMORY_START);
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_DISPLAY_ON);
 
 	return 0;
 }
 
-static int lg_lh400wv3_disable(struct drm_panel *panel)
+static int lg_lh400wv3_unprepare(struct drm_panel *panel)
 {
 	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
 
-	panel_dbi_command(priv, MIPI_DCS_SET_DISPLAY_OFF);
-	panel_dbi_command(priv, MIPI_DCS_ENTER_SLEEP_MODE);
+	panel_dbi_command(priv->dbi, MIPI_DCS_SET_DISPLAY_OFF);
+	panel_dbi_command(priv->dbi, MIPI_DCS_ENTER_SLEEP_MODE);
 	msleep(150);
 
-	panel_dbi_command(priv, 0xc1, 0x01);
+	panel_dbi_command(priv->dbi, 0xc1, 0x01);
 	usleep_range(10000, 11000);
 
-	return 0;
-};
-
-static int lg_lh400wv3_unprepare(struct drm_panel *panel)
-{
-	struct lg_lh400wv3 *priv = to_lg_lh400wv3(panel);
-
 	gpiod_set_value_cansleep(priv->reset_gpio, 1);
 	regulator_bulk_disable(ARRAY_SIZE(lg_lh400wv3_supplies), priv->supplies);
 
@@ -177,14 +166,13 @@ static int lg_lh400wv3_get_modes(struct drm_panel *panel,
 static const struct drm_panel_funcs lg_lh400wv3_panel_funcs = {
 	.prepare = lg_lh400wv3_prepare,
 	.enable = lg_lh400wv3_enable,
-	.disable = lg_lh400wv3_disable,
 	.unprepare = lg_lh400wv3_unprepare,
 	.get_modes = lg_lh400wv3_get_modes,
 };
 
-static int lg_lh400wv3_probe(struct platform_device *pdev)
+static int lg_lh400wv3_probe(struct mipi_dbi_device *dbi)
 {
-	struct device *dev = &pdev->dev;
+	struct device *dev = &dbi->dev;
 	struct lg_lh400wv3 *priv;
 	int ret;
 
@@ -203,6 +191,9 @@ static int lg_lh400wv3_probe(struct platform_device *pdev)
 		return dev_err_probe(dev, PTR_ERR(priv->reset_gpio),
 				     "Failed to get reset gpio\n");
 
+	priv->dbi = dbi;
+	mipi_dbi_set_drvdata(dbi, priv);
+
 	ret = drm_panel_of_backlight(&priv->panel);
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to get backlight\n");
@@ -211,9 +202,7 @@ static int lg_lh400wv3_probe(struct platform_device *pdev)
 	if (ret)
 		return dev_err_probe(dev, ret, "Failed to add panel\n");
 
-	platform_set_drvdata(pdev, priv);
-
-	return 0;
+	return devm_mipi_dbi_attach(dev, dbi);
 }
 
 static const struct of_device_id lg_lh400wv3_of_match[] = {
@@ -222,14 +211,14 @@ static const struct of_device_id lg_lh400wv3_of_match[] = {
 };
 MODULE_DEVICE_TABLE(of, lg_lh400wv3_of_match);
 
-static struct platform_driver lg_lh400wv3_driver = {
+static struct mipi_dbi_driver lg_lh400wv3_driver = {
 	.driver = {
 		.name = "panel-lg-lh400wv3",
 		.of_match_table = lg_lh400wv3_of_match,
 	},
 	.probe = lg_lh400wv3_probe,
 };
-module_platform_driver(lg_lh400wv3_driver);
+module_mipi_dbi_driver(lg_lh400wv3_driver);
 
 MODULE_AUTHOR("Svyatoslav Ryhel <clamor95@gmail.com>");
 MODULE_DESCRIPTION("LG LH400WV3-SD04 MIPI DBI Type B panel driver");
-- 
2.53.0

