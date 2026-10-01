Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6D234CA5FD2
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 14:41:37 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB76110E72A;
	Thu,  1 Oct 2026 14:41:36 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="bGZ24TO8";
	dkim-atps=neutral
Received: from mail-pj2-f12.google.com (mail-pj2-f12.google.com
 [74.125.227.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 38F2110E72A
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 14:41:35 +0000 (UTC)
Received: by mail-pj2-f12.google.com with SMTP id
 d9443c01a7336-2d6ff2b84fdso3823035ad.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 07:41:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790865695; x=1791470495; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=QCSnuGxp9XE7dQhnhZvQokcC2NUIPJCMksF4os7NREE=;
 b=bGZ24TO8YEUSK5tCdjf5KsmuWWJDoAo8XFhqC9HilWNbLCavJgzcFuViBTlZf6Y7GE
 PlYZi73BtfLmwky+fiVKRgLa7/qqfNxL+bs9bnTSUx4+rThz3gU5kuCEKH/0s6w5HOwV
 wf53pxPxNa7JhshDBVLZKnAClJn0+U1CdhHhbmrynKL6PGktyj87O2WDKtmptVI1YOo1
 wybopRJ0SHNmhsozlBlwprQaGK1hQgBNl1aa0rdyD+974938cNhu7WlZjDpoVHVGhHjy
 S27n3Q9TDRwEr7Jwvl2JF/aC2AdBNuEXwPWzO513zrgZR1bZIRQrmustPhzCVDS8W+q/
 Foig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790865695; x=1791470495;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=QCSnuGxp9XE7dQhnhZvQokcC2NUIPJCMksF4os7NREE=;
 b=hMJ3ZP/Udv0sgrVpk+KifX4BZ105P49dJ3ONLHZ4v1Mq3VS5F3zpYpx8MDtdjhWZgO
 PkSmDR4nRC8LIfsoOW0NICqeDlrqYs4Uc7KH7OhYBWd+7zx5Cj7xGMWAQooQq/J4LYU8
 NGAsWHHZ1Ks1bDRnBOs6ifQZ+Lwd34oehmrobchk6iuQCIPFWVuxfV50bBaK/YW6J7FL
 6Fg/arQSwmo1+0Q/2TtLVGhgkXB8efvrWaMDWT/UWFBzsu/8WBmgV53kS46Q9RGo0NXg
 KxnSYe8uvdz524gEmTqF8uf9lXl/ZoCYuWzjhbw0Y0UYvvPzOge1O1Pj6tOzYEIFGs7H
 AhRg==
X-Forwarded-Encrypted: i=1;
 AKwUvBySsbNXifBVkA6JzLXRVI3CY2I2AW2BVzU+4jPdKiuUF3dta6dND04Mo2UfSLtAbGs9wokMBD4AJnc=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJP8HSRBhskdmIQ0TnsR0AIcTzNWZfg8YWPYIfrSlUs66jnD+R7
 PDXC2let3YoD1A8E/cdz/V5QpzjBW+VYVv/kE4yKpjAPHR7MfByiOGCj
X-Gm-Gg: AYBFou16c01UW7Fcr/hyvSgq0LIqpnf6VA98Fks4XXsSymZAP/OW8ihzw9OuQYFEWKP
 Zji79Xe4yvBLiMwRqrm0mwdA/XkQTqs7sRzxyGFOvcvicgrFDfaC18zrEdQPSrS9PYDf3Doagjj
 hTxl5Q6NvF4hhm7vrMQQvcPJLK10Tr0Pv4vHATa/aaL72Eb0l34cjnXRf3lGWECZ0dLJuK0e7gS
 R5gWiedugmXDpZzHEu8JjSiQ5zF0kmALfhyjr3k5XnzUJhiFjX+T4fVrFlZzGp85evjFkCNGgmv
 Fn0MGAakL9O9oJN5RzARtA5vqI3ewiH18gy0QTxGZRs1O4+UrdRJhUW2NfTBwrdg31pkU64e6Sl
 pZo2lZRRjGQp41lRiAQc5DeCsegvOpTVF+OqQRsa5YznWMkuhy5NyeAp7oUYliuR/5wltLYD87+
 ssNZE7jh2Jbbv3PJs96clsrnNUb21wPNG7uIP8DeqFCpYzpA1zN1LLcSYN/aWoXbiJFT0p
X-Received: by 2002:a17:903:9cc:b0:2e2:cdbe:bcea with SMTP id
 d9443c01a7336-2e2e48cd1b8mr64108075ad.1.1790865694615; 
 Thu, 01 Oct 2026 07:41:34 -0700 (PDT)
Received: from marchy ([2405:3800:8e5:44e3:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 d9443c01a7336-2e30099c306sm11988435ad.21.2026.10.01.07.41.33
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 07:41:34 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Azuddin <azuddinadam@gmail.com>
Subject: [PATCH v3 0/2] drm/tiny: Add RAiO RA8875 display controller driver
 support
Date: Thu,  1 Oct 2026 22:41:24 +0800
Message-ID: <20261001144128.2336301-1-azuddinadam@gmail.com>
X-Mailer: git-send-email 2.55.0
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

This series adds a new drm/tiny driver and matching dt-binding for the
RAiO RA8875 SPI display controller. An fbtft driver for this chip
currently exists at drivers/staging/fbtft/fb_ra8875.c, but fbtft is a
legacy fbdev-based staging driver, and nothing in mainline DRM
currently supports this controller.

This driver does not use drm_mipi_dbi. The RA8875 SPI protocol is
structurally incompatible with both Type C options drm_mipi_dbi supports.
Type C1 encodes command/data as a 9th bit within a 9-bit SPI word. The
RA8875 uses a full prefix byte (0x80 = command write, 0x00 = data write,
0x40 = data read, 0xC0 = status read) sent as a separate 8-bit transaction.
These are not the same thing and cannot be mapped to each other.
Type C3 models two transfer types via a D/CX GPIO. The RA8875 has four
transfer cycle types and no D/CX pin.

My ER-TFTM050-3 board has RST tied NC, and VDD is a fixed supply
set via an on-board solder jumper rather than software-controllable,
so I couldn't test reset-gpios/vdd-supply myself, but added them
as optional/required properties respectively per review feedback for boards that do need them.

Tested on a Raspberry Pi 3B connected over SPI to an East Rising
ER-TFTM050-3, a 5" 800x480 panel driven by the RA8875 in Linux 7.3.0-rc4.
Based on drm-misc-next (commit 7c4bda20eb0f150315d19f1b51058820e75d3f3d)

Link to v1: https://lore.kernel.org/all/20260916175942.3186804-1-azuddinadam@gmail.com/
Link to v2: https://lore.kernel.org/all/20260924145400.1385815-1-azuddinadam@gmail.com/
---
Changes in v3:

Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml:
- Add gpio.h include in example to pass dt_binding_check
- Remove spi-max-frequency as there is no reference in datasheet

drivers/gpu/drm/tiny/ra8875.c:
- Remove debug-only ra8875_read_reg function
- Chunk large SPI transfers to 16 rows per chunk
- Remove unnecessary includes and spi cs setups in probe
- Create ra8875_write_pixels function for clear_screen and fb_dirty
- Use 2 spi writes instead of 1 write with 2 transfers and cs_change in write_reg

Changes in v2:

Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml (review by Krzysztof Kozlowski):
- Add hardware description to the binding
- Drop the display-timings property, and instead require it in the required block
- Add a required vdd-supply and an optional reset gpio property
- Rename the example node to a more generic "panel: display@0"

drivers/gpu/drm/tiny/Makefile and Kconfig:
- Remove TINYDRM prefix from the config name (Thomas Zimmermann [1])

drivers/gpu/drm/tiny/ra8875.c:
- Reformat device_id table to match current convention (Krzysztof Kozlowski)
- Drop unneeded linux/mod_devicetable.h include (Uwe Kleine-König)
- Use drm_dev_unplug() instead of drm_dev_unregister() in remove callback
- Move stack-allocated cmd/data buffers into ra8875_device struct
- Add mode_valid() callback to validate height/width against panel maximum
- Add optional reset gpio
- Use dev_err_probe() in probe function
- Remove connector detect callback
- Remove unnecessary |= on register write return value in hw_init
- Migrate from simple display pipe to manually-handled plane/crtc/encoder,
  following the simple-KMS-helper removal effort [2]
- Use defined constants instead of magic values where possible
- Use drm_atomic_helper_damage_merged() and drm_fb_swab() in plane update

[1] https://lore.kernel.org/all/fee2a743-d3e4-46b4-812f-05c3cc3a46ae@suse.de/
[2] https://lore.kernel.org/all/20260705-drm-simple-kms-removal-v1-0-b4e1ca053623@oss.qualcomm.com/


Adam Azuddin (2):
  dt-bindings: display: panel: Add RAiO RA8875 display controller
  drm/tiny: Add RAiO RA8875 display controller driver

 .../bindings/display/panel/raio,ra8875.yaml   |  77 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  13 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ra8875.c                 | 713 ++++++++++++++++++
 6 files changed, 812 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

-- 
2.55.0

