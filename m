Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7806BCD5BD1
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C156E11349A;
	Mon,  1 Jun 2026 15:19:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="aQQG97PA";
	dkim-atps=neutral
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com
 [209.85.221.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BFC3811349A
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:19:12 +0000 (UTC)
Received: by mail-wr1-f54.google.com with SMTP id
 ffacd0b85a97d-45ef6565cfdso1306609f8f.0
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:19:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780327151; x=1780931951; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=nMbWeeGe7TfgpPAVjQgWggP+Fym0ITJZjA/DygAtKOs=;
 b=aQQG97PA1AJz0wpLbwTva8yJMvi3cbzx7nXnE5dcpukp2ySKCZxXy6Mef2lVjghGch
 0HNmuh8ZuV7OAGgeOqKL3ySRc3Z3oMXX8aJBt51v+08tIoABwd1XFQVhCf1AsfnudOkr
 AHU9cbXyu9U6UH+QcDEUxiTI3lBwjLyPXBRdNb88zlDN0ioh8VvEEFjKPOxguQtw8SDr
 gH0SYRSssz/QcUQL9MQagISL2Lqm+n7/WulKf+cpyCz9Ch3W5pKHpmRudZrQXG3WFgIF
 nmDZ9oqdY3paTPCSyZ3IxF9ryJdcr4wzzq9cSgnkc0/kr2VYXEoJZM7cdi5YsLae9ULs
 nqQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327151; x=1780931951;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=nMbWeeGe7TfgpPAVjQgWggP+Fym0ITJZjA/DygAtKOs=;
 b=nCoT0hepG3/4BHevxEH9jVaFgYrQP4UXCVELa9BM2MOw/eJBQ4prltkBtO08WOBDqr
 1LOwh6rH7XRfzSS4mP0yeDvDSGv/Q4F74FQKt2sMXUZcW701ptrskDIAH6Kv7og/G7NO
 sVocU5He1aaIQ10h4/ewejxFEOyP0fTgaRgVgv3vlOw6637W/xeF8SOjVx1imIk1E0yE
 1sLwVHLEOKr33gAifZ4C7idorjFBsBGiP954L/rBTnbJ36PnIQyOBE/JXYzIb+JLlt4E
 QdGroUUK2cZdtxxUcUubbXiTf/romQ6bKaI1np5UxdZ+wkzojp0ez31YlrJkwQxHUyvX
 U9mw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/NH4hduZkkpmazo72ftUaCEg35zF+FCcSpkff0G2mAXewQpjGMwrVcZf48unznvvYIcIijG4cNyHY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzRyuhPGO7BoKxaj23xgmze4WGTEOe+PqbtIMIu7Pfq8ROH4EHM
 F6E1yIgWMqxig6Dd/CLGcRzODeaBOB2pB9zIBGwAvlKGS0UhpKlKIs1J
X-Gm-Gg: Acq92OGt+kS7BEzf43IBDlR1pZVoX4Hd1v26W2jmSla7Vd363/wrGEKoqAbSC6/2w3d
 3u1l556CTaD9emNtpqGCrHBpsYsyUatCTxFlzAA/6owdDYzsC/IWjZ03/nuf8dwDnNBJ9BAE1KE
 f45R6PT525zId1ln69gus5uaVH65/8aWSeGs/GkP3XMVjARTWf6SCkAX/4KRvOEcAhul4IrHg31
 ix+u3rsXd71RL9kH8VaDJg6VoCzN5Jf+4CPuS+HaQ9iHO2MQwYHgFeFc5SoGCDP0XkBNf0TLaGP
 Uc5Hht5vmnmZU3Y4rVF/09FzjhHJhqkqA5xfusR9qybi3knIxRs5OGxaEUHB9xpS0pUZv5TC00F
 z26tLCAaV7qQ62zzanR6v9qBkJp4UhmSt+AheXnpPKF48b/ntTimg2wCL8yivp+keZqkCAU7/bu
 bTaS0ATZq2WQjNutfCC1OJ+RY=
X-Received: by 2002:adf:f190:0:b0:44f:9b70:2996 with SMTP id
 ffacd0b85a97d-45ef6b4f4f5mr15476481f8f.21.1780327151236; 
 Mon, 01 Jun 2026 08:19:11 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:19:10 -0700 (PDT)
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
Subject: [PATCH v3 09/11] video: backlight: lm3533_bl: Set initial mapping
 mode from DT
Date: Mon,  1 Jun 2026 18:18:29 +0300
Message-ID: <20260601151831.76350-10-clamor95@gmail.com>
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

Add support to obtain the initial mapping mode from DT instead of leaving
it unconfigured.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 36e6f027613a..f0d88b7bc229 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -34,6 +34,7 @@ struct lm3533_bl {
 
 	u32 max_current;
 	u32 pwm;
+	bool linear;
 };
 
 
@@ -247,8 +248,15 @@ static struct attribute_group lm3533_bl_attribute_group = {
 
 static int lm3533_bl_setup(struct lm3533_bl *bl)
 {
+	int id = lm3533_bl_get_ctrlbank_id(bl);
 	int ret;
 
+	ret = regmap_update_bits(bl->lm3533->regmap, LM3533_REG_CTRLBANK_AB_BCONF,
+				 CTRLBANK_AB_BCONF_MODE(id),
+				 bl->linear ? CTRLBANK_AB_BCONF_MODE(id) : 0);
+	if (ret)
+		return ret;
+
 	ret = lm3533_ctrlbank_set_max_current(&bl->cb, bl->max_current);
 	if (ret)
 		return ret;
@@ -299,6 +307,9 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 	device_property_read_u32(&pdev->dev, "default-brightness",
 				 &props.brightness);
 
+	bl->linear = device_property_read_bool(&pdev->dev,
+					       "ti,linear-mapping-mode");
+
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
 	if (IS_ERR(bd)) {
-- 
2.51.0

