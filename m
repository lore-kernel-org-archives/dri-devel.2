Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07955C44515
	for <dri-devel@archiver.kernel.org>; Mon, 20 Jul 2026 15:08:05 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id 5057210E981;
	Mon, 20 Jul 2026 15:08:04 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="IhiUS3S6";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id 859F610E981
 for <dri-devel@lists.freedesktop.org>; Mon, 20 Jul 2026 15:08:02 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66KDqTsj2914173; Mon, 20 Jul 2026 16:07:52 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=vzqpkCpOUGBRuMhg8B/LjWE
 KGEloZQPTeKICH6ENZhs=; b=IhiUS3S654XWMuMXgQrcw1M2FmZpv1p+husUGlb
 4B7IWh/D0fr00hil6pM1lFh4NXgeFIDZzLobiiEg3B44Ls5rqYPiOKHLEUGyWyiy
 8qK3fSjpDMLBlRG3MjqTJ7pWt+kUqf1ckDUbPUzFhg6OzwYStKhxFGXS3B3xccYC
 0agY8f+25u44+6Sm1h7gHn5+gioMuoFMOpR1GKssuymuTWgvI5lyAcdQxSzvC9NU
 66GcpJ0nSgIj3lSDXAZOsGU+FW5npXwxD/TH72h5DGUJS6HeDKv4K4UPukiGiTmH
 vq5qZhwuAuRRvE+xV+8AukyzJb6Fw6xAiNKB6hIwJxAGjNQ==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fg1ju9v46-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Mon, 20 Jul 2026 16:07:52 +0100 (BST)
Received: from NP-A-BELLE.kl.imgtec.org (172.25.4.9) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Mon, 20 Jul
 2026 16:07:51 +0100
From: Alessio Belle <alessio.belle@imgtec.com>
Date: Mon, 20 Jul 2026 16:07:28 +0100
Subject: [PATCH] drm/imagination: Fix value of HWRT address in
 pvr_job_create tracepoint
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260720-fix-pvr-job-trace-hwrt-v1-1-b24551802efb@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAK85XmoC/x2MSQqAMAwAvyI5G2jril8RD1qjxkNbUlFB/LvF4
 8DMPBBJmCJ02QNCJ0f2LoHOM7Db6FZCnhODUaZWjVG48I3hFNz9hIeMlnC75MDCLFVpFVndVpD
 iIJTMf9wP7/sBYpDIqmgAAAA=
X-Change-ID: 20260720-fix-pvr-job-trace-hwrt-32f54c0ec185
To: Luigi Santivetti <luigi.santivetti@imgtec.com>, Brajesh Gupta
 <brajesh.gupta@imgtec.com>, Frank Binns <frank.binns@imgtec.com>,
 "Alexandru Dadu" <alexandru.dadu@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>
CC: <dri-devel@lists.freedesktop.org>, <linux-kernel@vger.kernel.org>,
 "Alessio Belle" <alessio.belle@imgtec.com>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=2606;
 i=alessio.belle@imgtec.com; s=20260628; h=from:subject:message-id;
 bh=4irHSa+ufzET4GT3muhV/dmV9x7WxdBYM/2KJoqpJ5E=;
 b=owGbwMvMwCUm4nVW5aiD4lnG02pJDFlxlsdrp37IXr5Kbvnlrc82rNHn+LVR1uDjhQ0Pc86/7
 ma6NHvipI5SFgYxLgZZMUWWD/s2/rfV+1ArxbD9IswcViaQIQxcnAIwkQIVhn8K6uWh5Tcq7qlu
 fbpfYea5i3pMe84+19F7f9FvU7JiY10ow19JO+0leUnX9jyr+ffl3n+v/DfT81pmV596stA3+MD
 WFexMAA==
X-Developer-Key: i=alessio.belle@imgtec.com; a=openpgp;
 fpr=F0BEB1FF3D2EF07D1A00B7D1144ACD24C54021CD
X-Originating-IP: [172.25.4.9]
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzIwMDE2NyBTYWx0ZWRfX+ifMnFKZP26t
 r6OOdpjGiEpHxtkqZxY6lPuPrQLIFxW0lRw42YZJVoaofxYaPP68Z+ngSNWtDhvsTkGIWV1tUbi
 0fNfZNvapp6Cb7ZLbmy5OCCL+s3kBNs=
