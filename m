Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B4687CD8C8C
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 1ADC2112D09;
	Sat,  6 Jun 2026 04:58:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="ZbBtwS9Q";
	dkim-atps=neutral
Received: from mail-ej1-f44.google.com (mail-ej1-f44.google.com
 [209.85.218.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7ABDD112D07
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:43 +0000 (UTC)
Received: by mail-ej1-f44.google.com with SMTP id
 a640c23a62f3a-bf046d4da1fso267319166b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721922; x=1781326722; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=tMzv/S8Y4Icyy6C4SSXqpDWOb9w1xnX2+g+CSvM++O4=;
 b=ZbBtwS9Q4KV8dyNwnOrUd8Udi281USjKIB/smLEoYNHqZf9C2XSFKIJ34pIiD4GRLg
 vsN7SWGJHQLdZNYRSeo6rdIIzr21FS9vf2LA1Z1hevJXDCjw/V0fT0p3CgkCFepuOCDX
 fnm+M+tPWVxOFlrI8H9jS3JT9aYJO5W/oLknqKVgAIQM11gsjfMrLr8cG2W/JKxvtRcw
 Nxyq53VnE23NnLUtNmkX+3sRldPGc2Ik5erQynAvRZt+33WPPOgyhd2ldslnW6AwHPbI
 zzBEPri9Fin9AC/9HkeGGzVJBhg4quXGQ7+RyP/j4N20lB3LoWSsMELwCYL+bwa/GS7V
 TiIw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721922; x=1781326722;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=tMzv/S8Y4Icyy6C4SSXqpDWOb9w1xnX2+g+CSvM++O4=;
 b=Y0mgmwNnxd+kAh/dVUBKQ7erXen4YXyfgF81ylSiCxZxQWqpp5DYjed16/sx/tBMRu
 ylCWxdQ+PuddgN47quQg9vt2P2cke+YyLMM7G77DgAAOXph53u7U5A0XEg1fltITkr1v
 MnyU2H3yYrgeNyZ25MtP4gL4gqZRPnzr/HQHMfLtq6z2JfVeuxRLpJb55UlZwvEsIrex
 hzoVhIipJqw5G7szvaoGVUOIQEeY+nXyZLbJ8e5TzbQHWIJwGVlxOe+taQqJzkomjYkF
 yGzTqy5b3udD1mObv/+MMn0at9Z+IptWGTszjH2kTVGO6CW9UTwq5teiqGYv4boSrcse
 JJJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8CM/FQUwS1Q/Gn6XckLrUhi7D74/GWvTluX6+qZ5s1hHhWLO/sqJwZGLG+UuoqLUlsRZRgGTmOCvw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzwSVO927MKIKpNhpblo1TBnJe/ZmL7L+HdI8NJ+tL0vBUsGPKs
 wKzNs4zDZYp5P1u0g+ezmvH6e7/MfGSKqUVa4LGIn/tEbKJ/T09Wn9bF
X-Gm-Gg: Acq92OEn103LjDVauyY7+krPo0LhDSza6J1yyLyLkLIbU0NfTnqZxILy/51DAeAh7m3
 lbjJ4JNQyk/b/N36fqUfnGX97iGTUcsMMsm/DPTeNekfOtsPi6/F3Tkx8Y/uamSYlwGsprGwC4I
 7QmgIu+MVMOPLpSX+CZFvast9fSruVeWHDJgygO8+Fw1Knq8eqpvedqxHcT9ZtWnscB8ZxvOAOi
 oxgG2HHYXWdyxnuzVMPrLZ6yMqtjwMQ0/Doz/fkUfnFHbMAzqykph+jKypf7ap2GedMYPGIZoOs
 4hc6kTPxSkkDOiTaLM6ag7OqXyM8CL7G/qq1qPtzly/icKQ2Gq9aqQCQCZKolSbnzuXvHmBQoqZ
 j9RKIFjCLtejDWisUErJ3Lk0ylBnA+TchTCULMxkiScPZXnWTfEUHGer+tgCVwZN3YYbUJs58Ix
 q6I+aEnrMmWA6kKVgbAnd6A7DdvyBIh4lM9A==
X-Received: by 2002:a17:907:6d05:b0:bed:afd7:185 with SMTP id
 a640c23a62f3a-bf3737ed359mr332707666b.43.1780721921881; 
 Fri, 05 Jun 2026 21:58:41 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.38
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:40 -0700 (PDT)
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
Subject: [PATCH v4 12/14] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
Date: Sat,  6 Jun 2026 07:57:36 +0300
Message-ID: <20260606045738.21050-13-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 9ad7ea1bbbcc..4f8cde9f290d 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -37,6 +37,7 @@ struct lm3533_bl {
 	u32 pwm;
 
 	bool have_als;
+	bool linear;
 };
 
 
@@ -226,8 +227,14 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = regmap_assign_bits(bl->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 CTRLBANK_AB_BCONF_MODE(ctrlbank), bl->linear);
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -281,6 +288,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	props.max_brightness = LM3533_BL_MAX_BRIGHTNESS;
 	props.brightness = default_brightness;
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
-- 
2.53.0

