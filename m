Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 31344CD37BE
	for <dri-devel@archiver.kernel.org>; Mon, 11 May 2026 16:40:33 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 8EA9110E1B1;
	Mon, 11 May 2026 16:40:32 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="16EJVQdW";
	dkim-atps=neutral
Received: from smtpout-03.galae.net (smtpout-03.galae.net [185.246.85.4])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABF910E1B1;
 Mon, 11 May 2026 16:40:31 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-03.galae.net (Postfix) with ESMTPS id 3CE2E4E42BF3;
 Mon, 11 May 2026 16:40:30 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id 0383060646;
 Mon, 11 May 2026 16:40:30 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id EF8DB11AF9F70; 
 Mon, 11 May 2026 18:40:17 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1778517628; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=58INz79bQ8VewatGOMRDf2JQ9ssQ32yAiWDpAQl1j6k=;
 b=16EJVQdWMK0IfMwBbRlS3dRFXi/xxt3XgVDZD5LlEpMvrSs6tmj94PMl2L1pxD5BYdCblo
 H9A8otN/olkHXdXEoqhwyQXHNQzJC2/D96akWuMjwjaa0thQTuMW5zzrjxBON5ZBN2p10d
 XwBfcVzUafyB8EMB0RM/7ppcXSLE73yC6T/gM1LfTnleyhwKppR3n1S6qEzdbVCRymQLEs
 m7cPpFUhZhoJviDzd/OAJgRSVgziV2HvCxsFvNlUpbh/646jJpEkwK9oeWO4lG/vzC3Cfv
 0cCfRk7MTWC9gPG9kjdScxCRp4u6Di/t0cGGP7DR/vululNBvPjlJpIVJ1uCdQ==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v6 00/11] drm/bridge: handle refcounting for bridge-only
 callers of drm_of_find_panel_or_bridge()
Date: Mon, 11 May 2026 18:40:04 +0200
Message-Id: <20260511-drm-bridge-alloc-getput-panel_or_bridge-v6-0-f61c9e498b3f@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAGUGAmoC/53Qy07DMBAF0F+pvMZo/IpTVvwHQtX4kdYojSM7j
 UBV/h27gKjIJmJ5NaNzR3Ml2afgM3naXUnyc8ghDiU0DztiTzgcPQ2uZMKBNyAZUJfO1KTgygT
 7Plp69NN4meiIg+8PMR2+h5IrYEa0HtGRoo3Jd+H91vTy+pXzxbx5O1W+bpxCnmL6uJ0ys7r30
 yo2t86MAkXrgFmn98i6ZxPj1Ifh0cYzqb0zv5N5u13mRZYCQEuJzEq9lsU/ZVFvVkIbpRqNzq1
 l+SsrkNtlWWSjdGuFQ+wYrGV1L+vtsqrf0NzsmTDKmj/fWJblE/4ALP9aAgAA
X-Change-ID: 20260410-drm-bridge-alloc-getput-panel_or_bridge-42501b38eaad
To: Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, 
 Jessica Zhang <jesszhan0024@gmail.com>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Sumit Semwal <sumit.semwal@linaro.org>, John Stultz <jstultz@google.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Michal Simek <michal.simek@amd.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-arm-kernel@lists.infradead.org, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>, 
 Laurent Pinchart <laurent.pinchart@ideasonboard.com>, 
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Biju Das <biju.das.jz@bp.renesas.com>
X-Mailer: b4 0.15.2
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

This series converts all the bridge-only callers of the deprecated
drm_of_find_panel_or_bridge() API to a new, simpler API that handles bridge
refcounting.

All patches acked/reviewed except patches 3 and 4.

== Series description

 * Patch 1 (new in v2) makes drm_bridge_put() ignore ERR_PTR pointers,
   not only NULL pointers
 * Patch 2 introduces of_drm_get_bridge_by_endpoint() as a replacement for
   bridge-only calls to drm_of_find_panel_or_bridge(); the new function
   refcounts the bridge and is simpler
 * The following patches convert all bridge-only users to the new API
 * The last patch forbids new bridge-only calls to
   drm_of_find_panel_or_bridge()

== Grand plan

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [0].

