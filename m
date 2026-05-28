Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76D3FCD6E44
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 13:51:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id CF2A310F1E1;
	Thu, 28 May 2026 13:51:50 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="A9/5YpOO";
	dkim-atps=neutral
Received: from mail-ed1-f52.google.com (mail-ed1-f52.google.com
 [209.85.208.52])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 98E1710F1E1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 13:51:49 +0000 (UTC)
Received: by mail-ed1-f52.google.com with SMTP id
 4fb4d7f45d1cf-68acf0a15b3so1501293a12.1
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 06:51:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779976308; x=1780581108; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=DSg6ryVfD5S41bWs4eS7vIgEWozL5e55NM5iPpo1Yvg=;
 b=A9/5YpOOlZR9qEZmogsoDh8SPi5ZPziegz18WWkYkvGz/1vYv7p/4Pgteo+DwIjblQ
 l45kBIgnCqkWMHtHxcvEyu8jr5vsl72c+hbziOEVsoc13fRV8TGNjf4ZBNzbtTGwy/1i
 13aKUsC7Vyi4TeQorHFLViE4+dzQIV5wJjycY+AfHSBBXMCGpXVBonSFlI5912CmlTJ/
 PAB82zpH9KI7tmSI0WBnJn0wJRP2OTPzNVWlhtD9BH+ci+/3lc/d0MBwCo41VRQWqsHf
 7GoPjj93MtmTioCvBLkY3hmJV554bA2SySYZfEYntAo0qzeWet6J2AtKQaHoNBlCCel2
 rKuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779976308; x=1780581108;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=DSg6ryVfD5S41bWs4eS7vIgEWozL5e55NM5iPpo1Yvg=;
 b=QTdTpthmZU2FFEF6cXEBM7oiL09DU8xwcjVCCMuEHZf3Lh2nkZ7OtfSJR/wiOWxz9/
 CndSEGGg2/+GuExl9KTfgaFIKBd6YUfddFhrdh8h4A6Seb6c+5YjFwmJlMxUDUzGfapJ
 bF0GmXHgi94T0It8vFnii4DozLeYXZiD3l3NydBqQiJEM/mdMXK0ZremnpzVbCRCnd5L
 by8SBG+EGmbbJmCVHJgs7QsXNEtDcTmCcgdVVvp4uhZ0AqeR6vTJvs+lO6vwyt8esNj+
 +2QakrZ71SnQiJBYjei5XFOMost7EhKNWqPNh+gozv3QOwA3pBUWNZQHjkOv2dmADMFQ
 fvLg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+xpB3CZOkJ704UmbaleIUEqke6Y61Y+V/NqMIoqQAndwuivhapYLxfZ9o/SwgH1yZs/+n5vvCEeJc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzX0BGbJe6xT7HT2m6droIXwJFT9Gi8bm3+/L2eVzxuRE6B1mQi
 31KV6NJP5Pml0gRN8aXWTjK4A+9IKAyXImqUDPJ/BnzdqjtgRc1eA8w9
X-Gm-Gg: Acq92OHSRiS2p2nT/+yk3aongzpvG9GFLSIVNXGDMJ1PJqRNuGfZ/HJRnwD5+mVKX0C
 8HKBO1HnHW7KSV/QisN0zoY678zZbYvLX24qpwHcAoTDxE9f8uDeNR00EewyVwPPUCzVVwCSK9I
 qNJ02ESOydB155gMsxEF3dPjxMlBpCB5Jp4xONorNWAoWHmSIv4pDvAniSTuwAYuZuqJkSw/Rbf
 OPs0ilvr7ku3C+KQBDTJb3Egk+QeI8KEBsJmjzTcOma11/bTYg6bFNGOmw/MpMjstLR4hFYMNkS
 2ISa91EuVaBnK9ajIuWY/3XOOGQ4NXu6TfBQtMxjA86GXruPcME2JNA/M2wdATC2M8xJfHs7HIX
 tDskwdQpEzbgY0uEig3EjMFygvUnlehnHtsVjGIWa535YpvRan29FoxY7YLwYK5+l0DtCLgImw/
 0sTkWcuXW+08TDL8Dpo6Xf5n4WUHjcEQiGNw==
X-Received: by 2002:a17:906:30c5:b0:bdd:90b8:e397 with SMTP id
 a640c23a62f3a-bdd90b8ec51mr1173734966b.4.1779976307812; 
 Thu, 28 May 2026 06:51:47 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bddc65da3bbsm723636566b.52.2026.05.28.06.51.46
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 28 May 2026 06:51:47 -0700 (PDT)
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
Subject: [PATCH v2 0/6] mfd: lm3533: convert to OF bindings, improve support
Date: Thu, 28 May 2026 16:51:17 +0300
Message-ID: <20260528135123.103745-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.51.0
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

Convert LM3533 to OF bindings, add missing VIN supply, add support for
setting mapping mode and LED sources based on device tree. 

---
Changes in v2:

schema
- maximum led sources for leds set to 4
- anyOf > oneOf in ALS
- improved ALS descriptions
- adjusted example
drivers
- dropped devm convertion of irq and mfd helpers
- all als configuration moved into lm3533_als_setup
- added regulator/consumer.h
- lm3533_bl_setup set before sysfs_create_group in backlight
- added check if LVLED is valid
- LM3533_REG_OUTPUT_CONF1 > LM3533_REG_OUTPUT_CONF2 for LVLED4 and LVLED5
---

Svyatoslav Ryhel (6):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: Set DMA mask
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  68 ++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  66 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 170 ++++++++++
 drivers/iio/light/lm3533-als.c                |  95 +++---
 drivers/leds/leds-lm3533.c                    | 108 +++++--
 drivers/mfd/lm3533-core.c                     | 291 +++++++-----------
 drivers/video/backlight/lm3533_bl.c           | 127 ++++++--
 include/linux/mfd/lm3533.h                    |  53 +---
 8 files changed, 653 insertions(+), 325 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.51.0

