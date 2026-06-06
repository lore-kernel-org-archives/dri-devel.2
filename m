Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1DAB6CD6E75
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4DCD9112CFD;
	Sat,  6 Jun 2026 04:58:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sBYTpGGF";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 34AC6112CFD
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:17 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-beb8a08a6c8so370072966b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721896; x=1781326696; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BMd8HY6ukZyI1ZnTN3O/lqGKIC/cU33GiiGHTNdAXMs=;
 b=sBYTpGGFiOTcITS3cxvry997TrwLQUm3OpMbEyCIm+ZSy4nRWm7nTRl7jACtMWs3/r
 wo6wmlB+DYTcenqh2OqkcoEwJn1RYV7646y3ArF3NJKjIkub0FRkTrSaa2QXWKNnwopO
 P09+y58tLsm8cUgIHiQ94tq30urH2mIy6XCvuXmT9CMFFmZqaU0GsUF5pCrheVkccq8a
 kPFUpFjEVywcEtrUFJtDdzcTmgPWldHHAVTwCanZ/9qe/suOp579eNVU+QTecYbiTT/X
 C9SBqXZ+cfxztWMdB4ebZaMWzOf5+ENnTTIYiJOa1Q/mnOUcRbhwlPnMPPXCx1zOdNCe
 CH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721896; x=1781326696;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BMd8HY6ukZyI1ZnTN3O/lqGKIC/cU33GiiGHTNdAXMs=;
 b=nIozyMtyVYGW6eQ0mAILKaRXRuIcQHnEJIv8Y4maZsdOofMxSHXtmwin96MPtPWPpM
 PJ2Cg0H02GnLxyS5PkAtfW+iveqMKuZnYvX6FpnFV/KQfOqr8sSJum+s6HX1Z3Um+VLM
 7XkAXtnFJbJPgLMnhjAl8Qu+TydO+IGQRj6WCuk0W1FuKWSXSDPb8mld1AqrVrK1C1Mj
 dT1lnuFDXN3wPYGPQ4qHWgE/U3piHZO5ZbZITotxwToNgs9hCLU+3vg0OwzKkEqtKEsm
 DPKMUIyiHXNbyoPjSXA5+9aJjV9lpOwigMtFc9URUmboyusKeHNScQfI3gxjxOed+DKL
 g77Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ+WXCBFMJz1PSCBpxbpsBwJb7Hhbi0U3P1lwBWHcGvFaJ9euwIB+bf+NJ69aKydtCcKS5/lfOfHzZc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy+v7bkyehC9i/78uvn5zdEgKzcT10JWBLYnCBv26j149jt/mP+
 Zcp8WG1VlKaV6NrpahwUATMytDbqeyv/YmwQTreW547XIsDlAFWpgcr3
X-Gm-Gg: Acq92OHhpKkuwzqPvX6w9ePpb3qif+ZzozKQNmEQkSqlPeFi9ESZrtJT+EZJH+eV3wB
 8XZUa7k2TSDlOt1R/qM/YYRurZQPIFfCkRzzhg5RDMx80NAEF4+Tl4p43oLRSUUgWDxc1TbAUCL
 oKJOm4C6sIQqP8R6XHBnhFEye8W2Yqkjg4f4QEzxKV0uFGoZf87fs2O2xJt7Z/mAUWkNCnCeS+f
 mQgx+SGz/ssDaV8Vg1R6VSAhTLM3qB5K97HkDVr9dYhJ2IW+h4bblXqSNGqJlH6s4i0ljCNQwXg
 XTrFO+8/khF56PT+/s4VXqDj3KjzkxAWnasHOGHCT5I/LOjoTQLBNkCDe2YDmXuDfaw0wsYuoi1
 J1BT6QvbGki2ugYC1YjfqOwYx/0GJn+Kqo4ab08kSpRJL4ctzSinHs4HV/KK5HWlJA+hqesOB66
 riSg/k6ShJw+O6s60x0HfmmHA=
X-Received: by 2002:a17:907:6e9f:b0:beb:7979:47dd with SMTP id
 a640c23a62f3a-bf3738f1f81mr401214366b.27.1780721895503; 
 Fri, 05 Jun 2026 21:58:15 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.12
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:14 -0700 (PDT)
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
Subject: [PATCH v4 04/14] mfd: lm3533: Pass only regmap and light sensor
 presence to child devices
Date: Sat,  6 Jun 2026 07:57:28 +0300
Message-ID: <20260606045738.21050-5-clamor95@gmail.com>
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

