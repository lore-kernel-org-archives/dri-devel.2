Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E436B6072C54
	for <dri-devel@archiver.kernel.org>; Mon,  2 Nov 2026 16:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=BB62gHzL
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 54E9C10F09A;
	Mon,  2 Nov 2026 16:49:35 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 8A2D310F0B3;
 Mon,  2 Nov 2026 16:49:29 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 598E9429DE;
 Mon,  2 Nov 2026 16:49:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9151E1F00A17;
 Mon,  2 Nov 2026 16:49:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793638169;
 bh=MeedEfZsFXsP5qo2iaurGBLApo5iEvSj6gKmWJRvO/A=;
 h=From:Subject:Date:To:Cc;
 b=BB62gHzL5S97E9XvJYB4smDYnpHNqlxvxahS6WU2szl1/FNeEz43DsW74XPCqPr98
 sdhrvyqz06mInyozpQwXvvwAcxepFngu4ypP5wqOAOdpDoyKfICilM0ClliISj1wqL
 WYq0/71ap7b5bwdiUb2A3tWwLwOppwQhSkMeFzW6boc/1khLdXx8+G1z/uNTViCTf3
 BWe187Hx/m7h4ucTM0DMx5sOBI53FU04Vq3H+5X6vvX3GUcRSRW2Qt++ilUCDFkJJy
 Vy/Buh+pa1OaO+TLi3bmLVBSh5bRa5ehBIn3Kz7nZaCaQYAI7feDBUX/DwevEpwmCB
 bO1cq4159riWQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v10 00/15] Add support for a DRM backlight capability
Date: Mon, 02 Nov 2026 10:49:16 -0600
Message-Id: <20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMTQ6CMBBA4auQWTtJpyEmehXjoi0jjD/QzBQjI
 dydqsv3Ft8KxipscG5WUH6LyTTWIHdoIA1h7BmlqwO880ciR2hzZn0RxpAeT+mHglmnusqCxHy
 KFNro2w4qkJVv8vnpl+u/bY53TuUrwrbtqRIDaH8AAAA=
X-Change-ID: 20261101-superm1-backlight-property-1ee9b1a4b24d
To: Maxime Ripard <mripard@kernel.org>, 
 Alex Deucher <alexander.deucher@amd.com>, 
 Jani Nikula <jani.nikula@linux.intel.com>, 
 Javier Martinez Canillas <javierm@redhat.com>, 
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>, 
 Thomas Zimmermann <tzimmermann@suse.de>, David Airlie <airlied@gmail.com>, 
 Simona Vetter <simona@ffwll.ch>, Harry Wentland <harry.wentland@amd.com>, 
 Leo Li <sunpeng.li@amd.com>, Rodrigo Siqueira <siqueira@igalia.com>
Cc: Mario Limonciello <superm1@kernel.org>, 
 Xaver Hugl <xaver.hugl@gmail.com>, dri-devel@lists.freedesktop.org, 
 linux-kernel@vger.kernel.org, amd-gfx@lists.freedesktop.org, 
 intel-gfx@lists.freedesktop.org, intel-xe@lists.freedesktop.org, 
 nouveau@lists.freedesktop.org, 
 Mario Limonciello <mario.limonciello@amd.com>
X-Mailer: b4 0.16.0
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
X-Spam-Status: No, score=-23.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

At Display Next Hackfest 2026 we reviewed progress moving brightness
control into the DRM connector properties.

There is a range LUMINANCE property that will default to 0->0.
Once a driver attaches a backlight it will be updated to 1->max.
If the panel supports the minimum backlight turning off the display
the range can later be updated to 0->max instead of 1->max.

Version 8 had a lot of review feedback, and the biggest change is that
this no longer has the legacy sysfs interface for brightness control.

There is a Kconfig knob introduced that turns on the new API, and when
the new API is available all drivers will conflict with the old backlight
control API.

This will allow us to land the new brightness control API and the transition
to the new API separately.  *This series only tracks the new API itself.*

The following compositors have implemented matching support, although they
need to be changed again for items modified in v10 (the dropped cap):
 * Kwin: https://invent.kde.org/plasma/kwin/-/merge_requests/9298
 * Mutter: https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop
 * Wlroots: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5384

I've tested this series using modetest on amdgpu.

The series is also available on this branch for easy testing.

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v10

Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Changes in v10:

* Split patch 7 (panel/bridge connector luminance forwarding) into three
   separate patches:
  - drm/bridge: add connector luminance operations
  - drm/panel: add connector luminance forwarding
  - drm/bridge_connector: add luminance support
 * Dropped MIPI-DBI tiny driver migrations and the new mipi_dbi connector
   luminance helpers (Javier): backlight is always NULL when
   CONFIG_BACKLIGHT_CLASS_DEVICE is disabled, so these drivers can't
   support LUMINANCE without DT binding changes or a new
   CONFIG_BACKLIGHT_SYSFS option. Will revisit later.
 * Added IS_ENABLED(CONFIG_DRM_LUMINANCE) conditional guards to all
   individual DRM driver patches that call drm_connector_attach_luminance_property()
 * Moved the LUMINANCE property patch after the new "Add support for a
   DRM backlight capability" patch to better separate backlight vs
   luminance functionality
 * Link to v9: https://lore.kernel.org/dri-devel/20261002190030.211356-1-mario.limonciello@amd.com/

