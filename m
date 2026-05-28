Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 11206CD6E49
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:52:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1F5A310F1E7;
	Thu, 28 May 2026 13:52:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RgPnOrG/";
	dkim-atps=neutral
Received: from mail-ed1-f46.google.com (mail-ed1-f46.google.com
 [209.85.208.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D1ABF10F1E6
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:51:59 +0000 (UTC)
Received: by mail-ed1-f46.google.com with SMTP id
 4fb4d7f45d1cf-68707d88626so3857163a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:51:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779976318; x=1780581118; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=/VF1wrmilBUlbim8sdlHkjNWy4s/JRLxuueYjCB0tac=;
 b=RgPnOrG/r94pLYlFDtVnfdCygFpDjxZmz50YwLXoxXTQR9/un9io1KvjYNldJt6AMc
 YWxBJeEg3Cj3IvV24lmqJwQbxqoMQ4qGwHRbIrP8p1gl4+t5WuEYNTHlTGWup9vfm9NV
 c8fngAwa2QnfTrlVQBQN0btlQC5Ps4FaPYVrgh4eZ20o1OCf8mf1qMu13RS/tGlKrc63
 5VmP9aPnv8uHq37GvtzfD8tWpuHyy8VLf4IH1qIw0Ap481q3e6TLuCiVtZqtYuBEZrMM
 BTjyKxN36u77fkoE+QtpmwnBDdGD3+8onbPt6rMyauJ8ZcuR6R1PWafFn2kfM1v45cZI
 lBgg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976318; x=1780581118;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=/VF1wrmilBUlbim8sdlHkjNWy4s/JRLxuueYjCB0tac=;
 b=JTHJ87sGRuakqfKIe8O4Cf4WDyHFOLsRwlr72orSkuX50E0j5OKcQ2EyiPuFzOzXys
 4jWUs9lzonP8TLrqKveFNCdm+c2NkXuSom4Q2tB2eD1Jljh2yEXWXgw/5nf8HCKoS9Cy
 8FKEZ9EQlrYbEwEGzn3upw8TRF/qWdGwfmUgrq2QR0k9pOhgIzCKJ7cTIvbHH4GRDcQs
 vGGJH8BfziW8Kqp1UJjC99etlA9sfvgJmDe9LKrqt/dlMbimfayrGqtaq4F2PeQ/GfFL
 OS0WKA/FCNADnRrJUiRlK5MX1Q6eu7qShZN5t/uEWu1ZrYyB+sdJZ8iMHFXuyOJ94nxL
 kqpw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/B7GViT8uyt9lOfhvaMQbr5p2hDXcGfA4AiEn71wbhNRKA4hxryrEGBJ31FesdRuwbLlyGHg4gasM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxuvMoz8u9Dp3HKnsP19x5K4Z9R2KdJp8kgWEj66sMfGcrzYdTr
 zkgmh5ewwY+mUtMdoWy+KZwTBIdIAeMwGbiB4JV3KfMacRyCeLz6ylub
X-Gm-Gg: Acq92OHt8k2Ai4X0qMUk+S9W8IotJWff/xtRn0WMkvrMAmEA3GY+sDDFa3Pih1VblzG
 YJLWBaMYKgHQMybjxXIsKEj+ht/J9nwja79yvLN+FFqo07TyCRSeDiqlGAT3Oo4CjlZXy37DAy7
 caXYoN6hH0ANK7faB+gX7V3jSwTGfh40HhelXbnLa9NrHbFXacBj9gF8O8LrDUn3/WjOb402e4k
 i20u2pkRkN42JlT5GL044p4tnz2sSrcueg7NpjGChT/Hl/L/oYX5BFcbebEdQ9fOIeiQLAG+Ok/
 t1p44Z0wy+uPiMkYK9NLKH5x2IFyE6Fz5PWqLn8fvifa+VBKGzSuDXyep/b44J/jIPQDy6vaAic
 Q/xBkaoc1o/SwO/LyeK5nltnKZKSUUpE6MqbHl+fI6XRhiWGQR7Jbl4tDjmMttNY7eArNQGw6zE
 Sa6STIkjp38ophv9V4LkgBfaw=
X-Received: by 2002:a17:907:d10:b0:bd1:4da0:b0d5 with SMTP id
 a640c23a62f3a-bdd2360369fmr1692341766b.17.1779976318068; 
 Thu, 28 May 2026 06:51:58 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:51:57 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: Johan Hovold <johan@kernel.org>, dri-devel@lists.freedesktop.org,
 linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
 linux-fbdev@vger.kernel.org
Subject: [PATCH v2 6/6] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Date: Thu, 28 May 2026 16:51:23 +0300
Message-ID: <20260528135123.103745-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260528135123.103745-1-clamor95@gmail.com>
References: <20260528135123.103745-1-clamor95@gmail.com>
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
 drivers/leds/leds-lm3533.c          | 55 ++++++++++++++++++++++++++++-
 drivers/video/backlight/lm3533_bl.c | 37 ++++++++++++++++++-
 2 files changed, 90 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index d707d43d5526..07390bba9a48 100644
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
@@ -53,6 +60,9 @@ struct lm3533_led {
 
 	u32 max_current;
 	u32 pwm;
+
+	int num_leds;
+	u32 leds[LM3533_LVCTRLBANK_MAX];
 };
 
 
@@ -639,7 +649,33 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
 static int lm3533_led_setup(struct lm3533_led *led)
 {
-	int ret;
+	u32 output_cfg_shift = 0;
+	u32 output_cfg_val = 0;
+	int ret, i;
+
+	if (led->num_leds) {
+		for (i = 0; i < led->num_leds; i++) {
+			if (led->leds[i] > LM3533_LVCTRLBANK_MAX)
+				continue;
+
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
+		ret = lm3533_update(led->lm3533, LM3533_REG_OUTPUT_CONF2,
+				    output_cfg_val >> OUTPUT_CONF2_SHIFT,
+				    OUTPUT_CONF2_MASK);
+		if (ret)
+			return ret;
+	}
 
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
@@ -714,6 +750,23 @@ static int lm3533_led_probe(struct platform_device *pdev)
 	led->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
 
+	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default LVLED or is not linked to any LVLED at all.
+	 */
+	if (led->num_leds > 0 && led->num_leds <= LM3533_LVCTRLBANK_MAX) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     led->leds, led->num_leds);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get led-sources\n");
+			goto err_deregister;
+		}
+	} else {
+		led->num_leds = 0;
+	}
+
 	ret = lm3533_led_setup(led);
 	if (ret)
 		goto err_deregister;
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index c03d0d1667e4..82b46a531dd2 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
@@ -21,6 +22,8 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
+#define   OUTPUT_CONF1_MASK		GENMASK(1, 0)
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
@@ -34,6 +37,9 @@ struct lm3533_bl {
 	u32 max_current;
 	u32 pwm;
 	bool linear;
+
+	u32 num_leds;
+	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
 };
 
 
@@ -248,7 +254,8 @@ static struct attribute_group lm3533_bl_attribute_group = {
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
 	int id = lm3533_bl_get_ctrlbank_id(bl);
-	int ret;
+	u32 output_cfg_val = 0;
+	int ret, i;
 
 	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
 			    bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
@@ -256,6 +263,16 @@ static int lm3533_bl_setup(struct lm3533_bl *bl)
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
@@ -329,6 +346,24 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
 
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	if (bl->num_leds > 0 && bl->num_leds <= LM3533_HVCTRLBANK_COUNT) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     bl->led_strings,
+						     bl->num_leds);
+		if (ret) {
+			dev_err(&pdev->dev, "failed to get led-sources\n");
+			goto err_sysfs_remove;
+		}
+	} else {
+		bl->num_leds = 0;
+	}
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		return ret;
-- 
2.51.0

