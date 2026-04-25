Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 843B4FF885E
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 06:47:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C329610E4FB;
	Sun, 26 Apr 2026 06:46:57 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="Mw5qabxa";
	dkim-atps=neutral
Received: from mail-dy1-f227.google.com (mail-dy1-f227.google.com
 [74.125.82.227])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BD82410E0A0
 for <dri-devel@lists.freedesktop.org>; Sat, 25 Apr 2026 03:10:16 +0000 (UTC)
Received: by mail-dy1-f227.google.com with SMTP id
 5a478bee46e88-2ba895adfeaso9305052eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 24 Apr 2026 20:10:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1777086616; x=1777691416; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=Fvue385W0hX6gDR6DeAjBvEUcDEjMxESWf6pVitmIoY=;
 b=Mw5qabxaGcXlqdbzbG+3cA1KoGqKYb7meAuvTa1x6XedtEY4FiiKlBobyL7bCeAKJv
 /f1NG3noZ2pFpwF6/qbucMiJzVH6QnzQkJ02PhgL1bZsNNAjmLmz4RhhAnCTwmw83o94
 iIfxYr4rGGrJhnuDx/GYjnnLDczrJYL/x627YreSjV2/cWibS/2lTynVVApceg7Q5mF2
 JkZ0lfRpPOJ51kV0Llt8xv30qbcfeM3DejZnMNF7rpv3eQwcUeQF3fp8QGnqPI5czMB9
 Jz9SSImuhRZLqOe0fHcbEP7fnLJVjK8O3DaMjIv503DJFngXDn4W3sOQEz319W2+r+vQ
 8UpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1777086616; x=1777691416;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=Fvue385W0hX6gDR6DeAjBvEUcDEjMxESWf6pVitmIoY=;
 b=N0v45W8P+4xNK1j+D/hcYRuuK0PTvZ2GvbKgJgNfjNpPNGMxJZItHO1a0UigUspwGN
 4AyHXEsPxgMA+qu+xtC1FJBMfL0hGGI8JvE9CA05ksEmb/myagf6tWne8gxHzS37+Qmo
 HXW9hJwnGojFAWAI57YqOzJIXKyOEJO0lBvFSeyQQacEucD3srW2wMiCjrCocWXhYCQO
 3qWFZZLnp9DrrLxVO9f2kfLjlzEYl6PbK2TJo9uWhPjNVIivrd14VdXURQjPDhh1SSSS
 NGGVhVD8X7TRbzgEL91eAv32vZ03PRr9ECTuPQsr3SkN0/NPvKEx5gxIwwa3a9jkPGbt
 X1Uw==
X-Forwarded-Encrypted: i=1;
 AFNElJ81HiWwhq99q1IrEfv8iCdwEEs8Q3Lh3mOjV7AmLS9jq7Cd4p8M3X8Ck/Ia/QI/UqOv89EiDVKKZuY=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YykyPSrbCTyA7Y87coA+dAPPLomDRD+Rw6XhQLRTCorJbChJBa1
 6GsPtE+kmSIWQbrSwQB/xu3y9aWiHduwFW9aSp3sz/HVfjqlFEmYOX1t78So2L122yVpbSAE320
 Q6HOxXLk1X266w7s0LAkWNECzBoAj5vIaJ8WY
X-Gm-Gg: AeBDieu9whsTUGCaB41bm6DZuWXP51oPTu174CVrSvcBV7oqaH+GKeolZ6nGagF+PSa
 R3oq/i4EdISAZRY7JndgnOWPa9bkdFvfmvKECDQ/v246N2KIpFj5uT+AF9ggcl/FD+78U4f3Pll
 S3tarHd8sZqMMpqe3zHdzdAEERC1GbplrvJOQj37nZC+G7j/jQPZuuKOYsaGEef+JXUzYNT4cuS
 zVQdD1iMGEJTufMJidUNSWNqBe6PG0RXdi52tRZQVJLPtxhxZDDdhpE1VRpUYBm9LWoZTXtTMBR
 BNgK+4ftAOfqe6sBqew2ZEPyFzPy0MBCxQc1S87tsx9AxW5bkHI8GeT8wIDWup7tPit7I05zLBD
 nH3WcK65Bp2I6b1rFOmWdA6WK7/fCS+PLjVbuyeW2yGy4L+Kjo6yHe/M=
