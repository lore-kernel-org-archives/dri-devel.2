Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E3D6FCD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:00:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 33C2D10EE7A;
	Wed, 17 Jun 2026 08:00:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="THoZ9MwS";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38CE510EE7C
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:00:52 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-bec3f69d343so780162366b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683251; x=1782288051; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=0zcYkBqsgtm7crDvyj+FVJGVI8rwwbt6ayEuo6Ql52s=;
 b=THoZ9MwS7GtXDKZL1fISmNgSWGmeHdtN4ot6PVsKd6rZVMYB0NqZZvA79w05qSjp98
 CYz/ryLcomiLgomU4tYMKWuPfvMqJ+Ix5s7QUU/fQQufixs7569nTlwyz+4colSVuzUI
 +wJQEOydKa0Yffga9o+QMls9Q/6Ayv9+NYALu1BBuB7yPUmsqStHlED9xOgMKnpXwl+z
 +5zeTHPVhy1o7KgJ9drbVF6JqMz9gxLhHB1VLQIoEtJWC5rgeVSCG05zDJEdRK3L+kHc
 bkIcYNliSXiB0+9lxXPaayVTe1Fuwj/lH79rRlvQYE6J6vocf+OBaE7d2Ea66bGon2rU
 spyA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683251; x=1782288051;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=0zcYkBqsgtm7crDvyj+FVJGVI8rwwbt6ayEuo6Ql52s=;
 b=SRFItZcGODnwRF1E0sa8gNIIqLfbRFq1FhngHgJdhKMHMXffmcK8Bb/YPNwnKZ1if4
 nuTh1Mh9h2YUOkiyW2qbFjMDwNqqLNm9yxsFQWe5dLI0bC+dSStCEd03VkMxMJsxJUgF
 cgK0I332DzE9yBxKrX8mWXGKnEJgWTHZ5YPOV3UU/IWD8t3phW3hmhkbifcdjglhCpBo
 8fB6vH32+JlhuWEoQTqsxSgVIMj/2vBBDgXX4EkYctBLgSM921VUVNDc1LoSo8e3+4JM
 9bSiuLcco5ndOJ+ySTEpxC0noPXwKAJWVGq7wB6BgDsQfqnDfzpK5Dz+Su22Q1pwLLh5
 tFkA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+oa+tJgK9LYzlXDJXZmhTzO8dTCh9imwh1Qsu/kY1d4NXwkKD3XCCBsaDXXhpztcnfLhNOtFaQ//I=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyMkE7ZsFpMAG1Bhg7mloA6g6cRPxwPCtx+uC9oaC4jdC7VcbL8
 KP1mydjlS94E3VKKWFaw1iaR7CiiSYQSsWPvT35PR5NV2acOhgI1PyTs
X-Gm-Gg: Acq92OEtMNbzi09vwSVks/XYnsmh0BlbR2epd8A5rUnRO2WHLhlovWzqazusCOf0y4q
 +O5l3/pCwLPflYhUTzsrHFVgL8jEneXwSO0h1wvoA+T53S785fWvh0ruq93KZ9q5sPrdCdRvKB+
 kQOuzI4NoulrmIDAicGyHR6mZrXU001l2JIggxLENepy6iwtGovoNDOPA/hnM/zpSUkQoQCZ/nb
 0GMaY93apxTjb9rAWlwJEgeFCQT050WCm9oS8FrlaDNBCzepajIe6R4W70TvpkD0B/Z0aLa/RQh
 +1ZO8dSZQAhnFy21bK0xhRMOnkXgR5TFqDVSJBRwXXB8j0ZyjlPWl5HJ0/7TIOPj028S9FScl45
 0wo9OoOUfbYLIMc0u/bIsgLfXGJc+yevqQm23mkTb4OeJFpQSAv5L4+KkQt28KE7Y7L56Scg2GQ
 AsJw==
X-Received: by 2002:a17:906:9fca:b0:c03:b8c6:cc27 with SMTP id
 a640c23a62f3a-c05a6bded8bmr163827566b.24.1781683249238; 
 Wed, 17 Jun 2026 01:00:49 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.47
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:48 -0700 (PDT)
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
Subject: [PATCH v5 05/14] iio: light: lm3533-als: Remove redundant pdata
 helpers
Date: Wed, 17 Jun 2026 11:00:22 +0300
Message-ID: <20260617080031.99156-6-clamor95@gmail.com>
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

The lm3533_als_set_input_mode() and lm3533_als_set_resistor() functions
are used only in lm3533_als_setup(). Incorporate their code into
lm3533_als_setup() directly to simplify driver readability.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/iio/light/lm3533-als.c | 56 ++++++++++------------------------
 1 file changed, 16 insertions(+), 40 deletions(-)

diff --git a/drivers/iio/light/lm3533-als.c b/drivers/iio/light/lm3533-als.c
index a9af8e2b965f..69bac1b202f1 100644
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
+	/* Bail out when in PWM-mode */
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

