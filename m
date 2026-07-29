Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E426EC53200
	for <dri-devel@archiver.kernel.org>; Wed, 29 Jul 2026 12:55:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 03F6D10E040;
	Wed, 29 Jul 2026 12:55:26 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="i3IX3eOa";
	dkim-atps=neutral
Received: from mail-wr1-f46.google.com (mail-wr1-f46.google.com
 [209.85.221.46])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8634D10E040
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 12:55:24 +0000 (UTC)
Received: by mail-wr1-f46.google.com with SMTP id
 ffacd0b85a97d-47f71156e1aso521202f8f.3
 for <dri-devel@lists.freedesktop.org>; Wed, 29 Jul 2026 05:55:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1785329723; x=1785934523; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Z1wP4pta5UyofIbZoGK/pLyizl12pGGfGAIOeMl3uuI=;
 b=i3IX3eOa10teroox66D1RkPcBGZgGiMu7WxHMeUXTqWNINWbqi+8v/QjM9JVN+kXrI
 oa03fHZApHsLaL6PygG+624I/1byklm0ncmvcP4m8u+gxbxpRQW4HpgRMIOI+bgHeDMD
 xUNN3BqyekXVVKj6d6w9aHPGBlDqGULxH+c3BnrYsPFFC2OuTzeaGVgrJm0h+vjd7jrv
 S9U8KqT/KvVkLXunQ2ZdcA+7wllon0fyuE86DPy1csWTSLApNQkVOjUXcf6GWlgP4fif
 56ZODLPyB/rsd0TOzGqACuPOChBYY8K/GER6yrEt8+BRqwGNqglM5naAsrIXo1UJtcVj
 QJbw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1785329723; x=1785934523;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Z1wP4pta5UyofIbZoGK/pLyizl12pGGfGAIOeMl3uuI=;
 b=Zh3ALsr9blLN66fyooCCI4+0/NY1I+AvMu3lV/56MW6PrwMXRsVTbmVapbdRLFoiOh
 KqNtqwfDE1R9sC5/CJxGK64qtqTkxZjUFADOnNhb33yQMCmhlOcogzSvjQNVazJTJj+1
 2ym+fN7YYRGaDAyX1NdxV/1/1E9c0px0dkRISEZANB32kgcYh2UFzH0ovcKetAaFU8OP
 6uyWJLZgQY1lG9d7FWAwy+NKSrQqcSn1qoLppfjcpw/MOJ7lmyKK+Vthk8qrJLVOybr/
 +JK/YVKpvBgxicR1+CPHJqw/ZtYfek8hMRuhKoQ7xSjA7W/1z/18Ou+GcCkJ++29Pjlj
 BEnA==
X-Forwarded-Encrypted: i=1;
 AHgh+RoRE2xwveCdSkQ+wgah/oef6J0jVpZ5GuUjDHx64j+zejKSYvzX7o0uYQ8MQ4NyKnq0o7LILFf/Uaw=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Ywr6ojqV756Qe7PPDbU2LVuE32p0dmbVoRM7jJ80RBMocXANBVY
 GqJsJ8SxOpbh4/ozaF20OGn51k275SDMl9bFR6Yt9Rnfp4/7vXJNTTmm
X-Gm-Gg: AR+sD11SB7RJH5t4Z1/bUET+nfaU79/DwiafN+kvrSi/3f4YmSpNsVFEf9uiiIc/hJb
 kDZ1ej+p0TSE0NiEYr8GbAmEyDFS2mf8QyOlp73GQI6M6XDObqc6wPEGUcxFBaIHVk5rP354H48
 P24Wby5Od3JKaHJ6IxLO2USkIKcGBsyPVMcRXpJdbEzU6keduyntJlPsaODNSjbZUotddUILeIR
 tk676BjDHKJImaxTbqBbH7iB98ACZHFfJ2PKtw7dQrCZtSpTsKvreCKGOSBMnSYhY60uH9jToyl
 q2ankouOcz1NT3DVq+tGI3AqrH94SvmdUXDgM6boV1SM8CNhp3sFWElN/v9C/EjIQ89g1IcDRyW
 IBPSQIp0ADinXqSxv3fuKSupqIzQIWTJPrrvs9eqDIJ3TkY1mbgRb5SFugW67Qv8O1G6dwTFGzQ
 PDIrZatdWkqVqnXeHnsCBdeHyUDZu7evC7jrG6zXAjXH3MbDAi5ZNyVxDj+e2C7KsdFnsrb/fll
 38f7Rw377wtFg==
X-Received: by 2002:a5d:6f13:0:b0:47f:7fd1:9602 with SMTP id
 ffacd0b85a97d-47fb1e87636mr7709094f8f.11.1785329722702; 
 Wed, 29 Jul 2026 05:55:22 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a702:d301:10b8:4461:ee04:15e2])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-47fb6b189e5sm9264645f8f.27.2026.07.29.05.55.20
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 29 Jul 2026 05:55:21 -0700 (PDT)
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
Subject: [PATCH v2 00/16] Add support for DU,
 LVDS and DSI on the Renesas RZ/G3L SoC
Date: Wed, 29 Jul 2026 13:54:52 +0100
Message-ID: <20260729125516.230757-1-biju.das.jz@bp.renesas.com>
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

 .../bindings/display/bridge/renesas,dsi.yaml  |   1 +
 .../bridge/renesas,r9a08g046-lvds.yaml        | 120 +++++++
 .../bindings/display/renesas,rzg2l-du.yaml    |  26 +-
 arch/arm64/boot/dts/renesas/Makefile          |   6 +
 arch/arm64/boot/dts/renesas/r9a08g046.dtsi    | 139 ++++++++
 .../r9a08g046l48-smarc-dsi-adv7535.dtso       |  95 ++++++
 .../r9a08g046l48-smarc-lvds-ite6263.dtso      | 104 ++++++
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  22 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |   1 +
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 182 ++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 299 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
 14 files changed, 1025 insertions(+), 9 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-dsi-adv7535.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-lvds-ite6263.dtso
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

