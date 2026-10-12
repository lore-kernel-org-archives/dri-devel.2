Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 83F1FCA9ED5
	for <dri-devel@archiver.kernel.org>; Mon, 12 Oct 2026 06:45:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id D845310E4AD;
	Mon, 12 Oct 2026 06:45:37 +0000 (UTC)
Received: from mail-pl1-f178.google.com (mail-pl1-f178.google.com
 [209.85.214.178])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3C9A110E44B
 for <dri-devel@lists.freedesktop.org>; Mon, 12 Oct 2026 06:45:31 +0000 (UTC)
Received: by mail-pl1-f178.google.com with SMTP id
 d9443c01a7336-2d01548ac96so931605ad.3
 for <dri-devel@lists.freedesktop.org>; Sun, 11 Oct 2026 23:45:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1791787531; x=1792392331; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=ouRjuP1RtfyniT15YEA/gc6km+f4No4a2cccPN4BtkA=;
 b=EGFbQAtrhBRTlxTzDwHgHmwAc4ybMVMN6RMN/oFHHTSfqMIIRy/VpJ2lFKzO1I8RLU
 XfM23xfwm5lBrAJsvOUR7uffxtB631pxcVbbEysmT/0pcyp4jAHgI5oSA+V8IRWWBDr9
 gK4nFW87DHX9MPqEAOxnj4qClwHSPVTZuask7ePOWMa9GR1nEcBExcic7llfPFp4jgxG
 fumB6aqbXre/y+YdQmDa1zMF3ZfdFtE0CkQo8i5IK6prhWUThLk9cOYc9hY36BBDXOBs
 7OfxqzjaQd50B62Tsam4BtacKqhlLuAnk4HOmn/CTDSMUw9OB8YwRgPIOiG9j3NDuQ5v
 zG/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1791787531; x=1792392331;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=ouRjuP1RtfyniT15YEA/gc6km+f4No4a2cccPN4BtkA=;
 b=qvobKEAUMg2+/Lju62BJ5Rlo8+VsQ6uj2Gd+OFzH3kap/NLbB3leldDexMtkNhxL11
 7/+KWkenqX5Yy/hdqgcyGEUuuZFaHxHDqGneRoT3c+dncBK4qf8TfJmXTUnt4TcMWh75
 MtLwR+UerqVS61izP7910fOcEhf3sUlUlbcfnShD/saG4EmnVEWDm+35WmeSsAa1lWWj
 nuDLxHzHD+duVSZnbUjbLiaO2Oi3xnDF8XiSrI7VvPBViRR4Ily1kj7hL4Y4F32mrSsv
 eTXbfLYViV0jdSrERWvCt/fEJyd1u1hF/AOxzfJd4kw3UbyK8RYjaxB28BdmlNlvtUAQ
 kLcg==
X-Forwarded-Encrypted: i=1;
 AKwUvBzXSPRWnvNuh4R2buMdjGYi/+vWOp9P+Kr2jHK9dGw5bXTLCrMp9r3TtqFMxBF58yTjklp+Bpx1+QI=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYIJ+1KrLqKIdM3rHMiePrFqwmAf51acTL2DZ5+eVQj1XbkvxJLk
 CAxmpAe2VArqAQA0CZF1SGMeSNMH+CPM3/t15VICGMMVZsrZzSFLA349
X-Gm-Gg: AYBFou1/EhlTKBEBob4xgcO8AHBQWhwULgfO+GHjI0yWqaOCkXMZ44+kfyefIewTcr0
 8ZjgAUSiQrUqL4XWbm8PH2IebalFQvSR90ym69b36SNML5tEGAU6EzV7aPSYbUBt3ngrykemMHB
 tILLKbPdu+odXymZwrFN8nfoRowY4Hq7JnshSwP6HKfq5TOT0pgyvbEPVV01bpPLG1riCVMBFU5
 sKH+eQAMZb1esa/OgARwQFa6VJ/XNnN4WgqRXatC74NYD0Cng91oC5A02noKuMe/5yB5ZZYQFg8
 9OnwdaZzkE6znsYfWgb9Y8YlMmJRe9SlOZJFm4BH5k/2mt1+I9Fp+C1DUtGDIJQGaKcqpm+2lqx
 WhTRXjOOb+DtPXI9F8nyOBVp9juXLfbM+ce0fKm2UFOQpip+HuZwS/frZ72TkZR910Jkyug16Mc
 GgPaseoEuoPkSoaqxGTmo/ZufmhtdLLiMdKQaK5teS+RcqDuIew2E+UkQ5JMsg42xp2hbI
X-Received: by 2002:a17:90b:224e:b0:3a0:bcc8:1549 with SMTP id
 98e67ed59e1d1-3ab3afb180emr11995577a91.6.1791787530571; 
 Sun, 11 Oct 2026 23:45:30 -0700 (PDT)
Received: from marchy ([2405:3800:8a8:86f0:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3ab36ed0daesm15052355a91.5.2026.10.11.23.45.29
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 11 Oct 2026 23:45:30 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 azuddinadam@gmail.com
Subject: [PATCH v4 0/2] drm/tiny: Add RAiO RA8875 display controller driver
 support
Date: Mon, 12 Oct 2026 14:45:03 +0800
Message-ID: <20261012064518.3497285-1-azuddinadam@gmail.com>
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
as optional/required properties respectively per review feedback
for boards that do need them.

Tested on a Raspberry Pi 3B connected over SPI to an East Rising
ER-TFTM050-3, a 5" 800x480 panel driven by the RA8875 in Linux 7.3.0-rc4.
Based on drm-misc-next (commit 73df79cceb8c)

Link to v1: https://lore.kernel.org/all/20260916175942.3186804-1-azuddinadam@gmail.com/
Link to v2: https://lore.kernel.org/all/20260924145400.1385815-1-azuddinadam@gmail.com/
Link to v3: https://lore.kernel.org/all/20261001144128.2336301-1-azuddinadam@gmail.com/
---
Changes in v4:

Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml:
-  Drop the sentence in the description saying the binding covers only the
   SPI-connected device (Conor).
- Drop unused panel label

drivers/gpu/drm/tiny/ra8875.c:
- Catch error value from ra8875_write_pixels
- Use consistent include header format.
- Return if fb is null in atomic_update
- Drop unnecessary extra byte in pixel data spi write.

drivers/gpu/drm/tiny/Kconfig:
- Add depends on OF, which is caught by intel 0-day[3]

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
[3] https://lore.kernel.org/all/202610042347.idGisdDW-lkp@intel.com/

Adam Azuddin (2):
  dt-bindings: display: panel: Add RAiO RA8875 display controller
  drm/tiny: Add RAiO RA8875 display controller driver

 .../bindings/display/panel/raio,ra8875.yaml   |  77 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  13 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ra8875.c                 | 719 ++++++++++++++++++
 6 files changed, 818 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

-- 
2.55.0

