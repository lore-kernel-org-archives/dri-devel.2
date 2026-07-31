Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C0C9EC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:23 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F053410F233;
	Fri, 31 Jul 2026 11:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="YO1ORyTt";
	dkim-atps=neutral
Received: from mail-wr1-f50.google.com (mail-wr1-f50.google.com
 [209.85.221.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5DAF310F22D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:37:06 +0000 (UTC)
Received: by mail-wr1-f50.google.com with SMTP id
 ffacd0b85a97d-47c2b362ee2so828066f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:37:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497825; x=1786102625; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=ircJJN/vjkOsrZPEPqNXfhhtl9Kl7VXZaKYIBCeg3Vg=;
 b=YO1ORyTtbmFMS9hlKu6+7Q+VMf5eH/tHWFItcMsHzgSeIZXnc/kmyVn91KaRKW3oVq
 HiLatmMI6RbtZ+i5hZiTzv3/Fcx/9lzjb4GOKbJ95Qw3ea2GYM94IVtrnqMwZVPoxwpZ
 rNKMozu7cdFW9LqmGKvOj9uLVcfcKgUnJREPMGLEojF9KJZAIW849yIoFBTpPf0NnaPS
 zu1hsyaSJs9D03tKL62DNVWqMjmKsvGEHk9wL5irFW8nr3Rp84LPS3qVY5D2e5mBkx7Y
 xyhUsmwyOYwu18rx4tOIW6gY5PjyoMfVnLnz/mVGmLlCAvXkLJJCtIQpoXvtE4aXvgfK
 fd9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497825; x=1786102625;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=ircJJN/vjkOsrZPEPqNXfhhtl9Kl7VXZaKYIBCeg3Vg=;
 b=pajReSYJRSLvw38OShPY2X9ZyxRxtP1rdeFjqSnVYxcKZnLuPGv3lIXBvev9fVyJ9D
 xDBPk6ddGdcFRX2w/wAbLXq/xF/q2JJ0srquMuR/j7EX3mTpjl37JL/GzQ5cQolVjoGw
 00Cr094rex6/SoN61g1UgFuuEln5l9SBRtbA1/y53htvA60X2FWj/J9Jx+Pag0Epm98N
 P4zYJKryPWpftC8RSKntvXs4OTtYO7q7O4y6yXIcVG365ssEJxKaNNAs9psB+9tDaK32
 Ys4ZPKQDFzUkKFO4zN4vPEAS9yV8WAUo2rZnDjFCTLDk36I28HRbU5wEKrVjV/4fYxH2
 j66w==
X-Forwarded-Encrypted: i=1;
 AHgh+Rptcs+WpCJb/Xy+Yx3BdJOF9odrlvdTML26kHUorn6cOBnQFECz9G6q8rFmvnxavPUoRXZ8w3uhPk8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxy91twzVHIZU3MO5pRLsCpnmzADFfVQRKD1JRtbdg6W7YIaGSp
 ZEwmirKbL5kIZT0vgKZfUcaaBf1/pNQ7M9Cx2UAUZNkUkLd4zuMwdo6E
X-Gm-Gg: AR+sD13f6qZUJ114/9AX0cmvaeZIKmk1L5r9HYUjXGtglalpgY5q6Bd5J8gYHInEIRQ
 11K6GlqpAUga2+QJkAJXUIsgvHfkWab6yfbAXRE20KoAKNj4RA9HWwxQucnRe2eS6CNYqdcVJx2
 s1GI/JRTre72t5OPqcgiJRFw8ZhTGZsI/UfsS83EWvivuKzd0dTp9ZdwCCBvYgPYjpUqMipFFvR
 8kpaznEtzCf0A23u/UOcDypMqLjLtQQFnzjhA9RRDLwfV2gi5plsmzfZTZNQ/1zg33wiEqPVd6F
 W1q/T5VeAnBEpQoJD18kPreA+0woHqqhAFE8m1kgLQ74omOKVY5696uOc2DlGtQh01c+1mmuAhO
 Pp7g/2jFE3L5YqW/ITRCT1+VmRy7rCJTiQ/yj3kMDjRsgPJXnm4gbecrNnt1jAYs44lahzTh2Ka
 6wpjrtHPa+RMVieKsN19ysrsA0SfdIyZUzyW0I7AlHyvLHxuG4xhTeMwiASTFcyU84GJI4TlwPL
 ZgWhtQvdg==
X-Received: by 2002:a05:6000:420f:b0:46d:d6e0:9cc8 with SMTP id
 ffacd0b85a97d-47fd2b56316mr3933735f8f.46.1785497824680; 
 Fri, 31 Jul 2026 04:37:04 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:37:03 -0700 (PDT)
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
Subject: [PATCH v6 07/14] mfd: lm3533: Use dev_groups in struct device_driver
Date: Fri, 31 Jul 2026 14:36:25 +0300
Message-ID: <20260731113632.158440-8-clamor95@gmail.com>
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

Instead of creating and removing the device sysfs attributes directly
during probe and remove of the driver, respectively, use dev_groups in
struct device_driver to point to the attribute definitions and let the
core take care of creating and removing them.

No intentional functional impact.

Suggested-by: Andy Shevchenko <andriy.shevchenko@intel.com>
Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Johan Hovold <johan@kernel.org>
---
 drivers/mfd/lm3533-core.c           | 16 ++++++----------
 drivers/video/backlight/lm3533_bl.c | 22 ++++++++--------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 5baf934fac825..53b87958c2c68 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -294,6 +294,11 @@ static struct attribute_group lm3533_attribute_group = {
 	.attrs		= lm3533_attributes
 };
 
+static const struct attribute_group *lm3533_attribute_groups[] = {
+	&lm3533_attribute_group,
+	NULL,
+};
+
 static int lm3533_device_als_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
@@ -414,16 +419,8 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	lm3533_device_bl_init(lm3533);
 	lm3533_device_led_init(lm3533);
 
-	ret = sysfs_create_group(&lm3533->dev->kobj, &lm3533_attribute_group);
-	if (ret < 0) {
-		dev_err(lm3533->dev, "failed to create sysfs attributes\n");
-		goto err_unregister;
-	}
-
 	return 0;
 
-err_unregister:
-	mfd_remove_devices(lm3533->dev);
 err_disable:
 	lm3533_disable(lm3533);
 
@@ -434,8 +431,6 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
 {
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
-	sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
-
 	mfd_remove_devices(lm3533->dev);
 	lm3533_disable(lm3533);
 }
@@ -530,6 +525,7 @@ MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
 static struct i2c_driver lm3533_i2c_driver = {
 	.driver = {
 		   .name = "lm3533",
+		   .dev_groups = lm3533_attribute_groups,
 	},
 	.id_table	= lm3533_i2c_ids,
 	.probe		= lm3533_i2c_probe,
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 4d6f680334802..9ef171d3aaeab 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -237,6 +237,11 @@ static struct attribute_group lm3533_bl_attribute_group = {
 	.attrs		= lm3533_bl_attributes
 };
 
+static const struct attribute_group *lm3533_bl_attribute_groups[] = {
+	&lm3533_bl_attribute_group,
+	NULL,
+};
+
 static int lm3533_bl_setup(struct lm3533_bl *bl,
 					struct lm3533_bl_platform_data *pdata)
 {
@@ -304,28 +309,17 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, bl);
 
-	ret = sysfs_create_group(&bd->dev.kobj, &lm3533_bl_attribute_group);
-	if (ret < 0) {
-		dev_err(&pdev->dev, "failed to create sysfs attributes\n");
-		return ret;
-	}
-
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
@@ -377,6 +370,7 @@ static struct platform_driver lm3533_bl_driver = {
 	.driver = {
 		.name	= "lm3533-backlight",
 		.pm	= &lm3533_bl_pm_ops,
+		.dev_groups = lm3533_bl_attribute_groups,
 	},
 	.probe		= lm3533_bl_probe,
 	.remove		= lm3533_bl_remove,
-- 
2.53.0

