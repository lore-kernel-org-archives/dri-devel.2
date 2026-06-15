Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7CD91CD98CF
	for <dri-devel@archiver.kernel.org>; Mon, 15 Jun 2026 13:12:30 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id DC53210E3F4;
	Mon, 15 Jun 2026 13:12:29 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="uFKfuJpP";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 47E9310E3F4
 for <dri-devel@lists.freedesktop.org>; Mon, 15 Jun 2026 13:12:28 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id EE39A241;
 Mon, 15 Jun 2026 15:11:52 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1781529114;
 bh=32Shx7TCKv3Qlm21pR+zetQqXjWhiye5TRnx0tFj7W4=;
 h=From:Subject:Date:To:Cc:From;
 b=uFKfuJpPGa1AL48Q70CA4sC1JIwS0/x8NistfrsvAccaZ67PW5YNEjVcC136jexnU
 J5XprOLSZ4XakJK+MUyKIpW6w4c9DzUQaO9TD+U21pus3E0kfNnjIYt/iPytxNWubB
 ROyxwC27L/HFy3ycQBJphWUqVXEtJQAUb6bkRVPg=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH v5 0/7] drm/rcar-du: Add support for DSI pipelines with DSC
Date: Mon, 15 Jun 2026 16:11:53 +0300
Message-Id: <20260615-rcar-du-dsc-v5-0-aed1a28610e4@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIABr6L2oC/33MyQrCMBSF4VeRrI1kbuPK9xAXGW0WNpJoUErf3
 bQbB1o3F/4L5xtAdim4DPabASRXQg6xr8G3G2A61Z8dDLY2IIgIxDGDyagE7R3abCDj2nhkiHe
 tAHVxTc6Hx6wdT7W7kG8xPWe84Om77BQMEbSC+0ZJJ1uGD8E6lWOvo0p2Z+IFTFwhnwT/Jkglv
 NCSMKRwPSsE/UPQSmDBMG9agphsVwj2JsQvwSohKZJCYc2FogvEOI4vhxmV03YBAAA=
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
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Conor Dooley <conor.dooley@microchip.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=4239;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=32Shx7TCKv3Qlm21pR+zetQqXjWhiye5TRnx0tFj7W4=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqL/ozdFtcRAnNYsXWYwB7iQ65JS05bhMdNu276
 YtVJloqFpyJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCai/6MwAKCRD6PaqMvJYe
 9WYCD/9yr9V2UlynqXbHRGP0j8LIDZK7WVtZzg1BZ1OK2eCRu0N2D7gpiVA1GbRdrPxF2PEmhy/
 XTumN/UC9bVin9ndxGDYczPMzH0y3ysG28DRQVTeRu8bLG5+7SVt4JTDDVix7EZZrv6EvD66BCy
 nOsRjan6i4DWJPqBk+Shp+ssPgzo0o3Zm5mkzvqDap6GDAOY7izkNVdVdbaJipWnJ3gdeAc/+G1
 jvwDNf2xUoYpc1m2NpN4VzKCxQCVXmJOI6VpfY3vGpYZuuFOzyoM3SV06D700TguDof4Qj6Altd
 RBWz3stKsOIyMP5URHxz2szij4NFfhWTmJCQFUZl0fcyBS9bx1hlCghDdoNPzBA/kL2TwWFbiHN
 5xWc8oU9XzXLkNAs9aPnxwEuy+jm0Oe+ftHfBObNsbAsPq+FjZrfs0WHZTSALFaFVOJwzFpBdWg
 P2yPaWOEvBTDkPsRGY8PFUdv8U+iudFD76lyukpRdoaBqzymB5gq00TNfp7Fa98I1DykwfEuRWY
 8DTroy+1Jeun+A2KcwT9BGS4qcKX8EWH8TK/pzLdJLTY3DFzFS9EWQ2n5YVa3M7Vio2KPOxk1fk
 Nm4fpVGCV8kSJAIruyC40MTxbOPNkQoO3CxFHuWJaqmY9q0Tm9Hoe0C/G7gceLWQ9o2CnVOM52+
 Ru3nNhDVMhcDBqA==
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
the DP output comes from DSI and sn65dsi86 bridge, and also White Hawk
board's second mini-DP output.

