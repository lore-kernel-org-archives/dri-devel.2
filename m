Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AE998CD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1366D112D05;
	Sat,  6 Jun 2026 04:58:34 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="VkFNS3OA";
	dkim-atps=neutral
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com
 [209.85.208.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3B976112D04
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:33 +0000 (UTC)
Received: by mail-ed1-f41.google.com with SMTP id
 4fb4d7f45d1cf-69165354c87so298949a12.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721912; x=1781326712; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=RlI5mUz8s798lOZfnX8f9JGZtNvnkftPBfqwbzzNVuw=;
 b=VkFNS3OA7nABSde4fxSPFaSkQ8C8pax1FYyhiG1XMfpfsDiTp1Z8Auo/DI/pfeMG30
 LygdZGNllSL2umfmr38p7zyUzR8BIZe6uENrEZfyqdTjSq2qVmHx3mIPcD+JnCrFNVO3
 6wqN74zS/cn0ShLbuegXvAMtDlzh0GDhNo+ZqZN/vQWa2rnryrvHIvV4ANjrBzq09nEr
 TGewCvXo/hluTkA3Rplord1bgJe90Yt+2M6/UAD7d35ZmfzlDTbx4XS327lHNpzl8Hv5
 fttc/M+CZO758KBx8huV9xikAagQbHdnwu2EIWKHXKSqhrxFczwgNhCQ2Gu4vCop5Cux
 SVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721912; x=1781326712;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=RlI5mUz8s798lOZfnX8f9JGZtNvnkftPBfqwbzzNVuw=;
 b=WeH0/GE7uDUMjB9A2lOlNSDDU0f6H/1D+ERVnoWK/OU8k09GKeLkbhJ+FmsavgeQCv
 BWO+5uRt2/wEFSYv9yTP1Vr8RXmoL3yr5kfIgX6cvBy8BRmR+Hn6Jy1S5UQduZa9V0q/
 Dw1COCRa50gINc5E6upyKVgVrzoAIPynwRaYHGQBz4nHwolJZaZNGDOiq7kz0UAF4Lvj
 lCe2W1pjTlhQytkQoNI8zajxgvwhs1beJWvXmjNrOvQ2ucOAMzNTL1pJuLnTmjvjEzn2
 0BpOLvpeTrQM3kVNogkUKZX1piwNVMLSOf2bn95rrXTAFiDQ+ux3VIWHPescnqcW8zC/
 UxNA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+jWKG65hvBihPDUaaLhq6c9E7tLu5p6hiV21o1RWt6BN9bKC9rNDwz5QHdW71p6VrU4bdjrcL7mFk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0Fm7bovjRe5SQxdog7FphMfiSpPzoEwpm1bCa+0S5MfvaKHKs
 36F2EhUcuxh/8R5rV6tEFn5OaJD+QQL0Xd9wVErZw5lpdy480xamch8a
X-Gm-Gg: Acq92OG6kpGDgiXDlqesoWISe3EeoDdG07Ycj4b3FTkWMURB7WOPGyT8u211Mi/XCrI
 5EW8ePrryglbTs+yRjhrjJZ5wZ9eK4ZMkOzFpOmI1kw3gB1nQU8SBACjQVee75EQQ12leMmZpcw
 TbOIjWE7ApO1qpmlrgt4jMV2FOoPKvuPknYrm5dZNaOHtdcUDG7XQn5dt6SKQEELGF6roejyu6d
 7mNeAiefhPJwYNNjX6Ji+SpL+6Rh/c+een0rVmYR5kh6bhT6ZVem4wiAl95w/fC38yRjYc8G0uS
 rqETr8h3DvUoJjGFT1KBlE/GispplIdc1F5A5ihx6HG55D0v3ksPxm9bFrI++7YL0+oHTl7Z6a9
 AUDA6j4QSIRyaYSOXIw1/1bs0C0BZD/uNCiMvftRWQgSOsfdUt4Y0Gxoo4GJ2Q32rzwUJhqbG7v
 I9oR4Si21qD7ThHxqY6XwXRJ8=
X-Received: by 2002:a17:907:c247:b0:bed:6e53:bb16 with SMTP id
 a640c23a62f3a-bf3743e5c7dmr350247866b.43.1780721911635; 
 Fri, 05 Jun 2026 21:58:31 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.28
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:30 -0700 (PDT)
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
Subject: [PATCH v4 09/14] mfd: lm3533: Add support for VIN power supply
Date: Sat,  6 Jun 2026 07:57:33 +0300
Message-ID: <20260606045738.21050-10-clamor95@gmail.com>
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

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 5af1d5476d3e..500cec3cceba 100644
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
@@ -332,7 +344,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		}
 	}
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
 				 LM3533_BOOST_FREQ_MASK,
@@ -456,6 +470,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index d3f7b07dbefc..3f9f4c9ef9f3 100644
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

