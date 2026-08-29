Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9FA4BC61DD7
	for <dri-devel@archiver.kernel.org>; Sat, 29 Aug 2026 06:38:10 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 824AB10E07B;
	Sat, 29 Aug 2026 06:38:09 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="eW0QsCq3";
	dkim-atps=neutral
Received: from mail-pg1-f174.google.com (mail-pg1-f174.google.com
 [209.85.215.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2F97F10E07B
 for <dri-devel@lists.freedesktop.org>; Sat, 29 Aug 2026 06:38:09 +0000 (UTC)
Received: by mail-pg1-f174.google.com with SMTP id
 41be03b00d2f7-cbedd5aece4so2256904a12.0
 for <dri-devel@lists.freedesktop.org>; Fri, 28 Aug 2026 23:38:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787985489; x=1788590289; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=9gUDHNOKmIoQbqe9mzJt0j0l2zbHlvksIrYcKhCoTP4=;
 b=eW0QsCq3iEfaCx99iqaNMXW7HAEatQDGGB/U+l3GFDIEBs5B/ULgQnuRglvHqFlo7v
 Vf32Mrlp4c/3N4pxq2L8ffLeLIONpmtG+cwswsugj0qH7r+P/I9LGUWEdYE9+s3oz65Y
 OBa3taLCGoMoOeVwJR2p9w/g0eFyG+aRg8XHbn90AyC5xtBBoG5HfhTimUTewyYOZV3+
 N38OflC0gzvb7AESlkhYcvuGpBEXfRydlg+QNONbi4eGq5DV8qpZzHiyNwH32PpqtW2J
 K02UNqBY20/lPoSnQLp2L66PuYgybVjxqkH7SQPaOkAmUr+6/cy/0uvWaBg496VDQVtw
 T8vQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787985489; x=1788590289;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=9gUDHNOKmIoQbqe9mzJt0j0l2zbHlvksIrYcKhCoTP4=;
 b=DQofOy++xD/yIacTdRGtAmQnglRfh9g1Yf+VzW0vOVQTn86YaLWwAzsu4Mffd86RHV
 Uyz+Jax+dqUkDecev6C/rT0HmtMDBCmgpUd4zaNKhI3PCe9d3jaCw17Tg6i/urNpUwhf
 vJ18q/9Fk7sxHxpDN5r9AAwJbB8gTrJAA62kVrFPrEbz/F9WjDSEOpA1jjE3SIRQH1Hd
 gS3AAzVAR+g7h3maGBHBYRFgNG8wwXYyYym3X1SIyPIFFG/E73TeOSUhtRr3e5uzXXSW
 5ZbkZq27EldjjWb9qLs1TjLKcf5JiGCrFyo4DQ31L6I5HZTc+VYBxnmQ1G/f8RNu03dS
 DcWw==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXZMODotUWPI/hSbl30Cb4HdD55nb7MW0Alhy4yCv01PCQ51btWLVLagYVdwZtugUaW3nqpREkpEI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mC2uEXH3DlzrWB2mQ0oU7rXQni32j62lGDrm3znnC9CnSYKzsc
 sAB2Ik+pUAlkReFRZCkpr7DkpW4/oO1IAeiKrJyf6J3895Nwu3HkWP8=
X-Gm-Gg: AYBFou3OTp2im3ajZPEfLJA+mjBs1Pkb5LR0p9CmC3QmtkJR6zGLAZE9boGszJ+agJr
 5g1IuVhEbBqfYyM3iKIhmMMyTyR0tdjvPzp527t79IQZwGEDo0WhAAGzKR1mXkJ848dQEZfu11g
 VeAkkyZkUGK6tuaWqpeWI1a7k9M517GP2VmgfStYYxfYpPC/eyTlVYuL94qofpUPDB+ADqeANle
 gwC61f/VuDikCcc8H7dVapfRooj5M0WLChs7FmtBgPnUyQvutyx8ynnk5wFkJEkbKhXzP+ATo2w
 vDRblBZZzsNsjfKzcpRoTSCDCgsRC1YKCwtmWFPovc/QIh/pgN8OnhQp18slQCrbJ/QOxvluIOi
 q3xMm36crLvZUQRIEhu/rb/QOEN4Z8GlHdd2I6C04hH1SOjR6pGFwjNbr7Pxc2GfduxSoBIS64a
 SYlIDRXqC/Nto0t6KEnRha7KIHnOvLiQlsnpS+rL9aPUo18OBIV9PI1y+cDPHLyoPxzf/uDoh45
 VIOXkGH/4WNxyAgmc/UVgA2L8Ft+3uXJ2yVYDU=
X-Received: by 2002:a17:90b:1644:b0:36b:b903:994 with SMTP id
 98e67ed59e1d1-3969ba3c851mr22712524a91.4.1787985488496; 
 Fri, 28 Aug 2026 23:38:08 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 a92af1059eb24-142e0d1abbdsm10957539c88.2.2026.08.28.23.38.05
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 28 Aug 2026 23:38:08 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v3 0/3] Add support for CH1115 Controller
Date: Sat, 29 Aug 2026 03:32:12 -0300
Message-ID: <cover.1787973729.git.nico.antinori.7@gmail.com>
X-Mailer: git-send-email 2.47.3
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

This series add support for the CH1115 Controller [1].
It is a monochrome dot matrix OLED controller that supports several
interfaces such as SPI and I2C.

This driver only supports the I2C interface, but all common parts could
easily be put into a common file to be used with other interfaces.
I only have I2C to test with.

This is the first driver I write. The work is based on the driver
located at:
- drivers/gpu/drm/sitronix/st7571-i2c.c
- drivers/gpu/drm/sitronix/st7571.c

Tested with Raspberry Pi 3b+.

Changelog:

v3:
- General:
  - Patch series based in kernel v7.2
- In dt-bindings:
  - Removed "chipwealth,contrast" property (added backlight_device
    support in driver's code)
  - Renamed "chipwealth,invert" -> "chipwealth,inverted"
  - Added default value to "chipwealth,offset"
  - Removed 'status = "okay"' from example
  - Indented example with 4 spaces as stated in the documentation [4]
- In driver code:
  - Added support for backlight_device
  - Replaced drm_dev_unregister with drm_dev_unplug to cover the dt
    overlay unload case
  - Executing drm shutdown operations before turning off the display
  - Checking that the width (panel-timing.hactive) and height
    (panel-timing.vactive) parameters are greater than 0

v2: [3]
- General:
  - Patch series based in kernel v7.2
- In dt-bindings:
  - Fixed linter problems
  - Replaced first_page property with offset
- In driver code:
  - Fixed dst_pitch calculation
  - Renamed file from ch1115.c to ch1115-i2c.c
  - Support flip-vertical and flip-horizontal dt properties
  - Fixed several things found by sashiko-ai

v1: [2]

[1] https://datasheet4u.com/download/1576606/CH1115.html
[2] https://lore.kernel.org/all/cover.1786110720.git.nico.antinori.7@gmail.com/
[3] https://lore.kernel.org/all/cover.1787321297.git.nico.antinori.7@gmail.com/
[4] https://docs.kernel.org/devicetree/bindings/writing-schema.html#annotated-example-schema

Nicolás Antinori (3):
  dt-bindings: display: add Chipwealth CH1115 OLED Controller
  drm/ch1115: add support for Chipwealth CH1115 OLED controller
  MAINTAINERS: add entry for Chipwealth CH1115 OLED Controller

 .../bindings/display/chipwealth,ch1115.yaml   |  81 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/chipwealth/Kconfig            |  16 +
 drivers/gpu/drm/chipwealth/Makefile           |   3 +
 drivers/gpu/drm/chipwealth/ch1115-i2c.c       | 887 ++++++++++++++++++
 8 files changed, 997 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
 create mode 100644 drivers/gpu/drm/chipwealth/Kconfig
 create mode 100644 drivers/gpu/drm/chipwealth/Makefile
 create mode 100644 drivers/gpu/drm/chipwealth/ch1115-i2c.c

--
2.47.3

