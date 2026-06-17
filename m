Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 544A2CD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 480CE10EE8B;
	Wed, 17 Jun 2026 08:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f7peD+ow";
	dkim-atps=neutral
Received: from mail-ej1-f48.google.com (mail-ej1-f48.google.com
 [209.85.218.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B02E10EE89
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:00:57 +0000 (UTC)
Received: by mail-ej1-f48.google.com with SMTP id
 a640c23a62f3a-bec4639953dso931201966b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:00:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683256; x=1782288056; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=bDbkv4yENGcso8lbBuowMRR6EhhW3sM2nEWvZfEX0tI=;
 b=f7peD+owZtQDF54vFkyzOTcg/NuPPrLrw3+yTwQ+RNmUex12R3cx0um5gNSRoFRidB
 3UGvXBC0epzNGsfCxpL1NvdvWzQELjmepJnQ78yIe/l0p36w/Cm/4gRbFDwlJc6e9v/d
 WS0AfpWVa5fLJW4bHwsz3y0SxBVLR3Wz9jlnIn2Ndhs0bHlIwJGmD+RxFGawnteOdjlA
 jjESBHi1+vQfpssTUsZE5auJgv9gnoHzs6jsNQbZ7RIr9qRs5dVItYXtYsvGs6GLvkiC
 G9C3t8RF9tjdoUP/V2mTOeEEg8r0jwdAdmYDchzVYpQmxl5AhnlSHYHJEVOvqjrb71CO
 xOMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683256; x=1782288056;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=bDbkv4yENGcso8lbBuowMRR6EhhW3sM2nEWvZfEX0tI=;
 b=RnAmQP0KBU0COF+uGzyC1w8ErVjbasTk/vlhGS/cWYp+1Bw+9RrTDih+cB5b9dBM9P
 bd4Smv3It4dDMU7S5T3yqnq7i/0ayxHK/GgH+vsPlDP/ZBVNS33XRPYPM/SNmooaZqUy
 JJKW+OhRmhojeKAAO7nLxH71bTUxucNMzDhEorIjtLWVJKQZRuEptNS2WkUz0+NUiCLW
 7xfVamA126jBv3SzJyh+9/BqOxSWady77xnkbDmz1at8a2I3eu23WydCBpnLiYYBnaQj
 IfN71egodcnG6G7bNXO+bIAIRXizGr4PZOhaO47GfVnXH55/sqaG+yossDLtocuwVPYP
 zF0A==
X-Forwarded-Encrypted: i=1;
 AFNElJ/PLx5mnVVCyLmAMRCOcOPCi/gPJ/fQkP2iMLeWUWm7nSdgEdEKa+div7FzQ9Zj2dsQNT+Q4X/6BkM=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy6cRKDaoPl4aLep7Sg7kPAoTpqfb3k2ND/UQBZRihamO+JVUlM
 QLHTOPyrmEKORbXEGzDOHwWl7DrA8cRRR+EkZIqRWYxz+GLHZx+WkCyq
X-Gm-Gg: Acq92OFe8Iht064teYlZOtKRUhC71+fwGH7fCk2gmBrtQD2YX7XB1Ax+1BvVxv2P9V6
 v+DYgeTsyEC907izuO6muS9KLId8UL0mzdVjtJ473hKvDEsanid7/YUprizCRjGV5VKuvBGnd5v
 kwT/ObtxpEdB4nxujObJxp3eZ6WquzlA/TXA9wUMLMfyjyV9xW02jw9H6yDL7OFfFa2vXuESmHc
 Di0OYiE/s3ja9t9yReKf5Suwd1PVZGUcN+ItNWOcf7WgFsXy8a6jOO34cezI1khfqRX99dR99h9
 yXMehRSah/aWEYPyXroqXQiReTLBAqjafD1N0gxytq6/gvrOC8WyosSPjG1+k5A0CUQC7pG6qCy
 KyJUzI3o8EPRKtDI/PUdaiheuQ6D91QD5Vm16hxfaLuccbhSo7iNIbPicJWp6dS9cLBbEHmKCP7
 uP9EWZjS2fsxTI
X-Received: by 2002:a17:907:94d6:b0:bec:b4e3:e930 with SMTP id
 a640c23a62f3a-c05a511f1ccmr158862466b.12.1781683255042; 
 Wed, 17 Jun 2026 01:00:55 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.53
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:54 -0700 (PDT)
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
Subject: [PATCH v5 09/14] mfd: lm3533: Add support for VIN power supply
Date: Wed, 17 Jun 2026 11:00:26 +0300
Message-ID: <20260617080031.99156-10-clamor95@gmail.com>
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

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index a5aa7da9668b..4b5d94e9ed27 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -17,6 +17,7 @@
 #include <linux/mod_devicetable.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -113,14 +114,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
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
@@ -333,7 +345,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		}
 	}
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
 				 LM3533_BOOST_FREQ_MASK,
@@ -447,6 +461,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index 5710e88da45d..8f72dd41e8f0 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -22,6 +22,7 @@
 struct device;
 struct gpio_desc;
 struct regmap;
+struct regulator;
 
 struct lm3533 {
 	struct device *dev;
@@ -29,6 +30,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.53.0

