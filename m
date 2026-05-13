Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6B8F1CD4851
	for <dri-devel@archiver.kernel.org>; Wed, 13 May 2026 12:01:19 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id BB6B810E306;
	Wed, 13 May 2026 12:01:18 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="LzN7/buc";
	dkim-atps=neutral
Received: from mx08-00376f01.pphosted.com (mx08-00376f01.pphosted.com
 [91.207.212.86])
 by gabe.freedesktop.org (Postfix) with ESMTPS id AF34010E306
 for <dri-devel@lists.freedesktop.org>; Wed, 13 May 2026 12:01:16 +0000 (UTC)
Received: from pps.filterd (m0168888.ppops.net [127.0.0.1])
 by mx08-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 64DBW32J1061321; Wed, 13 May 2026 13:00:58 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=Hjq6r4eY1n8YGRSnmCIyCFR
 Js9KBbxRHJDuv05y3RyM=; b=LzN7/bucTJOUnpPqmvk/guJqv6bl0U9rr81vMV+
 A1U74aP6Kg4SAbllk8bRWLLP5pFv3Uzy15SWLFKZqkrrimA9NaqRVpQnX6LaeCOA
 ZUsWCI230bQH3jtM+9sZRV78jnk3nXfYaCUlqF2ryK3URlBg+zDIw8wH1ZmlO1tf
 8erPPVM8u+Iwnd2F/YGmzTd3EYwzxypPbMijTlqT1heLt1JUYvGAJW6RQTr/9VxJ
 DezLfOU6YUHvBt8m2VzOMKqQsPYs36tejDXOAHL8dlssoI8c1FB7qnjQHvy85fXa
 kDPtMdZTRym0lGnb3mSsNKM4JqxzPqJlYAZgNJjY/eBvvHQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx08-00376f01.pphosted.com (PPS) with ESMTPS id 4e1u6pk95k-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Wed, 13 May 2026 13:00:58 +0100 (BST)
Received: from [127.0.1.1] (172.25.10.37) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.37; Wed, 13 May
 2026 13:00:56 +0100
From: Alexandru Dadu <alexandru.dadu@imgtec.com>
Date: Wed, 13 May 2026 15:00:45 +0300
Subject: [PATCH] drm/imagination: Add support for trace points
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260513-b4-pvr-trace-points-v1-1-81222d1a4c99@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAOxnBGoC/x3MMQqAMAxA0auUzAaaqh28ijhojZqlllSKIN7d4
 viG/x/IrMIZBvOAcpEsZ6ygxkA45rgzyloNzjpve3K4dJiK4qVzYEynxCtjt7aL90SeqYdaJuV
 N7v86Tu/7AfqG6CRlAAAA
To: Frank Binns <frank.binns@imgtec.com>, Matt Coster <matt.coster@imgtec.com>,
 Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
 Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <linux-kernel@vger.kernel.org>, <dri-devel@lists.freedesktop.org>,
 "Alessio Belle" <alessio.belle@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Donald Robson <donald.robson@imgtec.com>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1778673656; l=8174;
 i=alexandru.dadu@imgtec.com; s=20260304; h=from:subject:message-id;
 bh=tqdbPtlGvvhK/qsd0y9a0NUA83nKK8w2syqoNZUxOVc=;
 b=7AB36py/W7euNfpFw0ofQrexP6GfZXIpSzosWDr5bljA9jGkCvgo+SmjCfcAGSjjxd/XIsX35
 mVJDR0mjN2jDnA7VHS8r/Yeyf51VNLupBSjVOybWFHh00yqRIuZLA4r
X-Developer-Key: i=alexandru.dadu@imgtec.com; a=ed25519;
 pk=FU07SyNrYGwhahqSxbWEuzyXlUh47xBXvLvOR7UA6+U=
