Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AF1E3C5516F
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9616710F232;
	Fri, 31 Jul 2026 11:37:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="qrFIAiLr";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DF5C710F22D
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:37:01 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-472326ca506so612084f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:37:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497820; x=1786102620; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=88fGtlotIiUSgMJVrGrIa8cGFo+gZlVN06W7NwNhiU4=;
 b=qrFIAiLrsWcPHF1GR8aOMlYgef4EMG3mZu+bJ0smQFmXox+XKOBK+SklH3YWd6nCzn
 shxA3DegMer7JJ/loU0gPHr7PMB6yWm6faLaDdIWlNn+i/4f5DLWZzhJDgoPgKxSECaN
 mC5tnirRaHdD99p8/FhuMb1Q/EDxCqSpVQ2Hltqz4U+P/HKxE1Bv2IObZfFGV3e6mYVr
 KOOy5D8npysWtk8pCGYx8pEkUjGqwfNfp311sfcADR02JTXvcK2W65i6K1uljbTJf+MM
 LxRDmkTOJv+kh+kNHhFTfo8PFDtdHk5pisX2qZyHzrYKIlHPLYKm53a6eNi/Jxs2t6An
 8Qrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497820; x=1786102620;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=88fGtlotIiUSgMJVrGrIa8cGFo+gZlVN06W7NwNhiU4=;
 b=JIztifJixHPVpEPp9KKOg0oXar5eVqxz18rZcLlaU6R9VbeGNTzszXRBJOtkYdbu4h
 kJYY2sOSwcvtxR/lnErxkKvzT6Lz9qI1WN64Ts43Z89Cqv9IeLssVlkzFtx3DPcD8x/L
 Uo1m/tAMStt67XrB0EiJFA7xMaSM6m4EUwTEF7pqub1vMsMjj4awMuhQpm7HbQKVdTz9
 763XPxWDYuE3eNBcsHFGNsBXDOkIs9UerdgdC8sB522tAwhr5eeCfJXthvF+ER0Elg2g
 aciZaAeWWTYHbnIRi+CkLmldyFR61jCjkrNHqWj0L0fWTmnT40ekXtz9u5IjVEETxsLx
 vjag==
X-Forwarded-Encrypted: i=1;
 AHgh+RpeV/yxMgT2qDZ2vPdvMeZS8ZmSITsX9llan0XkUprX5PQx33/lU+7rHlpZ524P7z6qn/BBLbDKY5Q=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yyu9nJ+bskwDYmdwGfDDQJ6jPU7A0h6ImrBsm746ffi5rsnHD73
 jLG+MPMbVGgaP5Ky/JEzFdj3HFhZB0dKCwmtc5siTsPgxGYmvSF9zc+p
X-Gm-Gg: AR+sD10g9fqqiUnWO8REnF7IkzagT4QQjJgxq+07+z+9tmG7Llr3J3210hjK7jzoFWs
 w+G/QptgmSJsh+s7L6Sobgdlx/ftEOU6yBqQxCe978sYT2BPZY31PxA+HxHGEBdi3Eo8mvSHIVN
 a3FWHNEWtxp1FRJrw4QchGy+lqsWQlnHjgEzYnCHzEDLyy5NOvdb+v3pMHyIPK3N5wcOUXkISQL
 vWOWdVsZvPVatcjOOKTBukJwbOsAlzgXQZb1j8Q4lifoNvu86X877wH57ZPJC8uyJpro5Tu2WPe
 1kSL8qYb9OyBUVHkfKgMnWbHKPa53RNLth50S7nXOFYl6Kp1kXEKqMyZ0/ET1wXQpEkM2ui30GT
 fPU39pwyb/UZmmhySTRxj+oxRtKi423AzQraOIwR+4ij4mdeutB7GrOV5zT4irzR+21GkaVZC35
 psc6pyj6l7aazwi6hT+yy4mzUdJ4EjtNWyrJcFG2EtfuqmsvxJ2ZII3Oj3TbJl5e4mbLOnu6BZB
 WFezH68cw==
X-Received: by 2002:a05:6000:41e6:b0:47f:9171:c59d with SMTP id
 ffacd0b85a97d-47fd2b30babmr3903817f8f.32.1785497820326; 
 Fri, 31 Jul 2026 04:37:00 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:36:59 -0700 (PDT)
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
Subject: [PATCH v6 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
Date: Fri, 31 Jul 2026 14:36:23 +0300
Message-ID: <20260731113632.158440-6-clamor95@gmail.com>
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

The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
are used only in lm3533_als_setup(). Incorporate their code into
lm3533_als_setup() directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Jonathan Cameron <jic23@kernel.org>
---
 drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index a9af8e2b965f8..55c35018704c8 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -708,55 +708,31 @@ static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
+static int lm3533_als_setup(struct lm3533_als *als,
+			    const struct lm3533_als_platform_data *pdata)
 {
+	struct device *dev = &als->pdev->dev;
 	int ret;
 
 	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
-				 LM3533_ALS_INPUT_MODE_MASK, pwm_mode);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
-								pwm_mode);
-		return ret;
-	}
-
-	return 0;
-}
+				 LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_mode);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
+				     pdata->pwm_mode);
 
-static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
-{
-	int ret;
+	/* ALS input is always high impedance in PWM-mode. */
+	if (pdata->pwm_mode)
+		return 0;
 
-	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
-		dev_err(&als->pdev->dev, "invalid resistor value\n");
-		return -EINVAL;
-	}
+	if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
+	    pdata->r_select > LM3533_ALS_RESISTOR_MAX)
+		return dev_err_probe(dev, -EINVAL,
+				     "invalid resistor value\n");
 
 	ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
-			   val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set resistor\n");
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_setup(struct lm3533_als *als,
-			    const struct lm3533_als_platform_data *pdata)
-{
-	int ret;
-
-	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
+			   pdata->r_select);
 	if (ret)
-		return ret;
-
-	/* ALS input is always high impedance in PWM-mode. */
-	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
-		if (ret)
-			return ret;
-	}
+		return dev_err_probe(dev, ret, "failed to set resistor\n");
 
 	return 0;
 }
-- 
2.53.0

