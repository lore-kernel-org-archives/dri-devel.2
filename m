Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0F7E9F013D0
	for <dri-devel@archiver.kernel.org>; Mon, 16 Mar 2026 08:31:32 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5199710E4A4;
	Mon, 16 Mar 2026 08:31:31 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="Yj/HrSXQ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.13])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 9535C10E387;
 Mon, 16 Mar 2026 08:31:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1773649890; x=1805185890;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=/vdvZ8+JNewyJLC5VPWobT2nRff/AFgHAyyvAiwGErs=;
 b=Yj/HrSXQ+DkFrb4agYOSni7jNWeNQNnSD1qSwMel41nehB2pSAD358ZK
 SKmsqECn6OBDkzKVzO6S0CVyySe8ijhmmJQeUNUVnTeGBkSw8X7TOI+gL
 hwhOzsRe5tRd9FnQci7buxATEOFXR0WwkyN/G2D5LzMUsCmIDf4yL6yaC
 yaijSq+DoqOwhAAB2hlY5h4QxdnituCO8WEbG3fnQmEQCR1B9OGyeL/ZX
 gHeMPKGygT6dVfAXPQ1eb/JSE5tY01sV2Mztug5XIq1KFyRNYEr6/6lkf
 0nRbv3sMWhX9Gfz2QUZcd0EeiYhtObMNpjVd/AQAuurXZ4CBt7DKM1JNd w==;
X-CSE-ConnectionGUID: ypgHGPMfSYCd8Ku4ccbUkg==
X-CSE-MsgGUID: LcIs08G3TwaV6oW/AXv+XQ==
X-IronPort-AV: E=McAfee;i="6800,10657,11730"; a="77268370"
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="77268370"
Received: from orviesa006.jf.intel.com ([10.64.159.146])
 by fmvoesa107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 16 Mar 2026 01:31:29 -0700
X-CSE-ConnectionGUID: UYF//OnvROu3s89iesGXgQ==
X-CSE-MsgGUID: ZwiqnZgNQRyw7rUdPnhmjg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,123,1770624000"; d="scan'208";a="220889095"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by orviesa006.jf.intel.com with ESMTP; 16 Mar 2026 01:31:20 -0700
From: Suraj Kandpal <suraj.kandpal@intel.com>
To: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: ankit.k.nautiyal@intel.com, uma.shankar@intel.com,
 dmitry.baryshkov@oss.qualcomm.com, arun.r.murthy@intel.com,
 jani.nikula@intel.com, harry.wentland@amd.com, siqueira@igalia.com,
 alexander.deucher@amd.com, christian.koenig@amd.com, airlied@gmail.com,
 simona@ffwll.ch, liviu.dudau@arm.com, maarten.lankhorst@linux.intel.com,
 mripard@kernel.org, robin.clark@oss.qualcomm.com, abhinav.kumar@linux.dev,
 tzimmermann@suse.de, sean@poorly.ru, marijn.suijten@somainline.org,
 laurent.pinchart+renesas@ideasonboard.com, dave.stevenson@raspberrypi.com,
 tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com,
 Suraj Kandpal <suraj.kandpal@intel.com>
Subject: [PATCH v3 6/7] drm/connector: Modify prepare_writeback_job helper
Date: Mon, 16 Mar 2026 14:00:08 +0530
Message-Id: <20260316083008.87466-7-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260316083008.87466-1-suraj.kandpal@intel.com>
References: <20260316083008.87466-1-suraj.kandpal@intel.com>
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

Pass drm_connector to prepare_writeback_job since
drm_writeback_connector now resides within drm_connector.
It also makes it uniform with params passed to other
drm_connector_helper_funcs.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
---
 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c | 2 +-
 drivers/gpu/drm/drm_writeback.c                      | 2 +-
 drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c        | 4 +---
 drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c  | 6 ++----
 drivers/gpu/drm/vkms/vkms_writeback.c                | 2 +-
 include/drm/drm_modeset_helper_vtables.h             | 2 +-
 6 files changed, 7 insertions(+), 11 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
index 84a9c1d2bd8e..d02f5d20f3b1 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm_wb.c
@@ -80,7 +80,7 @@ static int amdgpu_dm_wb_connector_get_modes(struct drm_connector *connector)
 	return drm_add_modes_noedid(connector, 3840, 2160);
 }
 
-static int amdgpu_dm_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+static int amdgpu_dm_wb_prepare_job(struct drm_connector *connector,
 			       struct drm_writeback_job *job)
 {
 	struct amdgpu_framebuffer *afb;
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 15a680ba98ae..d6b260478889 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -392,7 +392,7 @@ int drm_writeback_prepare_job(struct drm_writeback_job *job)
 	int ret;
 
 	if (funcs->prepare_writeback_job) {
-		ret = funcs->prepare_writeback_job(wb_connector, job);
+		ret = funcs->prepare_writeback_job(connector, job);
 		if (ret < 0)
 			return ret;
 	}
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
index d4fc28951085..b8b299067845 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_writeback.c
@@ -87,11 +87,9 @@ static const struct drm_connector_funcs dpu_wb_conn_funcs = {
 	.atomic_destroy_state = drm_atomic_helper_connector_destroy_state,
 };
 
-static int dpu_wb_conn_prepare_job(struct drm_writeback_connector *wb_conn,
+static int dpu_wb_conn_prepare_job(struct drm_connector *connector,
 		struct drm_writeback_job *job)
 {
-	struct drm_connector *connector =
-		container_of(wb_conn, struct drm_connector, writeback);
 	struct dpu_wb_connector *dpu_wb_conn = to_dpu_wb_conn(connector);
 
 	if (!job->fb)
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index e874732f4d01..a0ad4c97971e 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -47,12 +47,10 @@ static int rcar_du_wb_conn_get_modes(struct drm_connector *connector)
 				    dev->mode_config.max_height);
 }
 
-static int rcar_du_wb_prepare_job(struct drm_writeback_connector *connector,
+static int rcar_du_wb_prepare_job(struct drm_connector *connector,
 				  struct drm_writeback_job *job)
 {
-	struct drm_connector *conn =
-		drm_writeback_to_connector(connector);
-	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(conn);
+	struct rcar_du_crtc *rcrtc = wb_to_rcar_crtc(connector);
 	struct rcar_du_wb_job *rjob;
 	int ret;
 
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 59d44c759785..ebfd243e2c1a 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -72,7 +72,7 @@ static int vkms_wb_connector_get_modes(struct drm_connector *connector)
 				    dev->mode_config.max_height);
 }
 
-static int vkms_wb_prepare_job(struct drm_writeback_connector *wb_connector,
+static int vkms_wb_prepare_job(struct drm_connector *connector,
 			       struct drm_writeback_job *job)
 {
 	struct vkms_writeback_job *vkmsjob;
diff --git a/include/drm/drm_modeset_helper_vtables.h b/include/drm/drm_modeset_helper_vtables.h
index 3e68213958dd..9de96a04784e 100644
--- a/include/drm/drm_modeset_helper_vtables.h
+++ b/include/drm/drm_modeset_helper_vtables.h
@@ -1119,7 +1119,7 @@ struct drm_connector_helper_funcs {
 	 *
 	 * This callback is used by the atomic modeset helpers.
 	 */
-	int (*prepare_writeback_job)(struct drm_writeback_connector *connector,
+	int (*prepare_writeback_job)(struct drm_connector *connector,
 				     struct drm_writeback_job *job);
 	/**
 	 * @cleanup_writeback_job:
-- 
2.34.1

