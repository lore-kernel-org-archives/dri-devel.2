Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31073C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 08:09:47 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 767A110E037;
	Sat,  4 Jul 2026 08:09:46 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="hc7UaNmH";
	dkim-atps=neutral
Received: from mail-wm1-f42.google.com (mail-wm1-f42.google.com
 [209.85.128.42])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 556A610E037
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 08:09:45 +0000 (UTC)
Received: by mail-wm1-f42.google.com with SMTP id
 5b1f17b1804b1-493bfe9f886so6991485e9.0
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 01:09:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783152584; x=1783757384; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=qUI6LtKyM70E/t6OmoCo0C4PhkrVFGAuXytOxTDiAXA=;
 b=hc7UaNmHswq4DfJfEGEKTCmMamYyvLtDdD5PydLrdQBl3VYq1Z4xetlMhvx5AdXnzO
 T1rXIg6ZDraEzAPGmZ4x8Pgrd511C0p+oBG4/wogjd79q87X9GXzicFzBfnqHEpJe7Vl
 V5ZRAQ9djq/kisWOB/U0+qXZookEhW0cTN9YVilMvYn/WXV/mmJp5DEaUVNlP5LMqin2
 NcGiQvdwveN7q0UiGsdlCTS9ADSCw6Y9bzyJeh2H3qy7CeT4N2jYQJxm22zl2DVjZPaB
 0WLWVGw5NyKwgZXCAUydBX3StmJDU+Gf93nQJTmmdkMQHukRx6Yw7G/m0TTx6HQGabmm
 EoDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783152584; x=1783757384;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=qUI6LtKyM70E/t6OmoCo0C4PhkrVFGAuXytOxTDiAXA=;
 b=MFQXXuM6RsdTDc1/WD9PnUAWOFIFfuWP1EuEZDBF6VxPxlPVsImro2b7TDrgm1Aiss
 LaTmW5vKDDM8OBQmn8h6LayjawS5trkak1+86xn4NW4DaeGeMcCIz1f5vAf3RLsM8+ZA
 tAyXCq7DFSSIys8GVxgZRt6KZLHhEOqzUuxMK0uoRCZ3VOUySh6JOACougrUwvsXel3+
 Js8YHdH7s9hwQllDbtAYjTbrD0+xIeDueXnuP7QSJy0D+zhYbbsUwMVmM+f56gU/TlET
 tz0/0l6TzTyP/Iva0bn9A5A7nCZ1urfHK51xW7hGf3ybFNZbTCXJG76/jN5CTHvpVuLN
 mIJQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ9E9A1QqOLRJgE2NAsc2sxlt+0igya/T70/TjOwj6RGQTovgphh0aoR0bO53J9w5Ykcznvc3mGghKk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxoh9ZzGU9Vdr/4avRLqdQYNASAOZjPK0rgDV+geTsLYjXa7dLV
 xgDQvD5ctsTpVQFcjcA5nont63EMETiqMH4ltQMV5rlU63bLA1QIUXDj
X-Gm-Gg: AfdE7cnt/M+5b0Qo3M9eyuY1F38syOrA/9rbr84MTFNH57loTJhWSyG4nkDdj6tBnVB
 OPAzaykdaCITcrf1gwbJtjrTYHWJlQnjnRu0vDznD42Xu8qGVP3zfydmI54/ypVJDq4MzanR1tF
 2ZHbFmRYHMpTKFXu64mVSwk+sVjDp7pRRwEhjT3/veuflaPKHnl9VA+tS5Y4YBIR+GH1XB7j7Er
 j61wVs8ap6hTFzFst09udvJjZqU0wSAhLLnRpKgHXzrV5KshyDlQGNb/bB3YtT/R/rZ6AhILaUE
 dS4Kr2K9BshWKsdFBDSVZ5C5IFMEsTvQgG4VP6lcLJmR3+IA8UnejjTrTqTRzapiMXoHXATzbjP
 ooihxZGGPQG3l6n+A+8X7Mm2sM7prcDA3pYzcEl0L3/KW8Ol6hYJskzXkF0EWyGZ2A9lz9c5+pB
 71u5smiJzqTrFI9PX4F5lVUAQKnAg=
X-Received: by 2002:a05:600c:5897:b0:492:4cce:53e2 with SMTP id
 5b1f17b1804b1-493d11d0775mr17309745e9.3.1783152583419; 
 Sat, 04 Jul 2026 01:09:43 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47aa0960634sm6143055f8f.26.2026.07.04.01.09.41
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 01:09:42 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: Javier Martinez Canillas <javierm@redhat.com>,
 Andy Shevchenko <andriy.shevchenko@intel.com>,
 dri-devel@lists.freedesktop.org
Cc: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v3 0/3] drm/ssd130x: Add support for the Solomon SSD1351 OLED
 controller
