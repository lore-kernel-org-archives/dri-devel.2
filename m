Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34981CD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 96A1B112D07;
	Sat,  6 Jun 2026 04:58:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bprZFxqZ";
	dkim-atps=neutral
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com
 [209.85.218.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EB695112D07
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:46 +0000 (UTC)
Received: by mail-ej1-f45.google.com with SMTP id
 a640c23a62f3a-bec354815b9so282211866b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721925; x=1781326725; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=aMkYm2wLFurUx2dgxyb2h52E5PnRVf0UR593PbHgI/g=;
 b=bprZFxqZON9OotBgj8WmgsP/FNg3Z1iBU7WUaBTlwCfrFDRDG9ozeXoI3DEHAHIC52
 Qx4f/6B3hQnGZY3SUSwoL3FEr6wONjwZ/mwX38NI7PcAz8Jl7OLoOYVOfrG03wG4D3C1
 6pgX2kUj01O/NFzESwd5MKQ52q4Eq6dlSP/vvINjzOcWnQkD1O98rsA9yEIKXCI//7yu
 D/pvkh5/S31nRiz84UDeqwTfu2w6JvQmrKDVXQUbQgjqL4/3qhcsJolx3rVgYDqOZcfc
 oYzX0K3IW9iaDfjo8Z4oXOneycfIQ0nfheOjCIdT8VIzonXfy/vVZg9/3bLfulXKqEUi
 0JGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721925; x=1781326725;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=aMkYm2wLFurUx2dgxyb2h52E5PnRVf0UR593PbHgI/g=;
 b=bodBhSXgofvQEoGVRNupOp2t++l939iJBUDnKMBmkk7wFVzrNjv82bX2tmu3oifOia
 QUznKEqFve5xNSmpFjBDotR2hefbFacQ0i63mjdLUIpnwz1LFrWSEjqDyAPR7cEV9Jgy
 d0lVHykzEyah9GHAzV4waGb/geS3265w3oBYY8yDKbqsh8DmX4NpJ59FOQIzAdXr1EQ3
 YdyrjO8iAE38/NIG9NlytjTLrWceuxvlS+p9qX1lVgYVVzLvQJunOPn9CmL+t1pJRaVV
 b/apsymG1dGMD+iy1+zqV30T1qbj7G/49JwcZwuuv6wAtxUobND3qQTI0DvT1iRfon/B
 gc/Q==
X-Forwarded-Encrypted: i=1;
 AFNElJ99ghHWA0jKtBrtf/lrvN7uBotm7QoPzY/7mFX8WDkZh/DwfXWYkKxLoSdRGS2QyfWNFUETDxAzgMY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw9WVgOvW59VYO9Uw3ReBAWLNKD2jvLfs105tWkribLwVA6teGi
 zLHan36utQI3AhIn0MYZHrDdH3umQ0HQYVSr88mOZ/p92vCQ8/yloROJ
X-Gm-Gg: Acq92OF/JYAyYv01IYSsE552vH8po0cQuKZm3Jd8IYju5S5RRwJqqzOz0Mr3dCxWYwN
 NjbAP8l3EQRyYLvuRUOBTSw/ilP3VSOWNpnnZyQREytFnt8h/BlkUuWwAFFvTCkrUIjEDllXPUe
 CpITQkYcTx9S2QtKLMzzT5p9nJtDOsjJ7WUmQnRqcp2mhsYKbIqw+6HlZIkDqCd8OPtRykJE7Gv
 RcJUmS2zjFgBHwzx+MPMrH89o97760Gn4ZP88lWNm6/1MRhP8ynOYlej0KQBX4cKVQjpQgCkFJz
 YxK59UEn6gxZNvs4+jJIipRzgUnhuEXQjOD9hMcqdVQOGyrIxsvlUx0cDrHKa87nJxFcAW6E06w
 DByg2p/etUIFZZFtx0uYgYjSGAP4IUIRXT9q65VFdXE78c7NJkvV9LUTvoz5axkaZ6F7yFYwour
 kOjcP3kddL8VEejL+qiU3LjHg=
X-Received: by 2002:a17:906:f5aa:b0:bec:157:a630 with SMTP id
 a640c23a62f3a-bf3721598f7mr362897366b.23.1780721925345; 
 Fri, 05 Jun 2026 21:58:45 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.42
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:43 -0700 (PDT)
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
Subject: [PATCH v4 13/14] video: backlight: lm3533_bl: Implement
 backlight_scale property
Date: Sat,  6 Jun 2026 07:57:37 +0300
Message-ID: <20260606045738.21050-14-clamor95@gmail.com>
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

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index 4f8cde9f290d..2aa4b86042ff 100644
--- a/drivers/video/backlight/lm3533_bl.c
+++ b/drivers/video/backlight/lm3533_bl.c
@@ -142,6 +142,7 @@ static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
 {
 	struct lm3533_bl *bl = dev_get_drvdata(dev);
 	int ctrlbank = lm3533_bl_get_ctrlbank_id(bl);
+	struct backlight_device *bd = bl->bd;
 	unsigned long linear;
 	int ret;
 
@@ -153,6 +154,9 @@ static ssize_t store_linear(struct device *dev, struct device_attribute *attr,
 	if (ret)
 		return ret;
 
+	bd->props.scale = linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
+
 	return len;
 }
 
@@ -290,6 +294,8 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
+	props.scale = bl->linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
 
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
-- 
2.53.0

