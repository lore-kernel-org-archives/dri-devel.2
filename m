Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4C106CD5BB1
	for <dri-devel@archiver.kernel.org>; Sun, 24 May 2026 19:45:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 722A310E170;
	Sun, 24 May 2026 19:45:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="W8ng4S1O";
	dkim-atps=neutral
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com
 [209.85.128.45])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A33B610E170
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 19:45:01 +0000 (UTC)
Received: by mail-wm1-f45.google.com with SMTP id
 5b1f17b1804b1-4896c22fcbaso75129215e9.0
 for <dri-devel@lists.freedesktop.org>; Sun, 24 May 2026 12:45:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779651900; x=1780256700; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=j/qe6eXcru11RESfUWXlWO5BzYgzjlHFDTWv1yJEsy8=;
 b=W8ng4S1OSBBdLuuTUtX9VjeY3Tmj8ZC2P28Z4dhNhgisqTFSPnFKoSOSRLWaE+p4pO
 2JVO9+Ig+2tjk1QrPfNa6jhv/wA4HvQ6b7nRgw5f4qmhFoPuxUtb2+7E1XPNhNKvbRNx
 EuYkN9dYK9JX+f/b7VMcgQVwpAv5TqDxVpR8gEAl9vRTCnMemAyfVcAw/U8lGGxCVoxj
 WuTR3fdN4CaoYlqwrSi//ARUzkPTDMWVAcSRnU0K0UKZwj3UOPiRZQBEu/ppjNlUKI6y
 i/v9KHnFNp0/5sjKdkfEVG4L2DB+0RvLfJfdoI65mbfI72vn62mAa3QBFvBWFryLMoV7
 kYvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779651900; x=1780256700;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=j/qe6eXcru11RESfUWXlWO5BzYgzjlHFDTWv1yJEsy8=;
 b=ctGcEPHfkcaQaRaFQr0u70mgtI0iLg3uINYt08nwCsrzoc6Gq98AQg4cfSWvOA3A/H
 F4oR3bqyMZ/JYuM1AB251FC8s2h5o86BkGcZKo2Mt7tgoNUHdWljJIf1S9OZZd86v9Lt
 vTyH9J0/nVdSciW4Dk7p+EPDVSYCYJubazN5+tUHdsXxbs0pRsv1lujzGw8SZAWEaSgN
 AfU7DuBx75nOWmnZmyMAp5FoxG6DBBk1WrXDt4BB9IyklEwWkjGyQIERQcnAYm5Hoats
 s+QSX3dgM7ZJi4vW34UPV5XYjEcVMf6p5S9imoZN4cbFGAvo7kJWuTqRkQajbJLhgQ42
 VQMw==
X-Forwarded-Encrypted: i=1;
 AFNElJ/N4uvLIEOoPQwXpxvopfm5efYDNiajJ0ZqUH4gH1xkJE8fK7yvBZqc4oj00lDPtd2xfLjkFUv+uVY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yx1D3/gkfBddOs/BF/2GYuTivFWlU05Pll5WSrgsRIvJcLAgcc8
 a1MQVAiqRFVw+RSaoIxlGv+yCjdlI3aycJ8GKgoTLaCMRdLPgzHX9RIa
X-Gm-Gg: Acq92OHHoZ82EJLoZRu6jFUzEreowfafbCfKKPcW2djCcx4dNB73/RhFeGvBh1gK+Ld
 EqSxmgKYDusF7XcO6Os0MlofTzOtCvClzQQyVUXEGdeVkhAX8FaBFC7GezmcMArbtUWaR+F1guR
 zD0WSv6yq3GIG3vYTZkkpMmzwJNL+C/EeHHPOsSa+2mfKlnLtRELGatfDafMtkAUrRobYnpO2Kp
 ZYsIDQsfQ0QTDH6gLhX5CMJWbY5JRAPnQ1odKe1v4vfVJoDU5xa1QAi7vbnW0pixquS4KA3Jmmk
 yItxv0j4dzwvCYDE9gK7DFp69rCeezUhkL0aOWYZDFDAtjSRWEGMSMyNL90tbYkl3xJcjmSVbC1
 lbb8oSDbZbGGBZrYTlCTrrPzC/F6qecZfLy8bxLlMD7ZOL0kYZW0IeKn9tUcp6w467zrdGN0BiP
 RSu9u+I8tDPW5kR5W/Bx3nnT+nWlUHjPXTMcrnL/cBEw==
X-Received: by 2002:a05:600c:1f87:b0:48a:8905:a500 with SMTP id
 5b1f17b1804b1-490424ad9abmr182880265e9.12.1779651899732; 
 Sun, 24 May 2026 12:44:59 -0700 (PDT)
Received: from biju.lan ([2a00:23c4:a700:7301:ae73:a12b:ca55:91be])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-49042cde62csm68224515e9.32.2026.05.24.12.44.58
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Sun, 24 May 2026 12:44:59 -0700 (PDT)
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
Subject: [PATCH v2 0/2] Add support for Renesas RZ/G3L LVDS encoder
Date: Sun, 24 May 2026 20:44:49 +0100
Message-ID: <20260524194457.479681-1-biju.das.jz@bp.renesas.com>
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

v2->v3:
 * Dropped patch#1 as it is accepted.
 * Replace drm_atomic_state with drm_atomic_commit in
   rzg3l_lvds_atomic_{en,dis}able().
 * Drop local variable ret and dev_err() messages in
   rzg3l_lvds_atomic_enable(); use WARN_ON() instead to
   capture unexpected failures since atomic_enable should not fail.
 * Drop local variable next_bridge from rzg3l_lvds_probe().
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

 .../bridge/renesas,r9a08g046-lvds.yaml        | 128 ++++++++
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 277 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  26 ++
 5 files changed, 445 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

