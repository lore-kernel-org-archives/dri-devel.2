Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E2DB0108E1E3
	for <dri-devel@archiver.kernel.org>; Thu, 19 Mar 2026 10:40:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3228A10E92A;
	Thu, 19 Mar 2026 10:40:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="aRUK+Y7j";
	dkim-atps=neutral
Received: from mail-m19731103.qiye.163.com (mail-m19731103.qiye.163.com
 [220.197.31.103])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 3D7E810E91E
 for <dri-devel@lists.freedesktop.org>; Thu, 19 Mar 2026 10:40:38 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3790344a2;
 Thu, 19 Mar 2026 18:40:33 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: hjc@rock-chips.com, heiko@sntech.de, andy.yan@rock-chips.com,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, robh@kernel.org, krzk+dt@kernel.org,
 conor+dt@kernel.org, andrzej.hajda@intel.com, neil.armstrong@linaro.org,
 rfoss@kernel.org
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, nicolas.frattaroli@collabora.com,
 alchark@gmail.com, cristian.ciocaltea@collabora.com,
 sebastian.reichel@collabora.com, kever.yang@rock-chips.com,
 heiko.stuebner@cherry.de, tomeu@tomeuvizoso.net, amadeus@jmu.edu.cn,
 michael.riesch@collabora.com, didi.debian@cknow.org,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 dianders@chromium.org, m.szyprowski@samsung.com,
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org,
 linux-kernel@vger.kernel.org, Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v2 0/9] Add eDP support for RK3576
Date: Thu, 19 Mar 2026 18:40:22 +0800
Message-Id: <20260319104031.1986946-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d05aec56903a3kunm32a99f093bee32
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZGU9IGlYdSB4aSExLS00aQh5WFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=aRUK+Y7jWp8HXcSnwpXCG6ZnOj5BfhrZHbM83KDxft9xtxWzlnpeOYI2wslX2sABPQqxa92W1i33x9GmS5k+d95qVpkiespjbitrStCMY9MdtqziS5mneXQ7RYRUyq4pTJpwKDcJ3dmIaWEEaBRLnV6fWTklnXk8boPRI4G5QrA=;
 c=relaxed/relaxed; s=default; d=rock-chips.com; v=1; 
 bh=RuwWMPlmv4RvekbGox9rM/lnWkYXlDqjkEi6DyWCV64=;
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

These patchs have been tested with a 1536x2048p60 eDP panel on
RK3576 EVB1 board (hardware modified specially).

Patch 1~4 are to add missing clock "hclk" for RK3588 eDP nodes.
Patch 5~6 are to add the RK3576 eDP node.
Patch 7~9 are to support the RK3576 Analogix DP controller.

Damon Ding (9):
  dt-bindings: display: rockchip: analogix-dp: Expand clock-names "hclk"
    for the third clock
  arm64: dts: rockchip: Add missing clock "hclk" for RK3588 eDP0 nodes.
  arm64: dts: rockchip: Add missing clock "hclk" for RK3588 eDP1 nodes.
  drm/rockchip: analogix_dp: Enable clock "hclk" for RK3588
  dt-bindings: display: rockchip: analogix-dp: Add support for RK3576
  arm64: dts: rockchip: Add eDP node for RK3576
  drm/bridge: analogix_dp: Rename and simplify is_rockchip()
  drm/bridge: analogix_dp: Add support for RK3576
  drm/rockchip: analogix_dp: Add support for RK3576

 .../rockchip/rockchip,analogix-dp.yaml        |  6 +++-
 arch/arm64/boot/dts/rockchip/rk3576.dtsi      | 28 +++++++++++++++++++
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi |  4 +--
 .../arm64/boot/dts/rockchip/rk3588-extra.dtsi |  4 +--
 .../drm/bridge/analogix/analogix_dp_core.c    |  3 +-
 .../gpu/drm/bridge/analogix/analogix_dp_reg.c | 18 ++++++------
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   | 15 ++++++++++
 include/drm/bridge/analogix_dp.h              | 13 +++++++--
 8 files changed, 74 insertions(+), 17 deletions(-)

-- 
2.34.1

