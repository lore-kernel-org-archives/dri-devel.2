Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96389C79F99
	for <dri-devel@archiver.kernel.org>; Tue,  8 Sep 2026 07:20:50 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C9CE410E9E0;
	Tue,  8 Sep 2026 07:20:49 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="uaBJUnJT";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 358D110E9D8;
 Tue,  8 Sep 2026 07:20:48 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 6887H9Jf2043923; Tue, 8 Sep 2026 08:20:38 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=94/7cSjGumKbLVojsGn6txU
 VsvIoMwFl9PmGiw3utUw=; b=uaBJUnJTHOEdpOctawzgNT9G+NNkvRlpZh2+hPM
 vwa48zJ6iY7irQxz4IhCUSfaIN66BO3+ddsT1iMmgpQ31SmS3HhaJMDlrhtuzeW/
 0lhiBaCUhDcUrGMYC2IplcDlUgIzLjx4Mxgh/jj8/d8NTzWMc0hkxO1P4xrXCdsh
 QZReRPRxARTlTs8iaK7rBkfnDLV1dkdjoOA1pgn4aa+g78++j5SN/5LAXEjmhgNK
 5KO0u2QhjmY/xdn2AcMibUXn8G129tFn+blbNWFb9g9RrQRItlyk6ImN5CIrPp+0
 z4Im9WQl4XJJOpU2bySfu4+924bLmDEKhX9M1/2+OUDj+NA==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gg9brj64q-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Tue, 08 Sep 2026 08:20:38 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.88) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Tue, 8 Sep
 2026 08:20:37 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Tue, 8 Sep 2026 10:20:27 +0300
Subject: [PATCH v5] drm/imagination: Propagate all errors from KCCB command
 submission code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260908-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v5-1-5e262721454b@imgtec.com>
X-B4-Tracking: v=1; b=H4sIADq3n2oC/63PTU7DMBAF4KtUXjPIcTxp2hX3QF34Z5wa6jqy0
 6ioyt2xixCgLsPySTPzvbmxTMlTZvvNjSWaffbxXAI+bZg5qvNA4G3JTHDR8b7hoCVcxjwlUgH
 GFEc1qIlAnU5AKcWUwaUY4N0YDSZYyBcdfK5XwURLwK0i6Tg6o5EVZEzk/PVe4PXwlcvKG5mpq
 nXi6PMU08e94dzUue8yzdoycwMNOGcRBUrbWfHiwzCReTYxsNpmFr89udoTxWuxRXTKIlf04LU
 /3o5vV3tt8SRue8UL6Lrdgyf/15PF010vHRayM3//W5blE2GR/f9vAgAA
X-Change-ID: 20260810-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-0dae4f05fcb5
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1788852037; l=11858;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=ZZiwfI+qgl0Hx83CxY1CLvtp9ZhpkXmyRKUDpQ/Fuw4=;
 b=uYiKIBGuvM2hQCvrWAbmuIbu9m855bOsyg5joUhInu8Moz2Qp2356ELu/X4kUs/jHTQBbfou1
 B3yvqOG6m/nCTVyPuVPsilPJmqOBPt9TRV3x5K0FbxXoXk8U2R/zh59
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.88]
X-Proofpoint-GUID: j65CyzqErrl7DmLmIXsFN8hoIMGUbC4h
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTA4MDA3NSBTYWx0ZWRfXzkfbNtDL2z92
 f7ykIYBgPQkJCo9eLrOn/5EVxSwO4R/z+a5jjBwFSDyLrbIDfE1NK5uNpi/2YxrOhqc3BY1c2t/
 t/wk5TaAtT3alvHb5uw8J/tu88bG+G7IJBvFq+4VBddt+qKQxBww4ihW9MIBfy5HOdqVXiQL4iP
 FGxyiGxztqDazP0+kjibWuP6tmIQXDQNHjmwiAvQjCTQ5aIU0iTzuDrMZ9hYBMfEGU1eY9D2Qe7
 I5Mtu2zwzplE1Qw0nUv1CG//Pg2iTLO+HMeQ6PN9UAYkdbTR5zpJ9gxEC7KAk86KQ7cjztUMc54
 CIqPjpM0ZDbissjvX23sqJJ5FUXSG9g1qqB78yRDHHDgF9xsN2gyBiPxSZM7unhWdVNrgWjqeB/
 HbhC7nSU21cnnRYdL/I6F1coyi0JnsieO9J5kspbtbAVDlydxlXRb5Yh6kJE6KBLfqEy+kQb8UM
 h4egYcltxvmic34Nuvg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTA4MDA3NSBTYWx0ZWRfX2KV+a7Ba/EmV
 tK9Ruzz9FLFu+3A1Z36FGCZo2E0A8Ar8RIh8Y6dZ2LboLaRgl0Bj2curnuBYFBt9e2NOLiz8+hS
 kfxfuNXQikiyEhu3MruXhkLK11FMeAo=
