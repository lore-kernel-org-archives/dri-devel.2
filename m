Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34127CD5BD5
	for <dri-devel@archiver.kernel.org>; Thu, 28 May 2026 05:50:07 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 706A810EC53;
	Thu, 28 May 2026 05:50:06 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.b="ej0u1atP";
	dkim-atps=neutral
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
 by gabe.freedesktop.org (Postfix) with ESMTPS id EDB5F10EC53
 for <dri-devel@lists.freedesktop.org>; Thu, 28 May 2026 05:50:04 +0000 (UTC)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
 by tor.source.kernel.org (Postfix) with ESMTP id 2ADFB60103;
 Thu, 28 May 2026 05:50:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F3711F000E9;
 Thu, 28 May 2026 05:50:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
 s=k20260515; t=1779947403;
 bh=wirO+78qTIzJMOe6M8pO04nFDPKZW8Pp66ZB9iAuXkc=;
 h=From:To:Cc:Subject:Date;
 b=ej0u1atPJJzoVQsXEoqDNzNKIdqMKx0Cc4TH/i6tml9y0NwLxyW3MXSWsW6FmnghZ
 p4nti+oYmEMk1+XDeInhJ70azESMyNhyUEy1MGsr2zW++tVECb3JNYApYMhxaZ6GIV
 hHv35LcH/RhfEz9uPX/Nm9chUChekqqAkrD1RuuLCGeO+6d1mSJDjV8qNH9Rwf1KHl
 1+aufimdUSjn+6SZ3xfA9o2Z8bJYYUktdoB275IAumMFQ6u3KeyXozrUB0KUOCP3V8
 5xQTbMBKJi0XS5ZiK5aotGF/0ANDLXSbTzcwhpMjxJzNlNjzpi/u1evzUGZPdPTCAH
 4ch6Fy/3jZvbQ==
From: "Mario Limonciello (AMD)" <superm1@kernel.org>
To: dri-devel@lists.freedesktop.org
Cc: Mario Limonciello <mario.limonciello@amd.com>, harry.wentland@amd.com,
 Louis Chauvet <louis.chauvet@bootlin.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>,
 "Mario Limonciello (AMD)" <superm1@kernel.org>
Subject: [PATCH v4 0/9] Add support for a DRM backlight capability
Date: Thu, 28 May 2026 00:49:02 -0500
Message-ID: <20260528054911.1513208-1-superm1@kernel.org>
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

At Display Next Hackfest 2025 we discussed the renewed need for moving
brightness control into the DRM connector properties.  I've taken the
previous efforts from David and Marta, rebased and adjusted for the
current kernel.

The legacy sysfs interface is synchronized with the DRM connector (although
the scale may be different as DRM connector property is u16).

Later after this has been adopted by enough userspace, it may make sense to
configure the legacy sysfs interface to be configurable so that only
DRM master controls backlight.

I've done a first implementation with amdgpu with eDP connectors; but
conceivably this can be extended to other connectors like DP for displays
that can be controlled via DDC as well later.

I have also used DRM review prompts to review this series and fix some bugs
which were caught with two different Claude models.  The fixes are squashed
into the patches.

Assisted-by: Claude Opus
Assisted-by: Claude Sonnet

For ease of testing; this series is also available on this branch:
https://git.kernel.org/pub/scm/linux/kernel/git/superm1/linux.git/log/?h=superm1/backlight-property-v4

---
v3->v4:
 * Address feedback on mailing list for linking, bridge connector handling
 * Make DRM capability block with writes
 * Drop unnecessary code

Mario Limonciello (AMD) (9):
  Revert "backlight: Remove notifier"
  backlight: add kernel-internal backlight API
  drm: link connectors to backlight devices
  DRM: Add support for client and driver indicating support for
    luminance
  drm/amd/display: Pass up errors reading actual brightness
  drm/amd: Indicate driver supports luminance
  drm/amd/display: Allow backlight registration to fail
  drm/amd/display: use drm backlight
  drm/bridge: auto-link panel backlight in bridge connector

 drivers/gpu/drm/Kconfig                       |   1 +
 drivers/gpu/drm/Makefile                      |   2 +
 drivers/gpu/drm/amd/amdgpu/amdgpu_drv.c       |   1 +
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  77 ++-
 drivers/gpu/drm/bridge/panel.c                |  15 +
 .../gpu/drm/display/drm_bridge_connector.c    |  15 +-
 drivers/gpu/drm/drm_atomic_helper.c           |   9 +
 drivers/gpu/drm/drm_atomic_uapi.c             |  59 ++-
 drivers/gpu/drm/drm_backlight.c               | 467 ++++++++++++++++++
 drivers/gpu/drm/drm_connector.c               |  12 +
 drivers/gpu/drm/drm_drv.c                     |   8 +
 drivers/gpu/drm/drm_file.c                    |   5 +
 drivers/gpu/drm/drm_ioctl.c                   |  17 +
 drivers/gpu/drm/drm_mode_config.c             |   7 +
 drivers/gpu/drm/drm_mode_object.c             |  66 ++-
 drivers/gpu/drm/drm_sysfs.c                   |  28 +-
 drivers/video/backlight/backlight.c           |  99 ++++
 include/drm/drm_backlight.h                   |  51 ++
 include/drm/drm_bridge.h                      |   1 +
 include/drm/drm_connector.h                   |   8 +
 include/drm/drm_drv.h                         |   7 +
 include/drm/drm_file.h                        |   8 +
 include/drm/drm_mode_config.h                 |   5 +
 include/linux/backlight.h                     |  56 +++
 include/uapi/drm/drm.h                        |  10 +
 25 files changed, 1005 insertions(+), 29 deletions(-)
 create mode 100644 drivers/gpu/drm/drm_backlight.c
 create mode 100644 include/drm/drm_backlight.h

-- 
2.54.0

