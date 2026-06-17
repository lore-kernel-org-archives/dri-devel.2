Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0987CCD98F0
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:01:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 79A6810EE95;
	Wed, 17 Jun 2026 08:01:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="G4TOASw2";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 26C9310EE89
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:00:58 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-beeba001887so706181766b.3
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683257; x=1782288057; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BStSfLs2cVd2uwZhDXiQO2uYMri4qNRZ0wt5dxl+TLw=;
 b=G4TOASw2a7pUMreq9rWsDh+ZV05NW0W7YRfNTZJiqJp2Q8FL+fqukcd3WKKJzzvzMM
 ryIzBZynmXqhUvV2riIHXDSAQ8G3oIJeNr7iNrSwisCVMgMXYiyZkXlwGiWiZVqXta9z
 ZSiIgc2DFd7HvFCm2I/dksY1HQbwjNCcIhB6NoewDkfjLXqpZRLsIarazCHHLyYE29Al
 VVn3eUWGfBc0KGh7PN2EAHNdsds1BRJ33Q5QKZraINXtm/yxqXEGeCkDpKAatptgL/Nv
 PndG4YeUIAk/6A5FreRczYoiErAZ84fkGUNP2i21UesieJVZW4f/monHzqBwkGeoiWj4
 Biyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683257; x=1782288057;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to;
 bh=BStSfLs2cVd2uwZhDXiQO2uYMri4qNRZ0wt5dxl+TLw=;
 b=KvgRBY1T1Ri+I5/nDM5rlSS70HGJcHP5vTCMthMgcHo7sGAtowVISeYNGrU+aHgpVR
 mRNFyHGbMTnXMz8AjW7um7ITeLpi/SMQTNcFm7NeBp4EUgPRQb0iO0Ec2EnwK83yALTO
 80rOKso8QcpNkcqsbz5VHvQxiMpwTFSUt5h2H3GKa5ZqYilO/0ggu/A56h2GbN8qe2Fh
 Oy0NtvZEWTmi31sGCCsWLZ3h88dbsd8Y0MeOxiY0bZy/sGdgsrPGrscHvDhAOSx6+ISE
 7kvTY0DfvJAwiCWkA4f/4KEIQV8dG5weQh5MM8OfgIF8mlwXEUdpiGxwLugiFOnZztyi
 aXEQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ8bvlLXpUyDrUHgPtwcSePPblVzBx12iUieEvSsz0CaFIX0lIqmml4QuIrs6m/E6UJy7DCs0/gOr1k=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyQ72fuTr4DOsugDLtgGZlYeq+hwFS/aEdzEDxnh/2JgwJklkl7
 za421dHV0I0M4i6/ntl1tgSkivLgFgZBQRS++ekR76cZEkimbCDv3rbO
X-Gm-Gg: AfdE7clsZt4mLV3KpdULYmLdPxIEOVsTAapYSJZkhQrWEHI5Tn+WjyFMW8/MPQD14bx
 IMUHU/IodLv5dL5C/ReIrCqT/PngEtbwWKZNLRjF/AIYeByCubTPxHYtUHkX+j+3ZHucOzmTMdN
 Aw9H47ERi2lqPJFVzlLXxyN87GqAmufZEX/Xhoq5xhmHJa8zgghDJFvkDxJ1zfmyYy9//EndEFu
 mLgjTgAxEqa8FPSVWZDe5qGSWG9oFx+VdmQOyI9cVTaBOMHPE079gOOFGLyqTa0wAmeXumu30Jn
 qcttjdF1uNkbmYtRc6z7Me/rUDaiAl9gGL9ecIaqplY/2fZxTiLZ54Tkk+kaO6TdSWoHUqJVQs4
 UqLeiyl/sHsYIL7vxNnUCfUEh8q/PWLku7kiI/GPuLioLJpbLIxTbWbgEvo4uryJvmbzhFWPEfT
 L+AA==
X-Received: by 2002:a17:907:928d:b0:bd5:405c:7964 with SMTP id
 a640c23a62f3a-c05a5219b56mr201079366b.48.1781683256443; 
 Wed, 17 Jun 2026 01:00:56 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.55
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:56 -0700 (PDT)
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
Subject: [PATCH v5 10/14] mfd: lm3533: Set DMA mask
Date: Wed, 17 Jun 2026 11:00:27 +0300
Message-ID: <20260617080031.99156-11-clamor95@gmail.com>
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
index 4b5d94e9ed27..db8581d1b073 100644
--- a/drivers/mfd/lm3533-core.c
+++ b/drivers/mfd/lm3533-core.c
@@ -480,6 +480,10 @@ static int lm3533_i2c_probe(struct i2c_client *i2c)
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

