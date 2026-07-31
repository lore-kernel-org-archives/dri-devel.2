Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 30918C5516D
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 74C0010F22E;
	Fri, 31 Jul 2026 11:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="S/ePDUSv";
	dkim-atps=neutral
Received: from mail-wr1-f52.google.com (mail-wr1-f52.google.com
 [209.85.221.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EC5510F224
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:37:19 +0000 (UTC)
Received: by mail-wr1-f52.google.com with SMTP id
 ffacd0b85a97d-476a130c138so1069722f8f.0
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:37:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497837; x=1786102637; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0PyVHQRL/Wspv3Qk4s8DBLC6Ax3FJKAvcclZCqUsci0=;
 b=S/ePDUSvi63u3zj29No2jnPFKijC3322hj1ABStKD9m2goQRO9LX+ZS4yWYm1jHuxf
 yYUsHWGtnfNdv8aMdsk5cml4O9COT7Ujzg/r2SBtovrlJFduNzcGxvfEbcRyXbEqNtxj
 uravNQPi9xZZe2kfSaBpYSsRF7lxPSnug6wTocymQRM163h+rELcy8Wuj2GJlFFQzbJ/
 lV9XMyy7VUJSoZ8ZI4YDAncmIBFrkE3rGX7PnUKdF6PBH1fzooLg0PqpRiMzEDi6iKqW
 N8I0AzltzwTTSCzkJikajQe99RjbBWklmLy8MdKiE0aaeDwyD0zmuYdyp+C7Bzqzjd21
 KRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497837; x=1786102637;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=0PyVHQRL/Wspv3Qk4s8DBLC6Ax3FJKAvcclZCqUsci0=;
 b=oqAWKjAZuY8Trl08VqFSjqeWCaCEw87cnxjwmBDPQnZjggUDZLmPWvjChvkWMVprku
 yGq8yyOSEISZ5s/EYNu+NEmnvh3fg2BQY/IRpIEYZLnq+gqfxbmmDy3//TFbywJu6cf7
 ttLgaLcFjMccDWSNjI4OO++eVP7Atp9/5Nha/0aib18u2VZdZHqwzX82XD4YOY/3TT5C
 /vV1LkZG9af8c98cilUbKkq+dnzAnvNUd0BcoFvIYZM9w8nB5Fs3kKEip2n+pGMlz8Bj
 iZWsYERcw5f0Va1kgXIOQ3L2sK2AjtvlT3krGf2xsz7xltqb2/yRT44IC134v3esBxLL
 Ry9Q==
X-Forwarded-Encrypted: i=1;
 AHgh+RpJTmqBo+x6CAzA1V2ubt64YMsCy/QiJ9Tw79F3xj1z8KancI3uBUgEn6UYywVyQsbtMX3dS5luDAk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwZT6tOvgAIrqiuDe6EFaOfdRj5W0YvhUX8JTUGwbAoFG1w3mCJ
 e23ZoR0RqflpaX+VEeOHiYftHOi6nHjz8BfrGLvBsBj/6n6vAIKSwwyx
X-Gm-Gg: AR+sD116W3uyI5vDTjyym0k8LgmP5ijzCvp9HY1xcjro0ABwCF47V5yoLxT6v9ToE81
 eZz58/qW6XO+BU6q2KUlO0uQUIE13fCok1XbckvWq1gAt9ZB3/P1b93DjhM9n9LLLiPWLRU/voh
 7hiicHMPh9x+vTkw35FMKCcJ1SPn2xHsON20RXz68pJDuT6jhy4ckwbX0fSOlxBbGN/AJqtzwlI
 tzOJsAaaompYHenzCHLtUeAODISlTa5jY0xMB8mYcapPXKn8/FSOUHc8ySvHJPf3e6RD0vCWoaG
 copy+Jwh7v+RdJ4iCgrjJ2K/TDTIdGNcLWLJhmLj7SrcbxnUZvMGVY+GdU4KJLvjoTXuVVyUooj
 cmNnIRpVcTO+Mj25hBjcWnUXqMm2sgLh53fC1QxFz7JOgU+LaktrcIZM33lnjx3H1slDj56iayG
 +nJVUrfm0JB3bLkWmM7WnXbBpePqcgE3tVzjfw315oxA7oX7oeig3DiAseTJ1VgUsrmCOxdVfTU
 u8C341VZg==
X-Received: by 2002:a05:6000:220d:b0:47f:93a1:1126 with SMTP id
 ffacd0b85a97d-47fd2b6b0cdmr3767923f8f.61.1785497837511; 
 Fri, 31 Jul 2026 04:37:17 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:37:16 -0700 (PDT)
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
 mfd@lists.linux.dev, linux-fbdev@vger.kernel.org
Subject: [PATCH v6 11/14] video: backlight: lm3533_bl: Improve logic of sysfs
 functions
Date: Fri, 31 Jul 2026 14:36:29 +0300
Message-ID: <20260731113632.158440-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260731113632.158440-1-clamor95@gmail.com>
References: <20260731113632.158440-1-clamor95@gmail.com>
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

Simplify the sysfs logic of properties by switching to macros and proper
regmap helpers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 62 ++++++++++-------------------
 1 file changed, 22 insertions(+), 40 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 5ce237cb42190..2e31a79628d6b 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -22,6 +22,8 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -84,88 +86,68 @@ static ssize_t show_als_channel(struct device *dev,
 	return scnprintf(buf, PAGE_SIZE, "%u\n", channel);
 }
 
-static ssize_t show_als_en(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_als_en(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
-	u32 val;
-	u8 mask;
-	bool enable;
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
-	if (ret)
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
+	if (ret < 0)
 		return ret;
 
-	mask = 1 << (2 * ctrlbank);
-	enable = val & mask;
-
-	return scnprintf(buf, PAGE_SIZE, "%d\n", enable);
+	return scnprintf(buf, PAGE_SIZE, "%d\n", ret);
 }
 
-static ssize_t store_als_en(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_als_en(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int enable;
-	u8 mask;
 	int ret;
 
 	if (kstrtoint(buf, 0, &enable))
 		return -EINVAL;
 
-	mask = 1 << (2 * ctrlbank);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, enable);
+				 CTRLBANK_AB_BCONF_ALS(ctrlbank), enable);
 	if (ret)
 		return ret;
 
 	return len;
 }
 
-static ssize_t show_linear(struct device *dev,
-				struct device_attribute *attr, char *buf)
+static ssize_t show_linear(struct device *dev, struct device_attribute *attr,
+			   char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
-	u32 val;
-	u8 mask;
-	int linear;
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
-	ret = regmap_read(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF, &val);
-	if (ret)
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
+	if (ret < 0)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (val & mask)
-		linear = 1;
-	else
-		linear = 0;
-
-	return scnprintf(buf, PAGE_SIZE, "%x\n", linear);
+	return scnprintf(buf, PAGE_SIZE, "%x\n", ret);
 }
 
-static ssize_t store_linear(struct device *dev,
-					struct device_attribute *attr,
-					const char *buf, size_t len)
+static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
+			    const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
-				 mask, linear);
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), linear);
 	if (ret)
 		return ret;
 
-- 
2.53.0

