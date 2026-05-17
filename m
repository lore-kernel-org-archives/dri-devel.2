Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8FCC8CD4F25
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 07:43:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E560C10E21C;
	Sun, 17 May 2026 07:43:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Dn5oFWuU";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F39B710E1B6
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 07:43:41 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-44a14580111so832314f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:43:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779003820; x=1779608620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=fIRirlk7+iVvv+aIkrP/TTxntKDqtRTgAMbNyHeeulc=;
 b=Dn5oFWuUeImgE2KO/EfSBdBGkD6gRv4g9hnOyEI340yRGvCDaGltyKdyaurRRMh9h5
 jy70+s4B/Xofad2VpA4Bd/w4emGw5f+SmuuyaiZ2m427v8FV/NkUkMm/yAkJmwAojXPN
 wdKoQKYB+k+XyfLGhy0K1/FDHHeh32k2g6/oz7FL1107vE/S5CnwhrW2ilZY+9GVeHUE
 BelBMlfrW/UM4/EA8uDuLtnnUcndgASH9X8ehK2Ti/Rd71U0ZrQH2I1SQjFLX71woMZ5
 PEz4X2AxL9AgTp1HCImGqj7/zgls9a+FGt6+bOzXTiCwPpCm6h4DeppOWh+tOrVz0qIB
 Z6gg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779003820; x=1779608620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=fIRirlk7+iVvv+aIkrP/TTxntKDqtRTgAMbNyHeeulc=;
 b=T3M59aI7cWOUEzEfYt/u/D+RflHhkZQNDg4iC+30oldqFGeaSxUVmWvqrve5n8Oj3F
 sjjQbAPK6cZoju0k+YkSRomAhRLgzPefMLTXWzgrUT/CvNfNpNgUG1wlbYffvNF01jO0
 S/xnWt1z5tnFRBXzVMvXdC1n58XjPSmWykCFvb6ikid4FYa9ShfWDLSa/exKDU7vtiYG
 dubyg50/DoCLXK1ZQOoP2p5aAxZ87KRJqLfoCjn2a+V9XHJ6i5rNkq31L38GOWGdB6LQ
 spYFWyduR0gNOTVebcNtGOPJ/EZM+B+USZJ0auEOB4FggZG/sPtRTrA53plZKts/OMc5
 POeQ==
X-Gm-Message-State: AOJu0YyY9Id3gX4SeRHbufVYAl8R0SLaaKs/VzLNVc51wKwKtQizhB7F
 SpICV035aY0N2qXZ5gvp4ndiyVWpOyOzRV3AKogOdnjy4Uu7P+sHSb49
X-Gm-Gg: Acq92OHc6aiwRVHsWYnDcOIJaTh6TxoefCUFmuTnK3xmNZc3Me6yw/BlxpRcjHZBi7J
 G05TuEwOAeqmnxeUfgXjaBJd/A5U7q9bn6vcnJsNiFIrgRlbNh5TSjXsbt71dHsKVcH117Or5J3
 eZxeJ9hfFVL55Mv4OaIaYVGuqwQGuDC27kN9qgRXTOSoV1jTNJV9hRuZoy3O9qdTokyECV2HgiE
 N8pUnISGPT+fi2ecljsJHRnbze3/nn5SD9B+wPjYGAKofvRv5c3g3+QPYkfxD5694SOBIjhaq60
 xeL4lN+ESqhrFE98dDppku87T81DrUrsST+o6PEhymYUuUXgIbIPKjUnGmQ7CxoQ3j1bDHK/wwE
 dO/ywh6GnoG5taIhQ52zcbimkAGvKJHRNs2cZRAIbkA4zoImlUfdAxmS3p0UVonn3HcYvq0mXZ1
 uqqPZs0WYHZ+1Z
X-Received: by 2002:a05:6000:22c5:b0:43d:7d24:b510 with SMTP id
 ffacd0b85a97d-45e5c5fd8demr15790172f8f.22.1779003820408; 
 Sun, 17 May 2026 00:43:40 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 00:43:39 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v1 6/6] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Date: Sun, 17 May 2026 10:43:06 +0300
Message-ID: <20260517074306.30937-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
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

Add Control Bank to HVLED/LVLED muxing support based on the led-sources
defined in the device tree.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/leds/leds-lm3533.c          | 55 +++++++++++++++++++++++++++--
 drivers/video/backlight/lm3533_bl.c | 39 +++++++++++++++++++-
 2 files changed, 91 insertions(+), 3 deletions(-)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index f6345bc1f443..c4eaf30880a1 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/leds.h>
 #include <linux/mfd/core.h>
@@ -26,6 +27,12 @@
 #define LM3533_ALS_CHANNEL_LV_MIN	1
 #define LM3533_ALS_CHANNEL_LV_MAX	2
 
