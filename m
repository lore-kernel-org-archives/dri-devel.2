Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 18CD5CD37AC
	for <dri-devel@archiver.kernel.org>; Sun, 17 May 2026 07:43:41 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4F56310E1A2;
	Sun, 17 May 2026 07:43:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Rp3VwzQU";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 945FC10E1A2
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 07:43:36 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-44e1860558fso561102f8f.0
 for <dri-devel@lists.freedesktop.org>; Sun, 17 May 2026 00:43:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779003815; x=1779608615; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=XCgjDXarYti7vTNUFmsGSYACwS96Ny5FHsWUIJ695K8=;
 b=Rp3VwzQU1zcGD50WYtrNoUkFmm2ptBUQ4gi4FPv0U7qmNoE3FaJlxMG9fxxW4/t37Z
 GQH22JxH9KYD0D5ZF9dEqhxxoebz178w2P4Brm8hv0F3Axtlr8+eI7SASNIxMF5gMx8a
 kSysYioO/QHcoWFQjtp25PYp54apvQx6g+2QCvXiEe7E8TKLaUaH1u5YsVTmuBxB564L
 ZRfSaeTuR9T53xu2JAJThEnrLo0S6yZmTUJNBIHS8R62PvPlR7lZ3nGgQv2smUnMFJyL
 W52x9/j76k5jFigmMLVIu7OOcEsE07qOcQOj2bVZ+pNWW4lVS3pPXcHMgldfdKPfVgZY
 t2MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779003815; x=1779608615;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=XCgjDXarYti7vTNUFmsGSYACwS96Ny5FHsWUIJ695K8=;
 b=F9yZt6OrphmdMKKj0VP7hObz+OOuOsQ+pAdnHw0Hbt9LgqKI/SnvWvpZ8ecHtaad+g
 Cyg7k54QfGTgdC6p1mX9cl7aMBo165Zsb8jZ3IToREvIXkhj91Y+1IondCoWkueF8QsN
 qNwjwv1hQZlJ8q34l8O19xBb30PkwvMzwwPC8aYYv7+liP8KXF8LLtwX5m4lsVkCKHyu
 4yGZHCuKn1FWrPc9BKSEQvsAGf6LQvCiTv4Yc6VTe3BjgyMShsqKUhxrxh4kmLa0mQfg
 k9LF2tQygWWCVlFFmWNlp8urLLB7kwM5GjJEptLa87jyPFj8ZKQhevBQ6Wsm1vRAbJZy
 k7UA==
X-Gm-Message-State: AOJu0YyZSuTskhieVwaajHSPGBN0uABrjinhGWwg5G7JBtuOSWpvTnV2
 m2/8GrifTVka25qUuXX1XikfRbhydKLwfefpe0R4N80WfJQaw8OA3tsR
X-Gm-Gg: Acq92OH6k6WCJ0HEa4lzdLvTuvsfqrQ/a5H0/uqoEbhECCWa8adSNey+B726ygZtT6j
 KbxVgzrEAuypN/MyS6LfgMWRRtVdqKkujpVuMdSqIt/38jrij+eIZ2RQBM8hD0wzrGhhSIYrvF1
 LuUvNBXyRMwXVtHvgmm/j67YX2mKViQnV6VZdzqVLWjNnjfp45/HUpXL5TtZC1KLw2L1JKISj25
 Dr1CEaIWefupf7nhzEAxrPZIlAQ7tVrr9boKo7LmSYT48MAJcXuV5+pNC6tI0Sj7Ev80MMZWeOf
 GrGaWZjVs9VTwfKoWxuEpZ6nN8gZw88WpqBJ5CW+3SVqf12EHsswT4oen+VTau8fhZ/ZvaG6Pja
 zTyF17jPFuJ8xPN9ezD5IepDXsTgEDaj9kjUllSrySJTZ2EFFu2/0v8oyetreuZDH2B+XiGmUrX
 vAyAtIppDIBFf/
X-Received: by 2002:a05:6000:25c4:b0:43d:184:8aa2 with SMTP id
 ffacd0b85a97d-45e5c589d93mr16397649f8f.16.1779003815037; 
 Sun, 17 May 2026 00:43:35 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45da0fe248dsm27512864f8f.30.2026.05.17.00.43.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 17 May 2026 00:43:34 -0700 (PDT)
From: Svyatoslav Ryhel <clamor95@gmail.com>
To: Lee Jones <lee@kernel.org>, Daniel Thompson <danielt@kernel.org>,
 Jingoo Han <jingoohan1@gmail.com>, Pavel Machek <pavel@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Jonathan Cameron <jic23@kernel.org>,
 David Lechner <dlechner@baylibre.com>,
 =?UTF-8?q?Nuno=20S=C3=A1?= <nuno.sa@analog.com>,
 Andy Shevchenko <andy@kernel.org>, Helge Deller <deller@gmx.de>,
 Svyatoslav Ryhel <clamor95@gmail.com>
Cc: dri-devel@lists.freedesktop.org, linux-leds@vger.kernel.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org
Subject: [PATCH v1 3/6] mfd: lm3533: Add support for VIN power supply
Date: Sun, 17 May 2026 10:43:03 +0300
Message-ID: <20260517074306.30937-4-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260517074306.30937-1-clamor95@gmail.com>
References: <20260517074306.30937-1-clamor95@gmail.com>
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

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 22 ++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  1 +
 2 files changed, 21 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 83ebd780f39d..131eb1a1c8eb 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -173,14 +173,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
 	return ret;
 }
 
-static void lm3533_enable(struct lm3533 *lm3533)
+static int lm3533_enable(struct lm3533 *lm3533)
 {
+	int ret;
+
+	ret = regulator_enable(lm3533->vin_supply);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to enable vin power supply\n");
+		return ret;
+	}
+
 	gpiod_set_value(lm3533->hwen, 1);
+
+	return 0;
 }
 
 static void lm3533_disable(struct lm3533 *lm3533)
 {
 	gpiod_set_value(lm3533->hwen, 0);
+	regulator_disable(lm3533->vin_supply);
 }
 
 enum lm3533_attribute_type {
@@ -331,7 +342,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	struct device *dev = lm3533->dev;
 	int ret;
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = lm3533_update(lm3533, LM3533_REG_BOOST_PWM,
 			    lm3533->boost_freq << LM3533_BOOST_FREQ_SHIFT,
@@ -453,6 +466,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->hwen),
 				     "failed to get HWEN GPIO\n");
 
+	lm3533->vin_supply = devm_regulator_get(lm3533->dev, "vin");
+	if (IS_ERR(lm3533->vin_supply))
+		return dev_err_probe(lm3533->dev, PTR_ERR(lm3533->vin_supply),
+				     "failed to get vin-supply\n");
+
 	device_property_read_u32(lm3533->dev, "ti,boost-ovp-microvolt",
 				 &lm3533->boost_ovp);
 
diff --git a/include/linux/mfd/lm3533.h b/include/linux/mfd/lm3533.h
index 3aa962d4c747..e355a3ac982e 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -28,6 +28,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.51.0

