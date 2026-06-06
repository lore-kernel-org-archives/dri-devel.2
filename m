Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0A15CD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 51A0C112D04;
	Sat,  6 Jun 2026 04:58:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Jyidzt3q";
	dkim-atps=neutral
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com
 [209.85.208.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 10C9C112D04
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:40 +0000 (UTC)
Received: by mail-ed1-f54.google.com with SMTP id
 4fb4d7f45d1cf-68d232e119dso4217762a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721918; x=1781326718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=GpLTvUbX/MW96Oy59fQWRealZVBkci3zFRen/ePeGpY=;
 b=Jyidzt3qrIWdWXpwxP8aHvkGqB/cQKvN/UmUfhmiyJRQthwN1WMTYjLvMlTWyJAUHC
 Bcol2NaAKiQw9jo0wYxQK8Cy4r/Nl4wV/uVor1AOlyxLPBidy5Eig9SRPwyhIY25G49k
 xQWY9IS0qCW4UAbZ1yB/Ypu5soiyAFcYry9KgaNiyJkilurTW7AIWXjuhN0qIbODUtsn
 SIKprk++VmP3eLNiHd3e/4PhXfdd0y1Qd3rH3UfP+sDHXIF/UyTvd7AsVCl2Ho6mo3tW
 8+mi5oqwGoZ2hb+D+MBTqFe8tSEcu5KANjGUxhyTzcCJSXkbemqPVffLgSHQe3fvizaA
 nnIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721918; x=1781326718;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=GpLTvUbX/MW96Oy59fQWRealZVBkci3zFRen/ePeGpY=;
 b=IBVhyVqubFdmuo6P7uAKrcjp92th45421g5Nbozzeg3esXSEjCMi8YgK45HEA6Uerv
 +Cm5m0MLZiy7iV+GCQnCrEOzWYg04SaOghr6CCSt6nTF5gTgsvs1NLPiOVq40pC5kuJF
 YSLmGAi9ZgNUODcfWKvlnvLss3pFhZEBhCFUs/g7TAKXmNx8RX4iBngwX9tqlRvhcLcm
 WYS19egTnKQV9unxQm/VaujUNP8m7bM8nTPNWWOwDMU/TClZGbNdggGWzkTisNYY0B8e
 w+UDNOocnwsSVEU+zFADGAQrGE5Ohu314tiBIF5brpgjhBMB6Kz7eE880oygjS6zdMFt
 oaAQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/aczdx8CtjNCpIQ4+69ejDQC1M6zNLgj/5uxVVpTu3YmLGo+KqWs5zcqxNJVfRS3ADRO7equdqfw8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzTWd4DxIx0vQ0I6c/Ti+TkvXm9Rzpe2Ylsp5Ss9Ww2SFIgcisY
 OpKem+62MjtnD0UhBnL0OoLbOpkRlaDVcbZSycazyFdyWjrxbgebY6Gu
X-Gm-Gg: Acq92OELEeAKKknG5XExkHUSD2W4v4XsZ8ZRNI5dxewnXny3dyLTtgDxaCYrX/7yPus
 Q7xvBvQ2yAbmS1Qle32QgxIoeCsJq3kLSLXQb7oVGPGHLUOdmXl/yTomldR57beKhXOApVPpgpJ
 DqD5NzHaCfrEcLrYux8SiddqBBBudCJqzEV5/4XzsuKPlZsZj9RuiSg8fCmSWXiGTI1LQsSuPn0
 qKjNxcmBsvrhEp1CsjCyDMIsB4V04Ie2Ll4AXg6OaHkQXjdzEZ4MbKrepL76aQ64rTI1cn82nAQ
 a2Nk+Xu7QHP/Bi9UfZQP1AM1iqzvL+ere25bFF7kanP861voNS854p+4TPbQuZtdbQGPGPnBTXA
 JVUQr5R9GH1sFMz7e1S9ZG9hUh/sKTEWrhi2lL231isLkBoRixDO40Vmz4TG9K0VnR7eaH+Ujjt
 GFmswucM9wgtoEkP/FNSQvKnQ=
X-Received: by 2002:a17:907:72d1:b0:bde:170:a0ef with SMTP id
 a640c23a62f3a-bf37234c5d9mr367725366b.27.1780721918445; 
 Fri, 05 Jun 2026 21:58:38 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.35
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:36 -0700 (PDT)
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
Subject: [PATCH v4 11/14] video: backlight: lm3533_bl: Improve logic of sysfs
 functions
Date: Sat,  6 Jun 2026 07:57:35 +0300
Message-ID: <20260606045738.21050-12-clamor95@gmail.com>
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

Simplify the sysfs logic of properties by switching to macros and proper
regmap helpers.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 58 ++++++++++-------------------
 1 file changed, 20 insertions(+), 38 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index e91c598342ad..9ad7ea1bbbcc 100644
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
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_ALS(ctrlbank));
 	if (ret)
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
+	ret = regmap_test_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+			       CTRLBANK_AB_BCONF_MODE(ctrlbank));
 	if (ret)
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

