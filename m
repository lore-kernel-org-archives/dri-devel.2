Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D5683C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:37:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3C2E210F22D;
	Fri, 31 Jul 2026 11:37:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="N4upsCq5";
	dkim-atps=neutral
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com
 [209.85.221.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 527AE10F235
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:37:23 +0000 (UTC)
Received: by mail-wr1-f53.google.com with SMTP id
 ffacd0b85a97d-47f3b39f2a1so191419f8f.2
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:37:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497842; x=1786102642; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=PPCwNXXQzUx5SzGc5RGFQWtwM4MIgHKgBLvTAnTdtiI=;
 b=N4upsCq5iOhLPWHwWaaDkaEHu984XDGxBzpzUUpvDQRratsWlXZis4uPah3QCN55HG
 bOWb62qFsuzjLvhX2rc1nl4r/aCSApXehd4S/Inq8jmk1ycKsb3PhQunlckKGQh2S8q/
 y/xuqNygkHaK/fT9U5gBgqTHVJeaOn4f+WoCfrLt2LJza/4ve6qZfh2HG9F4xcFclj3C
 /5uaLOK432aEn40gUE1IF5v+xt9D0uqjH7NImA+lS1+8Ta5pzWoZT1tDYuq0MCRhblql
 bgqaJ18gUTnxeVsAqe76l2fEwDO2lvgsuwDYid4TFWTxp6LZazJ0s+f3/3T6vx9XW93j
 TFSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497842; x=1786102642;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=PPCwNXXQzUx5SzGc5RGFQWtwM4MIgHKgBLvTAnTdtiI=;
 b=Q18mMPD+evLio00+JUL3Hh05tF1Psvq10aBZuMyd0/TN/wMzTOF2aSB4WRcgUP4g6o
 IDwpwIa1jgmfZ2zMM4BycsvpA19O37tXciuwvk6lGCg2r14CSESPG+/lbLWZDzYoH5cn
 p/xTxD3S0VOGy1VfuW42sp8uiWhEBnjEWYnwyR4R+wyTl5F4T9X1SxeI9TN9sZJvHiLF
 s0jtyBmUO7EW2Ab/LUz8azELjFAS1X5rvx5wnr+CohWJPmdjzrET8xFb0a7jSK8EAJcw
 sfL8LnOD1EvulHHNhcUdVB59qOQ3XNQw6nIqMjdWT7PUJ9GsBYLiyisMb4wpIaA+yKXe
 uisw==
X-Forwarded-Encrypted: i=1;
 AHgh+Rqu0f7pPa10PMnLDN6mtKR7YDjNqPIIz1F3M7ahjk0BT0igNtkF2SoNykHKZSVlHIQDa84m4Ase5nw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywkq4GXY6fKHJPrmP5IP0VJVkwizBQXkKIBH/XSn48j1zbqkXV+
 72qG7dofokEIshKirGAvE5SxQhPBfJQHYXCICUPu+NRVXO/EQeW6CV7z
X-Gm-Gg: AR+sD12k7xbhmaFg+eiK2p5odH5v4+FVrqd2cd+3H+maxdWl7JXFcx6HNShuVR6fFDQ
 hEyCHkFwdd02fO2AMyI/I0tYCxhdWyownrkfplvAmNma1HDgwH5s/IATFz3XJQZ88J81c7LNt1o
 kvPt5zoHyozjozKv9V9UrCaasAwh4921RzaDhz2aVaRQg9shtbnQw2qjWzkeopVOPR2+h/8LX/U
 E5ahD7ZZFUHZPOfrfHKZUyviBSwjsvhMW7NV3+8rFknQ6rKYduPQNRujubuatAtxD+X1NB0PcE1
 KjsTzDJv2OhfReehkyGX4McgjasSkRXZMR+J7tqZ01esdvnRPXvlRRiOuWB6n+H8wfKa9uVaI+0
 A1GsZnD+guJdd9mdN6X7DqwECl8wYmPGaqu4cHxnQjKr6A5PXeQs8ZJ4HRzCLR3VvrI7WvGnTBj
 bW3curqK0f/2CZk4sLBUKLBhPUfaHcwEjuhzEuQnD7Zj2kCZxRVygvJ2BRB7lRoGBIVVYRQUk1A
 XNf2gXYJA==
X-Received: by 2002:a05:6000:29c2:b0:478:4de8:9b91 with SMTP id
 ffacd0b85a97d-47fd2b55e06mr2408925f8f.41.1785497841644; 
 Fri, 31 Jul 2026 04:37:21 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.37.19
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:37:20 -0700 (PDT)
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
Subject: [PATCH v6 13/14] video: backlight: lm3533_bl: Implement
 backlight_scale property
Date: Fri, 31 Jul 2026 14:36:31 +0300
Message-ID: <20260731113632.158440-14-clamor95@gmail.com>
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

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 666213cab667a..adcd6ac7cf229 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -141,6 +141,7 @@ static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
+	struct backlight_device *bd = bl->bd;
 	unsigned long linear;
 	int ret;
 
@@ -152,6 +153,9 @@ static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	bd->props.scale = linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
+
 	return len;
 }
 
@@ -294,6 +298,8 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
+	props.scale = bl->linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
 
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
-- 
2.53.0

