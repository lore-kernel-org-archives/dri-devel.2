Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1E610C43458
	for <dri-devel@archiver.kernel.org>; Wed,  8 Jul 2026 21:57:55 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7408E10F2E8;
	Wed,  8 Jul 2026 21:57:54 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="VZQ4OvD6";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16A9310F2E8
 for <dri-devel@lists.freedesktop.org>; Wed,  8 Jul 2026 21:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1783547871;
 bh=k8K2SHz6AQFatWz++NWmyPhT7s4wTOLAwEAvCEwc65U=;
 h=From:Subject:Date:To:Cc:From;
 b=VZQ4OvD6RY9DscEBO5xZc1rPkHQONTlq4V9q9uhhCH945NEuB+zSxWRhkwwLi94JR
 9txR43Pg2UiUDOk8W6OvBKGnqe3wN9jBdHH9Kd1s1SBa3cg7Fg8NjxjGhEC4AGRzX1
 tBVeqZ8JXAXHtvFREhItMHQXBe28yqStOqcBZ3Wz3imdOh59/CtypcnZxc60eJ48ij
 LFZR07Z6pYXJVntUYRXbdp5TKoSUS2DWRqmCsmT5EVMewx+lNsxwbD9d7NRnNV+g/3
 1ldTmjtdHCQoPuBBBOd1HQCMEsoptqyw3y4zIjz7iuL1ig4YuN0KdYQmX80fVmwcho
 Gm4lnEpdn7LGA==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id EF19E17E013E;
 Wed, 08 Jul 2026 23:57:50 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v3 00/14] Support 10-bit YUV422 and 8/10-bit YUV420 color
 format on DW HDMI QP
Date: Thu, 09 Jul 2026 00:57:22 +0300
Message-Id: <20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XNQQ7CIBQE0Ks0rMUATUFdeQ/jgg/UYlqp0KJN0
 7sLdWGicTnJzJsZBeOtCehQzMibaIN1txTKTYFUI28Xg61OGTHCOOFUYP3Aje4svvd4GiNmQGo
 BUIHcUZRGvTe1fa7g6fzOYYSrUUNWcqOxYXB+Wh8jzb2/eKSYYMl5pWpNuBb6qFzbSnBebpXrU
 D6I7EMIwn8IlgjYUzBQltro+ptYluUFBIO5JQUBAAA=
X-Change-ID: 20260617-dw-hdmi-qp-yuv-2b0f7bb5ba81
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc: kernel@collabora.com, Andy Yan <andyshrk@163.com>, 
 dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-rockchip@lists.infradead.org, 
 linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Sashiko <sashiko-bot@kernel.org>
X-Mailer: b4 0.15.2
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

This series extends the output color format support of the Rockchip DW
HDMI QP controller to cover 10-bit YUV 4:2:2 and 8/10-bit YUV 4:2:0.

Please note this has a runtime dependency on the Rockchip Samsung HDPTX
PHY driver bug fixes posted separately as [1].  While there is no build
dependency, those fixes are required to address clock rate calculation
and synchronization issues that arise when changing the color depth
(bpc) while keeping the modeline constant.

Patches 1, 7 & 14 improve VOP2 robustness on RK3588, helping recover from
exceptions and preventing random display output glitches observed when
switching modes that also change the color format, e.g. from RGB to YUV
4:2:0 and vice versa.

Patch 8 avoids an incorrect DCLK source switch for 10-bit YUV 4:2:2 by
forcing 8 bpc in the bandwidth check.

Patches 2-6 address a few vop2 related issues reported by Sashiko, while
9-11 are additional cleanups/improvements.

Patch 12 adds MEDIA_BUS_FMT_UYVY10_1X20 for 10-bit YUV 4:2:2 output,
configuring the PHY with 8 bpc.  YUV 4:2:2 always transmits two 12-bit
components per pixel regardless of color depth, so from a clock-rate
perspective it is equivalent to three 8-bit RGB components.

Patch 13 advertises YUV 4:2:0 output, now that the bus-format and VOP2
support are in place.

Tested on Radxa ROCK 5B (RK3588) and Radxa ROCK 4D (RK3576), up to
4K@60Hz YUV 4:2:0 and 4K@30Hz RGB.

[1] https://lore.kernel.org/all/20260612-hdptx-clk-fixes-v4-0-ce5e1d456cda@collabora.com/

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v3:
- Updated patch 3 to skip any hardware programming in the callbacks
  gated by drm_atomic_helper_commit_planes() after powering down VOP2 on
  an atomic_enable() error (Sashiko)
- Ensured VBLANK events are sent immediately when atomic_enable() fails,
  hence preventing userspace processes waiting for the page flip
  completion to hang indefinitely (new patch 4, Sashiko)
- Rebased onto latest drm-misc-next
- Link to v2: https://patch.msgid.link/20260706-dw-hdmi-qp-yuv-v2-0-b91beb33dedf@collabora.com

Changes in v2:
- Collected R-b from Krzysztof on the binding patch, while also fixed
  the property ordering in the example
- Renamed vop2_clk_reset() to vop2_reset_assert_deassert() and used to
  devm_reset_control_get_optional_exclusive() in patch 6 (Philipp Zabel)
- Addressed several issues reported by Sashiko
  * Reset AXI before detaching the IOMMU domain, to close a theoretical
    window where stale or in-flight DMA transactions could fault or
    access memory untranslated after the domain is detached (patch 6)
  * Fixed resource leak on vop2_enable() error path (new patch 2)
  * Balance state on atomic_enable error paths (new patch 3)
  * Avoided division by zero when computing max_dclk (new path 4)
  * Fixed VOP2_MAX_DCLK_RATE overflow on 32-bit (new patch 5)
- Rebased onto latest drm-misc-next
- Link to v1: https://patch.msgid.link/20260617-dw-hdmi-qp-yuv-v1-0-a665cfd06d7d@collabora.com

---
Cristian Ciocaltea (14):
      dt-bindings: display: vop2: Add missing reset properties
      drm/rockchip: vop2: Fix resource leak on vop2_enable() error path
      drm/rockchip: vop2: Balance state on atomic_enable() error paths
      drm/rockchip: vop2: Send pending event when atomic_enable() fails
      drm/rockchip: vop2: Avoid division by zero when computing max_dclk
      drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE overflow on 32-bit
      drm/rockchip: vop2: Reset AXI and DCLK to improve robustness
      drm/rockchip: vop2: Avoid DCLK source switch for 10-bit YUV422 output
      drm/rockchip: vop2: Consolidate HDMI PHY PLL clock parent switch
      drm/rockchip: vop2: Switch to enum vop_csc_format
      drm/bridge: dw-hdmi-qp: Log resolution and refresh rate in atomic_enable()
      drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422 output format
      drm/rockchip: dw_hdmi_qp: Enable YUV420 output format
      arm64: dts: rockchip: Add RK3588 VOP2 resets

 .../bindings/display/rockchip/rockchip-vop2.yaml   |  46 ++++-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  12 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |  10 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |  13 +-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       | 215 +++++++++++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h       |  10 +
 6 files changed, 244 insertions(+), 62 deletions(-)
---
base-commit: 671b7825dbfe9ea6e3ad3001003aeee0df48d1b5
change-id: 20260617-dw-hdmi-qp-yuv-2b0f7bb5ba81

