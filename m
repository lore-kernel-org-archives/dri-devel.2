Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C6070C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D11D510F231;
	Fri, 31 Jul 2026 11:37:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Fz9SNOUH";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EEEB010F22D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:37:03 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47de0093c42so184473f8f.3
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:37:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497822; x=1786102622; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NbqFKXAPXCgqFlzsfbnx5DNlo8ULOW4jbUhFKit/7gU=;
 b=Fz9SNOUHaxG2An0XU4GUxzvUp6Y6lLQgkaPWFz0u59Z5fdk7IC/XrPtw0t+Xtx04Ns
 FNiLnFfM6sSvGnQbR/P18ezTYV8Bx7BRteenD2HvMPz73WnWQFIPIDBbVy9hTnIGmMJk
 E2Usz92otVwNgXBtIEUn32QlYrFPtb7aqTHIf/ESJmwO+WY/ysSJsd84lx/v0U2KVOe9
 9sMlBA1wEmYJRAk66CEo7aHPIbNhwmxwCbBv3mL2GRjSYld1NM8a4NOoUg+DmIwbmaYZ
 irawNX0Xdla4ZqAsLYRCSJywtzuW8y7iC0i8xZmIIfmc0eoZLXHmNx7X5vMrf/Pg36vU
 MVEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497822; x=1786102622;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NbqFKXAPXCgqFlzsfbnx5DNlo8ULOW4jbUhFKit/7gU=;
 b=GV+cSfYQl8GkU6Lvkc0VVhxGiT15X3v8PuiBB5P3iACwc2AgqM1CE/ePACjXIAXN+A
 9I24NlY7opuJbIyHJItF149A8Od0y+LwN7Lc9AcMYkorXKk5+pvi2ArwdHH9efuKdZjp
 qgeWBetkCMylsbEBYZNulfn3ZtGzEiR12WXA0CraZuj3kZraWC3hV4XsmuU+EBr9/X7s
 xrfs0CE2uFh9tNjCOwq3uZSsOzGM0YDHLxDzQlH+oVtH0dqTxPk9ICfT7Uon6z+HLySn
 kPTJRL9BIXrR9t2VqwVvr4a6oxPt/kDteoDpOjZcdcZR6bMOJvcZHwL/ntAVDN/Hvvmj
 f+Ig==
X-Forwarded-Encrypted: i=1;
 AHgh+RrhRDil7/uFeqBW/hKkyHX7pUiA68D5pEyd0mmcF9aA/Ej0LdiozvJNmC32EIeViLuaQ1fnA7Wcbz4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyFv+iBJi92RXH522UZ+rC8lk7gqFZy8XCQNgL8o6n/DmVD/jCM
 39DwAPwNoIy5dW0sLA8+oz1+x7x8YZsv8qFpg5vG6xkyAU/YtX2n0HTN
X-Gm-Gg: AR+sD103Uo2VE+kIplxx4dDx1jnKokjDVwBViaKsaMWG473AFHelSLjbzHX9rmYcmpf
 xvvGxkzRd097d1ogUhorhxxlt7hErMN39RWumaN6Pu2pVKf25rkayijg4TNrxExcUSor4N+4qtD
 tShHOiBnVf3/vgyZF7We62eOOYCWZqyeozYQTO1GyZov1HFsbded5sLFUwRWKlj2JrHHPLpl2nr
 zZITOe5lPk46uFo/Lgz8p8GbvJlO2+UROyJJg1vzVhRQi22yfMFRn4OIUraGLli7llM/YvS4ak+
 l3AsqY1kuUyZP06p01EC4SOtnzFLu6eV+aqKXQbRQc0WrDnaBkodQzE45rWWFJP0xQABtu6+QKw
 xSE41Uxo9suUvSxMGUxSCAFUqkZ252wMnATJTz3Zj9MmFn1RPKF4jHaoeQYr5hsWRXPme0/NLG0
 DqdnBgB4piO4vUKH5E1WbkdjOCX6BjxZnd3RHm+Ija5OC5Ovd9tEzZJeYO5z9PncXjq2k7DXi6L
 eMnXUGQHw==
