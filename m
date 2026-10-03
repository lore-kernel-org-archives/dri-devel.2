Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 95249CA5FE2
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:39:14 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id EA59E10E71C;
	Sat,  3 Oct 2026 02:39:13 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="addzX1pb";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="gPTHT2hL";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id DABC310E71C
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:39:11 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeQI13337994
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 02:39:11 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=NUsKTC3b6J3
 Po6ie7UxjBG3dEjuyh1dvnzc/MnprXkU=; b=addzX1pbzRkAD18DYO2NFpoaW5t
 CUDK5xjkrvJ/enJwyJ9DB9vK58JwuBe1vl3ZWTQNOVAp4F68uGJFc/rnXWC1iECt
 g3NMxITn6n4c+e5tvfJLuVh8zPayytyR8U4io7Zh+ASsEs0sm/F3WWQNlndiToFf
 46mjIho54nUltwfMIV8Jit0K6iC1WonAIEAGXUEOSxsVN718svvWWR7+KQ1W+7Ww
 ptfjeHKznyDbp+X2x6tCnGYolbuituQ+9Tf6lNHBvoj1Rtt+lEmU5fz2FCJJjbrM
 uvkejl5DRLoG4IC6IzFRjRvbTH54YMBrM5XKOv55EftvF1G7v+oPpwQxeYA==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj03akp-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:39:10 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-3510d0baf63so356397eec.1
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 19:39:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790995150; x=1791599950;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=NUsKTC3b6J3Po6ie7UxjBG3dEjuyh1dvnzc/MnprXkU=;
 b=gPTHT2hLhfYbtvfYlvLMd1Y18fG8Hvpfl90agWyhRGII2qnUK2/JAEaE2RgKP7Olxo
 S5d50orLNp//w7PyUxIf6XdYPkHVRRNToJxoxYJXANM7zsakHj6xoLYRJvapDjtllecw
 ufqIhHpEfJ740I9d353HGIEdPA9tJtZK/ZY278M9oM4Q9DQ/aBAD06J2H5zE4pQkvjlz
 XOwnHL8PsbmsM+2Yo9oZ3QUcrbRf4NdeTwH854ZIqk2z/ytg7mICPREJvcKgdNsYer7D
 t1GgHteoLYYE2fUAN+l6zqlBV6ox2cRaABq1gbA/RlAcncxoeck0tkvaWUqPCaVBPQym
 xGTQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995150; x=1791599950;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=NUsKTC3b6J3Po6ie7UxjBG3dEjuyh1dvnzc/MnprXkU=;
 b=l//G33c2XD+2g1d0onDYThWHN6G4ooVUnuQ93q1xEE9RwcazfVG6v4Apgr3ULXvAtQ
 nkjmv2VT/eOJ7Os4SWzQ0nts3hhPDNAQ50tmndyIe62ArQU/UhGNUVI9hHeyecj3zZSq
 fnwONi3Lp81Au7gMnE5fa02UFBT9p5YHxbiERBafCabJ4avw+v49djZz+T2qgy934Xg7
 gGwp5EuWR0DBTfe+taS/ZLDIe0NK+pCMRfl0zoz3lejBwzrIuFIBBptNglSNzF30S23h
 4HgXSwBc6WpgfZo9kox3XN2lYU2F9913MuqVJi8PBPBEP9vVM36G0XNNEH9JArRCUkYs
 K0dw==
X-Forwarded-Encrypted: i=1;
 AKwUvByhLJ1ulWximFvZ6ZgB4foYwltvOSWFyYAvQKxtdfPXrQqxPYXqqO8NnUpi1GJ2ehy5nHmTa2bgvPk=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYJtMHBShBOmq/VjWTb1hZEPT7jYTBHxJKhc1lJ+ePptwdV+HPLE
 dDFBi9wZI2U/HE1UUprZCjU4BCGkqX5bBDC1GiEMH4MogpN0eGlHa3/bYRCH836WRyTNUZ7m/UV
 JOmXqctIVoY9wf5Yl67A7VsXosQ34S+qssY0eN7rWONZrctd7FWq6kOpo+mSoKhp/DSHFZMc=
