Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 53BC1CD6E75
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A78F1112CF9;
	Sat,  6 Jun 2026 04:58:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ayMQI9o1";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 29C26112D02
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:24 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-befee9e5ef7so283275366b.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721903; x=1781326703; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=wS67jochwubseohJgYpjn1pYUwemo5z+ytbVISXPDzc=;
 b=ayMQI9o1psLvwUlGltieMxy4FLtNEd/5KacIiBdl/EArglxDOnxldzMr6o3YNb6cC3
 TAaVlw1URARlC9JKZ5KPE0pEZ4UR6n8/n7VvzEju9llPbHjc3nqTKGlx63rNb3rfGW4e
 tOJTi4eh2QdGEuNq5fJPlJsl0ABhop7Q4bdVxES608IPYm9NEE10LGyJxTPu7Yj5+Q7X
 S5kYUlHrP0ft3HgsZcfw8Y9ihz1q5ueJzFcjPLGIMvwU60DXbfOt8WEsbCIP/mt+7Duo
 Q2DnSyHhAC8NPZFEc6J9O9jw3WJht4NlARLyCvchc5NUP497YZCPU9QhSKU/FXXyRQY8
 A1zA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721903; x=1781326703;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=wS67jochwubseohJgYpjn1pYUwemo5z+ytbVISXPDzc=;
 b=BJr+SGhsa+2HDSiHQunWeQo0FJnlM+wjRrZxo5Qn3goe96BraBcdcYSVqofrke9ign
 1YsaCeXd9pwX3wfsYEGDcKi9boErCJxj4PASpyp5DA+VjNYgU8T58zDLmxvJQlW+5s9x
 P22ka2K/19e5+fD62QX6Ya64tFLajX9v9icRM92E1glpNlONrpVzi3oPKk2NdJ6Bdb8I
 2px586Jwu2R4i9ZiLkAd8wR3r9Izz1krQauwaccRDiEo2pKRYRVZ4K281apPPYTx/m5W
 Y2xwkjMCOGp5SnyzMJ+l9sS7vzpwVRFnUCdtvX5+yNcmfIY1vv1qH/N1TEncwUodEeJo
 jomA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8lc6NvDY1EIxtTrdWlqj1EznMeEaVcqwYM10/x/1vGAz2Hr+vwJvHYvlyZ4ZpckFAm7Omm6dQUtIk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yy0f8AmCZb5178DnLSws/7yXjV5TNPKg0Lis+JnT8hj5bVvpybA
 CALNJI7U0sUUlpKc/OaLj9Lh8OzSHg782Qtn8ROpLUNudwOtecB5oB4u
X-Gm-Gg: Acq92OG6J5s+qpS8b4KbF/t/qnF1aAfS77sMcfwGE8jsBaCSbIAXuxajHXD7y6pXeIQ
 MA6cR96FSmzLtr16qYPKlHb5bblyL40/jwznwx5FhhHNZMogs62R45M6q2qUxMTgX3wt54B8ZaB
 Lhp6y2YTJE52d63RT9fT1W7ta5rq3lXpZfRD/RXh1DrlMZnj5Fkxd6JqVMdJpJ6OcnwYY0owUtW
 RdJBK+Qld3X8yvzoKU1vdT4oHvUZKcqyxwD+hvLK98zO4jzxNLDP8DLcjLKXOUTiXqBoesWM/ZM
 kJKUZUi064oUa6w3UNis7fA6wPknXo3x7NrWn0qCIjbGDm2xwF80u8/nSMt20WFuzZIreJTcW8Z
 KbH8Ff/a0ISKRWERPxdryaJ185w4OevUED4KiPe9aT62gSQQu7Zrm4+V+IHJzTTpYOr/vEYaAL0
 CV/qV5wOFbmvQaNlGHKdyyGhM=
X-Received: by 2002:a17:907:3fa1:b0:bdd:378:3f2a with SMTP id
 a640c23a62f3a-bf372d28da4mr313211866b.38.1780721902322; 
 Fri, 05 Jun 2026 21:58:22 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.18
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:20 -0700 (PDT)
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
Subject: [PATCH v4 06/14] mfd: lm3533-core: Remove redundant pdata helpers
Date: Sat,  6 Jun 2026 07:57:30 +0300
Message-ID: <20260606045738.21050-7-clamor95@gmail.com>
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
2.53.0

