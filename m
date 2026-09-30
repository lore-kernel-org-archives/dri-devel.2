Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C9BDDCA5FAC
	for <dri-devel@archiver.kernel.org>; Wed, 30 Sep 2026 13:33:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 2F8DF10F3D5;
	Wed, 30 Sep 2026 13:33:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="abCToKFy";
	dkim-atps=neutral
Received: from mail-wr2-f33.google.com (mail-wr2-f33.google.com
 [74.125.225.97])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B87E010F3D5
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 13:33:02 +0000 (UTC)
Received: by mail-wr2-f33.google.com with SMTP id
 ffacd0b85a97d-482f6351831so3170284f8f.1
 for <dri-devel@lists.freedesktop.org>; Wed, 30 Sep 2026 06:33:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790775181; x=1791379981; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=z7TzL9qAFKtaS7vfznZL2zUVepTC6ZMh9+7GhOWKsog=;
 b=abCToKFy04hUg8ON5sPJzwX4ll90X2h5h3yoFE78VN71PQJp2wfEdYF5jj8TV4YWQb
 FIP1jteeCbuTMgjwcppOO9R3z8Ld+m0+XUIBShPKhgLI/K2fOZW5dIgJqJpW29cWagY5
 Eco2Q711TI1OLQ2AFMNNf2LfXjbxyUpLi7vaO/VdoFHEM+xySMVI4VpXtb8lryEp0Fk0
 OB7LBv3zFJLL3g0bPwMTcUUJdiKMUAFSgXrrXQaZvxndEaZwPxOKOBIjvg6TrGyJXt08
 FZ0BASbtC/6nEIrcTpWwPucLccdbgd7/LNThFgKM3489IguhSiSfUvdo8f3AfdU2mkEH
 B/Jg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790775181; x=1791379981;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=z7TzL9qAFKtaS7vfznZL2zUVepTC6ZMh9+7GhOWKsog=;
 b=Uxixj9mQsFk88tNZtYpGF2vAhadhz6aBBbcKdEqIFdzSGLf3yfY48TYKaLSy9JkFE6
 aJxoibAGkZKfOzsXYqAZbsijfZIQ1IxEmRtIm4ZiHbZYns4UhyPgZocdXy4B8RrOD0t+
 lHxSlNsLcR9LicOPOPS9cgXspVxr0xUGanYRo8k1Dmrp0DIi5CiDzDMBfkcqV9gr76ia
 FZGdhgZ6Qs3iGlm6H683df5nweVOiQM7FaN1Y2eAh2iuskczz2ti5fKH0eS8ZrWkbBIN
 SmLtqtRas5CR5txItj83HqABK/9c0DyAajJ+J6UC2RPvYCpjUtgAw3ZNKgkq2qjFcRMX
 SGKA==
X-Forwarded-Encrypted: i=1;
 AKwUvBzuwUn/WlmmwacugaGgmchbg7Ao9r3byvkGr0XjwLTcr0DLLvuS//aj16ZIrElqLJVsWh5R+KYH9Fs=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKB53eacol5ZorVLDLKlH3uHDlzbxvc82XvMcAfThjxi2F3mDY+
 8Uw/Pmn87ox8IREklyI8L8ULSulstVRTK7KAXifpB89UZ8UZH6CFi1Fl
