Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 81C5BC44507
	for <dri-devel@archiver.kernel.org>; Tue, 14 Jul 2026 04:28:26 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3D00D10E35F;
	Tue, 14 Jul 2026 04:28:24 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="JPVr2H3F";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.15])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 316FA10E0B6;
 Tue, 14 Jul 2026 04:28:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1784003303; x=1815539303;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=BpdDvnS/3JQwR+hmDLbJAmbTdHlLpQQqf+n5ckydQ8U=;
 b=JPVr2H3FW8o3k6a5DT4E2LnvQNKvf/4YZyGOzmzQJEstaBYoZq18Q7Pk
 lhSg5WdNOtXWntnQSqUbiQfXUThPNZDux+RPhF3+Vm5lLlHnrJKoOln00
 g733fPvyTNZNz+5DeP7cEuz76JIIDC21LokcgxvF2sqlOdIp/9gWkWXbj
 ZE5TRFqUvSI5zck3ARBlBxsLIxJt/2mAqD8YnI/K4UPVGDfPYRZvOHBT1
 BNPyansnpBQVb3rigHU9V2UtOCdwUYWexOTTVd0nkAK7FQNB3xmQYY9YU
 4IsqjaFVhvIhA7mAFKBndUYh8jPSCo/6emL8q+ozNc/iYIeZxLVprSqxF w==;
X-CSE-ConnectionGUID: mGJEpg+ySTCbKAthqvAY6g==
X-CSE-MsgGUID: HBvmafEcTHCNFE0sYsuZzA==
X-IronPort-AV: E=McAfee;i="6800,10657,11841"; a="88297015"
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="88297015"
Received: from orviesa008.jf.intel.com ([10.64.159.148])
 by orvoesa107.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 13 Jul 2026 21:28:22 -0700
X-CSE-ConnectionGUID: ef5UR8ujS+Wyfe6V7diKHA==
X-CSE-MsgGUID: IkJwYStrQcKHnimKpiOXGA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.25,163,1779174000"; d="scan'208";a="255243092"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by orviesa008.jf.intel.com with ESMTP; 13 Jul 2026 21:28:15 -0700
From: Suraj Kandpal <suraj.kandpal@intel.com>
To: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: uma.shankar@intel.com, arun.r.murthy@intel.com, abhinav.kumar@linux.dev,
 tzimmermann@suse.de, sean@poorly.ru, marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, louis.chauvet@bootlin.com,
 kernel-dev@igalia.com, John.Harrison@Igalia.com,
 Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH v6 0/7]  Refactor drm_writeback_connector structure
Date: Tue, 14 Jul 2026 09:57:58 +0530
Message-Id: <20260714042805.77934-1-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
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

Some drivers cannot work with the current design where the connector
is embedded within the drm_writeback_connector such as intel and
some drivers that can get it working end up adding a lot of checks
all around the code to check if it's a writeback conenctor or not.
This is due to the inheritance limitation in C.
This series intends to solve it by moving the drm_writeback_connector
within the drm_connector and remove the drm_connector base which was in
drm_writeback_connector. This is done in union with hdmi connector
within drm_connector to save memory and since drm_connector cannot be
both hdmi and writeback it serves is well.
A RFC version was floated and discussion had taken place at [1] which
kicked of this more cleaner series.
We do all other required modifications that come with these changes
along with addition of new function which returns the drm_connector when
drm_writeback_connector is present.
This series also contains some writeback API cleanups as a consequence
of writeback connector moving into drm_connector
All drivers will be expected to allocate the drm_connector.
This discussion was tiggered from [2] and sits on top of Dmitry's series
see [3].

[1] https://patchwork.freedesktop.org/series/152758/
[2] https://patchwork.freedesktop.org/series/152106/
[3] https://patchwork.freedesktop.org/series/152420/

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>

Suraj Kandpal (7):
  drm: writeback: Refactor drm_writeback_connector structure
  drm: writeback: Modify writeback init helpers
  drm: writeback: Modify drm_writeback_queue_job helper
  drm: writeback: Modify drm_writeback_signal_completion helper
  drm: writeback: Modify drm_writeback_get_out_fence helper
  drm: writeback: Modify prepare_writeback_job helper
  drm: writeback: Modify cleanup_writeback_job helper

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |  6 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |  2 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |  4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  | 12 +--
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |  2 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |  6 +-
 .../arm/display/komeda/komeda_wb_connector.c  | 11 +--
 drivers/gpu/drm/arm/malidp_crtc.c             |  2 +-
 drivers/gpu/drm/arm/malidp_drv.h              |  2 +-
 drivers/gpu/drm/arm/malidp_mw.c               |  7 +-
 drivers/gpu/drm/drm_atomic_uapi.c             |  4 +-
 drivers/gpu/drm/drm_writeback.c               | 47 +++++++-----
 .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |  9 ++-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c | 10 +--
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h |  4 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |  6 +-
 .../drm/renesas/rcar-du/rcar_du_writeback.c   | 15 ++--
 drivers/gpu/drm/vc4/vc4_txp.c                 |  6 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |  2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c         | 15 ++--
 include/drm/drm_connector.h                   | 69 ++++++++++++++++-
 include/drm/drm_modeset_helper_vtables.h      |  4 +-
 include/drm/drm_writeback.h                   | 76 ++-----------------
 23 files changed, 160 insertions(+), 161 deletions(-)

-- 
2.34.1

