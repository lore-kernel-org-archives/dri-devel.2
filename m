Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 675D0C44507
	for <dri-devel@archiver.kernel.org>; Mon, 13 Jul 2026 23:52:43 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E5FD810E2D1;
	Mon, 13 Jul 2026 23:52:41 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=igalia.com header.i=@igalia.com header.b="g7VBA5XD";
	dkim-atps=neutral
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
 by gabe.freedesktop.org (Postfix) with ESMTPS id E521710E03B;
 Mon, 13 Jul 2026 23:52:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com; 
 s=20170329;
 h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:
 Date:Subject:Cc:To:From:Sender:Reply-To:Content-ID:Content-Description:
 Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
 In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
 List-Post:List-Owner:List-Archive;
 bh=oshCRkuTSc7HxbPUpUr4GjCt+a0l1+09+Fh6sX4fpLk=; b=g7VBA5XDvnfdDlnIRZRUfNhIAi
 s2ZBkYWHnsScnBwuY8HBw7OUPK2qMcNc8E27oWIQEYijBLOoXvvW83SrTXKdv6mknBOQgYeJUK7cC
 a+hX1yKpQvSWhbaaEcCqtc1DDvy3xMdtzWAoGT9w9cy3e3eT5Ioe+cmYDNa2uKx6d7h60gKVqqiEa
 /n28FlMKmVnU0iox8EUtM5YOwLV0+IfcazQlXNMZ+S2Sl+qze8csFPsfEPOD2cMSSAlEg/qjgBk7l
 I/eHfwq5mDakgfPrwRAAbQN2XPmhUKxa6c32ymeDibujg9xZDcOC4IIjtgqKh+b+QFM6wEZhWrU5O
 6tjwc6fw==;
Received: from c-73-157-168-91.hsd1.or.comcast.net ([73.157.168.91]
 helo=localhost.localdomain) by fanzine2.igalia.com with esmtpsa 
 (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
 id 1wjQRy-00EjJa-9K; Tue, 14 Jul 2026 01:52:39 +0200
From: John Harrison <John.Harrison@Igalia.com>
To: dri-devel@lists.freedesktop.org
Cc: kernel-dev@igalia.com, linux-kernel@vger.kernel.org,
 amd-gfx@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org
Subject: [PATCH v7 0/9] v7 drm: writeback: clean up writeback connector
 initialization
Date: Mon, 13 Jul 2026 16:51:42 -0700
Message-ID: <20260713235153.3862650-1-John.Harrison@Igalia.com>
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

This series leaves former drm_writeback_connector_init_with_encoder()
(renamed to drm_writeback_connector_init as a non-managed counterpart
for drmm_writeback_connector_init()). It is supposed to be used by
drivers which can not use drmm functions (like Intel). However I think
it would be better to drop it completely.

NB: Patch set written by Dmitry B but taken over by John H at v7 due to
time pressures.

---
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

Dmitry Baryshkov (9):
  drm/managed: implement managed versions of kzalloc_obj/objs()
  drm/amd/display: use drmm allocation for writeback connector
  drm/amd/display: use drmm_writeback_connector_init()
  drm/komeda: use drmm_writeback_connector_init()
  drm/mali: use drmm_writeback_connector_init()
  drm: renesas: rcar-du: use drmm_writeback_connector_init()
  drm/vc4: use drmm_writeback_connector_init()
  drm: writeback: drop excess connector initialization functions
  drm: writeback: rename drm_writeback_connector_init_with_encoder()

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  7 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 18 +++--
 .../arm/display/komeda/komeda_wb_connector.c  | 37 ++++++----
 drivers/gpu/drm/arm/malidp_mw.c               | 26 ++++---
 drivers/gpu/drm/drm_writeback.c               | 71 +++----------------
 .../drm/renesas/rcar-du/rcar_du_writeback.c   | 22 ++++--
 drivers/gpu/drm/vc4/vc4_txp.c                 | 18 ++---
 include/drm/drm_managed.h                     | 23 ++++++
 include/drm/drm_writeback.h                   | 22 +-----
 9 files changed, 106 insertions(+), 138 deletions(-)

-- 
2.43.0

