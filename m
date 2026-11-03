Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44FAA606A32F
	for <dri-devel@archiver.kernel.org>; Tue,  3 Nov 2026 22:42:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IujG/Pht
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 7457E10ED72;
	Tue,  3 Nov 2026 22:42:21 +0000 (UTC)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9BAC910E1EB;
 Tue,  3 Nov 2026 22:42:15 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by sea.source.kernel.org (Postfix) with ESMTP id 53EE840A8E;
 Tue,  3 Nov 2026 22:42:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F6741F000C1;
 Tue,  3 Nov 2026 22:42:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1793745735;
 bh=WxnWKT+9kKH7Du8TkvgtZkUd4TPSXvyu35Kk8ujhBxM=;
 h=From:Subject:Date:To:Cc;
 b=IujG/PhtwVxl+I1yUP06jnUQg/GzV8RFVlD7Puk9oWCBWR9C8j47sZ3NXbftljcfq
 lw0hQd7wnM6BZEXdG0a+G8M+d0PgLOfQf7ihWutr+JIQw5WDncLSCqgAYYYwcztc2v
 dHK3zZGopufbra8//b4EXrGpbasnrMM22MCXQ2lWk0lxrDPLyApu+MwrfoWRgU34PC
 IFVWA+91/85geDcQiXNS9aIk+/EVkvE6pZy4V7ANOLMYU2fRNjzJpPMJlfmE3SRQ12
 3wjnsvxKkrM2ZWv9kdFTksl7PUbwqlzgNqZ5W+8tfLNbMKeUvbxz3m/HAfXqYkG3xE
 lmLSMG4E8yHjA==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v11 00/12] Add support for a DRM backlight capability
Date: Tue, 03 Nov 2026 16:42:01 -0600
Message-Id: <20261103-superm1-backlight-property-v11-0-00cce7b2ba22@kernel.org>
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAAAAAAAC/yXMwQrCMAyA4VcZORtYyhD0VYaHtotbdG4laUUZe
 3erHv//8G1grMIG52YD5aeYrEsNokMDcfLLyChDHeBadyRqCa0k1gdh8PE+yzhlTLrWld9IzKd
 AvguuG6ACSfkqr5/eX/5tJdw45q8I+/4B5PTr3n8AAAA=
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
X-Spam-Status: No, score=-21.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,
	INCLUDES_PATCH,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,
	SPF_PASS,TRACKER_ID,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=4.0.1
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

https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v11

Signed-off-by: Mario Limonciello <superm1@kernel.org>
---
Changes in v11:
 * Rebased on drm-tip (fixes Intel CI failing to apply the KUnit patch)
 * Squashed the amdgpu KUnit fixture update into the amdgpu luminance
   patch and moved the bios_scratch_reg_offset fix before it, so every
   commit builds and passes KUnit
 * Dropped drm/radeon and drm/gma500 patches: both are non-atomic drivers,
   so userspace can't use an atomic connector property there (Sashiko)
 * Restored the unconditional select of BACKLIGHT_CLASS_DEVICE in all
   migrated drivers, fixing ACPI_VIDEO unmet dependencies and link
   failures (Sashiko)
 * Core: don't call .disable_luminance when entering self refresh, and
   only call .set_luminance when the luminance changes or on a modeset
   that isn't a self refresh exit (Leo Li, Sashiko)
 * Drivers on ACPI systems (amdgpu, i915/xe) only attach LUMINANCE when
   acpi_video_backlight_use_native() allows it, keeping the acpi_video
   fallback otherwise (Sashiko)
 * Non-atomic paths (legacy non-DC amdgpu, nouveau NV04 and
   nouveau.atomic=0) keep the backlight class device (Sashiko)
 * bridge/panel: removed rebase artifacts from drm_bridge.h/drm_panel.h,
   fixed an invalid container_of() in the panel bridge, cleaned up the
   connector on error, and left backlight power to drm_panel_enable()/
   drm_panel_disable() (Sashiko)
 * bridge_connector: dropped .disable_luminance, which clobbered the
   bridge's saved level
 * amdgpu: restore brightness after GPU reset and modesets for LUMINANCE
   panels, and skip programming unchanged values (Leo Li, Sashiko)
 * amdgpu KUnit: fixed connector_type IDA mismatch (Sashiko)
 * amdgpu: seed LUMINANCE from the hardware level; left the unrelated
   privacy screen code in commit_tail unchanged
 * i915: fall back to the backlight class device if attaching LUMINANCE
   fails
 * panel: don't attach LUMINANCE for panel bridges attached after device
   registration, and update brightness under the backlight ops_lock
 * ps8622: program the committed luminance in pre_enable
 * i915: enable the backlight at the committed level, and fix the build
   with BACKLIGHT_CLASS_DEVICE=n (Sashiko)
 * nouveau: call the luminance helpers from the NV50 commit tail, attach
   the property before drm_dev_register(), and fix a stale eDP brightness
   on the class device path (Sashiko)
 * gud: apply LUMINANCE within the atomic commit instead of a worker,
   fixing an endless commit loop, a use-after-free on disconnect and
   brightness clobbering; attach the property at init (Sashiko)
 * ps8622: track internal PWM mode explicitly and don't touch I2C while
   powered down (Sashiko)
 * ssd130x: register the backlight device only without DRM_LUMINANCE,
   use the committed contrast on enable, don't clobber it on disable,
   skip writes while unpowered, and unify contrast dispatch (Sashiko)
 * Known limitation: with DRM_LUMINANCE, amdgpu ATIF firmware brightness
   requests are not forwarded (i915 OpRegion ASLE requests are already
   ignored when native backlight control is in use)
 * Link to v10: https://lore.kernel.org/dri-devel/20261102-superm1-backlight-property-v10-0-b2a6f24131f5@kernel.org/

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
Mario Limonciello (11):
      drm: add connector LUMINANCE property
      drm/amd/display: Pass up errors reading actual brightness
      drm/amd: add luminance property support
      drm/i915/display: add luminance property support
      drm/bridge: add connector luminance operations
      drm/panel: add connector luminance forwarding
      drm/bridge_connector: add luminance support
      drm/nouveau: add connector luminance support
      drm/gud: add connector luminance support
      drm/bridge: add PS8622 connector luminance support
      drm/solomon: add SSD130x connector luminance support

