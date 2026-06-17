Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F14B2CD98EE
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:01:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 64CFC10EE90;
	Wed, 17 Jun 2026 08:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QPiog+sW";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 52A2510EE86
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:00:52 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-bec449d0af2so661508766b.2
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683251; x=1782288051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j8y+i4Wk6Q8lVb7K/zxazYX8oolr+QPONOjz4+CZ6S0=;
 b=QPiog+sWYA/TE2Cu9eXvDtf9yIwN6e2XeK/n5FcQCmIi7OWBVxO2Zm5WepS4a/N3rx
 +yfbTG24KFR0kRIeD5ZAw5d76QVjeycX3D3mHOQ4m2E3j/wp0lWkb5WFkV06bQJYCwkd
 1b6xeTavayENzXzHY7+zTbdMOX9AsCXDBd+ZSo6+T43D6ejYrzhIfTIclUH2VfIUrIJi
 J/+0Gp8TImjQ0ov9JHySGHcgpTfkhfNFLRWX0a0OzxjHHThwMBemJzOmbM4WSjpHANVW
 Lv5AhqiFlonA7wxuzXTwtr4TRohntlcktMT9YtaKuXPmbugfos2LuMgW26JmP3QKZIg4
 eyFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683251; x=1782288051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=j8y+i4Wk6Q8lVb7K/zxazYX8oolr+QPONOjz4+CZ6S0=;
 b=LWPDro2HVUaCLTMUO6J1wRawoWIvflo0lr/6KlE0vi0lO+aNbfz8WMhX9SO0orteAh
 BwJrgPS/xKswi2pom57E5kOoeZPPV9GuE1IAbwP/Gs350p3LPpoIySMkbq1vhjHSXpJj
 9N7+0iQEpfbTjIEyMww47H4blwxhxMTE2jOc0Zuq1ShbUXwff+Os+b+hOPj4tsH0AV0q
 PcdO5Pa2jZgY7kFW94sd2TU2LL/6KS2sDASdqVGmDdHf9mqD6NEpiE/Z/qKVtI3jgWxG
 cLo/S8BVLaTzLV+FduGa8blcyLj/jKjU5e4/4jRHtRRqjyOwMl2s7fmtScXuyO5v+Zrh
 CwMQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/jaBtAl76VG4+/1CW7E177XTVnHeV6axCUgPM7XoqQE0Z843bEZRFKwqr04PseyWaQhaIotMa9Xas=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw6NGKYmXYGf7LznM7Qrsyca0gbKcwthVlP2oGcePzHHR9FH8am
 klijNf4QrA3sVjm+ynqKx+BSfSftIkMpUU0Hdbax9IVMDY8X45ePb0mC
X-Gm-Gg: AfdE7cnQa6RbiJYtvGEtx6NZab5R50N05l0Hz6JrFvP3Bef5AcCDPw+oUNB+D+8scYL
 iR4FarrRRqCz9OwuosqeNeEVvAFCSg3D6q5FdpiUfDVu41+CFTH2Ggj+FVl/e/zivShl1PeV2kq
 ndxYtfbo4VErxn80HJX3M5TRPZi+yiuab3mKJy9CSHPDAGY2CocItHK7BfTvsR0RGtba+y2+a3x
 UX8wX14ugxNW+lDZd87l++l1+WZdNANWQ7mLKHYjF83i6QM0bp5Oim0CJUoHLq769F33XCVAIKF
 Vc4ztjlXyiQhc6wsmlNxKx43TRFUihjR/NknmihE077w/Bz+rG7Q3wqf0b+YzkufMrZ4sZOp4PO
 t2bM5KOOOLTp8Ro90+4zG48DSjLA95ZaZ61FDW8kKV27e5NFY/RkZN/oMp+gzTxyIT9dBKtxwnr
 0OJzKdGYSuOz1m
X-Received: by 2002:a17:907:d02:b0:be2:d66:eb4d with SMTP id
 a640c23a62f3a-c05a7abd063mr208115166b.44.1781683250733; 
 Wed, 17 Jun 2026 01:00:50 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.49
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:50 -0700 (PDT)
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
Subject: [PATCH v5 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Date: Wed, 17 Jun 2026 11:00:23 +0300
Message-ID: <20260617080031.99156-7-clamor95@gmail.com>
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

The lm3533_set_boost_freq() and lm3533_set_boost_ovp() functions are used
only in lm3533_device_setup(), which in turn is only called by
lm3533_device_init(). Incorporate their code directly into
lm3533_device_init() to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 57 ++++++++++-----------------------------
 1 file changed, 14 insertions(+), 43 deletions(-)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index f9bdc0a1d9be..45e7f7481aa0 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -80,35 +80,6 @@ static struct mfd_cell lm3533_led_devs[] = {
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
@@ -406,18 +377,6 @@ static int lm3533_device_led_init(struct lm3533 *lm3533)
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
@@ -437,9 +396,21 @@ static int lm3533_device_init(struct lm3533 *lm3533)
 
 	lm3533_enable(lm3533);
 
-	ret = lm3533_device_setup(lm3533, pdata);
-	if (ret)
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_FREQ_MASK,
+				 pdata->boost_freq << LM3533_BOOST_FREQ_SHIFT);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost frequency\n");
 		goto err_disable;
+	}
+
+	ret = regmap_update_bits(lm3533->regmap, LM3533_REG_BOOST_PWM,
+				 LM3533_BOOST_OVP_MASK,
+				 pdata->boost_ovp << LM3533_BOOST_OVP_SHIFT);
+	if (ret) {
+		dev_err(lm3533->dev, "failed to set boost ovp\n");
+		goto err_disable;
+	}
 
 	lm3533_device_als_init(lm3533);
 	lm3533_device_bl_init(lm3533);
-- 
2.53.0

