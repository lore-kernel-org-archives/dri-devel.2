Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 388C8F34C53
	for <dri-devel@archiver.kernel.org>; Mon, 13 Apr 2026 13:26:09 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7E4E710E0C0;
	Mon, 13 Apr 2026 13:26:08 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (1024-bit key; unprotected) header.d=rock-chips.com header.i=@rock-chips.com header.b="dUSWDU2h";
	dkim-atps=neutral
Received: from mail-m3277.qiye.163.com (mail-m3277.qiye.163.com
 [220.197.32.77])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5A9EC8951B
 for <dri-devel@lists.freedesktop.org>; Mon, 13 Apr 2026 13:26:04 +0000 (UTC)
Received: from zyb-HP-ProDesk-680-G2-MT.. (unknown [58.22.7.114])
 by smtp.qiye.163.com (Hmail) with ESMTP id 3a8976ad3;
 Mon, 13 Apr 2026 21:25:54 +0800 (GMT+08:00)
From: Damon Ding <damon.ding@rock-chips.com>
To: andrzej.hajda@intel.com, neil.armstrong@linaro.org, rfoss@kernel.org,
 maarten.lankhorst@linux.intel.com, mripard@kernel.org, tzimmermann@suse.de,
 airlied@gmail.com, simona@ffwll.ch, inki.dae@samsung.com,
 sw0312.kim@samsung.com, kyungmin.park@samsung.com, krzk@kernel.org,
 jingoohan1@gmail.com, hjc@rock-chips.com, heiko@sntech.de,
 andy.yan@rock-chips.com
Cc: Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
 jernej.skrabec@gmail.com, alim.akhtar@samsung.com,
 dmitry.baryshkov@oss.qualcomm.com, luca.ceresoli@bootlin.com,
 nicolas.frattaroli@collabora.com, dianders@chromium.org,
 m.szyprowski@samsung.com, linux-kernel@vger.kernel.org,
 dri-devel@lists.freedesktop.org, linux-arm-kernel@lists.infradead.org,
 linux-samsung-soc@vger.kernel.org, linux-rockchip@lists.infradead.org,
 Damon Ding <damon.ding@rock-chips.com>
Subject: [PATCH v14 0/8] Apply drm_bridge_connector and panel_bridge helper
 for the Analogix DP driver
Date: Mon, 13 Apr 2026 21:25:43 +0800
Message-Id: <20260413132551.1049307-1-damon.ding@rock-chips.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-HM-Tid: 0a9d870522cc03a3kunmf5e06f40656e3d
X-HM-MType: 1
X-HM-Spam-Status: e1kfGhgUHx5ZQUpXWQgPGg8OCBgUHx5ZQUlOS1dZFg8aDwILHllBWSg2Ly
 tZV1koWUFDSUNOT01LS0k3V1ktWUFJV1kPCRoVCBIfWUFZQh9MS1YZTx0ZTk5LTEpKH0JWFRQJFh
 oXVRMBExYaEhckFA4PWVdZGBILWUFZTkNVSUlVTFVKSk9ZV1kWGg8SFR0UWUFZT0tIVUpLSEpKQk
 1VSktLVUpCWQY+
DKIM-Signature: a=rsa-sha256;
 b=dUSWDU2hhwBZz6Vnfg5TJ6feosYkPDKzfzuKQHKZN6mGC6XBnJ1A1AJv2TEO/elduZsYwaKDtN7UZ+jbqq1WWsgUmovSLoYDVP1cW3ZGAlLFYo8IQitxCEAD0OAC3ihzWkX64VyYpJP4tT07TH2nNzPtLROuD+0hvPklCglW8os=;
 s=default; c=relaxed/relaxed; d=rock-chips.com; v=1; 
 bh=3m1llzTVoFgx/vD5INRQ645qN4fKypoVUgFkxb0uIPU=;
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

Picked from:
https://lore.kernel.org/all/20260409065301.446670-1-damon.ding@rock-chips.com/

PATCH 1 is the preparation for apply drm_bridge_connector helper.
PATCH 2 is to apply the drm_bridge_connector helper.
PATCH 3-5 are to move the panel/bridge parsing to the Analogix side.
PATCH 6 is to attach the next bridge on Analogix side uniformly.
PATCH 7-8 are to apply the panel_bridge helper.

Damon Ding (8):
  drm/bridge: analogix_dp: Pass struct drm_atomic_state* for
    analogix_dp_bridge_mode_set()
  drm/bridge: analogix_dp: Apply drm_bridge_connector helper
  drm/bridge: analogix_dp: Add new API analogix_dp_finish_probe()
  drm/rockchip: analogix_dp: Apply analogix_dp_finish_probe()
  drm/exynos: exynos_dp: Apply analogix_dp_finish_probe()
  drm/bridge: analogix_dp: Attach the next bridge in
    analogix_dp_bridge_attach()
  drm/bridge: analogix_dp: Remove bridge disabing and panel unpreparing
    in analogix_dp_unbind()
  drm/bridge: analogix_dp: Apply panel_bridge helper

 drivers/gpu/drm/bridge/analogix/Kconfig       |   1 +
 .../drm/bridge/analogix/analogix_dp_core.c    | 225 +++++++++---------
 .../drm/bridge/analogix/analogix_dp_core.h    |   1 -
 drivers/gpu/drm/exynos/Kconfig                |   1 +
 drivers/gpu/drm/exynos/exynos_dp.c            |  59 ++---
 drivers/gpu/drm/rockchip/Kconfig              |   1 +
 .../gpu/drm/rockchip/analogix_dp-rockchip.c   |  49 +---
 include/drm/bridge/analogix_dp.h              |   3 +-
 8 files changed, 150 insertions(+), 190 deletions(-)