X-Originating-IP: [172.25.10.37]
X-Proofpoint-GUID: lubozX-_gUh6Rm_3T9Ibo5WVee9-uVLy
X-Proofpoint-ORIG-GUID: lubozX-_gUh6Rm_3T9Ibo5WVee9-uVLy
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNTEzMDEyNSBTYWx0ZWRfX+LEo+3RethSa
 gV5/FvJvTeckPqGqY2rggIne7D0ZJ2SJv4U9V1LDXBcLasQooABFme9yvXevv4/aFNXlyuntl3t
 46Vt0GA6mNwQWHo7GYTGDUuOL59RlpVe3UD1v3NZ81S+CI52FyE5jWzXdnI6+vmPfwnQ3xNt/Zt
 mXcZbq4I7pyPRYV8xb4ZDeNPnMQlKIsjrMUa02ix/HGzqIzg34qmoMUNIVL4OH/g7gxPU3hXbJB
 KvKMu8wHwU/nfaHpiI28SJbqfY6MMdnW3u6sgivWcPpqzDW6OEY/sVQ1gF51SnJJS3Mp1KlSTvD
 mB10i+zxqlBsParVbIbHD+VYUVdZp5hVX8qQRPL9bZYPH7S2+F3fXaqs4cItRVMo6RafJ6zsSo0
 cG1QuIN2XhHDaVei6FfxQacqcSERI2hsF2naWAmMAhvIMeDs3z5xE3+iV1Np68aUfydxUJBw50D
 uLw4VBIXzYTH647+1Sg==
X-Authority-Analysis: v=2.4 cv=dIeWXuZb c=1 sm=1 tr=0 ts=6a0467fa cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=7IANbbwssFwA:10 a=IkcTkHD0fZMA:10 a=NGcC8JguVDcA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=qZQ2PDNLMSdLoqI-hfl9:22
 a=r_1tXGB3AAAA:8 a=2RyeVlAdm6kr-1W8CGsA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
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

Add support for workload submission trace points.

Co-developed-by: Donald Robson <donald.robson@imgtec.com>
Signed-off-by: Donald Robson <donald.robson@imgtec.com>
Signed-off-by: Alexandru Dadu <alexandru.dadu@imgtec.com>
---
 drivers/gpu/drm/imagination/Makefile           |   3 +
 drivers/gpu/drm/imagination/pvr_drv.c          |   3 +
 drivers/gpu/drm/imagination/pvr_job.c          |   3 +
 drivers/gpu/drm/imagination/pvr_queue.c        |   5 ++
 drivers/gpu/drm/imagination/pvr_trace.h        | 113 +++++++++++++++++++++++++
 drivers/gpu/drm/imagination/pvr_trace_points.c |   7 ++
 6 files changed, 134 insertions(+)

diff --git a/drivers/gpu/drm/imagination/Makefile b/drivers/gpu/drm/imagination/Makefile
index 1222a14262e4..a5c5e386f16a 100644
--- a/drivers/gpu/drm/imagination/Makefile
+++ b/drivers/gpu/drm/imagination/Makefile
@@ -32,6 +32,9 @@ powervr-y := \
 powervr-$(CONFIG_DEBUG_FS) += \
 	pvr_debugfs.o
 
+powervr-$(CONFIG_TRACEPOINTS) += \
+	pvr_trace_points.o
+
 obj-$(CONFIG_DRM_POWERVR) += powervr.o
 
 obj-$(CONFIG_DRM_POWERVR_KUNIT_TEST) += pvr_test.o
diff --git a/drivers/gpu/drm/imagination/pvr_drv.c b/drivers/gpu/drm/imagination/pvr_drv.c
index 268900464ab6..b20c462bcba0 100644
--- a/drivers/gpu/drm/imagination/pvr_drv.c
+++ b/drivers/gpu/drm/imagination/pvr_drv.c
@@ -14,6 +14,7 @@
 #include "pvr_rogue_defs.h"
 #include "pvr_rogue_fwif_client.h"
 #include "pvr_rogue_fwif_shared.h"
+#include "pvr_trace.h"
 #include "pvr_vm.h"
 
 #include <uapi/drm/pvr_drm.h>
