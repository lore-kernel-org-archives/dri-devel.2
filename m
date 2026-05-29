Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 06750CD6E45
	for <dri-devel@archiver.kernel.org>; Fri, 29 May 2026 08:47:18 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5E59B10FB08;
	Fri, 29 May 2026 08:47:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.b="qeeXDZMa";
	dkim-atps=neutral
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 45E5910FB07
 for <dri-devel@lists.freedesktop.org>; Fri, 29 May 2026 08:47:16 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id 50390741;
 Fri, 29 May 2026 10:46:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1780044414;
 bh=ns9apGH4POa8yl/UYKramrpqDnT3jxOchO1UHnMK7Is=;
 h=From:Subject:Date:To:Cc:From;
 b=qeeXDZMaVDMD6ASaqBl8wz1iMyKUqCN1dxDCXmGLc8b+rkqQJIQCwLO8IROmiSsF+
 g8pqPg/FJAYNe85r8dCEGPIgGW+M3v2yT/8qxmwLWjJlrTr8fTZ+RZAvdUh5Y3Knbk
 fJ9lz9Xu3b7ALYZrUpDWKZoA4P4JjHymMq/70p4E=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v3 00/15] drm/tidss: Add BeagleY-AI display support (and
 some more)
Date: Fri, 29 May 2026 11:45:30 +0300
Message-Id: <20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIACxSGWoC/33PzY7CIBAH8FdpOO+YQqFqT/seGw98DDqJBYVKt
 jF996X14MXs8T8Dv5l5soyJMLOhebKEhTLFUEP31TB70eGMQK5mJlrRt1K0YFCfrziDJnCUb1c
 9g9v7vpPWofKS1Y+3hJ5+N/Tn9MoJ749qT6/imx6aDVbiABPBqCmAjcFXUmnUCpUVZih8VY3OW
 JvjSNPQlP2OQ7KKrf6F8hTTvN1Q364D/lu3cGjB9+KgZOe84/KbHOocg4k6uV0dsalFvCXFu4+
 SqNIRj8aid9gb+0FaluUPWlVPlGUBAAA=
X-Change-ID: 20260420-beagley-ai-display-d7f634cde5f4
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Lee Jones <lee@kernel.org>, 
 Aradhya Bhatia <aradhya.bhatia@linux.dev>, Nishanth Menon <nm@ti.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Swamil Jain <s-jain1@ti.com>, 
 Devarsh Thakkar <devarsht@ti.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>
Cc: devicetree@vger.kernel.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Jayesh Choudhary <j-choudhary@ti.com>, Aradhya Bhatia <a-bhatia1@ti.com>, 
 Andrew Davis <afd@ti.com>, Robert Nelson <robertcnelson@gmail.com>
X-Mailer: b4 0.15.2
X-Developer-Signature: v=1; a=openpgp-sha256; l=6028;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=ns9apGH4POa8yl/UYKramrpqDnT3jxOchO1UHnMK7Is=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBqGVKIlPy/glwTSO58WbcEpx1uvmffXSOmzmdlY
 7j5kYpPcLCJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCahlSiAAKCRD6PaqMvJYe
 9dE9D/kBYIS5NefMls2VIVt4nAzxtakVo9gp0P9DQoLTAMbFuqvB4bDKFSOdW4wgm+jixf7Uj5+
 dOslXajpKRvgazfT/GAI57D0F75I9a3F9LFsu9M8PNODk+sy9EbS5xOHymFXQLkhcR835qHSnDr
 vExBo8UjJB05Ofwnw+zDi2WWahzYQFRnVlJCTxRFXmMh4q7XTTseNj5MH6OTB4x0uNN4g7Thoig
 yxPsv2ceXH0fpqOVuq3wAZL15ejiJBif64e5ALEL6jzOky1KCvEsrGEYhXia5RnihEYY/fAXHMY
 8q6wIo0RdYMp/hGF4Vw/1VpuWd6syAvzust74e4nKTxu5ggEO7bvQXPo2OAC+J1C4xJkOCn3Hzo
 Asr/zZgVWOf2Mj+Y5LENOX25oMejRveWJO6jUIlGYpjZnrMCTxYioSHACdAMU+jjCLWQeQoGQq1
 86jUEFNhdPACMikOVoPijbnRs3dpUp7JqokzHDveBU+I6LrXMixTHNXSCzE5OHiCNukq7Ey8Mgu
 56loyZ1xhlGj4j3rRuijTJ/2hc5a4yZgXrk0f8E/HooF/XO33vRO8bI48XBGCpdmB2wLVmqADYQ
 WTpSBCsDWpfSO7wI2livadoNwQFPwli6HOYxldHIOpDkmi3lzIGrENNxHHLhBTW+hwy0OZmNB8O
 Er9p08NRc3oDONQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
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

This series aims to add display support for all display interfaces on
BeagleY-AI board. More generally, it adds display support for TI AM62P,
J722S, and related SoCs, and, as a bit extra, improves AM62L's DPI
handling.

The main topics to highlight:

- The data and sync signal polarities require accessing a register
  (DPI0_CLK_CTRL) in the CTRL_MMR block. This has already been discussed
  e.g. in
  https://lore.kernel.org/all/20250730-fix-edge-handling-v1-0-1bdfb3fe7922%40bootlin.com/.
  This series is based on "[PATCH 0/6] arm64: ti: Use syscon for the
  Control Module" which makes the CTRL_MMR block available for DSS via
  syscon.

- The tidss OLDI support will now use auxiliary device/driver. This seems
  to solve quite neatly the requirement to have a power-domain for each
  OLDI. The main issue that remains is that on AM62P (and similar) we
  will have three OLDI TX DT nodes, even if there are only two in the
  hardware.

