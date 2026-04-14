Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 55E5FFA0C37
	for <dri-devel@archiver.kernel.org>; Wed, 15 Apr 2026 07:14:54 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 0849510E685;
	Wed, 15 Apr 2026 07:14:51 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=ausil.us header.i=@ausil.us header.b="U2kwRNqB";
	dkim-atps=neutral
Received: from mail-vs1-f98.google.com (mail-vs1-f98.google.com
 [209.85.217.98])
 by gabe.freedesktop.org (Postfix) with ESMTPS id B8F6C10E05C
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 21:41:09 +0000 (UTC)
Received: by mail-vs1-f98.google.com with SMTP id
 ada2fe7eead31-60fee2fa3b8so825290137.2
 for <dri-devel@lists.freedesktop.org>; Tue, 14 Apr 2026 14:41:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ausil.us; s=google; t=1776202868; x=1776807668; darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:from:to:cc:subject:date:message-id:reply-to;
 bh=9sQVj34tJCzHG+OSzAE6qEOKAh1LdGOwM6EDuxjty+c=;
 b=U2kwRNqB0RfqrEj98RlfZJkI0UxoMs+PhePKxrQMHFQYkHcH8/X0Wxxt2OoA3JsfHe
 kTZKQ6o/G3WixgfemhdVTvHBmZ9f2XS5CRINYWvvNzcNBd4uCyph6p9LofsdMEY2M174
 nRTicLS3P3NpPCCEQjQ9nqxtKX40GWroCAmVX4vBvazLRUi5OOqzx4Uqfv1V+7M0BqT8
 fh15Xz4xsgwmWGL8M0NyJ7Gc2O2fkzPGGoE2gUtsuQbnD0UQkHhBoCHptTYyMJpd/qos
 Z9cAfRG9bi6i3g5Rcxa2dakppPIc40JJVw9WsAxyV3oyYvh7Y6ysKKgdb2t4hWm0ff/w
 aCcg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20251104; t=1776202868; x=1776807668;
 h=content-transfer-encoding:mime-version:message-id:date:subject:cc
 :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
 :message-id:reply-to;
 bh=9sQVj34tJCzHG+OSzAE6qEOKAh1LdGOwM6EDuxjty+c=;
 b=lBqEyXh0brOG91AGEX9Lbvhm1oRq/GF1b997etJzgzVLBdE6TZa1Qo63che8kjHF14
 dXJ73BBGaeJd06jGKUql1iiDRkPyNKm4ZESo2+6SHJBQx5CK2dICYCwVXjLku3yg/YYw
 PkPdoh1t/z4owIHGuFwooGoR+fgqtrKH5unO4V4bss9+8qplZdqHQZ9em9gAmkX//0wN
 eDd17qEHcHlfG4MMV6VPxtwaGT8lZfCzVDHYPYZPj1ApxIDcR2N7EKv82rkpXKfukDk1
 M/hMHZf6Z4HBafR81GzB9otMzeYxIgQvRMQkq7akkCABees4SS8FaEkGJYhPbTd5Tu9F
 B1Pg==
X-Forwarded-Encrypted: i=1;
 AFNElJ+eyGEO7/emXXJH2/BKZ+ooQfLSeTpaK+l4HLrK4XA4lgPUY25tTo2tz/apeLjuLmgDrwzeDFrcZBc=@lists.freedesktop.org
X-Gm-Message-State: AOJu0YxBLDGjGXneyV3bEnS23kLu4aozZh9BZ7xipKEF+db8TGG9gF0R
 XXmAClT+aFtFaDIuhd4MPSZaN2lv2a4tDXjo1XCAUBgAB/dXU7rt5/0inqPEMc6PxC3MMzkek6F
 xuCssE2bX1gssFly+JGOqsJoMgR30m1yepzdr
