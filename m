Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5E829C98305
	for <dri-devel@archiver.kernel.org>; Tue, 22 Sep 2026 06:17:52 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id B0A2F10EB75;
	Tue, 22 Sep 2026 06:17:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kemnade.info header.i=@kemnade.info header.b="6CPNdw/P";
	dkim-atps=neutral
Received: from mail.andi.de1.cc (mail.andi.de1.cc [178.238.236.174])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5E33510EB12
 for <dri-devel@lists.freedesktop.org>; Tue, 22 Sep 2026 06:17:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
 d=kemnade.info; s=20220719; h=Cc:To:Subject:From:Reply-To:Content-ID:
 Content-Description:In-Reply-To:References;
 bh=+kV7t3nkhmFlCoj8U2ZxK8+Ds1oB/yvQdLFQt8onTy0=; t=1790057855; x=1791267455; 
 b=6CPNdw/P868gK/O1Jjjh9Y8CcdDSFsgd8aE3yByUDkUbxyp8VAaOZs/FY7eQSEvSFW2RYDVW7Eq
 1T+UqF1iUUuJupxg/KkiAPzl7ptbURE1Ues7ZGn9Vy76HzroeYOpAw/42vz6XjBMpT5VdTvtN1Eo0
 r4iCNzedpKinvS6Fpbh59m3KKKIQL9W2ll00nC85uXjw3saFgZT+A6sz1I04kgEq4jMXuBwLtygLm
 MJpytCwkhFHmy1okAaloSRoKgRxUv3KuEPIdaIgjSuIfT3N3v4jUcWDDvttMVd8AukwTfF2CD0P3s
 Vxt7shRcNyV3vQL1dIhXLLgZX+/l8yM8OzKA==;
From: Andreas Kemnade <andreas@kemnade.info>
Subject: [PATCH RFC 0/9] drm: panel: Add support for Epson Moverio BT 200
 display
Date: Tue, 22 Sep 2026 08:16:57 +0200
Message-Id: <20260922-b2-panel-via-bridge-v1-0-45ff36b364cf@kemnade.info>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAFodsmoC/z2NQQ6CQAxFr0K6tslQoAhbEw/g1rCYgaJjDOAME
 BPC3R2RuPzN63sLeHFWPJTRAk5m623fhREfIqjvursJ2iZsIEWsCorREA66kyfOVqNxtgmI0Sk
 VeWo4phbC5+Ckte/NeoXL+QTV7+gn85B6/Pp2zMlrCs1xZ//JMtqCCTGOdZIdcybclMgtM2dKN
 bqQck6hWtcP9D+s18UAAAA=
X-Change-ID: 20260921-b2-panel-via-bridge-ba42974b612f
To: Neil Armstrong <neil.armstrong@linaro.org>, 
 Jessica Zhang <jesszhan0024@gmail.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Andrzej Hajda <andrzej.hajda@intel.com>, 
 Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, Marek Vasut <marex@denx.de>, 
 Aaro Koskinen <aaro.koskinen@iki.fi>, Kevin Hilman <khilman@baylibre.com>, 
 Roger Quadros <rogerq@kernel.org>, Tony Lindgren <tony@atomide.com>, 
 hns@goldelico.com
Cc: dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-omap@vger.kernel.org, 
 Andreas Kemnade <andreas@kemnade.info>
X-Mailer: b4 0.16.1-dev-53874
X-Developer-Signature: v=1; a=openpgp-sha256; l=4241; i=andreas@kemnade.info; 
 h=from:subject:message-id;
 bh=5KPRhw3PHHw+RQ/JZfD64PvTLB7y/YXDTUjBYHpew68=; 
 b=owGbwMvMwCUm/rzkS6lq2x3G02pJDFmbZBN+fLTVLs19cFjvatdcnuxJJ2dPtX1fGXriroJZ8
 N3Nho/fdZSyMIhxMciKKbL8slZw+6TyLDd4aoQ9zBxWJpAhDFycAjCR/2qMDPfyvjH6733qMNtP
 60OZRnRAw8eeZWGsub9Dejji/Z1MMhgZjhd+mVLaZis6yaM//fmBCzyFvLZxFmLxE6Zvyj5zezE
 PIwA=
