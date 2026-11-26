Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C858606A31C
	for <dri-devel@archiver.kernel.org>; Thu, 26 Nov 2026 04:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=intel.com header.i=@intel.com header.a=rsa-sha256 header.s=Intel header.b=nCEHWZNf
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id AC85F10E925;
	Thu, 26 Nov 2026 04:29:19 +0000 (UTC)
Received: from mgamail.intel.com (mgamail.intel.com [198.175.65.14])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 565C510E925;
 Thu, 26 Nov 2026 04:29:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
 d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
 t=1795667354; x=1827203354;
 h=from:to:cc:subject:date:message-id:in-reply-to:
 references:mime-version:content-transfer-encoding;
 bh=Bt9NFNtQXe1HDzT+V+VDfnLdD9tpBQ7s6IOSxy0yJPI=;
 b=nCEHWZNf3apEX1TbcNGeSMEdVQtWBM7ATNF03eo2mW/12ds8ZKWNu/Mz
 0Xktga8elnmIfozCEtoso/lHP1T0I2+TTFpUfkdEyzc4kQJ2eNXPJBuGu
 Pu8nIQVpXgBjj9TDiMhM0wjbtN90pLL8F1VPqR+Iy2Tm0QtKy0/Cz/T5/
 bxeBlR65Sn5UtzDmHqCrT+FNgRW4xg+/nxNJ8kbCODaOc1AlyeSW4mft/
 hTNPvvzCxhKX1sZQrk66R0wnQwv2AyG5kZoz9aEc7W3lpNxiOt9iYCThq
 sVBGS5Anj1399ZTBTgnpX9qzId/UACEIPfeHqXtTVdeSUL23pF7qXx5xI w==;
X-CSE-ConnectionGUID: aMgzD7CSQSCziL7+c/zDDA==
X-CSE-MsgGUID: jwzNvPLUSmeuRqyiEN5ysg==
X-IronPort-AV: E=McAfee;i="6800,10657,11977"; a="4472771"
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; 
   d="scan'208";a="4472771"
Received: from fmviesa003.fm.intel.com ([10.60.135.143])
 by orvoesa106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384;
 25 Nov 2026 20:29:14 -0800
X-CSE-ConnectionGUID: +IiETmXvT96lo4BLeKTbMg==
X-CSE-MsgGUID: qwV5TvMqScuoenYm8CnRYQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="6.27,234,1787036400"; d="scan'208";a="12287721"
Received: from kandpal-x299-ud4-pro.iind.intel.com ([10.190.239.10])
 by fmviesa003.fm.intel.com with ESMTP; 25 Nov 2026 20:29:06 -0800
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
Subject: [PATCH v8 4/7] drm: writeback: Modify drm_writeback_signal_completion
 helper
Date: Thu, 26 Nov 2026 09:58:32 +0530
Message-Id: <20261126042835.436307-5-suraj.kandpal@intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20261126042835.436307-1-suraj.kandpal@intel.com>
References: <20261126042835.436307-1-suraj.kandpal@intel.com>
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

drm_writeback_signal_completion() needs access to the parent
drm_connector object as well as the drm_writeback_connector object
itself. So, pass in the top level drm_connector and traverse down
to drm_writeback_connector rather than passing in the lower level
object and traversing back up. Update to use the top level object
for consistency across the writeback interface.

Signed-off-by: Suraj Kandpal <suraj.kandpal@intel.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@oss.qualcomm.com>
Reviewed-by: John Harrison <John.Harrison@Igalia.com>
---
v6 -> v7:
- Rebase over latest kernel
- Rebase over latest writeback series by Dmitry
- Fix null pointer dereference (Alex)

v5 -> v6:
- Rebase over latest kernel

v4 -> v5:
- Make @connector kerneldoc wording consistent across the series (John)

