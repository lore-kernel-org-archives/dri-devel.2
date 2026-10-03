Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8DA06CA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:39:21 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id E1CF110E728;
	Sat,  3 Oct 2026 02:39:20 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="QzjCLG7d";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="hsh4qDPG";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id CCCDD10E728
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:39:19 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NegM53338160
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 02:39:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=Qg9VBoVcFjj
 Up6OM0nt/5vJ12HQTFVqlHbAGmKdxIwQ=; b=QzjCLG7dp+E/z469TJ/6Lo/VzpJ
 or2ALZ0s45GEpAT5yEpsppCR6hnogmiMwYawgejleqZByeOmtr+1AhM776hcuZhQ
 ECekPtQxtyvet0HGSRhOt9hBMaw0sDyuOg9dtYipNQ9TwDw+ikkcjC1LQyWnOKpy
 fJ3YOH2eMdtyhAtghBdOb0ytsQsyTbA7Zpac3hvNsBhwd2nVihW8NI1Wnuhjmo/Z
 eNiBpu1Y85RdfvIPZTmWnpFyTwIkMf6ZbL+erp4ILIdk2HW4GNrbPmh9GZKFMwqk
 /C6EEEkr6StTdyR2OpVZvPCSbBnuxbtT38dpRNzlrFY5tN9lsYBeVuH0yEQ==
Received: from mail-dy1-f200.google.com (mail-dy1-f200.google.com
 [74.125.82.200])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj03amd-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:39:18 +0000 (GMT)
Received: by mail-dy1-f200.google.com with SMTP id
 5a478bee46e88-30bcb065bfdso235418eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 19:39:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790995158; x=1791599958;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=Qg9VBoVcFjjUp6OM0nt/5vJ12HQTFVqlHbAGmKdxIwQ=;
 b=hsh4qDPGstRy9OMWifZE9uGN/704oH66musfOtXLFfvqXppY1yh9AkwnH13oBFYhru
 9ySelui+iZHXJRYydkP9qnc2wyTjeb5Ww0fKa/OcqkiwD20Na9jCBxkpOc/zoiwpHIjE
 mrbPpB52MFDPRyuc8HzOr2njnQ/QPFauIz415mEjWsufFy8Gqe2WxZG/KLvMLgfYz+w6
 wuVVgI5E5hLIJ1Cl+AcBkQKVcNaUy5B6tHaFP8H5nEuJel4OpArF0IcDall+B5SWZsvw
 e1qxY0RQudP1bpIzVu1pr4m3Gip3bhefVJWY9/76DsS6SQPLFq3P/b0/8/EJqIgqMau5
 GmYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995158; x=1791599958;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=Qg9VBoVcFjjUp6OM0nt/5vJ12HQTFVqlHbAGmKdxIwQ=;
 b=UsqITThQWwYIb9aJOv5In/qvfB1/NhczT6/v4C42o/AEDd0tGDZwzagNSI1qPDgvBs
 fy/Ur9DyELkkFlMbss4YVU7Ybyg2ddOm68GztoQQOQCUaEXbpULR4yaaQzK3AND92fNJ
 mHdv1OJub5HyiICno6HRredUvp4HQxxkypfvG2cyI0KFpHNa5EwsSY1LpXp6mKvM3VSd
 sZzF6tmJB9b81nczMtsAr7b5bF722Mr4SkVgMqjwL8YoxWjLeVD1SFkN9dy9SvaHaahj
 T0L1PyGxaNPHNCXWV5psU9PHB1tTl3NoB4z4wSuw8jCAEHz243LRxLpOiN2nPpcP0YhO
 6SVw==
X-Forwarded-Encrypted: i=1;
 AKwUvByQ0jOy5mN31ClxxW82N/imiv3+O12BBCfzDN01PbPi/tI74T85IbgVkYHCJW6XCCr8I0RTdTPhGfA=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYLi2cPja6IBC18xcTMEEwlt65kY2F0B/auqbQY85XEC03JbmhLj
 g935px5bprdG+iD3YewVKZtascHL8noXk23Ik4iMwK+5SbSczSuepuSr0HXQHP9GaC2KTViFZxN
 fi600q7OLmjdtYtYRubhDoSk2A0n6s12yn7M5UJ7/F1yPeY1iI5EDHS3ACT/32wgiUhKcbcY=
