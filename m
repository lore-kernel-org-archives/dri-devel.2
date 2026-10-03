Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4810CCA5FE4
	for <dri-devel@archiver.kernel.org>; Sat,  3 Oct 2026 02:39:28 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 86D0A10E730;
	Sat,  3 Oct 2026 02:39:27 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=qualcomm.com header.i=@qualcomm.com header.b="MPm1JOGl";
	dkim=pass (2048-bit key; unprotected) header.d=oss.qualcomm.com header.i=@oss.qualcomm.com header.b="K4mfr9PZ";
	dkim-atps=neutral
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com
 [205.220.180.131])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 1C8A710E730
 for <dri-devel@lists.freedesktop.org>; Sat,  3 Oct 2026 02:39:26 +0000 (UTC)
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
 by mx0a-0031df01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 692NeLUk3337864
 for <dri-devel@lists.freedesktop.org>; Sat, 3 Oct 2026 02:39:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=qualcomm.com; h=
 cc:content-transfer-encoding:date:from:in-reply-to:message-id
 :mime-version:references:subject:to; s=qcppdkim1; bh=zCL9hgHRrgr
 CRKucGc49oUpynHJkuTRj7wtzvSVqyZU=; b=MPm1JOGlbYri73Vsdp+UPyZ8OV7
 /okHOfCpcB+20TipVqHpdCND/pRuwqSvmcobwLuEFvGz28Vv9ouOZCo1gHOv/DB3
 UF9xZ1hAvsi26GFhk04ACuhRxUJnOlA2NPng6suJ40WmvDXKidnf2PNJBHEM5gkk
 rQBtt/4tOjmMx/roCz+HQjFkdqAaFOv9Q1ImwQBRP8ryAwC1l0+GWZULMNd3zKiy
 Ubq9daP0azwQVnIoKjsZHqfH5XgnNl27DJNm0z7DR2bWLctam/BpmLDlLp+hYG86
 M5j9iq4ReU65ySRvFWDv8SHL7ioKvm8DHb/ZYAbxYv+l/IXvktWC9j6hkfQ==
Received: from mail-dy1-f199.google.com (mail-dy1-f199.google.com
 [74.125.82.199])
 by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 4h2aj03amw-1
 (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NOT)
 for <dri-devel@lists.freedesktop.org>; Sat, 03 Oct 2026 02:39:24 +0000 (GMT)
Received: by mail-dy1-f199.google.com with SMTP id
 5a478bee46e88-34d49d8dee1so335768eec.0
 for <dri-devel@lists.freedesktop.org>; Fri, 02 Oct 2026 19:39:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=oss.qualcomm.com; s=google; t=1790995164; x=1791599964;
 darn=lists.freedesktop.org; 
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:from:to:cc:subject:date
 :message-id:reply-to:content-type;
 bh=zCL9hgHRrgrCRKucGc49oUpynHJkuTRj7wtzvSVqyZU=;
 b=K4mfr9PZkXaUNkMySmTlIfKtS+NlmOIje4R++Xwozyzg5ceV7cMITLCWmAUcLkQHUg
 iP0uVmiWkIgzdpZAwdbWol8RbJG2EYgXhMV1oXSCCRBv2A6wmAYV2BxgF74Te2Sqb2Tq
 NV/0GrgB9aNspwtsDKnPqT42u3tOMCyEIPQ3n+6OzT5vn43fYxacBThqpPGiaUWWlYfG
 i7KZnALagkXY1v1YjHBD5t51Lr/55L+mApOVStgYMr5KLRNI+M3dEcYj5aXzo0drydVZ
 86skRX9vEssuAAbkwaAHh5FVIGfmHApyrHhoUWxcC2T/vwAW5xDad4E+dozTYwZ3CeT0
 K3xA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20260707; t=1790995164; x=1791599964;
 h=content-transfer-encoding:mime-version:references:in-reply-to
 :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
 :to:cc:subject:date:message-id:reply-to:content-type;
 bh=zCL9hgHRrgrCRKucGc49oUpynHJkuTRj7wtzvSVqyZU=;
 b=HI47bUBoL87NCfwSJHHyFpr0kBqxp7UaUAejKiddyGYZ+jGbu5AQyNmb6Wx5ywLcBq
 M+Vv0jZBTCzKaN5L+WWu59HgwTmNgQBatUm7+wnzjQW1zNuSdqoNtjvq+93Qm3UJEsWd
 3MwcKqtgk72oA+smdoWH1XsYYrV9TwxL6Jcbjokawqp0ZpqYWqEWwuwoGRHdmfKg9GIz
 9ZDmQfPDCODFpp8hITQGNGBYNZSFqNrWO87EsWdQBZv2kQ3PtAyggB/VHTB8rEE/OQ2C
 Tibk5vYW+K0hLlRpwr656+sz75BVpbB5jExsCwfAInPhWYwLUDB1/C3nSEwAy6MWemar
 68Kw==
X-Forwarded-Encrypted: i=1;
 AKwUvBwodJOEaennk9g3LLpsmJ57kTO+ndDBz3Vd9rVFOVTgqnmG9gODEhyno0yPayjY1ujNMYglfYH3uC4=@lists.freedesktop.org
X-Gm-Message-State: AFq9FYKjDgQHgtv31R3oGdle9K2v9jH0WoEKzGr1YBWuoXp/DPTuvGSr
 +MiMLNbgJQdv93mhtgIXj524L+I/rPXB/qNufAZ9jx5C1zKXhij56GrwJU4ewxVdd5bz1W7F9GP
 NdFhH7d6Qa5fzGaTjybVrS+giF+WKfAJDsnnQi5tyT+5h07Xgmox+AqEOaYjDgbnVSIBiklM=
X-Gm-Gg: AYBFou1tApwzYiWK4V9kyhGCpzTx5mthWvjGwYEGpbgbBa5CcigiJurTZbdketh2qZI
 fYrvu1gF38PW+glKz9CkxMDH6gzQB0KZAQSiMGNQ/EY7URJm7fq40Hv8vIKZ4IfCJnIUErKG7xM
 J9UJU5xeGRB7AqZYa44kXq//r+cWNqNFqG0AnYXBmxdvy+XJ8G51nHZwanCyC5ijx3rwI3cySN1
 Xy36/97cK5717n/foeCkOQYaHMTaIVMZUpTkc8MS8g/idmFpu9uk8vN6LgLM0GC42zmpxmKShD8
 TQRRcz0KJIVaWEBRw9epYKNltSEFOkRVnpMIGdHz0lj7p+k/GKsZIh0m+xy7MOCj5qkQtcRqTAj
 HpIMpevIPgzBNj+g5m5X4WsVs8AX493qriK0yE3OxEf+TT3TquUn8Fg27
X-Received: by 2002:a05:7300:f58d:b0:34d:4cb9:f24c with SMTP id
 5a478bee46e88-34f150cc0a1mr4918382eec.20.1790995163112; 
 Fri, 02 Oct 2026 19:39:23 -0700 (PDT)
X-Received: by 2002:a05:7300:f58d:b0:34d:4cb9:f24c with SMTP id
 5a478bee46e88-34f150cc0a1mr4918340eec.20.1790995162275; 
 Fri, 02 Oct 2026 19:39:22 -0700 (PDT)
Received: from carlv-linux.qualcomm.com (i-global254.qualcomm.com.
 [199.106.103.254]) by smtp.gmail.com with ESMTPSA id
 5a478bee46e88-3510752b575sm7665736eec.6.2026.10.02.19.39.21
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Fri, 02 Oct 2026 19:39:21 -0700 (PDT)
From: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
To: jeff.hugo@oss.qualcomm.com, carl.vanderlip@oss.qualcomm.com,
 troy.hanson@oss.qualcomm.com, zachary.mckevitt@oss.qualcomm.com
Cc: ogabbay@kernel.org, lizhi.hou@amd.com, karol.wachowski@linux.intel.com,
 linux-arm-msm@vger.kernel.org, dri-devel@lists.freedesktop.org,
 Sashiko <sashiko-bot@kernel.org>,
 Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>,
 Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Subject: [PATCH 4/6] accel/qaic: Use DRM_SCHED to handle FIFO submission
Date: Fri,  2 Oct 2026 19:38:16 -0700
Message-ID: <20261003023818.1161666-5-carl.vanderlip@oss.qualcomm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
References: <20261003023818.1161666-1-carl.vanderlip@oss.qualcomm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfX43It3bMcmjpS
 FpYr26me4cRSdSRNNL98N8J0YxYBoRvGDQoqcOV6iZrxcUz477YWt5HjXtiCPAsCYSX4kVaidoZ
 +ZLzv95me0Hu+/gPSDgAks5tXGKtako=
