Return-Path: <dri-devel-bounces@lists.freedesktop.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from gabe.freedesktop.org (gabe.freedesktop.org [131.252.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F3A69C4453D
	for <dri-devel@archiver.kernel.org>; Fri, 24 Jul 2026 04:42:04 +0000 (UTC)
Received: from gabe.freedesktop.org (localhost [127.0.0.1])
	by gabe.freedesktop.org (Postfix) with ESMTP id C206F10E187;
	Fri, 24 Jul 2026 04:42:03 +0000 (UTC)
Authentication-Results: gabe.freedesktop.org;
	dkim=pass (2048-bit key; unprotected) header.d=imgtec.com header.i=@imgtec.com header.b="WxSbig1m";
	dkim-atps=neutral
Received: from mx07-00376f01.pphosted.com (mx07-00376f01.pphosted.com
 [185.132.180.163])
 by gabe.freedesktop.org (Postfix) with ESMTPS id D629110E187;
 Fri, 24 Jul 2026 04:42:02 +0000 (UTC)
Received: from pps.filterd (m0168889.ppops.net [127.0.0.1])
 by mx07-00376f01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id
 66O4fkrq3899191; Fri, 24 Jul 2026 05:41:46 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=imgtec.com; h=cc
 :content-transfer-encoding:content-type:date:from:message-id
 :mime-version:subject:to; s=dk201812; bh=YQPvpA1K95rM0c8UZsZpICC
 FZi3RhIjCVGYa23Hd5ns=; b=WxSbig1mRLGYyA9Yhzs7XUZ0GRNS4HLYe+XQ7eF
 /YYhq9VoLpEITkUn+cEQyzWQtP3zkDWg/uvXzOYICLPQT4yAnzQJZC+S/I2Neyij
 tNypjjThQEs3nk5e1npl//khx+CJBdY+Xa916sJjuKPuoT2iMRnn+cjeWHw5hWDa
 HsgG6pcy9nzhN3bABPfUoc3hfS6qmA6MbpCxZ3ZJVKF0r5X28/Ei77C4RU1YJOVV
 UfBQLt4TxPtgtoT/8F39QHdD8uFwavIa8XCdZfCE4rRrrV1UjJRIWE10+lzpxsZt
 6EOfBE8hVIdBDkTkZ4WP5LstRdTkHIURM5k/iKTtfyibxqg==
Received: from hhmail01.hh.imgtec.org
 (83-244-153-141.cust-83.exponential-e.net [83.244.153.141])
 by mx07-00376f01.pphosted.com (PPS) with ESMTPS id 4fhq52bd3x-1
 (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
 Fri, 24 Jul 2026 05:41:46 +0100 (BST)
Received: from [127.0.1.1] (172.25.128.225) by HHMAIL01.hh.imgtec.org
 (10.100.10.19) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.2562.43; Fri, 24 Jul
 2026 05:41:41 +0100
From: Brajesh Gupta <brajesh.gupta@imgtec.com>
Date: Fri, 24 Jul 2026 10:11:30 +0530
Subject: [PATCH v2] drm/imagination: Update the trace point pvr_job_submit_fw()
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20260724-b4-tracepoint-fix-v2-1-e6a81a348394@imgtec.com>
X-B4-Tracking: v=1; b=H4sIAPnsYmoC/32NQQ6DIBBFr2Jm3WmAqsSueo/GBYVBZyEYIKaN8
 e6lHqDL95L//g6ZElOGe7NDoo0zx1BBXRqwswkTIbvKoITqhVYKXy2WZCytkUNBz28U3g69dFq
 om4O6WxNVfTafY+WZc4npc15s8mf/1TaJEr3udKu96QZpHrxMhezVxgXG4zi+exOlxbMAAAA=
To: Alessio Belle <alessio.belle@imgtec.com>, Luigi Santivetti
 <luigi.santivetti@imgtec.com>, Maarten Lankhorst
 <maarten.lankhorst@linux.intel.com>, Maxime Ripard <mripard@kernel.org>,
 Thomas Zimmermann <tzimmermann@suse.de>,
 David Airlie <airlied@gmail.com>, Simona Vetter <simona@ffwll.ch>,
 Matt Coster <opensource@mtcoster.net>,
 Alexandru Dadu <alexandru.dadu@imgtec.com>, Frank Binns
 <frank.binns@imgtec.com>
CC: <imagination@lists.freedesktop.org>, <dri-devel@lists.freedesktop.org>,
 <linux-kernel@vger.kernel.org>, Brajesh Gupta <brajesh.gupta@imgtec.com>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=ed25519-sha256; t=1784868101; l=2280;
 i=brajesh.gupta@imgtec.com; s=20260417; h=from:subject:message-id;
 bh=IXFv6GGzbsQ830d4LD6IpRXpu4n/OzSr78hAribUZII=;
 b=nrDL4quCIlodisiOC6UfDG2GZYeh1MThgCJ+PnJAmoG5hvKdRcen+4zKUFtlyiOB+zc70bf+B
 8/7P9X36BQbDZpWuMHUPzjxRHv6c0YHeRqQCazgVndsrM4+2Gb8kZWF
X-Developer-Key: i=brajesh.gupta@imgtec.com; a=ed25519;
 pk=vDcrSP6vOpWKs914T986xUbB/vY0/cU7mRRb16MRkcg=
X-Originating-IP: [172.25.128.225]
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzI0MDA0MCBTYWx0ZWRfXxvMUkqh7yuAw
 MU3NavfsOowAQ77zle0ac3zgx9f7V4ZJ8BzmD1XmQZdq7W87/SK9aUS4B7ClIlnUQ66uGlf6mHB
 OKp5oxF8BcOm+29Uvw0wJitqpyFI4xHre6s7jHUlMTs49uAhakEU7/qpDAHNE/0DYgyBLtRfIvo
 9BVUp+7hLzI22HD8a9i/ofL8m0FZiAI1ELmjd/gdzKF5eIovlS+xWK1VXTyRjvsVrtXJ33wqM+V
 Op2uD0l8Ji5MwmZmoZwVvPgCaMKEo2Tp0XOE1xP9rMhpILyXIGU+0otAh3SpWZOeisRjaAyKBeP
 4Z3LT/74JF0XRFo2H0I1rY5vcGTPUvXdLocOMmEGtI4hkqLJFuCloZqSblnoeVfFHswQRKaGZRq
 aze6mKC/4hvlhtbrLK2DqyCZFclEjpf3aERgdLDCeN4VSCOCIaHmnI2jBwnB7YiLWTcBlGDr1V8
 ZdE3uoJRMQ3MgwdRouA==
X-Authority-Analysis: v=2.4 cv=B5+JFutM c=1 sm=1 tr=0 ts=6a62ed0a cx=c_pps
 a=AKOq//PuzOIrVTIF9yBwbA==:117 a=AKOq//PuzOIrVTIF9yBwbA==:17
 a=HYrZrZQ_E1YA:10 a=IkcTkHD0fZMA:10 a=RAioF0-LDSMA:10
 a=VkNPw1HP01LnGYTKEx00:22 a=kQ-hrUj2-E3RCbRHssb7:22 a=7RYWX5rxfSByPNLylY2M:22
 a=VwQbUJbxAAAA:8 a=r_1tXGB3AAAA:8 a=yWxx2l9es2RvQy5cUQQA:9 a=QEXdDO2ut3YA:10
 a=t8nPyN_e6usw4ciXM-Pk:22
X-Proofpoint-GUID: O4ZoxqGEBKuziCU9qdfz94ykN9gKCmIK
X-Proofpoint-ORIG-GUID: O4ZoxqGEBKuziCU9qdfz94ykN9gKCmIK
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzI0MDA0MCBTYWx0ZWRfX97PcyVYQaZ9a
 jDAVhtWuer5nhHgA1wmHugipf8QCRTt4ZiHdai7sCZ+WvRAiUn5BA9R5CTS8ji3vpR80Q+kLgd1
 aE4bTByuYX/f7pFDIqyPb75uTzq+w1Y=
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

Trace point pvr_job_submit_fw() is used to trace job submission to
the FW. Currently it is recorded when a command is written to the Client
circular buffer.

Move trace recording after writing command to the Kernel circular buffer to
better represent command submission to the FW.

Fixes: c1079aebb4de ("drm/imagination: Add support for trace points")
Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>

Signed-off-by: Brajesh Gupta <brajesh.gupta@imgtec.com>
---
Changes in v2:
- Updated safer trace point recording for fragment job to handle
Sashiko-bot reported possible use-after-free case.
- Due to depenedency between grometry and fragment jobs, fragment job
will not be scheduled till geometry is scheduled so even V1 solution is safe.
- Link to v1: https://lore.kernel.org/r/20260722-b4-tracepoint-fix-v1-1-f75747fa591a@imgtec.com
---
 drivers/gpu/drm/imagination/pvr_queue.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/imagination/pvr_queue.c b/drivers/gpu/drm/imagination/pvr_queue.c
index 941c017399fc..fd968d7def66 100644
--- a/drivers/gpu/drm/imagination/pvr_queue.c
+++ b/drivers/gpu/drm/imagination/pvr_queue.c
@@ -726,8 +726,6 @@ static void pvr_queue_submit_job_to_cccb(struct pvr_job *job)
 		cmd->partial_render_geom_frag_fence.value = job->done_fence->seqno - 1;
 	}
 
-	trace_pvr_job_submit_fw(job);
-
 	/* Submit job to FW */
 	pvr_cccb_write_command_with_header(cccb, job->fw_ccb_cmd_type, job->cmd_len, job->cmd,
 					   job->id, job->id);
@@ -758,6 +756,7 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 	 */
 	if (job->paired_job && job->type == DRM_PVR_JOB_TYPE_FRAGMENT &&
 	    job->done_fence->ops) {
+		trace_pvr_job_submit_fw(job);
 		return dma_fence_get(job->done_fence);
 	}
 
@@ -810,6 +809,7 @@ static struct dma_fence *pvr_queue_run_job(struct drm_sched_job *sched_job)
 					pvr_context_get_fw_addr(job->ctx) + queue->ctx_offset,
 					job->hwrt);
 	}
+	trace_pvr_job_submit_fw(job);
 
 	return dma_fence_get(job->done_fence);
 }

---
base-commit: e5320be8a585a9286f231305d0d443d59c24e46c
change-id: 20260722-b4-tracepoint-fix-0fc961d7023d

Best regards,
-- 
Brajesh Gupta <brajesh.gupta@imgtec.com>

