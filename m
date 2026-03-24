Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 2D282F54AAA
	for <dri-devel@archiver.kernel.org>; Tue, 24 Mar 2026 13:07:51 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9B9B10E576;
	Tue, 24 Mar 2026 13:07:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=bootlin.com header.i=@bootlin.com header.b="lasowkfk";
	dkim-atps=neutral
Received: from smtpout-02.galae.net (smtpout-02.galae.net [185.246.84.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 5CBCE10E13D;
 Tue, 24 Mar 2026 13:07:48 +0000 (UTC)
Received: from smtpout-01.galae.net (smtpout-01.galae.net [212.83.139.233])
 by smtpout-02.galae.net (Postfix) with ESMTPS id DDDA51A2FC5;
 Tue, 24 Mar 2026 13:07:46 +0000 (UTC)
Received: from mail.galae.net (mail.galae.net [212.83.136.155])
 by smtpout-01.galae.net (Postfix) with ESMTPS id A0D5C6011D;
 Tue, 24 Mar 2026 13:07:46 +0000 (UTC)
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon)
 with ESMTPSA id D3F4110451273; Tue, 24 Mar 2026 14:07:33 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=dkim;
 t=1774357664; h=from:subject:date:message-id:to:cc:mime-version:content-type:
 content-transfer-encoding; bh=oz2n6EGzzohxeupK2HnEka+WLJWsM35paHY/3OjrXOI=;
 b=lasowkfkGR1jPvF44IgZjk2NBlO2y0FNCjB+SkEGW4alIwhrJQJfOPfZzMT4yUoQhUMzqg
 K7MGJqRyFTlm/3+Pi3fRvYQosVj3YHVev4QC+4Y/8yxtUk4ax7bhwO3OKXCCXSPvtrp2mi
 zmPXG6uFwucE3VMM9yWvSJPOVnrTmg6IjswG6i29GemocuisliWWSi7aKzPUNzRhYDSa8f
 IitiYmZuesN+f8nAm4yFp2dabTZELhgIOSfVmsFKSMB6owRGcHaUT4RXTIII13a4LE/inW
 K3GZWVpEB/O+2XIxmxOOlUpfdbFgIBhC0HZG0hpd6AFQFnsqDuAQl9xEji1eJA==
From: Luca Ceresoli <luca.ceresoli@bootlin.com>
Subject: [PATCH v3] drm/atomic: protect bridge private_obj during bridge
 removal
Date: Tue, 24 Mar 2026 14:07:29 +0100
Message-Id: <20260324-drm-bridge-atomic-vs-remove-private_obj-v3-0-64deefe84044@bootlin.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-B4-Tracking: v=1; b=H4sIAJGMwmkC/5WQy07DMBBFfyXymkEeu0mcrvgPhJAfEzoIx8U2F
 qjqv+O2G9jB8s6VztGdkyiUmYrYDyeRqXHhtPWg7wbhD3Z7IeDQs1BSjShRQ8gRXObQG1tTZA+
 tQKaYGsExc7OVnpN7hTAvysjRkQtedNox08qfV9PjU88HLjXlr6u44eX6f0dDkICrVzQalIrkg
 0upvvF271MUF0tTP8gK/05WgLBDZdHoZXHW/yafb4MyvX/0j9XbKuFsIeh95LofZrJyNxltunb
 yKN2sJ63dMk9Ba1qt8aiCnscOO38DQlj9HYYBAAA=
X-Change-ID: 20251013-drm-bridge-atomic-vs-remove-private_obj-d792805bebdc
To: Harry Wentland <harry.wentland@amd.com>, Leo Li <sunpeng.li@amd.com>, 
 Rodrigo Siqueira <siqueira@igalia.com>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>, 
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>, 
 Liviu Dudau <liviu.dudau@arm.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Maxime Ripard <mripard@kernel.org>, Thomas Zimmermann <tzimmermann@suse.de>, 
 Andrzej Hajda <andrzej.hajda@intel.com>, 
 Neil Armstrong <neil.armstrong@linaro.org>, Robert Foss <rfoss@kernel.org>, 
 Laurent Pinchart <Laurent.pinchart@ideasonboard.com>, 
 Jonas Karlman <jonas@kwiboo.se>, Jernej Skrabec <jernej.skrabec@gmail.com>, 
 Paul Cercueil <paul@crapouillou.net>, 
 Rob Clark <robin.clark@oss.qualcomm.com>, 
 Dmitry Baryshkov <lumag@kernel.org>, 
 Abhinav Kumar <abhinav.kumar@linux.dev>, Sean Paul <sean@poorly.run>, 
 Marijn Suijten <marijn.suijten@somainline.org>, 
 Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Mikko Perttunen <mperttunen@nvidia.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Dave Stevenson <dave.stevenson@raspberrypi.com>, 
 =?utf-8?q?Ma=C3=ADra_Canal?= <mcanal@igalia.com>, 
 Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: Hui Pu <Hui.Pu@gehealthcare.com>, 
 Thomas Petazzoni <thomas.petazzoni@bootlin.com>, 
 amd-gfx@lists.freedesktop.org, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, linux-mips@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, freedreno@lists.freedesktop.org, 
 linux-tegra@vger.kernel.org, Ian Ray <ian.ray@gehealthcare.com>, 
 Luca Ceresoli <luca.ceresoli@bootlin.com>
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

This series prevents a race between DRM bridge removal and usage of the
bridge private_obj during DRM_MODESET_LOCK_ALL_BEGIN/END() and other
locking operations.

== Series description

The need for this series emerged during testing of DRM bridge
hot-plugging. Very rarely on hot-unplug the following warning has appeared:

  WARNING: CPU: 0 PID: 123 at include/drm/drm_modeset_lock.h:114 drm_atomic_private_obj_fini+0x64/0x80
  ...
  Call trace:
   drm_atomic_private_obj_fini+0x64/0x80
   drm_bridge_detach+0x38/0x98

This series does not depend on other series.

== Grand plan

This is part of the work to support hotplug of DRM bridges. The grand plan
was discussed in [0].

Here's the work breakdown (➜ marks the current series):

 1. … add refcounting to DRM bridges struct drm_bridge,
      based on devm_drm_bridge_alloc()
    A. ✔ add new alloc API and refcounting (v6.16)
    B. ✔ convert all bridge drivers to new API (v6.17)
    C. ✔ kunit tests (v6.17)
    D. ✔ add get/put to drm_bridge_add/remove() + attach/detach()
         and warn on old allocation pattern (v6.17)
    E. … add get/put on drm_bridge accessors
       1. ✔ drm_bridge_chain_get_first_bridge(), add cleanup action (v6.18)
       2. ✔ drm_bridge_get_prev_bridge() (v6.18)
       3. ✔ drm_bridge_get_next_bridge() (v6.19)
       4. ✔ drm_for_each_bridge_in_chain() (v6.19)
       5. ✔ drm_bridge_connector_init (v6.19)
       6. … protect encoder bridge chain with a mutex
       7. … of_drm_find_bridge
          a. ✔ add of_drm_get_bridge() (v7.0),
	       convert basic direct users (v7.0-v7.1)
	  b. ✔ convert direct of_drm_get_bridge() users, part 2 (v7.0)
	  c. ✔ convert direct of_drm_get_bridge() users, part 3 (v7.0)
	  d. ✔… convert direct of_drm_get_bridge() users, part 4
	        (some v7.1, some pending)
	  e.   convert bridge-only drm_of_find_panel_or_bridge() users
       8. drm_of_find_panel_or_bridge, *_of_get_bridge
       9. ✔ enforce drm_bridge_add before drm_bridge_attach (v6.19)
    F. ✔ debugfs improvements
       1. ✔ add top-level 'bridges' file (v6.16)
       2. ✔ show refcount and list lingering bridges (v6.19)
 2. ➜ handle gracefully atomic updates during bridge removal
    A. ✔ Add drm_bridge_enter/exit() to protect device resources (v7.0)
    B. ➜ protect private_obj removal from list
    C. ✔ Add drm_bridge_clear_and_put() (v7.1)
 3. … DSI host-device driver interaction
 4. ✔ removing the need for the "always-disconnected" connector
 5. … Migrate i.MX LCDIF driver to bridge-connector
 6.   DRM bridge hotplug
    A.   Bridge hotplug management in the DRM core
    B.   Device tree description

[0] https://lore.kernel.org/lkml/20250206-hotplug-drm-bridge-v6-0-9d6f2c9c3058@bootlin.com/#t

Signed-off-by: Luca Ceresoli <luca.ceresoli@bootlin.com>
---
Changes in v3:
- Rebased on current drm-misc-next (on 7.0-rc3)
- Small commit message clarification
- Link to v2: https://lore.kernel.org/r/20251021-drm-bridge-atomic-vs-remove-private_obj-v2-1-412a18399bac@bootlin.com

Changes in v2:
- Adapted to work on top of "drm/atomic: Add dev pointer to drm_private_obj"
- Removed 'To: jessica.zhang@oss.qualcomm.com', invalid address
- Link to v1: https://lore.kernel.org/r/20251013-drm-bridge-atomic-vs-remove-private_obj-v1-0-1fc2e58102e0@bootlin.com

---
Luca Ceresoli (1):
      drm/atomic: drm_atomic_private_obj_fini: protect private_obj removal from list

 drivers/gpu/drm/drm_atomic.c | 6 ++++++
 1 file changed, 6 insertions(+)
---
base-commit: 7ea0468380216c10b73633b976d33efa8c12d375
change-id: 20251013-drm-bridge-atomic-vs-remove-private_obj-d792805bebdc

Best regards,
--  
Luca Ceresoli <luca.ceresoli@bootlin.com>