X-Proofpoint-ORIG-GUID: j65CyzqErrl7DmLmIXsFN8hoIMGUbC4h
X-Authority-Analysis: v=2.4 cv=ePQbHnp1 c=1 sm=1 tr=0 ts=6a9fb746 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=YP7Kpn5otooA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=-Hwv4S9AhHCUfRXPc_sA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
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

From: Alessio Belle <alessio.belle@imgtec.com>

pvr_kccb_send_cmd_reserved_powered() returned void while the other two
variants of pvr_kccb_send_cmd*() returned int.

The error is now propagated all the way to the DRM scheduler's run_job()
callback, which is the only user of pvr_kccb_send_cmd_reserved_powered()
outside of the other variants of pvr_kccb_send_cmd*().

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
Changes in v5:
- Added pvr_job_release_pm_ref() to the kccb kick command return value
check.
- Update v4 description typo.
- Link to v4: https://patch.msgid.link/20260907-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v4-1-b684f58a06ce@imgtec.com

Changes in v4:
- Added a check over the return value of the kccb kick command.
- Link to v3: https://patch.msgid.link/20260907-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v3-1-4578a0fadf69@imgtec.com

Changes in v3:
- Dropped the job->kccb_fence check since pvr_queue_prepare_job() makes
sure that the check would always be true.
- Dropped the power references from the patch.
- Link to v2: https://patch.msgid.link/20260814-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v2-1-35355fad50ae@imgtec.com

Changes in v2:
- Provide an error path in pvr_queue_run_job(). The path will use
pvr_kccb_release_slot() to avoid resource leaks.
- Link to v1: https://patch.msgid.link/20260811-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v1-1-ffd55254d6d2@imgtec.com

To: Alessio Belle <alessio.belle@imgtec.com>
To: Luigi Santivetti <luigi.santivetti@imgtec.com>
To: Maarten Lankhorst <maarten.lankhorst@linux.intel.com>
To: Maxime Ripard <mripard@kernel.org>
To: Thomas Zimmermann <tzimmermann@suse.de>
To: David Airlie <airlied@gmail.com>
To: Simona Vetter <simona@ffwll.ch>
Cc: imagination@lists.freedesktop.org
Cc: dri-devel@lists.freedesktop.org
Cc: linux-kernel@vger.kernel.org
---
 drivers/gpu/drm/imagination/pvr_ccb.c   | 33 +++++++++++++++++------
 drivers/gpu/drm/imagination/pvr_ccb.h   |  6 ++---
 drivers/gpu/drm/imagination/pvr_cccb.c  | 12 ++++++---
 drivers/gpu/drm/imagination/pvr_cccb.h  | 20 +++++++-------
 drivers/gpu/drm/imagination/pvr_queue.c | 46 +++++++++++++++++++++------------
 5 files changed, 76 insertions(+), 41 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index b702d122d791..dfd068270542 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -257,8 +257,13 @@ pvr_kccb_used_slot_count_locked(struct pvr_device *pvr_dev)
  * @pvr_dev: Device pointer.
  * @cmd: Command to send.
  * @kccb_slot: Address to store the KCCB slot for this command. May be %NULL.