X-Received: by 2002:a05:6000:2997:20b0:47f:9661:6766 with SMTP id
 ffacd0b85a97d-47fd2b9824emr2824366f8f.61.1785497822299; 
 Fri, 31 Jul 2026 04:37:02 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:37:01 -0700 (PDT)
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
Subject: [PATCH v6 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Date: Fri, 31 Jul 2026 14:36:24 +0300
Message-ID: <20260731113632.158440-7-clamor95@gmail.com>
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

The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
only in lm3533_device_setup(), which in turn is only called by
lm3533_device_init(). Incorporate their code directly into
lm3533_device_init() to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 61 ++++++++++-----------------------------
 1 file changed, 15 insertions(+), 46 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index f9bdc0a1d9bec..5baf934fac825 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -7,6 +7,7 @@
  * Author: Johan Hovold <jhovold@gmail.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/module.h>
 #include <linux/init.h>
 #include <linux/kernel.h>
@@ -23,10 +24,7 @@
 
 
 #define LM3533_BOOST_OVP_MASK		0x06
-#define LM3533_BOOST_OVP_SHIFT		1
-
 #define LM3533_BOOST_FREQ_MASK		0x01
-#define LM3533_BOOST_FREQ_SHIFT		0
 
 #define LM3533_BL_ID_MASK		1
 #define LM3533_LED_ID_MASK		3
@@ -80,35 +78,6 @@ static struct mfd_cell lm3533_led_devs[] = {
 	},
 };
 
-static int lm3533_set_boost_freq(struct lm3533 *lm3533,
-						enum lm3533_boost_freq freq)
-{
-	int ret;
-
-	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
-				 LM3533_BOOST_FREQ_MASK,
-				 freq << LM3533_BOOST_FREQ_SHIFT);
-	if (ret)
-		dev_err(lm3533->dev, "failed to set boost frequency\n");
-
-	return ret;
-}
-
-
-static int lm3533_set_boost_ovp(struct lm3533 *lm3533,
-						enum lm3533_boost_ovp ovp)
-{
-	int ret;
-
-	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
-				 LM3533_BOOST_OVP_MASK,
-				 ovp << LM3533_BOOST_OVP_SHIFT);
-	if (ret)
-		dev_err(lm3533->dev, "failed to set boost ovp\n");
-
-	return ret;
-}
-
 /*
  * HVLED output config -- output hvled controlled by backlight bl
  */
@@ -406,18 +375,6 @@ static int lm3533_device_led_init(struct lm3533 *lm3533)
 	return 0;
 }
 
-static int lm3533_device_setup(struct lm3533 *lm3533,
-					struct lm3533_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_set_boost_freq(lm3533, pdata->boost_freq);
-	if (ret)
-		return ret;
-
-	return lm3533_set_boost_ovp(lm3533, pdata->boost_ovp);
-}
-
 static int lm3533_device_init(struct lm3533 *lm3533)
 {
 	struct lm3533_platform_data *pdata = dev_get_platdata(lm3533->dev);
@@ -437,9 +394,21 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 
 	lm3533_enable(lm3533);
 
-	ret = lm3533_device_setup(lm3533, pdata);
-	if (ret)
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_FREQ_MASK,
+				 FIELD_PREP(LM3533_BOOST_FREQ_MASK, pdata->boost_freq));
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost frequency\n");
 		goto err_disable;
+	}
+
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_OVP_MASK,
+				 FIELD_PREP(LM3533_BOOST_OVP_MASK, pdata->boost_ovp));
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost ovp\n");
+		goto err_disable;
+	}
 
 	lm3533_device_als_init(lm3533);
 	lm3533_device_bl_init(lm3533);
-- 
2.53.0

