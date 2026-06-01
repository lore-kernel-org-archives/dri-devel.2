Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 203B8CD6E57
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7B1C51134B2;
	Mon,  1 Jun 2026 15:19:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="shLZdV9/";
	dkim-atps=neutral
Received: from mail-wm1-f50.google.com (mail-wm1-f50.google.com
 [209.85.128.50])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6B5791134A4
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:19:05 +0000 (UTC)
Received: by mail-wm1-f50.google.com with SMTP id
 5b1f17b1804b1-490af320e2aso4146125e9.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:19:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780327144; x=1780931944; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kHipHX0fj9UFI6kqkRtr6SnJM0WlhcDH4RQJ2Kh7RME=;
 b=shLZdV9/yRNXl93qZGv+rotMYqsTbczyjjQpIg6CVuYpQTmxBoMlaCXaCNGfBILgVw
 2/aErAfpsnRJVca0yLj4+QIKvoWL8IvU2wg7VrQHqX4rQCeqWARc4bEehrBZ9Sm0GkcN
 K/mbUWZhXykFUs3JOCpAuKS7Lw6LUNUnUea85BwGQ6mPvG8iGgQRdxJ24xYeAz+t8hAH
 a9D7SWOOw2F45woC2OYdP/hJ5/rV/QOdtszh7BvkyZjNg8rhobzIwsrnOdMyr0ma2MMn
 gF2iX3j6Q0HMGoSChj9ZfDqWM+g+5zTfN8YF4PcwM+lk2uuF+x3i+INufJNs8yQoFHXw
 08Kw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327144; x=1780931944;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=kHipHX0fj9UFI6kqkRtr6SnJM0WlhcDH4RQJ2Kh7RME=;
 b=gxnHDqq79PuLYCp2dm+PglQad1/mpv3pc6cDCgncyRJPWwkBF4t1qf9dyxeULCMvq0
 fAH/KUKMgz/Xknh8Nq6k6fEyXFH2ORFzBIwiPjFPguMLmkskbhBz35bbU7/TCZ/qmsKA
 QRedmrGhnfoKN8Q9sg9/7MOU5X3q0BNacrWxv6h5BGkH3mXotnxKqMXs0SZU/mnirCaY
 P7x2+4PIPlj5vzVtnw0ywz9O49RKXsvMhbVldajlNRSmG3HhOsvYnkmvjUn3dlAQxyYA
 /WRJ/L+QskKbimtWHBdlk2RPXSvICWGqdN6QviTKDdkzrvypDht6BxfB1xmBFeOZ9wST
 fA7g==
X-Forwarded-Encrypted: i=1;
 AFNElJ8Q7K3I/vgLJSuKSZ2d/3q+euRvJUZXURNevZqULj3QYpF3aSNQ7+Zx5cHaLtsNQGl9j8fj2nqJ5zU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyXcUsYOQWpE3TDf34G56j8ctNeVK6cGiwuG7XBG65hHs4GcNri
 PCLnZc7w+OLqko918G60u2o+S/kAyNuZSSEEJ1YOpN2NXJhymi+SEwpC
X-Gm-Gg: Acq92OGQ3TSSCG+Nad4E5AskMVjm4g5F5GjPK2qzyokgcHD8bIGPXT6Eagk/vig58Po
 l+sxSKB++Nhicpd24b7KddjeiMVnUq0kN8npd/kXW2nHDb+mywiAGXS+LqD4sOwQ8AV17auCcr7
 8E5gHtoGE5r9SLT6FcuWvkEImtDi/WTUtCt42elA7rfomebBB09F5J6FzxSBkD2OnaiJrsUJJ4G
 EyfwP5aql5XE9Y8YV27WjDxi5EeP8m7SlapZbuIdVyLpbsW0sa4N/gWAOdC5EVfft48zCAp+tj6
 f4UYzKkrFGzFRlhpVs3WMsK7s+V0aD/P16jNbTbdNedwZd8z6DoLDDBLuF7Zhd9yTIeqykrxRt7
 9j3EhMjkAhXMimuD7jumT4+CC3hFFhAX56MXVIPLNURgBhPi+X9nG/NKyVOkk/RoIYwR3o0zVoM
 nM72NymtMUNX9EUtRBDcFY5os=
X-Received: by 2002:a05:600d:8444:20b0:490:7136:ad02 with SMTP id
 5b1f17b1804b1-490b078f2d5mr5481165e9.7.1780327143862; 
 Mon, 01 Jun 2026 08:19:03 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:19:03 -0700 (PDT)
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
Subject: [PATCH v3 04/11] mfd: lm3533-core: Remove redundant pdata helpers
Date: Mon,  1 Jun 2026 18:18:24 +0300
Message-ID: <20260601151831.76350-5-clamor95@gmail.com>
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

The lm3533_set_boost_freq and lm3533_set_boost_ovp functions are used only
in lm3533_device_setup, which in turn is only called by
lm3533_device_init. Incorporate their code directly into
lm3533_device_init to simplify driver readability.

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
2.51.0

