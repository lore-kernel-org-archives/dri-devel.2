Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E5DA3C79F9E
	for <dri-devel@archiver.kernel.org>; Mon,  7 Sep 2026 09:30:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F000310E723;
	Mon,  7 Sep 2026 09:30:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="S1e7UYsm";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A83BB10E723
 for <dri-devel@lists.freedesktop.org>; Mon,  7 Sep 2026 09:30:19 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 62573981;
 Mon,  7 Sep 2026 11:28:42 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1788773323;
 bh=ovABkjJQOwgz2Rl7QrXo+phQjTOEQxYwHSTkCXNqCao=;
 h=From:Subject:Date:To:Cc:From;
 b=S1e7UYsmAfJwa8mJgo5Nm25SKiLv5VWT3Mx/EdnliXTnN9TxI1Ays2pWPV3Br5RtR
 y9q/dJqEm6in6aGNUPy7Clspg9JUzUCu1Dt2ojY0RPIkD9vRYTsXs+neW10cjKh8OB
 JU18grlp1tP/E61wlt8MtPJ+4VV9vgszEH4oAxrk=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH v6 0/6] drm/rcar-du: Add support for DSI pipelines with DSC
Date: Mon, 07 Sep 2026 12:29:39 +0300
Message-Id: <20260907-rcar-du-dsc-v6-0-f8ef711a7494@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAOEnmoC/33MwW4CIRDG8VcxnEvDsDBCT76H6WEWhsqhSwO6a
 WP23YtetI3rZZL/JN/vLBrXzE28bc6i8pxbLlMPfNmIcKDpg2WOvYVWGpUFI2ugKuNJxhaksWN
 IKujEDkVffFVO+fuq7d97H3I7lvpzxWe4fB87M0glI9q0Jc/eGdjlyNTKNBaq8TWUT3HhZn1P2
 L+E7kTC0WujCPpZIYYnxNAJQAN267Qy3q0Q5kbgf8J0wg/KI8FokYYVwj4hbCeII5B2CIrNA2J
 Zll+FDhxDuQEAAA==
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
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=4419;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=ovABkjJQOwgz2Rl7QrXo+phQjTOEQxYwHSTkCXNqCao=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqnoQjP3UWjvF2zTKilwELqDLccSxBoS1ZjfCRm
 ylAV0rMUfOJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCap6EIwAKCRD6PaqMvJYe
 9bJrD/4r8VrBbyxQ3Ei6g6lOH/qJJsKc1gFTrJ9qrIBAhj1EVvUPF74l/Se3qw6m0EmJ4KZB3ui
 xt2neNLmoCLi4F6FQU/Rb9i9/h3lkApSSSPFrpEV1CmpMDHQfIIQjNUeevznVUC1RFVCaP+XSdi
 /+Wj6JDbFId07EleOmKnkM5PLNywmyJO7m5DyaGH4tTleZ2vkOd/eXkSlM/go7//mwPe5RKYvAg
 R/nJO9JxleIZhUs7qgqmCq+WQ0jFlWsv7xokliLALjOTkV7Ka1/2Y7D7eZxRqd5DMqHzLjsSnKt
 wQLU3YPmIseSq8n076/PXKqRYEOOIlKfHphTDm1+NqFPEhsB6L5m+cMdYTZlwwujEQXtsRPbhOo
 HiEg8NHn5ejh5S6JLwbqBXQ3ggrBUTHXt9MjRCJ5NFiaUCa0TFrxxGOs0zA4uVHx7V1AmxKwvp2
 IbAaiiMkmYS/hjCREoGlwYz0y0hIk2re7mfmhF1su1+VAUJzDvVCQDJGG1oVJhZFUzR7fHh6Cv0
 RFBJh5pVFRAASVkZwlMPuEjsE3gOzfpS1aPxqL3jSeORxt+9YpFYYY4bHUZJPZmhjcwtWhvOlnB
 tZAnrEgqDw3w1x9toljk1xQ2lnB4KWovK8LP8WvYRw4pBpvMNUm4/mUWNZd1MXRio9iuZSEmsY9
 oO0rpj+vM5E7qXw==
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
Changes in v6:
- Rebased on latest drm-misc-next, fixing the compile issues caused by
  the rebase
- Minor things: commit desc cleanups, indentation change, dropping
  unused include.
- Link to v5: https://patch.msgid.link/20260615-rcar-du-dsc-v5-0-aed1a28610e4@ideasonboard.com

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

Marek Vasut (4):
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
 drivers/gpu/drm/renesas/rcar-du/Kconfig            |  12 ++
 drivers/gpu/drm/renesas/rcar-du/Makefile           |   1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c         | 153 +++++++++++++++++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c  |  17 ++-
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |   1 +
 9 files changed, 407 insertions(+), 3 deletions(-)
---
base-commit: a9f09b5ea0c3db1e2d4c0f8d3ebdd612d8aa0366
change-id: 20260514-rcar-du-dsc-45bcf0c2fe86

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

