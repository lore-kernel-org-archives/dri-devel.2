Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C07E6C5AC7A
	for <dri-devel@archiver.kernel.org>; Fri,  7 Aug 2026 14:22:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 16E7A10E426;
	Fri,  7 Aug 2026 14:22:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="pvByaba1";
	dkim-atps=neutral
Received: from mail-pl1-f180.google.com (mail-pl1-f180.google.com
 [209.85.214.180])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8898B10E426
 for <dri-devel@lists.freedesktop.org>; Fri,  7 Aug 2026 14:22:24 +0000 (UTC)
Received: by mail-pl1-f180.google.com with SMTP id
 d9443c01a7336-2cc97653887so40311915ad.1
 for <dri-devel@lists.freedesktop.org>; Fri, 07 Aug 2026 07:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1786112544; x=1786717344; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=Y4jrqSj3opeMMbFpu/4FeQ4O+rDHnQsZg3TOVpbai7E=;
 b=pvByaba1ovMfquxhzHTwmJMIRVAgYDAPS1XFqrrk7li/QzerYqVhK81IBQuzkBH/CN
 6rwSudjMgi0aBqYVt/jYXlESwIZ9V+SLOBP0z0X9jhoiZ3ar4LGCKFW0RScYyx0GlZ1A
 ycExMkt/WNsGrM0f14GXgNw+7pbhkPDyPSDOABvAFhpIGqsQ98fU0NDy831VIP4kzzvD
 iiN5ifRloGtW84qrm62raNrC4eVybOQ2s8hTvM2ptTw3hrg6WvyYI2AV3ORBCwL8QCDJ
 Z1wXggYwCnMd6wbB3SWcFRDWmTqU5mVh5YzWl/E8Ns44EIgceQhdw9NumnWj0SfNgcBG
 BFUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1786112544; x=1786717344;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=Y4jrqSj3opeMMbFpu/4FeQ4O+rDHnQsZg3TOVpbai7E=;
 b=c7iv3vJsg1eerFAapS/TMkI49kxBg9Vhr32Gr2C2Eb5IEWq53s2KVkgSgCxGc0QNMf
 1eWvzWRaHvGFvJpC1IkcjEkj4uIDjfz32+bEuWe2U3ob7jns+yy8N4gHdsk3nyCaOg53
 LhFcqE7VfPO3GSqyNud8uAJ9/OkdtVLEs32R4TkH0JSRMc+/i88oUPoNEbSqfOEAMdhM
 zHkeIrwyee6fYgj9EwXjEiuNTAsHPA5OAy5QV/jG7YIz1pZXb/68Bi2aZouwx0OWJDvc
 dJYhlWb/42E8/u8sOtM3oWvkpbD+IoRuPCMePYkPpecSGxymJMCNGYZxuCI2nZC5aP0w
 +ZOg==
X-Forwarded-Encrypted: i=1;
 AHgh+RosGL5tORar6HhGpxJCeLxy4TeaJcAVDn6lgEv/pOqONYQw6gTiyQ9ZbUKtvfHsgLPCUcpms2dfQ2Y=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YwLv/7ge3Yci02Xtpr61Z5IMSf3+Rc+3TXhZOzhDJY2dtnIqpyZ
 rMxiCXyecTxOGsYmMZYktV7ZQzoztMrYQjqRWMjOY4xKpnJNxKmr2sU=
X-Gm-Gg: AR+sD12XYjqcVQ+Be4R3D8kdWn/j+YlxSYLcoM5caHfZTQztNyu0Ae4AOvFqOC3sKl+
 jRyLhw50uBJytEOIWsyAFlg+aY2JYuFBpbDeMnDVJVaBhsv1ovfHT19ThBzepJTv3uKGbGJjM8V
 Hq0P58pMV71LflODsmOMAC/9488/kOzDFBUTRPCUy8vLlmiYwXNrM5YUw/UYReqS7/KaaUdKUsR
 lUv9lZfIcK3rWMJDBbXpXoqwUO1xK7qHyk4Gwmvuj86fQRGfpv2+7qq1nq5J3I1y66WAPNFraYM
 nAeQZfySEtiZwWdoc1DTQl1ASl87sFQL0reewAahEepExiynG2kxDq8n4SSsZ6JvAQ9bRJyb5gg
 1aFFHLRoAgqVnWNo6QjcqSjmDRTEuMlN0DtQsYDdO7bnBMkvrzl3g1Hr8EwDKlNdjEI2Pk/c33p
 jh+eYGxMimcW05Ecpl+mVN19yVZwHhg/nYb8V7iH3wptk3TPGr/QeC8QfjfvImFABDNlHeBwgJi
 E+kTmEV9MSNE7r/uIR556eQ8iMSznYxyZMdLJNGgg==
X-Received: by 2002:a17:902:da82:b0:2cf:7bfe:6043 with SMTP id
 d9443c01a7336-2d0ca949b71mr207130955ad.19.1786112543799; 
 Fri, 07 Aug 2026 07:22:23 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-315be8a7395sm8521868eec.9.2026.08.07.07.22.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 07 Aug 2026 07:22:23 -0700 (PDT)
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
Subject: [PATCH 0/3] Add support for CH1115 Controller
Date: Fri,  7 Aug 2026 11:19:49 -0300
Message-ID: <cover.1786110720.git.nico.antinori.7@gmail.com>
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

Thanks,
Nicolás

[1] https://datasheet4u.com/download/1576606/CH1115.html

Nicolás Antinori (3):
  dt-bindings: display: add Chipwealth CH1115 OLED Controller
  drm/ch1115: add support for Chipwealth CH1115 OLED controller
  MAINTAINERS: add entry for Chipwealth CH1115 OLED Controller

 .../bindings/display/chipwealth,ch1115.yaml   |  73 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/chipwealth/Kconfig            |  16 +
 drivers/gpu/drm/chipwealth/Makefile           |   3 +
 drivers/gpu/drm/chipwealth/ch1115.c           | 828 ++++++++++++++++++
 8 files changed, 930 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
 create mode 100644 drivers/gpu/drm/chipwealth/Kconfig
 create mode 100644 drivers/gpu/drm/chipwealth/Makefile
 create mode 100644 drivers/gpu/drm/chipwealth/ch1115.c

--
2.47.3

