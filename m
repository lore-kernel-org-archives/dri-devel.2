Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C31B3CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:15 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0A8011134A5;
	Mon,  1 Jun 2026 15:19:15 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fFsX/BA5";
	dkim-atps=neutral
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com
 [209.85.128.43])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E82A1134A6
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:19:14 +0000 (UTC)
Received: by mail-wm1-f43.google.com with SMTP id
 5b1f17b1804b1-4906238c62eso82352655e9.3
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:19:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780327153; x=1780931953; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=33jV+tJR7Nm5ReUL1Jncj608Et9Ag1X54glyJfKp5cY=;
 b=fFsX/BA5QmJIJzIRUwHYRxbl0oBDXexOBICZOJ8j+yyteeIuqDhoDkJLwDFjLVb6YE
 VE0GJ/AURm7Jtuof+PTL5xYDSBsm6MNUB5JraidcSabyG5hDBCzR9fI3umAknOtBcCHA
 tkdpfw+PdLT6MtIgyYX+rz+kXr1qIgT8X93SOXPN6uRw20Th3E+YLtwXoWFEBQjdk4Ua
 tqPtmXmiUEit0BF9onZRC31J2XE7i117DGmtN1fLj0MKLwIC7Fm07Xoe8zGTwwmhPG1R
 AZrtsEia5p/uoDaoSXCXIR9ptQtOIjrEu54pjVDWNGw1gCgNVLMV/66g5MdrkeGc4HRQ
 zGEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327153; x=1780931953;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=33jV+tJR7Nm5ReUL1Jncj608Et9Ag1X54glyJfKp5cY=;
 b=Cpu8Duoh0KRmk1S1r5f6b4SVw+ZMLI5bN5jG+RLmriEzcIUDtf3RDTHQAQY/DmpTpB
 /ijZu6608IXrRXsP5lv4tFpw4NxljzQKHI7mAgj/Vt4DEZhpujy6xNwqGO+dnO8umw4z
 Cq+Nu6ROEUItopkoEQmHZZCVR2hjH1tXAyLXni/OYxkm6ZWeXRzv6SPsp5abY7hH6lm3
 If9DSKKJ+M2vBmIweEQeaeOqipBVkuEZdn6hLUlZZT0y8kGDSinsVVmB2MGHOJsOKqWB
 jb5Sd/okZ59BJigEqaukJ74d9w0qKGTG1h1f3hqyet1M/6VrAn91n0n0soqnotPhu9fP
 cWww==
X-Forwarded-Encrypted: i=1;
 AFNElJ/2tp4ALYtoy0ZeOqaf940xYUt3dBWxLTKFyDvlOtDaKpVEOyt6a65+pEktbmRwO6brV54aM1/jdrY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxDeIeKQQ/GEyZTn+OurEQM5+l0MUxJHbLGep55OOqpWMX/DhKY
 WU/HHnGsjRwR8opyNFEhjsxQTz9HHVlG7r01wCKNh5NuLYj4AEPvvYkd
X-Gm-Gg: Acq92OFSWRxm+7sP7kHoVH+pqbMCLPU8FzcmFABulWeAOiFUxYWzlfWKrmf6jG/Pfg6
 ptfokYBc3EmEYhhGk/Hax41ROoya6oOZBmb/cSexDICO9bqqaDl3Qk50H3kwRQb+rtkNanzUtgP
 zvBKYcnocTtUBjpqeX1dv72o4hF4NQkSxZDFevyBQqvy8k9k2XXzeahqJPCcr1n/LB2Rpm6DS7U
 AU7Bwtrbl6HP6EPLBuaLMtO50iU5ideizoybQi07ixy9kk94svQxeyzlIlDqG+5PnXbSpF7fwvN
 NBtUONg873pCMK52HTPXssResP5OrtXOvy+c6v2f4dkCfgWg9iI1/FGltJ9Am7Kw2V5URW+4jBf
 ppnUa3X9e/B/bFbPwKE/zp1XOeQa++E3OVn2dtq5uSEDgoKCOt1mWZgy3IgWXKR18ukbWDyF9eR
 pi9NJ8JE6+Jgps6A4FDHoJ10boRnZ6LieHjw==
X-Received: by 2002:a05:600c:6385:b0:490:40f1:5314 with SMTP id
 5b1f17b1804b1-490a290ec08mr258749965e9.1.1780327152708; 
 Mon, 01 Jun 2026 08:19:12 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.19.11
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:19:12 -0700 (PDT)
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
Subject: [PATCH v3 10/11] video: backlight: lm3533_bl: Implement
 backlight_scale property
Date: Mon,  1 Jun 2026 18:18:30 +0300
Message-ID: <20260601151831.76350-11-clamor95@gmail.com>
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

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/video/backlight/lm3533_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index f0d88b7bc229..945625c54fc4 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -161,6 +161,7 @@ static ssize_t store_linear(struct device *dev,
 					const char *buf, size_t len)
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
+	struct backlight_device *bd = bl->bd;
 	int id = lm3533_bl_get_ctrlbank_id(bl);
 	unsigned long linear;
 	int ret;
@@ -174,6 +175,9 @@ static ssize_t store_linear(struct device *dev,
 	if (ret)
 		return ret;
 
+	bd->props.scale = linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
+
 	return len;
 }
 
@@ -309,6 +313,8 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
+	props.scale = bl->linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
 
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
-- 
2.51.0

