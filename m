Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14E22C43458
	for <dri-devel@archiver.kernel.org>; Sat,  4 Jul 2026 09:34:38 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3A85710E03F;
	Sat,  4 Jul 2026 09:34:38 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="QHJK/DIl";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 19F4010E03F
 for <dri-devel@lists.freedesktop.org>; Sat,  4 Jul 2026 09:34:37 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-493ae59eca6so9161215e9.1
 for <dri-devel@lists.freedesktop.org>; Sat, 04 Jul 2026 02:34:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1783157675; x=1783762475; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=7v5Pm7hcHoKncuVk3HS0rjh4rfNcOYchDGYsTPk7k5s=;
 b=QHJK/DIlKzMHVn8aZUA/N2t4GvG+/rxb+G8DVqpY7udqO57ORzFNpuqT5aZfW4bz2T
 hi9YqOT49+iEac9Ynue6T8HHZBTxHeyYG39VjLLdqaaT92ULEYIKJ3vab9RHnL1mTqYm
 cuq1vxEs9wMYuzaGPrnp2nyGdllxS1PNhc06bCeQiIVQVlwimGYBCElt81KMc+1LWz7o
 rmQoBENAKgk9srq3+jpjk7hLcU3zxQeLouJdBKh4/eq9M/JU5RxflDfvP+ZMOV/KjDAF
 tK2I7LdE1T8DeRQHjE1oX4WjD3t+qLlvVhXWiYAVfmUhHo6Dj1qiIfoHQ+JTViYvYGLA
 reTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1783157675; x=1783762475;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=7v5Pm7hcHoKncuVk3HS0rjh4rfNcOYchDGYsTPk7k5s=;
 b=WXZ48ug4p20iuRLhVoLjM8MzNTPCKFY75/MSzRv1olcb5p7EXhqRJpYZ0v6FYteTnU
 SE54A9gvOVHveBUryip/l2o3v9jIgmBwb2NR0TeMofs4IUVDdIzhe3WGT5uA72toLWZP
 /jNLEmsJa7bo3y317s5e5QQSW3j7zOWfyWT3GSyMfpGfLwsIElVfVW7TCwCRCxL1w21/
 4IkAnZt4uE3enin2iv6Bo61OSUi5Kz5EPSVoDYDk87IGeJWwv/H9TnP7nvB/TH6e1JSl
 N1mCzpfnsxAU0aryJAue89Mn2B90DhvV9VOspk0Pe0Ut+7ccFhj0vFyRK3aHiv39qSdU
 3gYQ==
X-Forwarded-Encrypted: i=1;
 AFNElJ/0+16XJZuR0DuvSYNKF2ljJFMq5pDaTrwRxxqv2nNW5sWwjpa48HA8cKWPOp4DaK+s02oO5kDI9Lk=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yz95VyckmWugXcKQw7EKgIs4kFOMlC57o0FG86IuWRfr7WIT0st
 L4RQD3lkZ/2b2+kF5lKaW33kz3KvmaEfVY2Bo/6YcGcp+SxoOCgFJJ2Z
X-Gm-Gg: AfdE7cliRo6/+XhKZGViv3ENs7sEQ8oj+PTvT3NHGxFdQ0iaYiuEdxaLe1l/F19EE1q
 GX4Af8bvK/HTlJIw9KLBygwTaM9O3v+Li5r2vg3Bj75JnTWs780BYVROh3WmclZ/flk10ONwyy9
 heIdjgEfah2apb9Ly7EpoJ0wN9PgcJin7pzNRAK9z8fEdQMTo+ISu0/laN5oKK2cnWldSv+L4IY
 SdSYAVwCAsi47Z9Au7DF45B+FAXcRF20VEbtVUkiCVA+aWbtV1FWAxnxLxuJOfhPALuMGn0svkv
 EeXoIBiIHMg7CRjht/YoT2BybIbGBo3zuhr6MLG/pwVJXIL2hIeNcZ5gIF6NlxllE0m36Nu1fhj
 GI1++LeH0kbus/rqZtipK4qZxQ+381/F1I2Yj8KwRRsISLKMexndk/zDj6JWOxxtOcz7r3oxaAZ
 QivPDGqM8x2oWnNvUSVNZm
X-Received: by 2002:a05:600c:8b76:b0:493:d21f:8f98 with SMTP id
 5b1f17b1804b1-493d21f9075mr19743205e9.36.1783157675277; 
 Sat, 04 Jul 2026 02:34:35 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:8c5b:5b11:f6a5:9bc9])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-493cce040b4sm153180235e9.10.2026.07.04.02.34.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sat, 04 Jul 2026 02:34:35 -0700 (PDT)
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
 Conor Dooley <conor+dt@kernel.org>,
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
Subject: [PATCH 00/16] Add support for DU,
 LVDS and DSI on the Renesas RZ/G3L SoC
Date: Sat,  4 Jul 2026 10:34:10 +0100
Message-ID: <20260704093433.273672-1-biju.das.jz@bp.renesas.com>
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
LVDS support. It is simpler compared to RZ/G3E [1], hence sending
this series to get review feedback. Based on the discussion on [1],
will rebase this later.

This patch series has a dependency on [2].

Also, the LVDS series [3] is merged here to get an overall picture.

[1] https://lore.kernel.org/all/cover.1770996493.git.tommaso.merciai.xr@bp.renesas.com
[2] https://lore.kernel.org/all/20260619164030.380098-1-biju.das.jz@bp.renesas.com/
[3] https://lore.kernel.org/all/20260625172359.292631-1-biju.das.jz@bp.renesas.com/

Biju Das (16):
  dt-bindings: display: bridge: renesas,dsi: Document RZ/G3L
  drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val to hw_info
  drm: renesas: rzg2l_mipi_dsi: Add activation_dly to hw_info
  drm: renesas: rzg2l_mipi_dsi: Move global timings into hardware info
    struct
  drm: renesas: rzg2l_mipi_dsi: Add support for DSI PWRRDY
  drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI support
  dt-bindings: display: renesas,rzg2l-du: Document RZ/G3L SoC
  drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU support
  dt-bindings: display: bridge: Document Renesas RZ/G3L LVDS encoder
  drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder
  arm64: dts: renesas: r9a08g046: Add fcpvd node
  arm64: dts: renesas: r9a08g046: Add vspd node
  arm64: dts: renesas: r9a08g046: Add DU and DSI nodes
  arm64: dts: renesas: r9a08g046: Add LVDS node
  arm64: dts: renesas: Add DSI overlay for RZ/G3L SMARC EVK with ADV7535
  arm64: dts: renesas: Add LVDS overlay for RZ/G3L SMARC EVK with
    ITE6263

 .../bindings/display/bridge/renesas,dsi.yaml  |  15 +
 .../bridge/renesas,r9a08g046-lvds.yaml        | 120 +++++++
 .../bindings/display/renesas,rzg2l-du.yaml    |  27 +-
 arch/arm64/boot/dts/renesas/Makefile          |   6 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 140 ++++++++
 .../r9a08g046l48-smarc-dsi-adv7535.dtso       |  95 ++++++
 .../r9a08g046l48-smarc-lvds-ite6263.dtso      | 104 ++++++
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  22 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |   4 +
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |   4 +
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.h  |   1 +
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 206 +++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 299 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
 16 files changed, 1072 insertions(+), 10 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-dsi-adv7535.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-lvds-ite6263.dtso
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

