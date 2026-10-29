Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B95B60A2607
	for <dri-devel@archiver.kernel.org>; Thu, 29 Oct 2026 10:19:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=ideasonboard.com header.i=@ideasonboard.com header.a=rsa-sha256 header.s=mail header.b=Mkhrtj8T
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C60881121A9;
	Thu, 29 Oct 2026 10:19:16 +0000 (UTC)
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com
 [213.167.242.64])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 14D4D112195
 for <dri-devel@lists.freedesktop.org>; Thu, 29 Oct 2026 10:19:10 +0000 (UTC)
Received: from [127.0.1.1] (91-158-153-178.elisa-laajakaista.fi
 [91.158.153.178])
 by perceval.ideasonboard.com (Postfix) with ESMTPSA id DCA26BE;
 Thu, 29 Oct 2026 11:16:53 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
 s=mail; t=1793269015;
 bh=xjPt9iFKHwraDMSxYIm/+3oJVPthmqu84OfAsjawJ9Y=;
 h=From:Subject:Date:To:Cc:From;
 b=Mkhrtj8T+86O0hQAP0D2ke8eZ4W9cUbF3bRdVUp8YMCJY2jRGtm/CLzzk2cPS/W/z
 +LEOVjf1LSBrRM9hioAJjbWqL5ZBIxItG3CGXEEqmm55S6muYaHKxXZa2jwDHRbJlI
 Gg2GojOxUo4Fd7zuA1kTSQcm2XD09HHH7NGq0e8s=
From: Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Subject: [PATCH v4 00/14] drm/tidss: Add BeagleY-AI display support (and
 some more)
Date: Thu, 29 Oct 2026 12:18:46 +0200
Message-Id: <20261029-beagley-ai-display-v4-0-dc7f2b532478@ideasonboard.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAIgd42oC/43R22rDMAwG4FcJuZ5GfEzSq73HGMW25NawHBZnY
 aH03ee4jI0tjN5ZBn0S+i9lpClQLA/FpZxoCTEMfSrkQ1G6s+lPBAFTXfKK60ryCiyZ0yutYAJ
 giOOrWQFrr4V0SMrLMjWOE/nwkdHnl1s90dt7sufbZ9lRjCbbhyLLbVWDwz4CxgC5GRYOFbQaW
 8uYpta6p4Bk4tDbwUz46IZum/VbYhVTMDuhmlrzL0klqXZYc2a0VMzeKXEBY3c082zc+WjXYz8
 gwcKAgURrnEPf2IruXUtDkkK/wjgNlrbVblarhaitUQ16s2tZEwnSuwvzoRCCkGsuFNq23I57D
 nEepjUHuLB83f+ySiMr8Jo3Sgr0yOTfkZu68G9JMbEr5Xy2YMgj6b18siR+SLzdlcSWj0+MU8g
 M+h3per1+Ak84XDSsAgAA
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
 Andrew Davis <afd@ti.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=7836;
 i=tomi.valkeinen@ideasonboard.com; h=from:subject:message-id;
 bh=xjPt9iFKHwraDMSxYIm/+3oJVPthmqu84OfAsjawJ9Y=;
 b=owEBbQKS/ZANAwAIAfo9qoy8lh71AcsmYgBq4x2SeQagfTLRcK6WO69TzPR+T15rzHO2Laxus
 Sz4ZhyR+uiJAjMEAAEIAB0WIQTEOAw+ll79gQef86f6PaqMvJYe9QUCauMdkgAKCRD6PaqMvJYe
 9SfKEACAZJoYNx48biwHtw0WwkE4GoePlCZP6do4HwGJMQG8Z4ErKo9ijXUPVCCnc/C7xMsNbko
 nL6ykxjWm/rd8c84kKv9dZyjq4x9/Nf1rxOrLX4GG6HbuEUXtncdlCF253xrt3rbxYfQ0EbJYI+
 iyZgsbVc7JRzAi0JeXAHd4fjscWZVnfSJXaisOpmUTqYU4TDcOnYK+BW1B5Wba/vME7zEJ4VPDb
 rOL2ZIwrgvVDMo6hqy5fkXqVPfGf6W+dt7FGq7qq2R4i7r98CtS8E/LxUG4WAjZ1UHodn7u5Hoc
 XCgDVxU8Vv1GCa5r2qKvb1gd2k0RW6lLgnanZIpoaH7oDBobyCocVnisCo5ytsCJn+k9fnPbYgB
 dHQ9GOGAUbrdLopLu2g6fgGE26TGQsJfDrjf0gUiCUMhY2C5owDY1HEvpnoGuocAP5ZBQZT2pCr
 GLWYmTFalJCJ2xH2gxCg7FC6OMYOlIJ3KJ/G/gLw4TA0TbgG5GQJwhYRDTAFWTtGRsZrnkYnQ+D
 tYfPGQQkYjT+RY4iE+bSSfX1orsOt2Vs1WIn8XxPKprMcppJwlfKi1HFWqLDB7pF2UgNWX9mNHE
 tY5MYJDb0BCjabGsmi49bLGzDkmJg+cxJBKsVHpom2NZetrbBHSDzfqB+EePYxNH94hGNQq+oQv
 PvHERHH2cK4lFeQ==
