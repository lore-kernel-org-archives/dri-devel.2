Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0009BCD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:00:58 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E420F10EE88;
	Wed, 17 Jun 2026 08:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ddfAzk+O";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id F2FDB10EE7A
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:00:53 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-6912f4acca4so9642238a12.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:00:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683252; x=1782288052; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XN/2fWo04yb49XoOXlEMtfv2zfwELjeaHNjw1feXliI=;
 b=ddfAzk+OfmuwgyhsBoiEJOTmPE1i001nQCP4+1Uhw691PYNBWlCAZP2XCqGIepKyW5
 MEw57Jqn5K9Df0hJU3foMtMQlyZpRxiCvUGTKIV1vqsBVxGnKYrTPS5GAEul3jxbzHrc
 boSUY7z1XpRCahkJS9H2B+AvgE4+okFYtiE7oaaOHMzLzi3Hv1KMKYgadRdG/mIieOYF
 jBLY+ynwHF3LZdfkZcpsuwV8kNYwL/xjUozt+TTC7024VOc3qlys3gkr3cVE2BCrq61+
 Ri4iNUQDA8sAZc7ileiP8dCzffq81tMGXbclWmuzETIWVI+/p8gLgzsOeE1GNGkBkRdr
 GGww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683252; x=1782288052;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XN/2fWo04yb49XoOXlEMtfv2zfwELjeaHNjw1feXliI=;
 b=HgSELvLtKSQqu4KGcXjwDHtO0q+oU2Yz5UEl0KkvsCDkZx+b/iEhNucwOSOmdxhNOZ
 Nw7bate/2zHJ3F8YY5BcCVkyw1tMxHmvWiHWgZOWw6B3z/LpmYq62cyc2uNlmB4CzHPG
 2Ya05h489RKlMv3h91785+fhiIhN7VrP6127bEiAuI/9QrrZOdLEO2bskatf09AL5Dih
 /iVSz7TA+krl0c9MEVXjgITH3l5F3spyNvkoknSttN7Y+wGF+JoeLWtff/8w6wAsLy63
 SZ5Y/YBAGo5jZhaKXuH8WFweqPFNxnvPEwZ7ERK5fe2p9GUPh6FJ4EDIdUmb4kkG/A7Y
 KQIg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+bqZLioj6hiaKcTXdTfcimpdzY4pVaCyt8so6mOZTjtyoswdhHL5YHGgdGp3GG378a1Yu5GuHEQLM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFTxRRsG/z6rrObA0Oa45K3mDdne9wIRlrUKUnlYKbLxaDX4kg
 GUSLIxMNF6wtMgTge+sKkLtfjbGC9LboRFtIjliVdodMxtvRQUMnDhOe
X-Gm-Gg: AfdE7cn3NwhxijJrBaqqbaQvHMBKMuERp2oaxXRs+vCGycsvRiV5QPWLHcd+UZmy6t0
 u0A26MGeHb14ZgE/ZEKghx2QABQ7ZH9a2CB+MQ7q6VeUxDG0Ehi39kCiCm1lF6TKIr9iAAipcW+
 8ZYHOABhAfyHeuiJR1gDHDhYU0+xO+HVK88IyR2npEjnLCqfJogTj60hsKJsEum0aiFeRE90B92
 u/w2eX/PoBAYNklX6GypFSVPJ67KVdQFU5pwygarKI+D8RMbcskLXw6CTJSPkQiqeo7GrQrCjfb
 UcSGS/dRu49hGj/WV48vAMpQDjGWGl/R5BNztTG2q0jIZWgFQaDIAQhIr/AQN8zvPxTcddXsvBa
 xGjCRzAfs6PdyTYbKU66dYLz0gOOhuha5hDeMZCZ1rX73uREZ3fQGV7LGa5DiXn46R48qoodL7n
 l5593cGKgMJS2N
X-Received: by 2002:a17:907:d78a:b0:bed:275:5e5b with SMTP id
 a640c23a62f3a-c05a77cb897mr178021366b.42.1781683252049; 
 Wed, 17 Jun 2026 01:00:52 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.50
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:51 -0700 (PDT)
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
Subject: [PATCH v5 07/14] mfd: lm3533: Use dev_groups in struct device_driver
Date: Wed, 17 Jun 2026 11:00:24 +0300
Message-ID: <20260617080031.99156-8-clamor95@gmail.com>
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

Instead of creating and removing the device sysfs attributes directly
during probe and remove of the driver, respectively, use dev_groups in
struct device_driver to point to the attribute definitions and let the
core take care of creating and removing them.

No intentional functional impact.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c           | 16 ++++++----------
 drivers/video/backlight/lm3533_bl.c | 22 ++++++++--------------
 2 files changed, 14 insertions(+), 24 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 45e7f7481aa0..b03a3ae96c10 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -296,6 +296,11 @@ static struct attribute_group lm3533_attribute_group = {
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
@@ -416,16 +421,8 @@ static int lm3533_device_init(struct lm3533 *lm3533)
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
 
@@ -436,8 +433,6 @@ static void lm3533_device_exit(struct lm3533 *lm3533)
 {
 	dev_dbg(lm3533->dev, "%s\n", __func__);
 
-	sysfs_remove_group(&lm3533->dev->kobj, &lm3533_attribute_group);
-
 	mfd_remove_devices(lm3533->dev);
 	lm3533_disable(lm3533);
 }
@@ -532,6 +527,7 @@ MODULE_DEVICE_TABLE(i2c, lm3533_i2c_ids);
 static struct i2c_driver lm3533_i2c_driver = {
 	.driver = {
 		   .name = "lm3533",
+		   .dev_groups = lm3533_attribute_groups,
 	},
 	.id_table	= lm3533_i2c_ids,
 	.probe		= lm3533_i2c_probe,
diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 4d6f68033480..9ef171d3aaea 100644
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

