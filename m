Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C84E3CD6E53
	for <dri-devel@archiver.kernel.org>; Sun, 31 May 2026 11:49:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3BB7A112AE6;
	Sun, 31 May 2026 11:49:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="FHRVu1Ec";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D4D60112AE1;
 Sun, 31 May 2026 11:49:16 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id BB32760123;
 Sun, 31 May 2026 11:49:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 18AD41F00893;
 Sun, 31 May 2026 11:49:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1780228155;
 bh=MQT9vVgz4HegpDjfH+RJO0/pEzwdH74lXx7OVPfGEAs=;
 h=From:To:Cc:Subject:Date;
 b=FHRVu1EcpIn0soQD4dZYEaguxHdsQB58eYF7zjdMjgtwOypHm9cNB/oXQh89l7DSZ
 HMv9FsjNcg5R7KvSNN4vbgalo1lPtYFxWF/S0Z8XMRHi4C4TFz8vjsXJ6/C0P5cfV7
 SlsELSkqQqA4TYdDstUk50wySAw6Xtfvs3/wziLJikw5FfOoIB1DyXXONhmDbrSCk4
 ru42w62NAxMX6OEn10Yciy8pDQcN9CxekqYq9cwsK8hKZfKotUkoUwa8fr9CJL8Y+2
 GINllVUz7GXaRRz1SMeYgTzEE1WKiPRFJBWB/kR1+yX7y4+bj/cSIzNkRyeffePX+D
 ZEtgQfnRH5i8Q==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: amd-gfx@lists.freedesktop.org,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v5 00/11] Add support for a DRM backlight capability
Date: Sun, 31 May 2026 06:48:57 -0500
Message-ID: <20260531114908.1693426-1-superm1@kernel.org>
X-Mailer: git-send-email 2.53.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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

At Display Next Hackfest 2026 we reviewed progress moving brightness
control into the DRM connector properties.

There is a range LUMINANCE property that will default to 0->0.
Once a driver attaches a backlight it will be updated to 1->max.
If the panel supports the minimum backlight turning off the display
the range can later be updated to 0->max instead of 1->max.

The legacy sysfs interface is synchronized with the DRM connector.
When a compositor using this feature is loaded, sysfs writes are disabled
to prevent legacy tools from going out of sync with the compositor.

This has an implementation initially for amdgpu, i915, and Xe with eDP
connectors.  It can be extended to other connectors like DP for displays
that can be controlled via DDC as well later.

For ease of testing; this series is also available on this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v5

This tree is:
 * 7.1-rc5 +
 * Various patches coming from drm-next for amdgpu vblank handling +
 * This series

These patches are backported into that branch due to timing bugs being exposed
with this series. If this series is applied to drm-next those patches are not
needed.

The following compositors have implemented matching support:
 * Kwin: https://invent.kde.org/plasma/kwin/-/merge_requests/9298
 * Mutter: https://gitlab.gnome.org/swick/mutter/-/commits/wip/kms-luminance-prop
 * Wlroots: https://gitlab.freedesktop.org/wlroots/wlroots/-/merge_requests/5384

---
v4->v5:
 * Add i915/xe support (Tested by Simon)
 * Drop driver indicating support as drivers will just add property to connectors
 * Lots of internal cleanups (see patches for details)
 * Add testing tags
 * Changes for bugs found in amdgpu handling when testing with Kwin
 * Use 1->max for default range, reserving 0 specifically for displays that
   are confirmed to turn off at minimum luminance.
 * Drop worker thread to notify brightness changes (handle part of the commit)
 * Drop amdgpu brightness caching

Mario Limonciello (AMD) (11):
  Revert "backlight: Remove notifier"
  backlight: add kernel-internal backlight API
  drm: link connectors to backlight devices
  DRM: Add support for client indicating support for luminance
  drm/amd/display: Pass up errors reading actual brightness
  drm/amd/display: Allow backlight registration to fail
  drm/amd/display: Move backlight tracing out of the dc lock
  drm/amd/display: use drm backlight
  drm/amd/display: Drop brightness caching in amdgpu_dm
  drm/bridge: auto-link panel backlight in bridge connector
  drm/i915/display: use drm backlight

 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c | 117 ++---
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  13 -
 drivers/gpu/drm/bridge/panel.c                |  15 +
 .../gpu/drm/display/drm_bridge_connector.c    |  15 +-
 drivers/gpu/drm/drm_atomic_helper.c           |   7 +
 drivers/gpu/drm/drm_atomic_uapi.c             |  59 ++-
 drivers/gpu/drm/drm_backlight.c               | 441 ++++++++++++++++++
 drivers/gpu/drm/drm_connector.c               |  63 +++
 drivers/gpu/drm/drm_drv.c                     |   8 +
 drivers/gpu/drm/drm_file.c                    |   5 +
 drivers/gpu/drm/drm_ioctl.c                   |  15 +
 drivers/gpu/drm/drm_mode_config.c             |   7 +
 drivers/gpu/drm/drm_mode_object.c             |  66 ++-
 drivers/gpu/drm/drm_property.c                |   6 +
 drivers/gpu/drm/drm_sysfs.c                   |  28 +-
 .../gpu/drm/i915/display/intel_backlight.c    |   4 +
 drivers/gpu/drm/i915/display/intel_dp.c       |   8 +
 drivers/video/backlight/backlight.c           |  97 ++++
 include/drm/drm_backlight.h                   |  51 ++
 include/drm/drm_bridge.h                      |   1 +
 include/drm/drm_connector.h                   |   8 +
 include/drm/drm_file.h                        |   8 +
 include/drm/drm_mode_config.h                 |   5 +
 include/linux/backlight.h                     |  56 +++
 include/uapi/drm/drm.h                        |  22 +
 27 files changed, 1038 insertions(+), 89 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_backlight.c
 create mode 100644 include/drm/drm_backlight.h

-- 
2.54.0

