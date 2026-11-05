Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3EA5E606D803
	for <dri-devel@archiver.kernel.org>; Thu,  5 Nov 2026 01:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=collabora.com header.i=@collabora.com header.a=rsa-sha256 header.s=mail header.b=KXx2WsyE
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 9A1E310E047;
	Thu,  5 Nov 2026 01:01:13 +0000 (UTC)
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id BA7CF10E047
 for <dri-devel@lists.freedesktop.org>; Thu,  5 Nov 2026 01:01:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1793840466;
 bh=84a+IYBILuhpZX+k0ipvweU/l0G2TkLtg047ssnB/Xs=;
 h=From:Subject:Date:To:Cc:From;
 b=KXx2WsyE8VFTdzA8DG7qoZ53i6TECTZ+PcdmUZcE2tVtU0AFOaVrJWAmiV9BOsd86
 imGiywghPMfKV2/26+OtyZtE9DqXN1HdAUfU2wWPGPVEskXF/yCUOuaXSJwSdG5ILS
 43kjtHYmXM5EJXdkN7O+6QSKhKv/G+J3qPqMB/Zlk+Nk9lz73rsV+U5E18rx9EPMeh
 IEdxfHJk9/Lf3xymOpZF2KB17SnV8Fag3+05eQn/2gcoMGsymfrOJne7vzG2O5AY9S
 MkBiKHjoYMT+bh2hSLs5H/SJQ/jKYrAzgDidFXh8CmDuDOiQoNAUpqxjiNFvMv/UHe
 PEki4lEIx/nJg==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest
 SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id F27A217E02F2;
 Thu, 05 Nov 2026 02:01:05 +0100 (CET)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v6 00/15] Support 10-bit YUV422 and 8/10-bit YUV420 color
 format on DW HDMI QP
Date: Thu, 05 Nov 2026 03:00:34 +0200
Message-Id: <20261105-dw-hdmi-qp-yuv-v6-0-1bb63ef5766e@collabora.com>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/3XQ3U4DIRAF4FdpuBbDP8Ur38N4wcDgYtpS2Xa1a
 fbdZWtiTVgvTzLznclcyYg140ieNldSccpjLocWzMOGhMEf3pDm2DIRTBhmuKXxkw5xn+nHkV7
 OExXAkgXQ4LectKVjxZS/buDL608ez/CO4bQoy8SQx1Opl1vjxJe5f/GJU0a9MTqkyEy08TmU3
 c5Dqf4xlD1ZCiZxJywzHSEaAY4DgpQRY1oj5F/CdYRcrlDebYV3SaBdI9SdcEx2hGpEAqUhKa4
 swhqhfwnOuOoI3QiTfPs3KuldR8zz/A2WH5kKzgEAAA==
X-Change-ID: 20260617-dw-hdmi-qp-yuv-2b0f7bb5ba81
To: Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andyshrk@163.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Herring <robh@kernel.org>, Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Daniel Stone <daniels@collabora.com>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniel@fooishbar.org>, 
 Nicolas Frattaroli <nicolas.frattaroli@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@oss.qualcomm.com>, 
 Sashiko <sashiko-bot@kernel.org>, Igor Paunovic <royalnet026@gmail.com>, 
 Sebastian Reichel <sebastian.reichel@collabora.com>, 
 Andy Yan <andyshrk@163.com>
X-Mailer: b4 0.15.2
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

This series extends the output color format support of the Rockchip DW
HDMI QP controller to cover 10-bit YUV 4:2:2 and 8/10-bit YUV 4:2:0.

Patches 1, 7 & 15 improve VOP2 robustness on RK3588, helping recover
from exceptions and preventing random display output glitches observed
when switching modes that also change the color format, e.g. from RGB to
YUV 4:2:0 and vice versa.

Patch 8 avoids an incorrect DCLK source switch for 10-bit YUV 4:2:2 by
forcing 8 bpc in the bandwidth check.

Patches 2-6 address a few vop2 related issues reported by Sashiko, while
9-12 are additional cleanups/improvements.

