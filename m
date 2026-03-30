Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 52125FF4956
	for <dri-devel@archiver.kernel.org>; Mon, 30 Mar 2026 07:57:35 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5F77710E45E;
	Mon, 30 Mar 2026 07:57:28 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="GAhqJ2df";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D9E7010E3EA
 for <dri-devel@lists.freedesktop.org>; Mon, 30 Mar 2026 07:57:26 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 62U5HJTo174202; Mon, 30 Mar 2026 08:57:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:in-reply-to
 :message-id:mime-version:references:subject:to; s=dk201812; bh=s
 eLcPBEcAsaYN6ay45rwCaaiKgAxHGqW+q1E15iAdgU=; b=GAhqJ2df2B61ce8ss
 QKzv/zYQBPG2ldQyqeDhYhxnhxXbvSI7bQ8F5Btl4WwPakqvys9s0clGjmOoZ0hy
 ZTr6iehsCLtpIX6mXeZ1BCc+W4xLHNfnbj5XZ+2CAhaFMSR2VJbdeZfMKTB1nPA8
 D2+O74uC/pw71xwoH7fWlyMvIG/aGPF8Kvpl/lyEtCMRyl1OInjKJN6HcjptukaU
 jdCg3WaiBN/CdXE0YOArC/uOcT/aT3SpZOonxaJbQ3Uxsci3+zZMqNlDhWHqsiGD
 akjGwUE/XtDz7ZUswvZ2nzY5Ca4LMeet983Vv9UztxDFy89DrWjUqyFOZCTwSwEY
 /l2Tw==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4d67xusfkv-8
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 30 Mar 2026 08:57:02 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.6.106) by
 HHMAIL01.hh.imgtec.org (10.100.10.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.2562.37; Mon, 30 Mar 2026 08:57:00 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Mon, 30 Mar 2026 08:56:39 +0100
Subject: [PATCH 4/8] drm/imagination: Rename
 pvr_queue_fence_is_ufo_backed() to reflect usage
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260330-job-submission-fixes-cleanup-v1-4-7de8c09cef8c@imgtec.com>
References: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
In-Reply-To: <20260330-job-submission-fixes-cleanup-v1-0-7de8c09cef8c@imgtec.com>
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Brajesh Gupta <brajesh.gupta@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Sumit Semwal <sumit.semwal@linaro.org>,
 =?utf-8?q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
 Boris Brezillon <boris.brezillon@collabora.com>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 <linux-media@vger.kernel.org>, <linaro-mm-sig@lists.linaro.org>, "Alessio
 Belle" <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=ed25519-sha256; t=1774857418; l=3271;
 i=alessio.belle@imgtec.com; s=20251208; h=from:subject:message-id;
 bh=aOXr9l0FFmTL/LnafMxft6puEJEDoSxUR5y77Mzx8s8=;
 b=jPTx7qR6OzCRucaHhLcYT3Dw8wFzkDxv+qzNiUFU4TCxWaGz7LSF2jWIeEoRlkuaVBMYVXJ9f
 B4LQyL0J/WnDcxqdxUn3y5LJOZI/mEaqjeqFYG6USjGh2bmhg2JuMdw
X-Developer-Key: i=alessio.belle@imgtec.com; a=ed25519;
 pk=2Vtuk+GKBRjwMqIHpKk+Gx6zl7cgtq0joszcOc0zF4g=
X-Originating-IP: [172.25.6.106]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzMwMDA2MSBTYWx0ZWRfX8RiojEjqnNLp
 ujESR9x9nOyk+KnnMi9dG9on1bIK8IpbWuPlWm7CmC+odHbB76vkYDeCBbFpP0x8iuubAMgfm6X
 TeovI9i6g/ZO8/Sv8n9eKqDxxDh1xb7NYJeOBl5Hn1PGnl6FEbPXZnThc7yjO0lGdpnw8FJTBEA
 fWQ4dHo5Vr5bIuZ8LQQhh6P4/FSqF6/464FX3C5Qzrz68T51d5iomG4KOeOphSQVUxf6FJUA0u6
 oMq+w0DcbeA08rsVleBAJpFYQuyotrjJGTr1CGrBXoh57CdrfrBLCu1hlOj6PhPL2fU7vT67ccR
 I/ickFYFET4Y67gAgUNZWChcPj7efnkhuIp4Ni06ChoopJ/5G51kbndsTOZBWbNFymshK/CxGT/
 F55zXz05w/sy7IkvJ+YdtcJi8NDwip7mmbdEwCwREgzTBqlJAwgzKfOc2tS/QQh27s85ujGYj7c
 v+Lcv4zn8Bu/VyFOXqw==
X-Authority-Analysis: v=2.4 cv=QO9lhwLL c=1 sm=1 tr=0 ts=69ca2cce cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=txNhvCuK94MA:10 a=IkcTkHD0fZMA:10 a=Yq5XynenixoA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=BXHwQC_6lmVYEJqqvYEA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: dDHRjWMPgsG4VMMMCfFiVfPyiBFejy9E
X-Proofpoint-ORIG-GUID: dDHRjWMPgsG4VMMMCfFiVfPyiBFejy9E
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

This function is only used by the synchronization code to figure out if
a fence belongs to this driver.
Rename it to pvr_queue_fence_is_native() and update its documentation to
reflect its current purpose.

Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_queue.c | 14 +++++++-------
 drivers/gpu/drm/imagination/pvr_queue.h |  2 +-
 drivers/gpu/drm/imagination/pvr_sync.c  |  4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 527eae1309d8..df0a110ed96f 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -898,16 +898,16 @@ static const struct drm_sched_backend_ops pvr_queue_sched_ops = {
 };
 
 /**
- * pvr_queue_fence_is_ufo_backed() - Check if a dma_fence is backed by a UFO object
+ * pvr_queue_fence_is_native() - Check if a dma_fence is native to this driver.
  * @f: Fence to test.
  *
- * A UFO-backed fence is a fence that can be signaled or waited upon FW-side.
- * pvr_job::done_fence objects are backed by the timeline UFO attached to the queue
- * they are pushed to, but those fences are not directly exposed to the outside
- * world, so we also need to check if the fence we're being passed is a
- * drm_sched_fence that was coming from our driver.
+ * Check if the fence we're being passed is a drm_sched_fence that is coming from this driver.
+ *
+ * It may be a UFO-backed fence i.e. a fence that can be signaled or waited upon FW-side,
+ * such as pvr_job::done_fence objects that are backed by the timeline UFO attached to the queue
+ * they are pushed to.
  */
-bool pvr_queue_fence_is_ufo_backed(struct dma_fence *f)
+bool pvr_queue_fence_is_native(struct dma_fence *f)
 {
 	struct drm_sched_fence *sched_fence = f ? to_drm_sched_fence(f) : NULL;
 
diff --git a/drivers/gpu/drm/imagination/pvr_queue.h b/drivers/gpu/drm/imagination/pvr_queue.h
index fc1986d73fc8..4aa72665ce25 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.h
+++ b/drivers/gpu/drm/imagination/pvr_queue.h
@@ -141,7 +141,7 @@ struct pvr_queue {
 	u64 callstack_addr;
 };
 
-bool pvr_queue_fence_is_ufo_backed(struct dma_fence *f);
+bool pvr_queue_fence_is_native(struct dma_fence *f);
 
 int pvr_queue_job_init(struct pvr_job *job, u64 drm_client_id);
 
diff --git a/drivers/gpu/drm/imagination/pvr_sync.c b/drivers/gpu/drm/imagination/pvr_sync.c
index 3582616ff722..757a18b1ab8f 100644
--- a/drivers/gpu/drm/imagination/pvr_sync.c
+++ b/drivers/gpu/drm/imagination/pvr_sync.c
@@ -211,7 +211,7 @@ pvr_sync_add_dep_to_job(struct drm_sched_job *job, struct dma_fence *f)
 	int err = 0;
 
 	dma_fence_unwrap_for_each(uf, &iter, f) {
-		if (pvr_queue_fence_is_ufo_backed(uf))
+		if (pvr_queue_fence_is_native(uf))
 			native_fence_count++;
 	}
 
@@ -227,7 +227,7 @@ pvr_sync_add_dep_to_job(struct drm_sched_job *job, struct dma_fence *f)
 		if (err)
 			continue;
 
-		if (pvr_queue_fence_is_ufo_backed(uf)) {
+		if (pvr_queue_fence_is_native(uf)) {
 			struct drm_sched_fence *s_fence = to_drm_sched_fence(uf);
 
 			/* If this is a native dependency, we wait for the scheduled fence,

-- 
2.43.0

