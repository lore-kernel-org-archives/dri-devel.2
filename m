Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D6BECD6E57
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:11 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 216971134C2;
	Mon,  1 Jun 2026 15:19:10 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i2rWZuQ0";
	dkim-atps=neutral
Received: from mail-wr1-f51.google.com (mail-wr1-f51.google.com
 [209.85.221.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 74E9C1134A9
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:19:08 +0000 (UTC)
Received: by mail-wr1-f51.google.com with SMTP id
 ffacd0b85a97d-460166910e6so340429f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:19:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780327147; x=1780931947; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=u1lcsLIobScldpWx6WSR7/N2rSVozhhuMPVVUCbPDt4=;
 b=i2rWZuQ04huxAM15VbKtJSNjNn6AEXIVicKRBnJjHy88pY20U4LhKtMw8y289nvCQf
 ARfW7mOhgQ7eDuWmPjGgKRI47w6AnJadNHxhtyzonCFH+te9ZWZhz+2dlshi9hIEaXIQ
 nRC8Lv4s+TfxDA1izcel10oLvNQ9paekhf9+234cw+wam9kGisg6DXC1ZKPFo0lqmpQD
 Oe273slM3Oh/ZkxbpkRE2UE7XhwKfWkk5TFCFh+0Fm0EgM/RIdlvB65Ci1s5IUULQ1hB
 G7txe/kWYQ7VtaPVpn5N4G4Cg0di9UxWhBma65XfhM+GpFioRGDK/R3AM4GZquh/EwjG
 0AaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327147; x=1780931947;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=u1lcsLIobScldpWx6WSR7/N2rSVozhhuMPVVUCbPDt4=;
 b=ZrUwgTCkkHfLW8+stR2oHSdpeBGip2822B5CyJ8eEyy8CFm+Hu5Tht5RBAbyskFGOe
 QgRX+tLC4/Ogzlo6M1Fjp1GkO+azVfmrAET5NtChHKbVXTefcn8MNNvtJft2hCHKg+G6
 alhxLB86f96OfvI/2KbXRTTETPfbym5B3PlGuEV3nI8omH3vXorpMwGLIC34pti+uDkb
 6m0aKYgQpnVmDTUqKvx7xd6+4z40q7UUD3rT5UzFxprpmhFgwpJvNvWx7ItTHNCQk86W
 QIxBb9Gabh5mSbUTYnUWNlXuMkd553xIvj2nr8LwG0Eo0goxZHn+bvIsm7WHmjorYYoy
 D/3g==
X-Forwarded-Encrypted: i=1;
 AFNElJ+MF0UWSKoB1uwg74GBdCyTuYWEhzybUiQcF1soFHSxxr8kKy4UioPzTNwSnZ2W8t3ms0QxyQdTPrE=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy3tldphVvBkxedT69XmbrTprgwKY2SQvFjDU8i7WD8sNGZ+p9D
 OTIj6I/0ha2ltx1XFk7nCPUG1JIJRQHqvRqjMZ4vPUDzGR7lV5X+iLYU
X-Gm-Gg: Acq92OFoJ0bNiVxPSLaOozgf8j1mEqhPxPKPLTUO2MjO2gXXVxBXg5JvJLWrW1q2870
 jV6ys/vMPT6IIl3J0yT3q9ta15G4JO8q9BolrlTRrCBi+7RVMrrNGx1Zy+4CWOOPWICutD1TO0L
 N8ObWvESG17quL0CKlaWxI8vpulnxh3ynoisbVbeRxzclHrKNUV4T9Z2dyrn2vKhsLlH/7gH3tx
 /PmBMShpS2Aa0d779J20Y8fprcjMxrHrcQd4Ao9H2i0FA6AJpni3aeaimZJvfXMo+5aFHEzXtpI
 I/Uy6p27UUjy3DbDYIKl1H1LpUiNgAfIhbv8gmxocpkXv0Ar58DoRfIFo3tj0IWzzuKcCV849lm
 SORoA8Cf5npwZN5COZkENzHe4T8d4t1E2h8i2lTqzlDt4qVhrQHdC5ER5oJSab2EKefoWAkOre2
 Tz6zF3al0D4i63M8xx53Dqvrg=
X-Received: by 2002:a05:6000:40c7:b0:460:cfc:eb24 with SMTP id
 ffacd0b85a97d-4600cfced10mr13759481f8f.22.1780327146823; 
 Mon, 01 Jun 2026 08:19:06 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:19:06 -0700 (PDT)
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
Subject: [PATCH v3 06/11] mfd: lm3533: Add support for VIN power supply
Date: Mon,  1 Jun 2026 18:18:26 +0300
Message-ID: <20260601151831.76350-7-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260601151831.76350-1-clamor95@gmail.com>
References: <20260601151831.76350-1-clamor95@gmail.com>
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
index d57c2cdf11c5..4dca5641b774 100644
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
@@ -334,7 +346,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 		}
 	}
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
 				 LM3533_BOOST_FREQ_MASK,
@@ -458,6 +472,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index 3fd8d4737ea5..9ee99be93d9b 100644
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
2.51.0

