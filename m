Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7BF50C61DBD
	for <dri-devel@archiver.kernel.org>; Wed, 26 Aug 2026 17:49:01 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A639810E1D0;
	Wed, 26 Aug 2026 17:49:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="fIhwuTTg";
	dkim-atps=neutral
Received: from mail-ej1-f46.google.com (mail-ej1-f46.google.com
 [209.85.218.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CDD2B10E1D0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 17:48:59 +0000 (UTC)
Received: by mail-ej1-f46.google.com with SMTP id
 a640c23a62f3a-c1671ec8692so181642466b.0
 for <dri-devel@lists.freedesktop.org>; Wed, 26 Aug 2026 10:48:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1787766538; x=1788371338; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=GV19qGomh8jVFr0DU0I6wY2+mqT2GUa1szxwspwi060=;
 b=fIhwuTTgytjzQL3qXAQtDkBbgTdZt+I/p4WrUGID/N+Amo8kvHsDeHE2TFx0vcGpWP
 0ZPCVcQCEjWe1Jsit1mCw7yoXL+unqUJ42bXX9TQLcgEyqVtGivOUsJH2JXdvlkiV6Uq
 tx309PGFP9jKcy89V8fJACgpZFjQ/qivguQcpfpKU+N4kgDAxclzpvZVnZQmAaS454ar
 8HGpSMeOz0R7UvYDavMOivfPNmVc8xhhmbLVGeC7PkgfOTLaTODeu2fQUuUeVtuOXi/t
 COGlQFLYCyMmDDh5R1BMxK2FW7TEC0UyfCxqxxUqUVuzPtS9tOWvJ5nqdU7oQqb1DVyO
 IZkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1787766538; x=1788371338;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=GV19qGomh8jVFr0DU0I6wY2+mqT2GUa1szxwspwi060=;
 b=UF1EasMBRFWyQK5y63ZwrF5fkTBDdQCG0Uu8j1WehJOACZcrtPPACBt15BX7oatNfQ
 Fy7Xc4Acpi65cFQKePKZBuI3PwExU5GBD5+y1d7ou4JnsXB6mCfauFMFFgBnTq6MJd03
 PgH4iljWf+su3Wy5S6u79oLG4+CG+IaxhisOMFsft29fHvz3KwKigTYMnoqihAqGdHFw
 pQE1w+Co8nCNLfb6LVZLFy/4HAZfrlA0C0I9t4GfUvAVLxc22sK0lFT4HuCzSnd9r42q
 P1zEQWWhCkVl6yo3utiS5Wchths7x7E52OIiMo5ct6zhHSppwFkSL2a1ptVDmq5Y1tZm
 VKUg==
X-Forwarded-Encrypted: i=1;
 AHgh+RpO9nkLY6VCyVJ2LqU9Mjlp4/opFvx2pGGFAN07bM4jvPeTA0bZco34N3lACh3d+V7EFbClLDuV87A=@lists.freedesktop.org
X-Gm-Message-State: AFuF++nP/0lo9N3evc0ZCInpbT25QCowxuXAFidaqpvu5qjA4hrcCl/1
 CLgpoZvMUMS/Apr6rsXtHWtp/Yby484Qu9sXhRbejBPUD6f4H1gow8rQ
X-Gm-Gg: AR+sD11L0NQjqaXF/PZKCvDZUko4XjRvYo825f71Lxy2sY26FNIEcguXELzFzSDRiuI
 nJEl5fH9IjtH4d8nSS1oF63ECBuJv4GXAIuU7flqC2CnrrE+6xZYklujbz9LCaguLCXpDsRQyGV
 +yWn4/SOnjhUHv0FZfZEEEo9dTtRB+vSNqIcaTbpLSAAJGywYJQf4RimaSx4FSrOWQdHH5HK4LX
 LdoGqzuyjV291gHYJAgfb887BDIJoIBxN24E4pGCHUacOojFE9hN05xi8RYyLKBOxCXUzEu+4ei
 IVk9wkbv2Or1JWZGxZd6yrs8J4/itcB0YNqZAK+8RsIqnYpSPpj97sAVvzYNCEdaCbIxPDedLut
 0k2phVqbmsvkx/ILxBjDFXIIaHklcUKOJPwnsmCF64URFHbOytask5/8+UWZWvfFqJp/91lwI8A
 Kl3KEj+ElPA1F5RGrT5X37nRZvZbrElY11yOqV5f23VqsfSMGws2G75j3ivsupgWCFGL6oNZQvz
 rpQteIX0SBqtqpM7AidKpsj
X-Received: by 2002:a17:907:7203:b0:c24:dd7f:3254 with SMTP id
 a640c23a62f3a-c250c4492b6mr1005185866b.3.1787766538022; 
 Wed, 26 Aug 2026 10:48:58 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:aa64:3da0:a259:ecd5])
 by smtp.gmail.com with ESMTPSA id
 a640c23a62f3a-c250a88ac7fsm777752766b.30.2026.08.26.10.48.56
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 26 Aug 2026 10:48:57 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Philipp Zabel <p.zabel@pengutronix.de>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Bartosz Golaszewski <brgl@kernel.org>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v3 00/13] Add support for DU,
 LVDS and DSI on the Renesas RZ/G3L SoC