X-Gm-Gg: AeBDieu1h57R4OdUvC6MsGMhDynC4anbIR7y5qfVZk9YMLxG30on62out7TAFDMZeOh
 GP9d5Nz1gLRAZXvU5OffT0ymg+aYdgn/4PEBvfrVByD5n4dKf5Y6C3svIjeqdWATN0nNp5ZYL1m
 haI2edZZJQNLpRTK3yIIYjO6av1z/pFAOwBnS3dNA0mf5dE45623u71AOwelEq5MJUhdYJe8ZWU
 TWYBHsAlNrGNH39cgoGXdeYwBAuCtADw8XxpO06Fk73bQV54K03GRjaIk+1pcT8Wa9VyEjZzOls
 TWFFdtpVkuFly9UU2mM6yf2SrTTF6MqJZI/OiTlMJQNWFvuLzjE6Dj01NeYP8UHL9YMuDigQJjU
 dmJNIIkkjOmCXnd+MfrU3WDfMJf70ATIYUsKgTF01YvecsgPnTmKT9Nk=
X-Received: by 2002:a05:6102:10ce:b0:60a:9cac:d286 with SMTP id
 ada2fe7eead31-60a9cacdb01mr5997352137.12.1776202868454; 
 Tue, 14 Apr 2026 14:41:08 -0700 (PDT)
Received: from ryac.ausil.us (207-179-239-100.mtco.net. [207.179.239.100])
 by smtp-relay.gmail.com with ESMTPS id
 a1e0cc1a2514c-95691131afesm346899241.1.2026.04.14.14.41.07
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Tue, 14 Apr 2026 14:41:08 -0700 (PDT)
X-Relaying-Domain: ausil.us
From: Dennis Gilmore <dennis@ausil.us>
To: 
Cc: Alexey Charkov <alchark@gmail.com>, Andrew Lunn <andrew@lunn.ch>,
 Andrzej Hajda <andrzej.hajda@intel.com>,
 Chaoyi Chen <chaoyi.chen@rock-chips.com>,
 Conor Dooley <conor+dt@kernel.org>, David Airlie <airlied@gmail.com>,
 Dennis Gilmore <dennis@ausil.us>, devicetree@vger.kernel.org,
 dri-devel@lists.freedesktop.org, FUKAUMI Naoki <naoki@radxa.com>,
 Heiko Stuebner <heiko@sntech.de>, Hsun Lai <i@chainsx.cn>,
 Jernej Skrabec <jernej.skrabec@gmail.com>,
 Jimmy Hon <honyuenkwun@gmail.com>, John Clark <inindev@gmail.com>,
 Jonas Karlman <jonas@kwiboo.se>, Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-rockchip@lists.infradead.org,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Michael Opdenacker <michael.opdenacker@rootcommit.com>,
 Michael Riesch <michael.riesch@collabora.com>,
 Mykola Kvach <xakep.amatop@gmail.com>,
 Neil Armstrong <neil.armstrong@linaro.org>,
 Peter Robinson <pbrobinson@gmail.com>,
 Quentin Schulz <quentin.schulz@cherry.de>, Robert Foss <rfoss@kernel.org>,
 Rob Herring <robh@kernel.org>, Simona Vetter <simona@ffwll.ch>,
 Thomas Zimmermann <tzimmermann@suse.de>
Subject: [PATCH v7 0/6] Add support for Orange Pi 5 Pro
Date: Tue, 14 Apr 2026 16:40:51 -0500
Message-ID: <20260414214104.1363987-1-dennis@ausil.us>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Wed, 15 Apr 2026 07:14:48 +0000
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

This series adds initial support for Orange Pi 5 Pro. The PCIe attached
network driver(dwmac-motorcomm) was just added.

The series was tested against Linux 7.0-rc7

Please take a look.

Thank you,

Dennis Gilmore

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
  match the schematics as they all use vcca_*
- RK806 PLDO1 and PLDO2 outputs are swapped between the 5/5B and pro.
  move their definition to the shared 5/5B dtsi and 5 Pro dts
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
- Added pinctrl entries for all GPIO pins (dp_bridge_en, vcc3v3_phy1_en,
  wifi_enable_h, pcie2x1l1_rst, pcie2x1l2_rst)