X-Proofpoint-GUID: KsktsEeYe1CRbZRWkqQUw3XCbh6q-N7o
X-Authority-Analysis: v=2.4 cv=UJZIjyfy c=1 sm=1 tr=0 ts=6ac06add cx=c_pps
 a=cFYjgdjTJScbgFmBucgdfQ==:117 a=JYp8KDb2vCoCEuGobkYCKw==:17
 a=660iZSQnnn4A:10 a=s4-Qcg_JpJYA:10 a=VkNPw1HP01LnGYTKEx00:22
 a=u7WPNUs3qKkmUXheDGA7:22 a=3WHJM1ZQz_JShphwDgj5:22 a=COk6AnOGAAAA:8
 a=EUspDBNiAAAA:8 a=1SGmV3kBK_6LbSKbM2kA:9 a=4jUS9IocgTha65DM:21
 a=scEy_gLbYbu1JhEsrz4S:22 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAzMDAxMCBTYWx0ZWRfX9TAv3vDlWPkS
 s/V7NB0nk1jC3v/IoaaxLjATBd010b0iLL3W8x23ZQcOGzZOiBaURGosQ7yCPY+ZYScnZ6y4Xtu
 DSYZfqSqFTBMK5CL0nmr7rJcwH30yrpY36cI6jmPRNPansSPlzO3X/U5DpmcztCA9mHIAMvFdkE
 F8K0cZIgior5MuElze/YhQdRITzw625+rabaLKHosKqLiLl+WdXlGAual5KJ+D1Vb19YnwYZK4D
 5xBbh7R1k+/phAZBWGC11fzfBms9rV9ms6jQtXkgU+AWWMqkSNBbdAGxkeF23g8KJje2w2+zvjx
 4FhjEuQz2sPMbhMJgg97Fwji519WGCn2hVHqiSVNEIV6aogJlqTUT0lhCN1lRzqa0/G6wklHq0e
 7cMuqafnNdTSBIepisQM2Y7LsnNPk55PL7cBqMtG1bstlhfcboqzzTn7Jx60soU5aRi7iTR94Wk
 XFwnQkgh0oFKAu0a2+w==
X-Proofpoint-ORIG-GUID: KsktsEeYe1CRbZRWkqQUw3XCbh6q-N7o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-02_07,2026-10-02_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 phishscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
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

Replace current FIFO submission process with DRM scheduler. Leverage
scheduler entity credit system to prevent overflow.

Since the network's FIFO size is unknown at device/scheduler creation, a
large fixed credit value is used (65536). During network activation, a
scaling ratio is calculated to map the real FIFO size to the fixed
credit limit. If the ratio would be a fraction, it is rounded up;
limiting FIFO utilization, but preventing overuse.

Co-developed-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Signed-off-by: Pranjal Ramajor Asha Kanojiya <quic_pkanojiy@quicinc.com>
Co-developed-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Signed-off-by: Youssef Samir <youssef.abdulrahman@oss.qualcomm.com>
Signed-off-by: Carl Vanderlip <carl.vanderlip@oss.qualcomm.com>
---
 drivers/accel/qaic/Kconfig        |   1 +
 drivers/accel/qaic/Makefile       |   1 +
 drivers/accel/qaic/qaic.h         | 159 +++++++++++++--
 drivers/accel/qaic/qaic_control.c |   5 +
 drivers/accel/qaic/qaic_data.c    | 315 ++++++++++--------------------
 drivers/accel/qaic/qaic_debugfs.c |   4 +-
 drivers/accel/qaic/qaic_drv.c     |  14 +-
 drivers/accel/qaic/qaic_fence.c   | 101 ++++++----
 drivers/accel/qaic/qaic_sched.c   | 236 ++++++++++++++++++++++
 include/uapi/drm/qaic_accel.h     |   2 +-
 10 files changed, 563 insertions(+), 275 deletions(-)
 create mode 100644 drivers/accel/qaic/qaic_sched.c

diff --git a/drivers/accel/qaic/Kconfig b/drivers/accel/qaic/Kconfig
index 116e42d152ca..d43c06394bb0 100644
--- a/drivers/accel/qaic/Kconfig
+++ b/drivers/accel/qaic/Kconfig
@@ -10,6 +10,7 @@ config DRM_ACCEL_QAIC
 	depends on MHI_BUS
 	select CRC32
 	select WANT_DEV_COREDUMP
+	select DRM_SCHED
 	help
 	  Enables driver for Qualcomm's Cloud AI accelerator PCIe cards that are
 	  designed to accelerate Deep Learning inference workloads.
diff --git a/drivers/accel/qaic/Makefile b/drivers/accel/qaic/Makefile
index 90582b0693da..092f962e71d3 100644
--- a/drivers/accel/qaic/Makefile
+++ b/drivers/accel/qaic/Makefile
@@ -12,6 +12,7 @@ qaic-y := \
 	qaic_drv.o \
 	qaic_fence.o \
 	qaic_ras.o \
+	qaic_sched.o \
 	qaic_ssr.o \
 	qaic_sysfs.o \
 	qaic_timesync.o \
diff --git a/drivers/accel/qaic/qaic.h b/drivers/accel/qaic/qaic.h
index 4cdd6579aa89..40c7492ea121 100644
--- a/drivers/accel/qaic/qaic.h
+++ b/drivers/accel/qaic/qaic.h
@@ -18,12 +18,14 @@
 #include <linux/workqueue.h>
 #include <drm/drm_device.h>
 #include <drm/drm_gem.h>
+#include <drm/gpu_scheduler.h>
 
 #define QAIC_NAME		"qaic"
 #define QAIC_DBC_BASE		SZ_128K
 #define QAIC_DBC_SIZE		SZ_4K
 #define QAIC_SSR_DBC_SENTINEL	U32_MAX /* No ongoing SSR sentinel */
-#define QAIC_TIMELINE_LEN	32 /* Should fit max sized DBC id/BO handle */
+#define QAIC_TIMELINE_LEN	32 /* Should fit max sized DBC id/Job id */
+#define QAIC_DBC_NAME_LEN	8
 
 #define QAIC_NO_PARTITION	-1
 
@@ -34,6 +36,7 @@
 #define to_drm(qddev) (&(qddev)->drm)
 #define to_accel_kdev(qddev) (to_drm(qddev)->accel->kdev) /* Return Linux device of accel node */
 #define to_qaic_device(dev) (to_qaic_drm_device((dev))->qdev)