@@ -1150,6 +1151,8 @@ pvr_ioctl_submit_jobs(struct drm_device *drm_dev, void *raw_args,
 	int idx;
 	int err;
 
+	trace_pvr_job_submit_ioctl(pvr_dev, args->jobs.count);
+
 	if (!drm_dev_enter(drm_dev, &idx))
 		return -EIO;
 
diff --git a/drivers/gpu/drm/imagination/pvr_job.c b/drivers/gpu/drm/imagination/pvr_job.c
index dd9f5df01e08..b8a58d817009 100644
--- a/drivers/gpu/drm/imagination/pvr_job.c
+++ b/drivers/gpu/drm/imagination/pvr_job.c
@@ -14,6 +14,7 @@
 #include "pvr_stream.h"
 #include "pvr_stream_defs.h"
 #include "pvr_sync.h"
+#include "pvr_trace.h"
 
 #include <drm/drm_exec.h>
 #include <drm/drm_gem.h>
@@ -510,6 +511,8 @@ static int pvr_job_data_init(struct pvr_device *pvr_dev,
 		}
 
 		job_data_out[i].sync_op_count = job_args[i].sync_ops.count;
+
+		trace_pvr_job_create(pvr_dev, job_data_out[i].job, job_data_out[i].sync_op_count);
 	}
 
 	return 0;
diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index d10a13173f0f..3c2331e834fb 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -10,6 +10,7 @@
 #include "pvr_drv.h"
 #include "pvr_job.h"
 #include "pvr_queue.h"
+#include "pvr_trace.h"
 #include "pvr_vm.h"
 
 #include "pvr_rogue_fwif_client.h"
@@ -725,6 +726,8 @@ static void pvr_queue_submit_job_to_cccb(struct pvr_job *job)
 		cmd->partial_render_geom_frag_fence.value = job->done_fence->seqno - 1;
 	}
 
+	trace_pvr_job_submit_fw(job);
+
 	/* Submit job to FW */
 	pvr_cccb_write_command_with_header(cccb, job->fw_ccb_cmd_type, job->cmd_len, job->cmd,
 					   job->id, job->id);
@@ -1193,6 +1196,8 @@ void pvr_queue_job_cleanup(struct pvr_job *job)
 
 	if (job->base.s_fence)
 		drm_sched_job_cleanup(&job->base);
