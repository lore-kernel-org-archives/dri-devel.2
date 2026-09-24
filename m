Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C99BDC98314
	for <dri-devel@archiver.kernel.org>; Thu, 24 Sep 2026 07:30:16 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5400D10F352;
	Thu, 24 Sep 2026 07:30:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="pikZqSH0";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 16BA810E65B;
 Thu, 24 Sep 2026 07:30:11 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 68O5e24I1074552; Thu, 24 Sep 2026 08:30:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=T
 GItrDhoO+5pPBhuhDC6SPpjuAv3wA8TVpPKmsAGa3k=; b=pikZqSH0E34BWHbNh
 vCxpW3tSkWdohWF+i45kGjJhTmNhLrQ7UKUlAHlosRVIA7RAgyXzQFc3/H71ghB0
 ENiTeMva1kOwTtTcGighr/yzpC9/i52YWp66WEqPB5Y/Q+r72pyU3Gf1WpL5DMvZ
 jreR+t09rTns1UWulnFdDIuvSwhYH4YM0UF251KZLSNSbh89qTkWTKyZX0jayUqf
 WkldXTV5mlEqE6x4TnjUNUfB3UfjfqWezGuaBa4KM2AREzns4V2ni0JZmDlf1ZTS
 lyu0LPyJjg8/RlK94JlYjl5ms/5sQK+IFGqybiRbQ27hYJO9ILA1Ya5L6ByI3fR7
 eo0ew==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4gsgnq3w1g-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Thu, 24 Sep 2026 08:30:03 +0100 (BST)
Received: from [127.0.1.1] (172.25.5.18) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.46; Thu, 24 Sep
 2026 08:30:02 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Thu, 24 Sep 2026 10:29:44 +0300
Subject: [PATCH v7 2/3] drm/imagination: Propagate all errors from KCCB
 command submission code
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-2-584796cb599d@imgtec.com>
References: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-0-584796cb599d@imgtec.com>
In-Reply-To: <20260924-b4-upstream-propagate-all-errors-from-kccb-cmd-submission-code-v7-0-584796cb599d@imgtec.com>
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.16.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1790234999; l=9250;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=5Ql3OVcHLkZ9VHWPfvZ4KKEbvE5uPaVprIcf7QNVmkE=;
 b=EWCIjy+fcPV+V1/clnBlLzpiQz4FInCMyw+6p30UtJXq6GrtJf5UaPT8xly+tqNuOBiPxSBE8
 REy1nw6Yi/UDSAkjVaCX17QIFqybGp78r6MvkeKCnd5pFHyl7zmM19E
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.5.18]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTI0MDAzMSBTYWx0ZWRfX0nQGYb5wro5x
 lWU5QBR4JcuwwZvuV4ILcQuOS+gxSd6URR2r25dnT80OQzBakzAYxc8Sp+Dx7EGFN343rP2NHEz
 gOhqry6J34YTYA0r08cwnMPDgokR2YXCXVrejg8XTVFWbtGxha5v8GbSb+O8lPf/84+8xc5oehb
 V7kypgBYxU7Qlpv0Ota25T0E4IwLfY0zZDbTiOREbBPOfFOdKiiYsAJk3pv2H+Fy90s8AkTle4Q
 zx4TylZX8+Mgx7xecHkV5BILFlioCj92sXbFeGvd1CZAElPkR3bpr5kZp8DYe5sfYeQBjIroC1c
 xogR5w3dyPN0xDg0XeDV4qZ1DEgyPKQuE8MskR2J+149gV2SaINgZQeCMXh2XPDUzt9A+RAl2RT
 Ce4/8cJZL8nLgqE5X5c1XH/3E/L9ihKDliEzo6lzn6pbcvGHylMIxvjHPruGMB3DUt0RI52qTN+
 rer64NHwpByY96tjs6w==
X-Proofpoint-ORIG-GUID: f-loZv5FJuqpkHvCiVDN1WYEI-_57_Qk
X-Authority-Analysis: v=2.4 cv=fYs4WEQF c=1 sm=1 tr=0 ts=6ab4d17b cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=sVS2Dey4ZWMA:10 a=IkcTkHD0fZMA:10 a=VdqzKS8jKosA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=WhBBAM252t03QMwC9x0A:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: f-loZv5FJuqpkHvCiVDN1WYEI-_57_Qk
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTI0MDAzMSBTYWx0ZWRfX30/POf5r3kby
 Sd7ERIQHQjsMidBOvsZ+P/0JqOYOi3zlP5I7klVULIJrXov8wDnaxfhQibdkZ17h9GZGUaGT5qZ
 9+69lbjQceemTe0akL77v/aIWF2hX0I=
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
 drivers/gpu/drm/imagination/pvr_ccb.c   | 33 +++++++++++++++++++++++++--------
 drivers/gpu/drm/imagination/pvr_ccb.h   |  6 +++---
 drivers/gpu/drm/imagination/pvr_cccb.c  | 12 ++++++++----
 drivers/gpu/drm/imagination/pvr_cccb.h  | 20 ++++++++++----------
 drivers/gpu/drm/imagination/pvr_queue.c | 25 +++++++++++++------------
 5 files changed, 59 insertions(+), 37 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_ccb.c b/drivers/gpu/drm/imagination/pvr_ccb.c
index e408df74853d..2b3dfbe725dd 100644
--- a/drivers/gpu/drm/imagination/pvr_ccb.c
+++ b/drivers/gpu/drm/imagination/pvr_ccb.c
@@ -253,8 +253,13 @@ pvr_kccb_used_slot_count_locked(struct pvr_device *pvr_dev)
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
@@ -264,19 +269,25 @@ pvr_kccb_send_cmd_reserved_powered(struct pvr_device *pvr_dev,
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
@@ -294,8 +305,14 @@ pvr_kccb_send_cmd_reserved_powered(struct pvr_device *pvr_dev,
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
@@ -361,8 +378,9 @@ static int pvr_kccb_reserve_slot_sync(struct pvr_device *pvr_dev)
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
@@ -374,8 +392,7 @@ pvr_kccb_send_cmd_powered(struct pvr_device *pvr_dev, struct rogue_fwif_kccb_cmd
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
index 8dd87192fabc..b58c0887cafe 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -793,15 +793,15 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 
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
 
 		trace_pvr_job_submit_fw(geom_job);
 		trace_pvr_job_submit_fw(frag_job);
@@ -809,9 +809,10 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 		struct pvr_queue *queue = container_of(job->base.sched,
 						       struct pvr_queue, scheduler);
 
-		pvr_cccb_send_kccb_kick(pvr_dev, &queue->cccb,
-					pvr_context_get_fw_addr(job->ctx) + queue->ctx_offset,
-					job->hwrt);
+		err = pvr_cccb_send_kccb_kick(pvr_dev, &queue->cccb,
+					      pvr_context_get_fw_addr(job->ctx) +
+					      queue->ctx_offset,
+					      job->hwrt);
 
 		trace_pvr_job_submit_fw(job);
 	}

-- 
2.43.0

