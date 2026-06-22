Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D83A2CDB46F
	for <dri-devel@archiver.kernel.org>; Mon, 22 Jun 2026 15:25:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4C34A10E49D;
	Mon, 22 Jun 2026 15:25:21 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="q2CBGXWo";
	dkim-atps=neutral
Received: from mail-wr1-f44.google.com (mail-wr1-f44.google.com
 [209.85.221.44])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 394FA10E49D
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 15:25:20 +0000 (UTC)
Received: by mail-wr1-f44.google.com with SMTP id
 ffacd0b85a97d-45f3cf907ceso2081803f8f.2
 for <dri-devel@lists.freedesktop.org>; Mon, 22 Jun 2026 08:25:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782141918; x=1782746718; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=kL1tj/BLw05+tMmUXWpE7p03gE32TyonQg4lQC1zuNQ=;
 b=q2CBGXWov/tcXmhyFitv75wSOj5DL3SZ7i0MlBd2RyzJLBUdnGdB/fDLc6tGCJoPhy
 s2bpgRVTCaORHMHruaa0VXFIXhs0cLrBdNoLOseJ7Q/j63uQekx5NJc+K1MORBd8pSzB
 3TL9s0ekMDIPfcgOfyXQeuDz5dTl09/Q3E/8X0LOdoUbo8rSkKDWeo5rq2tHeH1vkg5b
 pvNZUPeizFVj2hLpGLV0oXn39DgEY+UJBxSFJmI1o97T79t3Bizlsj1w0OI9bpZxwFsp
 ipAQ2dR50izpZLUX5oFRDNw0F/Hvoopl3P0TgtsPFYQRFj2xX8mzTE6K8ntkd0KBQgxX
 UAHA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782141918; x=1782746718;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=kL1tj/BLw05+tMmUXWpE7p03gE32TyonQg4lQC1zuNQ=;
 b=L843bESL6zq+MxZQ+2qM13pMrI0IqdmkvZHXdYz1N4zfgcDY8sRoXvi0R6vGtZtyS4
 K+Ql2v9LZBm2XMDiAVmhGgSpPY3T+eNJX+ZZ+BxiJx0+q8D85Pf7V0IkdlPX44PxVklg
 mkL/+vZcqzbYI0BLLrNq3AopmR+IklsFu1ISh0XUqdY7zyexzqiLp+wkPgwtfjvuX5YW
 2ea02H73uP7WoGy67KhLzNGmFm43S7Dt3hlB2X2zXYtfutuTRH2GOr8gDP77EB3kGK6P
 LacTb0FNoEv3K4nHQNDpCFXFARcqEq0bdQw2mR7CNijQ1HUiZx15YwcXeLmoKsoHD6ei
 GIjg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Nq6DkdoDkcdI/GZxqn1i+6j9eO/Ez3F/bfbHexpLbcqXQM4bwbsao+lZLqdK8J2DBSyQdv/PgLdY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YzcED4L+CsWLNXVPS159iPwrax7SH705YjJLqIKT2/4pMF5Zw2f
 bEMbjadDhTXvqS/vnVTgq/V+9xow4DK1r7OWAi77Er+L0A1R2P4lHsft
X-Gm-Gg: AfdE7cmlo+7VTEXnegENiZO5Mi+L4WIz3Ycb6kellvVPBn0tSy77VKaVD6qhTn3jynb
 ZlnchShKDrXROtDkjF/X2gFLs2swJ7FP5Gxkn70z49rQJ9vpEM/aLjgXbAdQa47yetWhcmjp1mA
 umHI+XXOGksU1KJoEqEmqcUnRmjtQU+sQwLhMydxNrpaOlGbIGh3gATAu9nVSOoi487uchKy/9f
 t5PxT3fO+HNM+8L8bz2NmXTadx5VnsFQ25+dp1UAj9B6l2Ny4jn46CdDECSnezpDkJa824yhGwg
 9pvLsHMKze0oRb1yTpTWmB4r3M4eeMWyBIA2l1yUXnavfmFM2sgZKAdH/YTb9LuzdRbLg8UQFLq
 Xuy+jT+cmVMEjMyO2pXEvvaJMI48dfORLxqRpUT4HYAMp4Pv3xBJ5wK2YGlFdyRhYjDeqqJPRFO
 Sll2//b1EiqqA8MZXJM/ErRyxu3d8=
X-Received: by 2002:a05:600c:45c5:b0:492:41a1:f217 with SMTP id
 5b1f17b1804b1-49241a1f31fmr221649685e9.1.1782141917981; 
 Mon, 22 Jun 2026 08:25:17 -0700 (PDT)
