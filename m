Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7EFE0CD6E75
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:22 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DE660112CFE;
	Sat,  6 Jun 2026 04:58:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="PnPPSfe2";
	dkim-atps=neutral
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com
 [209.85.218.41])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82634112CFC
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:20 +0000 (UTC)
Received: by mail-ej1-f41.google.com with SMTP id
 a640c23a62f3a-bec49f7e35eso353326666b.2
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721899; x=1781326699; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=YqXfwtTZgGLv1WLyA0/ZZTY8n+25azMFw/42UfL9a9I=;
 b=PnPPSfe2EaaWJFt3wquXHxq3wx7Ma3OJ5v0EClF8AUnYRx9HV/zNVnKTrRkRss6yvF
 WNUqWSVGfAoVYMuQ9t/kDHz8dAS9nWTUhPLPR1fUT9Olh+nlZQaLOKl4q6oM7BF4LNs/
 JUQr0OmMvm0VScO8nK/sFidObtAgLoJor25W4l6JKH0vGoPB2nTtgvYu9udxDiiFKd8b
 p4maT3zHj+Nv4dntVpkXng0+rZw98HN6DqGfCOP8fns9mbzkyKk1uUt/l7fIJI2X0M5T
 lGZJUhU+a08Z9oF9nSDugQ6zwAhJm0ZJa1fZSqSLkqbnAvTzYWxf/Fhoe0r1lWAix2DH
 pS6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721899; x=1781326699;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=YqXfwtTZgGLv1WLyA0/ZZTY8n+25azMFw/42UfL9a9I=;
 b=VqqQX67Yi9Tk3G/F63PcrnQDcZ7FeNzza0HvmNPSDvo2WUJukNGZZ46kB8UmdAsvZ1
 T72iWk5Ui5ABSkUQTJUumU7H58ayr1m9ekEbA1Al4ex62R93NWLiEfZIZyPpOQjzuxx0
 Ztwl62++3ham3gtYFahrj2hXNgw7mB3kfyuQLZsIjxkPT1lzyr3LwQn+inGIkyAR1rvw
 7ITde0M5fzQRuo++0fWh0xKozBFNDwlFYUE5O9W+XqxPpKF0ZZYUifQfLqwHom3D+JEv
 FPk8muHlXbqsEQz3uprzKxwYcfqy33hC5QQPOIFGnOA4fezbTeQiPlz0E/0cCvslD4kI
 pk/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ/l4FjSzSPuf9FB0C+LlbVcq8u80VOsAlSpKCANBWxsoHdMQJLUKKQe5R9lCy936sz4aoIaYSHkyzQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxyXmn0UO3UF/AdTNH12GcfSey5pY9QdxPkob+vm03w7c62Zonl
 ph3+AoLlY1Vfz5Jd4ltOzda+oJgJ2lq8qJAPAsWEo3gADmoD0/91hQki
X-Gm-Gg: Acq92OEGPKtpq/NU/ITqSJo45PbP3RFuj2ryaHtYA/RtPsTB6vbn0WQ/+NOQGKB8G5k
 9ELCGFezR4Q0BhwqSLDfUeRMI1PtrvXUxRGF38JrR718cLhhsg1EA6PEKES6tEn8oFK9aDT0VNu
 g7EDEDPzW9Pc+62nl7tquo91LJN0yn51382op8Bz5RWCuJ2nTUWlGGwugM5fMLMzQ5d9gHf5vAY
 TuCsPaME7vRGz8oqfpAEV1hdpin+fP7f1m8gi1WBnp7XKSK2ajZVPKO3OcAferDElNPJwQDTn/T
 tcuG0x8CTf8GZh6iJOrwYOsOApXeBSaGAKc1k06Be8EVetRs1rONBpS233FZoD3qy5v25m7pEi4
 VvzZDgE7zzllw0sS4wcOC8HA4K1GqEzERP9O3ejn6L+cIAQJ4+nFC/NfcDc++Tf2R7Ngu6TaSpF
 iv54xAjZLWOH3oienxJGjEWxQ=
X-Received: by 2002:a17:907:60cb:b0:bee:4562:32fa with SMTP id
 a640c23a62f3a-bf3708686cdmr334213566b.14.1780721898847; 
 Fri, 05 Jun 2026 21:58:18 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:17 -0700 (PDT)
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
Subject: [PATCH v4 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
Date: Sat,  6 Jun 2026 07:57:29 +0300
Message-ID: <20260606045738.21050-6-clamor95@gmail.com>
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

The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
used only in lm3533_als_setup. Incorporate their code into
lm3533_als_setup directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c | 51 +++++++++-------------------------
 1 file changed, 13 insertions(+), 38 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index a9af8e2b965f..c4035d1c8d57 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -708,54 +708,29 @@ static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
-{
-	int ret;
-
-	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
-				 LM3533_ALS_INPUT_MODE_MASK, pwm_mode);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set input mode %d\n",
-								pwm_mode);
-		return ret;
-	}
-
-	return 0;
-}
-
-static int lm3533_als_set_resistor(struct lm3533_als *als, u8 val)
-{
-	int ret;
-
-	if (val < LM3533_ALS_RESISTOR_MIN || val > LM3533_ALS_RESISTOR_MAX) {
-		dev_err(&als->pdev->dev, "invalid resistor value\n");
-		return -EINVAL;
-	}
-
-	ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
-			   val);
-	if (ret) {
-		dev_err(&als->pdev->dev, "failed to set resistor\n");
-		return ret;
-	}
-
-	return 0;
-}
-
 static int lm3533_als_setup(struct lm3533_als *als,
 			    const struct lm3533_als_platform_data *pdata)
 {
+	struct device *dev = &als->pdev->dev;
 	int ret;
 
-	ret = lm3533_als_set_input_mode(als, pdata->pwm_mode);
+	ret = regmap_assign_bits(als->regmap, LM3533_REG_ALS_CONF,
+				 LM3533_ALS_INPUT_MODE_MASK, pdata->pwm_mode);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
+				     pdata->pwm_mode);
 
 	/* ALS input is always high impedance in PWM-mode. */
 	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
+		if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
+		    pdata->r_select > LM3533_ALS_RESISTOR_MAX)
+			return dev_err_probe(dev, -EINVAL,
+					     "invalid resistor value\n");
+
+		ret = regmap_write(als->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
+				   pdata->r_select);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "failed to set resistor\n");
 	}
 
 	return 0;
-- 
2.53.0

