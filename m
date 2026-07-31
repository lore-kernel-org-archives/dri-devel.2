Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A424CC54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 036E910F224;
	Fri, 31 Jul 2026 11:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="NWi3P24k";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 99AF510F22E
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:37:13 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-c1f7666a90bso131155966b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497832; x=1786102632; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=HoJ5QEzgIc1R//Ldk+eAj0/fHRhzYHI0+TPDQsoclNc=;
 b=NWi3P24keUOpgfFzoNawAw2VUgMZxiSBKIQV1f3Kpuk25xmSNV0HICEI4xciazrB2/
 r7D7kk/KmE+A6NBYuapmHShVIxtonGvb9uvvmVxga6b08cnOku7Gj5AnQGfUmwYdc264
 vcEAwIwQq1fCut3FO1LwXoijFVHXwcOp6TS4JJaODCwhZ1maJUshBwnO6OIWOjZCpxdn
 a7sBJWXUs/miSygvv1xlWdWUQs1cMKXWS4sAxUtnTcTSggd0dR5uzHW08/Bjx8Kr5Tz2
 8YhP8X1UaZhcZ9sKW4QGPtIalP9TrAGabQRaMCqnPmWrnI3/mtNb0APQd2LbHPy3x95+
 /Wwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497832; x=1786102632;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=HoJ5QEzgIc1R//Ldk+eAj0/fHRhzYHI0+TPDQsoclNc=;
 b=K0vI8ZN4Lln+9GD8EM9z6iI78C8ysrfeuMUE0BenJH4heGMVUnyg2bGxANd97XIzUC
 mP2OSvdK1i+3tlZM2yaTrqB7QkwOOjpT6Nltd3PTCOs446+FsY8KJHs6cjqoEfIBYo1s
 xvD/iilvld0qX+vf8OvzzM+wm8kvpzGGAWGKwtCq2tWGdRZ7JvT98sgzakv7iVmLJtLp
 yQ+sa5b13R44YPqBnE3LZqP6+G1K6zCaFtUO8/JWS8k7DfmPOfX9PhhNETAOO3C+V4L7
 xNpa7/H85HllLNfwRCdjegCi+JoEo0R+Vw/QpJWETWy+qs3hBJdCErzXxy2L32ZddlmM
 IoUg==
X-Forwarded-Encrypted: i=1;
 AHgh+Rq5yjKZ/2wJ0/Ncw4wB+iNerE6JP/fpkLgsPw506u7YK175VfjqKicy7j6zMu+C7o5ts163Q+V50jk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwUXlKYjUJK3cvTMwOk7kyiJRlZBL+uq34Q4Gge0jnDaec+fLEv
 dhraqNg9/J2LJZK3CwfYq5+N7d0W4tHgU+c/6K7/QtDt54DHuFfDraKi
X-Gm-Gg: AR+sD10zdAvWkADDBSKVltFGSXc+uPPbJlgEkfUNABUnNTNAy5mHa8o/YOIBLKNMOb+
 uNfB8H9ZEFylXuNfAIc2IvTbAAsGt7zrFTrJ2HBy7oQ9MmTlUY9lJWWX2BAnhQ6FpcADJmMGq24
 paDEPHJxeU0R42Mh8P7P7TLZnFu3+k5ePC7wXt0ZShWi2qj4Ne5Gfah/ayStibvrcAZtaaDAeBD
 hDobR3oNNlob9a7R3PqGYWnbYeZGHbIiNt+2hCgmgMWJ1M8SymBVIr7+n1zFUlsD9ljSUu+9jbW
 6rYhunrPuHeJz7/8IKModP2F8ALbfO7bOFIIe4UcVGo6rXaWmyzTJNysIrUDOGDx7vrJXe5hz1/
 Sj1pZ0YLaa9q5wDK9UPdaQmRRkiD4WVkCfP95lksRjGsJ8xvcrmDKuUKQTc4OKM+NV98CVJRSAm
 elJRKpJJ7zR+/eicTmBXUmVyXL1rjU0EciLyDUmHGuHBRPUB9M4xXS3rCWPPmYh/4RjUsYmgPM9
 YW8Qhv4Zg==
X-Received: by 2002:a17:907:c78e:b0:c12:7934:52fd with SMTP id
 a640c23a62f3a-c1fd250eeb8mr91901366b.32.1785497831684; 
 Fri, 31 Jul 2026 04:37:11 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:37:10 -0700 (PDT)
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
Subject: [PATCH v6 09/14] mfd: lm3533: Add support for VIN power supply
Date: Fri, 31 Jul 2026 14:36:27 +0300
Message-ID: <20260731113632.158440-10-clamor95@gmail.com>
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

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index c7c7e71719ae0..2a63df034171e 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -17,6 +17,7 @@
 #include <linux/mfd/core.h>
 #include <linux/property.h>
 #include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
 #include <linux/seq_file.h>
 #include <linux/slab.h>
 #include <linux/uaccess.h>
@@ -111,14 +112,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
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
@@ -446,6 +460,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index 5710e88da45d2..8f72dd41e8f02 100644
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

