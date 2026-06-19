Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 041EBCD98F2
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 10:10:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 47B7D10F501;
	Fri, 19 Jun 2026 10:10:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="KylHeCJK";
	dkim-atps=neutral
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com
 [209.85.128.48])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5452B10F501
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 10:10:30 +0000 (UTC)
Received: by mail-wm1-f48.google.com with SMTP id
 5b1f17b1804b1-491609cdd8fso11222385e9.2
 for <dri-devel@lists.freedesktop.org>; Fri, 19 Jun 2026 03:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1781863829; x=1782468629; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=C7PzdOlm6ppimpgT1Ue/GK7k7tsgiFLY2bjtHZ0QZ2U=;
 b=KylHeCJKXhDRSPzF8jkx8EJUe39HKtAHHbBzMS7azhwrtHLgXQyOyBrqwuEGL/+tSG
 yiMczq64XbqH5Jz789LLOlGgT60IygZJk03/DOver0Hpo6+0Z/tth8dEzEBWQ1o8FLmX
 toCT7zmemhE9VEA9GN4uKL0XMlf8XL97GJCs9aCc72v0jiHjQK1DZh2Lic1zACX5p23J
 fRaEpgqfaIqvLYMkUznBJWsFz94AMG0jWuMWveC8Zm1CUgfqVQgxnSRA1TZTLq0cyLYo
 4CWYs1YTAwy0a4Va7RJ5nQxd8BNeGd97XnWkHVcPkpswuwU6ZrCNSIzkGOHEB14ov1nT
 XgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1781863829; x=1782468629;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=C7PzdOlm6ppimpgT1Ue/GK7k7tsgiFLY2bjtHZ0QZ2U=;
 b=YQUbIHjl5fJotL5Z5A2+0Rg6GR5lVXOk//CsdbmHWyANxPYwBZqfEfSXk3lAe4IcwW
 was0SARYaECqw7Iy1eSjAWYKCjGL3x8CDVgf/IeazN5X4g/TSPoXu3ildyd5lvUmf27j
 lVwygq8FEGxSVnet7xYyVmy87zbBl3kUzAYYkspG9c2i2p2P/aDYHS8WkT8CfzhpPiq3
 Ub4gjKQP0y91E5ZQ/AWfW/LsFMxNOUyEV8o7sNdUJGG2SJJManhjrriQ6qPMTlIx0JpX
 tunfoj0sHegqj+jaKT/7pcNT/1vvH5xwvxwxv2SxiFcK3P9OcKOM5zTgY1wCDBedKJ53
 qmJA==
X-Forwarded-Encrypted: i=1;
 AFNElJ8ycFCzJsHf+jkG7i9keH44f7PdziHjW3vXnSNgygRv53ejFkouR2h54G+NzfjxJu0veBYSsNzgzTc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxT0y502qt1ZMSZ1h4ynlSv0uS1+0Ln743IFuQwN0fBNknQKZ3p
 UJkkDHJTg8WY8IqZrTRg2Ajk1ZcrYH7kxXrMvA0f8J/K4Ozg1ic/v1/p
X-Gm-Gg: AfdE7cnFbZl/1Fa6MG7X+w+Omcnmdrk5s4D/r3HAiMPWKVaZr4aG1wsOGpicLQWPEjZ
 K9puH4g9TUP/brqlxV/kT4O3plsp8slh9I4CRsplZji2/L0qD6zLE9mD/IKl+4sLiDrjV2H9nCT
 hjRKA3ZbGv4MFWZSvktlkM7LwHwaNcOKqQAAD+OJy5eAqBxPg9G3USJNN+f7D/PiZ66Cuyt5Up7
 W8sFkqX8766BX9ieCGF3nf4dqR7Qi6bx7SxeA+geSbHLUyY81ILlyB8OIgM3cGKGBGLVamrtPnQ
 A2aRFXwO0VBInPir95fxQxyqgfgLL/e6hEmxDDMnK8oun+6UdfJWb5muR798xoWiEvqXQSxD+Jl
 zXGeFuztRXBKrriL/m5tArjdPeoVSJsxA4yjUPAHo5QnyxikN943uG/jP91QjEn1efuWnXlxaxP
 bkS6AZNXints4HxBUzYQ==
