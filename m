Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A879AC44536
	for <dri-devel@archiver.kernel.org>; Thu, 23 Jul 2026 00:33:20 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E9C8A10E472;
	Thu, 23 Jul 2026 00:33:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="V+g+Hly5";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 046A110E472;
 Thu, 23 Jul 2026 00:33:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:From:Reply-To;
 bh=6JjzArKh/LXGa0K404gNaqBiFxulwWCzM1gJiW9MZ5I=; b=V+g+Hly57J2SqxkBf9BblwAqPt
 Hv08SQoWOVIFXCKW/D/p8ijV9U7uYKCRpP+h+3Ti4Ah3762S4ja4IR2ZTPrAiHttrKV0s701jfQHi
 KmIr87nJQp6KGmEsWrlfT8gT0mSH8yXCGvCLn/k52+xL08jDg7HGcfFL2OTflRXDZJs9E5DQyfG+a
 mTGlhw2DiPAQkr6HFZURLehoIpVtAyImAWVKGYrivTAEZvLGG0k5qF7ovo/z1O7D3fD9izvuLtcPI
 7jmciTKCdH7FPH/2yNiUuGewPzwry24I7HNQBQFO1ucnLH5Ln2h0B68mkTY8vF59wQk77oeUC9X8u
 kPA400yw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wmhNC-003EEc-EB; Thu, 23 Jul 2026 02:33:14 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v8 0/8] drm: writeback: clean up writeback connector
 initialization
Date: Wed, 22 Jul 2026 17:31:55 -0700
Message-ID: <20260723003205.330362-1-John.Harrison@Igalia.com>
X-Mailer: git-send-email 2.43.0
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Drivers using drm_writeback_connector_init() / _with_encoder() don't
perform cleanup in a manner similar to drmm_writeback_connector_init()
(see drm_writeback_connector_cleanup()). Migrate all existing drivers
to use drmm_writeback_connector_init(), drop
drm_writeback_connector_init() and drm_writeback_connector::encoder
(it's unused afterwards).

NB: Patch set written by Dmitry B but taken over by John H at v7 due to
time pressures.

---
Changes in v8 (by John Harrison):
- Fix up the AMD KUnit test
- Drop the error path drmm_kfree calls that are post DRM hand off
  They are unnecessary as the memory will get freed when the drm
  device is disconnected. More importantly, the DRM layer now has
  a pointer to the memory and may call a cleanup function that
  references it during disconnection.
- Drop drm_writeback_connector_init_with_encoder() completely. It is
  not used by any current driver and the very strong recommendation
  for any new addition is to use the new drmm equivalent.
- Update some documentation comments with the new drmm naming.

Changes in v7 (by John Harrison):
- Fix missing parameter in drmm_kfree
- Fix leaking error paths
- Fix kernel docs
- Add typecast to drmm_zalloc_obj(s)
- Drop extra obsolete cleanup call in vc4

Changes in v6:
- Dropped applied patch
- Implemented suggestion by Alex to use drmm allocation for the
  writeback connector.
- Link to v5: https://patch.msgid.link/20260505-wb-drop-encoder-v5-0-42567b7c7af2@oss.qualcomm.com

Changes in v5:
- Rebased on top of drm-misc-next
- Expanded commit message for msm patch, describing devm vs drmm issues (Laurent)
- Expanded commit messages, describing why the drivers are converted to
  drmm_writeback_connector_init() (Laurent)
- Link to v4: https://lore.kernel.org/r/20251228-wb-drop-encoder-v4-0-58d28e668901@oss.qualcomm.com

Changes in v4:
- Rebase on top of drm-misc-next, dropping applied patch.
- Added a note regarding memory leak in the AMDGPU driver.
- Fixed a devm vs drmm issue in the msm/dpu driver.
- Link to v3: https://lore.kernel.org/r/20250819-wb-drop-encoder-v3-0-b48a6af7903b@oss.qualcomm.com

Changes in v3:
- Fixed subject prefix for the rcar-du patch (Jessica Zhang)
- Link to v2: https://lore.kernel.org/r/20250816-wb-drop-encoder-v2-0-f951de04f4f9@oss.qualcomm.com

Changes in v2:
- Switched to drm_crtc_mask() where applicable (Louis Chauvet)
- Link to v1: https://lore.kernel.org/r/20250801-wb-drop-encoder-v1-0-824646042f7d@oss.qualcomm.com

To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
To: Harry Wentland <harry.wentland@amd.com>
To: Leo Li <sunpeng.li@amd.com>
To: Rodrigo Siqueira <siqueira@igalia.com>
To: Alex Deucher <alexander.deucher@amd.com>
To: Christian König <christian.koenig@amd.com>
To: Liviu Dudau <liviu.dudau@arm.com>
To: Laurent Pinchart <laurent.pinchart+renesas@ideasonboard.com>
To: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
To: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
To: Geert Uytterhoeven <geert+renesas@glider.be>
To: Magnus Damm <magnus.damm@gmail.com>
To: Dave Stevenson <dave.stevenson@raspberrypi.com>
To: Maíra Canal <mcanal@igalia.com>
To: Raspberry Pi Kernel Maintenance <kernel-list@raspberrypi.com>
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
Cc: amd-gfx@lists.freedesktop.org
Cc: linux-renesas-soc@vger.kernel.org

Dmitry Baryshkov (8):
  drm/managed: implement managed versions of kzalloc_obj/objs()
  drm/amd/display: use drmm allocation for writeback connector
  drm/amd/display: use drmm_writeback_connector_init()
  drm/komeda: use drmm_writeback_connector_init()
  drm/mali: use drmm_writeback_connector_init()
  drm: renesas: rcar-du: use drmm_writeback_connector_init()
  drm/vc4: use drmm_writeback_connector_init()
  drm: writeback: drop excess connector initialization functions

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   6 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  18 ++-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |   2 -
 .../arm/display/komeda/komeda_wb_connector.c  |  39 ++++---
 drivers/gpu/drm/arm/malidp_mw.c               |  26 +++--
 drivers/gpu/drm/drm_writeback.c               | 107 ------------------
 .../drm/renesas/rcar-du/rcar_du_writeback.c   |  22 ++--
 drivers/gpu/drm/vc4/vc4_txp.c                 |  18 +--
 include/drm/drm_managed.h                     |  23 ++++
 include/drm/drm_mode_config.h                 |   6 +-
 include/drm/drm_writeback.h                   |  26 +----
 11 files changed, 99 insertions(+), 194 deletions(-)

-- 
2.43.0