X-Gm-Gg: AYBFou24ZKg4tADXFsFLO0CCkkEx4tAVNG2nSdrtRZqi2Uu6mc6fkrG6OgViHRjzCtj
 z/6V57XRDkZbyNSyMbz4O5BqoPHMtlV8Y07LQ7pV7InKfpaIgDuKg+OEi9T2nD0CCSWH2IbGO05
 7DHh79TB8eqoYn/MHHvKfqf8bK2qZXyrwjU28HtPLWqXoRjL7sVimu6FscomPUBbvzzoAijQlgm
 RfJBqSSYd+hRtGbQB6K/lvyvtUcWC3mMbb3KTOBFT2WcT7hWRskrXm90i5/TZHN703f4l4IgJEz
 lVYufgZppcQPzcfrP9kp62I/HYnAK6whyTVUNbkp78X63F3o9LuNE7HrH76kkp2H1BfC5TuJvbg
 H+NJBfgtkdpmTtAPKu7tam9Pi1eqUMkfzeSfMg6yjXJzAXDoBMhTISM1o
X-Received: by 2002:a05:7301:259c:b0:34c:1ddd:baee with SMTP id
 5a478bee46e88-34f14f15b5bmr5088176eec.2.1790995157522; 
 Fri, 02 Oct 2026 19:39:17 -0700 (PDT)
X-Received: by 2002:a05:7301:259c:b0:34c:1ddd:baee with SMTP id
 5a478bee46e88-34f14f15b5bmr5088149eec.2.1790995156860; 
 Fri, 02 Oct 2026 19:39:16 -0700 (PDT)
Received: from carlv-linux.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3510752b575sm7665736eec.6.2026.10.02.19.39.16
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 19:39:16 -0700 (PDT)
From: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>,
 Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Subject: [PATCH 2/6] accel/qaic: Replace transfer completion with dma-fence
Date: Fri,  2 Oct 2026 19:38:14 -0700
Message-ID: <20261003023818.1161666-3-carl.vanderlip@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfX0lA4wjZE9NCg
 AXRt3AhIyxEaRIEPv/CW9sedM6QrlWrC+j4dJ5G1LuXTT8LOb9ZijMU7pZPyeSHvZVY1V53T5xG
 pqGC5pJDpbFTz+5xrR/4nyfQ82+FUwc=
X-Proofpoint-GUID: FLd1nvA2YJoLj-swznyctHCeg3fK6681
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6ac06ad6 cx=c_pps
 a=PfFC4Oe2JQzmKTvty2cRDw==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=MHz2CafV60DOkNvWHnUA:9 a=6Ab_bkdmUrQuMsNx7PHu:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfX0WWtCwi1LrbV
 A2W5TaM0EuZ0381rdTDRRnCvOBegaWixp8ikCK2JXeJvw4Ir9/zflEEPBB7O7yInTaohE4ZErjo
 KVOvZ7MqEaFbQWN/OCm+nsBJzqPOW8V44UTrdssaapltG848kn8Es/AjQKZxJNtYsR7wA5ltjvX
 AEeEghkTTl77qDxOmzoS/h+b6UHDtxgWyHlOe8y8F4USRzp2HOrMim+3kqGMl61mliptc8+zZd7
 6Bx4+MYm532gsG141d6Rakco1Zyx8qaVRNbhyV+ezKCuD8jiuLn8iHEOrVKPX2AdRsw6TI9En+2
 gQfvTJS5Ydm/rNK9W20Wdx5h7m9djJgnI0DE115YBKt6E2rJW2OXMajyw0pxQQt4GbGOYdu7EQP
 jsG/OyPu761FwrVvE7c1JOlJ0XvLb0p0ETyzn9QeBYqoR/pEB+/kAjz19O0ixQuZNCrHUR/ZMbs
 v1tzEXFIdxU6F73QWfA==
X-Proofpoint-ORIG-GUID: FLd1nvA2YJoLj-swznyctHCeg3fK6681
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1011 priorityscore=1501
 spamscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0 adultscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610030010
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

Currently, finished irq work is signaled by a completion. This is
lightweight but doesn't integrate with other kernel buffer
synchronization.

Using dma-fences instead of completions allows for the fences to be
added to their respective DMA-BUFs which enables polling on the buffer
instead of relying on the ~_WAIT_BO IOCTL for synchronization.

This is also useful in preparation for the addition of drm_sched
support. Fences can be linked together to create more complex
synchronization structures.

