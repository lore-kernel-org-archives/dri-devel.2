Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2F6ACCD98E2
	for <dri-devel@archiver.kernel.org>; Wed, 17 Jun 2026 08:00:46 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 907B210EE76;
	Wed, 17 Jun 2026 08:00:45 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="AGXbzPec";
	dkim-atps=neutral
Received: from mail-ej1-f54.google.com (mail-ej1-f54.google.com
 [209.85.218.54])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2E4AD10EE76
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 08:00:44 +0000 (UTC)
Received: by mail-ej1-f54.google.com with SMTP id
 a640c23a62f3a-befee9e5ef7so658542666b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 17 Jun 2026 01:00:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781683243; x=1782288043; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kcUO9XWzTg2IsD2mVUzEQjeXErkVrXuEkYwVMwsj2Z0=;
 b=AGXbzPecBU0q2ekLH2IfMGmQ28XVaNTZnj2ClEERRu7gafUY8dJgpkJy7IqAET81p3
 kQK/yPffmcJ4PfyHBYVI3A0vt/zyZlt1TDi6lXM1P8RibJNaNr4za3EGYsBP1yXSj4Zg
 r+q7Erh6Z2GivCJ86+SMWX3J2HIjYueOoQL+u/ZrFm48tJsHa6zH6/gTDLuEOMPh3SzI
 OLZZ94cvTTMhS9BZiJFQXg9HXpo+fI3z+j6/peu7T0P+82bVJvdl9XzvRDYrEKVregSS
 b8U9j2m3qdD21ABadlHxfk97UGKNEZ2H64BXCA7/NPrpqx9DwNL4jHhgWpr4RkO44MCT
 Lreg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781683243; x=1782288043;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kcUO9XWzTg2IsD2mVUzEQjeXErkVrXuEkYwVMwsj2Z0=;
 b=W6SEx05bD7KJDVYX02gTXaZZJMTdXl+rIIcjmFZXKpM7QCiFkf5nrdC3nSU9h/M6vv
 zdCRv/+Mt2imJrqyZ+5rzaV6lBTtdsuLxLNmP+FsuRnvbWRHTWFhwaT7JjaUtDeBVPsN
 uek0MmUpeEZOzMptwGnGYzCrXGFQYyWJ38F/vJ9MdDGuI5rN7uHUFh29fLy8Hv/ihOZ4
 fiFfHD5SkwfZm4vZrnj5YoFxLJfGbImh7SeVsOop5xc4ijByaDM972+m/9lUijvR6za6
 /6RNdxfafPxLMtgnTIsMqtNt5PGFXnzyqaNwA6xeh5Xp8+eLAmASinoKEbZFWKfNt3P2
 RbSg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9VUTLfn8oF9E0Vp0Lgqv2HHGILX7sMBBPlpC4pxxcjLlIZJHZRg58JcfHisOT+6YCThW9d13fCl2o=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxGDpfH3WTuPhJekb4pGbUMX58aWPGRLug0hzl0P22RLHAm5f0n
 bd5pj/Bg8Myj190OBZBRYUHlW81KybRCoZz6HeouscFxWfgSHieLyTLG
X-Gm-Gg: Acq92OHyutOU0NjSceiXOMtoBXb2lTyWPUyMcIbg56mSIAqUVKMaMta+rNjD0mOTTTE
 9Du9UEIDSTQg8JJ2QUePreSI8NEhmzdH7/3YlI48fcgxNW2mfcAAj4lZTdqsHBEXLCP5LUGO+oW
 sMyAdKO7cb0xbjQCuFIB4DTplcoqIw1KOZDCjSjQ9SlRrdaaqD6BzlGcP0l6smPl01xy2yINCM+
 Z4Ig1SKSih4igNBxN/iMAh0dH8UjeRLTTaWSvpURLfqU9KDLmYvzV6wUbgfpMVj+YJddlqoqo0X
 5KDGKCDAVQvAo5X/+O+B2QhqnsDSFawfzOsjW47B0ifXyipzMs1ytbdG2491Slke/LdfWgyYUw0
 cGW4yJNTmZi+fbD8CjU/622FYHqZN3UcPFNcmk+MJ4N9mM5AExtH7NIr/gHe6R8XJWg/XEzhu2u
 Tj0A==
X-Received: by 2002:a17:907:6090:b0:bed:e2e8:d8c3 with SMTP id
 a640c23a62f3a-c05a2e40c2dmr185800566b.22.1781683241134; 
 Wed, 17 Jun 2026 01:00:41 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bfdb058fa59sm755339766b.0.2026.06.17.01.00.39
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 17 Jun 2026 01:00:40 -0700 (PDT)
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
Subject: [PATCH v5 00/14] mfd: lm3533: convert to OF bindings, improve support
Date: Wed, 17 Jun 2026 11:00:17 +0300
Message-ID: <20260617080031.99156-1-clamor95@gmail.com>
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
 drivers/iio/light/lm3533-als.c                | 180 ++++-----
 drivers/leds/leds-lm3533.c                    | 184 ++++++---
 drivers/mfd/lm3533-core.c                     | 375 +++++++-----------
 drivers/mfd/lm3533-ctrlbank.c                 |  33 +-
 drivers/video/backlight/lm3533_bl.c           | 232 ++++++-----
 include/linux/mfd/lm3533.h                    |  75 +---
 9 files changed, 821 insertions(+), 563 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.53.0