X-Developer-Key: i=andreas@kemnade.info; a=openpgp;
 fpr=EEC0DB858E66C0DA70620AC07DBD6AC74DE29324
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

This series depends on
https://lore.kernel.org/lkml/20260907-tc358762-fixes-v4-0-e3fc3ab5cd83@ideasonboard.com/.
That series is still v7.2 based, but this needs -next material, to work.
It compiles on -rc.

The Epson Moverio BT200 AR glasses have two displays. Each is behind a
TC358762. As disassembly of that unit is not feasible, not much can be
found out about the display chip itself, so no good compatible name for
the panel can be found. Also I do not have access to a full datasheet
for the bridge, so my knowledge is based to values found in vendor
kernel. So more magic numbers than I wanted.
As the panel needs to be configured via SPI, add support in the bridge
for that, also the initialisation needs to be moved to pre_enable()
to be able to use SPI in the panel driver alse in prepare(). To be able
to properly narrow down any issues, add some read checks. Since two
lanes are in use, the intenal PLL needs to be configured to derive
proper clocks. Check for success there. Configuration of the PLL is
too tailored to the BT200, it needs proper divider calculation
derived from the input clock rate.
I did not find any sane looking value for the input clock producing
the known constant for SYSPLL3.

Issues / Limitations:
- SPI only works if bridge is pre-enabled, probably does not matter
  as the main use case is to control the display behind it and
  SPI transactions are properly rejected if the bridge is not ready.
- SYSPLL3 tailored to BT200.
- error messages on first read in reinitialisation without reset,
  no practical problems seem to be connected to this, will
  probably went away in most cases if shared reset is enabled.
- some lines missing in output, so the picture gets around
  10% smaller vertially, with the upper 10% repeating at
  the button. I have a standalone variant of the panel driver
  which does not have that issue. I did not find any significant
  differences in omapdss registers per debugfs yet.

Signed-off-by: Andreas Kemnade <andreas@kemnade.info>
---
Andreas Kemnade (9):
      dt-bindings: display: panel: Add panel for Epson Moverio BT-200
      drm: panel: Add panel for Epson Moverio BT200
      dt-bindings: display: bridge: tc358762: Add some missing properties
      drm/bridge: tc358762: Move initialisation to pre_enable
      drm/bridge: tc358762: add SPI master support to control panels
      drm/bridge: tc358762: read back ID register
      drm/bridge: tc358762: make LPTXTIMECNT configurable
      drm/bridge: tc358762: Basic support for 2 lanes
      ARM: dts: ti/omap: omap4-embt2ws: Add displays

 .../bindings/display/bridge/toshiba,tc358762.yaml  |  14 ++
 .../bindings/display/panel/epson,panel-bt200.yaml  |  48 ++++
 arch/arm/boot/dts/ti/omap/omap4-epson-embt2ws.dts  | 120 ++++++++++
 drivers/gpu/drm/bridge/tc358762.c                  | 234 ++++++++++++++++---
 drivers/gpu/drm/panel/Kconfig                      |  10 +
 drivers/gpu/drm/panel/Makefile                     |   1 +
 drivers/gpu/drm/panel/panel-epson-bt200.c          | 251 +++++++++++++++++++++
 7 files changed, 651 insertions(+), 27 deletions(-)
---
base-commit: ae05b821e09ca387eab7441be8c82fd521f7a42c
change-id: 20260921-b2-panel-via-bridge-ba42974b612f
prerequisite-change-id: 20260326-tc358762-fixes-6f666500da9e:v4
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
prerequisite-patch-id: 88939d8af6eef5fea65b7883909856e692c29cfa
prerequisite-patch-id: c6c3d34380425f4ee21411e860726786b56c8236
prerequisite-patch-id: ac1f5d7bc054cf7a0d84cb343f4b1d1e393a7956

Best regards,
--  
Andreas Kemnade <andreas@kemnade.info>

