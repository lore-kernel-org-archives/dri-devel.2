Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4AF3BC5CFC1
	for <dri-devel@archiver.kernel.org>; Fri, 14 Aug 2026 07:50:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id A544210F3A9;
	Fri, 14 Aug 2026 07:50:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="udXhmZXw";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CC5F710F3CA;
 Fri, 14 Aug 2026 07:50:18 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 67E7fMmD3790941; Fri, 14 Aug 2026 08:50:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=wnfUzeGAykUnZLeQXub4d7g
 aXesvRp4CDHiFNkv3vJQ=; b=udXhmZXwrN0lF3IYBq3uIDY45XgdLrXR921Lh+T
 R1OaWfgH66uY49MEe+djqQKl8ZWzD1rSezofkypXliheyM+mJZj7iuBRfGRFaINO
 aB3DxyD4YCS4PqtvsTMmkv85a51CCsVhOLhr1chot7g/nj6Qm23njpERX3NVXwlP
 tbR/ApWFTLFDWGyQ0HWx8mo4Ox8nqvuF5K3MX6QEpJAJ3ZEnh7MnlrRjPd0/0VEF
 sB9pLGyGGDGyjP0BLruTVTEp0Duc4gNuOweUeifqpiJMFb7b2w3qXu454FVQfA4n
 YTnRIHkC4Fuu7XPOc+PSuRz9j1Rk6cx906C01itT4MsFXiw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4g1nyx0b30-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 14 Aug 2026 08:50:03 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.25) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.45; Fri, 14 Aug
 2026 08:50:02 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Fri, 14 Aug 2026 10:49:54 +0300
Subject: [PATCH v2] drm/imagination: Propagate all errors from KCCB command
 submission code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260814-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v2-1-35355fad50ae@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAKHIfmoC/6WOTQ6CMBBGr0K6dkzbUGJceQ/DokynWKWWTCvRG
 O4uYDyBy5d8P+8tMnGgLI7VWzBNIYd0X0DvKoEXe+8JgltYaKkbeVASuhoeYy5MNsLIabS9LQR
 2GICYE2fwnCLcEDvA6CA/uhjyugqYHIF0lmovjcfOiOVkZPLhuQmc2y8vlSthWV/XxCXkkvi1G
 U5qzf1k1L8ykwIF3jtjtKld4/QpxL4Q7jFF0c7z/AGkT5V3HwEAAA==
X-Change-ID: 20260810-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-0dae4f05fcb5
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1786693802; l=11741;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=76iO50fC+O9gsP0jdhSoEdIMsGm6xpxMUaPJddUqe08=;
 b=xBbdhCMfffJ3VjBi3Rkh5hgtn3lV+MFiYBc+Dk1SsL+/zFtLyAgqKEtLeUjtguMpN5Eo4Su6l
 31+Y3b1WuR6BTNFL4XEKEfOup0PNw25myYyYS1XS9YyMbXPkdpXDXP7
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.25]
X-Proofpoint-ORIG-GUID: Ryg2mFH3NTh8bUpHLEFzkmZN4Pj9ypPP
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE0MDA2MCBTYWx0ZWRfX1ctR5jLFlS7J
 9N1LmMeXuLpUawYgvtpuiOZhaH0zXVuiBHNayu3CUZFlZzdviHHUgVLCA0V6dOeHsUkQsJFVoAI
 gvc484LHzRbQO8aFNZS3jL1l9R/KgzE=