Co-developed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Signed-off-by: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
---
 drivers/accel/qaic/Makefile     |   1 +
 drivers/accel/qaic/qaic.h       |  26 +++++-
 drivers/accel/qaic/qaic_data.c  |  84 +++++++++++--------
 drivers/accel/qaic/qaic_drv.c   |   2 +-
 drivers/accel/qaic/qaic_fence.c | 144 ++++++++++++++++++++++++++++++++
 5 files changed, 220 insertions(+), 37 deletions(-)
 create mode 100644 drivers/accel/qaic/qaic_fence.c

diff --git a/drivers/accel/qaic/Makefile b/drivers/accel/qaic/Makefile
index 71f727b74da3..90582b0693da 100644
--- a/drivers/accel/qaic/Makefile
+++ b/drivers/accel/qaic/Makefile
@@ -10,6 +10,7 @@ qaic-y := \
 	qaic_control.o \
 	qaic_data.o \
 	qaic_drv.o \
+	qaic_fence.o \
 	qaic_ras.o \
 	qaic_ssr.o \
 	qaic_sysfs.o \
diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
index 02ca99000e2a..4cdd6579aa89 100644
--- a/drivers/accel/qaic/qaic.h
+++ b/drivers/accel/qaic/qaic.h
@@ -6,6 +6,7 @@
 #ifndef _QAIC_H_
 #define _QAIC_H_
 
+#include <linux/dma-fence.h>
 #include <linux/interrupt.h>
 #include <linux/kref.h>
 #include <linux/mhi.h>
@@ -18,9 +19,11 @@
 #include <drm/drm_device.h>
 #include <drm/drm_gem.h>
 
+#define QAIC_NAME		"qaic"
 #define QAIC_DBC_BASE		SZ_128K
 #define QAIC_DBC_SIZE		SZ_4K
 #define QAIC_SSR_DBC_SENTINEL	U32_MAX /* No ongoing SSR sentinel */
+#define QAIC_TIMELINE_LEN	32 /* Should fit max sized DBC id/BO handle */
 
 #define QAIC_NO_PARTITION	-1
 
@@ -227,6 +230,16 @@ struct qaic_drm_device {
 	void			*sysfs_attrs;
 };
 
+struct qaic_fence {
+	struct dma_fence	base;
+	/* Spinlock used for initializing this fence */
+	spinlock_t		lock;
+	/* Name of fence context */
+	char			timeline_name[QAIC_TIMELINE_LEN];
+	/* Cached value of dbc_id for use in populating timeline_name */
+	u32			dbc_id;
+};
+
 struct qaic_bo {
 	struct drm_gem_object	base;
 	/* Scatter/gather table for allocate/imported BO */
@@ -253,8 +266,10 @@ struct qaic_bo {
 	bool			sliced;
 	/* Request ID of this BO if it is queued for execution */
 	u16			req_id;
-	/* Wait on this for completion of DMA transfer of this BO */
-	struct completion	xfer_done;
+	/* Wait on this fence for DMA transfer of this BO */
+	struct qaic_fence	*fence;
+	/* Current fence context for this BO */
+	u64			fence_context;
 	/*
 	 * Node in linked list where head is dbc->xfer_list.
 	 * This link list contain BO's that are queued for DMA transfer.
@@ -290,6 +305,8 @@ struct qaic_bo {
 	} perf_stats;
 	/* Synchronizes BO operations */
 	struct mutex		lock;
+	/* Callback to sync BO with CPU */
+	struct dma_fence_cb	cb;
 };
 
 struct bo_slice {
@@ -351,6 +368,11 @@ void qaic_irq_polling_work(struct work_struct *work);
 void qaic_dbc_enter_ssr(struct qaic_device *qdev, u32 dbc_id);
 void qaic_dbc_exit_ssr(struct qaic_device *qdev);
 
+/* qaic_fence.c */
+int qaic_fence_wait(struct dma_fence *fence, signed long timeout);
+void qaic_remove_bo_fence(struct qaic_bo *bo);
+int qaic_acquire_bo_fence(struct qaic_bo *bo);
+
 /* qaic_sysfs.c */
 int qaic_sysfs_init(struct qaic_drm_device *qddev);
 void qaic_sysfs_remove(struct qaic_drm_device *qddev);
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 64bc3cc50d1f..3326d9da0e1e 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -184,9 +184,12 @@ struct qaic_exec_data_req {
 	int idx;
 };
 
+/* Caller should be holding bo->lock */
 static inline bool bo_queued(struct qaic_bo *bo)
 {
-	return !list_empty(&bo->xfer_list);
+	if (bo->fence)
+		return !dma_fence_is_signaled(&bo->fence->base);
+	return false;
 }
 
 inline int get_dbc_req_elem_size(void)
@@ -745,16 +748,8 @@ static const struct drm_gem_object_funcs qaic_gem_funcs = {
 	.vm_ops = &drm_vm_ops,
 };
 
-static void qaic_init_bo(struct qaic_bo *bo, bool reinit)
+static void qaic_init_bo_lists(struct qaic_bo *bo)
 {
-	if (reinit) {
-		bo->sliced = false;
-		reinit_completion(&bo->xfer_done);
-	} else {
-		mutex_init(&bo->lock);
-		init_completion(&bo->xfer_done);
-	}
-	complete_all(&bo->xfer_done);
 	INIT_LIST_HEAD(&bo->slices);
 	INIT_LIST_HEAD(&bo->xfer_list);
 }
@@ -767,7 +762,9 @@ static struct qaic_bo *qaic_alloc_init_bo(void)
 	if (!bo)
 		return ERR_PTR(-ENOMEM);
 
-	qaic_init_bo(bo, false);
+	mutex_init(&bo->lock);
+	bo->fence_context = dma_fence_context_alloc(1);
+	qaic_init_bo_lists(bo);
 
 	return bo;
 }
@@ -996,6 +993,7 @@ static void qaic_unprepare_bo(struct qaic_device *qdev, struct qaic_bo *bo)
 	bo->dir = 0;
 	bo->dbc = NULL;
 	bo->nr_slice = 0;
+	bo->sliced = false;
 }
 
 static void qaic_free_slices_bo(struct qaic_bo *bo)