Date: Wed, 26 Aug 2026 18:48:34 +0100
Message-ID: <20260826174854.199139-1-biju.das.jz@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
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

From: Biju Das <biju.das.jz@bp.renesas.com>

Hi All,

This patch series aims to add DSI, LVDS and LCD support for the RZ/G3L
SMARC EVK. The RZ/G3L LCDC is similar to the one found on RZ/G2L, but has
LVDS support.

Patch#4 has build dependency on [1]
[1] https://git.kernel.org/pub/scm/linux/kernel/git/brgl/linux.git/commit/?id=d51fc9d4cd6eb18ac82913d83ecf7bd8c85f71ee

v2->v3:
 * Dropped binding patches as it is accepted.
 * Collected tags.
 * Dropped .dsi_global_timings from rzv2h_mipi_dsi_info as it uses
   different path.
 * Updated powerseq API names.
 * Moved set duty cycle from bridge driver to DU encoder.
 * Added min/max frequencies for DPI.
v1->v2:
 * Dropped renesas,sysc-pwrrdy property as it is modelled as power
   sequence.
 * Switched to power sequence for handling pwrrdy signal.
 * Dropped header file regmap.h and mfd/syscon.h
 * Added header file pwrseq/consumer.h
 * Replaced syscon_field->pwrrdy in struct rzg3l_mipi_dsi_info.
 * Restored ports in DU bindings.
 * Replaced endpoint with port in ports node.
 * Dropped the macro RZG2L_DU_FEATURE_SMUX2_DSI_CLK and RZG2L_DU_MAX_LVDS.
 * Dropped the variable rcdu from struct rzg2l_du_encoder.
 * Dropped the variable lvds from struct rzg2l_du_device.
 * Dropped renesas,sysc-pwrrdy from dsi node.

Biju Das (13):
  drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val to hw_info
  drm: renesas: rzg2l_mipi_dsi: Add activation_dly to hw_info
  drm: renesas: rzg2l_mipi_dsi: Move global timings into hardware info
    struct
  drm: renesas: rzg2l_mipi_dsi: Add support for DSI PWRRDY
  drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI support
  drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU support
  drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder
  arm64: dts: renesas: r9a08g046: Add fcpvd node
  arm64: dts: renesas: r9a08g046: Add vspd node
  arm64: dts: renesas: r9a08g046: Add DU and DSI nodes
  arm64: dts: renesas: r9a08g046: Add LVDS node
  arm64: dts: renesas: Add DSI overlay for RZ/G3L SMARC EVK with ADV7535
  arm64: dts: renesas: Add LVDS overlay for RZ/G3L SMARC EVK with
    ITE6263

 arch/arm64/boot/dts/renesas/Makefile          |   6 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 139 +++++++++
 .../r9a08g046l48-smarc-dsi-adv7535.dtso       |  95 ++++++
 .../r9a08g046l48-smarc-lvds-ite6263.dtso      | 104 ++++++
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  24 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |   3 +-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  24 ++
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 174 ++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 295 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
 12 files changed, 895 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-dsi-adv7535.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-lvds-ite6263.dtso
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

