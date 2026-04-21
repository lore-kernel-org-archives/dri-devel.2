Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C18FF327D4
	for <dri-devel@archiver.kernel.org>; Tue, 21 Apr 2026 17:29:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BBC1110E25E;
	Tue, 21 Apr 2026 17:29:17 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="WvTx2nBA";
	dkim-atps=neutral
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com
 [209.85.128.51])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1FA7010E25E
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 17:29:16 +0000 (UTC)
Received: by mail-wm1-f51.google.com with SMTP id
 5b1f17b1804b1-488d2079582so52686315e9.2
 for <dri-devel@lists.freedesktop.org>; Tue, 21 Apr 2026 10:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=gmail.com; s=20251104; t=1776792555; x=1777397355; darn=lists.freedesktop.org;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=18zwonTTNGSCTnLCCjEENQ9bQwbO5iLEoVwPTzytlbk=;
 b=WvTx2nBAGO0TNV1erWQmE+uMXwQoONAFKJ7vv5D7G+jcSgzXfOLVpgGzTfHyePJRUy
 eV9axuEo6KI8kZR6NkC7qStflQuen1SeonVvWZXc/0bG1QMYEWNfx4uboiL8IZUiBL30
 TipCZXSwgMKBtFSYnHZ+cyRtbYBjgdeXGcPZbGVja+/Y+T8fHOP0baxw8RMcJ1r7KKMA
 wiQU9j2s613iuOYkkVqX/ehRinWAo+GiMf6CgtgVKDAeicDZEt0Ucb6gEgc9gk7HB8NR
 WYVCJo3lGM64vih+Ii8RAN5dX7lcX0iZjRh2YH7ppX7NfdHTxPtCuHWPFvl4mhOlAqLR
 HxJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776792555; x=1777397355;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=18zwonTTNGSCTnLCCjEENQ9bQwbO5iLEoVwPTzytlbk=;
 b=WSvM8o6Y83YUiHvr0EZsFY4aIFqLk4q2++UqovSCSs0iE9QMNysNcrKulsuCHH6Sje
 uJY4mevVMMTr7skjO0gsgnIHpVJCNGCa/xQhlGbO2dAPfUh1sGGxrlINiR80bnnULVmf
 4gGXnV03HYZ3WlmmSRgwdSDlsZoRTrJW1U7sTfakBD76Nyu7ADqbINPjSWHQxUI+N49d
 Io2WDPRc4W0N5ZB5mzIoM52z7ndfQt7Fzike77Cx/QtFUaImU64mLLZYDmVl1IdB3Ibk
 U+kpUzFuDZTDZHd6XctR0dXf8ALV9D2XSAf2v1kXyupbWJBnTF0aPOQMOrJ0zEVUi8PJ
 Z5Nw==
X-Forwarded-Encrypted: i=1;
 AFNElJ+Swb4fVqQCGgTzXs+6b8KLvvK8fllMyWVYGv/AcjO+pgc3UEfrv5FOhP3QkvY1NaTGCkV2IG0fFA4=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YyadppfbbJBWdp1NxjAWnU1bS1HyrL5gFU+i/dmF2uOvYU/6Li/
 oAn1kzqwfl2RzT7Mab346bJTeugvCiasUwy0KHV9wK6CmhQXR5uIBump
X-Gm-Gg: AeBDiesTgMH+EFXPVPL/thg7F+zhJSOTee2x1PZ1A0k1mN3S1uTkkXrjmiD9Yu7rU9P
 3UvwPCdMdrhwcdH1SfACYJ9820+zZsUgDYwjjklBdoZ3hOR+aUkd2JlIseRqHF2gISi6SqZqFC4
 /XCb840xPNT2hdGMpVX+UB7SP1EExNsZ5n/EQ9gJtQ0QtWuWDVNpYTcZo4d0E6Ju9opX0US3K0D
 yC7Rbiku6qQIm8gjtqFM+ZVEtdZf+p1/YaE0L495KKBD3qUFEI/NhVBtjDduBxNbC6ppYXvfqYw
 kMpwD4azKtysFBc/sEBHFSnt9ztJH9UIroSjS6umDs+2yFtxoc8vec5tDZeqoktzkK225dVg15A
 WxIULK8ONurHJXvdyfILZY/q1UEgVfYqjPV3gIe2amLBtRrQu/lqfkuoOjTqbOBHr5gzO5Oe1hz
 pYc9WkXrAh4Zmr6D89NCB3X8nayCMRtz6YdcgWCpZAyinaxK1G1nDL321ce+E=
X-Received: by 2002:a05:600c:8908:b0:48a:58e1:6d02 with SMTP id
 5b1f17b1804b1-48a58e16eb2mr15879275e9.19.1776792554371; 
 Tue, 21 Apr 2026 10:29:14 -0700 (PDT)
Received: from localhost.localdomain
 ([2a00:23c4:a758:8a01:de57:c37d:677b:c772])
 by smtp.gmail.com with ESMTPSA id
 5b1f17b1804b1-48a525a0b1asm57445855e9.2.2026.04.21.10.29.13
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 21 Apr 2026 10:29:14 -0700 (PDT)
From: Biju <biju.das.au@gmail.com>
X-Google-Original-From: Biju <biju.das.jz@bp.renesas.com>
To: Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>, Lee Jones <lee@kernel.org>,
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>,
 Geert Uytterhoeven <geert+renesas@glider.be>,
 Magnus Damm <magnus.damm@gmail.com>
Cc: Biju Das <biju.das.jz@bp.renesas.com>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Tommaso Merciai <tommaso.merciai.xr@bp.renesas.com>,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
 Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>,
 Biju Das <biju.das.au@gmail.com>
Subject: [PATCH v2 0/3] Add support for Renesas RZ/G3L LVDS encoder
Date: Tue, 21 Apr 2026 18:29:02 +0100
Message-ID: <20260421172910.218497-1-biju.das.jz@bp.renesas.com>
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

Biju Das (3):
  dt-bindings: mfd: syscon: Document the LVDS_CMN syscon for the RZ/G3L
  dt-bindings: display: bridge: Document Renesas RZ/G3L LVDS encoder
  drm: renesas: rz-du: Add support for RZ/G3L LVDS encoder

 .../bridge/renesas,r9a08g046-lvds.yaml        | 128 ++++++++
 .../devicetree/bindings/mfd/syscon.yaml       |   1 +
 drivers/gpu/drm/renesas/rz-du/Kconfig         |  13 +
 drivers/gpu/drm/renesas/rz-du/Makefile        |   1 +
 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c    | 285 ++++++++++++++++++
 .../gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h   |  26 ++
 6 files changed, 454 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/display/bridge/renesas,r9a08g046-lvds.yaml
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds.c
 create mode 100644 drivers/gpu/drm/renesas/rz-du/rzg3l_lvds_regs.h

-- 
2.43.0