- I'm no audio expert, but based on the original dts from Robert Nelson,
  I did get HDMI audio working, but I see "davinci-mcasp
  2b10000.audio-controller: Sample-rate is off by 400 PPM".

With this series one can use the HDMI output on BeagleY-AI. I have also
tested the DSI output with Raspberry Pi's 7" DSI display, and OLDI
output with an oscilloscope (I don't have a suitable OLDI panel) with
extra DT overlays.

 Tomi

Signed-off-by: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
---
Changes in v3:
- Base on "[PATCH 0/6] arm64: ti: Use syscon for the Control Module"
- Drop quotation marks from Rb tags
- Drop Tested-by tags for the bindings patches
- "drm/tidss: Add external data and sync signal edge configuration": Fix
  error handling
- "drm/tidss: Add support for DPIENABLE bit": set/unset DPIENABLE in
  prepare/unprepare
- "drm/tidss: oldi: Convert OLDI to an aux driver": Improve cleanups
  (of_node_put, clk_put, device_link_del)
- Dropped "arm64: dts: ti: k3-am62p-j722s-common-main: Make main_conf a syscon"
- "arm64: dts: ti: k3-am62p-j722s-common-main: Add support for DSS": Add
  missing clocks and ti,oldi-io-ctrl for oldi1 node. Drop unused
  main-gpio0-ioexp-intr-default-pins node. Fix MCASP1_AXR0 pin
  direction. Fix DSS videoport numbering.
- Link to v2: https://lore.kernel.org/r/20260513-beagley-ai-display-v2-0-9e9bcefde6bc@ideasonboard.com

Changes in v2:
- Add Rb and Tb tags
- Drop "dt-bindings: mfd: syscon: Add ti,am625-dss-dpi0-clk-ctrl
  compatible", which is now implemented with the below changes.
- New patch "dt-bindings: display: ti,am65x-dss: Add ti,dpi-io-ctrl"
- Modify "drm/tidss: Add external data and sync signal edge
  configuration" to use the 'ti,dpi-io-ctrl' with offset.
- New patch "arm64: dts: ti: k3-am62p-j722s-common-main: Make main_conf
  a syscon".
- Modify "arm64: dts: ti: k3-am62p-j722s-common-main: Add support for
  DSS" to set 'ti,dpi-io-ctrl' properties
- Drop generic desc in DT bindings for power-domains property
- Fix pm_runtime_get_sync() return value check
- Link to v1: https://lore.kernel.org/r/20260420-beagley-ai-display-v1-0-f628543dfd14@ideasonboard.com

---
Andrew Davis (1):
      arm64: dts: ti: beagley-ai: Enable HDMI display and audio

Jayesh Choudhary (1):
      arm64: dts: ti: k3-am62p-j722s-common-main: Add support for DSS

Swamil Jain (1):
      drm/tidss: Add support for AM62P display subsystem

Tomi Valkeinen (12):
      dt-bindings: display: ti: Move ti,am62l-dss binding to a new binding file
      dt-bindings: display: ti,am65x-dss: Simplify binding
      dt-bindings: display: ti,am625-oldi: Add optional power-domain for OLDI
      dt-bindings: display: ti,am65x-dss: Add ti,dpi-io-ctrl
      dt-bindings: display: ti,am65x-dss: Add AM62P DSS
      drm/tidss: Remove extra pm_runtime_mark_last_busy
      drm/tidss: oldi: Remove define for unused register OLDI_LB_CTRL
      drm/tidss: Add mechanism to detect DPI output
      drm/tidss: Add external data and sync signal edge configuration
      drm/tidss: Add support for DPIENABLE bit
      drm/tidss: oldi: Fix OLDI signal polarities
      drm/tidss: oldi: Convert OLDI to an aux driver

 .../bindings/display/ti/ti,am625-oldi.yaml         |   3 +
 .../bindings/display/ti/ti,am62l-dss.yaml          | 136 ++++++
 .../bindings/display/ti/ti,am65x-dss.yaml          | 187 +++----
 MAINTAINERS                                        |   1 +
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi    | 112 +++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi               |  16 +
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts     | 191 ++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi               |  16 +
 drivers/gpu/drm/tidss/tidss_crtc.c                 |  10 +-
 drivers/gpu/drm/tidss/tidss_crtc.h                 |   4 +-
 drivers/gpu/drm/tidss/tidss_dispc.c                |  53 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |   5 +-
 drivers/gpu/drm/tidss/tidss_dispc_regs.h           |   5 +
 drivers/gpu/drm/tidss/tidss_drv.c                  |  54 ++-
 drivers/gpu/drm/tidss/tidss_drv.h                  |   5 +-
 drivers/gpu/drm/tidss/tidss_kms.c                  |  55 ++-
 drivers/gpu/drm/tidss/tidss_oldi.c                 | 540 +++++++++++++++------
 drivers/gpu/drm/tidss/tidss_oldi.h                 |   8 +-
 18 files changed, 1109 insertions(+), 292 deletions(-)
---
base-commit: 9e171fc1d7d7ab847a750c03571c87ac3c17bd84
change-id: 20260420-beagley-ai-display-d7f634cde5f4
prerequisite-change-id: 20260528-ti-main-conf-d75aea5e5c2b:v1
prerequisite-patch-id: b45e40d091eeb547189d2bed60cb809be22543cf
prerequisite-patch-id: 1098a5aca6124123635bc0b19853eca9968291bc
prerequisite-patch-id: edea999683b5849977f5a1d40430fa674c3143ff
prerequisite-patch-id: 1a71566898f248dfdd99bed6b2de9ab8b229bf7d
prerequisite-patch-id: 9112dad36cf951c79d63ea3d87324745ed790ca3
prerequisite-patch-id: 7b93f92509cb1a9536cd8a2833526178a9d13f74

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