X-Developer-Key: i=tomi.valkeinen@ideasonboard.com; a=openpgp;
 fpr=C4380C3E965EFD81079FF3A7FA3DAA8CBC961EF5
X-BeenThere: dri-devel@lists.freedesktop.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Direct Rendering Infrastructure - Development
 <dri-devel.lists.freedesktop.org>
List-Archive: <https://lists.freedesktop.org/archives/dri-devel>
List-Post: <mailto:dri-devel@lists.freedesktop.org>
List-Help: <mailto:dri-devel-request@lists.freedesktop.org?subject=help>
List-Subscribe: <https://lists.freedesktop.org/mailman/listinfo/dri-devel>,
 <mailto:dri-devel-request@lists.freedesktop.org?subject=subscribe>
Sender: "dri-devel" <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

This series aims to add display support for all display interfaces on
BeagleY-AI board. More generally, it adds display support for TI AM62P,
J722S, and related SoCs.

The main topics to highlight:

- The data and sync signal polarities require accessing a register
  (DPI0_CLK_CTRL) in the CTRL_MMR block. This has already been discussed
  e.g. in
  https://lore.kernel.org/all/20250730-fix-edge-handling-v1-0-1bdfb3fe7922%40bootlin.com/.
  This topic is still open, and it also touches already upstreamed SoCs
  with DSS (AM625). In other words, with this series, we don't have full
  polarity support, and DPI works exactly like upstream AM625's does.

- In the SoC, the two OLDI TX instances are shared between the two DSS
  instances. This has been a bit tricky to solve neatly. In this series
  the result is that in the DT we have three OLDI TX nodes, two under
  DSS0, one under DSS1, representing the OLDIs that the DSS instance
  can use.

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
Changes in v4:
- Based on today's drm-misc-next
- Dropped the CTRL MMR related code. This means the DPI polarities are
  not quite right (the same as AM625)
- Dropped the commit to convert OLDI to an aux driver. This version uses
  a new (unmerged) PM dev_pm_domain_attach_by_node() to manage the OLDI
  power domains.
- Dropped a bunch of commits which were merged via "[PATCH 00/10]
  drm/tidss: Preparation for AM62P and BeagleY-AI display support"
  series.
- Dropped tested-by tags, as the series has changed quite a bit.
- Includes new fixes and cleanup patches:
  - vp_bus_type removal: 
    - "Add helper to identify the AM65x OLDI video port"
    - "Stop using vp_bus_type for directly connected panels"
    - "Drop the tied off video port check from mode validation"
    - "Remove the unused vp_bus_type feat"
  - OLDI:
    - "Drop unnecessary forward declaration"
    - "Fix wrong return value from tidss_oldi_mode_valid()"
    - "Fix serial clock reference leak"
    - "Fix cleanup on a failed init"
    - "Move the setup of one OLDI TX to its own function"
    - "Add power domain support"
- Link to v3: https://patch.msgid.link/20260529-beagley-ai-display-v3-0-7fefdc5d1adf@ideasonboard.com

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