+ *
+ * Returns:
+ * * Zero on success,
+ * * -EIO if the device is lost, or
+ * * -EINVAL if a KCCB slot was not reserved or is not available.
  */
-void
+int
 pvr_kccb_send_cmd_reserved_powered(struct pvr_device *pvr_dev,
 				   struct rogue_fwif_kccb_cmd *cmd,
 				   u32 *kccb_slot)
@@ -268,19 +273,25 @@ pvr_kccb_send_cmd_reserved_powered(struct pvr_device *pvr_dev,
 	struct rogue_fwif_ccb_ctl *ctrl = pvr_ccb->ctrl;
 	u32 old_write_offset;
 	u32 new_write_offset;
+	int err;
 
-	WARN_ON(pvr_dev->lost);
+	if (pvr_dev->lost)
+		return -EIO;
 
 	mutex_lock(&pvr_ccb->lock);
 
-	if (WARN_ON(!pvr_dev->kccb.reserved_count))
+	if (WARN_ON(!pvr_dev->kccb.reserved_count)) {
+		err = -EINVAL;
 		goto out_unlock;
+	}
 
 	old_write_offset = READ_ONCE(ctrl->write_offset);
 
 	/* We reserved the slot, we should have one available. */
-	if (WARN_ON(!pvr_ccb_slot_available_locked(pvr_ccb, &new_write_offset)))
+	if (WARN_ON(!pvr_ccb_slot_available_locked(pvr_ccb, &new_write_offset))) {
+		err = -EINVAL;
 		goto out_unlock;
+	}
 
 	memcpy(&kccb[old_write_offset], cmd,
 	       sizeof(struct rogue_fwif_kccb_cmd));
@@ -298,8 +309,14 @@ pvr_kccb_send_cmd_reserved_powered(struct pvr_device *pvr_dev,
 	pvr_fw_mts_schedule(pvr_dev,
 			    PVR_FWIF_DM_GP & ~ROGUE_CR_MTS_SCHEDULE_DM_CLRMSK);
 
+	mutex_unlock(&pvr_ccb->lock);
+
+	return 0;
+
 out_unlock:
 	mutex_unlock(&pvr_ccb->lock);
+
+	return err;
 }
 
 /**
@@ -365,8 +382,9 @@ static int pvr_kccb_reserve_slot_sync(struct pvr_device *pvr_dev)
  * @kccb_slot: Address to store the KCCB slot for this command. May be %NULL.
  *
  * Returns:
- *  * Zero on success, or
- *  * -EBUSY if timeout while waiting for a free KCCB slot.
+ * * Zero on success,
+ * * Any error returned by pvr_kccb_reserve_slot_sync(), or
+ * * Any error returned by pvr_kccb_send_cmd_reserved_powered().
  */
 int
 pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev, struct rogue_fwif_kccb_cmd *cmd,
@@ -378,8 +396,7 @@ pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev, struct rogue_fwif_kccb_cmd
 	if (err)
 		return err;
 
-	pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
-	return 0;
+	return pvr_kccb_send_cmd_reserved_powered(pvr_dev, cmd, kccb_slot);
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_ccb.h b/drivers/gpu/drm/imagination/pvr_ccb.h
index 4c8aef31eeb0..8b698206c68b 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.h
+++ b/drivers/gpu/drm/imagination/pvr_ccb.h
@@ -60,9 +60,9 @@ int pvr_kccb_send_cmd(struct pvr_device *pvr_dev,
 int pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev,
 			      struct rogue_fwif_kccb_cmd *cmd,
 			      u32 *kccb_slot);
-void pvr_kccb_send_cmd_reserved_powered(struct pvr_device *pvr_dev,
-					struct rogue_fwif_kccb_cmd *cmd,
-					u32 *kccb_slot);
+int pvr_kccb_send_cmd_reserved_powered(struct pvr_device *pvr_dev,
+				       struct rogue_fwif_kccb_cmd *cmd,
+				       u32 *kccb_slot);
 int pvr_kccb_wait_for_completion(struct pvr_device *pvr_dev, u32 slot_nr, u32 timeout,
 				 u32 *rtn_out);
 bool pvr_kccb_is_idle(struct pvr_device *pvr_dev);
diff --git a/drivers/gpu/drm/imagination/pvr_cccb.c b/drivers/gpu/drm/imagination/pvr_cccb.c
index 4fabab41bea7..da6e6d94e29f 100644
--- a/drivers/gpu/drm/imagination/pvr_cccb.c
+++ b/drivers/gpu/drm/imagination/pvr_cccb.c
@@ -220,8 +220,12 @@ static void fill_cmd_kick_data(struct pvr_cccb *cccb, u32 ctx_fw_addr,
  * You must call pvr_kccb_reserve_slot() and wait for the returned fence to
  * signal (if this function didn't return NULL) before calling
  * pvr_cccb_send_kccb_kick().
+ *
+ * Returns:
+ * * Zero on success, or
+ * * Any error returned by pvr_kccb_send_cmd_reserved_powered().
  */
-void
+int
 pvr_cccb_send_kccb_kick(struct pvr_device *pvr_dev,
 			struct pvr_cccb *pvr_cccb, u32 cctx_fw_addr,
 			struct pvr_hwrt_data *hwrt)
@@ -235,10 +239,10 @@ pvr_cccb_send_kccb_kick(struct pvr_device *pvr_dev,
 	/* Make sure the writes to the CCCB are flushed before sending the KICK. */
 	wmb();
 
-	pvr_kccb_send_cmd_reserved_powered(pvr_dev, &cmd_kick, NULL);
+	return pvr_kccb_send_cmd_reserved_powered(pvr_dev, &cmd_kick, NULL);
 }
 
-void
+int
 pvr_cccb_send_kccb_combined_kick(struct pvr_device *pvr_dev,
 				 struct pvr_cccb *geom_cccb,
 				 struct pvr_cccb *frag_cccb,
@@ -263,5 +267,5 @@ pvr_cccb_send_kccb_combined_kick(struct pvr_device *pvr_dev,
 	/* Make sure the writes to the CCCB are flushed before sending the KICK. */
 	wmb();
 
-	pvr_kccb_send_cmd_reserved_powered(pvr_dev, &cmd_kick, NULL);
+	return pvr_kccb_send_cmd_reserved_powered(pvr_dev, &cmd_kick, NULL);
 }
diff --git a/drivers/gpu/drm/imagination/pvr_cccb.h b/drivers/gpu/drm/imagination/pvr_cccb.h
index 943fe8f2c963..a2155f732bf1 100644
--- a/drivers/gpu/drm/imagination/pvr_cccb.h
+++ b/drivers/gpu/drm/imagination/pvr_cccb.h
@@ -59,16 +59,16 @@ void pvr_cccb_fini(struct pvr_cccb *cccb);
 void pvr_cccb_write_command_with_header(struct pvr_cccb *pvr_cccb,
 					u32 cmd_type, u32 cmd_size, void *cmd_data,
 					u32 ext_job_ref, u32 int_job_ref);
-void pvr_cccb_send_kccb_kick(struct pvr_device *pvr_dev,
-			     struct pvr_cccb *pvr_cccb, u32 cctx_fw_addr,
-			     struct pvr_hwrt_data *hwrt);
-void pvr_cccb_send_kccb_combined_kick(struct pvr_device *pvr_dev,
-				      struct pvr_cccb *geom_cccb,
-				      struct pvr_cccb *frag_cccb,
-				      u32 geom_ctx_fw_addr,
-				      u32 frag_ctx_fw_addr,
-				      struct pvr_hwrt_data *hwrt,
-				      bool frag_is_pr);
+int pvr_cccb_send_kccb_kick(struct pvr_device *pvr_dev,
+			    struct pvr_cccb *pvr_cccb, u32 cctx_fw_addr,
+			    struct pvr_hwrt_data *hwrt);
+int pvr_cccb_send_kccb_combined_kick(struct pvr_device *pvr_dev,
+				     struct pvr_cccb *geom_cccb,
+				     struct pvr_cccb *frag_cccb,
+				     u32 geom_ctx_fw_addr,
+				     u32 frag_ctx_fw_addr,
+				     struct pvr_hwrt_data *hwrt,
+				     bool frag_is_pr);
 bool pvr_cccb_cmdseq_fits(struct pvr_cccb *pvr_cccb, size_t size);
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 09993e858df8..8aba8fbfccfa 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -769,17 +769,19 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 		    (job->type != DRM_PVR_JOB_TYPE_GEOMETRY ||
 		     job->paired_job->type != DRM_PVR_JOB_TYPE_FRAGMENT ||
 		     job->hwrt != job->paired_job->hwrt ||
-		     job->ctx != job->paired_job->ctx)))
-		return ERR_PTR(-EINVAL);
+		     job->ctx != job->paired_job->ctx))) {
+		err = -EINVAL;
+		goto err_release;
+	}
 
 	err = pvr_job_get_pm_ref(job);
 	if (WARN_ON(err))