Mario Limonciello (AMD) (1):
      drm/amdgpu: Check bios_scratch_reg_offset in backlight level helper

 drivers/gpu/drm/Kconfig                            |  14 ++
 drivers/gpu/drm/amd/amdgpu/amdgpu_atombios.c       |   7 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c  |  16 +--
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h  |   7 +
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.c    |  91 +++++++++++-
 .../amd/display/amdgpu_dm/amdgpu_dm_backlight.h    |   5 +-
 .../amd/display/amdgpu_dm/amdgpu_dm_connector.c    |   5 +-
 .../amdgpu_dm/tests/amdgpu_dm_backlight_test.c     |  72 ++++++++--
 .../amdgpu_dm/tests/amdgpu_dm_kunit_helpers.c      |   7 +-
 drivers/gpu/drm/bridge/parade-ps8622.c             |  66 +++++++--
 drivers/gpu/drm/display/drm_bridge_connector.c     |  39 ++++++
 drivers/gpu/drm/drm_atomic_helper.c                |  98 ++++++++++++-
 drivers/gpu/drm/drm_atomic_state_helper.c          |   7 +
 drivers/gpu/drm/drm_atomic_uapi.c                  |   5 +
 drivers/gpu/drm/drm_connector.c                    |  57 ++++++++
 drivers/gpu/drm/drm_panel.c                        |  93 +++++++++++++
 drivers/gpu/drm/gud/gud_connector.c                |  20 ++-
 drivers/gpu/drm/i915/display/icl_dsi.c             |   1 +
 drivers/gpu/drm/i915/display/intel_backlight.c     |  74 ++++++++--
 drivers/gpu/drm/i915/display/intel_backlight.h     |   1 +
 drivers/gpu/drm/i915/display/intel_display.c       |   2 +
 drivers/gpu/drm/i915/display/intel_dp.c            |   1 +
 drivers/gpu/drm/i915/display/intel_lvds.c          |   1 +
 drivers/gpu/drm/i915/display/intel_panel.c         |   8 +-
 drivers/gpu/drm/i915/display/vlv_dsi.c             |   1 +
 drivers/gpu/drm/nouveau/dispnv50/disp.c            |  13 +-
 drivers/gpu/drm/nouveau/nouveau_backlight.c        | 152 ++++++++++++++++++---
 drivers/gpu/drm/nouveau/nouveau_connector.c        |   3 +
 drivers/gpu/drm/nouveau/nouveau_connector.h        |  23 ++++
 drivers/gpu/drm/nouveau/nouveau_drm.c              |   6 +
 drivers/gpu/drm/solomon/ssd130x.c                  | 149 +++++++++++++-------
 drivers/gpu/drm/solomon/ssd130x.h                  |   2 +
 drivers/gpu/drm/tests/drm_connector_test.c         |  28 ++++
 include/drm/drm_atomic_helper.h                    |   3 +
 include/drm/drm_bridge.h                           |  20 +++
 include/drm/drm_connector.h                        |  16 +++
 include/drm/drm_modeset_helper_vtables.h           |  28 ++++
 include/drm/drm_panel.h                            |   4 +
 38 files changed, 1008 insertions(+), 137 deletions(-)
---
base-commit: 9f54e1a5b50dc017d371c435b12ddb5300c7d5b2
change-id: 20261101-superm1-backlight-property-1ee9b1a4b24d

Best regards,
--  
Mario Limonciello <superm1@kernel.org>