X-Received: by 2002:a05:7301:4586:b0:2e2:27bb:a4a2 with SMTP id
 5a478bee46e88-2e47873a866mr19665803eec.13.1777086615769; 
 Fri, 24 Apr 2026 20:10:15 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 5a478bee46e88-2e53a3ae691sm1728646eec.11.2026.04.24.20.10.14
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 24 Apr 2026 20:10:15 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: Heiko Stuebner <heiko@sntech.de>, Andrzej Hajda <andrzej.hajda@intel.com>,
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>
Cc: Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Maxime Ripard <mripard@kernel.org>, Alexey Charkov <alchark@gmail.com>,
 devicetree@vger.kernel.org, linux-rockchip@lists.infradead.org,
 linux-arm-kernel@lists.infradead.org, dri-devel@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, Dennis Gilmore <dennis@ausil.us>
Subject: [PATCH v8 0/6] Add support for Orange Pi 5 Pro
Date: Fri, 24 Apr 2026 22:10:05 -0500
Message-ID: <20260425031011.2529364-1-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Sun, 26 Apr 2026 06:46:56 +0000
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

This series adds initial support for the Xunlong Orange Pi 5 Pro, based on
the Rockchip RK3588S SoC. The board features eMMC, SD card, NVMe (PCIe),
a Motorcomm YT6801 NIC (PCIe), WiFi/BT (BCM43456), dual HDMI output (the
second via a Lontium LT8711UXD DP-to-HDMI bridge on dp0), and a 40-pin
expansion header.

The series was tested against Linux 7.0

This series depends on:
  https://lore.kernel.org/all/20260217-typea-vbus-v1-1-657b4e55a4c2@flipper.net/

Please take a look.

Thank you,

Dennis Gilmore

Changes in v8:
- Bridge node: renamed label from lt8711uxd to hdmi-bridge
- Bridge node: added vdd-supply = <&vcc3v3_dp>. The vcc3v3_dp regulator
  gates power to the LT8711UXD. regulator-always-on is kept because
  drm_simple_bridge only enables vdd-supply with HPD which does not
  happen without power on
- GPIO output pinctrl groups (bt_wake_gpio, dp_bridge_en, ethernet_en,
  vcc5v0_otg_en, wifi_enable_h) changed from pcfg_pull_none to
  pcfg_pull_down to match the RK3588S power-on-reset default state
- pcie2x1l1 (NVMe): switched from GPIO-mode reset to hardware sideband pins
  using pinctrl-0 = <&pcie30x1m1_1_perstn>, <&pcie30x1m1_1_clkreqn>,
  <&pcie30x1m1_1_waken>. Note: despite the "pcie30" prefix in the DTSI
  group names, the SoC pin-mux table confirms these alt-function 4 pads
  physically route to pcie2x1l1's native PERST#/CLKREQ#/WAKE# inputs.
  reset-gpios is retained alongside the pinctrl entry for U-Boot
  compatibility (pcie_dw_rockchip in U-Boot requires reset-gpios).
- pcie2x1l2 (NIC): added &pcie20x1m0_clkreqn and &pcie20x1m0_waken to
  pinctrl-0
- Renamed pinctrl group vcc3v3_phy1_en to ethernet_en to match the
  schematic signal name (Ethernet_EN)
- link to v7: https://lore.kernel.org/linux-devicetree/20260414214104.1363987-1-dennis@ausil.us/

Changes in v7:
- Fix up whitespace issues identified by checkpatch.pl --strict in
  rk3588s-orangepi-5-5b.dtsi
- checkpatch gave a warning for WARNING: phy-mode "rgmii-rxid" without
  comment, as this was moved over I left it untouched
- Added lontium,lt8711uxd to the compatible enum in the simple-bridge
  binding
- Added lontium,lt8711uxd match entry with DRM_MODE_CONNECTOR_HDMIA to
  the simple-bridge driver
- New patch to rename the regulator labels for the es8388 supplies to
  match the schematics and they all use vcca_*
- Fixed ES8388 PVDD-supply — vcca_3v3_s0 → vcca_1v8_s0, 5 Pro is
  different to 5 and 5b.
- analog-sound: use CPU-as-clock-master on the Pro. The ES8388 is wired to
  i2s2_2ch (the only I2S block physically routed to the codec pins on this
  board), which uses the legacy rockchip_i2s driver. That driver's
  slave-mode trigger path hangs for 200 µs polling I2S_CLR and bails with
  -ETIMEDOUT ("lrclk update failed"). The TDM-capable i2s0/i2s1/i2s5
  blocks served by rockchip_i2s_tdm don't have this issue, which is why
  other mainline ES8388 boards get away with bitclock-master = masterdai.
  Drop bitclock-master/frame-master and the masterdai label to let the I2S
  block generate BCLK/LRCK itself
