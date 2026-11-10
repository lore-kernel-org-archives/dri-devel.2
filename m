Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26270606A325
	for <dri-devel@archiver.kernel.org>; Tue, 10 Nov 2026 06:18:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=cUChSNbw
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 57C3B10EE34;
	Tue, 10 Nov 2026 06:17:55 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 2293210EE0B;
 Tue, 10 Nov 2026 06:17:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1794291468; x=1825827468;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=QedGAz6xqU07cdwi37X7wfVwdw1FT28mPhTh+sQwCYs=;
 b=cUChSNbw7C6jQqXtoOUwxhcDe1QNSNlaDNA/+Z6NLVi2R6o57jxHn9pZ
 /C9rlNCxMRqVUuJwiqLBx8l+VC9yADA3vrpqzq1hBpXn4D68ORxz2nMij
 GWliDTGZdj8dwxEFAW/NdXLNwnaKfVC2ictzm4t3ggheygV9Hb/Gvu4Qd
 Hjy4lr5kgWc+XiBIN8X9CT/eRBVDAHV5lGFG7d32jdlIn75NLSbmKjxLW
 FPD571zMS3C4ahvL8tzW6+MViFTuU+Zzj8QY56z+NdChx/3vYJ04AkdOO
 v8ALy3JMXrJ/rsQvkOVBLejcMRyVRSGgwqhUMYTY7CFaegqz62rRChc3L w==;
X-CSE-ConnectionGUID: Qq9h0ORSRI6Pf3FAQ8K42g==
X-CSE-MsgGUID: DeTU7170RwKb7Hp24yRVKA==
X-IronPort-AV: E=McAfee;i="6800,10657,11961"; a="3021037"
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="3021037"
Received: from orviesa004.jf.intel.com ([10.64.159.144])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 09 Nov 2026 22:17:47 -0800
X-CSE-ConnectionGUID: iPZLlZKGRyiHKDv8Krj3PQ==
X-CSE-MsgGUID: zQbwIy0RSyKDryRwgJxZ3g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,205,1787036400"; 
   d="scan'208";a="7931050"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by orviesa004.jf.intel.com with ESMTP; 09 Nov 2026 22:17:42 -0800
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
Subject: [PATCH v7 8/8] drm: writeback: Modify cleanup_writeback_job helper
Date: Tue, 10 Nov 2026 11:46:37 +0530
Message-Id: <20261110061637.2500929-9-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261110061637.2500929-1-suraj.kandpal@intel.com>
References: <20261110061637.2500929-1-suraj.kandpal@intel.com>
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

The cleanup_writeback_job() connector helper hook needs access to
the parent drm_connector object as well as the drm_writeback_connector
object itself. So, pass in the top level drm_connector and traverse
down to drm_writeback_connector rather than passing in the lower
level object and traversing back up. This also makes it uniform
with the params passed to other drm_connector_helper_funcs hooks.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: John Harrison <John.Harrison@Igalia.com>
Reviewed-by: Alex Hung <alex.hung@amd.com>
---
v6 -> v7:
- Rebase over latest kernel
- Rebase over latest writeback series by Dmitry

v5 -> v6:
- Rebase over latest kernel

v3 -> v4:
- Update subject line for consitency (John)
- Update commit message across commits for consitency (John)

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 2 +-
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h | 2 +-
 drivers/gpu/drm/drm_writeback.c                      | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c        | 3 +--
 drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c  | 5 ++---
 drivers/gpu/drm/vkms/vkms_writeback.c                | 5 +----
 include/drm/drm_modeset_helper_vtables.h             | 2 +-
 7 files changed, 8 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index afed660762fd..90ffa9e83957 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -196,7 +196,7 @@ STATIC_IFN_KUNIT int amdgpu_dm_wb_prepare_job(struct drm_connector *wb_connector
 }
 EXPORT_IF_KUNIT(amdgpu_dm_wb_prepare_job);
 
-STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
+STATIC_IFN_KUNIT void amdgpu_dm_wb_cleanup_job(struct drm_connector *connector,
 				struct drm_writeback_job *job)
 {
 	struct amdgpu_bo *rbo;
diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
index ede7ff007ad7..4050d83a2a95 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.h
@@ -61,7 +61,7 @@ int amdgpu_dm_wb_encoder_atomic_check(struct drm_encoder *encoder,
 int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector);
 int amdgpu_dm_wb_prepare_job(struct drm_connector *wb_connector,
 			     struct drm_writeback_job *job);
-void amdgpu_dm_wb_cleanup_job(struct drm_writeback_connector *connector,
+void amdgpu_dm_wb_cleanup_job(struct drm_connector *connector,
 			      struct drm_writeback_job *job);
 void amdgpu_dm_wb_kunit_set_ops(const struct amdgpu_dm_wb_kunit_ops *ops);
 #endif
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index f54ee84c2e8a..815eb63c2d56 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -423,7 +423,7 @@ void drm_writeback_cleanup_job(struct drm_writeback_job *job)
 		connector->helper_private;
 
 	if (job->prepared && funcs->cleanup_writeback_job)
-		funcs->cleanup_writeback_job(wb_connector, job);
+		funcs->cleanup_writeback_job(connector, job);
 
 	if (job->fb)
 		drm_framebuffer_put(job->fb);
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index 88227aa7ee69..44797c9443ac 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -100,10 +100,9 @@ static int dpu_wb_conn_prepare_job(struct drm_connector *connector,
 	return 0;
 }
 
-static void dpu_wb_conn_cleanup_job(struct drm_writeback_connector *wb_connector,
+static void dpu_wb_conn_cleanup_job(struct drm_connector *connector,
 		struct drm_writeback_job *job)
 {
-	struct drm_connector *connector = drm_writeback_to_connector(wb_connector);
 	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
 
 	if (!job->fb)
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index 6c4685147e49..d6171fb5eb9a 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -72,11 +72,10 @@ static int rcar_du_wb_prepare_job(struct drm_connector *connector,
 	return 0;
 }
 
-static void rcar_du_wb_cleanup_job(struct drm_writeback_connector *connector,
+static void rcar_du_wb_cleanup_job(struct drm_connector *connector,
 				   struct drm_writeback_job *job)
 {
-	struct drm_connector *conn = drm_writeback_to_connector(connector);
-	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(conn);
+	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(connector);
 	struct rcar_du_wb_job *rjob = job->priv;
 
 	if (!job->fb)
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index be67b13e7347..c805fcf78163 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -103,13 +103,10 @@ static int vkms_wb_prepare_job(struct drm_connector *connector,
 	return ret;
 }
 
-static void vkms_wb_cleanup_job(struct drm_writeback_connector *wb_conn,
+static void vkms_wb_cleanup_job(struct drm_connector *connector,
 				struct drm_writeback_job *job)
 {
 	struct vkms_writeback_job *vkmsjob = job->priv;
-	struct drm_connector *connector = container_of(wb_conn,
-						       struct drm_connector,
-						       writeback);
 	struct vkms_output *vkms_output = container_of(connector,
 						       struct vkms_output,
 						       wb_connector);
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index bff41a1d49a6..0fdba3eded28 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1176,7 +1176,7 @@ struct drm_connector_helper_funcs {
 	 *
 	 * This callback is used by the atomic modeset helpers.
 	 */
-	void (*cleanup_writeback_job)(struct drm_writeback_connector *connector,
+	void (*cleanup_writeback_job)(struct drm_connector *connector,
 				      struct drm_writeback_job *job);
 
 	/**
-- 
2.34.1

