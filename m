Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9437ECD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:27 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E8EC6112D03;
	Sat,  6 Jun 2026 04:58:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="LVSZXI1R";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 43E29112D02
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:26 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-beb8a08a6c8so370079166b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721905; x=1781326705; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=yN9wV+nrusoIiZXpR2QbLHADEoHUVVuow5fDPzDOfKY=;
 b=LVSZXI1Rs4ef4CvA90T2bgycyrD6fOQF7E8GNSEARqA1cjxER7egCAvoej2GoQmn+A
 xqM43pKh9yKaTyPz++ifdzfIi0T98IahlNXEAQNJ7b7VBn67aAmPl62eih8/vA9TF/Ke
 GbsQBgsGKm4ktUTBLMtxa6vUnagIye2IMLYXbwBaUrPt33TFdylX8AvETKjgltdslvN2
 U6mb1CI1y5N9nN5nX13uzzJQFGpjBWbj2OFCNyjwlIewXodDr/BUzbKjd9KvlSgLP9NJ
 ywTLKEvU6FGKY+lA5WjvxMb3CRA+DrDo8PnHyBLnb0fm9n56xPIeZaJ6Cv2Oiy0FXz/b
 uk5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721905; x=1781326705;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=yN9wV+nrusoIiZXpR2QbLHADEoHUVVuow5fDPzDOfKY=;
 b=AJuu/nAKhojBB05JapSCwbngEv8SI7TzM8nKjd7u3SfxCJelYiaFtaSEd32ArdIvrD
 gSas1uZ0hv2J7zCRveXQuVFeXecEc7ISwRNUwqnwy3rUV0FPlV+XU1h5d+PB9qIwHsYK
 vbMhwNa6iuAqV15995RO0DE6UMvrSxBSoAfnca9vY9kmd5UwEXIYNxetoCyGVzBZGGGg
 nHJYMu4+ec896YPGZ0miAzDiA9JKQuZRPUJkxrlG7P7lmeQuyiIaWlr76IOfmE5Ht4Ys
 Zt7aFHYqZQmTlPWJFmK/yMY1vRf0hK1KbV1XeHVP0Ll2uAKrkOXPR/hF/ebaIu6n6Y8S
 /KcA==
X-Forwarded-Encrypted: i=1;
 AFNElJ//DeWoZ4dhP8S+pk3l6i0eijklkHxOex/Mmo2/V1Y3eEiKs2Hj8RbkUd1Hv+6EUUPImR6zi/f+rH0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwJzZabcfLFz1jMSEBUIgPvijpWM/vKBGHebOJu8eE+pCEF++MA
 FTSDqxHiuDI3g6KLDXadXGLI2g08pOGsqGB238b7GRZZcui+5jq+ckT9
X-Gm-Gg: Acq92OFZPYSKkl/buvaDQiQF07xPhfgZdNrwFg5jrOXqZqnvI9677CgvqZcEX0OhXNA
 zgJqh8JvASvzqYJrvYrCzp5FmYPhXiYGEWZ2rPBdqmM0HmTgPU4PR4y39cMJssvU2zk/CY/7JYY
 S5KbYO2BKG8RGE6skjnWPbQzeLZSdOBxR57tsHIV/tODqU9PHYI1bpB04djl4hEyKO0/YTLzlGa
 in5qaftnpxatdusj1r1hizvVBHKhnPRJPg8lfjHRNUlW2txu9ThwbNjTJsoyYLDGk1+30fmE95C
 CloHRTLd8X8N8EkA2yoFXFfDBfX7cwHYab1OHL7spOtcDzzVnQ/ddIyxRxquj83YrMIpD2kPuev
 eLPHztGT+ekR08SyYKyscmj828kIzAf3idBNjGrqWJfprvfw66Lw/O8wIn2CZxUozuzorC2nCE7
 w1BPlrD19k/ly2/UvYQRD3bNw=
X-Received: by 2002:a17:906:f58d:b0:bed:5d12:db5d with SMTP id
 a640c23a62f3a-bf37135e498mr329022266b.4.1780721904690; 
 Fri, 05 Jun 2026 21:58:24 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:24 -0700 (PDT)
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
Subject: [PATCH v4 07/14] mfd: lm3533: Switch sysfs_create_group() to
 device_add_group()
Date: Sat,  6 Jun 2026 07:57:31 +0300
Message-ID: <20260606045738.21050-8-clamor95@gmail.com>
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

Switch from sysfs_create_group() to device_add_group() including device
managed where appropriate.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c           |  4 ++--
 drivers/video/backlight/lm3533_bl.c | 19 ++++++-------------
 2 files changed, 8 insertions(+), 15 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 45e7f7481aa0..e3efc9f6f348 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -416,7 +416,7 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	lm3533_device_bl_init(lm3533);
 	lm3533_device_led_init(lm3533);
 
-	ret = sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_group);
+	ret = device_add_group(lm3533->dev, &lm3533_attribute_group);
 	if (ret < 0) {
 		dev_err(lm3533->dev, "failed to create sysfs attributes\n");
 		goto err_unregister;
@@ -436,7 +436,7 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
 {
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
-	sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
+	device_remove_group(lm3533->dev, &lm3533_attribute_group);
 
 	mfd_remove_devices(lm3533->dev);
 	lm3533_disable(lm3533);
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 39f438114c48..b4363a30b2c8 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -304,28 +304,22 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
+	ret = devm_device_add_group(&bd->dev, &lm3533_bl_attribute_group);
+	if (ret < 0)
+		return dev_err_probe(&pdev->dev, ret,
+				     "failed to create sysfs attributes\n");
 
 	backlight_update_status(bd);
 
 	ret = lm3533_bl_setup(bl, pdata);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
 
 	ret = lm3533_ctrlbank_enable(&bl->cb);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
 
 	return 0;
-
-err_sysfs_remove:
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-
-	return ret;
 }
 
 static void lm3533_bl_remove(struct platform_device *pdev)
@@ -339,7 +333,6 @@ static void lm3533_bl_remove(struct platform_device *pdev)
 	bd->props.brightness = 0;
 
 	lm3533_ctrlbank_disable(&bl->cb);
-	sysfs_remove_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
 }
 
 #ifdef CONFIG_PM_SLEEP
-- 
2.53.0

