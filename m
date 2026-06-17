Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 78FA8CD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 59C0210EE8C;
	Wed, 17 Jun 2026 08:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="dG+bLCjB";
	dkim-atps=neutral
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com
 [209.85.208.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8D4610EE89
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:00:59 +0000 (UTC)
Received: by mail-ed1-f44.google.com with SMTP id
 4fb4d7f45d1cf-6919f40a0c8so10133310a12.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:00:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683258; x=1782288058; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=2i1k8AoyDEf4+SEcMRPttiYCfUlkSwT7R4ZGBXCsSZk=;
 b=dG+bLCjBBHzXazl0G9EFxUpl6aFVn979waS2MyN++VRok6gu9Hv7suyNpSYUf0L6UB
 OeMhBDQufDakYvzQJmNOy3bcUF1i04rw2tIN5l38I+dHf1LbtRzE2GYPR66GE/9qh1fC
 YWb4BdIZaWHnZFDtRpENJ7aEw9eXVfZCeZVacEVqF/71WmBK5JKwlmJD7r6GDOGD9JRW
 fuAKbzGMwjzcz8Qur1Ot7PAt0+qsBnH8KyggI0ehrXV32bF7kijv73JO7aeXgpnFaJjE
 glntDWI9wbNdLUvN3Ljj4dGigKVZfT68+a7+l/Xqf/pvudt3AgGnkTy1X9Ob994qX1sH
 ANFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683258; x=1782288058;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=2i1k8AoyDEf4+SEcMRPttiYCfUlkSwT7R4ZGBXCsSZk=;
 b=NmrQpZySgKoZKiIu/HpZExQ9eZUIX1bzdxJRdQMTEStePEZVjyAGGZK/FAfWArI6Te
 rx7M+PEpX01aTvYaQgv0V4PdzM35gds7PaDpDYytSdsZvVVhQyOcf7nmh5Kog8bM2TZj
 pgIc9ZZEgf7v6KS7EEPuFqUpo5EzJDPrklzTrSlpW+FlgP5Y/vLH/HXJ/mCXaeZJGVJc
 Fxt/IVHdFA5z4viol7BeKbEpwUvWm25cal1khWh5oQ1rET0K7WujO5hSAVtzdE1iDUBX
 Z6rtNnNLwyZ8gyg4ALvmK70ionFo5QdRjqFnknfwLElOk+UPk0NzJUMJdHxPQ+LQDGZ8
 Kz7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8XhMmZUhYTJfLHIiM7tRb/L2s824ZHycTp17hTYlPEcYFJChlENAzxov/POPrg83Euu3YyhkGCk5M=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyaVCXreI38hIS2omS8TeCjX7xvJZ46XgOCUqoEfSZwxlu5Fx/J
 wmYEznOc1BNZAdXedU9C1DAi2HVRIq/lf9MZUve3yW7i0WKCysa5AJAt
X-Gm-Gg: Acq92OFrEjH4e5DMHNIVEKvoJLoiGBNJ550nWnLEIMpwE4c4N6ucIovGEqULoyTjHJl
 +MBAdjlm3SODtlLvEKVYtD5Oiz37I7exaetk37QpPj+3jo5sibZm1T9BfGiZ+eXcvMle88Ct2t9
 0fr6Zc2dAfkbYV5ft6tTT7icOG6VfEHGQkO5iKZ1DGGabFG9dCIFGrcFNNBirlW6N/YLQhJgVF4
 3JI7sCdvB/Gss8riaAM50pIe2WQ+k+cillHOLHhL8FG3ugvzJVs6kkwctA3alSRIqK600EjGsX1
 EYmy8JGXj3dMIVBKswm3oZQeC7Cu3R+hfSxMz9/WCP2qM//CoPNS1aPQmmfCFPpwwSVnEy3Eoy0
 2f1Ib82XaVeDCvy1WC4XxHI+ANgmYI6ybH7OJfFJ0e8dp5IMK2OYAO5He9OX2U2Pypp/8ffAbDG
 okJQ==
X-Received: by 2002:a17:907:9305:b0:bfe:ed06:5a1f with SMTP id
 a640c23a62f3a-c05a83a199dmr195494666b.52.1781683257844; 
 Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
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
Subject: [PATCH v5 11/14] video: backlight: lm3533_bl: Improve logic of sysfs
 functions
Date: Wed, 17 Jun 2026 11:00:28 +0300
Message-ID: <20260617080031.99156-12-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260617080031.99156-1-clamor95@gmail.com>
References: <20260617080031.99156-1-clamor95@gmail.com>
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
index 2c24647fc17a..9eb0db640948 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -23,6 +23,8 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_ALS(n)	BIT(2 * (n))
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -85,88 +87,68 @@ static ssize_t show_als_channel(struct device *dev,
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