+#define LM3533_REG_OUTPUT_CONF1			0x10
+#define   OUTPUT_CONF1_MASK			GENMASK(7, 2)
+#define   OUTPUT_CONF1_SHIFT			2
+#define LM3533_REG_OUTPUT_CONF2			0x11
+#define   OUTPUT_CONF2_MASK			GENMASK(3, 0)
+#define   OUTPUT_CONF2_SHIFT			6
 #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
 #define LM3533_REG_PATTERN_ENABLE		0x28
 #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
@@ -40,7 +47,7 @@
 #define LM3533_REG_CTRLBANK_BCONF_ALS_CHANNEL_MASK	0x01
 
 #define LM3533_LED_FLAG_PATTERN_ENABLE		1
-
+#define LM3533_MAX_LEDS				5
 
 struct lm3533_led {
 	struct lm3533 *lm3533;
@@ -53,6 +60,9 @@ struct lm3533_led {
 
 	u32 max_current;
 	u32 pwm;
+
+	u32 num_leds;
+	u32 leds[LM3533_MAX_LEDS];
 };
 
 
@@ -639,7 +649,30 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
 static int lm3533_led_setup(struct lm3533_led *led)
 {
-	int ret;
+	u32 output_cfg_shift = 0;
+	u32 output_cfg_val = 0;
+	int ret, i;
+
+	if (led->num_leds) {
+		for (i = 0; i < led->num_leds; i++) {
+			output_cfg_shift = led->leds[i] * 2;
+			output_cfg_val |= led->id << output_cfg_shift;
+		}
+
+		/* LVLED1, LVLED2 and LVLED3 */
+		ret = lm3533_update(led->lm3533, LM3533_REG_OUTPUT_CONF1,
+				    output_cfg_val << OUTPUT_CONF1_SHIFT,
+				    OUTPUT_CONF1_MASK);
+		if (ret)
+			return ret;
+
+		/* LVLED4 and LVLED5 */
+		ret = lm3533_update(led->lm3533, LM3533_REG_OUTPUT_CONF1,
+				    output_cfg_val >> OUTPUT_CONF2_SHIFT,
+				    OUTPUT_CONF2_MASK);
+		if (ret)
+			return ret;
+	}
 
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
@@ -713,6 +746,24 @@ static int lm3533_led_probe(struct platform_device *pdev)
 	led->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
 
+	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default LVLED or is not linked to any LVLED at all.
+	 */
+	if (led->num_leds <= 0 || led->num_leds > LM3533_MAX_LEDS)
+		led->num_leds = 0;
+
+	if (led->num_leds > 0 && led->num_leds < LM3533_MAX_LEDS) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     led->leds, led->num_leds);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get led-sources\n");
+			goto err_deregister;
+		}
+	}
+
 	ret = lm3533_led_setup(led);
 	if (ret)
 		goto err_deregister;
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index be9114b7e0ad..2898cb229643 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
@@ -21,9 +22,12 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
+#define   OUTPUT_CONF1_MASK		GENMASK(1, 0)
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
+#define LM3533_MAX_LED_STRINGS		2
 
 struct lm3533_bl {
 	struct lm3533 *lm3533;
@@ -34,6 +38,9 @@ struct lm3533_bl {
 	u32 max_current;
 	u32 pwm;
 	bool linear;
+
+	u32 num_leds;
+	u32 led_strings[LM3533_MAX_LED_STRINGS];
 };
 
 
@@ -248,7 +255,8 @@ static struct attribute_group lm3533_bl_attribute_group = {
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
 	int id = lm3533_bl_get_ctrlbank_id(bl);
-	int ret;
+	u32 output_cfg_val = 0;
+	int ret, i;
 
 	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
 			    bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
@@ -256,6 +264,16 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
 	if (ret)
 		return ret;
 
+	if (bl->num_leds) {
+		for (i = 0; i < bl->num_leds; i++)
+			output_cfg_val |= id << bl->led_strings[i];
+
+		ret = lm3533_update(bl->lm3533, LM3533_REG_OUTPUT_CONF1,
+				    output_cfg_val, OUTPUT_CONF1_MASK);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -337,6 +355,25 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
 
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	if (bl->num_leds <= 0 || bl->num_leds > LM3533_MAX_LED_STRINGS)
+		bl->num_leds = 0;
+
+	if (bl->num_leds > 0 && bl->num_leds < LM3533_MAX_LED_STRINGS) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     bl->led_strings,
+						     bl->num_leds);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get led-sources\n");
+			goto err_sysfs_remove;
+		}
+	}
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		goto err_sysfs_remove;
-- 
2.51.0