@@ -1304,9 +1302,7 @@ static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *fil
 			goto unlock_bo;
 		}
 
-		spin_lock_irqsave(&dbc->xfer_lock, flags);
 		if (bo_queued(bo)) {
-			spin_unlock_irqrestore(&dbc->xfer_lock, flags);
 			ret = -EINVAL;
 			goto unlock_bo;
 		}
@@ -1327,12 +1323,15 @@ static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *fil
 							     head, tail);
 			else
 				ret = copy_exec_reqs(qdev, slice, dbc->id, head, tail);
-			if (ret) {
-				spin_unlock_irqrestore(&dbc->xfer_lock, flags);
+			if (ret)
 				goto unlock_bo;
-			}
 		}
-		reinit_completion(&bo->xfer_done);
+
+		ret = qaic_acquire_bo_fence(bo);
+		if (ret)
+			goto unlock_bo;
+
+		spin_lock_irqsave(&dbc->xfer_lock, flags);
 		list_add_tail(&bo->xfer_list, &dbc->xfer_list);
 		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
 		dma_sync_sgtable_for_device(&qdev->pdev->dev, bo->sgt, bo->dir);
@@ -1787,11 +1786,13 @@ irqreturn_t dbc_irq_threaded_fn(int irq, void *data)
 			 * At this point we have received all the interrupts for
 			 * BO, which means BO execution is complete.
 			 */
-			dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, bo->dir);
 			bo->nr_slice_xfer_done = 0;
 			list_del_init(&bo->xfer_list);
-			bo->perf_stats.req_processed_ts = ktime_get_ns();
-			complete_all(&bo->xfer_done);
+			/*
+			 * fence is put when it is executed next, during xfer_list
+			 * cleanup, or when slice is detached
+			 */
+			dma_fence_signal(&bo->fence->base);
 			drm_gem_object_put(&bo->base);
 			break;
 		}
@@ -1840,6 +1841,7 @@ int qaic_wait_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 	struct dma_bridge_chan *dbc;
 	struct drm_gem_object *obj;
 	struct qaic_device *qdev;
+	struct dma_fence *fence;
 	unsigned long timeout;
 	struct qaic_user *usr;
 	struct qaic_bo *bo;
@@ -1881,6 +1883,9 @@ int qaic_wait_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 		goto unlock_ch_srcu;
 	}
 
+	timeout = args->timeout ? args->timeout : wait_exec_default_timeout_ms;
+	timeout = msecs_to_jiffies(timeout);
+
 	obj = drm_gem_object_lookup(file_priv, args->handle);
 	if (!obj) {
 		ret = -ENOENT;
@@ -1888,15 +1893,24 @@ int qaic_wait_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 	}
 
 	bo = to_qaic_bo(obj);
