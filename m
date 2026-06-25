Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 61B29CDE001
	for <dri-devel@archiver.kernel.org>; Thu, 25 Jun 2026 17:24:08 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8AE2E10E259;
	Thu, 25 Jun 2026 17:24:07 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="GA6FUJD/";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6F52C10E259
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 17:24:05 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-490cf322ed0so891185e9.1
 for <dri-devel@lists.freedesktop.org>; Thu, 25 Jun 2026 10:24:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1782408244; x=1783013044; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=BsMZVPfVRATp7NVDC8FWrCYbdkwciYq6TDikcpY8QOc=;
 b=GA6FUJD/stFvnsIdb8Z0G7Biwx4iwPAMv2WzSNY/elQYZ+RrJEAZkJhpCOC0FJARB+
 7kMC1DE2SK246y+4SYHX80q/cAR/pHWfFTrtCf7fdc8UGVFU/oCZR0umZI24LQjHmK65
 378kUbRBelUyUSBTNq3Oy/GcDmLhoob6cI+0Vwz6jkxRu85S6d4mr5AXPZx93rH4C5sR
 6YxnPV1RR9Fs1g11TNyHISyZ2mP6ktpnrmMk/iF2JdCWqScE+qNJ5y29MDqOFWZTBVIO
 SHWqT6+0DYYLN2jIQ3u5r1S/NGJ5XhbU4+k9fyXNTRJjkExlWmlGpn0t6mGhMDn/SEsA
 ZoWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1782408244; x=1783013044;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=BsMZVPfVRATp7NVDC8FWrCYbdkwciYq6TDikcpY8QOc=;
 b=fDuA+Xx36nZGSiFZFqwJqpBHM0E7COD2ozG/WS0u518ktU7DC7cwyJRFE8lGAhzxdK
 DUbB0wOnfjs2pfGEWyTL1dHFD8frSVQe0D5edb7rnnw16Zsb7mgZhMBDCjcH9NBgH8k+
 H9JCR+CKZLTgrcQdINh5TYS2fnzEhEdKY1pA9k9GRd7yK/OdQ0Of3MXrizFFygTAYSW3
 viGeri5/L0vlqpoBS2OqYo/7LplbQs2yKuDBoogs4FP7qcDcge2ItpsHamoQNfbBycd2
 3ve/GwcQakhXXVJ7YIIk+Pl6PlvUx/fH+LeX2WtVlMRbQV4Y/f+WcGNwXH35RDj3Tyy3
 dfaA==
X-Forwarded-Encrypted: i=1;
 AFNElJ+K9wWCsaq4jzgtyfTE75xLsJrIeCU6ON9KNs/oKhVPX6gZM5Qd8/1hCUp7wUCRlMI+kORXsBVf0ZA=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yw0EE89zJX4t0+ZfySxeSAXQiLYxgzkpCVzi842Dkzdu5OLw7yn
 QWUcX6v5SQ3NHALvwGLWnBE62mIwboBJ4eQaP/l6E2YZ3XDjAiQwP8xb
X-Gm-Gg: AfdE7cl5rd/d6QH2O5Tr75rdAdNvfw5in0V2AKP6j21+RoduZcqGa5Jl0euw9ZAJ1kc
 YQkkxoaM6lm6pvacn0RYR5m9oBHb9ChddCLDDbPax9Xs4IbLS+fP51Ug+8pACAl15kh9vJM8ZfW
 rT6bE44WEVssgnh+FkBaECRQYGb81cJXHEuYdpMviHO4enAp2nJsYEBM0xUVLCsTaf92Hpn6mtJ
 LrQScVTdYQy+RZVUgCf0AR88jJxz6ycYBCX1bbUgX4slGX7u6UlqOrgYBHu4/h+zh+JKzNaZEcV
 Y29YduN81kqkmWA5YNq9EhDriuxdttFnret4uHanF3gCgzAzqmlIYrWQvZ8s8CuaOikZHPApCYo
 WI+EnMyZ+W7qrrePxxPNDq8xCx2BX4KE8SOu/s10Z3eM7su97xju1fIjcnNF6VW1jP2Z0c371BT
 a1hmuman1eykKtxQe/pibmrT6nC9ZvO8nmJfQJ
X-Received: by 2002:a05:600c:c3ce:20b0:492:62eb:ebe8 with SMTP id
 5b1f17b1804b1-4926686638emr41836615e9.16.1782408243598; 
 Thu, 25 Jun 2026 10:24:03 -0700 (PDT)
Received: from localhost.localdomain ([2a00:23c4:a702:d301:6aa7:b2d:3460:b689])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49268fd9e77sm11167265e9.4.2026.06.25.10.24.02
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Thu, 25 Jun 2026 10:24:03 -0700 (PDT)
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
Subject: [PATCH v5 0/2] Add support for Renesas RZ/G3L LVDS encoder
Date: Thu, 25 Jun 2026 18:23:47 +0100
Message-ID: <20260625172359.292631-1-biju.das.jz@bp.renesas.com>
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

v4->v5:
 * Collected the tags.
 * Added Kconfig functional dependency for DRM_RZG2L_DU
 * Dropped DRM_PANEL from DRM_RZG3L_LVDS config
 * Dropped unused headers of_device.h,of_graph.h and drm_panel.h
 * Dropped the unused macro LVDS_CMN_RST_PHY0_SEL_CH0
 * Used plain number for macro LVDS_0_PHY_CH_IO_EN0_MSK
 * Retained the tag as the above changes are trivial.
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
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 282 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  25 ++
 5 files changed, 441 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

