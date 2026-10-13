Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2BC27CC6B0F
	for <dri-devel@archiver.kernel.org>; Tue, 13 Oct 2026 12:50:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 4AC3A10E815;
	Tue, 13 Oct 2026 12:50:07 +0000 (UTC)
Received: from mail-m83144.xmail.ntesmail.com (mail-m83144.xmail.ntesmail.com
 [156.224.83.144])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 0131E10E7FE
 for <dri-devel@lists.freedesktop.org>; Tue, 13 Oct 2026 12:49:59 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [61.154.14.86])
 by smtp.qiye.163.com (Hmail) with ESMTP id 50e2b9409;
 Tue, 13 Oct 2026 20:49:52 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: Sandy Huang <hjc@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>,
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>,
 Simona Vetter <simona@ffwll.ch>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>, Rob Herring <robh@kernel.org>,
 Krzysztof Kozlowski <krzk+dt@kernel.org>,
 Conor Dooley <conor+dt@kernel.org>, Vinod Koul <vkoul@kernel.org>,
 Andrzej Hajda <andrzej.hajda@intel.com>, Robert Foss <rfoss@kernel.org>
Cc: Neil Armstrong <neil.armstrong@linaro.org>,
 Manivannan Sadhasivam <mani@kernel.org>,
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>,
 Luca Ceresoli <luca.ceresoli@bootlin.com>,
 Dave Jones <s.dave.jones@gmail.com>, dri-devel@lists.freedesktop.org,
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-phy@lists.infradead.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v1 0/6] Add eDP support for RK3568
Date: Tue, 13 Oct 2026 20:49:40 +0800
Message-Id: <20261013124946.1807886-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0aa1354febbb03a8kunm2e7c128b3001
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFITzdXWRgWCB1ZQUpXWS1ZQUlXWQ8JGhUIEh9ZQVkaSRoYVktJGR8eHhgfGR5OTlYVFA
 kWGhdVEwETFhoSFyQUDg9ZV1kYEgtZQVlNSlVKTk9VSk9VQ01ZV1kWGg8SFR0UWUFZT0tIVUpLSE
 pKQk1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=Z5bIQIAvlHI95Bg0MV8RLH59wzyVXSY9zR3sHlD4R7SKAAI5DFyYYyxcZgwLbzW5DvKdT/YPvYzBZ2EgJOL3ps9az40v8TtyH2tCvldwSgFNWHBArBL1eA8hIGIZeYNaiG5ekfTAwE4/3gZn1nUtHttW6l5UolPMYOpQ3E51qMI=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=qsgnaJ8HgUwsD9AqhRnuRILZRtDgVlSZGoEjMwRkn1s=;
 h=date:mime-version:subject:message-id:from;
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

Rebased after:
https://lore.kernel.org/all/20260928081418.3605775-1-damon.ding@rock-chips.com/

PATCH 1 is to document the "rockchip,rk3568-edp" compatible in the
        Rockchip Analogix DP binding.
PATCH 2 is to add the binding for the RK3568 eDP PHY with NaNeng IP block.
PATCH 3 is to add the RK3568 support for the Analogix DP bridge driver.
PATCH 4 is to add the driver for the Rockchip eDP Transmitter PHY with
        NaNeng IP block.
PATCH 5 is to add the RK3568 support for the Rockchip Analogix DP driver.
PATCH 6 is to add the eDP controller and eDP PHY nodes for the RK3568
        SoCs.

Tested on RK3568 EVB1 baord with LG eDP panel LP079QX1-SP0V.

&edp {
  avdd-0v9-supply = <&vdda0v9_image>;
  avdd-1v8-supply = <&vcca1v8_image>;
  force-hpd;
  status = "okay";

  aux-bus {
    panel {
      compatible = "edp-panel";
      backlight = <&backlight>;
      power-supply = <&vcc3v3_lcd0_n>;
      no-hpd;

      port {
        panel_in_edp: endpoint {
          remote-endpoint = <&edp_out_panel>;
        };
      };
    };
  };
};

&edp_in {
  edp_in_vp0: endpoint {
    remote-endpoint = <&vp0_out_edp>;
  };
};

&edp_out {
  edp_out_panel: endpoint {
    remote-endpoint = <&panel_in_edp>;
  };
};

&edp_phy {
  status = "okay";
};

&vp0 {
  vp0_out_edp: endpoint@ROCKCHIP_VOP2_EP_EDP0 {
    reg = <ROCKCHIP_VOP2_EP_EDP0>;
    remote-endpoint = <&edp_in_vp0>;
  };
};

Damon Ding (6):
  dt-bindings: display: rockchip: analogix-dp: Add support for RK3568
  dt-bindings: phy: Add rockchip,rk3568-edp-phy
  drm/bridge: analogix_dp: Add support for RK3568
  phy: rockchip: Add support for Naneng eDP phy
  drm/rockchip: analogix_dp: Add support for RK3568
  arm64: dts: rockchip: rk356x: Add eDP controller and phy nodes

 .../rockchip/rockchip,analogix-dp.yaml        |  25 +-
 .../bindings/phy/rockchip,rk3568-edp-phy.yaml |  59 +++
 .../devicetree/bindings/soc/rockchip/grf.yaml |  15 +
 arch/arm64/boot/dts/rockchip/rk356x-base.dtsi |  41 ++
 .../drm/bridge/analogix/analogix_dp_core.c    |   1 +
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  20 +-
 drivers/phy/rockchip/Kconfig                  |  10 +
 drivers/phy/rockchip/Makefile                 |   1 +
 .../phy/rockchip/phy-rockchip-naneng-edp.c    | 435 ++++++++++++++++++
 include/drm/bridge/analogix_dp.h              |   2 +
 10 files changed, 607 insertions(+), 2 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/phy/rockchip,rk3568-edp-phy.yaml
 create mode 100644 drivers/phy/rockchip/phy-rockchip-naneng-edp.c

-- 
2.34.1