Date: Sat,  4 Jul 2026 11:09:22 +0300
Message-ID: <20260704080925.75113-1-amit.barzilai22@gmail.com>
X-Mailer: git-send-email 2.54.0
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

This series adds support for the Solomon SSD1351, a 128x128 65k-color
RGB OLED controller, to the ssd130x DRM driver:

  - Patch 1 adds the device tree binding.

  - Patch 2 switches the SSD133X family from RGB332 to RGB565, bringing
    65k color to the SSD1331.

  - Patch 3 adds the SSD1351 as a new SSD135X_FAMILY, reusing the
    SSD133X plane/CRTC and blit/clear helpers. The only data-path
    difference is the explicit Write RAM command (0x5c) the SSD1351
    needs before pixel data; it also gets its own init sequence.

Testing:

  - The SSD1351 (patches 1 and 3) is tested on hardware.
  - The SSD1331 RGB565 change (patch 2) is compile-tested only; I do not
    currently have a working SSD1331 panel. Javier has kindly offered to
    test it on his SSD1331.

Dependency:

  The SSD1351 reuses ssd133x_update_rect(), which programs the column
  and row *end* address as a relative offset rather than an absolute
  coordinate. This breaks partial updates that do not start at (0,0). A
  separate fix is posted at [2]; until it lands, the SSD1351 shows the
  same partial-redraw artifacts. This series applies independently of
  that fix, but the two are best merged together.

Backlight:

  While adding the SSD1351 I noticed that the shared backlight path
  (ssd130x_update_bl()) is only correct for the SSD130X and SSD132X
  families, where 0x81 is the contrast command. On the SSD133X, 0x81 is
  "Set Contrast for Color A", so brightness changes shift the color
  balance rather than dim the panel. On the SSD1351, 0x81 is not
  implemented at all and the brightness byte itself would be executed
  as a command opcode (e.g. 0xae is Display OFF). This series therefore
  does not register a backlight device for the SSD135X family. I plan a
  follow-up making the backlight path family-aware (scaling
  0x81/0x82/0x83 together for SSD133X, 0xc1 contrast A/B/C for
  SSD135X), which would also fix the existing SSD1331 behavior. Happy
  to reorder if you would prefer that rework to land first.

Based on drm-misc-next. Note that the series depends on
ssd130x_run_cmd_seq() (commit 208211646fb3 ("drm/solomon: add
ssd130x_run_cmd_seq() for batch command execution")), which is in
drm-misc-next but not yet in mainline.

Thanks to Javier, Andy and Krzysztof for the reviews.

[1] v2 of this series:
    https://lore.kernel.org/dri-devel/20260622152506.78627-1-amit.barzilai22@gmail.com
[2] ssd132x/ssd133x update_rect end-address fix:
    https://lore.kernel.org/dri-devel/20260622122604.32500-1-amit.barzilai22@gmail.com

---

Changes since v2 [1]:
- Drop patch 4 (staging fbtft fb_ssd1351 removal); it was agreed that
  the fbtft driver stays.
- Patch 2: remove RGB332 support entirely and drive the SSD133X family
  at RGB565 unconditionally, instead of adding a per-variant format
  flag to the deviceinfo struct (per Javier). Retitled accordingly.
- Patch 3: drop the 120 ms post-reset msleep(); it was a generic fbtft
  value, not an SSD1351 datasheet figure. Retested on hardware without
  it. A comment noting this is left in ssd130x_reset() (per Andy).
- Patch 3: explain the ssd130x_write_data() constification in the
  commit message (per Andy).
- Add trailing commas to non-terminator array/enum entries and drop
  the comma from the init-sequence terminator (per Andy).
- Declare the loop variable inside the for statement in
  ssd130x_write_cmd() (per Andy).
- Split declaration and assignment of ret in ssd133x_write_pixels()
  (per Andy).
- Fix comment wording/plurals ("3, 3 and 2 bits") (per Andy).
- Patch 3: skip backlight device registration for the SSD135X family;
  the shared backlight path would execute the brightness byte as a
  command opcode on the SSD1351. To be addressed by a follow-up making
  the backlight path family-aware (see the Backlight section above).
- Collect Reviewed-by tags on patch 1.

Amit Barzilai (3):
  dt-bindings: display: Add Solomon SSD1351 OLED controller
  drm/ssd130x: Change SSD133X color format to RGB565 from RGB332
  drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support

 .../bindings/display/solomon,ssd1351.yaml     |  42 +++
 drivers/gpu/drm/solomon/ssd130x-spi.c         |   7 +
 drivers/gpu/drm/solomon/ssd130x.c             | 289 ++++++++++++++----
 drivers/gpu/drm/solomon/ssd130x.h             |   5 +-
 4 files changed, 278 insertions(+), 65 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml

--
2.54.0
