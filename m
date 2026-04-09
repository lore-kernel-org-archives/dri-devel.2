Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 20E52F364A4
	for <dri-devel@archiver.kernel.org>; Thu,  9 Apr 2026 17:08:57 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 60F0510E011;
	Thu,  9 Apr 2026 17:08:56 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="hxpi7Dsx";
	dkim-atps=neutral
Received: from smtpout-04.galae.net (smtpout-04.galae.net [185.171.202.116])
 by gabe.freedesktop.org (Postfix) with ESMTPS id A8F5310E011;
 Thu,  9 Apr 2026 17:08:54 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-04.galae.net (Postfix) with ESMTPS id EF74FC5C18A;
 Thu,  9 Apr 2026 17:09:26 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 00587603E4;
 Thu,  9 Apr 2026 17:08:51 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id B8770104500F2; 
 Thu,  9 Apr 2026 19:08:41 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775754530; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=vkWOcKx6uUnLGWEeSpSMD8GMbN5TDhNOCyHUzp+VpLg=;
 b=hxpi7DsxOvnrGkGEMd+Aa5L7+cTR44o6q+DIIYM+E88DF08NNiyGSA36Z9B4uTkPe9PTf3
 Y1Mk2/KNjvIiSUnjp+GTl2o32jI/r0soNWm+SBkJliCgN3BwZxRrxdFL58Hk5UBNyxxU66
 o+th6eHU1A4yNEroonMDElx+4JgdLv68aWDmEACMzOD1Xf7fT9k/ovMBns/p6sTn+D53D5
 l7gP3O7x9X7kwvGIhScbDAZh4NjOCoYvale6z4mrsLdOhSQuGo7Ka7dpGxuFmJhyLYlxXv
 2XEYp9Ki+p27ZZgvpeUgFNv70GwDkdOH64xkmoWbfBfPWMfBPLAuprjOnPcl3g==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH RFC 00/12] Add support for DisplayPort link training
 information report
Date: Thu, 09 Apr 2026 19:08:16 +0200
Message-Id: <20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAADd12kC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyDHUUlJIzE
 vPSU3UzU4B8JSMDIzMDIyMz3bTUxJL4nMy87PjkxAJdI4PkpCSzNGPDFBMDJaCegqLUtMwKsHn
 RSkFuzkqxtbUAHOP6R2QAAAA=
To: Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Dave Airlie <airlied@redhat.com>, 
 Jesse Barnes <jbarnes@virtuousgeek.org>, Eric Anholt <eric@anholt.net>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Chris Wilson <chris@chris-wilson.co.uk>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Simona Vetter <simona.vetter@ffwll.ch>, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.14-dev-d4707
X-Last-TLS-Session-Version: TLSv1.3
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

DisplayPort link training negotiates the physical-layer parameters needed
for a reliable connection: lane count, link rate, voltage swing,
pre-emphasis, and optionally Display Stream Compression (DSC). Currently,
each driver exposes this state in its own way, often through
driver-specific debugfs entries, with no standard interface for userspace
diagnostic and monitoring tools.

This series introduces a generic, DRM-managed framework for exposing DP
link training state as standard connector properties, modeled after the
existing HDMI helper drmm_connector_hdmi_init().

The new drmm_connector_dp_init() helper initializes a DP connector and
registers the following connector properties to expose the negotiated link
state to userspace:

- num_lanes:      negotiated lane count (1, 2 or 4)
- link_rate:      negotiated link rate
- dsc_en:         whether Display Stream Compression is active
- voltage_swingN: per-lane voltage swing level (lanes 0-3)
- pre_emphasisN:  per-lane pre-emphasis level (lanes 0-3)

Two runtime helpers update and clear these properties when link training
completes or the link goes down:
- drm_connector_dp_set_link_train_properties()
- drm_connector_dp_reset_link_train_properties()

Two drivers are updated as reference implementations: i915 (direct
connector path) and MediaTek (via the bridge connector framework using a
new DRM_BRIDGE_OP_DP flag). The i915 patches are preceded by a series of
conversions to DRM managed resources, which are required before adopting
drmm_connector_dp_init().

The MST case in i915 driver is not supported yet.