---

Changes in v2:
- Update Exynos DP driver synchronously.
- Move the panel/bridge parsing to the Analogix side.

Changes in v3:
- Rebase for the existing devm_drm_bridge_alloc() applying commit.
- Fix the typographical error of panel/bridge check in exynos_dp_bind().
- Squash all commits related to skip_connector deletion in both Exynos and
  Analogix code into one.
- Apply panel_bridge helper to make the codes more concise.
- Fix the handing of bridge in analogix_dp_bridge_get_modes().
- Remove unnecessary parameter struct drm_connector* for callback
  &analogix_dp_plat_data.attach().
- In order to decouple the connector driver and the bridge driver, move
  the bridge connector initilization to the Rockchip and Exynos sides.

Changes in v4:
- Rebase for the applied &drm_bridge_funcs.detect() modification commit.
- Rename analogix_dp_find_panel_or_bridge() to analogix_dp_finish_probe().
- Drop the drmm_encoder_init() modification commit.
- Rename the &analogix_dp_plat_data.bridge to
  &analogix_dp_plat_data.next_bridge.

Changes in v5:
- Add legacy bridge to parse the display-timings node under the dp node
  for Exynos side.
- Move color format check to &drm_connector_helper_funcs.atomic_check()
  in order to get rid of &analogix_dp_plat_data.get_modes().
- Remove unused callback &analogix_dp_plat_data.get_modes().
- Distinguish the &drm_bridge->ops of Analogix bridge based on whether
  the downstream device is a panel, a bridge or neither.
- Select DRM_DISPLAY_DP_AUX_BUS for DRM_ANALOGIX_DP, and remove it for
  ROCKCHIP_ANALOGIX_DP.
- Apply rockchip_dp_attach() to support the next bridge attachment for
  the Rockchip side.
- Move next_bridge attachment from Analogix side to Rockchip/Exynos sides.

Changes in v6:
- Move legacy bridge driver out of imx directory for multi-platform use.
- Apply DRM legacy bridge to parse display timings intead of implementing
  the same codes only for Exynos DP.
- Ensure last bridge determines EDID/modes detection capabilities in DRM
  bridge_connector driver.
- Remove unnecessary drm_bridge_get_modes() in
  analogix_dp_bridge_get_modes().
- Simplify analogix_dp_bridge_edid_read().
- If the next is a bridge, set DRM_BRIDGE_OP_DETECT and return
  connector_status_connected in analogix_dp_bridge_detect().
- Set flag DRM_BRIDGE_ATTACH_NO_CONNECTOR for bridge attachment while
  binding. Meanwhile, make DRM_BRIDGE_ATTACH_NO_CONNECTOR unsuppported
  in analogix_dp_bridge_attach().
- Move the next bridge attachment to the Analogix side rather than
  scattered on Rockchip and Exynos sides.
- Remove the unnecessary analogix_dp_bridge_get_modes().
- Squash [PATCH v5 15/17] into [PATCH v5 17/17].
- Fix the &drm_bridge->ops to DRM_BRIDGE_OP_EDID | DRM_BRIDGE_OP_DETECT.

Changes in v7:
- As Luca suggested, simplify the code and related comment for bridge_connector
  modifications. Additionally, move the commit related to bridge_connector to
  the top of this patch series.
- Rename legacy-bridge driver to of-display-mode-bridge driver.
- Remove unnecessary API drm_bridge_is_legacy() and apply a temporary flag
  &exynos_dp_device.has_of_bridge instead, which will be removed finally.
- Remove exynos_dp_legacy_bridge_init() and inline API
  devm_drm_of_display_mode_bridge().

Changes in v8:
- Adapt the related modifications to the newest bridge_connector driver.

Changes in v9:
- Fix the Kconfig help text for CONFIG_DRM_OF_DISPLAY_MODE_BRIDGE.
- Add Tested-by tag from Heiko.

Changes in v10:
- Fix to use dev_err_probe() in newly added API analogix_dp_finish_probe().
- Expaned commit message for [PATCH v9 9/15] and [PATCH v9 10/15].
- Split [PATCH v9 9/15] into serval smaller commits.
- Add Reviewed-by tags from Luca.

Changes in v11:
- Merge [PATCH v10 12/18] into [PATCH v10 11/18].
- Fix the bridge flag to 'flags | DRM_BRIDGE_ATTACH_NO_CONNECTOR' in
  [PATCH v10 11/18].
- Add Reviewed-by tags from Luca.

Changes in v12:
- Restore accidentally removed DRM_BRIDGE_CONNECTOR Kconfig in v10.

Changes in v13:
- Modify '(on rk3588)' to '# rk3588' for Tested-by tag as discussed in
  https://lore.kernel.org/all/571cc85a-3310-4b56-a3ef-3aab698192f6@rock-chips.com/
- Rebase [PATCH v12 2/17] after commit 02df94d98ff8 ("drm/imx: parallel-display:
  add DRM_DISPLAY_HELPER for DRM_IMX_PARALLEL_DISPLAY")
- Rebase [PATCH v12 7/17] and [PATCH v12 11/17] after commit 01962a191242
  ("drm/rockchip: analogix: Convert to drm_output_color_format")

Changes in v14:
- Picked from
  https://lore.kernel.org/all/20260409065301.446670-1-damon.ding@rock-chips.com/
- Add Reviewed-by tags.
- Apply __free() to call drm_bridge_put() in CRC ralted functions of Analogix
  side.

-- 
2.34.1

