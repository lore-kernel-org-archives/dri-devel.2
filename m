Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6F33CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:52:03 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 01E8E10F1E8;
	Thu, 28 May 2026 13:52:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bN05VySb";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2EAB110F1E3
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:51:58 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-bd3eb594960so1478888366b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:51:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779976317; x=1780581117; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=dDQ/tiPuyfzwfBV4n9YbMw4Pd30yVycLBAunY89akC8=;
 b=bN05VySb/B3jLqrU5BtKR3cUWT1uYOEKJaKRZg/ZXUhVMQn9tF27abuJvZwdhtMOBY
 UfaBs43sZDgS8fp+NfHDYN02no7Ii9lk0HSbBjScPm272zYHqQ0WQD0lfD5PjuAgBSaz
 ahWZKL1Cd+62QVfOmkDvK8Hhp95Co6e4Hy2SYZvZcjCHYzEx+GzOoD4lE++18Srxq9Za
 qYzVJ6SLXfpbfN2YXezqTrk5hksW+f9Fnz4qzjDoUY9H+znIgwhSr0iXqC00/P8WtObo
 6BFIO3iMk2zSK2PZz34l7o6mcXssuWAxAiVi0rxkwNVl+4VtFwvP3atcBFdE/e80snNl
 tYoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976317; x=1780581117;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=dDQ/tiPuyfzwfBV4n9YbMw4Pd30yVycLBAunY89akC8=;
 b=PB7zwtXyphXTr0L3dpZ/qjPWN9at3zfwcs5JU+cO17hxzEg6lB59CNKRuLcuyNw09H
 ZfeiqCPIfMwGkUjMDCyMjCR3hB4xSr7oyeeExvrG9f03YO8Zi2cvt2PmQ6KPS5RjrQ7m
 R6CPqWWV1rQ4pFgx5+ZwgdHKH3kvBPDmJtISOQ422Rco5jUzzu/CUHoNSnn6hdIaBPtt
 pfhT2L+kYIREPfiWsyFi6DcrvVMVOD9rbivGuzP7BLtzP/4Mq5QjNZ3UAumExEjglwRI
 NHbllFYhxWsRSXGNdQWNilsWSy3qMgJYgeQuXA8GUjMCZn+jAL8mIqQKGS7vgFQvkiA9
 Bvjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9a1ULQN611RG6JoRRPCRsODgblJoaMOe87C4mb8+ee762iVFclSYFKSzzsnf15P8OkBeDxFHTDT7g=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwYJiiBzlhCyGJ2j0q7gtIuAeRZT+EPCZTRewE3uYkd/v0+IYvV
 wIMZyxRrB6Z2kdwam5P7tFzKaxq67oUZGHeCHzEXe73T9TMeHvwvXeli
X-Gm-Gg: Acq92OFA3XOisOc5nCwBGXmvkTREHNJZdRs8b7GcJcLm1JkZPXXBb9ru5ZzY6Q10TwO
 Ny28Buh4S5Z8jaOawyozIZv6oLJzyApGkgJEAo6E2SnJ/PH0VHCDpvSZJc7z45zh9fbnPaCQuJh
 +ccRYIBbX5+FiuxhFHZnh7GgX/h89HDvdmtHq6Ge8lsM7teyyNpxgTocPOMiew5YvncgdWXt5pd
 2ww5sgCf6lZ6rjpc1KYC+IoiaJm1WhvpZuqqKIPTUWkA7MYe+8ro91+yCPDRxncaNmhS6leMg+N
 JPVPbvjxQDnVjYjVSlhGDzm3TP5Te3jS+OOXsPOqh11tQanUImZq6o2P4x99+MPRo+5Bspj7o0j
 urJZzwWXLzlsMq7ll8TP4vSUXwLfGxmQ8GdonU1bqwLH6KeU8O6ID1I/i9LjVw9n6Yym641z8kf
 3U0rb6DsPvKEcnCBpt8okPN1FL6Ampwp3Vhg==
X-Received: by 2002:a17:906:f049:b0:bdc:8c6b:4842 with SMTP id
 a640c23a62f3a-bdd25cecf04mr1579914166b.30.1779976316385; 
 Thu, 28 May 2026 06:51:56 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.54
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:51:55 -0700 (PDT)
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
Subject: [PATCH v2 5/6] video: backlight: lm3533_bl: Set initial mapping mode
 from DT
Date: Thu, 28 May 2026 16:51:22 +0300
Message-ID: <20260528135123.103745-6-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured. Additionally, update the linear sysfs code, which uses a
similar coding pattern.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 50 ++++++++++++++++-------------
 1 file changed, 27 insertions(+), 23 deletions(-)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 42da652df58d..c03d0d1667e4 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -22,6 +22,7 @@
 #define LM3533_BL_MAX_BRIGHTNESS	255
 
 #define LM3533_REG_CTRLBANK_AB_BCONF	0x1a
+#define   CTRLBANK_AB_BCONF_MODE(n)	BIT(2 * (n) + 1)
 
 
 struct lm3533_bl {
@@ -32,6 +33,7 @@ struct lm3533_bl {
 
 	u32 max_current;
 	u32 pwm;
+	bool linear;
 };
 
 
@@ -135,8 +137,9 @@ static ssize_t show_linear(struct device *dev,
 				struct device_attribute *attr, char *buf)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
+	u8 mask = CTRLBANK_AB_BCONF_MODE(id);
 	u8 val;
-	u8 mask;
 	int linear;
 	int ret;
 
@@ -144,8 +147,6 @@ static ssize_t show_linear(struct device *dev,
 	if (ret)
 		return ret;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
 	if (val & mask)
 		linear = 1;
 	else
@@ -159,23 +160,16 @@ static ssize_t store_linear(struct device *dev,
 					const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
-	u8 mask;
-	u8 val;
 	int ret;
 
 	if (kstrtoul(buf, 0, &linear))
 		return -EINVAL;
 
-	mask = 1 << (2 * lm3533_bl_get_ctrlbank_id(bl) + 1);
-
-	if (linear)
-		val = mask;
-	else
-		val = 0;
-
-	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF, val,
-									mask);
+	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+			    linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
+			    CTRLBANK_AB_BCONF_MODE(id));
 	if (ret)
 		return ret;
 
@@ -253,8 +247,15 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = lm3533_update(bl->lm3533, LM3533_REG_CTRLBANK_AB_BCONF,
+			    bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0,
+			    CTRLBANK_AB_BCONF_MODE(id));
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -317,14 +318,6 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
-
-	backlight_update_status(bd);
-
 	device_property_read_u32(&pdev->dev, "led-max-microamp",
 				 &bl->max_current);
 	bl->max_current = clamp(bl->max_current, LM3533_LED_MAX_CURRENT_MIN,
@@ -333,9 +326,20 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	bl->pwm = 0;
 	device_property_read_u32(&pdev->dev, "ti,pwm-config-mask", &bl->pwm);
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	ret = lm3533_bl_setup(bl);
 	if (ret)
-		goto err_sysfs_remove;
+		return ret;
+
+	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
+	if (ret < 0) {
+		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
+		return ret;
+	}
+
+	backlight_update_status(bd);
 
 	ret = lm3533_ctrlbank_enable(&bl->cb);
 	if (ret)
-- 
2.51.0

