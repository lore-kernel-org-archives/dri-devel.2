Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DF8A8C9830E
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 14:54:12 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4087510E1A2;
	Thu, 24 Sep 2026 14:54:12 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GgHOd8Hl";
	dkim-atps=neutral
Received: from mail-pz2-f40.google.com (mail-pz2-f40.google.com
 [74.125.228.40])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 319B410E1A2
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 14:54:11 +0000 (UTC)
Received: by mail-pz2-f40.google.com with SMTP id
 41be03b00d2f7-cc769b0498cso34957a12.0
 for <dri-devel@lists.freedesktop.org>; Thu, 24 Sep 2026 07:54:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790261651; x=1790866451; darn=lists.freedesktop.org;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:from:to:cc:subject:date:message-id:reply-to
 :content-type; bh=p2jed+r/RYO8PQdQxEYLrGM4HfS4Po2jUlT/jQ5ucjw=;
 b=GgHOd8HljStJE/j4fGnPX4SL51U2ebURK/Fk4N1L3ta+gjPOZM5QqO0YkRpsj3n9md
 4yXhgspgsjx4ejJkurVCKsveu14wKYabPchQIHwiMIKuf6z9rLPB/1/qb/ft/rUDmYZc
 jgi3taIJIYt8he0JFxcth5boLQI/f5Pdv/Pw4lJFib3BtUIJJDlkJ0J8BiWTViR3aY14
 bjbzgGO5byd1m+a/fZgUoULzQ9VRrWq4BgPok/GRbfghggSMiToDaI4yv6L65BZ8RiC4
 /SSkWIOUz7WJ61oGkgJ0uojSk3Hor33gvbBf2i7YQO02n1Fi8Z10aYx6apcjJpSkQhPU
 wSzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790261651; x=1790866451;
 h=content-transfer-encoding:content-type:mime-version:message-id:date
 :subject:cc:to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject
 :date:message-id:reply-to:content-type;
 bh=p2jed+r/RYO8PQdQxEYLrGM4HfS4Po2jUlT/jQ5ucjw=;
 b=tUcxSR74j0FUUZVn2oIpjcMwClHDfjjGzRHqmucJ4UgZaHnQNh44BaJG1FM8waJvW7
 qoYsVgcCBnrtc0GUo+Tctv+cYiwB8xlbGPZ6TKLn25oKqOHt+TIif2XgjJfSSDOeA25r
 SFtyfBsVGPdtn5JJWyAbEm6eQqHSWfosMkObvDBbvue27+SvVv4NtUjtrbixDOp0zhZI
 dOWhxQCAfN/3aoymLFMMswSmq5UWY4lSGIGPTsZS0adS43Rvn9/ydn2OV4a/hLnJCdDe
 zvp2oNchEVHgdkH3NgTbuG3r9kTZGsr/o0qiViqlQXhUjQFBlTIakvalvBmGsnFY6nzn
 /L7w==
X-Forwarded-Encrypted: i=1;
 AKwUvBxo0pKsqPqIygevvrUiMSIF7tBGShg0qHSf0ZE0iBcZrZXUa74h5p2SsbYpk+Bin2cSS5fCKYB3SRM=@lists.freedesktop.org
X-Gm-Message-State: AFuF++k6EORAYLL/dvD/l2lTBEn1m1bJ0IAev6H+seScoNT/zPdk4fs2
 Hil289kr4zMOGrygjHDIQ/IGtlRyWMxc5jn3OtvRwXn6O7EqzGx5rdaN
X-Gm-Gg: AYBFou3uREV2qoW+KX/r0VyAylWAyOlb3jWHxXusFtEmDnC1vxM5lnhyAYZSyxJAY6C
 xuDw1nk03sPsDqoiZyYw9TZ+BA5r9tV7+7DAHaSGjc7RpSuNBq29+08zdKgmq4y7y2BsYVs/JY+
 h7FM2gb7K9LLAHgFQPYfKoRnvXxw4A2VZGXOdSx3CDEu4s265MZtqBkxdD582X5ne6CcKJwVWwU
 Hfx7TM0Gihn913hbNCI0MSA5EKNiZguLzqGPRoPlTICvAVc+DzPSs7P3mSn/+Y3oaTcSRvYLIuR
 ogj+iskaVxUGx73etGcTjtLlTFByDgqBrXI6No4/oaS+SsRGgqnWioVuz/d7emFU9tqTDceZcYc
 lXsMo0SUiT3zKC9COBm1oqmVqcbl9vcCXcOFLDv5xGwXi3JPC8lt7/g6xHML+LUpQ31Sl+GNNzd
 l5gsVnIrfkCjBhN3iq/7P/zoj+dxX4IyvVp8BLVFT1FEqXC3M0VsKtFz1T4M+yKoYfZF9V
X-Received: by 2002:a17:90b:39ad:b0:3a0:60c0:7f8f with SMTP id
 98e67ed59e1d1-3a0b21d2233mr37250a91.0.1790261650464; 
 Thu, 24 Sep 2026 07:54:10 -0700 (PDT)
Received: from marchy ([2405:3800:9cc:defe:ee8e:77ff:fed4:d18b])
 by smtp.gmail.com with ESMTPSA id
 98e67ed59e1d1-3a097344841sm5391590a91.10.2026.09.24.07.54.09
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 24 Sep 2026 07:54:09 -0700 (PDT)
From: Adam Azuddin <azuddinadam@gmail.com>
To: robh@kernel.org, krzk+dt@kernel.org, conor+dt@kernel.org,
 neil.armstrong@linaro.org, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de
Cc: jesszhan0024@gmail.com, airlied@gmail.com, simona@ffwll.ch,
 andersson@kernel.org, dri-devel@lists.freedesktop.org,
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
 Adam Azuddin <azuddinadam@gmail.com>
Subject: [PATCH v2 0/2] drm/tiny: Add RAiO RA8875 display controller driver
 support
Date: Thu, 24 Sep 2026 22:53:54 +0800
Message-ID: <20260924145400.1385815-1-azuddinadam@gmail.com>
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
as optional/required properties per review feedback for boards that do need them.

Tested on a Raspberry Pi 3B connected over SPI to an East Rising
ER-TFTM050-3, a 5" 800x480 panel driven by the RA8875 in Linux 7.3.0-rc4.

Link to v1: https://lore.kernel.org/all/20260916175942.3186804-1-azuddinadam@gmail.com/
---
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

---
Adam Azuddin (2):
  dt-bindings: display: panel: Add RAiO RA8875 display controller
  drm/tiny: Add RAiO RA8875 display controller driver

 .../bindings/display/panel/raio,ra8875.yaml   |  78 ++
 .../devicetree/bindings/vendor-prefixes.yaml  |   2 +
 MAINTAINERS                                   |   6 +
 drivers/gpu/drm/tiny/Kconfig                  |  13 +
 drivers/gpu/drm/tiny/Makefile                 |   1 +
 drivers/gpu/drm/tiny/ra8875.c                 | 808 ++++++++++++++++++
 6 files changed, 908 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/panel/raio,ra8875.yaml
 create mode 100644 drivers/gpu/drm/tiny/ra8875.c

-- 
2.55.0