To: Maxime Ripard <mripard@kernel.org>
To: Alex Deucher <alexander.deucher@amd.com>
To: Jani Nikula <jani.nikula@linux.intel.com>
To: Javier Martinez Canillas <javierm@redhat.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Harry Wentland <harry.wentland@amd.com>
To: Leo Li <sunpeng.li@amd.com>
To: Rodrigo Siqueira <siqueira@igalia.com>
Cc: Xaver Hugl <xaver.hugl@gmail.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: intel-gfx@lists.freedesktop.org
Cc: intel-xe@lists.freedesktop.org
Cc: nouveau@lists.freedesktop.org

---
Mario Limonciello (13):
      drm: add connector LUMINANCE property
      drm/amd/display: Pass up errors reading actual brightness
      drm/amd: add luminance property support
      drm/i915/display: add luminance property support
      drm/bridge: add connector luminance operations
      drm/panel: add connector luminance forwarding
      drm/bridge_connector: add luminance support
      drm/nouveau: add connector luminance support
      drm/gud: add connector luminance support
      drm/radeon: add connector luminance support
      drm/gma500: add connector luminance support
      drm/bridge: add PS8622 connector luminance support
      drm/solomon: add SSD130x connector luminance support

Mario Limonciello (AMD) (2):
      drm/amdgpu: Check bios_scratch_reg_offset in backlight level helper
      drm/amd/display: update KUnit luminance fixtures

 drivers/gpu/drm/Kconfig                            |  14 +++
 drivers/gpu/drm/amd/amdgpu/Kconfig                 |   2 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   7 +-
 drivers/gpu/drm/amd/amdgpu/amdgpu_connectors.c     |  20 ++++
 drivers/gpu/drm/amd/amdgpu/atombios_encoders.c     |  17 +++-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  22 +++--
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  55 +++++++++--
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   4 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   7 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  47 +++++++--
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   7 +-
 drivers/gpu/drm/bridge/Kconfig                     |   2 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |  45 ++++++---
 drivers/gpu/drm/display/drm_bridge_connector.c     |  48 +++++++++
 drivers/gpu/drm/drm_atomic_helper.c                |  73 +++++++++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c          |   7 ++
 drivers/gpu/drm/drm_atomic_uapi.c                  |   5 +
 drivers/gpu/drm/drm_connector.c                    |  57 +++++++++++
 drivers/gpu/drm/drm_panel.c                        |  99 +++++++++++++++++--
 drivers/gpu/drm/gma500/Kconfig                     |   2 +-
 drivers/gpu/drm/gma500/backlight.c                 |  45 ++++++---
 drivers/gpu/drm/gma500/cdv_intel_lvds.c            |   2 +
 drivers/gpu/drm/gma500/psb_drv.c                   |   2 +-
 drivers/gpu/drm/gma500/psb_drv.h                   |   4 +-
 drivers/gpu/drm/gma500/psb_intel_lvds.c            |   3 +-
 drivers/gpu/drm/gud/Kconfig                        |   2 +-
 drivers/gpu/drm/gud/gud_connector.c                |  48 ++++++++-
 drivers/gpu/drm/i915/Kconfig                       |   2 +-
 drivers/gpu/drm/i915/display/icl_dsi.c             |   1 +
 drivers/gpu/drm/i915/display/intel_backlight.c     |  20 ++++
 drivers/gpu/drm/i915/display/intel_backlight.h     |   1 +
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   1 +
 drivers/gpu/drm/i915/display/intel_lvds.c          |   1 +
 drivers/gpu/drm/i915/display/intel_panel.c         |   8 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |   1 +
 drivers/gpu/drm/nouveau/Kconfig                    |   4 +-
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |   2 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        | 110 +++++++++++++++++----
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   2 +
 drivers/gpu/drm/nouveau/nouveau_connector.h        |  14 +++
 drivers/gpu/drm/radeon/Kconfig                     |   2 +-
 drivers/gpu/drm/radeon/atombios_encoders.c         |  32 +++++-
 drivers/gpu/drm/radeon/radeon_connectors.c         |  34 +++++++
 drivers/gpu/drm/radeon/radeon_legacy_encoders.c    |  49 +++++++--
 drivers/gpu/drm/radeon/radeon_mode.h               |   2 +
 drivers/gpu/drm/solomon/Kconfig                    |   2 +-
 drivers/gpu/drm/solomon/ssd130x.c                  |  79 +++++++++++----
 drivers/gpu/drm/tests/drm_connector_test.c         |  28 ++++++
 drivers/gpu/drm/xe/Kconfig                         |   2 +-
 include/drm/drm_atomic_helper.h                    |   3 +
 include/drm/drm_bridge.h                           |  74 ++++++++++++++
 include/drm/drm_connector.h                        |  16 +++
 include/drm/drm_modeset_helper_vtables.h           |  25 +++++
 include/drm/drm_panel.h                            |  39 +-------
 55 files changed, 1030 insertions(+), 172 deletions(-)
---
base-commit: 6628e7d4c6b25c8d18f1345e3a20d21829aae7e4
change-id: 20261101-superm1-backlight-property-1ee9b1a4b24d

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