+#define to_qaic_job(job) container_of((job), struct qaic_job, base)
 
 enum aic_families {
 	FAMILY_AIC100,
@@ -68,6 +71,32 @@ enum dbc_states {
 
 extern bool datapath_polling;
 
+struct qaic_job {
+	/*
+	 * Base job structure, internal to DRM.
+	 * Do not update any fields in base directly in this driver
+	 */
+	struct drm_sched_job	base;
+	/* QAIC GEM object this job is referencing */
+	struct qaic_bo		*bo;
+	/* Slice this job is executing */
+	struct bo_slice		*slice;
+	/* DBC associated with this job */
+	struct dma_bridge_chan	*dbc;
+	/* QAIC will signal this fence after execution of this job */
+	struct qaic_fence	*irq_fence;
+	/* Node of list of jobs associated with a DBC */
+	struct list_head	queue;
+	struct kref		ref_count;
+	/* Number of requests this job executes */
+	unsigned int		num_req;
+	/* True if this job is partially executed */
+	bool			partial;
+	u32			partial_size;
+	/* Identifier for this job */
+	u16			id;
+};
+
 struct qaic_user {
 	/* Uniquely identifies this user for the device */
 	int			handle;
@@ -86,8 +115,8 @@ struct dma_bridge_chan {
 	struct qaic_device	*qdev;
 	/* ID of this DMA bridge channel(DBC) */
 	unsigned int		id;
-	/* Synchronizes access to xfer_list */
-	spinlock_t		xfer_lock;
+	/* Synchronizes access to job queue */
+	spinlock_t		job_q_lock;
 	/* Base address of request queue */
 	void			*req_q_base;
 	/* Base address of response queue */
@@ -108,7 +137,7 @@ struct dma_bridge_chan {
 	 * memory handle can enqueue more than one request elements, all
 	 * this requests that belong to same memory handle have same request ID
 	 */
-	u16			next_req_id;
+	atomic_t		next_req_id;
 	/* true: DBC is in use; false: DBC not in use */
 	bool			in_use;
 	/*
@@ -118,8 +147,6 @@ struct dma_bridge_chan {
 	void __iomem		*dbc_base;
 	/* Synchronizes access to Request queue's head and tail pointer */
 	struct mutex		req_lock;
-	/* Head of list where each node is a memory handle queued in request queue */
-	struct list_head	xfer_list;
 	/* Synchronizes DBC readers during cleanup */
 	struct srcu_struct	ch_lock;
 	/*
@@ -135,6 +162,23 @@ struct dma_bridge_chan {
 	struct work_struct	poll_work;
 	/* Represents various states of this DBC from enum dbc_states */
 	unsigned int		state;
+	/*
+	 * Name of this DBC. Format is "dbcXXX" where XXX is DBC id
+	 * with leading 0's
+	 */
+	char				name[QAIC_DBC_NAME_LEN];
+	/* Job scheduler for this DBC */
+	struct drm_gpu_scheduler	sched;
+	/* Custom DRM scheduler workqueue for multi-device performance */
+	struct workqueue_struct		*submit_wq;
+	/* Scheduler entity for this DBC */
+	struct drm_sched_entity		sched_entity;
+	/* List head for jobs scheduled for execution */
+	struct list_head		job_queue;
+	/* Ratio to scale FIFO length to scheduler credit constant */
+	u32				credit_ratio;
+	/* Total number of requests that have been queued to this DBC */
+	u32				pending_reqs;
 };
 
 struct qaic_device {
@@ -238,6 +282,8 @@ struct qaic_fence {
 	char			timeline_name[QAIC_TIMELINE_LEN];
 	/* Cached value of dbc_id for use in populating timeline_name */
 	u32			dbc_id;
+	/* ID of associated Job */
+	u16			job_id;
 };
 
 struct qaic_bo {
@@ -257,24 +303,15 @@ struct qaic_bo {
 	struct dma_bridge_chan	*dbc;
 	/* Number of slice that belongs to this buffer */
 	u32			nr_slice;
-	/* Number of slice that have been transferred by DMA engine */
-	u32			nr_slice_xfer_done;
 	/*
 	 * If true then user has attached slicing information to this BO by
 	 * calling DRM_IOCTL_QAIC_ATTACH_SLICE_BO ioctl.
 	 */
 	bool			sliced;
-	/* Request ID of this BO if it is queued for execution */
-	u16			req_id;
 	/* Wait on this fence for DMA transfer of this BO */
-	struct qaic_fence	*fence;
+	struct dma_fence	*fence;
 	/* Current fence context for this BO */
 	u64			fence_context;
-	/*
-	 * Node in linked list where head is dbc->xfer_list.
-	 * This link list contain BO's that are queued for DMA transfer.
-	 */
-	struct list_head	xfer_list;
 	/*
 	 * Node in linked list where head is dbc->bo_lists.
 	 * This link list contain BO's that are associated with the DBC it is
@@ -307,6 +344,8 @@ struct qaic_bo {
 	struct mutex		lock;
 	/* Callback to sync BO with CPU */
 	struct dma_fence_cb	cb;
+	/* True if BO needs to be sync'd with device; otherwise no need */
+	bool			need_dev_sync;
 };
 
 struct bo_slice {
@@ -331,6 +370,78 @@ struct bo_slice {
 	u64			offset;
 };
 
+struct dbc_req {
+	/*
+	 * A request ID is assigned to each memory handle going in DMA queue.
+	 * As a single memory handle can enqueue multiple elements in DMA queue
+	 * all of them will have the same request ID.
+	 */
+	__le16	req_id;
+	/* Future use */
+	__u8	seq_id;
+	/*
+	 * Special encoded variable
+	 * 7	0 - Do not force to generate MSI after DMA is completed
+	 *	1 - Force to generate MSI after DMA is completed
+	 * 6:5	Reserved
+	 * 4	1 - Generate completion element in the response queue
+	 *	0 - No Completion Code
+	 * 3	0 - DMA request is a Link list transfer
+	 *	1 - DMA request is a Bulk transfer
+	 * 2	Reserved
+	 * 1:0	00 - No DMA transfer involved
+	 *	01 - DMA transfer is part of inbound transfer
+	 *	10 - DMA transfer has outbound transfer
+	 *	11 - NA
+	 */
+	__u8	cmd;
+	__le32	resv;
+	/* Source address for the transfer */
+	__le64	src_addr;
+	/* Destination address for the transfer */
+	__le64	dest_addr;
+	/* Length of transfer request */
+	__le32	len;
+	__le32	resv2;
+	/* Doorbell address */
+	__le64	db_addr;
+	/*
+	 * Special encoded variable
+	 * 7	1 - Doorbell(db) write
+	 *	0 - No doorbell write
+	 * 6:2	Reserved
+	 * 1:0	00 - 32 bit access, db address must be aligned to 32bit-boundary
+	 *	01 - 16 bit access, db address must be aligned to 16bit-boundary
+	 *	10 - 8 bit access, db address must be aligned to 8bit-boundary
+	 *	11 - Reserved
+	 */
+	__u8	db_len;
+	__u8	resv3;
+	__le16	resv4;
+	/* 32 bit data written to doorbell address */
+	__le32	db_data;
+	/*
+	 * Special encoded variable
+	 * All the fields of sem_cmdX are passed from user and all are ORed
+	 * together to form sem_cmd.
+	 * 0:11		Semaphore value
+	 * 15:12	Reserved
+	 * 20:16	Semaphore index
+	 * 21		Reserved
+	 * 22		Semaphore Sync
+	 * 23		Reserved
+	 * 26:24	Semaphore command
+	 * 28:27	Reserved
+	 * 29		Semaphore DMA out bound sync fence
+	 * 30		Semaphore DMA in bound sync fence
+	 * 31		Enable semaphore command
+	 */
+	__le32	sem_cmd0;
+	__le32	sem_cmd1;
+	__le32	sem_cmd2;
+	__le32	sem_cmd3;
+} __packed;
+
 int get_dbc_req_elem_size(void);
 int get_dbc_rsp_elem_size(void);
 int get_cntl_version(struct qaic_device *qdev, struct qaic_user *usr, u16 *major, u16 *minor);
@@ -350,6 +461,8 @@ void enable_dbc(struct qaic_device *qdev, u32 dbc_id, struct qaic_user *usr);
 void wakeup_dbc(struct qaic_device *qdev, u32 dbc_id);
 void release_dbc(struct qaic_device *qdev, u32 dbc_id);
 void qaic_data_get_fifo_info(struct dma_bridge_chan *dbc, u32 *head, u32 *tail);
+int qaic_submit_reqs_to_hw(struct bo_slice *slice, unsigned int num_req,
+			   bool is_partial, u32 partial_size, u16 job_id);
 
 void wake_all_cntl(struct qaic_device *qdev);
 void qaic_dev_reset_clean_local_state(struct qaic_device *qdev);
@@ -370,8 +483,20 @@ void qaic_dbc_exit_ssr(struct qaic_device *qdev);
 
 /* qaic_fence.c */
 int qaic_fence_wait(struct dma_fence *fence, signed long timeout);
+struct qaic_fence *qaic_create_irq_fence(struct qaic_bo *bo, u64 seqno, u16 job_id);
+int qaic_acquire_bo_fence(struct qaic_bo *bo, int job_count, struct list_head *job_list);
 void qaic_remove_bo_fence(struct qaic_bo *bo);
-int qaic_acquire_bo_fence(struct qaic_bo *bo);
+
+/* qaic_sched.c */
+int qaicm_sched_init(struct drm_device *drm, struct dma_bridge_chan *dbc);
+void qaic_sched_entity_init(struct dma_bridge_chan *dbc);
+struct qaic_job *qaic_create_job(struct drm_file *file_priv, struct bo_slice *slice,
+				 unsigned int num_req, u64 seq_no, struct list_head *tmp_list);
+void qaic_submit_job(struct dma_bridge_chan *dbc, struct qaic_job *job);
+void qaic_free_job(struct kref *ref);
+void qaic_put_job(struct qaic_job *job);
+void qaic_cleanup_job(struct qaic_job *job);
+void set_dbc_scaling_ratio(struct dma_bridge_chan *dbc, u32 nelem);
 
 /* qaic_sysfs.c */
 int qaic_sysfs_init(struct qaic_drm_device *qddev);
diff --git a/drivers/accel/qaic/qaic_control.c b/drivers/accel/qaic/qaic_control.c
index 2ccc55486aac..9c4400c0fd17 100644
--- a/drivers/accel/qaic/qaic_control.c
+++ b/drivers/accel/qaic/qaic_control.c
@@ -919,7 +919,12 @@ static int decode_deactivate(struct qaic_device *qdev, void *trans, u32 *msg_len
 		 * Releasing resources failed on the device side, which puts
 		 * us in a bind since they may still be in use, so enable the
 		 * dbc. User is expected to retry deactivation.
+		 *
+		 * Scheduler entity must be destroyed before it's reinitialized
+		 * in enable_dbc, otherwise entity list element points to itself
+		 * and causes a cycle in any list it was a node of.
 		 */
+		drm_sched_entity_destroy(&qdev->dbc[dbc_id].sched_entity);
 		enable_dbc(qdev, dbc_id, usr);
 		return -ECANCELED;
 	}
diff --git a/drivers/accel/qaic/qaic_data.c b/drivers/accel/qaic/qaic_data.c
index 0208400d2636..63ca4a489a9a 100644
--- a/drivers/accel/qaic/qaic_data.c
+++ b/drivers/accel/qaic/qaic_data.c
@@ -64,78 +64,6 @@ module_param(datapath_poll_interval_us, uint, 0600);
 MODULE_PARM_DESC(datapath_poll_interval_us,
 		 "Amount of time to sleep between activity when datapath polling is enabled");
 
-struct dbc_req {
-	/*
-	 * A request ID is assigned to each memory handle going in DMA queue.
-	 * As a single memory handle can enqueue multiple elements in DMA queue
-	 * all of them will have the same request ID.
-	 */
-	__le16	req_id;
-	/* Future use */
-	__u8	seq_id;
-	/*
-	 * Special encoded variable
-	 * 7	0 - Do not force to generate MSI after DMA is completed
-	 *	1 - Force to generate MSI after DMA is completed
-	 * 6:5	Reserved
-	 * 4	1 - Generate completion element in the response queue
-	 *	0 - No Completion Code
-	 * 3	0 - DMA request is a Link list transfer
-	 *	1 - DMA request is a Bulk transfer
-	 * 2	Reserved
-	 * 1:0	00 - No DMA transfer involved
-	 *	01 - DMA transfer is part of inbound transfer
-	 *	10 - DMA transfer has outbound transfer
-	 *	11 - NA
-	 */
-	__u8	cmd;
-	__le32	resv;
-	/* Source address for the transfer */
-	__le64	src_addr;
-	/* Destination address for the transfer */
-	__le64	dest_addr;
-	/* Length of transfer request */
-	__le32	len;
-	__le32	resv2;
-	/* Doorbell address */
-	__le64	db_addr;
-	/*
-	 * Special encoded variable
-	 * 7	1 - Doorbell(db) write
-	 *	0 - No doorbell write
-	 * 6:2	Reserved
-	 * 1:0	00 - 32 bit access, db address must be aligned to 32bit-boundary
-	 *	01 - 16 bit access, db address must be aligned to 16bit-boundary
-	 *	10 - 8 bit access, db address must be aligned to 8bit-boundary
-	 *	11 - Reserved
-	 */
-	__u8	db_len;
-	__u8	resv3;
-	__le16	resv4;
-	/* 32 bit data written to doorbell address */
-	__le32	db_data;
-	/*
-	 * Special encoded variable
-	 * All the fields of sem_cmdX are passed from user and all are ORed
-	 * together to form sem_cmd.
-	 * 0:11		Semaphore value
-	 * 15:12	Reserved
-	 * 20:16	Semaphore index
-	 * 21		Reserved
-	 * 22		Semaphore Sync
-	 * 23		Reserved
-	 * 26:24	Semaphore command
-	 * 28:27	Reserved
-	 * 29		Semaphore DMA out bound sync fence
-	 * 30		Semaphore DMA in bound sync fence
-	 * 31		Enable semaphore command
-	 */
-	__le32	sem_cmd0;
-	__le32	sem_cmd1;
-	__le32	sem_cmd2;
-	__le32	sem_cmd3;
-} __packed;
-
 struct dbc_rsp {
 	/* Request ID of the memory handle whose DMA transaction is completed */
 	__le16	req_id;
@@ -188,7 +116,7 @@ struct qaic_exec_data_req {
 static inline bool bo_queued(struct qaic_bo *bo)
 {
 	if (bo->fence)
-		return !dma_fence_is_signaled(&bo->fence->base);
+		return !dma_fence_is_signaled(bo->fence);
 	return false;
 }
 
@@ -751,7 +679,6 @@ static const struct drm_gem_object_funcs qaic_gem_funcs = {
 static void qaic_init_bo_lists(struct qaic_bo *bo)
 {
 	INIT_LIST_HEAD(&bo->slices);
-	INIT_LIST_HEAD(&bo->xfer_list);
 }
 
 static struct qaic_bo *qaic_alloc_init_bo(void)
@@ -1181,9 +1108,8 @@ static void submit_reqs_to_fifo(struct dma_bridge_chan *dbc, struct dbc_req *req
 }
 
 /* Caller should be holding dbc->req_lock */
-static inline int qaic_submit_reqs_to_hw(struct bo_slice *slice,
-					 unsigned int num_req,
-					 bool is_partial, u32 partial_size)
+int qaic_submit_reqs_to_hw(struct bo_slice *slice, unsigned int num_req,
+			   bool is_partial, u32 partial_size, u16 job_id)
 {
 	struct dma_bridge_chan *dbc = slice->bo->dbc;
 	struct dbc_req *reqs = slice->reqs;
@@ -1225,27 +1151,30 @@ static inline int qaic_submit_reqs_to_hw(struct bo_slice *slice,
 	bo->perf_stats.req_submit_ts = ktime_get_ns();
 
 	/* Finalize commit to hardware */
-	dma_sync_sgtable_for_device(&dbc->qdev->pdev->dev, bo->sgt, bo->dir);
+	if (bo->need_dev_sync) {
+		bo->need_dev_sync = false;
+		dma_sync_sgtable_for_device(&dbc->qdev->pdev->dev, bo->sgt, bo->dir);
+	}
 	writel(tail, dbc->dbc_base + REQTP_OFF);
 	return 0;
 }
 
-static inline int copy_exec_reqs(struct bo_slice *slice)
+static inline void qaic_dbc_put_job(struct dma_bridge_chan *dbc, struct qaic_job *job)
 {
-	int ret;
-
-	ret = qaic_submit_reqs_to_hw(slice, slice->nents, false, 0);
-
-	return ret;
+	list_del_init(&job->queue);
+	dbc->pending_reqs -= job->num_req;
+	qaic_put_job(job);
 }
 
-static inline int copy_partial_exec_reqs(struct bo_slice *slice, u64 resize)
+static int create_slice_jobs(struct drm_file *file_priv, struct bo_slice *slice, bool partial,
+			     u64 resize, struct list_head *tmp_list)
 {
 	struct dbc_req *reqs = slice->reqs;
+	struct qaic_job *job = NULL;
+	unsigned int job_count = 0;
 	unsigned int nents_xfer;
 	u64 last_bytes;
 	u32 first_n;
-	int ret;
 
 	/*
 	 * After this for loop is complete, first_n represents the index
@@ -1260,20 +1189,33 @@ static inline int copy_partial_exec_reqs(struct bo_slice *slice, u64 resize)
 		else
 			break;
 
-	nents_xfer = first_n + 1;
+	if (partial)
+		nents_xfer = first_n + 1;
+	else
+		nents_xfer = slice->nents;
 
-	ret = qaic_submit_reqs_to_hw(slice, nents_xfer, true, last_bytes);
+	job = qaic_create_job(file_priv, slice, nents_xfer, 0, tmp_list);
+	if (IS_ERR(job))
+		return PTR_ERR(job);
+	job_count++;
 
-	return ret;
+	/* job points to the last job for this slice, only valid for partial execute ioctl */
+	job->partial_size = last_bytes;
+	job->partial = partial;
+
+	return job_count;
 }
 
-static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *file_priv,
-				  struct execute_info *exec, struct dma_bridge_chan *dbc)
+static int send_bo_list_to_sched(struct qaic_device *qdev, struct drm_file *file_priv,
+				 struct execute_info *exec, struct dma_bridge_chan *dbc)
 {
+	struct qaic_job *job, *job_i, *tmp;
 	struct ww_acquire_ctx acquire_ctx;
 	struct bo_slice *slice;
 	unsigned long flags;
+	LIST_HEAD(tmp_list);
 	struct qaic_bo *bo;
+	int job_count;
 	u64 resize;
 	u32 handle;
 	int i, j;
@@ -1290,13 +1232,7 @@ static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *fil
 		handle = exec->handle_arr[i];
 		ret = mutex_lock_interruptible(&bo->lock);
 		if (ret)
-			goto failed_to_send_bo;
-
-		/*
-		 * Take reference to object before sending to device,
-		 * released when transfer is complete (in dbc_irq_threaded_fn()).
-		 */
-		drm_gem_object_get(&bo->base);
+			goto free_jobs;
 
 		if (!bo->sliced) {
 			ret = -EINVAL;
@@ -1313,54 +1249,54 @@ static int send_bo_list_to_device(struct qaic_device *qdev, struct drm_file *fil
 			goto unlock_bo;
 		}
 
-		bo->req_id = dbc->next_req_id++;
-
-		spin_lock_irqsave(&dbc->xfer_lock, flags);
-		list_add_tail(&bo->xfer_list, &dbc->xfer_list);
-		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
-
-		ret = qaic_acquire_bo_fence(bo);
-		if (ret)
-			goto fence_failed;
-
+		job_count = 0;
 		list_for_each_entry(slice, &bo->slices, slice) {
-			for (j = 0; j < slice->nents; j++)
-				slice->reqs[j].req_id = cpu_to_le16(bo->req_id);
-
 			if (exec->is_partial && (!resize || resize <= slice->offset))
 				/* Configure the slice for no DMA transfer */
-				ret = copy_partial_exec_reqs(slice, 0);
+				ret = create_slice_jobs(file_priv, slice, true, 0, &tmp_list);
 			else if (exec->is_partial && resize < slice->offset + slice->size)
 				/* Configure the slice to be partially DMA transferred */
-				ret = copy_partial_exec_reqs(slice, resize - slice->offset);
+				ret = create_slice_jobs(file_priv, slice, true,
+							resize - slice->offset, &tmp_list);
 			else
-				ret = copy_exec_reqs(slice);
-			if (ret)
-				goto submit_failed;
+				ret = create_slice_jobs(file_priv, slice, false, 0, &tmp_list);
+			if (ret <= 0)
+				goto unlock_bo;
+			job_count += ret;
 		}
+
+		ret = qaic_acquire_bo_fence(bo, job_count, &tmp_list);
+		if (ret)
+			goto unlock_bo;
+
+		bo->need_dev_sync = true;
 		mutex_unlock(&bo->lock);
 	}
 
+	spin_lock_irqsave(&dbc->job_q_lock, flags);
+	job = list_last_entry(&dbc->job_queue, typeof(*job), queue);
+	list_splice_tail_init(&tmp_list, &dbc->job_queue);
+	list_for_each_entry_continue(job, &dbc->job_queue, queue)
+		qaic_submit_job(dbc, job);
+	spin_unlock_irqrestore(&dbc->job_q_lock, flags);
+
 	goto unlock_resv;
 
-submit_failed:
-	qaic_remove_bo_fence(bo);
-fence_failed:
-	spin_lock_irqsave(&dbc->xfer_lock, flags);
-	list_del_init(&bo->xfer_list);
-	spin_unlock_irqrestore(&dbc->xfer_lock, flags);
 unlock_bo:
-	drm_gem_object_put(&bo->base);
 	mutex_unlock(&bo->lock);
-failed_to_send_bo:
-	for (j = 0; j < i; j++) {
-		drm_gem_object_put(&exec->bo_arr[j]->base);
-		spin_lock_irqsave(&dbc->xfer_lock, flags);
-		bo = list_last_entry(&dbc->xfer_list, struct qaic_bo, xfer_list);
-		list_del_init(&bo->xfer_list);
-		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
-		dma_sync_sgtable_for_cpu(&qdev->pdev->dev, bo->sgt, bo->dir);
+free_jobs:
+	for (j = i - 1; i > 0 && j >= 0; j--) {
+		bo = exec->bo_arr[j];
+		ret = mutex_lock_interruptible(&bo->lock);
+		if (!ret) {
+			bo->need_dev_sync = false;
+			dma_fence_put(bo->fence);
+			bo->fence = NULL;
+			mutex_unlock(&bo->lock);
+		}
 	}
+	list_for_each_entry_safe_reverse(job_i, tmp, &tmp_list, queue)
+		qaic_cleanup_job(job_i);
 unlock_resv:
 	drm_gem_unlock_reservations((struct drm_gem_object **)exec->bo_arr,
 				    exec->count, &acquire_ctx);
@@ -1451,7 +1387,6 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 	struct qaic_user *usr;
 	size_t elem_size_sum;
 	void *usr_exec_ent;
-	u32 head, tail;
 	int i, ret;
 
 	exec.perf_stats.received_ts = ktime_get_ns();
@@ -1530,36 +1465,20 @@ static int __qaic_execute_bo_ioctl(struct drm_device *dev, void *data, struct dr
 		goto release_ch_rcu;
 	}
 
-	ret = mutex_lock_interruptible(&dbc->req_lock);
-	if (ret)
-		goto release_ch_rcu;
-
-	head = readl(dbc->dbc_base + REQHP_OFF);
-	tail = readl(dbc->dbc_base + REQTP_OFF);
-
-	if (head == U32_MAX || tail == U32_MAX) {
-		/* PCI link error */
-		ret = -ENODEV;
-		goto unlock_req_lock;
-	}
+	/* Not locking to read pending_reqs since exact value not necessary */
+	exec.perf_stats.queue_level = dbc->pending_reqs;
 
-	exec.perf_stats.queue_level = head <= tail ? tail - head : dbc->nelem - (head - tail);
-
-	ret = send_bo_list_to_device(qdev, file_priv, &exec, dbc);
+	ret = send_bo_list_to_sched(qdev, file_priv, &exec, dbc);
 	if (ret)
-		goto unlock_req_lock;
+		goto release_ch_rcu;
 
 	exec.perf_stats.submit_ts = ktime_get_ns();
-	mutex_unlock(&dbc->req_lock);
 
 	update_profiling_data(&exec);
 
 	if (datapath_polling)
 		schedule_work(&dbc->poll_work);
 
-unlock_req_lock:
-	if (ret)
-		mutex_unlock(&dbc->req_lock);
 release_ch_rcu:
 	srcu_read_unlock(&dbc->ch_lock, ch_rcu_id);
 	for (i = 0; i < exec.count; i++)
@@ -1683,13 +1602,13 @@ void qaic_irq_polling_work(struct work_struct *work)
 			srcu_read_unlock(&dbc->ch_lock, rcu_id);
 			return;
 		}
-		spin_lock_irqsave(&dbc->xfer_lock, flags);
-		if (list_empty(&dbc->xfer_list)) {
-			spin_unlock_irqrestore(&dbc->xfer_lock, flags);
+		spin_lock_irqsave(&dbc->job_q_lock, flags);
+		if (list_empty(&dbc->job_queue)) {
+			spin_unlock_irqrestore(&dbc->job_q_lock, flags);
 			srcu_read_unlock(&dbc->ch_lock, rcu_id);
 			return;
 		}
-		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
+		spin_unlock_irqrestore(&dbc->job_q_lock, flags);
 
 		head = readl(dbc->dbc_base + RSPHP_OFF);
 		if (head == U32_MAX) { /* PCI link error */
@@ -1719,8 +1638,8 @@ irqreturn_t dbc_irq_threaded_fn(int irq, void *data)
 	struct dma_bridge_chan *dbc = data;
 	int event_count = NUM_EVENTS;
 	int delay_count = NUM_DELAYS;
+	struct qaic_job *job, *tmp;
 	struct qaic_device *qdev;
-	struct qaic_bo *bo, *i;
 	struct dbc_rsp *rsp;
 	unsigned long flags;
 	int rcu_id;
@@ -1773,37 +1692,17 @@ irqreturn_t dbc_irq_threaded_fn(int irq, void *data)
 		status = le16_to_cpu(rsp->status);
 		if (status)
 			pci_dbg(qdev->pdev, "req_id %d failed with status %d\n", req_id, status);
-		spin_lock_irqsave(&dbc->xfer_lock, flags);
-		/*
-		 * A BO can receive multiple interrupts, since a BO can be
-		 * divided into multiple slices and a buffer receives as many
-		 * interrupts as slices. So until it receives interrupts for
-		 * all the slices we cannot mark that buffer complete.
-		 */
-		list_for_each_entry_safe(bo, i, &dbc->xfer_list, xfer_list) {
-			if (bo->req_id == req_id)
-				bo->nr_slice_xfer_done++;
-			else
-				continue;
 
-			if (bo->nr_slice_xfer_done < bo->nr_slice)
+		spin_lock_irqsave(&dbc->job_q_lock, flags);
+		list_for_each_entry_safe(job, tmp, &dbc->job_queue, queue) {
+			if (job->id == req_id) {
+				dma_fence_signal(&job->irq_fence->base);
+				qaic_dbc_put_job(dbc, job);
 				break;
-
-			/*
-			 * At this point we have received all the interrupts for
-			 * BO, which means BO execution is complete.
-			 */
-			bo->nr_slice_xfer_done = 0;
-			list_del_init(&bo->xfer_list);
-			/*
-			 * fence is put when it is executed next, during xfer_list
-			 * cleanup, or when slice is detached
-			 */
-			dma_fence_signal(&bo->fence->base);
-			drm_gem_object_put(&bo->base);
-			break;
+			}
 		}
-		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
+		spin_unlock_irqrestore(&dbc->job_q_lock, flags);
+
 		head = (head + 1) % dbc->nelem;
 	}
 
@@ -1910,7 +1809,7 @@ int qaic_wait_bo_ioctl(struct drm_device *dev, void *data, struct drm_file *file
 		goto put_obj;
 	}
 
-	fence = &bo->fence->base;
+	fence = bo->fence;
 	dma_fence_get(fence);
 	mutex_unlock(&bo->lock);
 
@@ -2101,44 +2000,31 @@ int qaic_detach_slice_bo_ioctl(struct drm_device *dev, void *data, struct drm_fi
 	return ret;
 }
 
-static void empty_xfer_list(struct qaic_device *qdev, struct dma_bridge_chan *dbc)
+static void empty_xfer_list(struct dma_bridge_chan *dbc)
 {
+	struct qaic_job *job, *tmp;
 	unsigned long flags;
-	struct qaic_bo *bo;
 
-	spin_lock_irqsave(&dbc->xfer_lock, flags);
-	while (!list_empty(&dbc->xfer_list)) {
-		bo = list_first_entry(&dbc->xfer_list, typeof(*bo), xfer_list);
-		list_del_init(&bo->xfer_list);
-		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
-		mutex_lock(&bo->lock);
-		bo->nr_slice_xfer_done = 0;
-		bo->req_id = 0;
-		bo->perf_stats.req_received_ts = 0;
-		bo->perf_stats.req_submit_ts = 0;
-		bo->perf_stats.req_processed_ts = 0;
-		bo->perf_stats.queue_level_before = 0;
-		dma_fence_get(&bo->fence->base);
-		dma_fence_set_error(&bo->fence->base, -ECANCELED);
-		dma_fence_signal(&bo->fence->base);
-		dma_fence_put(&bo->fence->base);
-		qaic_remove_bo_fence(bo);
-		mutex_unlock(&bo->lock);
-		drm_gem_object_put(&bo->base);
-		spin_lock_irqsave(&dbc->xfer_lock, flags);
+	spin_lock_irqsave(&dbc->job_q_lock, flags);
+	list_for_each_entry_safe_reverse(job, tmp, &dbc->job_queue, queue) {
+		dma_fence_get(&job->irq_fence->base);
+		dma_fence_set_error(&job->irq_fence->base, -ECANCELED);
+		dma_fence_signal(&job->irq_fence->base);
+		dma_fence_put(&job->irq_fence->base);
+		qaic_dbc_put_job(dbc, job);
 	}
-	spin_unlock_irqrestore(&dbc->xfer_lock, flags);
+	spin_unlock_irqrestore(&dbc->job_q_lock, flags);
 }
 
-static void sync_empty_xfer_list(struct qaic_device *qdev, struct dma_bridge_chan *dbc)
+static void sync_empty_xfer_list(struct dma_bridge_chan *dbc)
 {
-	empty_xfer_list(qdev, dbc);
+	empty_xfer_list(dbc);
 	synchronize_srcu(&dbc->ch_lock);
 	/*
 	 * Threads holding channel lock, may add more elements in the xfer_list.
 	 * Flush out these elements from xfer_list.
 	 */
-	empty_xfer_list(qdev, dbc);
+	empty_xfer_list(dbc);
 }
 
 int disable_dbc(struct qaic_device *qdev, u32 dbc_id, struct qaic_user *usr)
@@ -2161,6 +2047,8 @@ int disable_dbc(struct qaic_device *qdev, u32 dbc_id, struct qaic_user *usr)
  */
 void enable_dbc(struct qaic_device *qdev, u32 dbc_id, struct qaic_user *usr)
 {
+	qaic_sched_entity_init(&qdev->dbc[dbc_id]);
+	set_dbc_scaling_ratio(&qdev->dbc[dbc_id], qdev->dbc[dbc_id].nelem);
 	qdev->dbc[dbc_id].usr = usr;
 }
 
@@ -2169,7 +2057,7 @@ void wakeup_dbc(struct qaic_device *qdev, u32 dbc_id)
 	struct dma_bridge_chan *dbc = &qdev->dbc[dbc_id];
 
 	dbc->usr = NULL;
-	sync_empty_xfer_list(qdev, dbc);
+	sync_empty_xfer_list(dbc);
 }
 
 void release_dbc(struct qaic_device *qdev, u32 dbc_id)
@@ -2182,6 +2070,7 @@ void release_dbc(struct qaic_device *qdev, u32 dbc_id)
 		return;
 
 	wakeup_dbc(qdev, dbc_id);
+	drm_sched_entity_destroy(&dbc->sched_entity);
 
 	dma_free_coherent(&qdev->pdev->dev, dbc->total_size, dbc->req_q_base, dbc->dma_addr);
 	dbc->total_size = 0;
diff --git a/drivers/accel/qaic/qaic_debugfs.c b/drivers/accel/qaic/qaic_debugfs.c
index 909a4d774d90..2fac928d5406 100644
--- a/drivers/accel/qaic/qaic_debugfs.c
+++ b/drivers/accel/qaic/qaic_debugfs.c
@@ -100,7 +100,6 @@ void qaic_debugfs_init(struct qaic_drm_device *qddev)
 	struct qaic_device *qdev = qddev->qdev;
 	struct dentry *debugfs_root;
 	struct dentry *debugfs_dir;
-	char name[QAIC_DBC_DIR_NAME];
 	u32 i;
 
 	debugfs_root = to_drm(qddev)->debugfs_root;
@@ -111,8 +110,7 @@ void qaic_debugfs_init(struct qaic_drm_device *qddev)
 	 * reasonable range.
 	 */
 	for (i = 0; i < qdev->num_dbc && i < 256; ++i) {
-		snprintf(name, QAIC_DBC_DIR_NAME, "dbc%03u", i);
-		debugfs_dir = debugfs_create_dir(name, debugfs_root);
+		debugfs_dir = debugfs_create_dir(qdev->dbc[i].name, debugfs_root);
 		debugfs_create_file("fifo_size", 0400, debugfs_dir, &qdev->dbc[i], &fifo_size_fops);
 		debugfs_create_file("queued", 0400, debugfs_dir, &qdev->dbc[i], &queued_fops);
 	}
diff --git a/drivers/accel/qaic/qaic_drv.c b/drivers/accel/qaic/qaic_drv.c
index 219f58fdfde8..46b86b3655ca 100644
--- a/drivers/accel/qaic/qaic_drv.c
+++ b/drivers/accel/qaic/qaic_drv.c
@@ -461,10 +461,11 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 	INIT_LIST_HEAD(&qddev->users);
 
 	for (i = 0; i < qdev->num_dbc; ++i) {
-		spin_lock_init(&qdev->dbc[i].xfer_lock);
+		spin_lock_init(&qdev->dbc[i].job_q_lock);
 		qdev->dbc[i].qdev = qdev;
 		qdev->dbc[i].id = i;
-		INIT_LIST_HEAD(&qdev->dbc[i].xfer_list);
+		INIT_LIST_HEAD(&qdev->dbc[i].job_queue);
+		scnprintf(qdev->dbc[i].name, ARRAY_SIZE(qdev->dbc[i].name), "dbc%03u", i);
 		ret = qaicm_srcu_init(drm, &qdev->dbc[i].ch_lock);
 		if (ret)
 			return NULL;
@@ -473,6 +474,9 @@ static struct qaic_device *create_qdev(struct pci_dev *pdev,
 		ret = drmm_mutex_init(drm, &qdev->dbc[i].req_lock);
 		if (ret)
 			return NULL;
+		ret = qaicm_sched_init(drm, &qdev->dbc[i]);
+		if (ret)
+			return NULL;
 	}
 
 	return qdev;
@@ -708,9 +712,9 @@ static bool qaic_data_path_busy(struct qaic_device *qdev)
 			srcu_read_unlock(&dbc->ch_lock, ch_rcu_id);
 			continue;
 		}
-		spin_lock_irqsave(&dbc->xfer_lock, flags);
-		ret = !list_empty(&dbc->xfer_list);
-		spin_unlock_irqrestore(&dbc->xfer_lock, flags);
+		spin_lock_irqsave(&dbc->job_q_lock, flags);
+		ret = !list_empty(&dbc->job_queue);
+		spin_unlock_irqrestore(&dbc->job_q_lock, flags);
 		srcu_read_unlock(&dbc->ch_lock, ch_rcu_id);
 		if (ret)
 			break;
diff --git a/drivers/accel/qaic/qaic_fence.c b/drivers/accel/qaic/qaic_fence.c
index ec7e555c454b..ed4c7f6a7768 100644
--- a/drivers/accel/qaic/qaic_fence.c
+++ b/drivers/accel/qaic/qaic_fence.c
@@ -2,9 +2,12 @@
 
 /* Copyright (c) 2024-2025 Qualcomm Innovation Center, Inc. All rights reserved. */
 
+#include <linux/dma-fence-array.h>
 #include <linux/dma-fence.h>
 #include <linux/dma-resv.h>
+#include <linux/err.h>
 #include <linux/ktime.h>
+#include <linux/slab.h>
 #include <linux/spinlock.h>
 #include <linux/sprintf.h>
 
@@ -20,8 +23,8 @@ static const char *qaic_fence_get_timeline_name(struct dma_fence *f)
 	struct qaic_fence *qfence = container_of(f, struct qaic_fence, base);
 
 	if (!qfence->timeline_name[0])
-		scnprintf(qfence->timeline_name, ARRAY_SIZE(qfence->timeline_name), "D%02u",
-			 qfence->dbc_id);
+		scnprintf(qfence->timeline_name, ARRAY_SIZE(qfence->timeline_name),
+			  "D%02u-JOB%05x", qfence->dbc_id, qfence->job_id);
 	return qfence->timeline_name;
 }
 
@@ -64,7 +67,7 @@ int qaic_fence_wait(struct dma_fence *fence, signed long timeout)
 	return ret;
 }
 
-static struct qaic_fence *qaic_create_fence(struct qaic_bo *bo)
+struct qaic_fence *qaic_create_irq_fence(struct qaic_bo *bo, u64 seqno, u16 job_id)
 {
 	struct qaic_fence *fence;
 
@@ -74,71 +77,97 @@ static struct qaic_fence *qaic_create_fence(struct qaic_bo *bo)
 
 	spin_lock_init(&fence->lock);
 	fence->dbc_id = bo->dbc->id;
-	dma_fence_init(&fence->base, &qaic_fence_ops, &fence->lock, bo->fence_context, 1);
+	fence->job_id = job_id;
+	dma_fence_init(&fence->base, &qaic_fence_ops, &fence->lock, bo->fence_context, seqno);
 
 	return fence;
 }
 
-/* Caller should be holding bo->lock */
-static int qaic_set_bo_resv_fence(struct qaic_bo *bo, struct qaic_fence *fence)
+static int qaic_create_bo_fence(struct qaic_bo *bo, struct dma_fence **output_fence,
+				int job_count, struct list_head *job_list)
 {
-	int ret;
-
-	ret = dma_resv_reserve_fences(bo->base.resv, 1);
-	if (ret)
-		goto err_out_fence;
+	struct dma_fence_array *fence_arr;
+	struct dma_fence **job_fences;
+	struct qaic_job *job;
+	int ret, i = 0;
 
-	/*
-	 * Add a fence in dma-buf reservation object for this BO,
-	 * enables buffer sharing across devices.
-	 */
-	dma_resv_add_fence(bo->base.resv, &fence->base,
-			   dma_resv_usage_rw(bo->dir == DMA_TO_DEVICE));
+	job_fences = kcalloc(job_count, sizeof(*job_fences), GFP_KERNEL);
+	if (!job_fences)
+		return -ENOMEM;
 
-	ret = dma_fence_add_callback(&fence->base, &bo->cb, qaic_fence_sync_cb_func);
+	ret = dma_resv_reserve_fences(bo->base.resv, job_count);
 	if (ret)
-		goto err_out_fence;
+		goto job_err;
+
+	/* Add all the fences that we need to wait on to resv */
+	list_for_each_entry_reverse(job, job_list, queue) {
+		if (i < job_count) {
+			job_fences[i] = dma_fence_get(&job->irq_fence->base);
+			dma_resv_add_fence(bo->base.resv, job_fences[i],
+					   dma_resv_usage_rw(bo->dir == DMA_TO_DEVICE));
+			i++;
+		} else {
+			break;
+		}
+	}
 
-	return ret;
+	/* When successful, job_fences and the fences it contains are now owned by fence_arr */
+	fence_arr = dma_fence_array_create(job_count, job_fences, bo->fence_context, 1);
+	if (!fence_arr) {
+		ret = -ENOMEM;
+		goto fence_err;
+	}
 
-err_out_fence:
-	dma_fence_put(&fence->base);
-	bo->fence = NULL;
+	/* Output fence array so bo will only have one fence to wait on */
+	*output_fence = &fence_arr->base;
+	return 0;
+fence_err:
+	for (i = 0; i < job_count; i++)
+		dma_fence_put(job_fences[i]);
+job_err:
+	kfree(job_fences);
 	return ret;
+
 }
 
 /* Caller should be holding bo->lock */
 void qaic_remove_bo_fence(struct qaic_bo *bo)
 {
 	if (bo->fence) {
-		if (!dma_fence_is_signaled(&bo->fence->base)) {
-			dma_fence_set_error(&bo->fence->base, -ECANCELED);
-			dma_fence_signal(&bo->fence->base);
+		if (!dma_fence_is_signaled(bo->fence)) {
+			dma_fence_set_error(bo->fence, -ECANCELED);
+			dma_fence_signal(bo->fence);
 		}
-		dma_fence_put(&bo->fence->base);
+		dma_fence_put(bo->fence);
 	}
 	bo->fence = NULL;
 }
 
 /* Caller should be holding bo->lock */
-static void qaic_replace_bo_fence(struct qaic_bo *bo, struct qaic_fence *fence)
+static void qaic_replace_bo_fence(struct qaic_bo *bo, struct dma_fence *fence)
 {
 	qaic_remove_bo_fence(bo);
 	bo->fence = fence;
 }
 
 /* Caller should be holding bo->lock */
-int qaic_acquire_bo_fence(struct qaic_bo *bo)
+int qaic_acquire_bo_fence(struct qaic_bo *bo, int job_count, struct list_head *job_list)
 {
-	struct qaic_fence *fence;
-	int ret = 0;
+	struct dma_fence *fence;
+	int ret;
 
-	fence = qaic_create_fence(bo);
-	if (IS_ERR(fence))
-		return PTR_ERR(fence);
+	ret = qaic_create_bo_fence(bo, &fence, job_count, job_list);
+	if (ret)
+		return ret;
+
+	ret = dma_fence_add_callback(fence, &bo->cb, qaic_fence_sync_cb_func);
+	if (ret) {
+		dma_fence_put(fence);
+		bo->fence = NULL;
+		return ret;
+	}
 
 	qaic_replace_bo_fence(bo, fence);
-	ret = qaic_set_bo_resv_fence(bo, fence);
 
-	return ret;
+	return 0;
 }
diff --git a/drivers/accel/qaic/qaic_sched.c b/drivers/accel/qaic/qaic_sched.c
new file mode 100644
index 000000000000..b0992d63c2b6
--- /dev/null
+++ b/drivers/accel/qaic/qaic_sched.c
@@ -0,0 +1,236 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+/* Copyright (c) Qualcomm Technologies, Inc. and/or its subsidiaries. */
+
+#include <drm/drm_device.h>
+#include <drm/drm_file.h>
+#include <drm/drm_gem.h>
+#include <drm/drm_managed.h>
+#include <drm/gpu_scheduler.h>
+#include <linux/dma-fence.h>
+#include <linux/workqueue.h>
+
+#include "qaic.h"
+
+#define QAIC_CREDITS SZ_64K
+
+static void qaic_job_fini(struct drm_sched_job *sched_job)
+{
+	struct qaic_job *job = to_qaic_job(sched_job);
+
+	qaic_cleanup_job(job);
+}
+
+static struct dma_fence *qaic_job_run(struct drm_sched_job *sched_job)
+{
+	struct qaic_job *job = to_qaic_job(sched_job);
+	struct dma_bridge_chan *dbc = job->dbc;
+	struct bo_slice *slice = job->slice;
+	struct dma_fence *fence;
+	int ret;
+
+	fence = dma_fence_get(&job->irq_fence->base);
+
+	/* Job has been cancelled */
+	if (fence->error) {
+		ret = fence->error;
+		goto exit;
+	}
+
+	ret = mutex_lock_interruptible(&dbc->req_lock);
+	if (ret)
+		goto exit;
+
+	ret = qaic_submit_reqs_to_hw(slice, job->num_req, job->partial,
+				     job->partial_size, job->id);
+	if (ret)
+		goto unlock_dbc;
+	mutex_unlock(&dbc->req_lock);
+
+	return fence;
+
+unlock_dbc:
+	mutex_unlock(&dbc->req_lock);
+exit:
+	dma_fence_put(fence);
+	return ERR_PTR(ret);
+}
+
+static const struct drm_sched_backend_ops qaic_sched_ops = {
+	.run_job = qaic_job_run,
+	.free_job = qaic_job_fini,
+};
+
+static void qaicm_sched_fini(struct drm_device *dev, void *res)
+{
+	struct dma_bridge_chan *dbc = res;
+
+	drm_sched_fini(&dbc->sched);
+	destroy_workqueue(dbc->submit_wq);
+}
+
+/*
+ * Currently, drm_sched is configured to always have credits equal to 64k, but
+ * the network can configure different HW queue sizes. Create a scaling ratio to
+ * convert sizes of HW queue to size in credits.
+ *
+ * The ratio expresses the cost of each queue element. For example, if nelem=10,
+ * then the ratio is 6554 credits consumed per queue element. This cost,
+ * together with the queue credit balance, limits the number of items in the
+ * queue at any time.
+ *
+ * The credit limit should be greater than the typical HW queue so that the
+ * scaling ratio is never less than 1. 'nelem' is bounds checked in
+ * encode_activate() to guarantee that it is less than QAIC_CREDITS. Round up
+ * the scaling ratio if it isn't perfectly divisible.
+ */
+void set_dbc_scaling_ratio(struct dma_bridge_chan *dbc, u32 nelem)
+{
+	if (!nelem) {
+		/*
+		 * There is a chance of enable_dbc() being called after a failed deactivation of the
+		 * dbc. In that case, set the credit ratio to a value that shouldn't let any further
+		 * work be scheduled.
+		 */
+		dbc->credit_ratio = QAIC_CREDITS;
+		return;
+	}
+	if (QAIC_CREDITS % nelem != 0)
+		pr_debug("Credits not evenly divisible by queue size: size = %d\n", nelem);
+	dbc->credit_ratio = DIV_ROUND_UP(QAIC_CREDITS, nelem);
+}
+
+int qaicm_sched_init(struct drm_device *drm, struct dma_bridge_chan *dbc)
+{
+	int ret;
+
+	/*
+	 * Using out own workqueue here due to performance regression with
+	 * large numbers of devices and jobs (32+ and 16+ respectively).
+	 *
+	 * Workqueues with WQ_UNBOUND + max_active > 1 also prevented this
+	 * regression, but introduced the possibility of unordered
+	 * submission to the HW queue. Under testing that did not seem to
+	 * cause any issues, though eventually decided to go with this to
+	 * minimize changes to existing HW interaction patterns.
+	 */
+	dbc->submit_wq = alloc_workqueue("%s", WQ_MEM_RECLAIM | WQ_PERCPU, 1, dbc->name);
+	if (!dbc->submit_wq)
+		return -EINVAL;
+
+	const struct drm_sched_init_args args = {
+		.ops = &qaic_sched_ops,
+		.submit_wq = dbc->submit_wq,
+		.num_rqs = 1,
+		.credit_limit = (QAIC_CREDITS - 1),
+		.hang_limit = 1,
+		.timeout = MAX_SCHEDULE_TIMEOUT,
+		.name = dbc->name,
+		.dev = drm->dev,
+	};
+
+	ret = drm_sched_init(&dbc->sched, &args);
+	if (ret) {
+		destroy_workqueue(dbc->submit_wq);
+		return ret;
+	}
+
+	return drmm_add_action_or_reset(drm, qaicm_sched_fini, dbc);
+}
+
+void qaic_sched_entity_init(struct dma_bridge_chan *dbc)
+{
+	struct drm_gpu_scheduler *sched = &dbc->sched;
+
+	drm_sched_entity_init(&dbc->sched_entity, DRM_SCHED_PRIORITY_KERNEL, &sched, 1, NULL);
+}
+
+struct qaic_job *qaic_create_job(struct drm_file *file_priv, struct bo_slice *slice,
+				 unsigned int num_req, u64 seq_no, struct list_head *tmp_list)
+{
+	struct dma_bridge_chan *dbc = slice->bo->dbc;
+	struct qaic_bo *bo = slice->bo;
+	struct qaic_job *job;
+	u32 credits;
+	u16 req_id;
+	int ret, i;
+
+	if (check_mul_overflow((u32)num_req, dbc->credit_ratio, &credits))
+		return ERR_PTR(-EINVAL);
+
+	job = kzalloc_obj(*job);
+	if (!job)
+		return ERR_PTR(-ENOMEM);
+
+	req_id = (u16) atomic_inc_return(&dbc->next_req_id);
+
+	job->irq_fence = qaic_create_irq_fence(bo, seq_no, req_id);
+	if (IS_ERR(job->irq_fence)) {
+		ret = PTR_ERR(job->irq_fence);
+		goto free_job;
+	}
+
+	ret = drm_sched_job_init(&job->base, &dbc->sched_entity, credits,
+				 dbc, file_priv->client_id);
+	if (ret)
+		goto put_fence;
+
+	/*
+	 * Make new job depend on the pre-existing fences in BO reservation.
+	 * DRM scheduler will wait on every fence in the dependency list
+	 * before running this job.
+	 */
+	ret = drm_sched_job_add_implicit_dependencies(&job->base, &bo->base, true);
+	if (ret)
+		goto job_cleanup;
+
+	job->slice = slice;
+	job->num_req = num_req;
+	job->dbc = dbc;
+	INIT_LIST_HEAD(&job->queue);
+	job->id = req_id;
+	kref_init(&job->ref_count);
+	for (i = 0; i < job->num_req; i++)
+		slice->reqs[i].req_id = cpu_to_le16(job->id);
+
+	list_add_tail(&job->queue, tmp_list);
+	drm_gem_object_get(&bo->base);
+	job->bo = bo;
+	return job;
+
+job_cleanup:
+	drm_sched_job_cleanup(&job->base);
+put_fence:
+	dma_fence_put(&job->irq_fence->base);
+free_job:
+	kfree(job);
+	return ERR_PTR(ret);
+}
+
+void qaic_submit_job(struct dma_bridge_chan *dbc, struct qaic_job *job)
+{
+	kref_get(&job->ref_count);
+	drm_sched_job_arm(&job->base);
+	drm_sched_entity_push_job(&job->base);
+	dbc->pending_reqs += job->num_req;
+}
+
+void qaic_free_job(struct kref *ref)
+{
+	struct qaic_job *job = container_of(ref, struct qaic_job, ref_count);
+
+	dma_fence_put(&job->irq_fence->base);
+	drm_gem_object_put(&job->bo->base);
+	kfree(job);
+}
+
+void qaic_put_job(struct qaic_job *job)
+{
+	kref_put(&job->ref_count, qaic_free_job);
+}
+
+void qaic_cleanup_job(struct qaic_job *job)
+{
+	drm_sched_job_cleanup(&job->base);
+	qaic_put_job(job);
+}
diff --git a/include/uapi/drm/qaic_accel.h b/include/uapi/drm/qaic_accel.h
index c92d0309d583..5271bf66f5bd 100644
--- a/include/uapi/drm/qaic_accel.h
+++ b/include/uapi/drm/qaic_accel.h
@@ -346,7 +346,7 @@ struct qaic_perf_stats {
  * struct qaic_perf_stats_entry - Defines a BO perf info.
  * @handle: In. GEM handle of the BO to get perf stats for.
  * @queue_level_before: Out. Number of elements in the queue before this BO
- *			was submitted.
+ *			was submitted, including those not yet scheduled to HW.
  * @num_queue_element: Out. Number of elements added to the queue to submit
  *		       this BO.
  * @submit_latency_us: Out. Time taken by the driver to submit this BO.
-- 
2.43.0