X-Gm-Gg: AYBFou2di4lSV+pJE1rkifbcf2QkX/shVWTvh76CLWoorYNeNwRnM2HtBldv1wkVFKf
 CSn2L21+h3JM0sDdE112dpsvzFVmb0aQI1Q0JYAKlWWtyvBFaWiuFe++FvIklJDUiGJ+qmcpYLy
 UCaZE5Qd3AjJtxM8Ll9z6wksV2EYGkJwRe+IS6+MdNamigZvPAwyZ0Ss3vMKYQMNS7uNot7ZhZw
 utaNe8e10qMeA85H7LVVX6EnfttKjC5ZTYjVa1IO0iP2hjr2MIgJKGNUHecMSOshwQ1/yqCFrSQ
 4FyG+rGndW64c7x/SlJSC8TvfIgRx+CyoXZceMevxEPsnTQyI12WdrnTQ+u6Z2angQqN7jkDFGx
 hOQGCsCUAuS9CUV4Dg4UlfVD+KMuWtOObipxwZ5oQQVWIJ82SEJ98c61m
X-Received: by 2002:a05:7300:c00b:10b0:34c:fedf:ec64 with SMTP id
 5a478bee46e88-351114f8a93mr1684391eec.30.1790995149576; 
 Fri, 02 Oct 2026 19:39:09 -0700 (PDT)
X-Received: by 2002:a05:7300:c00b:10b0:34c:fedf:ec64 with SMTP id
 5a478bee46e88-351114f8a93mr1684356eec.30.1790995148853; 
 Fri, 02 Oct 2026 19:39:08 -0700 (PDT)
Received: from carlv-linux.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3510752b575sm7665736eec.6.2026.10.02.19.39.08
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 19:39:08 -0700 (PDT)
From: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>,
 Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Subject: [PATCH 1/6] accel/qaic: Centralize execution info
Date: Fri,  2 Oct 2026 19:38:13 -0700
Message-ID: <20261003023818.1161666-2-carl.vanderlip@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfX+EvmO91OfL9g
 X8FP62x1NzIBRW1Ir9x/s6dPMgNy2oB8u1UkGKlKb0j03FYH0fn+po8e/+rVm9VcMn1Hzh4s+7o
 Z4FSCe77pAixG70GRNa4t3oBrjtbXHM=
X-Proofpoint-GUID: t6M1dlKZH1VDVh0r6XY0bvMp77FRp-Wc
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6ac06ace cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=jqpLdFhmzWg4wxF5_swA:9 a=scEy_gLbYbu1JhEsrz4S:22
 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfXz3jx5IcW3gwT
 R81Dy82vaSisttUvYYENBJYXiFndT0KNopTAfIDgb3BaDedMUa9S+fOSI1vZ+ECe6L8tHDXCede
 XzKytquZHvzSEbT7lNN+AlNJkQzP4WT6PT6evPgugfTMf/EdrmDyf0NY1UT84aU/XxYMcwc3iUV
 AbQt4/+rq/tyqQ9U8Si0NBRZ0kGiM8A8paW1f+Rnta0YU+CSVprEursUDo3Hp9F4DAeD0cCFk4w
 ud7Qdb/BuKqFoIrrcZBB3t+uIMYkaI8gfX/BdBrUwHrjODDiB6GFJzmHGJwo1bw8j4f98jlMgnQ
 DHsn+AnaVinCj2OoQ7n2dEGMzHHZtdbx/5HWAz6/p+PV5i7HkU1q/4taujYDvWZNOsIiWbO6FTl
 3RtsGN4T1goxnzA2iXHn//okICUGr4j/IQZjM3lgJMdNqGNzUGF4B4eIqS/iOmZS+En2a8TQT2b
 KDc9g5nNJci5ULVfArw==
