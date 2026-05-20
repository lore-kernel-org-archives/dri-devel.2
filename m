Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 617C0CD5BA4
	for <dri-devel@archiver.kernel.org>; Wed, 20 May 2026 18:38:34 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BD5D710E431;
	Wed, 20 May 2026 18:38:33 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="eDDRrxaz";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9885410E431
 for <dri-devel@lists.freedesktop.org>; Wed, 20 May 2026 18:38:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1779302311;
 bh=d7upM0l/PKAeVuVxfaTslrHBJEs/g3xzJczXCxTi9II=;
 h=From:Subject:Date:To:Cc:From;
 b=eDDRrxazfg1t6yc8FxgWA6MUwdAl8NzhOrTpCF1aP7kkHBKlnBLe+4qNR+b7eKNOp
 f1SkGWh6mPvzlfMBmCzcm4J2UlqxZ7QwdHK9KVKNoBIkkUBCLgbAqyNcmqCWLsuiXB
 l2HF2968ygDwjkmHYUs6xTuoI/etkEAgIE0Yjwl+x5sNq7wy3HSRC3Qua6i5WANuWs
 /etahr/EBuz6lBI1ktiqKVQiGt3xHTo2X/+NGXsOp6ebhiv+pfFdUwZkgOlubjn/Nq
 BdeJzZGk/ddMcZSU1c4T/qlfSs6Auw+AY4IV2eS6QWQo/kMqoNWLz1WoDvd74GHsgc
 Hn4elVtDnfwuw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 103E017E0698;
 Wed, 20 May 2026 20:38:31 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v6 00/22] Add HDMI 2.0 support to DW HDMI QP TX
Date: Wed, 20 May 2026 21:38:11 +0300
Message-Id: <20260520-dw-hdmi-qp-scramb-v6-0-24b74603b782@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33PTWrDMBAF4KsEraui0a+dVe8RupBGci2Io1QKb
 kvw3TsJlJQiunwD8z3elbVUc2psv7uymtbccjlRsE87hrM/vSWeI2UmhTQgheLxg89xyfz9zBt
 WvwSOMcQhGIc4jYz+zjVN+fNuHl4pz7ldSv26V6xwu/6nrcAFH5SdktMCvB1fsByPPpTqn7Es7
 Cau8kexAqCrSFJ8ckGiGaLUsaeo38rYUxQpNM4COCUmhJ6iH4rqL9KkKHBRhSFECd1F5qFoaXu
 KISU6NyQnkLTwV9m27RtBvQCQzgEAAA==
X-Change-ID: 20251203-dw-hdmi-qp-scramb-cdbd8b57ccf9
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Sandy Huang <hjc@rock-chips.com>, 
 =?utf-8?q?Heiko_St=C3=BCbner?= <heiko@sntech.de>, 
 Andy Yan <andy.yan@rock-chips.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Daniel Stone <daniels@collabora.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Diederik de Haas <diederik@cknow-tech.com>, 
 Maud Spierings <maud_spierings@hotmail.com>
X-Mailer: b4 0.15.1
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

Enable HDMI 2.0 display modes (e.g. 4K@60Hz) on the Synopsys DW HDMI QP
TX controller, as found in Rockchip RK3576 & RK3588 SoCs, by adding SCDC
management for high TMDS clock ratio and scrambling.

Since SCDC state is lost on sink disconnects, the bridge driver needs to
trigger a CRTC reset during connector detection.  To support this, the
series introduces the connector and bridge scrambling infrastructure
(patches 1-7), wires it up through the bridge connector layer with an
atomic-aware detect_ctx hook (patches 8-10), then implements the SCDC
scrambling feature in the DW HDMI QP bridge driver (patches 11-14).

Patches 15-17 are minor cleanups in the Rockchip platform driver.
Patches 18-22 improve HPD handling by deferring IRQ registration until
the connector is fully initialized, adding .enable_hpd()/.disable_hpd()
PHY ops, and restricting HPD events to the affected connector.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
Changes in v6:
- Collected R-b & A-b tags from Dmitry and Heiko
- Restructured the series from 10 into 22 patches, splitting the SCDC
  scrambling helpers, connector infrastructure, bridge operations,
  bridge_connector plumbing, dw-hdmi-qp implementation, and Rockchip
  platform changes into distinct commits
- Added drm_scdc_dbg() macro to simplify debug messages (new patch)
- Added drm_scdc_start/stop/sync_status() helpers for full scrambling
  lifecycle management (reworked from v5 patch 5)
- Added drm_atomic_helper_connector_hdmi_hotplug_ctx() to propagate
  modeset acquire context for SCDC sync on hotplug (new patch)
- Added connector scrambler callbacks and SCDC work/flag infrastructure
  as a separate patch (split from v5 patch 5)
- Added DRM_BRIDGE_OP_HDMI_SCRAMBLER bridge operation with
  hdmi_scrambler_enable/disable callbacks (new patch)
- Implemented bridge_connector scrambler interface wiring (new patch)
- Added .enable_hpd()/.disable_hpd() PHY ops for dw-hdmi-qp bridge and
  Rockchip platform drivers, replacing the obsolete .setup_hpd() op
- Added dw_hdmi_qp_hpd_notify() helper for targeted connector-only HPD
  notification (split from v5 patch 10)
- Dropped drm_fb_helper_hotplug_event() unused variable (new cleanup)
- Dropped unused drm_simple_kms_helper.h include (new cleanup)
- Masked RK3576 HPD IRQ in io_init() for consistency with RK3588
- Rebased onto latest drm-misc-next
- Link to v5: https://patch.msgid.link/20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com

