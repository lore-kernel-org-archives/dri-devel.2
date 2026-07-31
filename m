Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B1750C54F54
	for <dri-devel@archiver.kernel.org>; Fri, 31 Jul 2026 11:36:49 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AA90E10F21F;
	Fri, 31 Jul 2026 11:36:48 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AOxNzo7w";
	dkim-atps=neutral
Received: from mail-wr1-f48.google.com (mail-wr1-f48.google.com
 [209.85.221.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 82A8A10F21F
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 11:36:47 +0000 (UTC)
Received: by mail-wr1-f48.google.com with SMTP id
 ffacd0b85a97d-47df43bfb07so340384f8f.1
 for <dri-devel@lists.freedesktop.org>; Fri, 31 Jul 2026 04:36:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785497806; x=1786102606; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=0oYKY0Gc5U72MShEoavxG+AazK3v/FMxLUqW5uFuuYY=;
 b=AOxNzo7wxUHGXKAppkB1Kk3ifwePyH13ilNiaE8xCx8UATwpX0/6/lBhwKv3xsWtlS
 MXEyDYq0udZ0IDfrLzaniv6K74NYehLtjCP74NXIJh0EtCWKHNqq7oJalkBKkoMBPNE6
 5vh4NlG/KCjFxH7EyXBDJiU548qX5Fs1GJFWxYrZOzZDrAxpUh8pEv57qbXPTFbqjrus
 2wKfcdoh9mqRc+lw9/Gqox/xaWff/9sGD16l5jg5qcYNapZfcCuWiJp220ph0y+Os05s
 cIkYAbWqTh1UY6F2Ll//ZK+RiO5PIMVL/luUaD2xQ0/YAHpzX/9SAWuzvG2UaGeLZcQr
 VeUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785497806; x=1786102606;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=0oYKY0Gc5U72MShEoavxG+AazK3v/FMxLUqW5uFuuYY=;
 b=Cn+nm7O1ehhgUrXH54MkByFFt9Jx+rc38+iqh9eWcoMzbaEYiW7dSncje0ORyGkTrC
 nBVSZqC3fAJtJgcsdRbHSC6tu4TcCVdxmDfcWHX1ES062LLS4mlNp5QeCHIRwE4UNtiq
 R1sZPHwOUW8LqtI8xHmO/IwKJwmbp0la6WgO36jpTJ08haLiXsx7Ha18IO2nsAbPnfmR
 tPMnE1MgUzPUPsTeeXw/tyvRI/Jz39O8Ga4HpYQnMF5o/p1KT3Myz9RubR8+amR6eZv2
 IuIbddQ6mR06OHOkawjUpyAegUhTr94ROOG52TbxJRJj7wdWJeV+M/THwD5LRV2A3fPd
 PvFQ==
X-Forwarded-Encrypted: i=1;
 AHgh+Rr5epr8ucloH+tMgHH4BcBM46sSDMCCCAsPIcbCCog5mj03tCjuYPt85jt1N6tGw6b+VqEid4a0o6o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxzI/ER3+N6Ii4tWXQYDEiygmVLLXX+5VohtmmHW4ce1xVT+eIT
 o8s5b41+WUmWyiHYPq8mNjo2iBc5JiN9AUowkbNJJhIDZRUzEyF+2lds
X-Gm-Gg: AR+sD13tiwGH5HyLoKZ9sUOcygjbbeXG7ZLGBQtUMWMp+qtZNvfkiZZI5RqibgSn9e8
 MCn3gcTtLUyY0R5tT+YPOcP1UBMl2UuIYmG2w4T3pVO+8vifB1DLYZZRWtM8fCPzzSZG4r19ynK
 ut4qDIQxGg0nW8Wx5qHqSYyvfDfbAU4W5mqaM33s5Jpwb5jwefENFzT+UOQ8W/DiFJUH3MUnwWT
 BYpSkdGFngMAIZpe4Dz98VhcWxg4hUOlObIY7jy4N/yWbiCOsBO8bi3vsJEhrQDTS8hw1veGsvz
 hV8xiHwyYUxrfRdosAWD1eutcgpw4kJVNoqdz7ZNX9QLOW8sY8+e/y/aOmMDFhr5W8R4H4STOir
 kKAfg8JRZVIzEqbpOtbbjt6kNYPI1lwxcIJG0V9rk8+fB4mbcM/nDYqWvMDRqJKbpjSGez7W9FQ
 ZHUYixwZ+YPBjh+TlytzXooof/A3K5wLKTO7N7LbEB6FBq+tWNDo31TTTj5VadekAHBhQdT93Fy
 7ufzKrq/w==
X-Received: by 2002:a05:6000:2904:b0:47f:2de3:b351 with SMTP id
 ffacd0b85a97d-47fd2adcad1mr4260062f8f.26.1785497805482; 
 Fri, 31 Jul 2026 04:36:45 -0700 (PDT)
Received: from xeon ([188.163.112.51]) by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fd45a0c8bsm3670646f8f.34.2026.07.31.04.36.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 31 Jul 2026 04:36:44 -0700 (PDT)
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
Subject: [PATCH v6 00/14] mfd: lm3533: convert to OF bindings, improve support
Date: Fri, 31 Jul 2026 14:36:18 +0300
Message-ID: <20260731113632.158440-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.53.0
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

Changes in v4:

- fixed regmap_update_bits val and mask swap in lm3533_als_set_int_mode
- fixed als->irq check in store_thresh_either_en
- removed clamping of r_select in als driver
- added use_of_reg and of_reg for backlight and leds registration
- added intermediate step in asigning props.brightness
- fixed HVLED/LVLED configuration overwriting
- added bounds check for num_leds in leds and backlight driver
- switched to regmap_clean/set/assign/test_bits helpers where appropriate
- dropped extern from header function declartions
- switched lm3533 pointer in cell structures to regmap
- sysfs_create_group > device_add_group
- changes in backlight sysfs were expanded to all properties

Changes in v5:

- aligned driver helpers to use u32
- child nodes parsing linked with 'else if' to ensure there is one call per node
- removed redundant pwm var init for leds
- fixed regmap_test_bits return check
- fixed leds and backlight counting handling
- iterator variables made scoped
- lm3533_als_setup() set to exit after mode set if m0de is pwm

Changes in v6:

- expanded commit message in OF conversion commit
- restored original comment regarding PWM mode of ALS
- switched to FIELD_PREP macro in core for helper flattening
---

Svyatoslav Ryhel (14):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Remove driver specific regmap wrappers
  mfd: lm3533: Remove extern from shared functions in the header
  mfd: lm3533: Pass only regmap and light sensor presence to child
    devices
  iio: light: lm3533-als: Remove redundant pdata helpers
  mfd: lm3533-core: Remove redundant pdata helpers
  mfd: lm3533: Use dev_groups in struct device_driver
  mfd: lm3533: Convert to use OF bindings
  mfd: lm3533: Add support for VIN power supply
  mfd: lm3533: Set DMA mask
  video: backlight: lm3533_bl: Improve logic of sysfs functions
  video: backlight: lm3533_bl: Set initial mapping mode from DT
  video: backlight: lm3533_bl: Implement backlight_scale property
  video: leds: backlight: lm3533: Support getting LED sources from DT

 .../leds/backlight/ti,lm3533-backlight.yaml   |  69 ++++
 .../bindings/leds/ti,lm3533-leds.yaml         |  67 ++++
 .../devicetree/bindings/leds/ti,lm3533.yaml   | 169 ++++++++
 drivers/iio/light/lm3533-als.c                | 179 ++++-----
 drivers/leds/leds-lm3533.c                    | 181 ++++++---
 drivers/mfd/lm3533-core.c                     | 378 +++++++-----------
 drivers/mfd/lm3533-ctrlbank.c                 |  33 +-
 drivers/video/backlight/lm3533_bl.c           | 231 ++++++-----
 include/linux/mfd/lm3533.h                    |  75 +---
 9 files changed, 818 insertions(+), 564 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.53.0

