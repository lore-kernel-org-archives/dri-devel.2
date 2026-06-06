Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C64B7CD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 361AF112D0C;
	Sat,  6 Jun 2026 04:58:52 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WclfGwIx";
	dkim-atps=neutral
Received: from mail-ed1-f43.google.com (mail-ed1-f43.google.com
 [209.85.208.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 73A79112D0A
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:50 +0000 (UTC)
Received: by mail-ed1-f43.google.com with SMTP id
 4fb4d7f45d1cf-69165354c87so299056a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721929; x=1781326729; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=THaL1QVPpQgP2z5ftX+u3ovu7VRE23Z1E4qNugQA6t8=;
 b=WclfGwIxR00AFhP1a7jPqAG3LHU+7Ddq1uqK14Fh7IZDWSnWDL3LmSHsp2nAgTMyJg
 FH917gQENdd7uSVtSN0Dw86BKpga5vTKqvFADIkDms3a8idiNBsUeO28JbKpEwLE+8mg
 teIiYSV+8kqJuBU7mrZOxIGiZQcSGVMrA4KuGlfRWmNOJhP8wwbzGxjvMgL0zVyjq7OO
 A56yNqJAw4f/Z07HVCFJeESrW8yDwVgeo4EVTeH5XyiwYBwAqlZd4VzFrQrl5QcCM0Nu
 FTInjlX3l/MluQqEcwFJv3inQjrvriApn6xs/Ta8O7vADsv6dQgtyA/6axAVC+mVdRja
 eO5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721929; x=1781326729;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=THaL1QVPpQgP2z5ftX+u3ovu7VRE23Z1E4qNugQA6t8=;
 b=IMX5Zb72/df9m7vE93lajo4XhGsmoYzyVqGDnWN0VGhs2h7QXbtvT4QSxLw3qZ3fjO
 uVV9xbR9vlEok7vhuoNXmPuuAO1RdTlVkJh6zLWqy5X1pe7FPLe6ncASSMQvu8dbE2+l
 uyZGKja3ILt7EDcff/6FMFZAMPeIppLEGnCJHyPudHov5GCgtSbrZFOvk/IZySkChGV+
 nS6MsK8uzJ7YijpUwyX4h6gwABc6EktL44tAi+JFCGYYtS4aBg5SMiFBhrudhK9F3IwU
 JOoVoVC8E7pOQtPj2TVkpCmN43CRXbUfa7m8mJm54EZ0QWz5gAwRtk/SlthdPYINaiad
 YkCg==
X-Forwarded-Encrypted: i=1;
 AFNElJ/qWBva6R5JHk5pdwAE9oFZZtnSb34nhS52pIc5CBEiw30ksvxtuaOr38RJM1wEPRYif1opGByoiyk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzjUUQ2TUuX6LRCZqAJIpVdK0MnYJ6ey1IXX8u+keBAmfec3VOv
 bH0icpF36e8NkWMqNfSuTaAeBz/7aSjkhfq4SIuYwAAox5cI+3tkI1DF
X-Gm-Gg: Acq92OG6Iwh+PmtfxFIr/1wxzkOzMH1cqPy8HDLN7qMziZg7TknoOoHsu4BS6vPRRoQ
 TkVgBfw2k8u08KQiHjpmKAZmNOpWdUVHo8WWLRJVm+zSazcvN1FGiOw3nO6YHrtzvT1HX0aJSIB
 HrTZ9QEkE02zszwS5ssR3MHL9SsY6MemMJueGKrmDXw3nEo6vt1c1D+H6BlI4tXkjShFAsQz08f
 V0UbaulSgy/JavbqcBcN5dGR5YzEkj0Ctk1vhafUrOxBiIg4ayt/nbbnf6dvaA0tGZDaLH99gf2
 jZVYNP0kSa3HfXBaY/F3Rf2TBa6s54S9Ja++PNQtqt+aLsKfIntpSclT4Bq+uPX1M2F691yBMBU
 JVfo6Oh1iaBWq6Nhq1jTLVzpujHPIK1u3vUnYIntfiV+phW5OlGl4XetBbhyO+YoZi2taEbwJiW
 2mKcjXGclI38TcUpxN/IXPdU6hK1BdhOqe5w==
X-Received: by 2002:a17:907:608b:b0:bcb:66df:819a with SMTP id
 a640c23a62f3a-bf3741e8062mr385758166b.40.1780721928778; 
 Fri, 05 Jun 2026 21:58:48 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.45
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:47 -0700 (PDT)
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
Subject: [PATCH v4 14/14] video: leds: backlight: lm3533: Support getting LED
 sources from DT
Date: Sat,  6 Jun 2026 07:57:38 +0300
Message-ID: <20260606045738.21050-15-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260606045738.21050-1-clamor95@gmail.com>
References: <20260606045738.21050-1-clamor95@gmail.com>
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
 drivers/leds/leds-lm3533.c          | 58 ++++++++++++++++++++++++++++-
 drivers/video/backlight/lm3533_bl.c | 43 ++++++++++++++++++++-
 2 files changed, 99 insertions(+), 2 deletions(-)

diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index a661aedcdc60..fe3e01b265e1 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -27,6 +27,11 @@
 #define LM3533_ALS_CHANNEL_LV_MIN	1
 #define LM3533_ALS_CHANNEL_LV_MAX	2
 
+#define LM3533_REG_OUTPUT_CONF1			0x10
+#define   OUTPUT_CONF1_SHIFT			2
+#define   OUTPUT_LVLED_MASK			0x3
+#define LM3533_REG_OUTPUT_CONF2			0x11
+#define   OUTPUT_CONF2_SHIFT			6
 #define LM3533_REG_CTRLBANK_BCONF_BASE		0x1b
 #define LM3533_REG_PATTERN_ENABLE		0x28
 #define LM3533_REG_PATTERN_LOW_TIME_BASE	0x71
@@ -55,6 +60,9 @@ struct lm3533_led {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 leds[LM3533_LVCTRLBANK_MAX];
+
 	bool have_als;
 };
 
@@ -623,7 +631,35 @@ static const struct attribute_group *lm3533_led_attribute_groups[] = {
 
 static int lm3533_led_setup(struct lm3533_led *led)
 {
-	int ret;
+	u32 output_cfg_shift = 0;
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
+	int ret, i;
+
+	if (led->num_leds) {
+		for (i = 0; i < led->num_leds; i++) {
+			if (led->leds[i] >= LM3533_LVCTRLBANK_MAX)
+				continue;
+
+			output_cfg_shift = led->leds[i] * 2;
+			output_cfg_val |= led->id << output_cfg_shift;
+			output_cfg_mask |= OUTPUT_LVLED_MASK << output_cfg_shift;
+		}
+
+		/* LVLED1, LVLED2 and LVLED3 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask << OUTPUT_CONF1_SHIFT,
+					 output_cfg_val << OUTPUT_CONF1_SHIFT);
+		if (ret)
+			return ret;
+
+		/* LVLED4 and LVLED5 */
+		ret = regmap_update_bits(led->regmap, LM3533_REG_OUTPUT_CONF2,
+					 output_cfg_mask >> OUTPUT_CONF2_SHIFT,
+					 output_cfg_val >> OUTPUT_CONF2_SHIFT);
+		if (ret)
+			return ret;
+	}
 
 	ret = lm3533_ctrlbank_set_max_current(&led->cb, led->max_current);
 	if (ret)
@@ -700,6 +736,26 @@ static int lm3533_led_probe(struct platform_device *pdev)
 	led->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &led->pwm);
 
+	led->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (led->num_leds > LM3533_LVCTRLBANK_MAX) {
+		dev_err(&pdev->dev, "num of LED sources exceeds max %d: %d\n",
+			LM3533_LVCTRLBANK_MAX, led->num_leds);
+		goto err_deregister;
+	}
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default LVLED or is not linked to any LVLED at all.
+	 */
+	if (led->num_leds > 0) {
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
index 2aa4b86042ff..ed358fb3c759 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bits.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/mod_devicetable.h>
@@ -22,6 +23,7 @@
 #define LM3533_HVCTRLBANK_COUNT		2
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
+#define LM3533_REG_OUTPUT_CONF1		0x10
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
 #define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
 #define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
@@ -36,6 +38,9 @@ struct lm3533_bl {
 	u32 max_current;
 	u32 pwm;
 
+	int num_leds;
+	u32 led_strings[LM3533_HVCTRLBANK_COUNT];
+
 	bool have_als;
 	bool linear;
 };
@@ -232,13 +237,30 @@ static struct attribute_group lm3533_bl_attribute_group = {
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	int ret;
+	u32 output_cfg_val = 0;
+	u32 output_cfg_mask = 0;
+	int ret, i;
 
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
 				 CTRLBANK_AB_BCONF_MODE(ctrlbank), bl->linear);
 	if (ret)
 		return ret;
 
+	if (bl->num_leds) {
+		for (i = 0; i < bl->num_leds; i++) {
+			if (bl->led_strings[i] >= LM3533_HVCTRLBANK_COUNT)
+				continue;
+
+			output_cfg_val |= ctrlbank << bl->led_strings[i];
+			output_cfg_mask |= BIT(bl->led_strings[i]);
+		}
+
+		ret = regmap_update_bits(bl->regmap, LM3533_REG_OUTPUT_CONF1,
+					 output_cfg_mask, output_cfg_val);
+		if (ret)
+			return ret;
+	}
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -316,6 +338,25 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	bl->num_leds = device_property_count_u32(&pdev->dev, "led-sources");
+	if (bl->num_leds > LM3533_HVCTRLBANK_COUNT)
+		return dev_err_probe(&pdev->dev, bl->num_leds,
+				     "num of LED sources exceeds max %d\n",
+				     LM3533_HVCTRLBANK_COUNT);
+
+	/*
+	 * If led-sources property is not set then either this Control Bank uses
+	 * its default HVLED or is not linked to any HVLED at all.
+	 */
+	if (bl->num_leds > 0) {
+		ret = device_property_read_u32_array(&pdev->dev, "led-sources",
+						     bl->led_strings,
+						     bl->num_leds);
+		if (ret)
+			return dev_err_probe(&pdev->dev, ret,
+					     "failed to get led-sources\n");
+	}
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
 		return ret;
-- 
2.53.0

