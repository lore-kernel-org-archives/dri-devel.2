Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 01324CD343F
	for <dri-devel@archiver.kernel.org>; Fri, 15 May 2026 07:56:44 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5B16910F43B;
	Fri, 15 May 2026 07:56:44 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="Z/nYeh4y";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1F69610F43B
 for <dri-devel@lists.freedesktop.org>; Fri, 15 May 2026 07:56:43 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 9BDD2454;
 Fri, 15 May 2026 09:56:30 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1778831792;
 bh=UV+kpOrZw60vdYwN8vaGUIsioZG6VeF10gIlh+vj06Y=;
 h=From:Subject:Date:To:Cc:From;
 b=Z/nYeh4yyjwTeBhLjmT2TfH/bVUsPqYnD3wi4k7YY97tcEJo9HEJm0P0u05nL4D4Z
 30FvCZVfB+Ti5p8KUTReaYpuGVjWK8wD/js8mPXvlmj8GeJ50tMzcxs8/PRFp79q9q
 ECwEoZ61QbRoRDkmDJZzjHl8MTvJikiTMMugdn18=
From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Subject: [PATCH v2 0/5] drm/rcar-du: Add support for DSI pipelines with DSC
Date: Fri, 15 May 2026 10:56:13 +0300
Message-Id: <20260515-rcar-du-dsc-v2-0-f6b9240a1240@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAJ3RBmoC/23MQQ6CMBCF4auQWTumbQDBlfcwLEo7lVnYmqk2G
 sLdraxd/i953wqZhCnDuVlBqHDmFGuYQwNusfFGyL42GGV61ekWxVlB/0KfHbbd7IJyJtDQQ30
 8hAK/d+061V44P5N8drzo3/rfKRoV+r4LJzvSOLT6wp5sTnFOVvzRpTtM27Z9Acnqr7CtAAAA
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2138;
 i=tomi.valkeinen+renesas@ideasonboard.com; h=from:subject:message-id;
 bh=UV+kpOrZw60vdYwN8vaGUIsioZG6VeF10gIlh+vj06Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqBtGy/c1DwjNnyZr6n/UoXZsDlv7XDuGJjAzTl
 DJ+SP9wLP+JAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCagbRsgAKCRD6PaqMvJYe
 9UfuD/9qgJmcAb531oyY9IAYrrpHpO3tEdmRNYMqAfm4BPi3je6kDgP8JOTTqRs4p8oukg99OlM
 cdFMdYRtB2Ke9djIoJOKOSCNaRZy3fnufLFXrWr2ms3mNmu8Js13eVjCW4OoDDtXs86bFTgRP45
 qjsxyuZdkViOrPog6Sf7yCt6gN6dRv4UQQ2PV6l3Xz/rA21B1/EoPXnF2NIeocnwu8Jsa3VwFT2
 3RAQN/qNStYDHHd0dHArp8GTmwQQLo5kcU6DKdlOUphDO2gjaJk2+ItljkCAnE8Ym6wd2IPTQM/
 dD/G5jvhyUGe+H2VW/wtdOHD2x5EqmquMy0r6TR95Uegxq7GcylG+6P5DG+pf7hT1tR63u3qdDR
 KjiuWKJ/tFFMpXR9mLI6Z/Dp6X2rqGiMwnu9pUo0zIuUIPaBUvfDFeupbPDYM19Nhe9CJk/wmfQ
 LO9ONh+88tYKohPBIKig5qi2tBj2gTEQzs8RgrEbl/6kNxwp5kEXS9Mu9tpcmU1amgT0nhgvMfK
 O/wO9wOvrJL2oqlnq8TVef5TRHFGERUHpmAXrRqLKdNG516jFlVRGieRASuiIhndpV8KaTzR45N
 qgS454w6X+jNdqYa1NT4LQ9latWE73JF+6cSxI7Fvby79heRGMg4WW4g3PUPsUEKVfeZ9QwGEsJ
 eX1NNgvvEo/iMWQ==
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
Changes in v2:
- Fixed the dts example in "dt-bindings: display: bridge: Document
  Renesas R-Car V4H DSC bindings"
- Link to v1: https://lore.kernel.org/r/20260514-rcar-du-dsc-v1-0-d65f7a9e9841@ideasonboard.com

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