Original series from Marek.

Note: I see that not every run of kms++'s kmstest gives me a picture on
my monitor. Sometimes the monitor seems to be trying to repeatedly sync,
but fails, and the screen stays black. However, I see this same issue on
WhiteHawk, which uses DSI0 pipeline, without DSC, so I think that is a
separate issue.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
---
Changes in v5:
- Drop the "renesas,rcar-dsc" compatible, and rename the binding file to renesas,r8a779g0-dsc.yaml
- Check pm_runtime_get_sync() < 0 for error, instead of
  pm_runtime_get_sync() != 0
- Move pm_runtime_enable() before drm_bridge_add(), so that runtime PM
  is ready when we publish the bridge
- Fix "DCS" typo in commit desc
- Rewrite "drm/rcar-du: dsi: Support DSC in the pipeline" again, this
  time solving the DSI/DSC question in rcar_du_encoder_init()
- Link to v4: https://patch.msgid.link/20260615-rcar-du-dsc-v4-0-93096a1b56a3@ideasonboard.com

Changes in v4:
- Add 'renesas,rcar-dsc' compatible, in addition to the SoC specific
  compatible
- Use 'bridge' as the name of the DT node
- Arrange Kconfig and Makefile entries alphabetically
- Rebase on drm-misc-next, and fix the drm_atomic_state rename issue
- Use pm_runtime_get_sync() in .atomic_enable() instead of
  pm_runtime_resume_and_get() to fix the possible runtime PM get/put
  discrepancy
- Drop ioremap and mmio field, as the driver does not touch the
  registers
- Use of_drm_get_bridge_by_endpoint() to get the next bridge
- Rewrite "drm/rcar-du: dsi: Support DSC in the pipeline" to use
  bridge->type to detect the DSI and the DSC
- And some cosmetic fixes pointed out in the review comments
- Link to v3: https://patch.msgid.link/20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com

Changes in v3:
- Simplify DSC driver: drop reset control, drop clk handling, use runtime PM
- Split dts changes for r8a779g0 and sparrow-hawk to separate patches
- Add "arm64: dts: renesas: white-hawk: Add second mini-DP output
  support"
- Link to v2: https://patch.msgid.link/20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com

Changes in v2:
- Fixed the dts example in "dt-bindings: display: bridge: Document
  Renesas R-Car V4H DSC bindings"
- Link to v1: https://lore.kernel.org/r/20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com

---
Geert Uytterhoeven (1):
      arm64: dts: renesas: white-hawk: Add second mini-DP output support

Marek Vasut (5):
      clk: renesas: r8a779g0: Add DSC clock
      dt-bindings: display: bridge: Document Renesas R-Car V4H DSC bindings
      drm/rcar-du: dsc: Add rudimentary Renesas R-Car V4H DSC driver
      arm64: dts: renesas: r8a779g0: Add DSC
      arm64: dts: renesas: sparrow-hawk: Enable DisplayPort by adding DSC

Tomi Valkeinen (1):
      drm/rcar-du: dsi: Support DSC in the pipeline

 .../display/bridge/renesas,r8a779g0-dsc.yaml       |  96 +++++++++++++
 .../arm64/boot/dts/renesas/r8a779g0-white-hawk.dts |  94 +++++++++++++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          |  31 ++++-
 .../boot/dts/renesas/r8a779g3-sparrow-hawk.dts     |   5 +
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   1 +
 drivers/gpu/drm/renesas/rcar-du/Kconfig            |  12 ++
 drivers/gpu/drm/renesas/rcar-du/Makefile           |   1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c         | 154 +++++++++++++++++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |  18 ++-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |   1 +
 10 files changed, 410 insertions(+), 3 deletions(-)
---
base-commit: a56a73ec85c81c7e533bc249ff0fd996256053fd
change-id: 20260514-rcar-du-dsc-45bcf0c2fe86

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