v3 -> v4:
- Update subject line for consitency (John)
- Update commit message across commits for consitency (John)

 drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c   | 2 +-
 drivers/gpu/drm/arm/display/komeda/komeda_crtc.c    | 2 +-
 drivers/gpu/drm/arm/malidp_hw.c                     | 6 +++---
 drivers/gpu/drm/drm_writeback.c                     | 6 ++++--
 drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c | 4 ++--
 drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c | 2 +-
 drivers/gpu/drm/vc4/vc4_txp.c                       | 2 +-
 drivers/gpu/drm/vkms/vkms_composer.c                | 2 +-
 include/drm/drm_writeback.h                         | 2 +-
 9 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
index d51b4bac1dcd..17abf739acad 100644
--- a/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
+++ b/drivers/gpu/drm/amd/display/amdgpu_dm/amdgpu_dm.c
@@ -4545,7 +4545,7 @@ bool amdgpu_dm_crtc_complete_writeback(struct amdgpu_crtc *acrtc)
 	if (!pending)
 		return false;
 
-	drm_writeback_signal_completion(acrtc->wb_conn, 0);
+	drm_writeback_signal_completion(drm_writeback_to_connector(acrtc->wb_conn), 0);
 	drm_crtc_vblank_put(&acrtc->base);
 
 	return true;