Patch 13 adds MEDIA_BUS_FMT_UYVY10_1X20 for 10-bit YUV 4:2:2 output,
configuring the PHY with 8 bpc.  YUV 4:2:2 always transmits two 12-bit
components per pixel regardless of color depth, so from a clock-rate
perspective it is equivalent to three 8-bit RGB components.

Patch 14 advertises YUV 4:2:0 output, now that the bus-format and VOP2
support are in place.

Tested on Radxa's boards ROCK 5B (RK3588) and ROCK 4D (RK3576).

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v6:
- Dropped vop2 patch "Send pending event when atomic_enable()" since
  atomic_enable() is not supposed to fail, and sending the event right
  away turns the vblank/flip_done timeout WARNs into a silent false
  success (Daniel)
- Added new vop2 patch "Disable core clocks before dropping runtime PM
  reference" (Sashiko)
- Captured dclk_src at init in "drm/rockchip: vop2: Consolidate HDMI PHY
  PLL clock parent switch" (Daniel)
- Reworked "drm/rockchip: vop2: Avoid DCLK source switch for 10-bit
  YUV422 output" into "drm/rockchip: vop2: Use TMDS character rate to
  select DCLK source" and further improved DCLK source switch handling
- Replaced the ternary with a helper in "drm/rockchip: dw_hdmi_qp:
  Support 10-bit YUV422 output format"
- Rebased series onto v7.4-rc1
- Link to v5: https://patch.msgid.link/20261014-dw-hdmi-qp-yuv-v5-0-6fab0fe43a9b@collabora.com

Changes in v5:
- Rebased onto latest drm-misc-next and fixed the conflicts introduced
  by the recent addition of HDMI 2.0 support to the DRM infrastructure
- Updated patch "drm/rockchip: vop2: Reset AXI and DCLK to improve
  robustness" to also assert the AXI reset in the bind path, fixing DSI
  panel support on RK3588 EVB1 (Sebastian Reichel)
- Added new patch "drm/rockchip: dw_hdmi_qp: Do not mask error code in
  atomic_check()" to fix a pre-existing issue reported by Sashiko
- Link to v4: https://patch.msgid.link/20260903-dw-hdmi-qp-yuv-v4-0-fb45bf4147eb@collabora.com

Changes in v4:
- Collected T-b tags from Igor
- Rebased onto the latest drm-misc-next, which now contains the HDPTX
  PHY driver fixes, so the runtime dependency has been dropped
- Link to v3: https://patch.msgid.link/20260709-dw-hdmi-qp-yuv-v3-0-a4a982a9f2e7@collabora.com

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
Cristian Ciocaltea (15):
      dt-bindings: display: vop2: Add missing reset properties
      drm/rockchip: vop2: Fix resource leak on vop2_enable() error path
      drm/rockchip: vop2: Disable core clocks before dropping runtime PM reference
      drm/rockchip: vop2: Balance state on atomic_enable() error paths
      drm/rockchip: vop2: Avoid division by zero when computing max_dclk
      drm/rockchip: vop2: Fix VOP2_MAX_DCLK_RATE overflow on 32-bit
      drm/rockchip: vop2: Reset AXI and DCLK to improve robustness
      drm/rockchip: vop2: Consolidate HDMI PHY PLL clock parent switch
      drm/rockchip: vop2: Use TMDS character rate to select DCLK source
      drm/rockchip: vop2: Switch to enum vop_csc_format
      drm/bridge: dw-hdmi-qp: Log resolution and refresh rate in atomic_enable()
      drm/rockchip: dw_hdmi_qp: Do not mask error code in atomic_check()
      drm/rockchip: dw_hdmi_qp: Support 10-bit YUV422 output format
      drm/rockchip: dw_hdmi_qp: Enable YUV420 output format
      arm64: dts: rockchip: Add RK3588 VOP2 resets

 .../bindings/display/rockchip/rockchip-vop2.yaml   |  46 +++-
 arch/arm64/boot/dts/rockchip/rk3588-base.dtsi      |  12 ++
 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c       |  10 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c     |  27 ++-
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.c       | 231 +++++++++++++++------
 drivers/gpu/drm/rockchip/rockchip_drm_vop2.h       |  10 +
 6 files changed, 263 insertions(+), 73 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20260617-dw-hdmi-qp-yuv-2b0f7bb5ba81