Changes in v5:
- Added new patches: 1/10, 3/10, 6/10, 7/10, 8/10
- Removed redundant no-op error check in drm_bridge_helper_reset_crtc()
  (patch 1)
- Removed the EDEADLK retry loop from the bridge .detect_ctx() callback,
  as that's already handled in the drm_bridge_detect_ctx() helper or by
  the caller when ctx is provided (patch 2)
- Refactored drm_bridge_detect() to delegate to drm_bridge_detect_ctx()
  and added a WARN_ON for unexpected negative return values (patch 2)
- Split the bridge-connector .detect_ctx() switch into a preparatory
  patch to use cached connector status in .get_modes() (patch 3)
- Improved error handling in SCDC scrambling setup: roll back high TMDS
  clock ratio on scrambling failure, reset scramb_enabled flag on
  set_scramb failure, and add SCDC version read/write error checks
  (patch 5)
- Annotated scramb_enabled with READ_ONCE/WRITE_ONCE for cross-context
  access between modeset paths and the scrambling work item (patch 5)
- Renamed SCDC_MIN_SOURCE_VERSION to SCDC_MAX_SOURCE_VERSION (patch 5)
- Rate limited i2c error messages (patch 6)
- Added missing newlines in dev_err_probe() messages (patch 7)
- Replaced indirect device pointer accesses with local dev variable in
  bind() (patch 8)
- Split the HPD connector restriction (formerly patch 4/4): register HPD
  IRQ after connector setup first (patch 9), then restrict HPD event to
  the affected connector (patch 10); also collected R-b from Heiko
- Rebased onto latest drm-misc-next
- Link to v4: https://lore.kernel.org/r/20260303-dw-hdmi-qp-scramb-v4-0-317d3b8bd219@collabora.com

Changes in v4:
- Fixed conflicts while rebasing onto latest drm-misc-next
- Link to v3: https://lore.kernel.org/r/20260119-dw-hdmi-qp-scramb-v3-0-bd8611730fc1@collabora.com

Changes in v3:
- Used drm_bridge_helper_reset_crtc() helper to reset the display
  pipeline and got rid of some boilerplate code (Maxime)
- Rebased onto latest drm-misc-next
- Link to v2: https://lore.kernel.org/r/20260113-dw-hdmi-qp-scramb-v2-0-ae7b2c58d24d@collabora.com

Changes in v2:
- Collected Tested-by tags from Diederik and Maud
- Rebased onto latest drm-misc-next
- Ensured the recently introduced 'no-hpd' support for dealing with
  unconnected/repurposed/broken HPD pin is limited to HDMI 1.4 rates
- Link to v1: https://lore.kernel.org/r/20251203-dw-hdmi-qp-scramb-v1-0-836fe7401a69@collabora.com

---
Cristian Ciocaltea (22):
      drm/fb-helper: Remove unused local variable in hotplug_event()
      drm/connector: Add HDMI 2.0 scrambler infrastructure
      drm/display: scdc_helper: Add macro to simplify debugging
      drm/display: scdc_helper: Add HDMI 2.0 scrambling management helpers
      drm/display: hdmi_state_helper: Add ctx-aware hotplug helper for SCDC sync
      drm/bridge: Remove redundant error check in drm_bridge_helper_reset_crtc()
      drm/bridge: Add HDMI 2.0 scrambler bridge operation and callbacks
      drm/display: bridge_connector: Use cached connector status in .get_modes()
      drm/display: bridge_connector: Switch to .detect_ctx() connector helper
      drm/display: bridge_connector: Wire up HDMI 2.0 scrambler callbacks
      drm/bridge: dw-hdmi-qp: Rate limit i2c read error messages
      drm/bridge: dw-hdmi-qp: Provide .{enable|disable}_hpd() PHY ops
      drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC scrambling support`
      drm/bridge: dw-hdmi-qp: Provide dw_hdmi_qp_hpd_notify() helper
      drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() messages
      drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind()
      drm/rockchip: dw_hdmi_qp: Drop unnecessary #include
      drm/rockchip: dw_hdmi_qp: Defer HPD IRQ enable until after connector setup
      drm/rockchip: dw_hdmi_qp: Mask HPD IRQ in rk3576_io_init()
      drm/rockchip: dw_hdmi_qp: Implement .{enable|disable}_hpd() PHY ops
      drm/rockchip: dw_hdmi_qp: Switch to dw_hdmi_qp_hpd_notify()
      drm/bridge: dw-hdmi-qp: Remove obsolete .setup_hpd() phy op

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c    | 132 +++++++++---
 drivers/gpu/drm/display/drm_bridge_connector.c  | 118 +++++++----
 drivers/gpu/drm/display/drm_hdmi_state_helper.c |  36 +++-
 drivers/gpu/drm/display/drm_scdc_helper.c       | 259 ++++++++++++++++++++++--
 drivers/gpu/drm/drm_bridge_helper.c             |   2 -
 drivers/gpu/drm/drm_connector.c                 |  14 ++
 drivers/gpu/drm/drm_fb_helper.c                 |  11 +-
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c  | 130 ++++++------
 include/drm/bridge/dw_hdmi_qp.h                 |   4 +-
 include/drm/display/drm_hdmi_state_helper.h     |   4 +
 include/drm/display/drm_scdc_helper.h           |   6 +-
 include/drm/drm_bridge.h                        |  26 +++
 include/drm/drm_connector.h                     |  52 +++++
 13 files changed, 623 insertions(+), 171 deletions(-)
---
base-commit: a48bbcc7ac739e93562d6148c6fa504c2e9f22f8
change-id: 20251203-dw-hdmi-qp-scramb-cdbd8b57ccf9

