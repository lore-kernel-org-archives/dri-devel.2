Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B61E7CD4F54
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:51:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F100C10F1E5;
	Thu, 28 May 2026 13:51:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="kNZjbxQ+";
	dkim-atps=neutral
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com
 [209.85.218.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CB99110F1E2
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:51:54 +0000 (UTC)
Received: by mail-ej1-f47.google.com with SMTP id
 a640c23a62f3a-bd21ffaca79so2343260066b.0
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:51:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779976313; x=1780581113; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=8RF2xk6t5S9a3BXZ1svw/IWrQWbafQA9obLcpKPhSUU=;
 b=kNZjbxQ+1xIPHHUcHov62vtBlNkT+00419VEhux223+1E/0BOINb06+eunCXE3ptmO
 GrNrKN6fzgEWX4YiXon7CIb9EzNXNOoeNsE5Jtjj2O06I9/4DgMcC+jBTr3JAVdY0VZq
 M7/pMj8ygmcc3BdsG2407zQGEhZzxhlCMPQoaUQ+u6h3hasGN19tzsg8TfmHw7nEaduH
 y07DjSUjHlK9KV/n6fZVY6titiZbeuO7OaWpizBvylqnaR2GJHm3m2NOQKd79Sm72CRb
 ApEvF59LVG/B1tl8FTQX3NOfkD9yGAHn+JtS7sQqwt6L38Te+cJYUV8sQKMFi/oizHs6
 i54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976313; x=1780581113;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=8RF2xk6t5S9a3BXZ1svw/IWrQWbafQA9obLcpKPhSUU=;
 b=a+xkygOP/IvCw+osBL2BSxydVgV0N2wryDkklrCr0Qj8ymtfWzUvil27slbqh58dG/
 aenT3z669zSVFL3aK81xe6oL1JIRGLU/JSgjdQY+B17r7HPP9lt2sGgozF8+zJpCmZgo
 mvwxK3p/8IFKkEAIpJyECpQJ0Hucdz0dZ6LIT2fqkgwRrbkccPfl/l1wEWXBm0ZJgAvB
 m3rutt/Rox6jsSlPfb4y+7vAR+6ZCOEvy1CuOy0I61XmoxOIy6W2LKRBgX4Iw+0tYHmL
 vz5PGm4Kj1U3PkxaKRuDwWNJEQNLx5mdDjd2rgoY0kb26Qc1KVfs3h/rDT8279UwDECi
 LP0Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/dqJEHm6jDIeg9x+lFrCFCWhT2gDdQaWG1/a5zZXOy7ayTgxBT6xrylouyyaYggQnithVkQGNrgG0=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxA+ffhmD/t8jkCSfALsqo6vu0OGSz1XFuLDmv/VOKop9YuIVVI
 8Ppof6fNnh1hmxIt1R7wdATOcHG8KArUdTb9zyHo1kbWxT3WG8mdtHHx
X-Gm-Gg: Acq92OFzkzs/0+oySfs2yU8iaGz74IylFy/1f1YAMzqhbZdmjwFWso4UYncWmUYyZjJ
 lzKU35zqDklSIlspca/3iIEXqjGNVysw64BB05pBxBXkIhXyG+IsACNIfH1wY7l7JbX7ext8FyD
 xJMzAygzNOOJHIKBGb1Rq+20mFQkWb74e5qC3ipHtw3QVsVapBN4CtDRx71dd7cJexeZPDKeHqg
 9vGSFU1o0HegfMk1ypirLgf0rKUpZG+A2Del28DmBX+1iYTaktbK+e4cqU8dm+cYodLtxvLck+V
 6jP/y2csMJ9BagqPeNvavvAOXY9w6k1wGVVl5lViSj5Q5DRwGXwQQ7MRXig47y6QSuv9gRRWXSK
 RYMSBcQStDOYCxuMEZiwOoN+MD1zrE/590A9ein5p4E15spI8GzoiFVERg5rli8L2GxFiRsgE5q
 T5R/+jhoIDgEmcL7PeOR24S/cGUkv9Zx5rXA==
X-Received: by 2002:a17:907:1b06:b0:bd5:b27:c02e with SMTP id
 a640c23a62f3a-be86d71c01amr114017466b.6.1779976313029; 
 Thu, 28 May 2026 06:51:53 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.51
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:51:52 -0700 (PDT)
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
Subject: [PATCH v2 3/6] mfd: lm3533: Add support for VIN power supply
Date: Thu, 28 May 2026 16:51:20 +0300
Message-ID: <20260528135123.103745-4-clamor95@gmail.com>
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

Add support for 2.7V-5.5V VIN power supply.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c  | 23 +++++++++++++++++++++--
 include/linux/mfd/lm3533.h |  2 ++
 2 files changed, 23 insertions(+), 2 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 8495e9119871..519f8c16a3f3 100644
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
@@ -164,14 +165,25 @@ static int lm3533_set_lvled_config(struct lm3533 *lm3533, u8 lvled, u8 led)
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
@@ -324,7 +336,9 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 	u32 count = 0, reg;
 	int ret;
 
-	lm3533_enable(lm3533);
+	ret = lm3533_enable(lm3533);
+	if (ret)
+		return ret;
 
 	device_for_each_child_node_scoped(lm3533->dev, child) {
 		if (!fwnode_device_is_available(child))
@@ -493,6 +507,11 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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
index 3aa962d4c747..d751773fc92d 100644
--- a/include/linux/mfd/lm3533.h
+++ b/include/linux/mfd/lm3533.h
@@ -21,6 +21,7 @@
 struct device;
 struct gpio_desc;
 struct regmap;
+struct regulator;
 
 struct lm3533 {
 	struct device *dev;
@@ -28,6 +29,7 @@ struct lm3533 {
 	struct regmap *regmap;
 
 	struct gpio_desc *hwen;
+	struct regulator *vin_supply;
 
 	u32 boost_ovp;
 	u32 boost_freq;
-- 
2.51.0

