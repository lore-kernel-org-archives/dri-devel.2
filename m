Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BBFD9CD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2CE63112D06;
	Sat,  6 Jun 2026 04:58:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="Neptt8cA";
	dkim-atps=neutral
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com
 [209.85.218.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A0E85112D06
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:36 +0000 (UTC)
Received: by mail-ej1-f51.google.com with SMTP id
 a640c23a62f3a-bed4f2f0898so325160666b.3
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721915; x=1781326715; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=gRUfH60NeaMpCaCx84KeDTGgGO9ytSJVg0ZaUrTfvB4=;
 b=Neptt8cA3DhBZHAHez0Q4hF9jGmQHAl/Y/qwCufW2RrWWgvD4oobd4i5JwjiQISzLI
 zlcfNGItqY1Syu3GXwsJCyG4qOPqAKuVDKR83ozZapfPcIkb1uskr0ywzDE4z7J3F723
 NO6SlP1UObX7DvneB8Gp2EUUzcSIJSIvzdpn/seLeO8I+h86pna5qNG6P9t+q9gXcqly
 2MUtYwHyodKceK/Vb3+/EoZBrv7ndOlQbdneH2o2kGV1EID1VWbZmhudzsS/gloHXw/l
 oX73YHtWjpyIk5rAaCTuLxlkA/T7RZLZFAimonCOkU9ieYlxJ3NJXiECWYYiyByk/9fR
 m90Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721915; x=1781326715;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=gRUfH60NeaMpCaCx84KeDTGgGO9ytSJVg0ZaUrTfvB4=;
 b=tVsJ6xwGfr2MHX56uWxUHDf2261lMaLS/J425AjCL8FsX71ft3xW/tUNeiZbEUw2mg
 AS7spkb7GUKJIWIL71h6TP6ZMXZw8tZxTSJ2y57EHGAoJ6i0obGUsIh8rKB+9Gze6laj
 XkjqNoeBembKaFOKEhsi3SEj6pad/qDnBx1qwvfF3+nhg++KhLQ+UEAyQdYBv1HHwgJf
 HDY3lJyRVjwXLKR2Na1r8cSnnmQmLl8tUSL+H3QfR6OL6YY7ydieD2O7BFve1eT1jnxH
 +2hjw1fCSg5NgAx++pQvWa+2HGcUTgGHR3DVQW+N2OS+O4z4Dc/2CFT1TErJ7y0pcz3b
 nm6g==
X-Forwarded-Encrypted: i=1;
 AFNElJ/B1xkY4jltsBu8rGu8fCjkYhwyyJdl4yOAILN9JudBYHOnPszbaIzqW/r0ZjUjQg8yIwmpYH9vjNA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzG+eKDNKCg/36PEKgpLiYBiXMy/Qz0q71ZyZnhyagLl2tqPGQu
 aA9ITU0qetcNzwLILmcz+iQt2DkQ2UqFvz0Y7v9HlmKCcGJ5YUgb+cBT
X-Gm-Gg: Acq92OFNh7T5bRhodxoGDJKyxnnX3vhg5ma7XYsPXouFxg2cLC7eZJ+1AuIjR6fN/M3
 XUNQme6OR2ekh2w2phzc05Qf8gPCRDLpKVsZSvH+bo0VxWLupR+cQkchuzTlSkpgPUCbECtvloH
 bSKb/3jVQWuOdJloaE9l/udBSwVFBrliPez6O3dIhvCjOSVD8kRoRX1ItkqgRJG6scVYc3FI2CI
 sdEA1TkXAlmLjvDZ0hBmM58R5EMjhpbYip4llxXolGFQZnaPOXiLfd5vS3euvWTLRsFVFxIpNFM
 HKRa0+D7FUG0lAIdv1nPwcyuRqVICg89z5w6aNoUBqfbZenrYA7i+SkPfbtwOpBeho93QoVqzTV
 Yl8xqVtphKssMqifC9zpHml0a9hljVFKVOvpzBV0oMJdDTU2CzwKAH3pByQVNy9vI/WO8XGnXW+
 p+SpAuy3Wzk3uHQq+c4Kb6CRo=
X-Received: by 2002:a17:907:e117:b0:bed:62c1:ec with SMTP id
 a640c23a62f3a-bf3704783c0mr169855366b.13.1780721915036; 
 Fri, 05 Jun 2026 21:58:35 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.58.31
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:33 -0700 (PDT)
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
Subject: [PATCH v4 10/14] mfd: lm3533: Set DMA mask
Date: Sat,  6 Jun 2026 07:57:34 +0300
Message-ID: <20260606045738.21050-11-clamor95@gmail.com>
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

Missing coherent_dma_mask assigning triggers the following warning in
dmesg:

[    3.287872] platform lm3533-backlight.0: DMA mask not set

Since this warning might be elevated to an error in the future, set
coherent_dma_mask to zero because both the core and cells do not utilize
DMA.

Signed-off-by: Svyatoslav Ryhel <clamor95@gmail.com>
---
 drivers/mfd/lm3533-core.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/mfd/lm3533-core.c b/drivers/mfd/lm3533-core.c
index 500cec3cceba..5d17da1d998b 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -489,6 +489,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
 				   LM3533_BOOST_FREQ_MAX);
 	lm3533->boost_freq = lm3533->boost_freq / (500 * KILO) - 1;
 
+	/* LM3533 and child devices do not use DMA */
+	i2c->dev.coherent_dma_mask = 0;
+	i2c->dev.dma_mask = &i2c->dev.coherent_dma_mask;
+
 	return lm3533_device_init(lm3533);
 }
 
-- 
2.53.0