X-Gm-Gg: AYBFou1aINiCJ+VTYQbYEWS6nK5yE8Cgej+uqTQAx5kh+4/pYtlYiJO8ES7NR4VBisV
 9OJzSi2knb4UJuglS2lI4WKBDK9DiF/jBVT9VfGZlCkmDhZR9j/Rs+/9kyvMZdgdeVqS17ZMMjp
 LefhTPgItRzDAxjiGViNl1KAtuX+/EEbPo7sv7nXif17Dd758AfyIuzn5GhMVnoIR0i8GfEMayA
 fXxZzhi5bDTW2mLm2r4ZyoPiWCJGtGt7twsW/p0e8CDDlA2wKYd5+h0ktUl+iViytq/yXT4zz4m
 tZzC0NdofM7VtPmaJjtxdO9bOIPZPwp6lkEOeH59rVdOR6O2A+1RnwK3SxPoUkoktH4b+XV3Asb
 WG61QNHfZlEihZXDaFDGhoYP26Lx8R52OD7MoCD+mfC69hxuc1M/jjaJI72SUPUbfRpto77iqvA
 8mpUWGs3ZQD93dVvjeldV5gd7QMNnQR/x6T9NBZpQ3IpFoWoXV2mPO5GXkswknprXrnZwMD0zL/
 3R2+PMStM6VDYprZd99W3I=
X-Received: by 2002:a05:6000:989:b0:48b:174:eab1 with SMTP id
 ffacd0b85a97d-48b02511718mr2875334f8f.36.1790775180889; 
 Wed, 30 Sep 2026 06:33:00 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:bade:1500:bcd:b3ec])
 by smtp.gmail.com with ESMTPSA id
 ffacd0b85a97d-48b029f2b02sm3685582f8f.24.2026.09.30.06.32.59
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 30 Sep 2026 06:33:00 -0700 (PDT)
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
Subject: [PATCH v4 0/9] Add support for DU,
 LVDS and DSI on the Renesas RZ/G3L SoC
Date: Wed, 30 Sep 2026 14:32:42 +0100
Message-ID: <20260930133257.23210-1-biju.das.jz@bp.renesas.com>
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

The LVDS series [1] is merged here to get an overall picture.

[1] https://lore.kernel.org/all/20260625172359.292631-1-biju.das.jz@bp.renesas.com/

v3->v4:
 * Collected tag.
 * Dropped pwrrdy variable from struct rzg2l_mipi_dsi_hw_info and instead
   using feature flag RZ_MIPI_DSI_FEATURE_PWRRDY
 * Dropped rzg2l_mipi_dsi_pwrrdy_off() as it is taken care by
   devm_pwrseq_get().
 * Updated mode_clock_min from 5440->5400 kHz.
 * Added resets in pair for simplification.
 * Added comment in probe() for asserting resets.
 * Updated commit description for patch#8 and #9.
 * Updated license header  for patch#8 and #9.
 * Added HDMI audio support.
 * Dropped reg_1v8 and reg_3v3 nodes as they are redundant.
 * Renamed it6263 node name from it6263 to hdmi.
v2->v3:
 * Dropped binding patches as it is accepted.
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

Biju Das (9):
  drm: renesas: rzg2l_mipi_dsi: Add dphyctrl0_init_val to hw_info
  drm: renesas: rzg2l_mipi_dsi: Add activation_dly to hw_info
  drm: renesas: rzg2l_mipi_dsi: Move global timings into hardware info
    struct
  drm: renesas: rzg2l_mipi_dsi: Add support for DSI PWRRDY
  drm: renesas: rzg2l_mipi_dsi: Add RZ/G3L MIPI DSI support
  drm: renesas: rz-du: Add RZ/G3L (R9A08G046) DU support
  drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder
  arm64: dts: renesas: Add DSI overlay for RZ/G3L SMARC EVK with ADV7535
  arm64: dts: renesas: Add LVDS overlay for RZ/G3L SMARC EVK with
    ITE6263

 arch/arm64/boot/dts/renesas/Makefile          |   6 +
 .../r9a08g046l48-smarc-dsi-adv7535.dtso       | 138 +++++++++
 .../r9a08g046l48-smarc-lvds-ite6263.dtso      |  86 ++++++
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.c  |  24 +-
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_drv.h  |   3 +-
 .../gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  |  24 ++
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 162 +++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 282 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
 11 files changed, 756 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-dsi-adv7535.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-lvds-ite6263.dtso
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