Here's the work breakdown (➜ marks the current series):

 1. ➜ add refcounting to DRM bridges struct drm_bridge,
      based on devm_drm_bridge_alloc()
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. ➜ add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. ✔ protect encoder bridge chain with a mutex (v7.2)
       7. ➜ of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
               convert basic direct users (v7.0-v7.1)
          b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
          c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
          d. ✔ convert direct of_drm_get_bridge() users, part 4 (v7.1-v7.2)
          e. ➜ convert bridge-only drm_of_find_panel_or_bridge() users
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ✔ enforce drm_bridge_add before drm_bridge_attach (v6.19)
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list lingering bridges (v6.19)
 2. … handle gracefully atomic updates during bridge removal
    A. ✔ Add drm_bridge_enter/exit() to protect device resources (v7.0)
    B. … protect private_obj removal from list
    C. ✔ Add drm_bridge_clear_and_put() (v7.1)
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. ✔ Migrate i.MX LCDIF driver to bridge-connector (v7.2)
 6. … DRM bridge hotplug
    A. … Bridge hotplug management in the DRM core
       1. ✔ bridge-connector: attach encoder to the connector (v7.2)
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v6:
- Patch 2: fix warning in the no-OF case 
- Patch 3: fix too-late next_bridge assignment
- Link to v5: https://patch.msgid.link/20260507-drm-bridge-alloc-getput-panel_or_bridge-v5-0-472b913b5cb7@bootlin.com

Changes in v5:
- Patch 1: change drm_bridge_put() only
- Patches 3,10: simplify error management code flow
- Link to v4: https://patch.msgid.link/20260504-drm-bridge-alloc-getput-panel_or_bridge-v4-0-b578c3daaf10@bootlin.com

Changes in v4:
- Fixed patches 3 and 10
- Minor fixes to patches 1 and 2
- Removed bouncing addresses yongqin.liu@linaro.org and
  xinliang.liu@linaro.org from Cc
- Link to v3: https://patch.msgid.link/20260428-drm-bridge-alloc-getput-panel_or_bridge-v3-0-a537b5567add@bootlin.com

Changes in v3:
- patch 3, 8, 10: fixed ERR_PTR deref in the -ENODEV case, and removed
  Dmitry's R-by from those patches as they are changed
- Added review trailers to the other patches
- Link to v2: https://patch.msgid.link/20260428-drm-bridge-alloc-getput-panel_or_bridge-v2-0-4300744a1c47@bootlin.com

Changes in v2:
- Added patch to ignore ERR_PTR values in drm_bridge_get/put()
- Changed API to return the bridge (or a ERR_PTR) in the return value,
  not as a double-pointer output parameter
- Adapted all patches to the new API, dropped Dmitry's review tags as the
  patches are all modified
- Removed bouncing addresses from Cc list
- Link to v1: https://patch.msgid.link/20260413-drm-bridge-alloc-getput-panel_or_bridge-v1-0-acd01cd79a1f@bootlin.com

---
Luca Ceresoli (11):
      drm/bridge: drm_bridge_put(): ignore ERR_PTR
      drm/bridge: add of_drm_get_bridge_by_endpoint()
      drm/msm/hdmi: switch to of_drm_get_bridge_by_endpoint()
      drm/hisilicon/kirin: switch to of_drm_get_bridge_by_endpoint()
      drm/bridge: chrontel-ch7033: switch to of_drm_get_bridge_by_endpoint()
      drm/bridge: lontium-lt9611uxc: switch to of_drm_get_bridge_by_endpoint()
      drm/bridge: lt9611: switch to of_drm_get_bridge_by_endpoint()
      drm/bridge: adv7511: switch to of_drm_get_bridge_by_endpoint()
      drm/bridge: lt8713sx: switch to of_drm_get_bridge_by_endpoint()
      drm: zynqmp_dp: switch to of_drm_get_bridge_by_endpoint()
      drm: of: forbid bridge-only calls to drm_of_find_panel_or_bridge()

 drivers/gpu/drm/bridge/adv7511/adv7511.h     |  1 -
 drivers/gpu/drm/bridge/adv7511/adv7511_drv.c | 15 +++---
 drivers/gpu/drm/bridge/chrontel-ch7033.c     | 28 ++++++-----
 drivers/gpu/drm/bridge/lontium-lt8713sx.c    | 10 ++--
 drivers/gpu/drm/bridge/lontium-lt9611.c      |  9 ++--
 drivers/gpu/drm/bridge/lontium-lt9611uxc.c   |  9 ++--
 drivers/gpu/drm/drm_bridge.c                 | 45 +++++++++++++++++-
 drivers/gpu/drm/drm_of.c                     | 26 +++++------
 drivers/gpu/drm/hisilicon/kirin/dw_drm_dsi.c |  9 ++--
 drivers/gpu/drm/msm/hdmi/hdmi.c              | 70 +++++++++++++++++++---------
 drivers/gpu/drm/xlnx/zynqmp_dp.c             | 19 ++++----
 include/drm/drm_bridge.h                     |  7 +++
 12 files changed, 162 insertions(+), 86 deletions(-)
---
base-commit: 7af78cfbe2b47cd9ecb61480fb74d64b584d8a94
change-id: 20260410-drm-bridge-alloc-getput-panel_or_bridge-42501b38eaad

Best regards,
--  
Luca Ceresoli, Bootlin
Embedded Linux and Kernel engineering
https://bootlin.com