Tomi Valkeinen (11):
      dt-bindings: display: ti,am65x-dss: Add AM62P DSS
      drm/tidss: Add helper to identify the AM65x OLDI video port
      drm/tidss: Stop using vp_bus_type for directly connected panels
      drm/tidss: Drop the tied off video port check from mode validation
      drm/tidss: Remove the unused vp_bus_type feat
      drm/tidss: oldi: Drop unnecessary forward declaration
      drm/tidss: oldi: Fix wrong return value from tidss_oldi_mode_valid()
      drm/tidss: oldi: Fix serial clock reference leak
      drm/tidss: oldi: Fix cleanup on a failed init
      drm/tidss: oldi: Move the setup of one OLDI TX to its own function
      drm/tidss: oldi: Add power domain support

 .../bindings/display/ti/ti,am65x-dss.yaml          |  27 ++
 .../boot/dts/ti/k3-am62p-j722s-common-main.dtsi    | 110 +++++++
 arch/arm64/boot/dts/ti/k3-am62p.dtsi               |  16 +
 arch/arm64/boot/dts/ti/k3-am67a-beagley-ai.dts     | 180 +++++++++++
 arch/arm64/boot/dts/ti/k3-j722s.dtsi               |  16 +
 drivers/gpu/drm/tidss/tidss_dispc.c                |  23 +-
 drivers/gpu/drm/tidss/tidss_dispc.h                |  16 +-
 drivers/gpu/drm/tidss/tidss_drv.c                  |   1 +
 drivers/gpu/drm/tidss/tidss_kms.c                  |  13 +-
 drivers/gpu/drm/tidss/tidss_oldi.c                 | 356 +++++++++++++--------
 drivers/gpu/drm/tidss/tidss_oldi.h                 |   2 -
 11 files changed, 593 insertions(+), 167 deletions(-)
---
base-commit: 33ed26235db93162935d1719bc6f538c384a2fd8
change-id: 20260420-beagley-ai-display-d7f634cde5f4
prerequisite-message-id: 20260907-cdns-dsi-fixes-v2-0-96d9b116e9bc@ideasonboard.com
prerequisite-patch-id: 22251f03ea9147feb3270bb8ecf5d08169ddf7a6
prerequisite-patch-id: 667af0055a8a26880d810f1a246202dde3b4b9fb
prerequisite-patch-id: 76b566286279f3544096c32a34d757ac47ff77d6
prerequisite-message-id: 20261015-tc358762-fixes-v5-0-7cd721a6451b@ideasonboard.com
prerequisite-patch-id: df4c4c2ab36f4504f08fd89804c91ecf1bbc5b85
prerequisite-patch-id: d270eb332c88f888f628b2cf751517500024b12c
prerequisite-patch-id: 6050aad2a160d9e85b176e8118f4ac4247de1355
prerequisite-patch-id: a7b3986c944f62156da6b368e6251b29451feaf2
prerequisite-patch-id: eb52b7ed89c1d44539bc7eef61f242dd444d3171
prerequisite-patch-id: e1a953467d847bea6bc9847134c0199e4702423b
prerequisite-patch-id: 538b6e710dcc07bd70eed2795d9e463e91bf0b48
prerequisite-patch-id: 6636bdd386becb3622944e57653e4fd1502527cc
prerequisite-patch-id: 84cf0fc416da9a016ebbd586020cb67b18aa84b7
prerequisite-patch-id: 64ff4472fe4467e9da0a11f69fe30d50db12204d
prerequisite-patch-id: db872cf55d9a2d204c4f1d08f49cd404da285670
prerequisite-patch-id: c6c3d34380425f4ee21411e860726786b56c8236
prerequisite-patch-id: ac1f5d7bc054cf7a0d84cb343f4b1d1e393a7956
prerequisite-message-id: 20261023-pm_attach_by_node-v1-1-4dbaccdf8b0e@ideasonboard.com
prerequisite-patch-id: 154b9cfd53b351e7d7617322e436dcf3db3413b3
prerequisite-message-id: 20261016-attiny-probe-fix-v1-1-96337ba58dfa@ideasonboard.com
prerequisite-patch-id: 45efa9d7ccd75f4a0b5c6868fe8ab369cd83303e

Best regards,
--  
Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>