-		return ERR_PTR(err);
+		goto err_release;
 
 	if (job->paired_job) {
 		err = pvr_job_get_pm_ref(job->paired_job);
 		if (WARN_ON(err))
-			return ERR_PTR(err);
+			goto err_release;
 	}
 
 	/* Submit our job to the CCCB */
@@ -793,25 +795,37 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 
 		/* Submit the fragment job along the geometry job and send a combined kick. */
 		pvr_queue_submit_job_to_cccb(frag_job);
-		pvr_cccb_send_kccb_combined_kick(pvr_dev,
-						 &geom_queue->cccb, &frag_queue->cccb,
-						 pvr_context_get_fw_addr(geom_job->ctx) +
-						 geom_queue->ctx_offset,
-						 pvr_context_get_fw_addr(frag_job->ctx) +
-						 frag_queue->ctx_offset,
-						 job->hwrt,
-						 frag_job->fw_ccb_cmd_type ==
-						 ROGUE_FWIF_CCB_CMD_TYPE_FRAG_PR);
+		err = pvr_cccb_send_kccb_combined_kick(pvr_dev,
+						       &geom_queue->cccb, &frag_queue->cccb,
+						       pvr_context_get_fw_addr(geom_job->ctx) +
+						       geom_queue->ctx_offset,
+						       pvr_context_get_fw_addr(frag_job->ctx) +
+						       frag_queue->ctx_offset,
+						       job->hwrt,
+						       frag_job->fw_ccb_cmd_type ==
+						       ROGUE_FWIF_CCB_CMD_TYPE_FRAG_PR);
 	} else {
 		struct pvr_queue *queue = container_of(job->base.sched,
 						       struct pvr_queue, scheduler);
 
-		pvr_cccb_send_kccb_kick(pvr_dev, &queue->cccb,
-					pvr_context_get_fw_addr(job->ctx) + queue->ctx_offset,
-					job->hwrt);
+		err = pvr_cccb_send_kccb_kick(pvr_dev, &queue->cccb,
+					      pvr_context_get_fw_addr(job->ctx) +
+					      queue->ctx_offset,
+					      job->hwrt);
+	}
+
+	if (WARN_ON(err)) {
+		pvr_job_release_pm_ref(job);
+		if (job->paired_job)
+			pvr_job_release_pm_ref(job->paired_job);
+		goto err_release;
 	}
 
 	return dma_fence_get(job->done_fence);
+
+err_release:
+	pvr_kccb_release_slot(pvr_dev);
+	return ERR_PTR(err);
 }
 
 static void pvr_queue_stop(struct pvr_queue *queue, struct pvr_job *bad_job)

---
base-commit: bd4f284df04d76fd65e57141cb1e6e7a49e4c3cb
change-id: 20260810-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-0dae4f05fcb5

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

