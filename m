Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 57041C98304
	for <dri-devel@archiver.kernel.org>; Wed, 23 Sep 2026 22:36:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 6828D10F221;
	Wed, 23 Sep 2026 22:36:43 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="l4f5pLu5";
	dkim-atps=neutral
Received: from mail-vs2-f42.google.com (mail-vs2-f42.google.com
 [74.125.227.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6A4AE10F21A
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 22:35:49 +0000 (UTC)
Received: by mail-vs2-f42.google.com with SMTP id
 71dfb90a1353d-5c67e504d59so582826e0c.1
 for <dri-devel@lists.freedesktop.org>; Wed, 23 Sep 2026 15:35:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790202948; x=1790807748; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=bClm3tufwH8Z04BuQiDaCFYe0ZcBB/1uq3G9UCOaFoQ=;
 b=l4f5pLu5R6lNiiwE4HTM9FNN7Pt9Ci8Z+7dcayTyRe8Tl6Dy+wC5waEr5nU72lveYU
 Jy+jB1mHUr1XIz3AcOO9lcZeZs1Q8lvpmvc6khAbe5UBM3SooCtsYe5pF28c03qqBWNP
 JDkwzfnybfJbSI/I/y9ez6tYixY5I/J4aL88lagOaDhNJDAj3sf/9zHn2jpFNTH4icvL
 s66YmPfOlbrr7gPpxGvPDHrUxBN1MlICiUffnoPONPEBnyLyDvG3FmFPs4POx3MWNaY5
 4dFOVR1xt1eIge0Bqt59/pxrNY1dgyaRqRYZPJZQSQE+dVLNRvInRjACiiP2uPX32G/T
 TBoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790202948; x=1790807748;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=bClm3tufwH8Z04BuQiDaCFYe0ZcBB/1uq3G9UCOaFoQ=;
 b=oPDtugvOkpsPMGM8YvXbrQSlP21XdIKHIhVMHjcYhLfsNcnAB6on168sTQrPI9I94G
 jFrAFKmcqB7jQ13FfflGC9juDWiL7RFv4/iml3U6L1Hx1SY63aGbvCzZfghiCWx6xjvB
 uBW3kcLvEaDNLCX8WOnN0wVrzB6unIWKwaIO2h5Xav/W6yhQEF6R+OtMZ1QlZiURB6mD
 IYOpQmwCIqLVQDXuJ0uF980T/a8is3PvY9cHsbG52EUyGGtegqg5IhdOw61sk8QwjODO
 MPtgAtZgMXr9UaD2d8it6RXX6ozD0WcwJW6v4tbeCMmtI+d/XNGyIT/553Qj7+gKKJ1d
 SdKg==
X-Forwarded-Encrypted: i=1;
 AKwUvByr9RY6BKov7oq/QlBFj75bhB8jGW7Ght84bkWAx1Bqz9mTijOxrueljn3Y8n2pvkBvbUwlV9o5jBI=@lists.freedesktop.org
X-Gm-Message-State: AFuF++mznttfG5W+DS05tYw6mbUEz4FJd+2J8pjsqBmgM4X26MkGP1Dq
 CQJhOXSYZWT4NrmFNdXxGC/5MKfVl5k2d80d1QY1pBa4rbJ6+7Li8Oo=
X-Gm-Gg: AYBFou0YM0BWdlyXQihhAQcjcvLQTr6FAnNl6YJ7xlH3xUljMfT0jG+LFr8GeUIKqWJ
 10Ro3wj6iqz4M2FaBZtO99JG+U7cYhI6/JX3wCLH1GrP89C/cQZCGEMpnt6N5qP0r5kfHPZYMue
 Wfe3xHEhksHIF5eZkJH1/IAF5CGbmoAnNhoZ2x94KIaO+wHa+47K3tFf+avLETIXJYAJ6/co+9F
 x1uN6XdRaAId3A2PtYurC7bD6l2ZC9iv2yS36sstvJIfRtOcYtCIR8OtUR943tj8ohC09jd0B+E
 yS+wRc58Kh5A9pV1ORsA5TRUwuiZvEbqWnH5HeuI/chrqj0wkzPt4idUQYodZE55KyFmmT5EnMF
 fVNKTNfayv7t0SSZtNcQ6oxQaM/RqjA2vi6cFZAUnuHrcOxATpP6mp1cEMYsfU81xd+hgfHd/tN
 RbJzSagrKoBERLDuR5AgZyhUJLRRX7Nq903ANm4q8tuTBZt06otT6LACOtllH9PlYaShi4MNRsE
 ou5B/skuGAKOewkKjPdmKUYwSP8YXTa6FqdL9k1mLpIbKtrpw==
X-Received: by 2002:a05:6122:29cb:b0:5c8:3870:ff73 with SMTP id
 71dfb90a1353d-5cb09217726mr543120e0c.4.1790202948179; 
 Wed, 23 Sep 2026 15:35:48 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 71dfb90a1353d-5c9f04fb621sm5162983e0c.9.2026.09.23.15.35.23
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 23 Sep 2026 15:35:31 -0700 (PDT)
From: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>
Cc: =?UTF-8?q?Nicol=C3=A1s=20Antinori?= <nico.antinori.7@gmail.com>,
 Brigham Campbell <me@brighamcampbell.com>,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 Jori Koolstra <jkoolstra@xs4all.nl>,
 Shuah Khan <skhan@linuxfoundation.org>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
 linux-kernel-mentees@lists.linux.dev
Subject: [PATCH v5 0/3] Add support for CH1115 Controller
Date: Wed, 23 Sep 2026 19:35:12 -0300
Message-ID: <cover.1790200427.git.nico.antinori.7@gmail.com>
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

v5:
General:
 - Patch series based on 7.3-rc1
Driver:
 - Fixed KConfig dependencies (OF and BACKLIGHT_CLASS_DEVICE)
 - Initializing baclight with backlight_properties struct
 - Moved driver from drivers/gpu/drm/chipwealth to drivers/gpu/drm/tiny
 - Fixed allocation for hwbuf if width or height are not multiple of 8.
   I was allocating less memory than needed in those cases.
 - Fixed damage rect horizontal alignment.

Note: The last two fixes listed were pointed out by Sashiko in some
occasions but when I checked them I dismissed them for false positives
because I misunderstood them.

Note 2: Sashiko keeps complaining that i2c transfers are called in
atomic_update callback stating that it is forbidden to call sleeping
functions there because we are in an atomic context. AFAIK this atomic
context is not that the kernel is in a non-sleepable state, but refers
to the DRM way of working by doing check -> commit. In fact, the driver
I based this driver (st7571) and others (ssd103x) do i2c transfer in an
atomic plane update. Am I missing something?

v4: [6]
General:
  - Patch series based in kernel v7.3-rc1
Driver:
  - Fixed nits found by Christophe JAILLET.
  - Fixed max_width and max_height in modeset to avoid having bigger
  framebuffers than resolution.

v3: [5]
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
[5] https://lore.kernel.org/all/cover.1787973729.git.nico.antinori.7@gmail.com/
[6] https://lore.kernel.org/all/cover.1788711082.git.nico.antinori.7@gmail.com/

Nicolás Antinori (3):
  dt-bindings: display: add Chipwealth CH1115 OLED Controller
  drm/ch1115: add support for Chipwealth CH1115 OLED controller
  MAINTAINERS: add entry for Chipwealth CH1115 OLED Controller

 .../bindings/display/chipwealth,ch1115.yaml   |  81 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  17 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ch1115-i2c.c             | 895 ++++++++++++++++++
 6 files changed, 1002 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
 create mode 100644 drivers/gpu/drm/tiny/ch1115-i2c.c

--
2.47.3