diff --git a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
index fd35f81dfca8..21445385b245 100644
--- a/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
+++ b/drivers/gpu/drm/arm/display/komeda/komeda_crtc.c
@@ -214,7 +214,7 @@ void komeda_crtc_handle_event(struct komeda_crtc   *kcrtc,
 		struct komeda_wb_connector *wb_conn = kcrtc->wb_conn;
 
 		if (wb_conn)
-			drm_writeback_signal_completion(&wb_conn->base.writeback, 0);
+			drm_writeback_signal_completion(&wb_conn->base, 0);
 		else
 			drm_warn(drm, "CRTC[%d]: EOW happen but no wb_connector.\n",
 				 drm_crtc_index(&kcrtc->base));
diff --git a/drivers/gpu/drm/arm/malidp_hw.c b/drivers/gpu/drm/arm/malidp_hw.c
index 5a7bd27d3718..9b845d3f34e1 100644
--- a/drivers/gpu/drm/arm/malidp_hw.c
+++ b/drivers/gpu/drm/arm/malidp_hw.c
@@ -1315,15 +1315,15 @@ static irqreturn_t malidp_se_irq(int irq, void *arg)
 	if (status & se->vsync_irq) {
 		switch (hwdev->mw_state) {
 		case MW_ONESHOT:
-			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
+			drm_writeback_signal_completion(&malidp->mw_connector, 0);
 			break;
 		case MW_STOP:
-			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
+			drm_writeback_signal_completion(&malidp->mw_connector, 0);
 			/* disable writeback after stop */
 			hwdev->mw_state = MW_NOT_ENABLED;
 			break;
 		case MW_RESTART:
-			drm_writeback_signal_completion(&malidp->mw_connector.writeback, 0);
+			drm_writeback_signal_completion(&malidp->mw_connector, 0);
 			fallthrough;	/* to a new start */
 		case MW_START:
 			/* writeback started, need to emulate one-shot mode */
diff --git a/drivers/gpu/drm/drm_writeback.c b/drivers/gpu/drm/drm_writeback.c
index 5d19d7852e7f..77f7955f955a 100644
--- a/drivers/gpu/drm/drm_writeback.c
+++ b/drivers/gpu/drm/drm_writeback.c
@@ -458,7 +458,8 @@ static void cleanup_work(struct work_struct *work)
 
 /**
  * drm_writeback_signal_completion - Signal the completion of a writeback job
- * @wb_connector: The writeback connector whose job is complete
+ * @connector: DRM connector which contains the writeback connector whose
+ * job is complete
  * @status: Status code to set in the writeback out_fence (0 for success)
  *
  * Drivers should call this to signal the completion of a previously queued
@@ -473,10 +474,11 @@ static void cleanup_work(struct work_struct *work)
  * See also: drm_writeback_queue_job()
  */
 void
-drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector,
+drm_writeback_signal_completion(struct drm_connector *connector,
 				int status)
 {
 	unsigned long flags;
+	struct drm_writeback_connector *wb_connector = &connector->writeback;
 	struct drm_writeback_job *job;
 	struct dma_fence *out_fence;
 
diff --git a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
index 0a4026f22274..977fc0337fbd 100644
--- a/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
+++ b/drivers/gpu/drm/msm/disp/dpu1/dpu_encoder_phys_wb.c
@@ -370,7 +370,7 @@ static void dpu_encoder_phys_wb_done_irq(void *arg)
 	spin_unlock_irqrestore(phys_enc->enc_spinlock, lock_flags);
 
 	if (wb_enc->wb_conn)
-		drm_writeback_signal_completion(wb_enc->wb_conn, 0);
+		drm_writeback_signal_completion(drm_writeback_to_connector(wb_enc->wb_conn), 0);
 
 	/* Signal any waiting atomic commit thread */
 	wake_up_all(&phys_enc->pending_kickoff_wq);
@@ -431,7 +431,7 @@ static void _dpu_encoder_phys_wb_handle_wbdone_timeout(
 	phys_enc->enable_state = DPU_ENC_ERR_NEEDS_HW_RESET;
 
 	if (wb_enc->wb_conn)
-		drm_writeback_signal_completion(wb_enc->wb_conn, 0);
+		drm_writeback_signal_completion(drm_writeback_to_connector(wb_enc->wb_conn), 0);
 
 	dpu_encoder_frame_done_callback(phys_enc->parent, phys_enc, frame_event);
 }
diff --git a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
index c3802bbced16..02e74048d00f 100644
--- a/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
+++ b/drivers/gpu/drm/renesas/rcar-du/rcar_du_writeback.c
@@ -258,5 +258,5 @@ void rcar_du_writeback_setup(struct rcar_du_crtc *rcrtc,
 
 void rcar_du_writeback_complete(struct rcar_du_crtc *rcrtc)
 {
-	drm_writeback_signal_completion(&rcrtc->wb_connector.writeback, 0);
+	drm_writeback_signal_completion(&rcrtc->wb_connector, 0);
 }
diff --git a/drivers/gpu/drm/vc4/vc4_txp.c b/drivers/gpu/drm/vc4/vc4_txp.c
index 584610e1628f..7b9f9828ea4e 100644
--- a/drivers/gpu/drm/vc4/vc4_txp.c
+++ b/drivers/gpu/drm/vc4/vc4_txp.c
@@ -505,7 +505,7 @@ static irqreturn_t vc4_txp_interrupt(int irq, void *data)
 	 */
 	TXP_WRITE(TXP_DST_CTRL, TXP_READ(TXP_DST_CTRL) & ~TXP_EI);
 	vc4_crtc_handle_vblank(vc4_crtc);
-	drm_writeback_signal_completion(&txp->connector.writeback, 0);
+	drm_writeback_signal_completion(&txp->connector, 0);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/gpu/drm/vkms/vkms_composer.c b/drivers/gpu/drm/vkms/vkms_composer.c
index 85724e380c2e..7a6a7875520c 100644
--- a/drivers/gpu/drm/vkms/vkms_composer.c
+++ b/drivers/gpu/drm/vkms/vkms_composer.c
@@ -745,7 +745,7 @@ void vkms_composer_worker(struct work_struct *work)
 		return;
 
 	if (wb_pending) {
-		drm_writeback_signal_completion(&out->wb_connector.writeback, 0);
+		drm_writeback_signal_completion(&out->wb_connector, 0);
 		spin_lock_irq(&out->composer_lock);
 		crtc_state->wb_pending = false;
 		spin_unlock_irq(&out->composer_lock);
diff --git a/include/drm/drm_writeback.h b/include/drm/drm_writeback.h
index b4c11d380df0..5e8ab51c2da4 100644
--- a/include/drm/drm_writeback.h
+++ b/include/drm/drm_writeback.h
@@ -100,7 +100,7 @@ void drm_writeback_queue_job(struct drm_connector *wb_connector,
 void drm_writeback_cleanup_job(struct drm_writeback_job *job);
 
 void
-drm_writeback_signal_completion(struct drm_writeback_connector *wb_connector,
+drm_writeback_signal_completion(struct drm_connector *connector,
 				int status);
 
 struct dma_fence *
-- 
2.34.1

