Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F1946CD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:06 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57FEB1134A2;
	Mon,  1 Jun 2026 15:19:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="mPjCkgG4";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1A25111349A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:19:04 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45ef29c5561so1690641f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:19:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780327142; x=1780931942; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Y382WZZPSXgqkJt8F6mrSdOVSYmocK83eFeJ1TSWQE4=;
 b=mPjCkgG4pUQcQgPSPkUlmcsh/ocKDG/hBIp1WMRAwlWdEit1iItFX1KUwjMUcv91hZ
 mlc9IQPg9JJ8rm08Y9IA8a+IyQeYRQU4THeZhqWG+ffQ27Rjn3xvzqCSZPqonYguSiFG
 TwKnBa3culGTs064XOs/hTeiCUuY9x8cJc5ThXyD8EvrMIR32JBFdpGrVANUKCvMN711
 yX85NM3sbIkedlGf8ahDtSvObhA3N/XkTtGz23ERFSR8hBhBLmlzHZ8XDL2yqQFgLAxt
 Al+TO+qLP5MzkVvGgH4mhcmejNe+dCAWxMsqcIfvYE8sWpvf/lFJKcC/GsjxMFXL40/k
 6nAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327142; x=1780931942;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Y382WZZPSXgqkJt8F6mrSdOVSYmocK83eFeJ1TSWQE4=;
 b=YWa2tQdmRpL5SePSz7+0doTl0bIrJtK9wsZe9VO/LWVFGiDpl/M6ujUzYpkLEzj4EJ
 +0YcBSkkazLWUo9EF2YaAroQ/F6DBjii3BCHn2fpd3CFVsBye6YQoRedZQrh4R45oUIJ
 mGokoDjjKwsnWVI72X20RAlACosZtrJqLxkXbDz1SuC49BQfG2Llw0XiLB6H5bMZvEyI
 htN7MiJV1DZJoeMv8KgZKPxx3WV9Pnbx02t+FH05oxYw6nMu00hergWUBh1nxjiMkx+w
 d3Mtnrmg7/NqXIBo/eSlqoxHsi4gMJMMnK7itVNhFcIHuGJKxIuRyoYwc0vY2uspRHeh
 CU0w==
X-Forwarded-Encrypted: i=1;
 AFNElJ+gdx/hniYbfmiJjtLMaZj6HC/d4/KZaYEsucp8fl/wE5X1kxVGV/je/M1SFcX/s0rphuHJU4qAhvU=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yzzxv3o5qizU62e/d5E99VCZvODtfHli8ebrW4Uu9BnV1X1NlFx
 9NVANSmBXeZHWjVO35MuwIIENntLFeNK8ZDo7ja8MXefLIfuHD2n5/FQ
X-Gm-Gg: Acq92OEVi6cxsQfojCEPLyqSUYUxumUOVmDqe3dUNZ0+XBUkUuijF3qKvOQ5dkW9T8u
 +H0FfyToz8q2SmuCyQOVmXgSNPwHObMoNI1ng483NbXNReVoOOqlUzJCG/Jv4mgnKNO8/29USwU
 9ZQb8TKg3VzwFn+bMLiaa54t6xlvqe2nWviaNevFfER49a4itXJIxwqvh7UUun1MWzVlqI2pTYD
 qWko4s1qGFxpKH4TqyySAV7D9kU+KsweP29ztdHh1RTDtcxCw34AEb8VwJH60pwv5+phl+BC3gS
 Q2eRk3XWtUCnqsoxBOCqL+r44tLG8GEnEw80mI31gCUL4dhn+DD1FY+GdkRaxePMMRBamT//B4r
 dGJ9q+mWW9fDXLNehPoHZv3DRELxoumnR3vlKW/WK2XgKpHokgmVlF6hmqeyvYBGnTNcqZIR5ig
 3sqZ6T6aPEQBtlxPkiqM8PmKs=
X-Received: by 2002:a05:6000:4c8:b0:45e:ea3a:47d6 with SMTP id
 ffacd0b85a97d-45ef6b93b94mr15555475f8f.32.1780327142357; 
 Mon, 01 Jun 2026 08:19:02 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.00
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:19:01 -0700 (PDT)
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
Subject: [PATCH v3 03/11] iio: light: lm3533-als: Remove redundant pdata
 helpers
Date: Mon,  1 Jun 2026 18:18:23 +0300
Message-ID: <20260601151831.76350-4-clamor95@gmail.com>
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

The lm3533_als_set_input_mode and lm3533_als_set_resistor functions are
used only in lm3533_als_setup. Incorporate their code into
lm3533_als_setup directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c | 61 +++++++++-------------------------
 1 file changed, 16 insertions(+), 45 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index fb61904f110f..52136ca1abc9 100644
--- a/drivers/iio/light/lm3533-als.c
+++ b/drivers/iio/light/lm3533-als.c
@@ -716,61 +716,32 @@ static const struct attribute_group lm3533_als_attribute_group = {
 	.attrs = lm3533_als_attributes
 };
 
-static int lm3533_als_set_input_mode(struct lm3533_als *als, bool pwm_mode)
-{
-	u8 mask = LM3533_ALS_INPUT_MODE_MASK;
-	u8 val;
-	int ret;
-
-	if (pwm_mode)
-		val = mask;	/* pwm input */
-	else
-		val = 0;	/* analog input */
-
-	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
-				 mask, val);
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
-	ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
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
+	ret = regmap_update_bits(als->lm3533->regmap, LM3533_REG_ALS_CONF,
+				 LM3533_ALS_INPUT_MODE_MASK,
+				 pdata->pwm_mode ? LM3533_ALS_INPUT_MODE_MASK : 0);
 	if (ret)
-		return ret;
+		return dev_err_probe(dev, ret, "failed to set input mode %d\n",
+				     pdata->pwm_mode);
+
 
 	/* ALS input is always high impedance in PWM-mode. */
 	if (!pdata->pwm_mode) {
-		ret = lm3533_als_set_resistor(als, pdata->r_select);
+		if (pdata->r_select < LM3533_ALS_RESISTOR_MIN ||
+		    pdata->r_select > LM3533_ALS_RESISTOR_MAX) {
+			dev_err(&als->pdev->dev, "invalid resistor value\n");
+			return -EINVAL;
+		}
+
+		ret = regmap_write(als->lm3533->regmap, LM3533_REG_ALS_RESISTOR_SELECT,
+				   pdata->r_select);
 		if (ret)
-			return ret;
+			return dev_err_probe(dev, ret, "failed to set resistor\n");
 	}
 
 	return 0;
-- 
2.51.0