Received: from anthony.local ([2a06:c701:49b2:4c00:12ff:e0ff:fea5:3d2e])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-492492338dasm217883655e9.1.2026.06.22.08.25.15
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Mon, 22 Jun 2026 08:25:17 -0700 (PDT)
From: Amit Barzilai <amit.barzilai22@gmail.com>
To: javierm@redhat.com, maarten.lankhorst@linux.intel.com, mripard@kernel.org,
 tzimmermann@suse.de, airlied@gmail.com, simona@ffwll.ch, robh@kernel.org,
 krzk+dt@kernel.org, conor+dt@kernel.org, andy@kernel.org,
 gregkh@linuxfoundation.org, deller@gmx.de
Cc: azuddinadam@gmail.com, chintanlike@gmail.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-fbdev@vger.kernel.org,
 linux-staging@lists.linux.dev, Amit Barzilai <amit.barzilai22@gmail.com>
Subject: [PATCH v2 0/4] drm/ssd130x: Add support for the Solomon SSD1351 OLED
 controller
Date: Mon, 22 Jun 2026 18:25:02 +0300
Message-ID: <20260622152506.78627-1-amit.barzilai22@gmail.com>
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
RGB OLED controller, to the ssd130x DRM driver, and removes the legacy
fbtft fb_ssd1351 driver it supersedes.

v1 [1] was a self-contained ssd1351.c driver. Following Javier's review,
the SSD1351 is instead folded into ssd130x as a new color family, which
also brings 65k color to the existing SSD1331. The work is split as:

  - Patch 1 adds the device tree binding. It was previously posted
    standalone as a v2 [2]; it is folded into this series here, as Conor
    asked, so the binding lands together with the driver and the fbtft
    removal.

  - Patch 2 changes the SSD133X family to drive RGB565 instead of
    RGB332, via a per-variant flag in deviceinfo. The SSD1331 is the
    only current member and gains 65k color from this.

  - Patch 3 adds the SSD1351 as a new SSD135X_FAMILY, reusing the
    SSD133X plane/CRTC and blit/clear helpers. The only data-path
    difference is the explicit Write RAM command (0x5c) the SSD1351
    needs before pixel data; it also gets its own init sequence and a
    longer post-reset settle delay.

  - Patch 4 removes the now-redundant staging fbtft fb_ssd1351 driver.

Testing:

  - The SSD1351 (patches 1 and 3) is tested on hardware.
  - The SSD1331 RGB565 change (patch 2) is compile-tested only; I do not
    currently have a working SSD1331 panel. Javier has kindly offered to
    test it on his SSD1331.

Dependency:

  The SSD1351 reuses ssd133x_update_rect(), which programs the column
  and row *end* address as a relative offset rather than an absolute
  coordinate. This breaks partial updates that do not start at (0,0). A
  separate fix is posted at [3]; until it lands, the SSD1351 shows the
  same partial-redraw artifacts. This series applies independently of
  that fix, but the two are best merged together.

Based on drm-misc-next.

[1] standalone v1 driver:
    https://lore.kernel.org/dri-devel/20260615181253.97551-1-amit.barzilai22@gmail.com
[2] standalone v2 binding:
    https://lore.kernel.org/dri-devel/20260615175620.88828-1-amit.barzilai22@gmail.com
[3] ssd132x/ssd133x update_rect end-address fix:
    https://lore.kernel.org/dri-devel/20260622122604.32500-1-amit.barzilai22@gmail.com

---

Changes since v1:
- Fold the SSD1351 into ssd130x as a new SSD135X family instead of a
  standalone ssd1351.c driver (per Javier).
- Add RGB565 to the SSD133X family, so the SSD1331 also gains 65k color.
- Drop native 256k color (no matching DRM fourcc) and the 0/180
  rotation support, to keep the series focused; both can return later.
- Binding: drop solomon,width / solomon,height (deducible from the
  compatible) and the rotation property (no consumer), per Krzysztof;
  use dt-bindings/gpio/gpio.h flag defines in the example.
- Remove the staging fbtft fb_ssd1351 driver in the same series (per
  Conor).

Amit Barzilai (4):
  dt-bindings: display: Add Solomon SSD1351 OLED controller
  drm/ssd130x: Add RGB565 support to SSD133X family
  drm/ssd130x: Add SSD135X_FAMILY and SSD1351 support
  staging: fbtft: remove fb_ssd1351 driver

 .../bindings/display/solomon,ssd1351.yaml     |  42 +++
 drivers/gpu/drm/solomon/ssd130x-spi.c         |   7 +
 drivers/gpu/drm/solomon/ssd130x.c             | 269 +++++++++++++++---
 drivers/gpu/drm/solomon/ssd130x.h             |  12 +-
 drivers/staging/fbtft/Kconfig                 |   5 -
 drivers/staging/fbtft/Makefile                |   1 -
 drivers/staging/fbtft/fb_ssd1351.c            | 240 ----------------
 7 files changed, 283 insertions(+), 293 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/solomon,ssd1351.yaml
 delete mode 100644 drivers/staging/fbtft/fb_ssd1351.c

-- 
2.54.0

