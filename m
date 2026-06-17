Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AA3EACD98F4
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B026810EE89;
	Wed, 17 Jun 2026 08:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="csEQc3Gx";
	dkim-atps=neutral
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com
 [209.85.218.49])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 4F47B10EE89
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:01:01 +0000 (UTC)
Received: by mail-ej1-f49.google.com with SMTP id
 a640c23a62f3a-bebc80100efso558879566b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683260; x=1782288060; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=iTLq06Trmxaj5LKPvLHLVj78rBrJr8ohTB02upYl/fw=;
 b=csEQc3GxXS+dVwW28WqCpJCzsL1S/nkxeR5wf5lbI8f+kkod5SWHLgmbh4eiAJ+V79
 zWdpVNk/CntS4T5dW1hMFyavObZaMaFqlCP6EzO4Jk1q+9+JlKpkkfTguQqboqrIbdDB
 JTQ7p32pVbloQPGPKDcrDf2Nv4VlqhEgC+UTTRBdJToGJ920oAI2edpCV40Ez3Ci5M5q
 8nQNQtyx2mpDjRONu4ifnPl56ZvnvM02Q/ZT3YHwXk31KbxPvKGo+BoLwn0CYlRE06g5
 MaZBwdEHkzj45WekSCZ+WbhqyCrlEmcx+Yxa7XycUzj7fki6fCDLztLJzWz9zj8bDhI6
 fvGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683260; x=1782288060;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=iTLq06Trmxaj5LKPvLHLVj78rBrJr8ohTB02upYl/fw=;
 b=Z/Rr8qRHFb+mAmFyFuNFZ2N+EOJ91qQBZZg+2T8NIlEH0odzq7YZhuF+6qm7kp+6sd
 Fc5wGpA4D8HKbhirF8syzaHG1S2yDU8uYeiUUH12u1Uu4mBeksvmA2rPEEiIez3of/qb
 uZLjOLuExniK36fPqNtWg7EBXW0K6LLw3hh6UK/tDU7B6lt1VnEBypStB66Kaoweb4FS
 TZZiwetYyktVpXSdbeyJF4Zi6hXQ2pLXWh/Pn3sSlNciCBfo0E2YFz2OQqBXQC3PVZ09
 o6Se2Vnyl4N1LDaZADCmaW9fbjHurgeVrTR12vwuI5ndF7Ky1pSaITtYBCucxEkmCKIG
 SFXg==
X-Forwarded-Encrypted: i=1;
 AFNElJ8LBTNY3EOngImB6SzCDyVcdpOyB6dQf3NxApbo8zvcHd49P27+/C5CKkMxXwqckL1rQq9sTmY2x+E=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwBrnBx8EqWLmNoya7chFir+MbiQ7cxb5l04rvYKOa9PXJVc+Ng
 ACz6jw9lWJArkT7LLpdBUEL6g+TghfqfcVGY9XBWTJvZGlPy0ksFB7qO
X-Gm-Gg: Acq92OEQGoeMo+867Hr/MXMF8Z20grHDkKM4Jpdhp3uKufx6o8rgBsR9arDn4qH5ME9
 TgdYvYpDzNVE8PtjttfxOItojJqINE9Z+dozZ14/VsmnO2QDbbD2PTUVvQ2iKQbqKY+6dgQlLTw
 wUtqtPPmuf0CPaExJznryUkLzyHb7BDRFNvcWvGUDrdi2WjZuZa/PUgd/vTCq67szKBfWE0w5xz
 P3pivFk5IjlpvZlpORJBpkNRAMiFYWExHqDYkaDIlP+GHl6ItIFHOoy+GMRWCg5ASAhOQECIsGH
 WnsOpgNyNGBBiWwCa/iD8xvyR+hoRB6ycI7jIHd626qrIlGuTnMBdGvNjOh8lYF2Y6XOMIkE8Al
 jXC64Na5bCpGXXmU9FI0LmJDQG+DzGg2g/zF2YRCIA4Z6rnC6xsx3PjEXOY321F70W0rgWbrq7u
 u1Aw==
X-Received: by 2002:a17:907:da4:b0:bf9:ad4f:4437 with SMTP id
 a640c23a62f3a-c05a6105803mr189014466b.3.1781683259392; 
 Wed, 17 Jun 2026 01:00:59 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.57
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:58 -0700 (PDT)
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
Subject: [PATCH v5 12/14] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
Date: Wed, 17 Jun 2026 11:00:29 +0300
Message-ID: <20260617080031.99156-13-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 9eb0db640948..d003d5802508 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -37,6 +37,7 @@ struct lm3533_bl {
 	u32 pwm;
 
 	bool have_als;
+	bool linear;
 };
 
 
@@ -231,8 +232,14 @@ static const struct attribute_group *lm3533_bl_attribute_groups[] = {
 
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
@@ -286,6 +293,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
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

