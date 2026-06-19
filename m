Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9B4A1CD4F26
	for <dri-devel@archiver.kernel.org>; Fri, 19 Jun 2026 14:08:56 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id F18DB10F619;
	Fri, 19 Jun 2026 14:08:55 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="dH0ACJym";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 6C68C10F616;
 Fri, 19 Jun 2026 14:08:55 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id 005FF1A3A20;
 Fri, 19 Jun 2026 14:08:54 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id C20C9601AD;
 Fri, 19 Jun 2026 14:08:53 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id 6A8E2106C8254; 
 Fri, 19 Jun 2026 16:08:43 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1781878132; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=XDkYpT+SCUd0m5Nj+gLnQpV+dZe6iTEpcMwnamD4vLs=;
 b=dH0ACJymmzk11uAEx0D/J4vHZvgWP2WRKaYt4kTgXxDW2J3XCzlxS87GEGm1sUB0RVH2tG
 d7UUkCyA8yhn0Rf9PkBvbtQcy8/paxGCX2NvAEY/vg2ovUkBmhEKPzHK9awWaFYFMuS9u5
 +7fERE7deqvf++LWoXM5rX6Pw1gCnm2PtMSZgCzd4s5LZRGjnzkyCjCPjdMABUf7xe5FvR
 CoONM4e3FywLalg4CkKyQnTQew9N6yIxOu9KbsYyCGBpRYXMt17LEJ3iIcKemJFv9fzeZt
 2Rw2CsviOe+YdT7MHWmGJAaEmMaBTWaTKQK1hBaw+Tm2XwSXBsiugUbFOwcRVA==
From: Kory Maincent <kory.maincent@bootlin.com>
Subject: [PATCH RFC v2 0/4] Add support for DisplayPort link training
 information report
Date: Fri, 19 Jun 2026 16:08:42 +0200
Message-Id: <20260619-feat_link_cap-v2-0-a3dec4c02ad9@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGpNNWoC/12NwQrCMBBEf6Xs2chmLdF4EgQ/wKuU0qZbXdSmJ
 KUopf9uyNHjzGPeLBA5CEc4FgsEniWKH1KgTQHu0Qx3VtKlDIRkkMionpupfsnwrF0zKkLXtqb
 f6a5ESJsxcC+f7LvB9XKGKpUPiZMP3/wx64yyrkT7p5u1QrVHY/mgrXVMp9b7KeGt82+o1nX9A
 biHlSaxAAAA
X-Change-ID: 20260226-feat_link_cap-20cbb6f31d40
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Rodrigo Vivi <rodrigo.vivi@intel.com>, 
 Joonas Lahtinen <joonas.lahtinen@linux.intel.com>, 
 Tvrtko Ursulin <tursulin@ursulin.net>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Chun-Kuang Hu <chunkuang.hu@kernel.org>, 
 Philipp Zabel <p.zabel@pengutronix.de>, 
 Matthias Brugger <matthias.bgg@gmail.com>, 
 AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, Daniel Stone <daniels@collabora.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 Mark Yacoub <markyacoub@google.com>, Sean Paul <seanpaul@google.com>, 
 Manasi Navare <navaremanasi@google.com>, 
 Drew Davenport <ddavenport@google.com>, 
 Louis Chauvet <louis.chauvet@bootlin.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, intel-gfx@lists.freedesktop.org, 
 intel-xe@lists.freedesktop.org, linux-mediatek@lists.infradead.org, 
 linux-arm-kernel@lists.infradead.org, 
 Kory Maincent <kory.maincent@bootlin.com>
X-Mailer: b4 0.15.0
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
for a reliable connection: lane count, link rate, and optionally Display
Stream Compression (DSC). Currently, each driver exposes this state in
its own way, often through driver-specific debugfs entries, with no
standard interface for userspace diagnostic and monitoring tools.

This series introduces generic, managed and unmanaged DisplayPort
connector initialization helpers, for exposing DP link capabilities and
state as standard sysfs entries, modeled after the existing HDMI helper
drmm_connector_hdmi_init().

The aim of such development is to guide users to select the most suitable
DisplayPort connector for their needs. For example, if you have a USB-C
hub with lesser capabilities than your computer’s native DisplayPort
connector (such as HBR2 versus HBR3 support), the system could recommend
connecting high-resolution displays directly to the computer’s port
instead of through the hub to ensure optimal performance.

These new drmm_connector_dp_init() and drm_connector_dp_init_with_ddc()
helpers initialize a DP connector and expose link training capabilities
and state to userspace via sysfs attributes under dp_link.

Additional helpers are provided to manage link capabilities and parameters
at runtime.

Two drivers are updated as reference implementations: i915 (direct
connector path) and MediaTek (via the bridge connector framework using a
new DRM_BRIDGE_OP_DP flag).

The changes updating the i915 driver to use DRM managed resources have been
removed due to cleanup path issues. The core problem is that some functions
do not consistently propagate errors through their call paths (whether this
is intentional or not) making it difficult to properly handle cleanup of
DRM objects (planes, encoders, connectors). A potential solution would be
to implement something similar to devres_group for each DRM object type,
but this represents a substantial undertaking that falls outside the scope
of this patch series.

The MST case in i915 driver is not supported yet.

Patch 1: Introduce the core drmm_connector_dp_init() framework
Patch 2: Wire the i915 DP connector to use the new helpers
Patch 3: Introduce DRM_BRIDGE_OP_DP and wire bridge connectors
Patch 4: Wire the MediaTek DP bridge to the new helpers [untested]

Signed-off-by: Kory Maincent <kory.maincent@bootlin.com>
---
Changes in v2:
- Removed work converting i915 to DRM managed resource
- Remove voltage swing and pre-emphasis properties
- Expose link training state via sysfs dp_link/ group instead of
  connector properties
- Add comprehensive sysfs attributes for both source and sink capabilities
- Add new helpers for managing sink capabilities and for current link
  parameters
- Link to v1: https://lore.kernel.org/r/20260409-feat_link_cap-v1-0-7069e8199ce2@bootlin.com

---
Kory Maincent (4):
      drm: Introduce DisplayPort connector helpers with link training state
      drm/i915/display/dp: Adopt dp_connector helpers to expose link training state
      drm/bridge: Wire drmm_connector_dp_init() via new DRM_BRIDGE_OP_DP flag
      drm/mediatek: Use dp_connector helpers to report link training state

 drivers/gpu/drm/display/drm_bridge_connector.c     |  24 ++++
 drivers/gpu/drm/display/drm_dp_helper.c            | 144 +++++++++++++++++++++
 drivers/gpu/drm/drm_connector.c                    | 122 +++++++++++++++++
 drivers/gpu/drm/drm_sysfs.c                        | 100 ++++++++++++++
 drivers/gpu/drm/i915/display/intel_dp.c            |  26 +++-
 .../gpu/drm/i915/display/intel_dp_link_training.c  |  17 +++
 drivers/gpu/drm/mediatek/mtk_dp.c                  |  23 ++++
 include/drm/display/drm_dp_helper.h                |   7 +
 include/drm/drm_bridge.h                           |  13 ++
 include/drm/drm_connector.h                        | 105 +++++++++++++++
 10 files changed, 577 insertions(+), 4 deletions(-)
---
base-commit: 4d75f8bd845c10f126e0e66bcdd264e1f9772bde
change-id: 20260226-feat_link_cap-20cbb6f31d40

Best regards,
--  
Köry Maincent, Bootlin
Embedded Linux and kernel engineering
https://bootlin.com

