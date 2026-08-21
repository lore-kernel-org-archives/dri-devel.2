Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C1061C5DF93
	for <dri-devel@archiver.kernel.org>; Fri, 21 Aug 2026 14:38:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E4E4F10E2F9;
	Fri, 21 Aug 2026 14:38:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="rYmOyxGc";
	dkim-atps=neutral
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com
 [209.85.128.181])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 7B9C010E302
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 14:38:28 +0000 (UTC)
Received: by mail-yw1-f181.google.com with SMTP id
 00721157ae682-841f1dfc30fso32964287b3.1
 for <dri-devel@lists.freedesktop.org>; Fri, 21 Aug 2026 07:38:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787323107; x=1787927907; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=AJ7GeXkvxDCAB3BMlDYkkSzT/Txb0FUDU70/A4GPBvY=;
 b=rYmOyxGc2EYZa3xPSEZQnlbTOU7NLi42c/v09XRr7p7gKVZ1PTXwlRQFPILuMidoXj
 LOmu5ehm/A5O3Klk82v2wBH0iMvLyRJIN/F/42FPYiQrAmuAjjlVfcMgkEuvhPSvA+Su
 vl3FDYlM3ppQuKx3UGjSrTT7hAJHRvTnoxpiwO0TNNoQQj/RFw1u3Zz2Ti4XHJ1iuXpy
 QXMy/pLdeSJFBjqj9JQqk0hZ+NTVuesjeovgLq2PFnph+3UmbtD8JWrDyZJJ0o8Xy8cP
 zxpWv0VoTj8mFMc33HR4BcLxRy0nqSfF+mO2qb8W1jh0+5/lUpHRtTD9N9vQkvJo9miS
 LYyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787323107; x=1787927907;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=AJ7GeXkvxDCAB3BMlDYkkSzT/Txb0FUDU70/A4GPBvY=;
 b=sFYLutpGEe4GiQ27GIDIpJiPr6vEU4Gna2dq2t6DPxbTy12pebwR/9kG3G2zVPA1KT
 bdXqOobATsuwXIDKpTY41uSB9oWtO2ei+vc+Qz0CSQII0Ju3xJk860GjEpHzVA3EHzAL
 SGfCNReax65d6JqcbHXJgMjXF/C+oU2GKFTIkwVpZIE1YrOnob8QpKUQbZ6dnziTsllS
 awvYi9TjAfGhLNAQD8l0sdPZoikMy2T9GLz+HsMF0kmo4bkBPX7/iaI2Gv975MHo4OOR
 qrqi40S1s/1HvbhNkMCfA7h3O2pmxTvxu0WTtKZeM2igb+KJsQfWZJgx7amfOcdDv7B3
 W4Tg==
X-Forwarded-Encrypted: i=1;
 AHgh+RoAc0O4lF8xbBbh5cg9LBDWN16kg4aXmH+b3Px8WbVbtM60KJ7HWNbqguAMWQrGYy9crE0BxO77Gf0=@lists.freedesktop.org
X-Gm-Message-State: AFuF++kcnimjnnonmXShPmC9ow0w6pbv3gOqJZRrm3tQq2rx8F3VyefK
 Z4Q56IOKGKGlJKlqPtrFrhUyfcz2UQdwHTKNIAiQZ+Gl29UuuNZkzyw=
X-Gm-Gg: AR+sD13hmObqWT3ALHuzns6Z6om6tpq7rwrC7ciC+TlMMnkqVsiV94eWl/gxpeT4hP5
 16Fh1Ok87xx1/MK+ca0XbLSmumIhNdbfaS08KpYAHUV1Uk24jqCkMy0gRVBuXxKOhcLgAo7yuvj
 DOMEPhvYY3Z2I6FHyvwMUNzbpXEs36+5AEtQ+UOGe9vbRqQzogRtjpKR3vxBf7q1APpnn1wQhbo
 BogQ+I39qoKSDBlYeXfOxUyGaAbVeYkzdrcgozrRjHDjHof8Z+bBuNTYmwdyryS7BfcoIw8Okub
 p9yjoiwrkX4fLI9pJhu+SfpEYJx2lXOu8WMWdY7PNakkR2eBUWfRR0PtgtsWgDrVcIAkjG13SeM
 vUVVigdasAvlyX3hbdXAsGUSLCG2KK4/xoZo6/tQc1MmwOBRPy4pTgU8LHH4yTDd4xQVe0MFZq2
 U8vuImR607plVctJio5AO+IkID5bdH0UXh+/Fzt5Ie9Fg6hh8IARpBsEznXwSxKGq5rugR7tyJJ
 v8Jt/rr4u9BpdVnF7EEiTUC4dn3YUKg7tp8E4t8
X-Received: by 2002:a05:690c:399:b0:81e:c500:c6d0 with SMTP id
 00721157ae682-8470139a4a6mr60233797b3.0.1787323107244; 
 Fri, 21 Aug 2026 07:38:27 -0700 (PDT)
Received: from localhost.localdomain ([186.158.238.108])
 by smtp.gmail.com with ESMTPSA id
 00721157ae682-845188b28f2sm41868277b3.38.2026.08.21.07.38.22
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 21 Aug 2026 07:38:26 -0700 (PDT)
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
Subject: [PATCH v2 0/3] Add support for CH1115 Controller
Date: Fri, 21 Aug 2026 11:34:15 -0300
Message-ID: <cover.1787321297.git.nico.antinori.7@gmail.com>
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

v2:
- general:
  - patch series based in kernel v7.2
- in dt-bindings:
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

Nicolás Antinori (3):
  dt-bindings: display: add Chipwealth CH1115 OLED Controller
  drm/ch1115: add support for Chipwealth CH1115 OLED controller
  MAINTAINERS: add entry for Chipwealth CH1115 OLED Controller

 .../bindings/display/chipwealth,ch1115.yaml   |  89 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   1 +
 drivers/gpu/drm/chipwealth/Kconfig            |  16 +
 drivers/gpu/drm/chipwealth/Makefile           |   3 +
 drivers/gpu/drm/chipwealth/ch1115-i2c.c       | 854 ++++++++++++++++++
 8 files changed, 972 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/chipwealth,ch1115.yaml
 create mode 100644 drivers/gpu/drm/chipwealth/Kconfig
 create mode 100644 drivers/gpu/drm/chipwealth/Makefile
 create mode 100644 drivers/gpu/drm/chipwealth/ch1115-i2c.c

--
2.47.3