-	timeout = args->timeout ? args->timeout : wait_exec_default_timeout_ms;
-	timeout = msecs_to_jiffies(timeout);
-	ret = wait_for_completion_interruptible_timeout(&bo->xfer_done, timeout);
-	if (!ret) {
-		ret = -ETIMEDOUT;
+	ret = mutex_lock_interruptible(&bo->lock);
+	if (ret)
+		goto put_obj;
+
+	if (!bo->fence) {
+		ret = -ENOENT;
+		mutex_unlock(&bo->lock);
 		goto put_obj;
 	}
-	if (ret > 0)
-		ret = 0;
+
+	fence = &bo->fence->base;
+	dma_fence_get(fence);
+	mutex_unlock(&bo->lock);
+
+	ret = qaic_fence_wait(fence, timeout);
+	dma_fence_put(fence);
+	if (ret)
+		goto put_obj;
 
 	if (!dbc->usr)
 		ret = -EPERM;
@@ -2000,9 +2014,10 @@ int qaic_perf_stats_bo_ioctl(struct drm_device *dev, void *data, struct drm_file
 
 static void detach_slice_bo(struct qaic_device *qdev, struct qaic_bo *bo)
 {
+	qaic_remove_bo_fence(bo);
 	qaic_free_slices_bo(bo);
 	qaic_unprepare_bo(qdev, bo);
-	qaic_init_bo(bo, true);
+	qaic_init_bo_lists(bo);
 	list_del(&bo->bo_list);
 	drm_gem_object_put(&bo->base);
 }
@@ -2015,7 +2030,6 @@ int qaic_detach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 	struct drm_gem_object *obj;
 	struct qaic_device *qdev;
 	struct qaic_user *usr;
-	unsigned long flags;
 	struct qaic_bo *bo;
 	int ret;
 
@@ -2060,13 +2074,10 @@ int qaic_detach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 	}
 
 	/* Check if BO is committed to H/W for DMA */
-	spin_lock_irqsave(&dbc->xfer_lock, flags);
 	if (bo_queued(bo)) {
-		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
 		ret = -EBUSY;
 		goto unlock_ch_srcu;
 	}
-	spin_unlock_irqrestore(&dbc->xfer_lock, flags);
 
 	detach_slice_bo(qdev, bo);
 
@@ -2093,14 +2104,19 @@ static void empty_xfer_list(struct qaic_device *qdev, struct dma_bridge_chan *db
 		bo = list_first_entry(&dbc->xfer_list, typeof(*bo), xfer_list);
 		list_del_init(&bo->xfer_list);
 		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
+		mutex_lock(&bo->lock);
 		bo->nr_slice_xfer_done = 0;
 		bo->req_id = 0;
 		bo->perf_stats.req_received_ts = 0;
 		bo->perf_stats.req_submit_ts = 0;
 		bo->perf_stats.req_processed_ts = 0;
 		bo->perf_stats.queue_level_before = 0;
-		dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, bo->dir);
-		complete_all(&bo->xfer_done);
+		dma_fence_get(&bo->fence->base);
+		dma_fence_set_error(&bo->fence->base, -ECANCELED);
+		dma_fence_signal(&bo->fence->base);
+		dma_fence_put(&bo->fence->base);
+		qaic_remove_bo_fence(bo);
+		mutex_unlock(&bo->lock);
 		drm_gem_object_put(&bo->base);
 		spin_lock_irqsave(&dbc->xfer_lock, flags);
 	}
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index c1bb6db78d12..219f58fdfde8 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -40,7 +40,7 @@ MODULE_IMPORT_NS("DMA_BUF");
 #define PCI_DEVICE_ID_QCOM_AIC080	0xa080
 #define PCI_DEVICE_ID_QCOM_AIC100	0xa100
 #define PCI_DEVICE_ID_QCOM_AIC200	0xa110
-#define QAIC_NAME			"qaic"
+#define PCI_DEVICE_ID_QCOM_AIC200VF	0xa111
 #define QAIC_DESC			"Qualcomm Cloud AI Accelerators"
 #define CNTL_MAJOR			5
 #define CNTL_MINOR			0
