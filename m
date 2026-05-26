Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B7A1DCD5BB4
	for <dri-devel@archiver.kernel.org>; Tue, 26 May 2026 07:47:53 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0714F10E524;
	Tue, 26 May 2026 07:47:53 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="SQDoczcL";
	dkim-atps=neutral
Received: from mail-wm1-f53.google.com (mail-wm1-f53.google.com
 [209.85.128.53])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1CD4010E524
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 07:47:52 +0000 (UTC)
Received: by mail-wm1-f53.google.com with SMTP id
 5b1f17b1804b1-4903d5c67bfso23746315e9.1
 for <dri-devel@lists.freedesktop.org>; Tue, 26 May 2026 00:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1779781670; x=1780386470; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=UvPr1W3ZIvvDxqV/H5K1ZKDBHyMogx0/kZuaS8a0a60=;
 b=SQDoczcLbx6JAJuoGqEM/Pwwla5TRDWfMJ6fvg3fjmXEf+jawxtgC9cljLURju4sTn
 16g/2v2al8BrD5AU9EofOdsTOQN8NXhCGQwlPGl5p8amEUXoC7jcwaEUo9miLKQs5CKt
 g0tvpimz7m303MFbrceUkEUZci7PHQ48K29OGp9amQlF+xJqU2CL3lyOcH3bVlojMz62
 1N7G3NkeyYlwxYFv+2pPf1TRumuzsvxV8ZPKRxDqLtID1+A8HjDDuY27zAlwQGeMv9rU
 9cBEPY0YHkCCITePRzj6VaANOu03OjGFe5gr1kzPox6eAoR8Kn9WRdC2wYem346wwW2d
 MEKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1779781670; x=1780386470;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=UvPr1W3ZIvvDxqV/H5K1ZKDBHyMogx0/kZuaS8a0a60=;
 b=GTVSQ+tNlDhEiy1YDVFMc7ksJ2xG1thZyM3STzDljKCiVpNpj3RX5tnobgoy0TW4x/
 TpR2R3Ty86G3Ubf+Wpp20MufJoTiDyEn9i9Ndz3jYw0ed0Bs8c2ZAgvH4B8Fa8uAZamo
 An/Zdq+i0pySxW9H3uKEFA8Of8aiBx17kqEzjmzy2u8UxKQlDlPlIq/cJEfTJ1r+fYZx
 1PlRuRAL2QKwz0vLPr9qdxjS/YO+hK2ElWGP/pUw8WOzGLSHnNEX0x/XYzRngrl7BzJG
 OdHhUfye5r6ofGlWTsrDR+2biE+yrWtybtTDP8ctK/jNTWpijaCBmFyyIKAWpXiJ4t4K
 exxg==
X-Forwarded-Encrypted: i=1;
 AFNElJ9709NOpbMMteLLRO1WG8vcJhH30DtJtCTjLn9ek5hTeC29+I3ytW0N8iBR3Pl3AxBu6ia3QsSJmO4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0Yxw1QZSpBjg2qoB5mDdedpo9VMtszPSWBcfe5yYHD1cdSkAuqp7
 d2VuNvRpX/Es2zQjSPzBQcZOfokgxa4vuFm24dBRwdonOkYg20oA55Zu
X-Gm-Gg: Acq92OFkt6a9rRntPb/Qk0+CxQoM2sasbpMFI9VCb6lWMmWaoAaDB1OPJ9/fFOo4QBd
 fLtpWsXgfs9CW/it6PdYf0o1EEiwte7VMxUa/oVlM+wf5HpxpCwwi3S/qsZdXrYx9bSDgKkqYc/
 wqHu5nvleWacyp7kif/ce3FHrSDSHsj7JMjzU6TnUrEnELcTwNDmA4hgBp+u1Wje5TltbZnEyzN
 dyyX5Vi0M+0ANhLcqTgU7HHKa0PMtgtP7iNRaTap6/nfHXWc12SjQuUCzu/M5IkY5Bs6RJq10ut
 6RQoY92OapLg6qqaVpB63KqK/KMAH57Xi1GxbZdnqE+ufUsxztT+j1Ugt5pf00Logn/oBfHv8dJ
 AoZM7Nhddgnoic4KARpedATHRf0+PJmTiBOfl8qeAve9P4iP2VqYny4XYV9DEytUjhCjTL0YR4L
 Guh8Ivms4MmJCUrXq7imh05fXxy8rOpVqBya4WqIvdnrKT3sKZ
X-Received: by 2002:a05:600c:4e4b:b0:48a:6fd4:d3d3 with SMTP id
 5b1f17b1804b1-49069da61b8mr85910915e9.20.1779781670417; 
 Tue, 26 May 2026 00:47:50 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a700:7301:c204:f511:e9bc:10b7])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-490428d63f8sm102848155e9.18.2026.05.26.00.47.48
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 26 May 2026 00:47:50 -0700 (PDT)
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
Subject: [PATCH v3 0/2] Add support for Renesas RZ/G3L LVDS encoder
Date: Tue, 26 May 2026 08:47:41 +0100
Message-ID: <20260526074746.20371-1-biju.das.jz@bp.renesas.com>
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

