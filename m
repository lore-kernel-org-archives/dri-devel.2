Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00C21CD5BA6
	for <dri-devel@archiver.kernel.org>; Thu, 21 May 2026 05:37:40 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 43D8610F1FA;
	Thu, 21 May 2026 05:37:40 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=intel.com header.i=@intel.com header.b="VMeY5vVJ";
	dkim-atps=neutral
Received: from mgamail.intel.com (mgamail.intel.com [192.198.163.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 506A910F1D9;
 Thu, 21 May 2026 05:37:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1779341858; x=1810877858;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=g8XquSItCm3+Atlh5azjfVg0r6Fht4I2+rcXNLhgaLE=;
 b=VMeY5vVJFIeW/L3vuZbpoXS904q63hk60TTYPB3UKlOgOuP1wR3KvIPK
 zSrhzAN7CuxnBf7TXEb+PFfncaYyOD5qVfuqtrPLNPVZVV4S2m4eQCW2T
 5DLu9SheFlTisa8a+vqg6Vd6PTCIk6uhunESFmIBAsDamKMvBa5K3+Y6g
 w/r4ZwkBIXgLPkO5fIi6f4kksKENih0IWU40Dno7LkbwW4B8MGeBV8Y74
 8tuRm1puPTZ5lx3TSLKmtPKlYLt3rMtn6zgr5VhPSVaEAlXS94FH5Efgl
 QbX5A2+ICGTlT3asITQ6BluZn0xSp8QONGul5fXAKkqLr+1XXmjkNuIKh w==;
X-CSE-ConnectionGUID: 2DlM54oPRK2vI73aPBlQSQ==
X-CSE-MsgGUID: Ruzjb27RRDmSrYO3JcZysA==
X-IronPort-AV: E=McAfee;i="6800,10657,11792"; a="80286439"
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="80286439"
Received: from orviesa005.jf.intel.com ([10.64.159.145])
 by fmvoesa108.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 20 May 2026 22:37:38 -0700
X-CSE-ConnectionGUID: alItOd0qSI6333WEciyU/A==
X-CSE-MsgGUID: 3os7LYGKRZ6/2eR+WFcofA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.23,245,1770624000"; d="scan'208";a="245420596"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by orviesa005.jf.intel.com with ESMTP; 20 May 2026 22:37:33 -0700
From: Suraj Kandpal <suraj.kandpal@intel.com>
To: freedreno@lists.freedesktop.org, dri-devel@lists.freedesktop.org,
 kernel-list@raspberrypi.com, amd-gfx@lists.freedesktop.org,
 linux-kernel@vger.kernel.org, intel-xe@lists.freedesktop.org,
 intel-gfx@lists.freedesktop.org
Cc: abhinav.kumar@linux.dev, tzimmermann@suse.de, sean@poorly.ru,
 marijn.suijten@somainline.org, laurent.pinchart+renesas@ideasonboard.com,
 dave.stevenson@raspberrypi.com, tomi.valkeinen+renesas@ideasonboard.com,
 kieran.bingham+renesas@ideasonboard.com,
 Louis Chauvet <louis.chauvet@bootlin.com>, kernel-dev@igalia.com,
 John.Harrison@Igalia.com, Suraj Kandpal <suraj.kandpal@intel.com>,
 Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Subject: [PATCH v4 3/7] drm: writeback: Modify drm_writeback_queue_job helper
Date: Thu, 21 May 2026 11:07:04 +0530
Message-Id: <20260521053708.1475129-4-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260521053708.1475129-1-suraj.kandpal@intel.com>
References: <20260521053708.1475129-1-suraj.kandpal@intel.com>
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

drm_writeback_queue_job() needs access to the parent drm_connector
object as well as the drm_writeback_connector object itself. So,
pass in the top level drm_connector and traverse down to
drm_writeback_connector rather than passing in the lower level
object and traversing back up. This is also consistent with the
rest of the writeback interface which is being updated to use
drm_connector as the top level handle.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
---
v3 -> v4:
- Update subject line for consitency (John)
- Update commit message across commits for consitency (John)

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c    | 2 +-
 drivers/gpu/drm/arm/malidp_mw.c                     | 3 +--
 drivers/gpu/drm/drm_writeback.c                     | 6 ++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 2 +-
 drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 2 +-
 drivers/gpu/drm/vc4/vc4_txp.c                       | 2 +-
 drivers/gpu/drm/vkms/vkms_writeback.c               | 3 +--
 include/drm/drm_writeback.h                         | 2 +-
 9 files changed, 12 insertions(+), 12 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index 27c59ef18c30..f5154b10e50f 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -10988,7 +10988,7 @@ static void dm_set_writeback(struct amdgpu_display_manager *dm,
 
 	acrtc->wb_pending = true;
 	acrtc->wb_conn = wb_conn;
-	drm_writeback_queue_job(wb_conn, new_con_state);
+	drm_writeback_queue_job(connector, new_con_state);
 }
 
 static void amdgpu_dm_update_hdcp(struct drm_atomic_commit *state)
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index 6611920c45fb..c64cf5d97e62 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -271,7 +271,7 @@ komeda_crtc_do_flush(struct drm_crtc *crtc,
 
 	conn_st = wb_conn ? wb_conn->base.state : NULL;
 	if (conn_st && conn_st->writeback_job)
-		drm_writeback_queue_job(&wb_conn->base.writeback, conn_st);
+		drm_writeback_queue_job(&wb_conn->base, conn_st);
 
 	/* step 2: notify the HW to kickoff the update */
 	mdev->funcs->flush(mdev, master->id, kcrtc_st->active_pipes);
diff --git a/drivers/gpu/drm/arm/malidp_mw.c b/drivers/gpu/drm/arm/malidp_mw.c
index c6d11c7af1e4..0f419b2b79ab 100644
--- a/drivers/gpu/drm/arm/malidp_mw.c
+++ b/drivers/gpu/drm/arm/malidp_mw.c
@@ -243,7 +243,6 @@ void malidp_mw_atomic_commit(struct drm_device *drm,
 			     struct drm_atomic_commit *old_state)
 {
 	struct malidp_drm *malidp = drm_to_malidp(drm);
-	struct drm_writeback_connector *mw_conn = &malidp->mw_connector.writeback;
 	struct drm_connector_state *conn_state = malidp->mw_connector.state;
 	struct malidp_hw_device *hwdev = malidp->dev;
 	struct malidp_mw_connector_state *mw_state;
@@ -263,7 +262,7 @@ void malidp_mw_atomic_commit(struct drm_device *drm,
 				     &mw_state->addrs[0],
 				     mw_state->format);
 
-		drm_writeback_queue_job(mw_conn, conn_state);
+		drm_writeback_queue_job(&malidp->mw_connector, conn_state);
 		hwdev->hw->enable_memwrite(hwdev, mw_state->addrs,
 					   mw_state->pitches, mw_state->n_planes,
 					   fb->width, fb->height, mw_state->format,
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 9a3037d11009..1c1802d87f13 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -404,7 +404,8 @@ EXPORT_SYMBOL(drm_writeback_prepare_job);
 
 /**
  * drm_writeback_queue_job - Queue a writeback job for later signalling
- * @wb_connector: The writeback connector to queue a job on
+ * @connector: The drm connector  which contains the writeback connector to
+ * queue a job on
  * @conn_state: The connector state containing the job to queue
  *
  * This function adds the job contained in @conn_state to the job_queue for a
@@ -421,9 +422,10 @@ EXPORT_SYMBOL(drm_writeback_prepare_job);
  *
  * See also: drm_writeback_signal_completion()
  */
-void drm_writeback_queue_job(struct drm_writeback_connector *wb_connector,
+void drm_writeback_queue_job(struct drm_connector *connector,
 			     struct drm_connector_state *conn_state)
 {
+	struct drm_writeback_connector *wb_connector = &connector->writeback;
 	struct drm_writeback_job *job;
 	unsigned long flags;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index e2a328225c9e..0a4026f22274 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -486,7 +486,7 @@ static void dpu_encoder_phys_wb_prepare_for_kickoff(
 	state = drm_conn->state;
 
 	if (wb_enc->wb_conn && wb_enc->wb_job)
-		drm_writeback_queue_job(wb_enc->wb_conn, state);
+		drm_writeback_queue_job(drm_conn, state);
 
 	dpu_encoder_phys_wb_setup(phys_enc);
 
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index 6b27307941a4..5cd6c81a9710 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -246,7 +246,7 @@ void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
 		cfg->mem[i] = sg_dma_address(rjob->sg_tables[i].sgl)
 			    + fb->offsets[i];
 
-	drm_writeback_queue_job(&rcrtc->wb_connector.writeback, state);
+	drm_writeback_queue_job(&rcrtc->wb_connector, state);
 }
 
 void rcar_du_writeback_complete(struct rcar_du_crtc *rcrtc)
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index c762b93738d3..46330b6f9a12 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -357,7 +357,7 @@ static void vc4_txp_connector_atomic_commit(struct drm_connector *conn,
 
 	TXP_WRITE(TXP_DST_CTRL, ctrl);
 
-	drm_writeback_queue_job(&txp->connector.writeback, conn_state);
+	drm_writeback_queue_job(&txp->connector, conn_state);
 
 	drm_dev_exit(idx);
 }
diff --git a/drivers/gpu/drm/vkms/vkms_writeback.c b/drivers/gpu/drm/vkms/vkms_writeback.c
index 9341533b0325..2e3df9388dd2 100644
--- a/drivers/gpu/drm/vkms/vkms_writeback.c
+++ b/drivers/gpu/drm/vkms/vkms_writeback.c
@@ -131,7 +131,6 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	struct drm_connector_state *connector_state = drm_atomic_get_new_connector_state(state,
 											 conn);
 	struct vkms_output *output = drm_crtc_to_vkms_output(connector_state->crtc);
-	struct drm_writeback_connector *wb_conn = &output->wb_connector.writeback;
 	struct drm_connector_state *conn_state = output->wb_connector.state;
 	struct vkms_crtc_state *crtc_state = output->composer_state;
 	struct drm_framebuffer *fb = connector_state->writeback_job->fb;
@@ -153,7 +152,7 @@ static void vkms_wb_atomic_commit(struct drm_connector *conn,
 	crtc_state->active_writeback = active_wb;
 	crtc_state->wb_pending = true;
 	spin_unlock_irq(&output->composer_lock);
-	drm_writeback_queue_job(wb_conn, connector_state);
+	drm_writeback_queue_job(&output->wb_connector, connector_state);
 	active_wb->pixel_write = get_pixel_write_function(wb_format);
 	drm_rect_init(&wb_frame_info->src, 0, 0, crtc_width, crtc_height);
 	drm_rect_init(&wb_frame_info->dst, 0, 0, crtc_width, crtc_height);
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index c6960c7e634e..b4c11d380df0 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -94,7 +94,7 @@ int drm_writeback_set_fb(struct drm_connector_state *conn_state,
 
 int drm_writeback_prepare_job(struct drm_writeback_job *job);
 
-void drm_writeback_queue_job(struct drm_writeback_connector *wb_connector,
+void drm_writeback_queue_job(struct drm_connector *wb_connector,
 			     struct drm_connector_state *conn_state);
 
 void drm_writeback_cleanup_job(struct drm_writeback_job *job);
-- 
2.34.1