Instead of passing the entire lm3533 core data structure, only pass the
regmap and the light sensor presence flag to child devices.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c      | 32 ++++++++++++++---------------
 drivers/leds/leds-lm3533.c          | 32 ++++++++++++++++-------------
 drivers/mfd/lm3533-ctrlbank.c       | 14 ++++++-------
 drivers/video/backlight/lm3533_bl.c | 19 +++++++++--------
 include/linux/mfd/lm3533.h          |  2 +-
 5 files changed, 53 insertions(+), 46 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index 44b104c2d77f..a9af8e2b965f 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -49,7 +49,7 @@
 
 
 struct lm3533_als {
-	struct lm3533 *lm3533;
+	struct regmap *regmap;
 	struct platform_device *pdev;
 
 	unsigned long flags;
@@ -73,7 +73,7 @@ static int lm3533_als_get_adc(struct iio_dev *indio_dev, bool average,
 	else
 		reg = LM3533_REG_ALS_READ_ADC_RAW;
 
-	ret = regmap_read(als->lm3533->regmap, reg, &val);
+	ret = regmap_read(als->regmap, reg, &val);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to read adc\n");
 		return ret;
@@ -90,7 +90,7 @@ static int _lm3533_als_get_zone(struct iio_dev *indio_dev, u8 *zone)
 	u32 val;
 	int ret;
 
-	ret = regmap_read(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO, &val);
+	ret = regmap_read(als->regmap, LM3533_REG_ALS_ZONE_INFO, &val);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to read zone\n");
 		return ret;
@@ -141,7 +141,7 @@ static int lm3533_als_get_target(struct iio_dev *indio_dev, unsigned channel,
 		return -EINVAL;
 
 	reg = lm3533_als_get_target_reg(channel, zone);
-	ret = regmap_read(als->lm3533->regmap, reg, val);
+	ret = regmap_read(als->regmap, reg, val);
 	if (ret)
 		dev_err(&indio_dev->dev, "failed to get target current\n");
 
@@ -162,7 +162,7 @@ static int lm3533_als_set_target(struct iio_dev *indio_dev, unsigned channel,
 		return -EINVAL;
 
 	reg = lm3533_als_get_target_reg(channel, zone);
-	ret = regmap_write(als->lm3533->regmap, reg, val);
+	ret = regmap_write(als->regmap, reg, val);
 	if (ret)
 		dev_err(&indio_dev->dev, "failed to set target current\n");
 
@@ -274,7 +274,7 @@ static int lm3533_als_set_int_mode(struct iio_dev *indio_dev, int enable)
 	struct lm3533_als *als = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_assign_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
+	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_ZONE_INFO,
 				 LM3533_ALS_INT_ENABLE_MASK, enable);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to set int mode %d\n",
@@ -290,7 +290,7 @@ static int lm3533_als_get_int_mode(struct iio_dev *indio_dev, int *enable)
 	struct lm3533_als *als = iio_priv(indio_dev);
 	int ret;
 
-	ret = regmap_test_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
+	ret = regmap_test_bits(als->regmap, LM3533_REG_ALS_ZONE_INFO,
 			       LM3533_ALS_INT_ENABLE_MASK);
 	if (ret < 0) {
 		dev_err(&indio_dev->dev, "failed to get int mode\n");
@@ -320,7 +320,7 @@ static int lm3533_als_get_threshold(struct iio_dev *indio_dev, unsigned nr,
 		return -EINVAL;
 
 	reg = lm3533_als_get_threshold_reg(nr, raising);
-	ret = regmap_read(als->lm3533->regmap, reg, val);
+	ret = regmap_read(als->regmap, reg, val);
 	if (ret)
 		dev_err(&indio_dev->dev, "failed to get threshold\n");
 
@@ -342,7 +342,7 @@ static int lm3533_als_set_threshold(struct iio_dev *indio_dev, unsigned nr,
 	reg2 = lm3533_als_get_threshold_reg(nr, !raising);
 
 	mutex_lock(&als->thresh_mutex);
-	ret = regmap_read(als->lm3533->regmap, reg2, &val2);
+	ret = regmap_read(als->regmap, reg2, &val2);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to get threshold\n");
 		goto out;
@@ -357,7 +357,7 @@ static int lm3533_als_set_threshold(struct iio_dev *indio_dev, unsigned nr,
 		goto out;
 	}
 
-	ret = regmap_write(als->lm3533->regmap, reg, val);
+	ret = regmap_write(als->regmap, reg, val);
 	if (ret) {
 		dev_err(&indio_dev->dev, "failed to set threshold\n");
 		goto out;
@@ -712,7 +712,7 @@ static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
 {
 	int ret;
 
-	ret = regmap_assign_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
 				 LM3533_ALS_INPUT_MODE_MASK, pwm_mode);
 	if (ret) {
 		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
@@ -732,7 +732,7 @@ static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
 		return -EINVAL;
 	}
 
-	ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
+	ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
 			   val);
 	if (ret) {
 		dev_err(&als->pdev->dev, "failed to set resistor\n");
@@ -766,7 +766,7 @@ static int lm3533_als_setup_irq(struct lm3533_als *als, void *dev)
 	int ret;
 
 	/* Make sure interrupts are disabled. */
-	ret = regmap_clear_bits(als->lm3533->regmap, LM3533_REG_ALS_ZONE_INFO,
+	ret = regmap_clear_bits(als->regmap, LM3533_REG_ALS_ZONE_INFO,
 				LM3533_ALS_INT_ENABLE_MASK);
 	if (ret) {
 		dev_err(&als->pdev->dev, "failed to disable interrupts\n");
@@ -789,7 +789,7 @@ static int lm3533_als_enable(struct lm3533_als *als)
 {
 	int ret;
 
-	ret = regmap_set_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+	ret = regmap_set_bits(als->regmap, LM3533_REG_ALS_CONF,
 			      LM3533_ALS_ENABLE_MASK);
 	if (ret)
 		dev_err(&als->pdev->dev, "failed to enable ALS\n");
@@ -801,7 +801,7 @@ static int lm3533_als_disable(struct lm3533_als *als)
 {
 	int ret;
 
-	ret = regmap_clear_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+	ret = regmap_clear_bits(als->regmap, LM3533_REG_ALS_CONF,
 				LM3533_ALS_ENABLE_MASK);
 	if (ret)
 		dev_err(&als->pdev->dev, "failed to disable ALS\n");
@@ -845,7 +845,7 @@ static int lm3533_als_probe(struct platform_device *pdev)
 	indio_dev->modes = INDIO_DIRECT_MODE;
 
 	als = iio_priv(indio_dev);
-	als->lm3533 = lm3533;
+	als->regmap = lm3533->regmap;
 	als->pdev = pdev;
 	als->irq = lm3533->irq;
 	atomic_set(&als->zone, 0);
diff --git a/drivers/leds/leds-lm3533.c b/drivers/leds/leds-lm3533.c
index a48991958eae..f57d97201816 100644
--- a/drivers/leds/leds-lm3533.c
+++ b/drivers/leds/leds-lm3533.c
@@ -42,13 +42,15 @@
 
 
 struct lm3533_led {
-	struct lm3533 *lm3533;
+	struct regmap *regmap;
 	struct lm3533_ctrlbank cb;
 	struct led_classdev cdev;
 	int id;
 
 	struct mutex mutex;
 	unsigned long flags;
+
+	bool have_als;
 };
 
 
@@ -96,7 +98,7 @@ static int lm3533_led_pattern_enable(struct lm3533_led *led, int enable)
 	pattern = lm3533_led_get_pattern(led);
 	mask = 1 << (2 * pattern);
 
-	ret = regmap_assign_bits(led->lm3533->regmap,
+	ret = regmap_assign_bits(led->regmap,
 				 LM3533_REG_PATTERN_ENABLE, mask, enable);
 	if (ret) {
 		dev_err(led->cdev.dev, "failed to enable pattern %d (%d)\n",
@@ -255,7 +257,7 @@ static u8 lm3533_led_delay_set(struct lm3533_led *led, u8 base,
 	dev_dbg(led->cdev.dev, "%s - %lu: %u (0x%02x)\n", __func__,
 							*delay, t, val);
 	reg = lm3533_led_get_pattern_reg(led, base);
-	ret = regmap_write(led->lm3533->regmap, reg, val);
+	ret = regmap_write(led->regmap, reg, val);
 	if (ret)
 		dev_err(led->cdev.dev, "failed to set delay (%02x)\n", reg);
 
@@ -336,7 +338,7 @@ static ssize_t show_risefalltime(struct device *dev,
 	u32 val;
 
 	reg = lm3533_led_get_pattern_reg(led, base);
-	ret = regmap_read(led->lm3533->regmap, reg, &val);
+	ret = regmap_read(led->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -371,7 +373,7 @@ static ssize_t store_risefalltime(struct device *dev,
 		return -EINVAL;
 
 	reg = lm3533_led_get_pattern_reg(led, base);
-	ret = regmap_write(led->lm3533->regmap, reg, val);
+	ret = regmap_write(led->regmap, reg, val);
 	if (ret)
 		return ret;
 
@@ -405,7 +407,7 @@ static ssize_t show_als_channel(struct device *dev,
 	int ret;
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
-	ret = regmap_read(led->lm3533->regmap, reg, &val);
+	ret = regmap_read(led->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -437,7 +439,7 @@ static ssize_t store_als_channel(struct device *dev,
 	mask = LM3533_REG_CTRLBANK_BCONF_ALS_CHANNEL_MASK;
 	val = channel - 1;
 
-	ret = regmap_update_bits(led->lm3533->regmap, reg, mask, val);
+	ret = regmap_update_bits(led->regmap, reg, mask, val);
 	if (ret)
 		return ret;
 
@@ -455,7 +457,7 @@ static ssize_t show_als_en(struct device *dev,
 	int ret;
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
-	ret = regmap_read(led->lm3533->regmap, reg, &val);
+	ret = regmap_read(led->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -479,7 +481,7 @@ static ssize_t store_als_en(struct device *dev,
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
 
-	ret = regmap_assign_bits(led->lm3533->regmap, reg,
+	ret = regmap_assign_bits(led->regmap, reg,
 				 LM3533_REG_CTRLBANK_BCONF_ALS_EN_MASK, enable);
 	if (ret)
 		return ret;
@@ -498,7 +500,7 @@ static ssize_t show_linear(struct device *dev,
 	int ret;
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
-	ret = regmap_read(led->lm3533->regmap, reg, &val);
+	ret = regmap_read(led->regmap, reg, &val);
 	if (ret)
 		return ret;
 
@@ -525,7 +527,7 @@ static ssize_t store_linear(struct device *dev,
 
 	reg = lm3533_led_get_lv_reg(led, LM3533_REG_CTRLBANK_BCONF_BASE);
 
-	ret = regmap_assign_bits(led->lm3533->regmap, reg,
+	ret = regmap_assign_bits(led->regmap, reg,
 				 LM3533_REG_CTRLBANK_BCONF_MAPPING_MASK, linear);
 	if (ret)
 		return ret;
@@ -597,7 +599,7 @@ static umode_t lm3533_led_attr_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_als_channel.attr ||
 					attr == &dev_attr_als_en.attr) {
-		if (!led->lm3533->have_als)
+		if (!led->have_als)
 			mode = 0;
 	}
 
@@ -654,7 +656,9 @@ static int lm3533_led_probe(struct platform_device *pdev)
 	if (!led)
 		return -ENOMEM;
 
-	led->lm3533 = lm3533;
+	led->regmap = lm3533->regmap;
+	led->have_als = lm3533->have_als;
+
 	led->cdev.name = pdata->name;
 	led->cdev.default_trigger = pdata->default_trigger;
 	led->cdev.brightness_set_blocking = lm3533_led_set;
@@ -670,7 +674,7 @@ static int lm3533_led_probe(struct platform_device *pdev)
 	 * registration so use parent device (for error reporting) until
 	 * registered.
 	 */
-	led->cb.lm3533 = lm3533;
+	led->cb.regmap = lm3533->regmap;
 	led->cb.id = lm3533_led_get_ctrlbank_id(led);
 	led->cb.dev = lm3533->dev;
 
diff --git a/drivers/mfd/lm3533-ctrlbank.c b/drivers/mfd/lm3533-ctrlbank.c
index b78c130d7712..07aec46e8c0a 100644
--- a/drivers/mfd/lm3533-ctrlbank.c
+++ b/drivers/mfd/lm3533-ctrlbank.c
@@ -39,7 +39,7 @@ int lm3533_ctrlbank_enable(struct lm3533_ctrlbank *cb)
 	dev_dbg(cb->dev, "%s - %d\n", __func__, cb->id);
 
 	mask = 1 << cb->id;
-	ret = regmap_set_bits(cb->lm3533->regmap, LM3533_REG_CTRLBANK_ENABLE,
+	ret = regmap_set_bits(cb->regmap, LM3533_REG_CTRLBANK_ENABLE,
 			      mask);
 	if (ret)
 		dev_err(cb->dev, "failed to enable ctrlbank %d\n", cb->id);
@@ -56,7 +56,7 @@ int lm3533_ctrlbank_disable(struct lm3533_ctrlbank *cb)
 	dev_dbg(cb->dev, "%s - %d\n", __func__, cb->id);
 
 	mask = 1 << cb->id;
-	ret = regmap_clear_bits(cb->lm3533->regmap, LM3533_REG_CTRLBANK_ENABLE,
+	ret = regmap_clear_bits(cb->regmap, LM3533_REG_CTRLBANK_ENABLE,
 				mask);
 	if (ret)
 		dev_err(cb->dev, "failed to disable ctrlbank %d\n", cb->id);
@@ -82,7 +82,7 @@ int lm3533_ctrlbank_set_max_current(struct lm3533_ctrlbank *cb, u16 imax)
 	val = (imax - LM3533_MAX_CURRENT_MIN) / LM3533_MAX_CURRENT_STEP;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_MAX_CURRENT_BASE);
-	ret = regmap_write(cb->lm3533->regmap, reg, val);
+	ret = regmap_write(cb->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to set max current\n");
 
@@ -96,7 +96,7 @@ int lm3533_ctrlbank_set_brightness(struct lm3533_ctrlbank *cb, u8 val)
 	int ret;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_BRIGHTNESS_BASE);
-	ret = regmap_write(cb->lm3533->regmap, reg, val);
+	ret = regmap_write(cb->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to set brightness\n");
 
@@ -110,7 +110,7 @@ int lm3533_ctrlbank_get_brightness(struct lm3533_ctrlbank *cb, u32 *val)
 	int ret;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_BRIGHTNESS_BASE);
-	ret = regmap_read(cb->lm3533->regmap, reg, val);
+	ret = regmap_read(cb->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to get brightness\n");
 
@@ -137,7 +137,7 @@ int lm3533_ctrlbank_set_pwm(struct lm3533_ctrlbank *cb, u8 val)
 		return -EINVAL;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_PWM_BASE);
-	ret = regmap_write(cb->lm3533->regmap, reg, val);
+	ret = regmap_write(cb->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to set PWM mask\n");
 
@@ -151,7 +151,7 @@ int lm3533_ctrlbank_get_pwm(struct lm3533_ctrlbank *cb, u32 *val)
 	int ret;
 
 	reg = lm3533_ctrlbank_get_reg(cb, LM3533_REG_PWM_BASE);
-	ret = regmap_read(cb->lm3533->regmap, reg, val);
+	ret = regmap_read(cb->regmap, reg, val);
 	if (ret)
 		dev_err(cb->dev, "failed to get PWM mask\n");
 
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 03cce6aeb014..39f438114c48 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -24,10 +24,12 @@
 
 
 struct lm3533_bl {
-	struct lm3533 *lm3533;
+	struct regmap *regmap;
 	struct lm3533_ctrlbank cb;
 	struct backlight_device *bd;
 	int id;
+
+	bool have_als;
 };
 
 
@@ -88,7 +90,7 @@ static ssize_t show_als_en(struct device *dev,
 	bool enable;
 	int ret;
 
-	ret = regmap_read(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
+	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
 	if (ret)
 		return ret;
 
@@ -113,7 +115,7 @@ static ssize_t store_als_en(struct device *dev,
 
 	mask = 1 << (2 * ctrlbank);
 
-	ret = regmap_assign_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
 				 mask, enable);
 	if (ret)
 		return ret;
@@ -130,7 +132,7 @@ static ssize_t show_linear(struct device *dev,
 	int linear;
 	int ret;
 
-	ret = regmap_read(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
+	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
 	if (ret)
 		return ret;
 
@@ -158,7 +160,7 @@ static ssize_t store_linear(struct device *dev,
 
 	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
 
-	ret = regmap_assign_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
 				 mask, linear);
 	if (ret)
 		return ret;
@@ -223,7 +225,7 @@ static umode_t lm3533_bl_attr_is_visible(struct kobject *kobj,
 
 	if (attr == &dev_attr_als_channel.attr ||
 					attr == &dev_attr_als_en.attr) {
-		if (!bl->lm3533->have_als)
+		if (!bl->have_als)
 			mode = 0;
 	}
 
@@ -277,10 +279,11 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	if (!bl)
 		return -ENOMEM;
 
-	bl->lm3533 = lm3533;
+	bl->regmap = lm3533->regmap;
+	bl->have_als = lm3533->have_als;
 	bl->id = pdev->id;
 
-	bl->cb.lm3533 = lm3533;
+	bl->cb.regmap = lm3533->regmap;
 	bl->cb.id = lm3533_bl_get_ctrlbank_id(bl);
 	bl->cb.dev = NULL;			/* until registered */
 
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index aab8f08dfcb0..696014deaa7c 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -33,7 +33,7 @@ struct lm3533 {
 };
 
 struct lm3533_ctrlbank {
-	struct lm3533 *lm3533;
+	struct regmap *regmap;
 	struct device *dev;
 	int id;
 };
-- 
2.53.0

