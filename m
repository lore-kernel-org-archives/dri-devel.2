Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id AB44ECD6E55
	for <dri-devel@archiver.kernel.org>; Sat,  6 Jun 2026 04:58:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C31C1112CF6;
	Sat,  6 Jun 2026 04:58:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="RdF8y4p9";
	dkim-atps=neutral
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com
 [209.85.208.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A564D112CF6
 for <dri-devel@lists.freedesktop.org>; Sat,  6 Jun 2026 04:58:05 +0000 (UTC)
Received: by mail-ed1-f45.google.com with SMTP id
 4fb4d7f45d1cf-68cec9f4c6cso3750191a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 05 Jun 2026 21:58:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1780721884; x=1781326684; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=ijiDIJoRq4DW5gmq2cKgL9VuesBVH2zWjg+vtHwI5sw=;
 b=RdF8y4p9sjRcpXYmzf/ASOx5E86288JmHLjZgken4F12ypCHpkwDfKE6qIVgMlEWUJ
 epHapuIX+7UeWQLqS/BtiL+IuGKGXP5xaNN1A2aHoRISREXbCEEVUf0kg+0fp2vywY70
 RZ0nWGc+36+crpfNV7ctjvKDubOaITmhOu45YVE987tyJRc+ScS7+RaTpgqidBe9JkUn
 nJizEyv9WZEvsHcVGw2Si4Q8MYOkUDYSBBBV0odkkPSh8/shHQTUVIBeS5QoGox6npay
 cXUa5eKUVX73BmsHLfdlerINPyTe5s/Q0rbD94QW7fMLdIn8aiLM3y6blYosdJZIYBHi
 pxpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1780721884; x=1781326684;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=ijiDIJoRq4DW5gmq2cKgL9VuesBVH2zWjg+vtHwI5sw=;
 b=h1+sR4bLaiyiwyV6Y72BJ0tALwnEUl47fXZU+9pijehg2rS+eDtfCKnO8HeJfsbeUu
 hnJWluKicGWIRyWyJgzKBbGMWxfslVJ8JrvKNUCk0w9fyHefgwSuQJfi7U/DZeFeJqve
 Ny/+er57pkn+pvm1ZZ3o7LIEKrMOftZOPG/761fDW6W7DgzIRlD3Tqdqm7mpqqgH3VGj
 HmpfuBRP8nbv3ZqUtzvD49LqUXqKtzGl60kB1BTUF8wyxf8/+LhL+ubpHugzo9W2coEr
 //rq9g2cc4TAWXZ5MVN5ei7RM3lzxEoTvVkoOvGCIPnhiRqhWz//QiMss/ZLAxeV/mon
 aA8w==
X-Forwarded-Encrypted: i=1;
 AFNElJ9rzAmmg8aNwtgvROwBKY5TgqgLbS2P96eTIsHtf7VCEnPEJDKBTlAmpRBCp5KRM4VD3XV0L4KancA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyEwKfrPjTHPrYsySxn0y0YxBNV52Fr3atjFWQg9dbNf26yoZIL
 GquUFYk56LGcER2diguH7kHcGI1PeICu3SGAsBUlkeRxmJ6vgOcKR30N
X-Gm-Gg: Acq92OFOYiZ9wkhsm0fZK2+KxiPTKgCngYfIktPtYQlItS1jxI4WT34r0i8lZ1NI/G+
 fW/noi3HR1zs6Bfdzk1oBb+moCq/twGGTICgeGAtPCLvJPSKuaTQhshwzB6GOB7hitYwmfN1FSg
 7+zu6qIQbO20blDOV6BoJv0EAAwh54WxPPP730mx9U9RG2jxtvvtt1535HpBPSs9RXZf3d3jp8D
 Fyr2CIZ90eziVm8f50GPxEQNrj3WooNxETb1L5wTWxxv410uO/P9Ljd3NmzrLUI+rnY6k/XNjUg
 aI5BoLA52bJ6KMlc6VrUc3KyD9i9b5+4NEUrDaQ5zQSj7EgguoUehy+BhuOQ3NoEeOTO54K8rDv
 N+vujKUsSJs9a95WxhEjALgOIqoKnA0Y/VXSsW3EdbOOffTjHqbdV3np22L3XBi3slMAdfgr97V
 uBeXB5CKJvfJDXYxzV3J7MUAvrS9f49zlSMQ==
X-Received: by 2002:a17:906:8a79:b0:bee:bcf6:6a23 with SMTP id
 a640c23a62f3a-bf3749d7f03mr231807166b.43.1780721883699; 
 Fri, 05 Jun 2026 21:58:03 -0700 (PDT)
Received: from xeon ([188.163.112.61]) by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-bf054e086fesm570597166b.32.2026.06.05.21.57.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 05 Jun 2026 21:58:01 -0700 (PDT)
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
Subject: [PATCH v4 00/14] mfd: lm3533: convert to OF bindings, improve support
Date: Sat,  6 Jun 2026 07:57:24 +0300
Message-ID: <20260606045738.21050-1-clamor95@gmail.com>
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
---

Svyatoslav Ryhel (14):
  dt-bindings: leds: Document TI LM3533 LED controller
  mfd: lm3533: Remove driver specific regmap wrappers
  mfd: lm3533: Remove extern from shared functions in the header
  mfd: lm3533: Pass only regmap and light sensor presence to child
    devices
  iio: light: lm3533-als: Remove redundant pdata helpers
  mfd: lm3533-core: Remove redundant pdata helpers
  mfd: lm3533: Switch sysfs_create_group() to device_add_group()
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
 drivers/mfd/lm3533-core.c                     | 365 +++++++-----------
 drivers/mfd/lm3533-ctrlbank.c                 |  27 +-
 drivers/video/backlight/lm3533_bl.c           | 223 ++++++-----
 include/linux/mfd/lm3533.h                    |  75 +---
 9 files changed, 806 insertions(+), 549 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/leds/backlight/ti,lm3533-backlight.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533-leds.yaml
 create mode 100644 Documentation/devicetree/bindings/leds/ti,lm3533.yaml

-- 
2.53.0