X-Received: by 2002:a05:600d:6451:20b0:490:a646:9d77 with SMTP id
 5b1f17b1804b1-49240dfe0a5mr34801065e9.6.1781863828461; 
 Fri, 19 Jun 2026 03:10:28 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a702:d301:435:f63f:6fb:bfa4])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-4923fcdd08esm34577555e9.0.2026.06.19.03.10.27
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 19 Jun 2026 03:10:28 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Add support for Renesas RZ/G3L LVDS encoder
Date: Fri, 19 Jun 2026 11:10:15 +0100
Message-ID: <20260619101026.323633-1-biju.das.jz@bp.renesas.com>
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

Add support for the RZ/G3L LVDS encoder driver. It operates in single-link
mode with 4 lanes (Data) + 1 lane (Clock) and supports pixel clock rates
from 25 to 87 MHz. The LVDS module cannot be used at the same time as
MIPI-DSI. However, LVDS and the DSI interface share a peripheral clock and
the MIPI_DSI_PRESET_N reset signal. Also, the MIPI_DSI_CMN_RSTB and
MIPI_DSI_ARESET_N reset signals must be asserted before using the LVDS
module.

This patch series depend upon [1]

[1]
 https://lore.kernel.org/all/20260608-drm-no-more-bridge-reset-v2-0-0a91018bf886@kernel.org/

v3->v4:
 * Reworked bindings, dropping parent node containing simple-mfd and
   syson.
 * Dropped the tags
 * Dropped the header files clk.h and syscon.h
 * Dropped next_bridge check in attach().
 * Dropped syscon for getting regmap.
 * Replaced the below macros to match the hardware manual:
	LVDS_0_CTL_FMT_SEL_MSK->LVDS_0_CTL_FMT_SEL0_MSK
	LVDS_0_PHY_CH_IO_EN_MSK->LVDS_0_PHY_CH_IO_EN0_MSK
	Replaced LVDS_0_PHY_CH_IO_EN->LVDS_0_PHY_CH_IO_EN0
 * Replaced atomic_reset()->atomic_create_state().
v2->v3:
 * Collected tags.
v2->v2[1]:
 * Dropped patch#1 as it is accepted.
 * Replace drm_atomic_state with drm_atomic_commit in
   rzg3l_lvds_atomic_{en,dis}able().
 * Drop local variable ret and dev_err() messages in
   rzg3l_lvds_atomic_enable(); use WARN_ON() instead to
   capture unexpected failures since atomic_enable should not fail.
 * Drop local variable next_bridge from rzg3l_lvds_probe().
[1] https://lore.kernel.org/all/20260524194457.479681-1-biju.das.jz@bp.renesas.com/
v1->v2:
 * Collected the tags for binding patches.
 * Dropped unused function rzg3l_lvds_is_connected() and removed the 
   corresponding header file rzg3l_lvds.h
 * Dropped next_bridge from struct rzg3l_lvds instead using bridge's
   next_bridge.
 * Replaced pm_runtime_resume_and_get()->pm_runtime_get_sync() as
   atomic_enable doesn't fail and for each enable there always will be an
   atomic_disable() call.
 * Started using DEFINE_RUNTIME_DEV_PM_OPS for PM callback.
 * Replaced rzg3l_lvds_parse_dt() with devm_drm_of_get_bridge() in probe()
 * Started using reset_control_bulk_*() in rzg3l_lvds_pm_runtime_{suspend,
   resume}().

Biju Das (2):
  dt-bindings: display: bridge: Document Renesas RZ/G3L LVDS encoder
  drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder

 .../bridge/renesas,r9a08g046-lvds.yaml        | 120 ++++++++
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 285 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  26 ++
 5 files changed, 445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