- Removed regulator-always-on/regulator-boot-on from vcc3v3_dp
- Added pinctrl entries for all GPIO pins (dp_bridge_en, vcc3v3_phy1_en,
  wifi_enable_h, pcie2x1l1_rst, pcie2x1l2_rst)
- DP bridge rework — replaced dp-connector node with proper chain:
    - lt8711uxd bridge node (compatible lontium,lt8711uxd, with port@0/port@1
      endpoints). Bridge power is gated by the vcc3v3_dp regulator, whose
      enable GPIO (GPIO3_PC2) is driven via the dp_bridge_en pinctrl group;
      no enable-gpios/vdd-supply on the bridge node itself.
    - hdmi1-con connector node (compatible hdmi-connector, type a)
    - dp0_out endpoint now points to bridge input instead of old connector
- remove accidentally included unnecessary changes
- link to v6: https://lore.kernel.org/linux-devicetree/20260411024743.195385-1-dennis@ausil.us/

Changes in v6:
- Move the shared configs for the Orange Pi 5 and Orange Pi 5b from each
  devices dts to a shared rk3588s-orangepi-5-5b.dtsi to avoid duplication
- Remove empty ports subnodeis from typea_con
- Move i2s2m1_mclk pinctrl from &i2s2 to the es8388 codec node
- Add dp-con, dp0_out, dp0_in, and vp1 nodes, plus the vcc3v3_dp regulator
  in order to get the second HDMI port working via its transparent
  LT8711UXD DP to HDMI bridge
- link to v5: https://lore.kernel.org/linux-devicetree/20260401010707.2584962-1-dennis@ausil.us/

Changes in v5:
- define a connector node for Type-A port, and list the regulator as its VBUS supply explicitly.
- Requires https://lore.kernel.org/all/20260217-typea-vbus-v1-1-657b4e55a4c2@flipper.net/
- link to v4: https://lore.kernel.org/linux-devicetree/20260310031002.3921234-1-dennis@ausil.us/

Changes in v4:
- rename vcc3v3_pcie20 copied from rk3588s-orangepi-5.dts to vcc3v3_phy1 to match the schematic
- use vcc_3v3_s3 as the supply not vcc5v0_sys for PCIe
- remove the definition for vcc3v3_pcie_m2 as it does not really exist
  as a regulator
- link to v3: https://lore.kernel.org/linux-devicetree/20260306024634.239614-1-dennis@ausil.us/

Changes in v3:
- moved leds from gpio-leds to pwm-leds
- remove disable-wp from sdio
- rename vcc3v3_pcie_eth regulator to vcc3v3_pcie_m2 to reflect the
  purpose
- actually clean up the delete lines and comments missed in v2
- link to v2: https://lore.kernel.org/linux-devicetree/20260304025521.210377-1-dennis@ausil.us/

Changes in v2:
- moved items not shared by orangepi 5/5b/5 Pro from dtsi to 5 and 5b
  dts files
- removed all the comments and deleted properties from 5 Pro dts
- link to v1: https://lore.kernel.org/linux-devicetree/20260228205418.2944620-1-dennis@ausil.us/

Dennis Gilmore (6):
  dt-bindings: arm: rockchip: Add Orange Pi 5 Pro
  dt-bindings: display: bridge: simple: document the Lontium LT8711UXD
    DP-to-HDMI bridge
  drm/bridge: simple: Add the Lontium LT8711UXD DP-to-HDMI bridge
  arm64: dts: rockchip: rk3588s-orangepi-5: rename PLDO regulator labels
    to match schematic
  arm64: dts: rockchip: refactor items from Orange Pi 5/b to prep for
    Pro
  arm64: dts: rockchip: Add Orange Pi 5 Pro board support

 .../devicetree/bindings/arm/rockchip.yaml     |   1 +
 .../display/bridge/simple-bridge.yaml         |   1 +
 arch/arm64/boot/dts/rockchip/Makefile         |   1 +
 .../dts/rockchip/rk3588s-orangepi-5-5b.dtsi   | 256 ++++++++++
 .../dts/rockchip/rk3588s-orangepi-5-pro.dts   | 440 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588s-orangepi-5.dts  |   6 +-
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi | 263 +----------
 .../boot/dts/rockchip/rk3588s-orangepi-5b.dts |   2 +-
 drivers/gpu/drm/bridge/simple-bridge.c        |   5 +
 9 files changed, 725 insertions(+), 250 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-5b.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts

-- 
2.53.0

