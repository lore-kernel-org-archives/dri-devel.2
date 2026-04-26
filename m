Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A9442FF885A
	for <dri-devel@archiver.kernel.org>; Sun, 26 Apr 2026 00:20:31 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 93EB610E0BA;
	Sun, 26 Apr 2026 00:20:30 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=collabora.com header.i=@collabora.com header.b="R0x/+eFK";
	dkim-atps=neutral
Received: from bali.collaboradmins.com (bali.collaboradmins.com
 [148.251.105.195])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 91E1710E0BA
 for <dri-devel@lists.freedesktop.org>; Sun, 26 Apr 2026 00:20:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
 s=mail; t=1777162827;
 bh=AfrklpZhanVZ347ZRxSgMmwfas3MbrEOgB7m30ETr4M=;
 h=From:Subject:Date:To:Cc:From;
 b=R0x/+eFKQ9LD56Y91qnpN6c8WuozAx0QLefjnZ1iaMn0Uh7OEqkwn5OTwqUMZ8h0I
 6pD3D6gWq2Q0asup3TgiNeBtjbqsGiCdCUdj+5a1Sg6/j4Gni2xouCHsJX29MSUy3m
 aOW+ryMXKyMKEjhSRd2eZpw6cXF66t3zUTyy+u96GEzw3O4mLTUmCJucUMPhnQm9jx
 nfNi7kVo/ZnzNF0RKjKp1UQKDZ5NiLMV1bej25WyunukXqvIUkLuKg7Hr2nosdzkyO
 0jgxwxutH52x9iJHvrO/jnSMfBpPZrrLJTwXZLloEwE5UueyuCkwsXIjuppMsEhJDq
 PmL85Cj+7C/zw==
Received: from localhost (unknown [100.64.0.241])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange ECDHE (prime256v1) server-signature RSA-PSS (4096 bits)
 server-digest SHA256) (No client certificate requested)
 (Authenticated sender: cristicc)
 by bali.collaboradmins.com (Postfix) with ESMTPSA id 3040817E0EB4;
 Sun, 26 Apr 2026 02:20:27 +0200 (CEST)
From: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
Subject: [PATCH v5 00/10] Add HDMI 2.0 support to DW HDMI QP TX
Date: Sun, 26 Apr 2026 03:20:12 +0300
Message-Id: <20260426-dw-hdmi-qp-scramb-v5-0-d778e70c317b@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/33P0WqEMBAF0F+RPDclk6jRPvU/Sh+SmVgDarZJs
 S3ivzcKZRc27OMdmHO5G0suepfYS7Wx6FaffFhyaJ4qhqNZPhz3lDOTQjYgheL0zUeaPf+88IT
 RzJYjWepsoxGHnuW/S3SD/znNt/ecR5++Qvw9K1Y4ro+0FbjgnWoHp2sBpu1fMUyTsSGaZwwzO
 8RV/iutACgqMivGaSux6UjWVFLUrdKXFJWVPK4F0EoMCCWlviqqvKjOigJNynaWJNwt2vf9D1u
 Acs6IAQAA
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
 Andy Yan <andy.yan@rock-chips.com>
Cc: kernel@collabora.com, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org, 
 linux-rockchip@lists.infradead.org, 
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
series introduces an atomic-aware detect_ctx bridge hook and a
drm_bridge_detect_ctx() helper (patches 1-4), then uses them to
implement the SCDC scrambling feature (patch 5).

Patches 6-8 are minor cleanups in the dw-hdmi-qp and Rockchip platform
drivers.  Patches 9-10 improve HPD handling by deferring IRQ
registration until the connector is fully initialized and restricting
HPD events to the affected connector.

Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@collabora.com>
---
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
Cristian Ciocaltea (10):
      drm/bridge: Remove redundant error check in drm_bridge_helper_reset_crtc()
      drm/bridge: Add detect_ctx hook and drm_bridge_detect_ctx() helper
      drm/bridge-connector: Use cached connector status in .get_modes()
      drm/bridge-connector: Switch to .detect_ctx() for connector detection
      drm/bridge: dw-hdmi-qp: Add HDMI 2.0 SCDC scrambling and high TMDS clock ratio support
      drm/bridge: dw-hdmi-qp: Rate limit i2c read error messages
      drm/rockchip: dw_hdmi_qp: Add missing newlines in dev_err_probe() messages
      drm/rockchip: dw_hdmi_qp: Use local dev variable consistently in bind()
      drm/rockchip: dw_hdmi_qp: Register HPD IRQ after connector setup
      drm/rockchip: dw_hdmi_qp: Restrict HPD event to the affected connector

 drivers/gpu/drm/bridge/synopsys/dw-hdmi-qp.c   | 192 ++++++++++++++++++++++---
 drivers/gpu/drm/display/drm_bridge_connector.c |  75 +++++-----
 drivers/gpu/drm/drm_bridge.c                   |  66 ++++++++-
 drivers/gpu/drm/drm_bridge_helper.c            |   2 -
 drivers/gpu/drm/rockchip/dw_hdmi_qp-rockchip.c |  68 ++++-----
 include/drm/drm_bridge.h                       |  43 +++++-
 6 files changed, 344 insertions(+), 102 deletions(-)
---
base-commit: 03af6c3afc4893988ceed54531f5dde4bebd6024
change-id: 20251203-dw-hdmi-qp-scramb-cdbd8b57ccf9

