Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8F4F6CA5FB3
	for <dri-devel@archiver.kernel.org>; Thu,  1 Oct 2026 09:40:48 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E0CF210E337;
	Thu,  1 Oct 2026 09:40:47 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="lhN2Ge4N";
	dkim-atps=neutral
Received: from mail-wm2-f12.google.com (mail-wm2-f12.google.com
 [74.125.225.140])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BB7D410E337
 for <dri-devel@lists.freedesktop.org>; Thu,  1 Oct 2026 09:40:46 +0000 (UTC)
Received: by mail-wm2-f12.google.com with SMTP id
 5b1f17b1804b1-49fff72474fso28559885e9.3
 for <dri-devel@lists.freedesktop.org>; Thu, 01 Oct 2026 02:40:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1790847645; x=1791452445; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to:content-type;
 bh=Jc3gHtQINmiAkpV7pjKLPbOoZ/HXw5DC2EHguV8I54k=;
 b=lhN2Ge4NHRcSHq9o07m8UdE2x3bQ8JnfuDeg5ATWrsDLx8QqbRxliZujXyJIvGmulY
 4Fjhh9zVp2MQ9ddLv+03Y2qni/2IseOERJWOL/4M/Bu3euVJDv8k6VB/+HhgnSu51cc0
 71bUIbhxQRgAOzbD+LI0/NQptE4a8ePvTsAzIMxXaMB/B2hTj8DODNrQ8loNrju6KLH0
 VJmKbonNvkI/NjaBnjh2CWCsai76UDZGhdJNWob00iEWK0aslmOG7ENFFIh58Pzpkhfh
 m6+V7DfTqkRIEjP4S9EeU5F8r4CNNiDJ3F3c1cfoh63mK7Dsyll9sw3uDAJ0RoQf3YbO
 85Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790847645; x=1791452445;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Jc3gHtQINmiAkpV7pjKLPbOoZ/HXw5DC2EHguV8I54k=;
 b=ifdM9e/YsAkGkOXxB7yYQZVAdv6FoQngeWc8N6d6BXVSt1+Na711LdqPg8MYPXQSNZ
 55XT8RXAeGE7MMVlaYm25v5qb5lhgI0MBjS14y+53B7tWih8+eBSvSEpdSU+F6FLDv5c
 nobJhRo6Pxzi3caWfs2CxdIvQZmVnTx69nPv3ZIBr7UKPGS2+EAhWHjbe4d0DgyzTXR6
 FNJhZOfkT9CAiJRPg00YsE530g0vpFdmQOnNTme2KgfT3uaDc6Qi3worCsoHwwlJU5yP
 L5eKl9eEkrdzj96jjfVNJH5RbsnY++Jf7E7aRsNwiR3Dkl1+Giuop++0mmJJzZbcT11l
 qywA==
X-Forwarded-Encrypted: i=1;
 AKwUvByKUWY4CXaYflH9SpCn+o6EUiq00fbO4PX/0ZdDBQFIJwCk1vdeBA2sIvKRVOO6M/CZDMcSdIelL6w=@lists.freedesktop.org
X-Gm-Message-State: AFuF++lCKiYDhb8XDZwUgoI2q574LgyqNM9Gf9i21MiLOv1R4zkEt6zf
 JDyG81TNYC4ELPtp0+FbYaV8zKOB/zg7tODj6eU46zK2BL7BoR3Jl/vR
X-Gm-Gg: AYBFou1KLT7tcmRxvC7z27X3VLzjozVKOVpw234Y25ZfmfzkBvCk5L46nQKrfPi9YTo
 cEjWvLA41smNE0/JKx0YH0WLA0trcngU3pEYazkStUYD1C18Lj2ziwECM3zkk6CWm8+KPCA2y8f
 Ke57bDEfGa3PNBHRyytZfBamW5i2EDRCcVb/VP9T8/EK8AD3Aaq6LhQaY2K4Tf0ERIDT2G7wnSh
 vqd2k8xLQGyBGm7AFpx4LgMzZpk2Ry9WfcCp1TmEMwhZ1JVVQpghDSeUCthE1HnDJx6W1mNAA8L
 RFoJsPb99I1/0fOAPrttSSntKvt4LIotGr4+xAuZBIKAq78P/biGn4ud6j6/lKZVkKhw7sz+7eO
 yBC6SSW+NFLTUDgcbluHR33gBwfKR5hXd8WRmqMhJ5UGK79jm7D9DXb8tTcYewRWHYR2hyHUTkW
 bwHcK9Pa8JeUrZ54y/9BPM6HiLnhY6SOqmamitmTmhj3CKmoZY0/o7U13kp0v6QJTyjvmF2NzQ1
 SFe
X-Received: by 2002:a05:600c:3b10:b0:49f:fbad:29c1 with SMTP id
 5b1f17b1804b1-4a01b133c13mr67735075e9.33.1790847644699; 
 Thu, 01 Oct 2026 02:40:44 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:5563:a938:8fc:9dc5])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4a0226201aasm38937725e9.6.2026.10.01.02.40.43
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 01 Oct 2026 02:40:44 -0700 (PDT)
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
Subject: [PATCH v5 0/9] Add support for DU,
 LVDS and DSI on the Renesas RZ/G3L SoC
Date: Thu,  1 Oct 2026 10:40:15 +0100
Message-ID: <20261001094041.135697-1-biju.das.jz@bp.renesas.com>
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

v4->v5:
 * Collected tag.
 * Restored mode_clock_min to 5440 kHz.
 * Replaced static resets array in probe with global resets array.
 * Updated rzg3l_lvds_atomic_disable() to fix the
   PM_RUNTIME_ACQUIRE_IF_ENABLED guard that prevents synchronous suspend.
 * Updated rzg3l_lvds_atomic_enable() to fix refcount underflow in
   atomic_disable due to early return in atomic_enable.
 * Dropped dotclk from struct rzg3l_lvds.
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
 .../gpu/drm/renesas/rz-du/rzg2l_mipi_dsi.c    | 162 ++++++++++-
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 275 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
 11 files changed, 749 insertions(+), 8 deletions(-)
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-dsi-adv7535.dtso
 create mode 100644 arch/arm64/boot/dts/renesas/r9a08g046l48-smarc-lvds-ite6263.dtso
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

