Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DEA45CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 09:10:00 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4B67710F4A4;
	Fri, 15 May 2026 09:10:00 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="f+Cvtnuh";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8FA9410E00F
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 09:09:58 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id CC7E5454;
 Fri, 15 May 2026 11:09:45 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778836187;
 bh=QkQuKbs3kTlKxTsbVSwlqIa7UFeA+IsMXFr+8EVhxAE=;
 h=From:Subject:Date:To:Cc:From;
 b=f+Cvtnuh71qA0h6CzDyqevEiD6nTrFk9j051b3ugyzRB4/5hwTNB+X8E2CT7zXsvv
 O/B8SHaYYxxcjpxlaCwYAS3wBiPQ4jMQy0LpDxR598b8oZq7iMOvXB1N/7TID0hZqa
 q2qdOLzDJga4/dR2q3urk+FQ32VCqNoo6da3FYSI=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH v3 0/7] drm/rcar-du: Add support for DSI pipelines with DSC
Date: Fri, 15 May 2026 12:09:25 +0300
Message-Id: <20260515-rcar-du-dsc-v3-0-164157820498@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAMXiBmoC/23MQQ7CIBCF4as0s3YMIGDrynsYFxQGy8JiQImm6
 d2lXWnSzST/JO+bIFMKlOHUTJCohBziWOOwa8AOZrwRBlcbBBOaKS4xWZPQvdBli1L11jMrPLU
 a6uKRyIf3ql2utYeQnzF9Vrzw5bvtFI4MnVb+aDrqWsnPwZHJceyjSW5v4x0WrohfQv0TohJe9
 52QzPB6Noh5nr+YfB8/8AAAAA==
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
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=2773;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=QkQuKbs3kTlKxTsbVSwlqIa7UFeA+IsMXFr+8EVhxAE=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBuLdhC3aBbT/EdqjeJDPhr9tj5KzWAv2gt+/i
 GP3lJ5khB+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbi3QAKCRD6PaqMvJYe
 9Z9JEACtCZTvQ1lSbUNYwSqLND/x6gQdwNiGTo3wRXSCIGcEvBv9WiWHOL11tDcZnZgJNfEcsm+
 bLzsuBdXKC7FpSFn+B4klgaXSwMgM13jG1dFamx4dsxnqG8s5A5mxoVs1ckF3OV3uDMsodTb2Sf
 pNLoEw2jj9gclLwf/ocrBluP8C9EZuM+PuGG7WaQbiGYg8Fl3uR1RnBI2f8clyKwYI4f4pp61SH
 b1ELeGUrC+l5Ps3wn9jk6gS4WDP78Awh2ECCjRJbAQ6UbnAQpGrOG0LzkbgPMh34DR61dDWpb1a
 DEAv17XKd/V1v0xTEu7QTiGC1mtHJMR4DC4+OdPxUXGJb/XIhNQtMEHA80mRZuaCouOZE7gODq9
 VwjhWwFWP/YTg0h4MEiUoelAkAFklwsQ3wUoQxgmtcONtRkEDXAy5NoOAarm8+tCEFlGRzlBWM4
 PDuDdKYx2Eri3WuAwMz9z983fYIP9xwdF22Q2gNAPe6SXgBsjFigJ3yeFArvpYfRaa7nUysEyGf
 ZZaIq7k4Dl+CIuaDsKZOeDQt/m+HWQS5hPo+wp6Yd9W00FTAgzGBIythRx7mCs3mriKt4l3jXed
 PwF0NhboA1BTwtA5IGSr/BkYabyeIdgVAreLUaXwQBRBVKcgZ7o50LwfNsqKFgg0xa2HMHKHE+a
 JylOjCWyDQQMIMA==
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

 .../bindings/display/bridge/renesas,dsc.yaml       |  96 +++++++++++++
 .../arm64/boot/dts/renesas/r8a779g0-white-hawk.dts |  94 ++++++++++++
 arch/arm64/boot/dts/renesas/r8a779g0.dtsi          |  31 +++-
 .../boot/dts/renesas/r8a779g3-sparrow-hawk.dts     |   5 +
 drivers/clk/renesas/r8a779g0-cpg-mssr.c            |   1 +
 drivers/gpu/drm/renesas/rcar-du/Kconfig            |  12 ++
 drivers/gpu/drm/renesas/rcar-du/Makefile           |   1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_dsc.c         | 160 +++++++++++++++++++++
 drivers/gpu/drm/renesas/rcar-du/rcar_mipi_dsi.c    |  36 ++++-
 9 files changed, 433 insertions(+), 3 deletions(-)
---
base-commit: 028ef9c96e96197026887c0f092424679298aae8
change-id: 20260514-rcar-du-dsc-45bcf0c2fe86

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>