- DP bridge rework — replaced dp-connector node with proper chain:
    - lt8711uxd bridge node (compatible lontium,lt8711uxd, with port@0/port@1
      endpoints). Bridge power is gated by the vcc3v3_dp regulator, whose
      enable GPIO (GPIO3_PC2) is driven via the dp_bridge_en pinctrl group;
      no enable-gpios/vdd-supply on the bridge node itself.
    - hdmi1-con connector node (compatible hdmi-connector, type a)
    - dp0_out endpoint now points to bridge input instead of old connector
- drop accidentally included, unrelated changes to
  drivers/gpu/drm/bridge/synopsys/dw-dp.c and
  Documentation/devicetree/bindings/display/rockchip/rockchip,dw-dp.yaml
- link to v6 https://lore.kernel.org/linux-devicetree/20260411024743.195385-1-dennis@ausil.us/

Changes in v6:
- Move the shared configs for the Orange Pi 5 and Orange Pi 5b from each
  devices dts to a shared rk3588s-orangepi-5-5b.dtsi to avoid duplication
- Remove empty ports subnodeis from typea_con
- Move i2s2m1_mclk pinctrl from &i2s2 to the es8388 codec node
- Add dp-con, dp0_out, dp0_in, and vp1 nodes, plus the vcc3v3_dp regulator
  in order to get the second HDMI port working via its transparent
  LT8711UXD DP to HDMI bridge
- link to v5 https://lore.kernel.org/linux-devicetree/20260401010707.2584962-1-dennis@ausil.us/

Changes in v5:
- define a connector node for Type-A port, and list the regulator as its VBUS supply explicitly.
- Requires https://lore.kernel.org/all/20260217-typea-vbus-v1-1-657b4e55a4c2@flipper.net/
- link to v4 https://lore.kernel.org/linux-devicetree/20260310031002.3921234-1-dennis@ausil.us/

Changes in v4:
- rename vcc3v3_pcie20 copied from rk3588s-orangepi-5.dts to vcc3v3_phy1 to match the schematic
- use vcc_3v3_s3 as the supply not vcc5v0_sys for PCIe
- remove the definition for vcc3v3_pcie_m2 as it does not really exist
  as a regulator

- link to v3 https://lore.kernel.org/linux-devicetree/20260306024634.239614-1-dennis@ausil.us/

Changes in v3:
- moved leds from gpio-leds to pwm-leds
- remove disable-wp from sdio
- rename vcc3v3_pcie_eth regulator to vcc3v3_pcie_m2 to reflect the
  purppose
- actually clean up the delete lines and comments missed in v2
- link to v2 https://lore.kernel.org/linux-devicetree/20260304025521.210377-1-dennis@ausil.us/

Changes in v2:
- moved items not shared by orangepi 5/5b/5 Pro from dtsi to 5 and 5b
  dts files
- removed all the comments and deleted properties from 5 Pro dts
- Link to v1 https://lore.kernel.org/linux-devicetree/20260228205418.2944620-1-dennis@ausil.us/


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
 .../dts/rockchip/rk3588s-orangepi-5-5b.dtsi   | 222 +++++++++
 .../dts/rockchip/rk3588s-orangepi-5-pro.dts   | 442 ++++++++++++++++++
 .../boot/dts/rockchip/rk3588s-orangepi-5.dts  |   6 +-
 .../boot/dts/rockchip/rk3588s-orangepi-5.dtsi | 235 +---------
 .../boot/dts/rockchip/rk3588s-orangepi-5b.dts |   2 +-
 drivers/gpu/drm/bridge/simple-bridge.c        |   5 +
 9 files changed, 695 insertions(+), 220 deletions(-)
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-5b.dtsi
 create mode 100644 arch/arm64/boot/dts/rockchip/rk3588s-orangepi-5-pro.dts

-- 
2.53.0

