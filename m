Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 100BF606A31C
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:17:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=iPQfytdY
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 3F1DA10EE07;
	Tue, 10 Nov 2026 06:17:02 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 63EC310E1AE;
 Tue, 10 Nov 2026 06:16:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794291416; x=1825827416;
 h=from:to:cc:subject:date:message-id:mime-version:
 content-transfer-encoding;
 bh=cm3IqdqaTmBiSSYtxE7H1ViyE7GZRQgg5cV+/V8g9bQ=;
 b=iPQfytdYKWRJDjHaH3wVKsY9VtHAg6p1cHXCVbAEfGUjs6OaJ2cFeMNM
 0uqtlgN283TqfI9A7g8UtU0QBenpLuZk0UiBJPDE2ag3J+5emeE4cSGtP
 rpSpPS9j4GuNsqrCaWiKB10bONR3uO2XSCj/LPWxNNkN8NemQGd3AEIHd
 dKhBccDTI45qhvdWzoCGZvLFZjim9z/rRRaPzWo40rzxrvl9bR8RtZtsZ
 91pmBziXeU2q+JCv5SMP2HOMTX/w7khf6DV46lbUXQZHqOfWgz7Y6p8hi
 pAmUKTMk3MRAIlaAa9aaqp5OPOAKtnz4f+Qe1Q0doGlDsPLGo93365BLg A==;
X-CSE-ConnectionGUID: Pi2Kh2QdSrupYqg30OOEWA==
X-CSE-MsgGUID: ZK1cISL2Qs68SM2f/nLUMQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3020905"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3020905"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 22:16:55 -0800
X-CSE-ConnectionGUID: AZOeAwC9RgyKAVcptfOVig==
X-CSE-MsgGUID: nW87YRJVR++h+MhDXW6PQA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7930910"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by orviesa004.jf.intel.com with ESMTP; 09 Nov 2026 22:16:49 -0800
From: Suraj Kandpal <suraj.kandpal@intel.com>
To: dri-devel@lists.freedesktop.org, amd-gfx@lists.freedesktop.org,
 freedreno@lists.freedesktop.org, linux-arm-msm@vger.kernel.org,
 linux-renesas-soc@vger.kernel.org, intel-gfx@lists.freedesktop.org,
 intel-xe@lists.freedesktop.org, linux-kernel@vger.kernel.org
Cc: dmitry.baryshkov@oss.qualcomm.com, John.Harrison@Igalia.com,
 kernel-dev@igalia.com, alex.hung@amd.com, liviu.dudau@arm.com,
 louis.chauvet@bootlin.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, tzimmermann@suse.de, airlied@gmail.com,
 simona@ffwll.ch, laurent.pinchart+renesas@ideasonboard.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 mcanal@igalia.com, kernel-list@raspberrypi.com, uma.shankar@intel.com,
 arun.r.murthy@intel.com, Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH v7 0/8] Refactor drm_writeback_connector structure
Date: Tue, 10 Nov 2026 11:46:29 +0530
Message-Id: <20261110061637.2500929-1-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
X-Archived-By: <archiver.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
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
X-Spam-Status: No, score=-18.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_GIT autolearn=unavailable autolearn_force=no
	version=4.0.1
X-Spam-Checker-Version: SpamAssassin 4.0.1 (2024-03-26) on
	aws-us-west-2-korg-listserv-alma10-1

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

Dmitry Baryshkov (1):
  drm: writeback: drop excess connector initialization functions

Suraj Kandpal (7):
  drm: writeback: Refactor drm_writeback_connector structure
  drm: writeback: Modify writeback init helpers
  drm: writeback: Modify drm_writeback_queue_job helper
  drm: writeback: Modify drm_writeback_signal_completion helper
  drm: writeback: Modify drm_writeback_get_out_fence helper
  drm: writeback: Modify prepare_writeback_job helper
  drm: writeback: Modify cleanup_writeback_job helper

 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c |   8 +-
 .../gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.h |   3 +-
 .../display/amdgpu_dm/amdgpu_dm_connector.c   |   4 +-
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c  |  37 ++--
 .../drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h  |   4 +-
 .../tests/amdgpu_dm_connector_test.c          |   6 +-
 .../display/amdgpu_dm/tests/amdgpu_dm_test.c  |   2 +-
 .../amdgpu_dm/tests/amdgpu_dm_wb_test.c       |  10 +-
 .../gpu/drm/arm/display/komeda/komeda_crtc.c  |   2 +-
 .../gpu/drm/arm/display/komeda/komeda_kms.h   |   9 +-
 .../arm/display/komeda/komeda_wb_connector.c  |  37 ++--
 drivers/gpu/drm/arm/malidp_crtc.c             |   2 +-
 drivers/gpu/drm/arm/malidp_drv.h              |   3 +-
 drivers/gpu/drm/arm/malidp_mw.c               |  32 ++-
 drivers/gpu/drm/drm_atomic_uapi.c             |   4 +-
 drivers/gpu/drm/drm_connector.c               |   3 +
 drivers/gpu/drm/drm_crtc_internal.h           |   3 +
 drivers/gpu/drm/drm_writeback.c               | 193 ++++++------------
 .../drm/msm/disp/dpu1/dpu_encoder_phys_wb.c   |   9 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c |  10 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.h |   4 +-
 .../gpu/drm/renesas/rcar-du/rcar_du_crtc.h    |   8 +-
 .../drm/renesas/rcar-du/rcar_du_writeback.c   |  44 ++--
 drivers/gpu/drm/vc4/vc4_txp.c                 |  16 +-
 drivers/gpu/drm/vkms/vkms_drv.h               |   2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c         |  15 +-
 include/drm/drm_connector.h                   |  69 ++++++-
 include/drm/drm_modeset_helper_vtables.h      |   4 +-
 include/drm/drm_writeback.h                   |  98 +--------
 29 files changed, 307 insertions(+), 334 deletions(-)

-- 
2.34.1