X-Proofpoint-ORIG-GUID: t6M1dlKZH1VDVh0r6XY0bvMp77FRp-Wc
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

Move per-exec ioctl information into common data structure in
preparation for adding dma-resv fences which require all BO's associated
with a fence to be locked with drm_gem_lock_reservations().

Co-developed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Signed-off-by: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
---
 drivers/accel/qaic/qaic_data.c | 261 ++++++++++++++++++++++++---------
 1 file changed, 190 insertions(+), 71 deletions(-)

diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 4d55531bf1c9..64bc3cc50d1f 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -143,6 +143,47 @@ struct dbc_rsp {
 	__le16	status;
 } __packed;
 
+/* Common data structure for all the variants of execute IOCTL */
+struct execute_info {
+	/* Number of entries present in arrays */
+	u32 count;
+	struct {
+		u64 received_ts;
+		u64 submit_ts;
+		u32 queue_level;
+	} perf_stats;
+	/* Array of pointers to BOs for this execution */
+	struct qaic_bo **bo_arr;
+	/* Array of handles to above BOs, helpful for identifying failures */
+	u32 *handle_arr;
+	/* Array of new sizes for BO transfer if request is_partial */
+	u64 *resize_arr;
+	/* True if execution is of resized BO */
+	bool is_partial;
+};
+
+/* Helper structure for retrieving info about execution entries */
+struct qaic_exec_data_ent {
+	/* Pointer to requested gem object */
+	struct drm_gem_object *obj;
+	/* New size for BO transfer if request is partial execute */
+	u64 resize;
+	/* Per-file handle for BO, helpful for identifying failures */
+	u32 handle;
+};
+
+/* Helper structure for requesting info about execution entries */
+struct qaic_exec_data_req {
+	/* Pointer to drm file */
+	struct drm_file *drm_file;
+	/* Pointer to beginning of array of execution entries from user */
+	void *exec_data;
+	/* Is exec_data an array of partial execution entries? */
+	bool is_partial;
+	/* Index of exec_data array this request is acting upon */
+	int idx;
+};
+
 static inline bool bo_queued(struct qaic_bo *bo)
 {
 	return !list_empty(&bo->xfer_list);
@@ -1222,41 +1263,43 @@ static inline int copy_partial_exec_reqs(struct qaic_device *qdev, struct bo_sli
 }
 
 static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *file_priv,
-				  struct qaic_execute_entry *exec, unsigned int count,
-				  bool is_partial, struct dma_bridge_chan *dbc, u32 head,
-				  u32 *tail)
+				  struct execute_info *exec, struct dma_bridge_chan *dbc,
+				  u32 head, u32 *tail)
 {
-	struct qaic_partial_execute_entry *pexec = (struct qaic_partial_execute_entry *)exec;
-	struct drm_gem_object *obj;
+	struct ww_acquire_ctx acquire_ctx;
 	struct bo_slice *slice;
 	unsigned long flags;
 	struct qaic_bo *bo;
+	u64 resize;
+	u32 handle;
 	int i, j;
 	int ret;
 
-	for (i = 0; i < count; i++) {
-		/*
-		 * ref count will be decremented when the transfer of this
-		 * buffer is complete. It is inside dbc_irq_threaded_fn().
-		 */
-		obj = drm_gem_object_lookup(file_priv,
-					    is_partial ? pexec[i].handle : exec[i].handle);
-		if (!obj) {
-			ret = -ENOENT;
-			goto failed_to_send_bo;
-		}
+	ret = drm_gem_lock_reservations((struct drm_gem_object **)exec->bo_arr,
+					exec->count, &acquire_ctx);
+	if (ret)
+		return ret;
 
-		bo = to_qaic_bo(obj);
+	for (i = 0; i < exec->count; i++) {
+		resize = exec->is_partial ? exec->resize_arr[i] : 0;
+		bo = exec->bo_arr[i];
+		handle = exec->handle_arr[i];
 		ret = mutex_lock_interruptible(&bo->lock);
 		if (ret)
 			goto failed_to_send_bo;
 
+		/*
+		 * Take reference to object before sending to device,
+		 * released when transfer is complete (in dbc_irq_threaded_fn()).
+		 */
+		drm_gem_object_get(&bo->base);
+
 		if (!bo->sliced) {
 			ret = -EINVAL;
 			goto unlock_bo;
 		}
 
-		if (is_partial && pexec[i].resize > bo->base.size) {
+		if (exec->is_partial && resize > bo->base.size) {
 			ret = -EINVAL;
 			goto unlock_bo;
 		}
@@ -1274,13 +1317,13 @@ static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *fil
 			for (j = 0; j < slice->nents; j++)
 				slice->reqs[j].req_id = cpu_to_le16(bo->req_id);
 
-			if (is_partial && (!pexec[i].resize || pexec[i].resize <= slice->offset))
+			if (exec->is_partial && (!resize || resize <= slice->offset))
 				/* Configure the slice for no DMA transfer */
 				ret = copy_partial_exec_reqs(qdev, slice, 0, dbc, head, tail);
-			else if (is_partial && pexec[i].resize < slice->offset + slice->size)
+			else if (exec->is_partial && resize < slice->offset + slice->size)
 				/* Configure the slice to be partially DMA transferred */
 				ret = copy_partial_exec_reqs(qdev, slice,
-							     pexec[i].resize - slice->offset, dbc,
+							     resize - slice->offset, dbc,
 							     head, tail);
 			else
 				ret = copy_exec_reqs(qdev, slice, dbc->id, head, tail);
@@ -1296,82 +1339,124 @@ static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *fil
 		mutex_unlock(&bo->lock);
 	}
 
-	return 0;
+	goto unlock_resv;
 
 unlock_bo:
+	drm_gem_object_put(&bo->base);
 	mutex_unlock(&bo->lock);
 failed_to_send_bo:
-	if (likely(obj))
-		drm_gem_object_put(obj);
 	for (j = 0; j < i; j++) {
+		drm_gem_object_put(&exec->bo_arr[j]->base);
 		spin_lock_irqsave(&dbc->xfer_lock, flags);
 		bo = list_last_entry(&dbc->xfer_list, struct qaic_bo, xfer_list);
-		obj = &bo->base;
 		list_del_init(&bo->xfer_list);
 		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
 		dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, bo->dir);
-		drm_gem_object_put(obj);
 	}
+unlock_resv:
+	drm_gem_unlock_reservations((struct drm_gem_object **)exec->bo_arr,
+				    exec->count, &acquire_ctx);
 	return ret;
 }
 
-static void update_profiling_data(struct drm_file *file_priv,
-				  struct qaic_execute_entry *exec, unsigned int count,
-				  bool is_partial, u64 received_ts, u64 submit_ts, u32 queue_level)
+static void update_profiling_data(struct execute_info *exec)
 {
-	struct qaic_partial_execute_entry *pexec = (struct qaic_partial_execute_entry *)exec;
-	struct drm_gem_object *obj;
+	u32 queue_level = exec->perf_stats.queue_level;
 	struct qaic_bo *bo;
 	int i;
 
-	for (i = 0; i < count; i++) {
-		/*
-		 * Since we already committed the BO to hardware, the only way
-		 * this should fail is a pending signal. We can't cancel the
-		 * submit to hardware, so we have to just skip the profiling
-		 * data. In case the signal is not fatal to the process, we
-		 * return success so that the user doesn't try to resubmit.
-		 */
-		obj = drm_gem_object_lookup(file_priv,
-					    is_partial ? pexec[i].handle : exec[i].handle);
-		if (!obj)
-			break;
-		bo = to_qaic_bo(obj);
-		bo->perf_stats.req_received_ts = received_ts;
-		bo->perf_stats.req_submit_ts = submit_ts;
+	for (i = 0; i < exec->count; i++) {
+		bo = exec->bo_arr[i];
+		bo->perf_stats.req_received_ts = exec->perf_stats.received_ts;
+		bo->perf_stats.req_submit_ts = exec->perf_stats.submit_ts;
 		bo->perf_stats.queue_level_before = queue_level;
 		queue_level += bo->total_slice_nents;
-		drm_gem_object_put(obj);
 	}
 }
 
+static int exec_index_to_gem_info(struct qaic_exec_data_req req, struct qaic_exec_data_ent *ent)
+{
+	int idx = req.idx;
+	int ret = 0;
+	u32 handle;
+
+	if (req.is_partial) {
+		struct qaic_partial_execute_entry *exec_ent_part = req.exec_data;
+
+		handle = exec_ent_part[idx].handle;
+		ent->resize = exec_ent_part[idx].resize;
+	} else {
+		struct qaic_execute_entry *exec_ent = req.exec_data;
+
+		handle = exec_ent[idx].handle;
+	}
+
+	ent->obj = drm_gem_object_lookup(req.drm_file, handle);
+	if (!ent->obj)
+		ret = -ENOENT;
+
+	ent->handle = handle;
+
+	return ret;
+}
+
+static int lookup_exec_data(struct drm_file *file_priv, void *exec_data,
+			       struct execute_info *exec)
+{
+	struct qaic_exec_data_req req;
+	struct qaic_exec_data_ent ent;
+	int i, ret = 0;
+
+	req.drm_file = file_priv;
+	req.exec_data = exec_data;
+	req.is_partial = exec->is_partial;
+
+	for (i = 0; i < exec->count; i++) {
+		req.idx = i;
+		ret = exec_index_to_gem_info(req, &ent);
+		if (ret)
+			goto put_obj;
+
+		exec->bo_arr[i] = to_qaic_bo(ent.obj);
+		exec->handle_arr[i] = ent.handle;
+		if (exec->resize_arr)
+			exec->resize_arr[i] = ent.resize;
+	}
+
+	return ret;
+put_obj:
+	for (i--; i >= 0; i--)
+		drm_gem_object_put(&exec->bo_arr[i]->base);
+	return ret;
+}
+
 static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *file_priv,
 				   bool is_partial)
 {
+	size_t usr_ent_size = is_partial ? sizeof(struct qaic_partial_execute_entry) :
+					   sizeof(struct qaic_execute_entry);
+	int usr_rcu_id, qdev_rcu_id, ch_rcu_id;
 	struct qaic_execute *args = data;
-	struct qaic_execute_entry *exec;
 	struct dma_bridge_chan *dbc;
-	int usr_rcu_id, qdev_rcu_id;
 	struct qaic_device *qdev;
+	struct execute_info exec;
 	struct qaic_user *usr;
-	u64 received_ts;
-	u32 queue_level;
-	u64 submit_ts;
-	int rcu_id;
-	u32 head;
-	u32 tail;
-	u64 size;
-	int ret;
+	size_t elem_size_sum;
+	void *usr_exec_ent;
+	u32 head, tail;
+	int i, ret;
 
-	received_ts = ktime_get_ns();
+	exec.perf_stats.received_ts = ktime_get_ns();
+	exec.is_partial = is_partial;
 
-	size = is_partial ? sizeof(struct qaic_partial_execute_entry) : sizeof(*exec);
 	if (args->hdr.count == 0)
 		return -EINVAL;
 
-	exec = memdup_array_user(u64_to_user_ptr(args->data), args->hdr.count, size);
-	if (IS_ERR(exec))
-		return PTR_ERR(exec);
+	exec.count = args->hdr.count;
+
+	usr_exec_ent = memdup_array_user(u64_to_user_ptr(args->data), exec.count, usr_ent_size);
+	if (IS_ERR(usr_exec_ent))
+		return PTR_ERR(usr_exec_ent);
 
 	usr = file_priv->driver_priv;
 	usr_rcu_id = srcu_read_lock(&usr->qddev_lock);
@@ -1394,7 +1479,39 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 
 	dbc = &qdev->dbc[args->hdr.dbc_id];
 
-	rcu_id = srcu_read_lock(&dbc->ch_lock);
+	/*
+	 * Going to allocate one large array, and then create pointers to
+	 * within it for sub-arrays that all have exec.count elements in them.
+	 *
+	 * bo_arr is an array of pointers to struct qaic_bo, but is used as an
+	 * argument for drm_gem_lock_reservations().
+	 *
+	 * handle_arr is an array of handles to each drm_gem_object embedded in
+	 * the respective bo_arr element. It is used to help debugging by
+	 * identifying particular buffers.
+	 *
+	 * resize_arr is an array of u64 sizes for partial executions. It is
+	 * only defined if a partial execution is underway.
+	 */
+	elem_size_sum = sizeof(*exec.bo_arr) + sizeof(*exec.handle_arr);
+	elem_size_sum += is_partial ? sizeof(*exec.resize_arr) : 0;
+	exec.bo_arr = kcalloc(exec.count, elem_size_sum, GFP_KERNEL);
+	if (!exec.bo_arr) {
+		ret = -ENOMEM;
+		goto unlock_dev_srcu;
+	}
+	exec.handle_arr = ((void *)exec.bo_arr) + (sizeof(*exec.bo_arr) * exec.count);
+	if (is_partial)
+		exec.resize_arr = ((void *)exec.bo_arr) +
+				  ((sizeof(*exec.bo_arr) + sizeof(*exec.handle_arr)) * exec.count);
+	else
+		exec.resize_arr = NULL;
+
+	ret = lookup_exec_data(file_priv, usr_exec_ent, &exec);
+	if (ret)
+		goto free_bo_arr;
+
+	ch_rcu_id = srcu_read_lock(&dbc->ch_lock);
 	if (!dbc->usr || dbc->usr->handle != usr->handle) {
 		ret = -EPERM;
 		goto release_ch_rcu;
@@ -1418,20 +1535,18 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 		goto unlock_req_lock;
 	}
 
-	queue_level = head <= tail ? tail - head : dbc->nelem - (head - tail);
+	exec.perf_stats.queue_level = head <= tail ? tail - head : dbc->nelem - (head - tail);
 
-	ret = send_bo_list_to_device(qdev, file_priv, exec, args->hdr.count, is_partial, dbc,
-				     head, &tail);
+	ret = send_bo_list_to_device(qdev, file_priv, &exec, dbc, head, &tail);
 	if (ret)
 		goto unlock_req_lock;
 
 	/* Finalize commit to hardware */
-	submit_ts = ktime_get_ns();
+	exec.perf_stats.submit_ts = ktime_get_ns();
 	writel(tail, dbc->dbc_base + REQTP_OFF);
 	mutex_unlock(&dbc->req_lock);
 
-	update_profiling_data(file_priv, exec, args->hdr.count, is_partial, received_ts,
-			      submit_ts, queue_level);
+	update_profiling_data(&exec);
 
 	if (datapath_polling)
 		schedule_work(&dbc->poll_work);
@@ -1440,12 +1555,16 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 	if (ret)
 		mutex_unlock(&dbc->req_lock);
 release_ch_rcu:
-	srcu_read_unlock(&dbc->ch_lock, rcu_id);
+	srcu_read_unlock(&dbc->ch_lock, ch_rcu_id);
+	for (i = 0; i < exec.count; i++)
+		drm_gem_object_put(&exec.bo_arr[i]->base);
+free_bo_arr:
+	kfree(exec.bo_arr);
 unlock_dev_srcu:
 	srcu_read_unlock(&qdev->dev_lock, qdev_rcu_id);
 unlock_usr_srcu:
 	srcu_read_unlock(&usr->qddev_lock, usr_rcu_id);
-	kfree(exec);
+	kfree(usr_exec_ent);
 	return ret;
 }
 

base-commit: 0915fb19e08f7f14a03df78c67d081bbfa8ff1fa
-- 
2.43.0