diff --git a/drivers/accel/qaic/qaic_fence.c b/drivers/accel/qaic/qaic_fence.c
new file mode 100644
index 000000000000..ec7e555c454b
--- /dev/null
+++ b/drivers/accel/qaic/qaic_fence.c
@@ -0,0 +1,144 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved. */
+
+#include <linux/dma-fence.h>
+#include <linux/dma-resv.h>
+#include <linux/ktime.h>
+#include <linux/spinlock.h>
+#include <linux/sprintf.h>
+
+#include "qaic.h"
+
+static const char *qaic_fence_get_driver_name(struct dma_fence *f)
+{
+	return QAIC_NAME;
+}
+
+static const char *qaic_fence_get_timeline_name(struct dma_fence *f)
+{
+	struct qaic_fence *qfence = container_of(f, struct qaic_fence, base);
+
+	if (!qfence->timeline_name[0])
+		scnprintf(qfence->timeline_name, ARRAY_SIZE(qfence->timeline_name), "D%02u",
+			 qfence->dbc_id);
+	return qfence->timeline_name;
+}
+
+static const struct dma_fence_ops qaic_fence_ops = {
+	.get_driver_name = qaic_fence_get_driver_name,
+	.get_timeline_name = qaic_fence_get_timeline_name,
+};
+
+static void qaic_fence_sync_cb_func(struct dma_fence *f, struct dma_fence_cb *cb)
+{
+	struct qaic_bo *bo = container_of(cb, struct qaic_bo, cb);
+	struct qaic_device *qdev;
+
+	if (f->error)
+		return;
+
+	qdev = bo->dbc->qdev;
+	dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, bo->dir);
+	bo->perf_stats.req_processed_ts = ktime_to_ns(f->timestamp);
+}
+
+int qaic_fence_wait(struct dma_fence *fence, signed long timeout)
+{
+	int ret;
+
+	timeout = dma_fence_wait_timeout(fence, true, timeout);
+	if (!timeout) { /* Wait timed out */
+		ret = -ETIMEDOUT;
+	} else if (timeout < 0) { /* Wait interrupted */
+		ret = -EINTR;
+	} else { /* Wait completed */
+		ret = dma_fence_get_status(fence);
+		WARN_ON_ONCE(ret == 0);
+		if (!ret) /* Fence not signaled yet */
+			ret = -EBUSY;
+		else if (ret > 0)  /* Fence is signaled successfully */
+			ret = 0;
+		/* otherwise ret already contains the error code of the fence */
+	}
+	return ret;
+}
+
+static struct qaic_fence *qaic_create_fence(struct qaic_bo *bo)
+{
+	struct qaic_fence *fence;
+
+	fence = kzalloc_obj(*fence);
+	if (!fence)
+		return ERR_PTR(-ENOMEM);
+
+	spin_lock_init(&fence->lock);
+	fence->dbc_id = bo->dbc->id;
+	dma_fence_init(&fence->base, &qaic_fence_ops, &fence->lock, bo->fence_context, 1);
+
+	return fence;
+}
+
+/* Caller should be holding bo->lock */
+static int qaic_set_bo_resv_fence(struct qaic_bo *bo, struct qaic_fence *fence)
+{
+	int ret;
+
+	ret = dma_resv_reserve_fences(bo->base.resv, 1);
+	if (ret)
+		goto err_out_fence;
+
+	/*
+	 * Add a fence in dma-buf reservation object for this BO,
+	 * enables buffer sharing across devices.
+	 */
+	dma_resv_add_fence(bo->base.resv, &fence->base,
+			   dma_resv_usage_rw(bo->dir == DMA_TO_DEVICE));
+
+	ret = dma_fence_add_callback(&fence->base, &bo->cb, qaic_fence_sync_cb_func);
+	if (ret)
+		goto err_out_fence;
+
+	return ret;
+
+err_out_fence:
+	dma_fence_put(&fence->base);
+	bo->fence = NULL;
+	return ret;
+}
+
+/* Caller should be holding bo->lock */
+void qaic_remove_bo_fence(struct qaic_bo *bo)
+{
+	if (bo->fence) {
+		if (!dma_fence_is_signaled(&bo->fence->base)) {
+			dma_fence_set_error(&bo->fence->base, -ECANCELED);
+			dma_fence_signal(&bo->fence->base);
+		}
+		dma_fence_put(&bo->fence->base);
+	}
+	bo->fence = NULL;
+}
+
+/* Caller should be holding bo->lock */
+static void qaic_replace_bo_fence(struct qaic_bo *bo, struct qaic_fence *fence)
+{
+	qaic_remove_bo_fence(bo);
+	bo->fence = fence;
+}
+
+/* Caller should be holding bo->lock */
+int qaic_acquire_bo_fence(struct qaic_bo *bo)
+{
+	struct qaic_fence *fence;
+	int ret = 0;
+
+	fence = qaic_create_fence(bo);
+	if (IS_ERR(fence))
+		return PTR_ERR(fence);
+
+	qaic_replace_bo_fence(bo, fence);
+	ret = qaic_set_bo_resv_fence(bo, fence);
+
+	return ret;
+}
-- 
2.43.0

