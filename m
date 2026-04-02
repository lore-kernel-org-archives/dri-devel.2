Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BF161D6AAF0
	for <dri-devel@archiver.kernel.org>; Thu,  2 Apr 2026 16:27:39 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 05F7F10E3F7;
	Thu,  2 Apr 2026 16:27:39 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="x+PV2+1m";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8328010E3F7
 for <dri-devel@lists.freedesktop.org>; Thu,  2 Apr 2026 16:27:37 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id F2BC21A3101;
 Thu,  2 Apr 2026 16:27:35 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id B33E6602CD;
 Thu,  2 Apr 2026 16:27:35 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id AEB5310450283; 
 Thu,  2 Apr 2026 18:27:29 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1775147254; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=231dMFUljBtRP2ObnzQwRUlHPRV5FegZUmPtUy6qqIw=;
 b=x+PV2+1mOOtbFnsV9/nzrpx1si6Eb3lZ7DrmBzTrayVlmrz/2oE/KEdRzQcs2W/6AYFJDu
 wSezKY5rKgc2Dn2aFmJqP1kYssQ2MXHLf4VmrD89vW4CywNvCjQK2bRmabHN8RNrFiGTQa
 zX6Gz96ZzHJ3Td/FtqymkAnVt/eV9wF6gvAR34VcfprQhnl1oDRCH+lGyZ1cpJ13Jl9T+R
 gSntbsSWFMSdcb8rz1GNoVUhgovvAy4hFH1GljyytgEAH+gD2sz50sBqgZLHUcpCuy4bPM
 vGoWcKlpzRaw96PJXeq9wd4AEmDMg8kiEFD55hiOQBcHYURrfchp6tqVnZO9jg==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v4 0/4] drm/bridge: convert users of of_drm_find_bridge(),
 part 4
Date: Thu, 02 Apr 2026 18:27:16 +0200
Message-Id: <20260402-drm-bridge-alloc-getput-drm_of_find_bridge-4-v4-0-421781c8c061@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAOWYzmkC/5XO3QqCQBAF4FeJvW5jZlfNuuo9IsT90wFzYzUpw
 ndvFaGIbrw8Z+A782KdDWQ7dty8WLADdeTbGJLthum6bCvLycTMBIgMEPbchCtXgUy8lE3jNa9
 sf7v3U194VzhqTbHcEw7lQSiZobMHwyJ5C9bRY547X2Kuqet9eM7rA07tMoTZuqEBOXArEyVzl
 4IR+5Pyvm+o3Wl/ZdPUIL54iSt5MfGQo9JGY5L94eWHl5iv5GXkEeLnIhUg0x9+HMc3F+UoOKg
 BAAA=
X-Change-ID: 20260107-drm-bridge-alloc-getput-drm_of_find_bridge-4-0a92b361fe9d
To: Biju Das <biju.das.jz@bp.renesas.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Anitha Chrisanthus <anitha.chrisanthus@intel.com>, 
 Linus Walleij <linusw@kernel.org>, 
 Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>, 
 Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>, 
 Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>, 
 Geert Uytterhoeven <geert+renesas@glider.be>, 
 Magnus Damm <magnus.damm@gmail.com>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, Ian Ray <ian.ray@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org, 
 linux-kernel@vger.kernel.org, Luca Ceresoli <luca.ceresoli@bootlin.com>
X-Mailer: b4 0.15.1
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

This series converts many DRM drivers from the now deprecated
of_drm_find_bridge() to its replacement of_drm_find_and_get_bridge() which
allows correct bridge refcounting.

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
       6. … protect encoder bridge chain with a mutex
       7. ➜ of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
	       convert basic direct users (v7.0-v7.1)
	  b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
	  c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
	  d. ➜ convert direct of_drm_get_bridge() users, part 4
	       (some v7.1, some pending)
	  e.   convert bridge-only drm_of_find_panel_or_bridge() users
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
 5. … Migrate i.MX LCDIF driver to bridge-connector
 6.   DRM bridge hotplug
    A.   Bridge hotplug management in the DRM core
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

This work is a continuation of the work to correctly handle bridge
refcounting for existing of_drm_find_bridge(). The ground work is in:

 - commit 293a8fd7721a ("drm/bridge: add of_drm_find_and_get_bridge()")
 - commit 9da0e06abda8 ("drm/bridge: deprecate of_drm_find_bridge()")
 - commit 3fdeae134ba9 ("drm/bridge: add next_bridge pointer to struct drm_bridge")

The whole conversion is split in multiple series to make the review process
a bit smoother:

 - Part 2: mostly drivers in drivers/gpu/drm/bridge [2], applied
 - Part 3: other drivers, low-medium complexity [3], applied
 - Part 4: other drivers, converting the most complex cases [this series]

[2] https://lore.kernel.org/lkml/20260109-drm-bridge-alloc-getput-drm_of_find_bridge-2-v2-0-8bad3ef90b9f@bootlin.com/
[3] https://lore.kernel.org/lkml/20260109-drm-bridge-alloc-getput-drm_of_find_bridge-3-v2-0-8d7a3dbacdf4@bootlin.com/

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v4:
- Patch 3: many improvements as suggested by Laurent
- Patch 1: add comment after Laurent's suggestion on patch 3
- Link to v3: https://lore.kernel.org/r/20260318-drm-bridge-alloc-getput-drm_of_find_bridge-4-v3-0-10f502520357@bootlin.com

Changes in v3:
- Rebased on current drm-misc-next (on v7.0-rc3)
- Dropped patches already applied
- Link to v2: https://lore.kernel.org/r/20260131-drm-bridge-alloc-getput-drm_of_find_bridge-4-v2-0-e081bcdc1467@bootlin.com

Changes in v2:
- Removed bouncing recipient: Edmund Dea <edmund.j.dea@intel.com>
- used break instead of a warning patch 3, adapted patch 4 as a
  consequence
- Link to v1: https://lore.kernel.org/r/20260116-drm-bridge-alloc-getput-drm_of_find_bridge-4-v1-0-e34b38f50d27@bootlin.com

---
Luca Ceresoli (4):
      drm: renesas: rz-du: rzg2l_du_encoder: convert to of_drm_find_and_get_bridge()
      drm/kmb/dsi: convert to of_drm_find_and_get_bridge()
      drm: rcar-du: encoder: convert to of_drm_find_and_get_bridge()
      drm/omap: dss: convert to of_drm_find_and_get_bridge()

 drivers/gpu/drm/kmb/kmb_dsi.c                     |  2 +-
 drivers/gpu/drm/omapdrm/dss/output.c              | 11 +++++--
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.c | 35 +++++++++++++++++++----
 drivers/gpu/drm/renesas/rcar-du/rcar_du_encoder.h |  1 +
 drivers/gpu/drm/renesas/rcar-du/rcar_du_kms.c     |  2 ++
 drivers/gpu/drm/renesas/rz-du/rzg2l_du_encoder.c  | 19 +++++++++---
 6 files changed, 56 insertions(+), 14 deletions(-)
---
base-commit: 3bb828758df6ad0fd40e63fa2372eb896c9a7199
change-id: 20260107-drm-bridge-alloc-getput-drm_of_find_bridge-4-0a92b361fe9d

Best regards,
--  
Luca Ceresoli <luca.ceresoli@bootlin.com>