X-Authority-Analysis: v=2.4 cv=Ta2mcxQh c=1 sm=1 tr=0 ts=6a5e39c8 cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=rvaOABGgyOwA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=r_1tXGB3AAAA:8 a=bGpNHNAHFwgwU_sQmyUA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: 9gwEFGdTwN1WWPm1_7DUgKVv-Ax26w87
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzIwMDE2NyBTYWx0ZWRfX+rJOnTeweNLb
 4+Vh3OAuG97m6+eKz/BzqpVwwgUWvNf78jfdP7XP3OCiG5EtaucMSZjrpaUDvl+bBT3fynoCM2F
 gUQ/CXaaHhb42h5OvQaqvjtGPFgtpfzQUr+skMAAYyBoTV6zLjMKN2YER0Rz/RBagqyvcoMUDls
 3I0iuCydZYuuhhUiXCOHtacIvn7qfHGUpBPl27Mw/odzWj4DNcrNdNSI8ISXh1HVZMBAMFwNdVA
 +qRNEuykeXl4RKEf7GWPT+Kd1fQ+MFDFa3nAgUFGcWfUSQl5S/edDUgJDnnoUFpiqnX5q+bS7FD
 WGrmtDpApJaHnXV7nEO29uBZ7PFVYpcxZOvSQglGgPMSh75tjXAezCVRucDtcPFSD/OKg7wEFfD
 msAzc3nYuxEYYFTdpyWA60HRfkx03qvqn++R3pSYpdB31dljOXVtx148ssFmV3oUp5J9gmSG8rq
 6KDBHm/TGqhXvQQhBvQ==
X-Proofpoint-ORIG-GUID: 9gwEFGdTwN1WWPm1_7DUgKVv-Ax26w87
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

The pvr_job_create tracepoint was using pvr_fw_object::fw_addr_offset
to display the firmware address of the render target structure attached
to a job, but that's an offset into the firmware heap, not the expected
full address, which is more useful in general e.g. for cross referencing
against firmware logs.

Use pvr_fw_object_get_fw_addr() to get the full firmware address.

Fixes: c1079aebb4de ("drm/imagination: Add support for trace points")
Signed-off-by: Alessio Belle <alessio.belle@imgtec.com>
---
 drivers/gpu/drm/imagination/pvr_trace.h | 16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_trace.h b/drivers/gpu/drm/imagination/pvr_trace.h
index ffbbde3b2bcc..943d6b2418cb 100644
--- a/drivers/gpu/drm/imagination/pvr_trace.h
+++ b/drivers/gpu/drm/imagination/pvr_trace.h
@@ -41,6 +41,17 @@ TRACE_EVENT(pvr_job_submit_ioctl,
 		      __entry->count)
 );
 
+#define PVR_JOB_GET_HWRT_FW_ADDR(job)                                                  \
+	({                                                                             \
+		struct pvr_job *_job = (job);                                          \
+		u32 _hwrt_fw_addr = 0;                                                 \
+										       \
+		if (_job && _job->hwrt)                                                \
+			pvr_fw_object_get_fw_addr(_job->hwrt->fw_obj, &_hwrt_fw_addr); \
+										       \
+		_hwrt_fw_addr;                                                         \
+	})
+
 #define PVR_JOB_TYPE_TO_STR(val)                                         \
 	__print_symbolic(val,                                            \
 			 { DRM_PVR_JOB_TYPE_GEOMETRY, "geometry" },      \
@@ -64,9 +75,7 @@ TRACE_EVENT(pvr_job_create,
 			   __entry->ctx = job->ctx;
 			   __entry->fw_obj = job->ctx->fw_obj;
 			   pvr_fw_object_get_fw_addr(job->ctx->fw_obj, &__entry->fw_addr);
-			   __entry->hwrt_addr = job->hwrt ?
-						job->hwrt->fw_obj->fw_addr_offset :
-						0;
+			   __entry->hwrt_addr = PVR_JOB_GET_HWRT_FW_ADDR(job);
 			   __entry->job = job;
 			   __entry->job_type = job->type;
 			   __entry->sync_op_count = sync_op_count;),
@@ -82,6 +91,7 @@ TRACE_EVENT(pvr_job_create,
 );
 
 #undef PVR_JOB_TYPE_TO_STR
+#undef PVR_JOB_GET_HWRT_FW_ADDR
 
 TRACE_EVENT(pvr_job_submit_fw,
 	    TP_PROTO(struct pvr_job *job),

---
base-commit: 17e2030f37600994440f875dc410615d5c66ee6d
change-id: 20260720-fix-pvr-job-trace-hwrt-32f54c0ec185

Best regards,
-- 
Alessio Belle <alessio.belle@imgtec.com>