X-Authority-Analysis: v=2.4 cv=Zfkt8MVA c=1 sm=1 tr=0 ts=6a7ec8ab cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=1spURiKJc90A:10 a=IkcTkHD0fZMA:10 a=Sv0fKeRqtYgA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=bC-a23v3AAAA:8 a=r_1tXGB3AAAA:8 a=QyXUC8HyAAAA:8 a=VwQbUJbxAAAA:8
 a=pGLkceISAAAA:8 a=e5mUnYsNAAAA:8 a=-Hwv4S9AhHCUfRXPc_sA:9 a=QEXdDO2ut3YA:10
 a=FO4_E8m0qiDe52t0p3_H:22 a=t8nPyN_e6usw4ciXM-Pk:22 a=Vxmtnl_E_bksehYqCbjh:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE0MDA2MCBTYWx0ZWRfX0FgIuZj+fgeO
 +T2Kk46tydyfv0KuU2kbX72lEIbqWwruC1prrf72E8+WKJ8l6RH/ZqJM3bEEoslVJt7n6yZqNBX
 rt8y+HWXYasb2NXlqu+1ffBv5xlNhpnfz0++PK4rPy9W2nu0k2xxaXRna127I+8InnYgVarUTXP
 PmYUtFq3xrIYPLWx3LjKBq5L8t10/3wMjB4G4ACdE90VlW2KDXFLEwoDWxu4VpbHJsuTX0IXj5c
 2aHLy8alZoSMGNsSiaYAWnOjl5FBO56+3A1uiQIWD5RTEKjdIbg6HzdYG4ownPniKnKRCfJgjb5
 nqOpyYzs6uidnEM0YYNbEhGHhCxiy0qeRyjBRuzdj03/IzPQb/7U/1BEaNqBFHNx0VjGsnyypYl
 GRlEeH/x/7bZdcgXa+sDGSa6j+rYnAWL6v18J5yqMfWlIcWkRLq4PbwPeOSy4bXmG9kWpgRMf0s
 PT6F7ffy4uyNsCgmREw==
X-Proofpoint-GUID: Ryg2mFH3NTh8bUpHLEFzkmZN4Pj9ypPP
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
---
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
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
 drivers/gpu/drm/imagination/pvr_ccb.c   | 33 +++++++++++++-----
 drivers/gpu/drm/imagination/pvr_ccb.h   |  6 ++--
 drivers/gpu/drm/imagination/pvr_cccb.c  | 12 ++++---
 drivers/gpu/drm/imagination/pvr_cccb.h  | 20 +++++------
 drivers/gpu/drm/imagination/pvr_queue.c | 60 +++++++++++++++++++++++----------
 5 files changed, 89 insertions(+), 42 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index 4accf18e2341..8182babd8ad8 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -257,8 +257,13 @@ pvr_kccb_used_slot_count_locked(struct pvr_device *pvr_dev)
  * @pvr_dev: Device pointer.
  * @cmd: Command to sent.
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
index 54e88b4208d7..70ad2bcc93b7 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -750,6 +750,15 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 	struct pvr_job *job = container_of(sched_job, struct pvr_job, base);
 	struct pvr_device *pvr_dev = job->pvr_dev;
 	int err;
+	bool reserved;
+
+	/* Track the KCCB slot reserved status: when reserve_slot succeeds, clears job->kccb_fence.
+	 * NULL means reservation was taken.
+	 */
+	if (job->kccb_fence == NULL)
+		reserved = true;
+	else
+		reserved = false;
 
 	/* The fragment job is issued along the geometry job when we use combined
 	 * geom+frag kicks. When we get there, we should simply return the
@@ -768,17 +777,21 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
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
-		if (WARN_ON(err))
-			return ERR_PTR(err);
+		if (WARN_ON(err)) {
+			pvr_job_release_pm_ref(job);
+			goto err_release;
+		}
 	}
 
 	/* Submit our job to the CCCB */
@@ -792,25 +805,38 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 
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
+	if (reserved)
+		pvr_kccb_release_slot(pvr_dev);
+	return ERR_PTR(err);
 }
 
 static void pvr_queue_stop(struct pvr_queue *queue, struct pvr_job *bad_job)

---
base-commit: e55fead22ff9ee047ab9f1903860c4b43043514e
change-id: 20260810-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-0dae4f05fcb5

Best regards,
--  
Alexandru Dadu <alexandru.dadu@imgtec.com>

