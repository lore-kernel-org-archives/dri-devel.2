Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2B93CCD4F39
	for <dri-devel@archiver.kernel.org>; Thu, 14 May 2026 12:25:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EF16410E5E7;
	Thu, 14 May 2026 12:25:25 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="R4TbKiR+";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5D96710E21D
 for <dri-devel@lists.freedesktop.org>; Thu, 14 May 2026 12:25:24 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 5733B56D;
 Thu, 14 May 2026 14:25:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778761513;
 bh=KX7cPNWNQV3tTJGSzBFahn7mQVOVPuP673fOrBp4UxE=;
 h=From:Subject:Date:To:Cc:From;
 b=R4TbKiR+isuwOI8qDg0VeWHNUvma84CNwvHgaQRTKP6UwGvW4bwhotarVdExzrJiU
 8jarJyoR4F/DHJOrz5+/jottgfew6S8iOtJP/GlwhF/PPvl+t5tE403CNuur83CY8Y
 Offd89ylD8hHotWRtL7bfOBwPdaUpqVTnlxVWRsk=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH 0/5] drm/rcar-du: Add support for DSI pipelines with DSC
Date: Thu, 14 May 2026 15:24:52 +0300
Message-Id: <20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABW/BWoC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDU0MT3aLkxCLdlFLdlOJkXRPTpOQ0g2SjtFQLMyWgjoKi1LTMCrBp0bG
 1tQDj8v0gXQAAAA==
X-Change-ID: 20260514-rcar-du-dsc-45bcf0c2fe86
To: Geert Uytterhoeven <geert+renesas@glider.be>, 
 Michael Turquette <mturquette@baylibre.com>, 
 Stephen Boyd <sboyd@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Magnus Damm <magnus.damm@gmail.com>, 
 Marek Vasut <marek.vasut+renesas@mailbox.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>
Cc: linux-renesas-soc@vger.kernel.org, linux-clk@vger.kernel.org, 
 linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 devicetree@vger.kernel.org, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
X-Mailer: b4 0.15-dev-c25d1
X-Developer-Signature: v=1; a=openpgp-sha256; l=1914;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=KX7cPNWNQV3tTJGSzBFahn7mQVOVPuP673fOrBp4UxE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBb8qu7RLSJGNdiijIDGQ9JxOiApet0G3sGId5
 zUiW6KMH8eJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagW/KgAKCRD6PaqMvJYe
 9WH9D/9CKruh2KnftyraPjOg9Z5+PkKDTx1ltVakbcxFbP3UGVyORJBeYpbecx842m9Vz6tsQ6Z
 opO8luYLP+533lPTrh/EbChdfvnxPJrnhfMOgSRhEvXUI33vsiZazNtZSQ9fBWUA3stHgrpL0VD
 jf30zKmO8p6b9Ld9oBCjed0hLfD1ixsEJx9UsMXrjjcFxK49zL10gCn+fd4/AqlkP+BP6QBlrNc
 wKdvTeBROpl67zCEARgRO739l+2RPrZUYlI4jqsa3WfNtv1IGrZ5E+TwS2xat+UKpXbWPjfkBuL
 HyhFwYj3KlkSBkVBbpjYZPg7uWmuNLDqi2R9ROFnTzF5yBdFyh/tNP32yMbp4ruJnh98Qly5PMa
 ForrrdereDmeOBDYJfiTtBUHExIGcm9bbIj2JHaUIMG8zVxZHlOWQiuxLUkD4s/ozY1x6QDzj5u
 qDGZ0mKVZwCAQs4achaSGb5DwBbcgCyqmffd9612sdaKdtTT5oSkpX7V3YO3RVwcgfs4rDA8QE+
 OeQ6HG4pGSVxU7Vv+GA6UAgL0Xl0Dc94dCsGg0f5F2PSjjZwhfevHTQ+pxbhY4kvRJdwJy/PKDs
 t1jQBhmFAtU1Bupx47XyBsvuGgYsHLz7HNHhwCkycuuJs4NROCFJYRc9SjWao5TmbnACWhLIN7B
 qCo74GwwkCGA48Q==
X-Developer-Key: i=tomi.valkeinen+renesas@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
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

Some DSI pipelines have DSC (Display Stream Compression) IP block
between the DU and the DSI. Even if DSC is not needed, the IP must be
enabled for the DSI output to work.

This series adds a basic DSC driver, so that the DSC IP gets enabled in
bypass mode. This enables DisplayPort output on Sparrow Hawk board, as
the DP output comes from DSI and sn65dsi86 bridge.

Original series from Marek.

Note: I see that not every run of kms++'s kmstest gives me a picture on
my monitor. Sometimes the monitor seems to be trying to repeatedly sync,
but fails, and the screen stays black. However, I see this same issue on
WhiteHawk, which uses DSI0 pipeline, without DSC, so I think that is a
separate issue.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
Marek Vasut (4):
      clk: renesas: r8a779g0: Add DSC clock
      dt-bindings: display: bridge: Document Renesas R-Car V4H DSC bindings
      drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H DSC driver
      arm64: dts: renesas: Add Renesas R-Car V4H DSC

Tomi Valkeinen (1):
      drm/rcar-du: dsi: Support DSC in the pipeline

 .../bindings/display/bridge/renesas,dsc.yaml       |  96 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          |  31 +++-
 .../boot/dts/renesas/r8a779g3-sparrow-hawk.dts     |   5 +
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   1 +
 drivers/gpu/drm/renesas/rcar-du/Kconfig            |  13 ++
 drivers/gpu/drm/renesas/rcar-du/Makefile           |   1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c         | 163 +++++++++++++++++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |  36 ++++-
 8 files changed, 343 insertions(+), 3 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260514-rcar-du-dsc-45bcf0c2fe86

Best regards,
-- 
Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

