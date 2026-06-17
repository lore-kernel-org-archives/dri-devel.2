Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7B70FCD98ED
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:01:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2AE2F10EE96;
	Wed, 17 Jun 2026 08:01:05 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="sJGepwxZ";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A086D10EE89
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:01:02 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-bef1e6423e7so597863966b.1
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:01:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683261; x=1782288061; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Bd9XYaCysxrts0G4Y5wJXzVAEaPGW9YIawHblvLTeko=;
 b=sJGepwxZ1/hdhBxatjJK9kKB8mIXQKU8Hh2bx7uytmJkWx3X31IPxdV5O7eoDLXvn1
 yFlLWSsWZGfm3Ij2pE0bDzGW/axqSmchrWARQjUObHW90XcY42yvZTw+0/uyDmWFZTmz
 iBmQHGWDOfHkqweub/+7dr0Rfcb3GPhYUYZ8/5QAkmQ76HujvsfbOw8qgWvD0R3RFvpg
 yZYjHYQ0DLq/bPSXTtQO5r+9VWteZaN7EMlbyVEdaLXhhpPR+CZLWAYskS+brIJF7TBl
 HHsoiY1DVQ4/FK1kJ04CbiDCwszJ5w80d8BrMZJePTxte9MjtmyNS6OTnI2B0cxL8YLA
 zAjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683261; x=1782288061;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=Bd9XYaCysxrts0G4Y5wJXzVAEaPGW9YIawHblvLTeko=;
 b=N7P5fKnEbUQCKTVWa4/ndo42fDEOColAY+S9kpoU7YrJZ0Q6X1n7PncfRG37RwR7Fh
 G/LVTw9syJxPALwwtfBGEnxlwIlWGHn+XQeKxtcB29ht54B4hRGWE6h4G2EuOyICjk3f
 VmXeBVCPZ0RDN2Aknie4RLyvnyI1/DLvnNLrjjj5DICJY9jdu/rG8iskYxt6l/ZUETq+
 bf1N+b9DwGlJk/l2HF+J3S8vxmuzI3+vHnBZ5krbeYvAJbq0GImxMajRQ8y4ydgv2LKx
 y0b4CqEF7NsF11GACQcjLqBrznuGhETI81OrPgO5e5nu1jbD1bLAPsMPgxVDvG04AOR+
 iAOA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8xDRrMB8kqEHnMPVkp2V2K7KV0tdlu2q14eyT2fN4TUITqFbUweEEm3f/Mc+DWR0TV6jmHNAQLbH8=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YybpwFo/zwpp1hIi1XvYZqMOq0MvzYLt03zBrWLEW3vgVbrarFj
 H/AfeZm0GlXCb0fNUFxikT+0eFvb9prO1zocJQaK5c9fNjVwSIX9W+qR
X-Gm-Gg: Acq92OFvZUluDrrnI+eRuViTv7hFINYEncje6Qr6sGyk/CvdrkkOLOYLve7HU6TQu54
 BfnjRH2ThZvSMaD1nXnK28+fVbMUMOPSzU0cgnqJitnhZeGc06NnVQGPFcJ0itikKwtUCFRDau2
 70CLMKaASkwwoHaRNFNVxtW2lZ8KZl/Ae9ECCjvYBP0Mancs4boep7sr3U4lHaHvaHhqy2Cc36O
 x3BHtDKdM/Y9HNp5zoScXJZ70hplyO/vlMeKNrZFzpVSGx17DR9Ngfx/WylsbdVBFUZv528rUG+
 yJm7v2LLZJIYrMYeeIdA8UH7vTKF/kn+0Y91nHg2NUm8DUlBIKt47S32GhcbNiSe5TYU8H/551w
 rD0VdBo3ax8HRYRuqiYOl8GbRrVJYEOgaIiGWdwP4ovAqJrpWLakw3BBxWl6jtHF9jkSjdJ2jLT
 bJ5A==
X-Received: by 2002:a17:907:b03:b0:bee:875d:af12 with SMTP id
 a640c23a62f3a-c05a09bc11dmr128164966b.0.1781683260892; 
 Wed, 17 Jun 2026 01:01:00 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:01:00 -0700 (PDT)
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
Subject: [PATCH v5 13/14] video: backlight: lm3533_bl: Implement
 backlight_scale property
Date: Wed, 17 Jun 2026 11:00:30 +0300
Message-ID: <20260617080031.99156-14-clamor95@gmail.com>
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

Since the device supports linear and non-linear modes, implement the
backlight_scale property to describe this state.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
Reviewed-by: Daniel Thompson (RISCstar) <danielt@kernel.org>
---
 drivers/video/backlight/lm3533_bl.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/video/backlight/lm3533_bl.c b/drivers/video/backlight/lm3533_bl.c
index d003d5802508..c99fc68cb669 100644
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
 
@@ -295,6 +299,8 @@ static int lm3533_bl_probe(struct platform_device *pdev)
 
 	bl->linear = device_property_read_bool(&pdev->dev,
 					       "ti,linear-mapping-mode");
+	props.scale = bl->linear ? BACKLIGHT_SCALE_LINEAR :
+				   BACKLIGHT_SCALE_NON_LINEAR;
 
 	bd = devm_backlight_device_register(&pdev->dev, name, &pdev->dev,
 					    bl, &lm3533_bl_ops, &props);
-- 
2.53.0