+
+	trace_pvr_job_done(job);
 }
 
 /**
diff --git a/drivers/gpu/drm/imagination/pvr_trace.h b/drivers/gpu/drm/imagination/pvr_trace.h
new file mode 100644
index 000000000000..ffbbde3b2bcc
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_trace.h
@@ -0,0 +1,113 @@
+/* SPDX-License-Identifier: GPL-2.0 OR MIT */
+/* Copyright (c) 2026 Imagination Technologies Ltd. */
+
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM pvr
+
+#if !defined(PVR_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define PVR_TRACE_H
+
+#include "pvr_context.h"
+#include "pvr_device.h"
+#include "pvr_fw.h"
+#include "pvr_hwrt.h"
+#include "pvr_job.h"
+#include "pvr_sync.h"
+
+#include <linux/stringify.h>
+#include <linux/types.h>
+#include <linux/tracepoint.h>
+
+/*
+ * NOTE:
+ * When adding trace points, or extra data to existing ones - you must capture
+ * all the data in the TP_fast_assign section that you wish to use in the
+ * TP_printk section. This is because the printk is performed on demand from the
+ * captured data when you `cat /sys/kernel/tracing/trace` and by the time this
+ * happens any pointers you captured will likely no longer point to valid data.
+ */
+
+/* Job submit */
+
+TRACE_EVENT(pvr_job_submit_ioctl,
+	    TP_PROTO(struct pvr_device *pvr_dev, u32 count),
+	    TP_ARGS(pvr_dev, count),
+	    TP_STRUCT__entry(__field(struct pvr_device *, pvr_dev)
+			     __field(u32, count)),
+	    TP_fast_assign(__entry->pvr_dev = pvr_dev;
+			   __entry->count = count;),
+	    TP_printk("pvr_dev=%p count=%u",
+		      __entry->pvr_dev,
+		      __entry->count)
+);
+
+#define PVR_JOB_TYPE_TO_STR(val)                                         \
+	__print_symbolic(val,                                            \
+			 { DRM_PVR_JOB_TYPE_GEOMETRY, "geometry" },      \
+			 { DRM_PVR_JOB_TYPE_FRAGMENT, "fragment" },      \
+			 { DRM_PVR_JOB_TYPE_COMPUTE, "compute" },        \
+			 { DRM_PVR_JOB_TYPE_TRANSFER_FRAG, "transfer" })
+
+TRACE_EVENT(pvr_job_create,
+	    TP_PROTO(struct pvr_device *pvr_dev, struct pvr_job *job,
+		     u32 sync_op_count),
+	    TP_ARGS(pvr_dev, job, sync_op_count),
+	    TP_STRUCT__entry(__field(struct pvr_device *, pvr_dev)
+			     __field(struct pvr_context *, ctx)
+			     __field(struct pvr_fw_object *, fw_obj)
+			     __field(u32, fw_addr)
+			     __field(u32, hwrt_addr)
+			     __field(struct pvr_job *, job)
+			     __field(enum drm_pvr_job_type, job_type)
+			     __field(u32, sync_op_count)),
+	    TP_fast_assign(__entry->pvr_dev = pvr_dev;
+			   __entry->ctx = job->ctx;
+			   __entry->fw_obj = job->ctx->fw_obj;
+			   pvr_fw_object_get_fw_addr(job->ctx->fw_obj, &__entry->fw_addr);
+			   __entry->hwrt_addr = job->hwrt ?
+						job->hwrt->fw_obj->fw_addr_offset :
+						0;
+			   __entry->job = job;
+			   __entry->job_type = job->type;
+			   __entry->sync_op_count = sync_op_count;),
+	    TP_printk("pvr_dev=%p ctx=%p fw_obj=%p fw_addr=0x%x hwrt_addr=0x%x job=%p job_type=%s sync_op_count=%u",
+		      __entry->pvr_dev,
+		      __entry->ctx,
+		      __entry->fw_obj,
+		      __entry->fw_addr,
+		      __entry->hwrt_addr,
+		      __entry->job,
+		      PVR_JOB_TYPE_TO_STR(__entry->job_type),
+		      __entry->sync_op_count)
+);
+
+#undef PVR_JOB_TYPE_TO_STR
+
+TRACE_EVENT(pvr_job_submit_fw,
+	    TP_PROTO(struct pvr_job *job),
+	    TP_ARGS(job),
+	    TP_STRUCT__entry(__field(struct pvr_job *, job)
+			     __field(u32, done_seqno)),
+	    TP_fast_assign(__entry->job = job;
+			   __entry->done_seqno = job->done_fence->seqno;),
+	    TP_printk("job=%p done_seqno=%u",
+		      __entry->job,
+		      __entry->done_seqno)
+);
+
+TRACE_EVENT(pvr_job_done,
+	    TP_PROTO(struct pvr_job *job),
+	    TP_ARGS(job),
+	    TP_STRUCT__entry(__field(struct pvr_job *, job)),
+	    TP_fast_assign(__entry->job = job;),
+	    TP_printk("job=%p", __entry->job)
+);
+
+#endif /* PVR_TRACE_H */
+
+/* This part must be outside protection */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH ../../drivers/gpu/drm/imagination
+#define TRACE_INCLUDE_FILE pvr_trace
+#include <trace/define_trace.h>
diff --git a/drivers/gpu/drm/imagination/pvr_trace_points.c b/drivers/gpu/drm/imagination/pvr_trace_points.c
new file mode 100644
index 000000000000..71b53f267af0
--- /dev/null
+++ b/drivers/gpu/drm/imagination/pvr_trace_points.c
@@ -0,0 +1,7 @@
+// SPDX-License-Identifier: GPL-2.0 OR MIT
+/* Copyright (c) 2026 Imagination Technologies Ltd. */
+
+#ifndef __CHECKER__
+#define CREATE_TRACE_POINTS
+#include "pvr_trace.h"
+#endif

---
base-commit: 921578cf373981eba92774a27f7644a11282cf89
change-id: 20260512-b4-pvr-trace-points-4d3b66116e15

Best regards,
-- 
Alexandru Dadu <alexandru.dadu@imgtec.com>