Patches 1-3:  Fix two error-path cleanup bugs in i915 sdvo and lvds
[Will probably be sent standalone]
Patches 4-8: Convert i915 display resources to DRM managed lifetime
Patch 9: Introduce the core drmm_connector_dp_init() framework
Patch 10: Wire the i915 DP connector to use the new helpers
Patch 11: Introduce DRM_BRIDGE_OP_DP and wire bridge connectors
Patch 12: Wire the MediaTek DP bridge to the new helpers [untested]

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Kory Maincent (12):
      drm/i915/display/intel_sdvo: Fix double connector destroy in error paths
      drm/i915/display/intel_lvds: Drop redundant manual cleanup on init failure
      drm/i915/display/intel_dp: Drop redundant intel_dp_aux_fini() on init failure
      drm/i915/display: Switch to drmm_mode_config_init() and drop manual cleanup
      drm/i915/display: Switch to managed for crtc
      drm/i915/display: Switch to managed for plane
      drm/i915/display: Switch to managed for encoder
      drm/i915/display: Switch to managed for connector
      drm: Introduce drmm_connector_dp_init() with link training state properties
      drm/i915/display/dp: Adopt dp_connector helpers to expose link training state
      drm/bridge: Wire drmm_connector_dp_init() via new DRM_BRIDGE_OP_DP flag
      drm/mediatek: Use dp_connector helpers to report link training state

 drivers/gpu/drm/Makefile                           |   1 +
 drivers/gpu/drm/display/drm_bridge_connector.c     |  26 +-
 drivers/gpu/drm/drm_dp_connector.c                 | 344 +++++++++++++++++++++
 drivers/gpu/drm/i915/display/g4x_dp.c              |  39 +--
 drivers/gpu/drm/i915/display/g4x_hdmi.c            |  27 +-
 drivers/gpu/drm/i915/display/i9xx_plane.c          |  97 +++---
 drivers/gpu/drm/i915/display/icl_dsi.c             |  50 ++-
 drivers/gpu/drm/i915/display/intel_connector.c     |  26 +-
 drivers/gpu/drm/i915/display/intel_connector.h     |   5 +-
 drivers/gpu/drm/i915/display/intel_crt.c           |  28 +-
 drivers/gpu/drm/i915/display/intel_crtc.c          | 102 +++---
 drivers/gpu/drm/i915/display/intel_cursor.c        |  41 ++-
 drivers/gpu/drm/i915/display/intel_ddi.c           |  64 ++--
 drivers/gpu/drm/i915/display/intel_display.c       |   8 -
 drivers/gpu/drm/i915/display/intel_display.h       |   1 -
 .../gpu/drm/i915/display/intel_display_driver.c    |  37 ++-
 drivers/gpu/drm/i915/display/intel_dp.c            |  43 ++-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  25 ++
 drivers/gpu/drm/i915/display/intel_dp_mst.c        |  33 +-
 drivers/gpu/drm/i915/display/intel_dvo.c           |  43 +--
 drivers/gpu/drm/i915/display/intel_encoder.c       |   6 +-
 drivers/gpu/drm/i915/display/intel_encoder.h       |   3 +-
 drivers/gpu/drm/i915/display/intel_hdmi.c          |  15 +-
 drivers/gpu/drm/i915/display/intel_lvds.c          |  45 ++-
 drivers/gpu/drm/i915/display/intel_plane.c         |  45 +--
 drivers/gpu/drm/i915/display/intel_plane.h         |   5 +-
 drivers/gpu/drm/i915/display/intel_sdvo.c          | 134 +++-----
 drivers/gpu/drm/i915/display/intel_sprite.c        | 119 ++++---
 drivers/gpu/drm/i915/display/intel_tv.c            |  26 +-
 drivers/gpu/drm/i915/display/skl_universal_plane.c | 102 +++---
 drivers/gpu/drm/i915/display/vlv_dsi.c             |  42 +--
 drivers/gpu/drm/mediatek/mtk_dp.c                  |  34 +-
 include/drm/drm_bridge.h                           |  13 +
 include/drm/drm_connector.h                        |  38 +++
 include/drm/drm_dp_connector.h                     | 109 +++++++
 35 files changed, 1125 insertions(+), 651 deletions(-)
---
base-commit: db5a75cfd29766536be62aece9f19c6e7a858fa6
change-id: 20260226-feat_link_cap-20cbb6f31d40

Best regards,
-- 
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

