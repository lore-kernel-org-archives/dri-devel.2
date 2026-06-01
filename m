Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E301CD6E55
	for <dri-devel@archiver.kernel.org>; Mon,  1 Jun 2026 15:19:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 919D7113495;
	Mon,  1 Jun 2026 15:19:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="f4juEALX";
	dkim-atps=neutral
Received: from mail-wr1-f47.google.com (mail-wr1-f47.google.com
 [209.85.221.47])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AB47A113495
 for <dri-devel@lists.freedesktop.org>; Mon,  1 Jun 2026 15:18:59 +0000 (UTC)
Received: by mail-wr1-f47.google.com with SMTP id
 ffacd0b85a97d-45ef4223be7so1758755f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 01 Jun 2026 08:18:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780327138; x=1780931938; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qzN96GbcZUpB13Q9YtY/dmYRB6hgHD9CiDUD5v/xjEA=;
 b=f4juEALXdvdkzppqu00HSRgu0HbATeBneMAMdozKU/pLOKyQw33VLp8qfJNYw7jLzh
 CjuTgs8cun7t2tlnivj/d7sGRvymN7g9xjkyxPEqOz9h82TSrAmmhBG7VUKjZrwmkN1H
 HNCUxpxb6QtNFUyty+KwXwqit8XF/PSbyraEs/thODBJ7PTRnxOU+cTy/r7KrfYdos7V
 a7Kb1gyghWMS7VyhveSmGJQ1hHzvI5GbYxfvfQRmBkPiUCbipZ4ZqoQDAXMclVp6Guwg
 4lEpeeCv3NOY1/5hpxo/1JtsVrfDMyLB0CPdBrxb7F46TZ6/Lr4xcyM3L3Lce8OKlpM7
 CwKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780327138; x=1780931938;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qzN96GbcZUpB13Q9YtY/dmYRB6hgHD9CiDUD5v/xjEA=;
 b=GOwtVNhypbSY6Qh6UFB977f5zkXJrDA4i/Li7FYgIReHxs+yucWcB0N/WBJDd6+kD5
 iY7S9wJQ0DUq7cIhZ5Y0/+tR6McE9xtHsvZzY5/thpThDtvZbWYvMLFsj+UeHv9zpnWt
 c4rEPS3cEmCnWFTpSkLFTY+llybGFTILUdIiqEqTb6mWq3aX8y4OpwW21zSor42TaLUP
 7tGRD+cqjudsOnZie2wPRZW8cPeyRKRyC2S88LOVDFuLch/mqinpLbQmWFyJwEsgK2Zk
 la0IeszzUrLQP9s33qM6ovl8HFDRy0l6f9VX/GRV5CB7mlCirCL2Hu4lU4D1jdbLOuBV
 3roA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8McMTrxTbelUllR4kXs+k4F08R+RE+bixLleytK9DQMcLCtpbLLnVolPuH8HbRUBsf2jD9LDOzdDQ=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyThMrwHSkoIs91sRAgzUQCeKPBi9af7QlT1SLw0Ye2/C7ypzCH
 xk1DlHHrDT5e34en706J04tKCDONRoTkw7+EZtXN+ZTxXW3IvHHJzBCj
X-Gm-Gg: Acq92OG0d4c4Uvx8fstchPg8SWwO/viOGhhXSHjIdWzhiNjRdizbaJlmEDcfET+snE5
 MOmr2gTjPa/hAettnGC3oBN+kRmy/JEzB6HQ1IfzVNsD2I2/1qxJdqbVpNwSxtG5ifRk3akYkyz
 GHq1aNG9BoLhnNy1+rDico9vXYL43QN+KWOZIWC05s5rj/TCITuXO5ZCcxHrluJ69fUsXywSQnB
 VuuLZdm7voVHYC55GgM6dFtzu4PLcXeKecBQPkSrZqP5hrpcG4cL2MLRmuw8Wnpop3tFgwu3Xhm
 UH52bcY8BFmRa1DhesxMf3iG60zDd0X2my/x1GtCLLpjGkzn6dU36YlmjueHD1Hw4qc7u55VC6F
 alsmS8joUAuj3VFL0ymCJdinoT49ILSzEMbnd4k+Njr1yXHUM/mSG7ff77INPsyMRJ5uLCk+amc
 18WogK6GSH4fGX4Gdw7mKZa6k=
X-Received: by 2002:a5d:59ca:0:b0:45e:f46d:fa95 with SMTP id
 ffacd0b85a97d-45ef6a8c8f7mr19705747f8f.0.1780327137736; 
 Mon, 01 Jun 2026 08:18:57 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-45ef354cd7csm25753103f8f.18.2026.06.01.08.18.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 01 Jun 2026 08:18:57 -0700 (PDT)
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
Subject: [PATCH v3 00/11] mfd: lm3533: convert to OF bindings, improve support
Date: Mon,  1 Jun 2026 18:18:20 +0300
Message-ID: <20260601151831.76350-1-clamor95@gmail.com>
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

Changes in v3:

- ohm -> ohms
- added default PWM mask to schema
- added commit removing driver regmap wrappers
- added commits which flatten pdata helpers
- adjusted check if als->irq > 0 since als->irq can be negative if error/missing
- added count for children defined in device tree and mfd_cell is allocated
  via devm_kcalloc to be able to contain all of them
- fixed backlight boundary check
- fixed count increased unconditionally
- dev_err returns node name instead of reg value
- LM3533_MAX_CURRENT_* defines moved to common header since they are used to clamp
  current values read from the tree
- mapping mode commit splitted into 2 (sysfs logic improvement > mode from DT)
- backlight mode configuration set before sysfs group is created
- fixed LVLED check on LEDs setup
- added check if HVLED is valid
- fixed wrong err_sysfs_remove goto in lm3533_bl
- added commit implementing backlight_scale property
---

Svyatoslav Ryhel (11):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Remove driver specific regmap wrappers
  iio: light: lm3533-als: Remove redundant pdata helpers
  mfd: lm3533-core: Remove redundant pdata helpers
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: Set DMA mask
  video: backlight: lm3533_bl: Improve linear sysfs logic
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: backlight: lm3533_bl: Implement backlight_scale property
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  69 ++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  67 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++
 drivers/iio/light/lm3533-als.c                | 159 ++++----
 drivers/leds/leds-lm3533.c                    | 142 +++++--
 drivers/mfd/lm3533-core.c                     | 361 +++++++-----------
 drivers/mfd/lm3533-ctrlbank.c                 |  27 +-
 drivers/video/backlight/lm3533_bl.c           | 153 ++++++--
 include/linux/mfd/lm3533.h                    |  62 +--
 9 files changed, 758 insertions(+), 451 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.51.0

